import 'dart:async';

import 'package:async/async.dart';
import 'package:badges/badges.dart' as badges;
import 'package:chopper/chopper.dart' show Response;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sharing_intent/model/sharing_file.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/layout.dart';
import 'package:waterflyiii/notificationlistener.dart';
import 'package:waterflyiii/pages/transaction/attachments.dart';
import 'package:waterflyiii/pages/transaction/delete.dart';
import 'package:waterflyiii/pages/transaction/tags.dart';
import 'package:waterflyiii/settings.dart';
import 'package:waterflyiii/timezonehandler.dart';
import 'package:waterflyiii/widgets/autocompletetext.dart';
import 'package:waterflyiii/widgets/input_number.dart';
import 'package:waterflyiii/widgets/materialiconbutton.dart';

final Logger log = Logger("Pages.Transaction");

bool _savingInProgress = false;

class TransactionState extends ChangeNotifier {
  TransactionTypeProperty type = .swaggerGeneratedUnknown;
  final TextEditingController groupTitleTC = TextEditingController();
  final FocusNode groupTitleFN = FocusNode();
  String? ownAccountID;
  late tz.TZDateTime _date;
  final TextEditingController dateTC = TextEditingController();
  final TextEditingController timeTC = TextEditingController();
  CurrencyRead localCurrency;
  bool reconciled = false;
  bool initiallyReconciled = false;
  final List<TransactionSplitState> splits = <TransactionSplitState>[];
  List<AttachmentRead>? _attachments = <AttachmentRead>[];
  AccountTypeProperty sourceAccountType = .swaggerGeneratedUnknown;
  AccountTypeProperty destinationAccountType = .swaggerGeneratedUnknown;

  bool get split => splits.length > 1;
  double get totalAmount => splits.fold(
    0,
    (double sum, TransactionSplitState s) => sum + s.localAmount,
  );

  tz.TZDateTime get date => _date;
  set date(tz.TZDateTime date) {
    log.finest(() => "[TS] set date");
    _date = date;
    dateTC.text = DateFormat.yMMMd().format(_date);
    timeTC.text = DateFormat.Hm().format(_date);
    //notifyListeners();
  }

  List<AttachmentRead>? get attachments => _attachments;
  bool get hasAttachments => attachments?.isNotEmpty ?? false;
  set attachments(List<AttachmentRead>? attachments) {
    log.finest(() => "[TS] set attachments");
    _attachments = attachments;
    notifyListeners();
  }

  bool get hasCommonSourceAccount {
    if (!split) {
      return true;
    }
    return splits.every(
      (TransactionSplitState s) =>
          s.sourceAccountTC.text == splits.first.sourceAccountTC.text,
    );
  }

  bool get showSplitSourceAccounts =>
      type == .deposit && !hasCommonSourceAccount;

  bool get hasCommonDestinationAccount {
    if (!split) {
      return true;
    }
    return splits.every(
      (TransactionSplitState s) =>
          s.destinationAccountTC.text == splits.first.destinationAccountTC.text,
    );
  }

  bool get showSplitDestinationAccount =>
      type == .withdrawal && !hasCommonDestinationAccount;

  TransactionState(this.localCurrency);

  void splitAdd() {
    log.fine(() => "[TS] splitAdd()");
    splits.add(TransactionSplitState(this));

    // As firefly doesn't allow editing accounts or sums when reconciled,
    // deactivate reconciled.
    reconciled = false;

    notifyListeners();
  }

  bool splitRemove(int i) {
    log.fine(() => "[TS] splitRemove($i)");
    if (splits.length == 1) {
      log.severe(("trying to remove last split!"));
      return false;
    }
    splits[i].dispose();
    splits.removeAt(i);

    // As firefly doesn't allow editing accounts or sums when reconciled,
    // deactivate reconciled.
    reconciled = false;

    notifyListeners();
    return true;
  }

  void setSourceAccount(String s) {
    log.finest(() => "[TS] setSourceAccount($s)");

    for (final TransactionSplitState split in splits) {
      split.sourceAccountTC.text = s;
    }
    if (sourceAccountType.isAsset) {
      ownAccountID = null;
    }
    sourceAccountType = .swaggerGeneratedUnknown;

    _checkTXType();
  }

  void selectSourceAccount(AutocompleteAccount option) {
    log.finest(() => "[TS] selectSourceAccount(${option.name})");

    for (final TransactionSplitState split in splits) {
      split.sourceAccountTC.text = option.name;
    }
    sourceAccountType = AccountTypeProperty.values.firstWhere(
      (AccountTypeProperty e) => e.value == option.type,
      orElse: () => .swaggerGeneratedUnknown,
    );
    log.finer(
      () =>
          "selected source account ${option.name}, type ${sourceAccountType.toString()} (${option.type})",
    );
    if (sourceAccountType.isAsset) {
      ownAccountID = option.id;
    }

    _checkTXType();
  }

  void setDestinationAccount(String s) {
    log.finest(() => "[TS] setDestinationAccount($s)");

    for (final TransactionSplitState split in splits) {
      split.destinationAccountTC.text = s;
    }
    if (destinationAccountType.isAsset) {
      ownAccountID = null;
    }
    destinationAccountType = .swaggerGeneratedUnknown;

    _checkTXType();
  }

  void selectDestinationAccount(AutocompleteAccount option) {
    log.finest(() => "[TS] selectDestinationAccount(${option.name})");

    for (final TransactionSplitState split in splits) {
      split.destinationAccountTC.text = option.name;
    }
    destinationAccountType = AccountTypeProperty.values.firstWhere(
      (AccountTypeProperty e) => e.value == option.type,
      orElse: () => .swaggerGeneratedUnknown,
    );
    log.finer(
      () =>
          "selected destination account ${option.name}, type ${destinationAccountType.toString()} (${option.type})",
    );
    if (destinationAccountType.isAsset) {
      ownAccountID = option.id;
    }

    _checkTXType();
  }

  TransactionTypeProperty computeTransactionType() {
    log.finest(() => "[TS] computeTransactionType()");

    TransactionTypeProperty txType = accountsToTransaction(
      sourceAccountType,
      destinationAccountType,
    );

    /* WATERFLY CUSTOM - NOT FIREFLY BEHAVIOR!
     * To ease UX, two assumptions:
     * 1. If only source is entered & it's an asset account, it'll be a
     *    withdrawal
     * 2. If only destination is entered & it's an asset account, it'll be a
     *    deposit
     *
     * As _ownAccountId will be set for both of these scenarios, the other one
     * would potentially be created by FF3 when saving. The actual webinterface
     * only does this when saving (but also throws an error when no ownAccount
     * is explicitly selected from the dropdown! Just typing the name [just as
     * in this app] will throw an error!).
     */
    if (txType == .swaggerGeneratedUnknown &&
        sourceAccountType == .assetAccount &&
        destinationAccountType == .swaggerGeneratedUnknown) {
      txType = .withdrawal;
    } else if (txType == .swaggerGeneratedUnknown &&
        sourceAccountType == .swaggerGeneratedUnknown &&
        destinationAccountType == .assetAccount) {
      txType = .deposit;
    }

    return txType;
  }

  void _checkTXType() {
    log.finest(() => "[TS] checkTXType()");

    final TransactionTypeProperty newType = computeTransactionType();

    if (type != newType) {
      type = newType;
      log.finest(() => "[TS] checkTXType(): notify due to new $type");
      notifyListeners();
    }
  }

  @override
  void dispose() {
    log.fine(() => "[TS] dispose");

    for (final TransactionSplitState s in splits) {
      s.dispose();
    }
    groupTitleTC.dispose();
    groupTitleFN.dispose();
    dateTC.dispose();
    timeTC.dispose();

    super.dispose();
  }

  static TransactionState fromExisting(
    TransactionRead transaction,
    TimeZoneHandler tzHandler,
  ) {
    final List<TransactionSplit> transactions =
        transaction.attributes.transactions;

    // Common values
    final TransactionState tx = TransactionState(
      CurrencyRead(
        type: "currencies",
        id: transactions.first.currencyId!,
        attributes: CurrencyProperties(
          code: transactions.first.currencyCode!,
          name: transactions.first.currencyName!,
          symbol: transactions.first.currencySymbol!,
          decimalPlaces: transactions.first.currencyDecimalPlaces,
        ),
      ),
    );
    tx.type = transactions.first.type;

    /// title
    if (transaction.attributes.groupTitle?.isNotEmpty ?? false) {
      tx.groupTitleTC.text = transaction.attributes.groupTitle!;
    }

    /// own account
    switch (tx.type) {
      case .withdrawal:
      case .transfer:
        tx.ownAccountID = transactions.first.sourceId;
        break;
      case .deposit:
      case .openingBalance:
      case .reconciliation:
        tx.ownAccountID = transactions.first.destinationId;
        break;
      default:
    }

    /// date
    tx.date = tzHandler.sTime(transactions.first.date).toLocal();

    // Reconciled
    tx.reconciled = transactions.first.reconciled ?? false;
    if (tx.reconciled) {
      tx.initiallyReconciled = true;
    }

    bool hasAttachments = false;

    for (TransactionSplit trans in transactions) {
      final TransactionSplitState newSplit = TransactionSplitState(tx);

      // Always in card view
      /// Category
      newSplit.categoryTC.text = trans.categoryName ?? "";

      //// Budget
      newSplit.budgetTC.text = trans.budgetName ?? "";

      /// Tags
      newSplit.tags = Tags(trans.tags ?? <String>[]);

      /// Notes
      newSplit.noteTC.text = trans.notes ?? "";

      /// Bill
      if ((trans.billId?.isNotEmpty ?? false) && trans.billId != "0") {
        newSplit.bill = BillRead(
          type: "bill",
          id: trans.billId ?? "",
          attributes: BillProperties(
            name: trans.billName ?? "",
            amountMin: "",
            amountMax: "",
            date: DateTime.now(),
            repeatFreq: .swaggerGeneratedUnknown,
          ),
        );
      }

      // Individual for split transactions
      /// Title
      newSplit.titleTC.text = trans.description;

      /// local amount
      newSplit.localAmount = double.tryParse(trans.amount) ?? 0.0;
      newSplit.localAmountUpdateText();

      /// source account
      newSplit.sourceAccountTC.text = trans.sourceName ?? "";
      tx.sourceAccountType = trans.sourceType!;

      /// target account
      newSplit.destinationAccountTC.text = trans.destinationName ?? "";
      tx.destinationAccountType = trans.destinationType!;

      /// foreign currency
      //// foreign currency
      if (trans.foreignCurrencyCode?.isNotEmpty ?? false) {
        newSplit.foreignCurrency = CurrencyRead(
          type: "currencies",
          id: trans.foreignCurrencyId!,
          attributes: CurrencyProperties(
            code: trans.foreignCurrencyCode!,
            name: "", // empty
            symbol: trans.foreignCurrencySymbol!,
            decimalPlaces: trans.foreignCurrencyDecimalPlaces,
          ),
        );
      }
      //// foreign amount
      newSplit.foreignAmount = double.tryParse(trans.foreignAmount ?? '') ?? 0;
      if (newSplit.foreignAmount != 0) {
        newSplit.foreignAmountUpdateText();
      }

      /// Journal ID
      newSplit.journalID = trans.transactionJournalId;

      /// attachments
      hasAttachments = hasAttachments || (trans.hasAttachments ?? false);

      tx.splits.add(newSplit);
    }

    if (hasAttachments) {
      // If any split had an attachment, there are some. Set to "null" to
      // trigger a separate API call to fetch the list!
      tx.attachments = null;
    }

    return tx;
  }
}

class TransactionSplitState {
  final TransactionState parent;

  // Always in card view
  final TextEditingController categoryTC = TextEditingController();
  final FocusNode categoryFN = FocusNode();
  final TextEditingController budgetTC = TextEditingController();
  final FocusNode budgetFN = FocusNode();
  Tags tags = Tags();
  final TextEditingController tagsTC = TextEditingController();
  final TextEditingController noteTC = TextEditingController();
  BillRead? bill;
  PiggyBankRead? piggy;

  // Individual for split transactions
  final TextEditingController titleTC = TextEditingController();
  final FocusNode titleFN = FocusNode();
  final TextEditingController sourceAccountTC = TextEditingController();
  final FocusNode sourceAccountFN = FocusNode();
  final TextEditingController destinationAccountTC = TextEditingController();
  final FocusNode destinationAccountFN = FocusNode();
  double _localAmount = 0.0;
  final TextEditingController localAmountTC = TextEditingController();
  final FocusNode localAmountFN = FocusNode();
  double _foreignAmount = 0.0;
  final TextEditingController foreignAmountTC = TextEditingController();
  final FocusNode foreignAmountFN = FocusNode();
  CurrencyRead? foreignCurrency;
  String? journalID;

  CurrencyRead get localCurrency => parent.localCurrency;

  double get localAmount => _localAmount;

  set localAmount(double amount) {
    log.fine(() => "[TSS] set localAmount($amount)");
    _localAmount = amount;
    // To update the global amount for splits
    parent.notifyListeners();
  }

  double get foreignAmount => _foreignAmount;
  set foreignAmount(double amount) {
    log.fine(() => "[TSS] set foreignAmount($amount)");
    _foreignAmount = amount;
  }

  TransactionSplitState(this.parent);

  void localAmountUpdateText() {
    localAmountTC.text = _localAmount.toStringAsFixed(
      localCurrency.attributes.decimalPlaces ?? 2,
    );
  }

  void foreignAmountUpdateText() {
    foreignAmountTC.text = _foreignAmount.toStringAsFixed(
      foreignCurrency?.attributes.decimalPlaces ?? 2,
    );
  }

  void dispose() {
    log.fine(() => "[TSS] dispose()");

    categoryTC.dispose();
    categoryFN.dispose();
    budgetTC.dispose();
    budgetFN.dispose();
    tagsTC.dispose();
    noteTC.dispose();
    titleTC.dispose();
    titleFN.dispose();
    sourceAccountTC.dispose();
    sourceAccountFN.dispose();
    destinationAccountTC.dispose();
    destinationAccountFN.dispose();
    localAmountTC.dispose();
    localAmountFN.dispose();
    foreignAmountTC.dispose();
    foreignAmountFN.dispose();
  }
}

class TransactionPage extends StatefulWidget {
  const TransactionPage({
    super.key,
    this.transaction,
    this.notification,
    this.files,
    this.clone = false,
    this.accountId,
  });

  final TransactionRead? transaction;
  final NotificationTransaction? notification;
  final List<SharedFile>? files;
  final bool clone;
  final String? accountId;

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage>
    with TickerProviderStateMixin {
  final Logger log = Logger("Pages.Transaction.Page");

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TransactionState _tx;
  final List<String> _deletedSplitIDs = <String>[];

  bool _txTypeChipExtended = false;
  late TransactionTypeProperty _lastTXType;
  late bool _newTX;
  late TimeZoneHandler _tzHandler;

  // Common fields
  final TextEditingController _totalAmountTC = TextEditingController();
  final FocusNode _totalAmountFN = FocusNode();
  final TextEditingController _commonSourceTC = TextEditingController();
  final FocusNode _commonSourceFN = FocusNode();
  final TextEditingController _commonDestinationTC = TextEditingController();
  final FocusNode _commonDestinationFN = FocusNode();

  // Magic moving!
  // https://m3.material.io/styles/motion/easing-and-duration/applying-easing-and-duration
  final List<AnimationController> _cardsAnimationController =
      <AnimationController>[];
  final List<Animation<double>> _cardsAnimation = <Animation<double>>[];

  @override
  void initState() {
    super.initState();

    _newTX = widget.transaction == null || widget.clone;
    _tzHandler = context.read<FireflyService>().tzHandler;

    // opening an existing transaction, extract information
    if (widget.transaction != null) {
      _tx = .fromExisting(widget.transaction!, _tzHandler);
      // Card Animations
      for (int i = 0; i < _tx.splits.length; i++) {
        _cardsAnimationController.add(
          AnimationController(
            // height 1 = visible - enter = fwd (0->1), exit = reverse (1->0)
            value: 1.0,
            duration: animDurationEmphasizedDecelerate,
            reverseDuration: animDurationEmphasizedDecelerate,
            vsync: this,
          ),
        );
        final int i = _cardsAnimationController.length - 1;
        _cardsAnimationController.last.addStatusListener(
          (AnimationStatus status) => deleteCardAnimated(i)(status),
        );
        _cardsAnimation.add(
          CurvedAnimation(
            parent: _cardsAnimationController.last,
            curve: animCurveEmphasizedDecelerate,
            reverseCurve: animCurveEmphasizedAccelerate,
          ),
        );
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_tx.attachments == null) {
          updateAttachmentCount();
        }
        updateTransactionAmounts();
      });
    } else {
      // New transaction
      _tx = TransactionState(context.read<FireflyService>().defaultCurrency);
      splitTransactionAdd();
      _tx.groupTitleFN.requestFocus();

      if (widget.notification != null) {
        _tx.date = _tzHandler
            .notificationTXTime(widget.notification!.date)
            .toLocal();
      } else {
        _tx.date = _tzHandler.newTXTime().toLocal();
      }

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        // Extract notification
        if (widget.notification != null) {
          final FireflyIii api = context.read<FireflyService>().api;
          final SettingsProvider settings = context.read<SettingsProvider>();

          log.info("Got notification ${widget.notification?.title}");
          _tx.type = .withdrawal;

          // Amount & Currency
          final CurrencyRead defaultCurrency = context
              .read<FireflyService>()
              .defaultCurrency;
          final NotificationAppSettings appSettings = await settings
              .notificationGetAppSettings(widget.notification!.appName);
          late CurrencyRead? currency;
          late double amount;
          (currency, amount) = await parseNotificationText(
            api,
            widget.notification!.body,
            _tx.localCurrency,
            userRegex: appSettings.regex,
          );
          currency ??= defaultCurrency; // Fallback solution

          // Set date
          _tx.date = _tzHandler
              .notificationTXTime(widget.notification!.date)
              .toLocal();

          // Title & Note
          if (!appSettings.emptyNote) {
            _tx.splits.first.noteTC.text = widget.notification!.body;
          }

          if (appSettings.includeTitle) {
            _tx.splits.first.titleTC.text = widget.notification!.title;
          } else {
            _tx.splits.first.titleTC.text = "";
            _tx.splits.first.noteTC.text =
                "${widget.notification!.title} - ${_tx.splits.first.noteTC.text}";
          }

          // Check account
          final Response<AccountArray> response = await api.v1AccountsGet(
            type: .assetAccount,
          );
          if (!response.isSuccessful || response.body == null) {
            log.warning("api account fetch failed");
            return;
          }
          final String settingAppId = appSettings.defaultAccountId ?? "0";
          for (AccountRead acc in response.body!.data) {
            if (acc.id == settingAppId ||
                widget.notification!.body.containsIgnoreCase(
                  acc.attributes.name,
                )) {
              _tx.splits.first.sourceAccountTC.text = acc.attributes.name;
              _tx.ownAccountID = acc.id;
              _tx.sourceAccountType = .assetAccount;
              if (currency.id == acc.attributes.currencyId) {
                _tx.localCurrency = currency;
              } else {
                _tx.localCurrency = CurrencyRead(
                  type: "currencies",
                  id: acc.attributes.currencyId!,
                  attributes: CurrencyProperties(
                    code: acc.attributes.currencyCode!,
                    name: "",
                    symbol: acc.attributes.currencySymbol!,
                    decimalPlaces: acc.attributes.currencyDecimalPlaces,
                  ),
                );
                _tx.splits.first.foreignCurrency = currency;
              }
              break;
            }
          }

          // Check currency
          if (currency.id == _tx.localCurrency.id) {
            _tx.splits.first.localAmount = amount;
            _tx.splits.first.localAmountUpdateText();
          } else {
            _tx.splits.first.foreignCurrency = currency;
            _tx.splits.first.foreignAmount = amount;
            _tx.splits.first.foreignAmountUpdateText();
          }
        }
        // Created from account screen, set account already
        if (widget.accountId != null && mounted) {
          // Check account
          final Response<AccountArray> response = await context
              .read<FireflyService>()
              .api
              .v1AccountsGet(type: .assetAccount);
          if (!response.isSuccessful || response.body == null) {
            log.warning("api account fetch failed");
            return;
          }
          for (AccountRead acc in response.body!.data) {
            if (acc.id == widget.accountId) {
              _tx.splits.first.sourceAccountTC.text = acc.attributes.name;
              _tx.sourceAccountType = .assetAccount;
              _tx.ownAccountID = acc.id;
              break;
            }
          }
        }
        // Created from a file share to app
        if (widget.files != null && widget.files!.isNotEmpty) {
          for (SharedFile file in widget.files!) {
            if (file.value == null || file.value!.isEmpty) {
              continue;
            }
            final XFile xfile = XFile(file.value!);
            _tx.attachments!.add(
              AttachmentRead(
                type: "attachments",
                id: _tx.attachments!.length.toString(),
                attributes: AttachmentProperties(
                  attachableType: .transactionjournal,
                  attachableId: "FAKE",
                  filename: xfile.name,
                  uploadUrl: xfile.path,
                  size: await xfile.length(),
                ),
                links: const ObjectLink(),
              ),
            );
          }
        }
      });
    }

    // If we're cloning, unset some values
    if (widget.clone) {
      _tx.date = _tzHandler.newTXTime().toLocal();
      _tx.reconciled = false;
      _tx.initiallyReconciled = false;
      _tx.splits.forEachIndexed(
        (_, TransactionSplitState s) => s.journalID = null,
      );
      _tx.attachments = <AttachmentRead>[];
    }

    _lastTXType = _tx.type;
    _tx.addListener(onTXChanged);
  }

  @override
  void dispose() {
    _totalAmountTC.dispose();
    _totalAmountFN.dispose();
    _commonSourceTC.dispose();
    _commonSourceFN.dispose();
    _commonDestinationTC.dispose();
    _commonDestinationFN.dispose();

    _tx.dispose();
    for (AnimationController a in _cardsAnimationController) {
      a.dispose();
    }

    super.dispose();
  }

  void updateTransactionAmounts() {
    // Individual for split transactions, show common for single transaction
    /// local amount
    if (_tx.splits.length == 1) {
      _totalAmountTC.text = _tx.splits.first.localAmountTC.text;
    } else {
      _totalAmountTC.text = _tx.totalAmount.toStringAsFixed(
        _tx.localCurrency.attributes.decimalPlaces ?? 2,
      );
    }
  }

  void Function(AnimationStatus) deleteCardAnimated(int i) {
    return (AnimationStatus status) {
      if (status == .dismissed) {
        splitTransactionRemove(i);
      }
    };
  }

  void splitTransactionRemove(int i) {
    log.fine(() => "removing split $i");
    _tx.splitRemove(i);

    _cardsAnimationController.removeAt(i).dispose();
    _cardsAnimation.removeAt(i);

    // Update summary values
    updateTransactionAmounts();
    if (!_tx.split) {
      // This is similar to the web interface --> summary text gets deleted when split is removed.
      if (_tx.splits.first.titleTC.text.isNotEmpty) {
        _tx.groupTitleTC.text = _tx.splits.first.titleTC.text;
      }
    }

    // Redo animationcallbacks due to new "i"s
    for (int i = 0; i < _cardsAnimationController.length; i++) {
      // ignore: invalid_use_of_protected_member
      _cardsAnimationController[i].clearStatusListeners();
      _cardsAnimationController[i].addStatusListener(
        (AnimationStatus status) => deleteCardAnimated(i)(status),
      );
    }

    log.finer(() => "remaining split #: ${_tx.splits.length}");
  }

  void splitTransactionAdd() {
    log.fine(() => "adding split");
    _tx.splitAdd();

    _cardsAnimationController.add(
      AnimationController(
        // height 0 = invisible - enter = fwd (0->1), exit = reverse (1->0)
        value: 0.0,
        duration: animDurationEmphasizedDecelerate,
        reverseDuration: animDurationEmphasizedAccelerate,
        vsync: this,
      ),
    );
    final int i = _cardsAnimationController.length - 1;
    _cardsAnimationController.last.addStatusListener(
      (AnimationStatus status) => deleteCardAnimated(i)(status),
    );
    _cardsAnimation.add(
      CurvedAnimation(
        parent: _cardsAnimationController.last,
        curve: animCurveEmphasizedDecelerate,
        reverseCurve: animCurveEmphasizedAccelerate,
      ),
    );

    log.finer(() => "new split #: ${_tx.splits.length}");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cardsAnimationController.last.forward();
    });
  }

  Future<void> updateAttachmentCount() async {
    log.finest(() => "updateAttachmentCount()");

    try {
      final FireflyIii api = context.read<FireflyService>().api;
      final Response<AttachmentArray> response = await api
          .v1TransactionsIdAttachmentsGet(id: widget.transaction?.id);
      apiThrowErrorIfEmpty(response, mounted ? context : null);

      _tx.attachments = response.body!.data;
    } catch (e, stackTrace) {
      log.severe("Error while fetching attachments from API", e, stackTrace);
    }
  }

  @override
  Widget build(BuildContext context) {
    log.finest(() => "build()");

    final List<Widget> actions = <Widget>[
      if (!_newTX) ...<Widget>[
        TransactionDeleteButton(transactionId: widget.transaction?.id),
        const SizedBox(width: 8),
      ],
      FilledButton(
        onPressed: _savingInProgress
            ? null
            : () async {
                /* :TODO: refactor
                final ScaffoldMessengerState msg = ScaffoldMessenger.of(
                  context,
                );
                final NavigatorState nav = Navigator.of(context);
                final FireflyIii api = context.read<FireflyService>().api;
                final AuthUser? user = context.read<FireflyService>().user;
                final TransStock? stock = context
                    .read<FireflyService>()
                    .transStock;

                // Sanity checks
                String? error;

                if (_ownAccountId == null) {
                  error = S.of(context).transactionErrorNoAssetAccount;
                }
                if (_titleTextController.text.isEmpty) {
                  error = S.of(context).transactionErrorTitle;
                }
                if (user == null || stock == null) {
                  error = S.of(context).errorAPIUnavailable;
                }
                if (_transactionType == .swaggerGeneratedUnknown) {
                  error = S.of(context).transactionErrorNoAccounts;
                }
                if (error != null) {
                  msg.showSnackBar(
                    SnackBar(content: Text(error), behavior: .floating),
                  );
                  return;
                }
                // Do stuff
                setState(() {
                  _savingInProgress = true;
                });
                // Fires calculation of text fields
                FocusScope.of(context).unfocus();
                late Response<TransactionSingle> resp;

                // Update existing transaction
                if (!_newTX) {
                  final String id = widget.transaction!.id;
                  final List<TransactionSplitUpdate> txS =
                      <TransactionSplitUpdate>[];
                  for (int i = 0; i < _localAmounts.length; i++) {
                    late String sourceName, destinationName;

                    sourceName = _sourceAccountTextControllers[i].text;
                    if (sourceName.isEmpty) {
                      sourceName = _sourceAccountTextController.text;
                    }
                    destinationName =
                        _destinationAccountTextControllers[i].text;
                    if (destinationName.isEmpty) {
                      destinationName = _destinationAccountTextController.text;
                    }

                    final TransactionSplitUpdate txSs = TransactionSplitUpdate(
                      amount: _localAmounts[i].toString(),
                      billId: _bills[i]?.id ?? "0",
                      budgetName: (_transactionType == .withdrawal)
                          ? _budgetTextControllers[i].text
                          : "",
                      categoryName: _categoryTextControllers[i].text,
                      date: _date,
                      description: _split
                          ? _titleTextControllers[i].text
                          : _titleTextController.text,
                      destinationName: destinationName,
                      // :HAX: Since nulled fields are not submitted, we set
                      // the value to 0 so the foreign currency is gone...
                      foreignAmount: _foreignCurrencies[i] != null
                          ? _foreignAmounts[i].toString()
                          : "0",
                      foreignCurrencyId: _foreignCurrencies[i]?.id,
                      notes: _noteTextControllers[i].text,
                      order: i,
                      sourceName: sourceName,
                      tags: _tags[i].tags,
                      transactionJournalId: _transactionJournalIDs
                          .elementAtOrNull(i),
                      type: _transactionType,
                      reconciled: _reconciled,
                    );

                    final TransactionSplit? oldSplit = widget
                        .transaction
                        ?.attributes
                        .transactions
                        .firstWhereOrNull(
                          (TransactionSplit e) =>
                              e.transactionJournalId != null &&
                              e.transactionJournalId ==
                                  txSs.transactionJournalId,
                        );
                    if (oldSplit != null) {
                      txS.add(txFilterSameFields(txSs, oldSplit));
                    } else {
                      txS.add(txSs);
                    }
                  }
                  final TransactionUpdate txUpdate = TransactionUpdate(
                    groupTitle: _split ? _titleTextController.text : null,
                    transactions: txS,
                  );
                  // Delete old splits
                  final List<Future<Response<dynamic>>> futures =
                      _deletedSplitIDs.where((String id) => id.isNotEmpty).map((
                        String id,
                      ) {
                        log.fine(() => "deleting split $id");
                        return api.v1TransactionJournalsIdDelete(id: id);
                      }).toList();
                  if (futures.isNotEmpty) {
                    await Future.wait(futures);
                  }
                  resp = await api.v1TransactionsIdPut(id: id, body: txUpdate);
                } else {
                  // New transaction
                  final List<TransactionSplitStore> txS =
                      <TransactionSplitStore>[];
                  for (int i = 0; i < _localAmounts.length; i++) {
                    late String sourceName, destinationName;

                    sourceName = _sourceAccountTextControllers[i].text;
                    if (sourceName.isEmpty) {
                      sourceName = _sourceAccountTextController.text;
                    }
                    destinationName =
                        _destinationAccountTextControllers[i].text;
                    if (destinationName.isEmpty) {
                      destinationName = _destinationAccountTextController.text;
                    }

                    txS.add(
                      TransactionSplitStore(
                        type: _transactionType,
                        date: _date.copyWith(
                          second: 0,
                          millisecond: 0,
                          microsecond: 0,
                        ),
                        amount: _localAmounts[i].toString(),
                        description: _split
                            ? _titleTextControllers[i].text
                            : _titleTextController.text,
                        billId: _bills[i]?.id ?? "0",
                        piggyBankId: (_piggy[i]?.id != null)
                            ? (int.parse(_piggy[i]!.id))
                            : null,
                        budgetName:
                            (_transactionType ==
                                TransactionTypeProperty.withdrawal)
                            ? _budgetTextControllers[i].text
                            : "",
                        categoryName: _categoryTextControllers[i].text,
                        destinationName: destinationName,
                        // :HAX: Since nulled fields are not submitted, we set
                        // the value to 0 so the foreign currency is gone...
                        foreignAmount: _foreignCurrencies[i] != null
                            ? _foreignAmounts[i].toString()
                            : "0",
                        foreignCurrencyId: _foreignCurrencies[i]?.id,
                        notes: _noteTextControllers[i].text,
                        order: i,
                        sourceName: sourceName,
                        tags: _tags[i].tags,
                        reconciled: _reconciled,
                      ),
                    );
                  }
                  final TransactionStore newTx = TransactionStore(
                    groupTitle: _split ? _titleTextController.text : null,
                    transactions: txS,
                    applyRules: true,
                    fireWebhooks: true,
                    errorIfDuplicateHash: true,
                  );
                  resp = await api.v1TransactionsPost(body: newTx);
                }

                // Check if insert/update was successful
                if (!resp.isSuccessful || resp.body == null) {
                  try {
                    final ValidationErrorResponse valError = .fromJson(
                      json.decode(resp.error.toString()),
                    );
                    error =
                        valError.message ??
                        // ignore: use_build_context_synchronously
                        (context.mounted
                            // ignore: use_build_context_synchronously
                            ? S.of(context).errorUnknown
                            : "[nocontext] Unknown error.");
                  } catch (_) {
                    // ignore: use_build_context_synchronously
                    error = context.mounted
                        // ignore: use_build_context_synchronously
                        ? S.of(context).errorUnknown
                        : "[nocontext] Unknown error.";
                  }

                  msg.showSnackBar(
                    SnackBar(content: Text(error), behavior: .floating),
                  );
                  setState(() {
                    _savingInProgress = false;
                  });
                  return;
                }

                // Update stock
                await stock!.setTransaction(resp.body!.data);

                // Upload attachments if required
                if ((_attachments?.isNotEmpty ?? false) &&
                    _transactionJournalIDs.firstWhereOrNull(
                          (String? e) => e != null,
                        ) ==
                        null) {
                  log.fine(
                    () => "uploading ${_attachments!.length} attachments",
                  );
                  final TransactionSplit? tx = resp
                      .body
                      ?.data
                      .attributes
                      .transactions
                      .firstWhereOrNull(
                        (TransactionSplit e) => e.transactionJournalId != null,
                      );
                  if (tx != null) {
                    final String txId = tx.transactionJournalId!;
                    log.finest(() => "uploading to txId $txId");
                    for (AttachmentRead attachment in _attachments!) {
                      log.finest(
                        () =>
                            "uploading attachment ${attachment.id}: ${attachment.attributes.filename}",
                      );
                      final Response<AttachmentSingle> respAttachment =
                          await api.v1AttachmentsPost(
                            body: AttachmentStore(
                              filename: attachment.attributes.filename!,
                              attachableType: .transactionjournal,
                              attachableId: txId,
                            ),
                          );
                      if (!respAttachment.isSuccessful ||
                          respAttachment.body == null) {
                        log.warning(() => "error uploading attachment");
                        continue;
                      }
                      final AttachmentRead newAttachment =
                          respAttachment.body!.data;
                      log.finest(() => "attachment id is ${newAttachment.id}");

                      final File file = File(attachment.attributes.uploadUrl!);

                      final http.StreamedRequest request = http.StreamedRequest(
                        HttpMethod.Post,
                        Uri.parse(newAttachment.attributes.uploadUrl!),
                      );
                      request.headers.addAll(user!.headers());
                      request.headers[HttpHeaders.contentTypeHeader] =
                          ContentType.binary.mimeType;
                      request.contentLength = await file.length();
                      log.fine(
                        () =>
                            "AttachmentUpload: Starting Upload ${newAttachment.id}",
                      );

                      file.openRead().listen(
                        (List<int> data) {
                          log.finest(() => "sent ${data.length} bytes");
                          request.sink.add(data);
                        },
                        onDone: () {
                          request.sink.close();
                        },
                      );

                      await httpClient.send(request);

                      log.fine(() => "done uploading attachment");
                    }
                  }
                }

                // Done saving
                setState(() => _savingInProgress = false);

                if (nav.canPop()) {
                  // Popping true means that the TX list will be refreshed.
                  // This should only happen if:
                  // 1. it is a new transaction
                  // 2. the date has been changed (changing the order of the TX list)
                  nav.pop(
                    widget.transaction == null ||
                        _date !=
                            _tzHandler.sTime(
                              widget
                                  .transaction!
                                  .attributes
                                  .transactions
                                  .first
                                  .date,
                            ),
                  );
                } else {
                  // Launched from notification
                  // https://stackoverflow.com/questions/45109557/flutter-how-to-programmatically-exit-the-app
                  await SystemChannels.platform.invokeMethod(
                    'SystemNavigator.pop',
                  );
                  await nav.pushReplacement(
                    MaterialPageRoute<bool>(
                      builder: (BuildContext context) => const NavPage(),
                    ),
                  );
                }*/
              },
        child: _savingInProgress
            ? const SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(strokeWidth: 3),
              )
            : Text(MaterialLocalizations.of(context).saveButtonLabel),
      ),
      const SizedBox(width: 16),
    ];
    final Widget body = PopScope(
      canPop: !_savingInProgress,
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          cacheExtent: 10000,
          padding: const .symmetric(horizontal: 24, vertical: 16),
          children: _transactionDetailBuilder(context),
        ),
      ),
    );
    if (context.read<LayoutProvider>().currentSize >= .expanded &&
        _newTX &&
        !widget.clone) {
      // Via FAB opened in a dialog
      return body;
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            _newTX
                ? S.of(context).transactionTitleAdd
                : S.of(context).transactionTitleEdit,
          ),
          actions: actions,
        ),
        body: body,
      );
    }
  }

  List<Widget> _transactionDetailBuilder(BuildContext context) {
    log.fine(() => "transactionDetailBuilder()");
    log.finer(() => "splits: ${_tx.splits.length}, split? ${_tx.split}");

    final List<Widget> childs = <Widget>[];
    const Widget hDivider = SizedBox(height: 16);
    const Widget vDivider = SizedBox(width: 16);

    CancelableOperation<Response<AutocompleteAccountArray>>? fetchOpSource;
    CancelableOperation<Response<AutocompleteAccountArray>>? fetchOpDestination;

    // Title + Amount
    childs.add(
      TransactionHeaderSection(
        tx: _tx,
        totalAmountTC: _totalAmountTC,
        totalAmountFN: _totalAmountFN,
        saving: _savingInProgress,
        readOnly: _tx.reconciled && _tx.initiallyReconciled,
      ),
    );
    /*
    // Title
    childs.add(
      Row(
        children: <Widget>[
          TransactionTitle(
            textController: _titleTextController,
            focusNode: _titleFocusNode,
          ),
          const SizedBox(width: 12),
          badges.Badge(
            badgeContent: Text(
              _attachments?.length.toString() ?? "..",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            showBadge: _hasAttachments,
            badgeStyle: badges.BadgeStyle(
              badgeColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
            badgeAnimation: const badges.BadgeAnimation.scale(
              animationDuration: animDurationEmphasized,
              curve: animCurveEmphasized,
            ),
            child: MaterialIconButton(
              icon: Icons.attach_file,
              tooltip: S.of(context).transactionAttachments,
              onPressed: () async {
                final List<AttachmentRead> dialogAttachments =
                    _attachments ?? <AttachmentRead>[];
                await showDialog<List<AttachmentRead>>(
                  context: context,
                  builder: (BuildContext context) => AttachmentDialog(
                    attachments: dialogAttachments,
                    transactionId: _transactionJournalIDs.firstWhereOrNull(
                      (String? element) => element != null,
                    ),
                  ),
                );
                setState(() {
                  _attachments = dialogAttachments;
                  _hasAttachments = _attachments?.isNotEmpty ?? false;
                });
              },
            ),
          ),
        ],
      ),
    );
    childs.add(hDivider);

    // Amount, Date & Time
    childs.add(
      // Date/Time select might overflow, so we need to be able to scroll horizontally.
      SingleChildScrollView(
        scrollDirection: .horizontal,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 130,
              child: Center(
                child: NumberInput(
                  icon: _localCurrency != null
                      ? SizedBox(
                          width: 24,
                          height: 32,
                          child: FittedBox(
                            child: Text(_localCurrency!.attributes.symbol),
                          ),
                        )
                      : const Icon(Icons.monetization_on),
                  hintText:
                      _localCurrency?.zero() ??
                      NumberFormat.currency(decimalDigits: 2).format(0),
                  decimals: _localCurrency?.attributes.decimalPlaces ?? 2,
                  //style: Theme.of(context).textTheme.headlineLarge,
                  controller: _localAmountTextController,
                  disabled:
                      _savingInProgress ||
                      _split ||
                      (_reconciled && _initiallyReconciled),
                  onChanged: (String string) =>
                      _localAmounts[0] = double.tryParse(string) ?? 0,
                ),
              ),
            ),
            vDivider,
            IntrinsicWidth(
              child: TextFormField(
                controller: _dateTextController,
                decoration: const InputDecoration(
                  //prefixIcon: Icon(Icons.calendar_month),
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                enabled: !_savingInProgress,
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _date,
                    locale: Locale(
                      Intl.defaultLocale!.split("_").first,
                      Intl.defaultLocale!.split("_").last,
                    ),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );

                  if (pickedDate == null) {
                    return;
                  }

                  setState(() {
                    _date = tz.TZDateTime.from(
                      _date.copyWith(
                        year: pickedDate.year,
                        month: pickedDate.month,
                        day: pickedDate.day,
                      ),
                      _date.location,
                    );
                    _dateTextController.text = DateFormat.yMMMd().format(_date);
                  });
                },
              ),
            ),
            vDivider,
            IntrinsicWidth(
              child: TextFormField(
                controller: _timeTextController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                readOnly: true,
                enabled: !_savingInProgress,
                onTap: () async {
                  final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: _date.getTimeOfDay(),
                  );

                  if (pickedTime == null) {
                    return;
                  }

                  setState(() {
                    _date = _date.setTimeOfDay(pickedTime);
                    _timeTextController.text = DateFormat.Hm().format(_date);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
    */
    childs.add(hDivider);

    // Source Account, Destination Account & floating type element
    childs.add(
      Stack(
        children: <Widget>[
          const SizedBox(height: 64 + 16 + 64), // Padding for Stack
          Row(
            children: <Widget>[
              const Icon(Icons.logout),
              vDivider,
              Expanded(
                child: AutoCompleteText<AutocompleteAccount>(
                  labelText: S.of(context).generalSourceAccount,
                  textController: _commonSourceTC,
                  focusNode: _commonSourceFN,
                  errorIconOnly: true,
                  onChanged: (String val) {
                    _tx.setSourceAccount(val);
                  },
                  onSelected: (AutocompleteAccount option) {
                    _tx.selectSourceAccount(option);
                    checkAccountCurrency(option, true);
                  },
                  displayStringForOption: (AutocompleteAccount option) =>
                      option.name,
                  optionsBuilder: (TextEditingValue textEditingValue) async {
                    try {
                      unawaited(fetchOpSource?.cancel());

                      final FireflyIii api = context.read<FireflyService>().api;
                      fetchOpSource =
                          CancelableOperation<
                            Response<AutocompleteAccountArray>
                          >.fromFuture(
                            api.v1AutocompleteAccountsGet(
                              query: textEditingValue.text,
                              types: _tx.destinationAccountType
                                  .allowedOpposingTypes(false),
                            ),
                          );
                      final Response<AutocompleteAccountArray>? response =
                          await fetchOpSource?.valueOrCancellation();
                      if (response == null) {
                        // Cancelled
                        return const Iterable<AutocompleteAccount>.empty();
                      }
                      apiThrowErrorIfEmpty(response, mounted ? context : null);

                      return response.body!;
                    } catch (e, stackTrace) {
                      log.severe(
                        "Error while fetching autocomplete from API",
                        e,
                        stackTrace,
                      );
                      return const Iterable<AutocompleteAccount>.empty();
                    }
                  },
                  disabled:
                      _savingInProgress ||
                      (_tx.reconciled && _tx.initiallyReconciled) ||
                      _commonSourceTC.text ==
                          "<${S.of(context).generalMultiple}>",
                ),
              ),
            ],
          ),
          // Destination account
          Positioned.fill(
            top: 64 + 16,
            child: Row(
              children: <Widget>[
                const Icon(Icons.login),
                vDivider,
                Expanded(
                  child: AutoCompleteText<AutocompleteAccount>(
                    labelText: S.of(context).generalDestinationAccount,
                    textController: _commonDestinationTC,
                    focusNode: _commonDestinationFN,
                    onChanged: (String val) {
                      _tx.setDestinationAccount(val);
                    },
                    errorIconOnly: true,
                    displayStringForOption: (AutocompleteAccount option) =>
                        option.name,
                    onSelected: (AutocompleteAccount option) {
                      _tx.selectDestinationAccount(option);
                      checkAccountCurrency(option, false);
                    },
                    optionsBuilder: (TextEditingValue textEditingValue) async {
                      try {
                        unawaited(fetchOpDestination?.cancel());

                        final FireflyIii api = context
                            .read<FireflyService>()
                            .api;
                        fetchOpDestination =
                            CancelableOperation<
                              Response<AutocompleteAccountArray>
                            >.fromFuture(
                              api.v1AutocompleteAccountsGet(
                                query: textEditingValue.text,
                                types: _tx.sourceAccountType
                                    .allowedOpposingTypes(true),
                              ),
                            );
                        final Response<AutocompleteAccountArray>? response =
                            await fetchOpDestination?.valueOrCancellation();
                        if (response == null) {
                          // Cancelled
                          return const Iterable<AutocompleteAccount>.empty();
                        }
                        apiThrowErrorIfEmpty(
                          response,
                          mounted ? context : null,
                        );

                        return response.body!;
                      } catch (e, stackTrace) {
                        log.severe(
                          "Error while fetching autocomplete from API",
                          e,
                          stackTrace,
                        );
                        return const Iterable<AutocompleteAccount>.empty();
                      }
                    },
                    disabled:
                        _savingInProgress ||
                        (_tx.reconciled && _tx.initiallyReconciled) ||
                        _commonDestinationTC.text ==
                            "<${S.of(context).generalMultiple}>",
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: (64 + 16 + 4) / 2,
            right: 15,
            child: FloatingActionButton.extended(
              extendedIconLabelSpacing: _txTypeChipExtended ? 10 : 0,
              extendedPadding: _txTypeChipExtended ? null : const .all(16),
              onPressed: null,
              label: AnimatedSize(
                duration: animDurationEmphasized,
                curve: animCurveEmphasized,
                child: _txTypeChipExtended
                    ? Text(_tx.type.friendlyName(context))
                    : const SizedBox(),
              ),
              icon: Icon(_tx.type.verticalIcon),
              backgroundColor: _savingInProgress
                  ? Theme.of(context).colorScheme.surfaceContainerHighest
                  : _tx.type.color,
            ),
          ),
        ],
      ),
    );
    childs.add(hDivider);
    // Cards with (Split Title), Category, (Split Amount), Tags, Notes
    for (int i = 0; i < _tx.splits.length; i++) {
      childs.add(
        SizeTransition(
          sizeFactor: _cardsAnimation[i],
          axis: .vertical,
          child: _buildSplitWidget(context, i),
        ),
      );
    }
    childs.add(hDivider);
    childs.add(
      FilledButton.icon(
        onPressed: _savingInProgress
            ? null
            : () => _tx.reconciled && _tx.initiallyReconciled
                  ? null
                  : splitTransactionAdd(),
        label: Text(S.of(context).transactionSplitAdd),
        icon: const Icon(Icons.call_split),
      ),
    );

    return childs;
  }

  void checkAccountCurrency(AutocompleteAccount option, bool isSource) {
    // :TODO: ONLY ASSET ACCOUNTS HAVE A CURRENCY!

    // Update currency when:
    // 1. set account is source & assetAccount
    // 2. set account is destination & assetAccount & source account is NOT an
    //    asset account
    // 3. either source or destination account are still unset, so first to set
    if ((isSource && _tx.sourceAccountType == .assetAccount) ||
        (!isSource &&
            _tx.destinationAccountType == .assetAccount &&
            _tx.sourceAccountType != .assetAccount) ||
        (_tx.sourceAccountType == .swaggerGeneratedUnknown ||
            _tx.destinationAccountType == .swaggerGeneratedUnknown)) {
      if (_tx.localCurrency.id != option.currencyId.toString()) {
        setState(() {
          _tx.localCurrency = CurrencyRead(
            type: "currencies",
            id: option.currencyId.toString(),
            attributes: CurrencyProperties(
              code: option.currencyCode,
              name: option.currencyName,
              symbol: option.currencySymbol,
              decimalPlaces: option.currencyDecimalPlaces,
            ),
          );
        });
      }
    }
    // set foreign currency if account is destination & asset account and source
    // account is also asset account (transfer from one currency to other)
    if ((!isSource &&
            _tx.destinationAccountType == .assetAccount &&
            _tx.sourceAccountType == .assetAccount) &&
        _tx.localCurrency.id != option.currencyId) {
      // Only when destination & source account have different currency
      if (!_tx.splits.every(
        (TransactionSplitState s) => s.foreignCurrency?.id == option.currencyId,
      )) {
        setState(() {
          for (TransactionSplitState s in _tx.splits) {
            s.foreignCurrency = CurrencyRead(
              type: "currencies",
              id: option.currencyId,
              attributes: CurrencyProperties(
                code: option.currencyCode,
                name: option.currencyName,
                symbol: option.currencySymbol,
                decimalPlaces: option.currencyDecimalPlaces,
              ),
            );
          }
        });
      }
    }
  }

  Future<void> onTXChanged() async {
    log.finest(() => "onTXChanged()");

    if (_tx.type != _lastTXType) {
      await handleTXTypeChange();
      _lastTXType = _tx.type;

      // Withdrawal: splits have common source account
      // Deposit: splits have common destination account
      // Transfer: splits have common accounts for both
      if (_tx.type == .withdrawal || _tx.type == .transfer) {
        for (TransactionSplitState s in _tx.splits) {
          s.sourceAccountTC.text = _commonSourceTC.text;
        }
      }
      if (_tx.type == .deposit || _tx.type == .transfer) {
        for (TransactionSplitState s in _tx.splits) {
          s.destinationAccountTC.text = _commonDestinationTC.text;
        }
      }
    }

    updateTransactionAmounts();
    setState(() {});
  }

  Future<void> handleTXTypeChange() async {
    if (_tx.type != .swaggerGeneratedUnknown) {
      setState(() {
        _txTypeChipExtended = true;
      });
      unawaited(
        Future<void>.delayed(animDurationEmphasized * 3, () {
          setState(() {
            _txTypeChipExtended = false;
          });
        }),
      );
    }
  }

  Card _buildSplitWidget(BuildContext context, int i) {
    const Widget hDivider = SizedBox(height: 16);

    CancelableOperation<Response<AutocompleteAccountArray>>? fetchOp;

    return const Card(child: SizedBox.shrink());

    /*
    :TODO: refactor
    return Card(
      key: ValueKey<int>(i),
      child: Padding(
        padding: const .all(16),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  // (Split) Transaction title
                  AnimatedHeight(
                    child: _split
                        ? Row(
                            children: <Widget>[
                              TransactionTitle(
                                textController: _titleTextControllers[i],
                                focusNode: _titleFocusNodes[i],
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                  AnimatedHeight(
                    child: _split ? hDivider : const SizedBox.shrink(),
                  ),
                  // (Split) Source Account
                  AnimatedHeight(
                    child: _showSourceAccountSelection
                        ? Row(
                            children: <Widget>[
                              Expanded(
                                child: AutoCompleteText<AutocompleteAccount>(
                                  disabled: _savingInProgress,
                                  labelText: S.of(context).generalSourceAccount,
                                  labelIcon: Icons.logout,
                                  textController:
                                      _sourceAccountTextControllers[i],
                                  focusNode: _sourceAccountFocusNodes[i],
                                  displayStringForOption:
                                      (AutocompleteAccount option) =>
                                          option.name,
                                  onChanged: (_) =>
                                      splitTransactionCheckAccounts(),
                                  onSelected: (_) =>
                                      splitTransactionCheckAccounts(),
                                  optionsBuilder:
                                      (
                                        TextEditingValue textEditingValue,
                                      ) async {
                                        try {
                                          unawaited(fetchOp?.cancel());

                                          final FireflyIii api = context
                                              .read<FireflyService>()
                                              .api;
                                          fetchOp =
                                              CancelableOperation<
                                                Response<
                                                  AutocompleteAccountArray
                                                >
                                              >.fromFuture(
                                                api.v1AutocompleteAccountsGet(
                                                  query: textEditingValue.text,
                                                  types: _destinationAccountType
                                                      .allowedOpposingTypes(
                                                        false,
                                                      ),
                                                ),
                                              );
                                          final Response<
                                            AutocompleteAccountArray
                                          >?
                                          response = await fetchOp
                                              ?.valueOrCancellation();
                                          if (response == null) {
                                            // Cancelled
                                            return const Iterable<
                                              AutocompleteAccount
                                            >.empty();
                                          }
                                          apiThrowErrorIfEmpty(
                                            response,
                                            mounted ? context : null,
                                          );

                                          return response.body!;
                                        } catch (e, stackTrace) {
                                          log.severe(
                                            "Error while fetching autocomplete from API",
                                            e,
                                            stackTrace,
                                          );
                                          return const Iterable<
                                            AutocompleteAccount
                                          >.empty();
                                        }
                                      },
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                  AnimatedHeight(
                    child: _showSourceAccountSelection
                        ? hDivider
                        : const SizedBox.shrink(),
                  ),
                  // (Split) Destination Account
                  AnimatedHeight(
                    child: _showDestinationAccountSelection
                        ? Row(
                            children: <Widget>[
                              Expanded(
                                child: AutoCompleteText<AutocompleteAccount>(
                                  disabled: _savingInProgress,
                                  labelText: S
                                      .of(context)
                                      .generalDestinationAccount,
                                  labelIcon: Icons.login,
                                  textController:
                                      _destinationAccountTextControllers[i],
                                  focusNode: _destinationAccountFocusNodes[i],
                                  onChanged: (_) =>
                                      splitTransactionCheckAccounts(),
                                  onSelected: (_) =>
                                      splitTransactionCheckAccounts(),
                                  displayStringForOption:
                                      (AutocompleteAccount option) =>
                                          option.name,
                                  optionsBuilder:
                                      (
                                        TextEditingValue textEditingValue,
                                      ) async {
                                        try {
                                          final FireflyIii api = context
                                              .read<FireflyService>()
                                              .api;
                                          fetchOp =
                                              CancelableOperation<
                                                Response<
                                                  AutocompleteAccountArray
                                                >
                                              >.fromFuture(
                                                api.v1AutocompleteAccountsGet(
                                                  query: textEditingValue.text,
                                                  types: _sourceAccountType
                                                      .allowedOpposingTypes(
                                                        true,
                                                      ),
                                                ),
                                              );
                                          final Response<
                                            AutocompleteAccountArray
                                          >?
                                          response = await fetchOp
                                              ?.valueOrCancellation();
                                          if (response == null) {
                                            // Cancelled
                                            return const Iterable<
                                              AutocompleteAccount
                                            >.empty();
                                          }
                                          apiThrowErrorIfEmpty(
                                            response,
                                            mounted ? context : null,
                                          );

                                          return response.body!;
                                        } catch (e, stackTrace) {
                                          log.severe(
                                            "Error while fetching autocomplete from API",
                                            e,
                                            stackTrace,
                                          );
                                          return const Iterable<
                                            AutocompleteAccount
                                          >.empty();
                                        }
                                      },
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                  AnimatedHeight(
                    child: _showDestinationAccountSelection
                        ? hDivider
                        : const SizedBox.shrink(),
                  ),
                  // Category (always)
                  TransactionCategory(
                    textController: _categoryTextControllers[i],
                    focusNode: _categoryFocusNodes[i],
                  ),
                  hDivider,
                  // Budget (for withdrawals)
                  AnimatedHeight(
                    child: (_transactionType == .withdrawal)
                        ? TransactionBudget(
                            textController: _budgetTextControllers[i],
                            focusNode: _budgetFocusNodes[i],
                          )
                        : const SizedBox.shrink(),
                  ),
                  AnimatedHeight(
                    child: (_transactionType == .withdrawal)
                        ? hDivider
                        : const SizedBox.shrink(),
                  ),
                  // (Split) Foreign Currency
                  AnimatedHeight(
                    child: (_split || _foreignCurrencies[i] != null)
                        ? Row(
                            children: <Widget>[
                              Expanded(
                                child: NumberInput(
                                  icon: (_foreignCurrencies[i] != null)
                                      ? const Icon(Icons.currency_exchange)
                                      : const Icon(Icons.monetization_on),
                                  controller: (_foreignCurrencies[i] != null)
                                      ? _foreignAmountTextControllers[i]
                                      : _localAmountTextControllers[i],
                                  hintText:
                                      _foreignCurrencies[i]?.zero() ??
                                      _localCurrency?.zero() ??
                                      NumberFormat.currency(
                                        decimalDigits: 2,
                                      ).format(0),
                                  decimals:
                                      _foreignCurrencies[i]
                                          ?.attributes
                                          .decimalPlaces ??
                                      _localCurrency
                                          ?.attributes
                                          .decimalPlaces ??
                                      2,
                                  prefixText:
                                      "${_foreignCurrencies[i]?.attributes.code ?? _localCurrency?.attributes.code} ",
                                  onChanged: (String string) {
                                    if (_foreignCurrencies[i] != null) {
                                      _foreignAmounts[i] =
                                          double.tryParse(string) ?? 0;
                                    } else {
                                      _localAmounts[i] =
                                          double.tryParse(string) ?? 0;
                                    }
                                    splitTransactionCalculateAmount();
                                  },
                                  disabled:
                                      _savingInProgress ||
                                      _reconciled && _initiallyReconciled,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                  AnimatedHeight(
                    child: (_split || _foreignCurrencies[i] != null)
                        ? hDivider
                        : const SizedBox.shrink(),
                  ),
                  // (Split) Local Currency (when foreign selected)
                  AnimatedHeight(
                    child: (_split && _foreignCurrencies[i] != null)
                        ? Row(
                            children: <Widget>[
                              Expanded(
                                child: NumberInput(
                                  icon: const Icon(Icons.currency_exchange),
                                  controller: _localAmountTextControllers[i],
                                  hintText:
                                      _localCurrency?.zero() ??
                                      NumberFormat.currency(
                                        decimalDigits: 2,
                                      ).format(0),
                                  decimals:
                                      _localCurrency
                                          ?.attributes
                                          .decimalPlaces ??
                                      2,
                                  prefixText:
                                      "${_localCurrency?.attributes.code} ",
                                  onChanged: (String string) {
                                    _localAmounts[i] =
                                        double.tryParse(string) ?? 0;
                                    splitTransactionCalculateAmount();
                                  },
                                  disabled:
                                      _savingInProgress ||
                                      _reconciled && _initiallyReconciled,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                  AnimatedHeight(
                    child: (_split && _foreignCurrencies[i] != null)
                        ? hDivider
                        : const SizedBox.shrink(),
                  ),
                  // Tags (always)
                  TransactionTags(
                    interactable: !_savingInProgress,
                    textController: _tagsTextControllers[i],
                    tagsController: _tags[i],
                  ),
                  // Note (always)
                  hDivider,
                  TransactionNote(textController: _noteTextControllers[i]),
                ],
              ),
            ),
            SizedBox(
              width: 48,
              child: Align(
                alignment: .centerRight,
                child: AnimatedSize(
                  duration: animDurationStandard,
                  curve: animCurveStandard,
                  alignment: .topCenter,
                  child: Column(
                    children: <Widget>[
                      // Reconciled Button
                      IconButton(
                        icon: const Icon(Icons.done_outline),
                        isSelected: _reconciled,
                        selectedIcon: const Icon(Icons.done),
                        onPressed: _savingInProgress
                            ? null
                            : () => setState(() {
                                _reconciled = !_reconciled;
                                _initiallyReconciled = false;
                              }),
                        tooltip: S.of(context).generalReconcile,
                      ),
                      hDivider,
                      // Bills Button
                      IconButton(
                        icon: const Icon(Icons.calendar_today),
                        isSelected: _bills[i] != null,
                        selectedIcon: const Icon(Icons.event_available),
                        onPressed: _savingInProgress
                            ? null
                            : () async {
                                BillRead? newBill = await showDialog<BillRead>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) =>
                                      BillDialog(currentBill: _bills[i]),
                                );
                                // Back button returns "null"
                                if (newBill == null) {
                                  return;
                                }
                                // Delete bill returns id "0"
                                if (newBill.id.isEmpty || newBill.id == "0") {
                                  newBill = null;
                                }
                                if (newBill != _bills[i]) {
                                  setState(() {
                                    _bills[i] = newBill;
                                  });
                                }
                              },
                        tooltip: S.of(context).transactionDialogBillTitle,
                      ),
                      hDivider,
                      // Foreign Currency Button
                      IconButton(
                        icon: const Icon(Icons.currency_exchange),
                        isSelected: _foreignCurrencies[i] != null,
                        onPressed: _savingInProgress
                            ? null
                            : !(_reconciled && _initiallyReconciled)
                            ? () async {
                                CurrencyRead? newCurrency =
                                    await showDialog<CurrencyRead>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          CurrencyDialog(
                                            currentCurrency:
                                                _foreignCurrencies[i] ??
                                                _localCurrency!,
                                          ),
                                    );
                                if (newCurrency == null) {
                                  return;
                                }

                                if (newCurrency.id == _localCurrency!.id) {
                                  newCurrency = null;
                                  _foreignAmounts[i] = 0;
                                  _foreignAmountTextControllers[i].text = "";
                                }

                                log.fine(
                                  () =>
                                      "adding foreign currency ${newCurrency?.id ?? "null"} for $i",
                                );

                                setState(() {
                                  _foreignCurrencies[i] = newCurrency;
                                });
                              }
                            : null,
                        tooltip: (_split)
                            ? S.of(context).transactionSplitChangeCurrency
                            : null,
                      ),
                      // Piggy Bank Button
                      // Only on new TX (similar to Firefly webinterface)
                      if (_newTX) ...<Widget>[
                        hDivider,
                        IconButton(
                          icon: const Icon(Icons.savings_outlined),
                          isSelected: _piggy[i] != null,
                          selectedIcon: const Icon(Icons.savings),
                          onPressed: _savingInProgress
                              ? null
                              : () async {
                                  PiggyBankRead? newPiggy =
                                      await showDialog<PiggyBankRead>(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) =>
                                            PiggyDialog(
                                              currentPiggy: _piggy[i],
                                            ),
                                      );
                                  // Back button returns "null"
                                  if (newPiggy == null) {
                                    return;
                                  }
                                  // Delete piggy returns id "0"
                                  if (newPiggy.id.isEmpty ||
                                      newPiggy.id == "0") {
                                    newPiggy = null;
                                  }
                                  if (newPiggy != _piggy[i]) {
                                    setState(() {
                                      _piggy[i] = newPiggy;
                                    });
                                  }
                                },
                          tooltip: S.of(context).transactionDialogPiggyTitle,
                        ),
                        hDivider,
                        // (Split) Source Account Button (for deposits)
                        if (_split) ...<Widget>[
                          if (!_showSourceAccountSelection &&
                              _transactionType == .deposit) ...<Widget>[
                            IconButton(
                              icon: const Icon(Icons.add_business),
                              onPressed: _savingInProgress
                                  ? null
                                  : _split &&
                                        !_showSourceAccountSelection &&
                                        _transactionType == .deposit &&
                                        !(_reconciled && _initiallyReconciled)
                                  ? () {
                                      log.fine(
                                        () =>
                                            "adding separate source account for $i",
                                      );
                                      _sourceAccountTextControllers[i].text =
                                          "";
                                      setState(() {
                                        _showSourceAccountSelection = true;
                                      });
                                    }
                                  : null,
                              tooltip: (_split)
                                  ? S
                                        .of(context)
                                        .transactionSplitChangeSourceAccount
                                  : null,
                            ),
                            hDivider,
                          ],
                          // (Split) Destination Account Button (for withdrawals)
                          if (!_showDestinationAccountSelection &&
                              _transactionType == .withdrawal) ...<Widget>[
                            IconButton(
                              icon: const Icon(Icons.add_business),
                              onPressed: _savingInProgress
                                  ? null
                                  : _split &&
                                        !_showDestinationAccountSelection &&
                                        _transactionType == .withdrawal &&
                                        !(_reconciled && _initiallyReconciled)
                                  ? () {
                                      log.fine(
                                        () =>
                                            "adding separate destination account for $i",
                                      );
                                      _destinationAccountTextControllers[i]
                                              .text =
                                          "";
                                      setState(() {
                                        _showDestinationAccountSelection = true;
                                      });
                                    }
                                  : null,
                              tooltip: (_split)
                                  ? S
                                        .of(context)
                                        .transactionSplitChangeDestinationAccount
                                  : null,
                            ),
                            hDivider,
                          ],
                          // Delete Split Button
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: _savingInProgress
                                ? null
                                : _split &&
                                      !(_reconciled && _initiallyReconciled)
                                ? () {
                                    log.fine(() => "marking $i for deletion");
                                    _cardsAnimationController[i].reverse();
                                  }
                                : null,
                            tooltip: (_split)
                                ? S.of(context).transactionSplitDelete
                                : null,
                          ),
                        ],
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );*/
  }
}

TransactionSplitUpdate txFilterSameFields(
  TransactionSplitUpdate txU,
  TransactionSplit tx,
) {
  /* https://github.com/firefly-iii/firefly-iii/blob/main/app/Validation/GroupValidation.php#L105
     $forbidden = ['amount', 'foreign_amount', 'currency_code', 'currency_id', 'foreign_currency_code', 'foreign_currency_id',
       'source_id', 'source_name', 'source_number', 'source_iban',
       'destination_id', 'destination_name', 'destination_number', 'destination_iban',
     ];
       */
  return txU.copyWith(
    amount: tx.amount == txU.amount ? null : txU.amount,
    foreignAmount: tx.foreignAmount == txU.foreignAmount
        ? null
        : txU.foreignAmount,
    foreignCurrencyId: tx.foreignCurrencyId == txU.foreignCurrencyId
        ? null
        : txU.foreignCurrencyId,
    sourceName: tx.sourceName == txU.sourceName ? null : txU.sourceName,
    destinationName: tx.destinationName == txU.destinationName
        ? null
        : txU.destinationName,
  );
}

class TransactionDeleteButton extends StatelessWidget {
  const TransactionDeleteButton({super.key, required this.transactionId});

  final String? transactionId;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      tooltip: MaterialLocalizations.of(context).deleteButtonTooltip,
      onPressed: _savingInProgress
          ? null
          : () async {
              final FireflyIii api = context.read<FireflyService>().api;
              final NavigatorState nav = Navigator.of(context);
              final bool? ok = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) =>
                    const DeletionConfirmDialog(),
              );
              if (!(ok ?? false)) {
                return;
              }

              await api.v1TransactionsIdDelete(id: transactionId);
              nav.pop(true);
            },
    );
  }
}

class TransactionTitle extends StatelessWidget {
  const TransactionTitle({
    super.key,
    required this.textController,
    required this.focusNode,
  });

  final TextEditingController textController;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final Logger log = Logger("Pages.Transaction.Title");

    CancelableOperation<Response<AutocompleteTransactionArray>>? fetchOp;

    log.finest(() => "build()");
    return Expanded(
      child: AutoCompleteText<String>(
        disabled: _savingInProgress,
        labelText: S.of(context).transactionFormLabelTitle,
        labelIcon: Icons.receipt_long,
        textController: textController,
        focusNode: focusNode,
        optionsBuilder: (TextEditingValue textEditingValue) async {
          try {
            unawaited(fetchOp?.cancel());

            final FireflyIii api = context.read<FireflyService>().api;
            fetchOp =
                CancelableOperation<
                  Response<AutocompleteTransactionArray>
                >.fromFuture(
                  api.v1AutocompleteTransactionsGet(
                    query: textEditingValue.text,
                  ),
                );
            final Response<AutocompleteTransactionArray>? response =
                await fetchOp?.valueOrCancellation();
            if (response == null) {
              // Cancelled
              return const Iterable<String>.empty();
            }
            apiThrowErrorIfEmpty(response, context.mounted ? context : null);

            return response.body!.map((AutocompleteTransaction e) => e.name);
          } catch (e, stackTrace) {
            log.severe(
              "Error while fetching autocomplete from API",
              e,
              stackTrace,
            );
            return const Iterable<String>.empty();
          }
        },
      ),
    );
  }
}

class TransactionNote extends StatelessWidget {
  const TransactionNote({super.key, required this.textController});

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    final Logger log = Logger("Pages.Transaction.Note");

    log.finest(() => "build()");
    return Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            enabled: !_savingInProgress,
            controller: textController,
            maxLines: null,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: S.of(context).transactionFormLabelNotes,
              icon: const Icon(Icons.description),
              filled: _savingInProgress,
            ),
          ),
        ),
      ],
    );
  }
}

class TransactionCategory extends StatelessWidget {
  const TransactionCategory({
    super.key,
    required this.textController,
    required this.focusNode,
  });

  final TextEditingController textController;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final Logger log = Logger("Pages.Transaction.Category");

    CancelableOperation<Response<AutocompleteCategoryArray>>? fetchOp;

    log.finest(() => "build()");
    return Row(
      children: <Widget>[
        Expanded(
          child: AutoCompleteText<String>(
            disabled: _savingInProgress,
            labelText: S.of(context).generalCategory,
            labelIcon: Icons.assignment,
            textController: textController,
            focusNode: focusNode,
            optionsBuilder: (TextEditingValue textEditingValue) async {
              try {
                unawaited(fetchOp?.cancel());

                final FireflyIii api = context.read<FireflyService>().api;
                fetchOp =
                    CancelableOperation<
                      Response<AutocompleteCategoryArray>
                    >.fromFuture(
                      api.v1AutocompleteCategoriesGet(
                        query: textEditingValue.text,
                      ),
                    );
                final Response<AutocompleteCategoryArray>? response =
                    await fetchOp?.valueOrCancellation();
                if (response == null) {
                  // Cancelled
                  return const Iterable<String>.empty();
                }
                apiThrowErrorIfEmpty(
                  response,
                  context.mounted ? context : null,
                );

                return response.body!.map((AutocompleteCategory e) => e.name);
              } catch (e, stackTrace) {
                log.severe(
                  "Error while fetching autocomplete from API",
                  e,
                  stackTrace,
                );
                return const Iterable<String>.empty();
              }
            },
          ),
        ),
      ],
    );
  }
}

class TransactionBudget extends StatefulWidget {
  const TransactionBudget({
    super.key,
    required this.textController,
    required this.focusNode,
  });

  final TextEditingController textController;
  final FocusNode focusNode;

  @override
  State<TransactionBudget> createState() => _TransactionBudgetState();
}

class _TransactionBudgetState extends State<TransactionBudget> {
  final Logger log = Logger("Pages.Transaction.Budget");

  // Initial string is empty, as we expect it to be ok
  // (either empty or loaded from db)
  String? _budgetId = "";

  @override
  void initState() {
    super.initState();

    widget.focusNode.addListener(() async {
      if (widget.focusNode.hasFocus) {
        return;
      }
      if (widget.textController.text.isEmpty) {
        setState(() {
          _budgetId = "";
        });
        return;
      }
      try {
        final FireflyIii api = context.read<FireflyService>().api;
        final Response<AutocompleteBudgetArray> response = await api
            .v1AutocompleteBudgetsGet(query: widget.textController.text);
        apiThrowErrorIfEmpty(response, mounted ? context : null);

        if (response.body!.isEmpty ||
            (response.body!.length > 1 &&
                response.body!.first.name != widget.textController.text)) {
          setState(() {
            _budgetId = null;
          });
        } else {
          widget.textController.text = response.body!.first.name;
          setState(() {
            _budgetId = response.body!.first.id;
          });
        }
      } catch (e, stackTrace) {
        log.severe("Error while fetching autocomplete from API", e, stackTrace);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    CancelableOperation<Response<AutocompleteBudgetArray>>? fetchOp;

    log.finest(() => "build()");
    return Row(
      children: <Widget>[
        Expanded(
          child: AutoCompleteText<AutocompleteBudget>(
            disabled: _savingInProgress,
            labelText: S.of(context).generalBudget,
            labelIcon: Icons.payments,
            textController: widget.textController,
            focusNode: widget.focusNode,
            errorText: _budgetId == null
                ? S.of(context).transactionErrorInvalidBudget
                : null,
            errorIconOnly: true,
            displayStringForOption: (AutocompleteBudget option) => option.name,
            onSelected: (AutocompleteBudget option) {
              setState(() {
                _budgetId = option.id;
              });
            },
            optionsBuilder: (TextEditingValue textEditingValue) async {
              try {
                unawaited(fetchOp?.cancel());

                final FireflyIii api = context.read<FireflyService>().api;
                fetchOp =
                    CancelableOperation<
                      Response<AutocompleteBudgetArray>
                    >.fromFuture(
                      api.v1AutocompleteBudgetsGet(
                        query: textEditingValue.text,
                      ),
                    );
                final Response<AutocompleteBudgetArray>? response =
                    await fetchOp?.valueOrCancellation();
                if (response == null) {
                  // Cancelled
                  return const Iterable<AutocompleteBudget>.empty();
                }
                apiThrowErrorIfEmpty(response, mounted ? context : null);

                return response.body!;
              } catch (e, stackTrace) {
                log.severe(
                  "Error while fetching autocomplete from API",
                  e,
                  stackTrace,
                );
                return const Iterable<AutocompleteBudget>.empty();
              }
            },
          ),
        ),
      ],
    );
  }
}

class AttachmentButton extends StatefulWidget {
  final List<AttachmentRead>? attachments;
  final Future<void> Function() onPressed;

  const AttachmentButton({
    super.key,
    required this.attachments,
    required this.onPressed,
  });

  @override
  State<AttachmentButton> createState() => _AttachmentButtonState();
}

class _AttachmentButtonState extends State<AttachmentButton> {
  late bool _hasAttachments;

  final Logger log = Logger("Pages.Transaction.AttachmentButton");

  @override
  void initState() {
    super.initState();

    log.finest(() => "initState()");
    _hasAttachments = widget.attachments?.isNotEmpty ?? false;
  }

  @override
  void didUpdateWidget(covariant AttachmentButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    log.finest(() => "didUpdateWidget()");
    _hasAttachments = widget.attachments?.isNotEmpty ?? false;
    log.finest(() => "_hasAttachments: $_hasAttachments");
  }

  @override
  Widget build(BuildContext context) {
    log.finest(() => "build(${widget.attachments?.length ?? "null"})");

    return badges.Badge(
      badgeContent: Text(
        widget.attachments?.length.toString() ?? "..",
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
      showBadge: _hasAttachments,
      badgeStyle: badges.BadgeStyle(
        badgeColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      badgeAnimation: const badges.BadgeAnimation.scale(
        animationDuration: animDurationEmphasized,
        curve: animCurveEmphasized,
      ),
      child: MaterialIconButton(
        icon: Icons.attach_file,
        tooltip: S.of(context).transactionAttachments,
        onPressed: _savingInProgress ? null : widget.onPressed,
      ),
    );
  }
}

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({
    super.key,
    required this.initialDateTime,
    required this.onDateTimeChanged,
  });

  final tz.TZDateTime initialDateTime;
  final ValueChanged<tz.TZDateTime> onDateTimeChanged;

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  late tz.TZDateTime _selectedDateTime;
  late TextEditingController _dateTextController;
  late TextEditingController _timeTextController;

  final Logger log = Logger("Pages.Transaction.DateTimePicker");

  @override
  void initState() {
    super.initState();

    log.finest(() => "initState()");
    _selectedDateTime = widget.initialDateTime;
    _dateTextController = TextEditingController(
      text: DateFormat.yMMMd().format(_selectedDateTime),
    );
    _timeTextController = TextEditingController(
      text: DateFormat.Hm().format(_selectedDateTime),
    );
  }

  @override
  void dispose() {
    _dateTextController.dispose();
    _timeTextController.dispose();

    super.dispose();
  }

  Future<void> _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      locale: Locale(
        Intl.defaultLocale!.split('_').first,
        Intl.defaultLocale!.split('_').last,
      ),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate == null) {
      return;
    }

    setState(() {
      _selectedDateTime = tz.TZDateTime.from(
        _selectedDateTime.copyWith(
          year: pickedDate.year,
          month: pickedDate.month,
          day: pickedDate.day,
        ),
        _selectedDateTime.location,
      );
      _dateTextController.text = DateFormat.yMMMd().format(_selectedDateTime);
      widget.onDateTimeChanged(_selectedDateTime);
    });
  }

  Future<void> _pickTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedDateTime.getTimeOfDay(),
    );

    if (pickedTime == null) {
      return;
    }

    setState(() {
      _selectedDateTime = _selectedDateTime.setTimeOfDay(pickedTime);
      _timeTextController.text = DateFormat.Hm().format(_selectedDateTime);
      widget.onDateTimeChanged(_selectedDateTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    log.finest("build()");

    return Row(
      children: <Widget>[
        IntrinsicWidth(
          child: TextFormField(
            enabled: !_savingInProgress,
            controller: _dateTextController,
            decoration: InputDecoration(
              //prefixIcon: Icon(Icons.calendar_month),
              border: const OutlineInputBorder(),
              filled: _savingInProgress,
            ),
            readOnly: true,
            onTap: _pickDate,
          ),
        ),
        const SizedBox(width: 16),
        IntrinsicWidth(
          child: TextFormField(
            enabled: !_savingInProgress,
            controller: _timeTextController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              filled: _savingInProgress,
            ),
            readOnly: true,
            onTap: _pickTime,
          ),
        ),
      ],
    );
  }
}

class TransactionHeaderSection extends StatelessWidget {
  final TransactionState tx;
  final TextEditingController totalAmountTC;
  final FocusNode totalAmountFN;
  final bool saving;
  final bool readOnly;

  const TransactionHeaderSection({
    super.key,
    required this.tx,
    required this.totalAmountTC,
    required this.totalAmountFN,
    required this.saving,
    required this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    final Logger log = Logger("Pages.Transaction.TransactionHeaderSection");

    log.finest("build()");
    final bool isSplit = tx.split;

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            _buildTitle(context, isSplit),
            const SizedBox(width: 12),
            _buildAttachmentButton(context),
          ],
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: .horizontal,
          child: Row(
            children: <Widget>[
              _buildAmount(context, isSplit),
              const SizedBox(width: 16),
              _buildDate(context),
              const SizedBox(width: 16),
              _buildTime(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTitle(BuildContext context, bool isSplit) {
    if (isSplit) {
      return TransactionTitle(
        textController: tx.groupTitleTC,
        focusNode: tx.groupTitleFN,
      );
    } else {
      final TransactionSplitState split = tx.splits.first;

      return TransactionTitle(
        textController: split.titleTC,
        focusNode: split.titleFN,
      );
    }
  }

  Widget _buildAttachmentButton(BuildContext context) {
    return badges.Badge(
      badgeContent: Text(
        tx.attachments == null ? ".." : tx.attachments!.length.toString(),
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
      showBadge: tx.hasAttachments,
      badgeStyle: badges.BadgeStyle(
        badgeColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      badgeAnimation: const badges.BadgeAnimation.scale(
        animationDuration: animDurationEmphasized,
        curve: animCurveEmphasized,
      ),
      child: MaterialIconButton(
        icon: Icons.attach_file,
        tooltip: S.of(context).transactionAttachments,
        onPressed: () async {
          final List<AttachmentRead> dialogAttachments =
              tx.attachments ?? <AttachmentRead>[];
          await showDialog<List<AttachmentRead>>(
            context: context,
            builder: (BuildContext context) => AttachmentDialog(
              attachments: dialogAttachments,
              transactionId: tx.splits.first.journalID,
            ),
          );
          tx.attachments = dialogAttachments;
        },
      ),
    );
  }

  Widget _buildAmount(BuildContext context, bool isSplit) {
    if (tx.splits.isEmpty) {
      return const SizedBox.shrink();
    }

    late final Widget input;

    if (!isSplit) {
      // SINGLE TX --> editable
      final TransactionSplitState split = tx.splits.first;

      input = _buildNumberInput(
        controller: split.localAmountTC,
        enabled: !saving && !readOnly,
        onChanged: (String val) {
          log.finest(() => "_buildAmount: onChanged($val)");
          split.localAmount = double.tryParse(val) ?? 0;
        },
        currency: tx.localCurrency,
      );
    } else {
      // SPLIT TX --> derived total (readonly)
      input = _buildNumberInput(
        controller: totalAmountTC,
        enabled: false,
        currency: tx.localCurrency,
      );
    }
    return SizedBox(width: 135, child: input);
  }

  Widget _buildNumberInput({
    required TextEditingController controller,
    required bool enabled,
    void Function(String)? onChanged,
    required CurrencyRead currency,
  }) {
    return NumberInput(
      icon: SizedBox(
        width: 24,
        height: 32,
        child: FittedBox(child: Text(currency.attributes.symbol)),
      ),
      hintText: currency.zero(),
      decimals: currency.attributes.decimalPlaces ?? 2,
      controller: controller,
      disabled: !enabled,
      onChanged: onChanged,
    );
  }

  Widget _buildDate(BuildContext context) => IntrinsicWidth(
    child: TextFormField(
      controller: tx.dateTC,
      decoration: const InputDecoration(border: OutlineInputBorder()),
      readOnly: true,
      enabled: !saving,
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: tx.date,
          locale: Locale(
            Intl.defaultLocale!.split("_").first,
            Intl.defaultLocale!.split("_").last,
          ),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );

        if (pickedDate == null) {
          return;
        }

        tx.date = tz.TZDateTime.from(
          tx.date.copyWith(
            year: pickedDate.year,
            month: pickedDate.month,
            day: pickedDate.day,
          ),
          tx.date.location,
        );
      },
    ),
  );

  Widget _buildTime(BuildContext context) => IntrinsicWidth(
    child: TextFormField(
      controller: tx.timeTC,
      decoration: const InputDecoration(border: OutlineInputBorder()),
      readOnly: true,
      enabled: !saving,
      onTap: () async {
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: tx.date.getTimeOfDay(),
        );

        if (pickedTime == null) {
          return;
        }

        tx.date = tx.date.setTimeOfDay(pickedTime);
      },
    ),
  );
}
