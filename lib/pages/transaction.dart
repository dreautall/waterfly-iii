import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:badges/badges.dart' as badges;
import 'package:chopper/chopper.dart' show HttpMethod, Response;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sharing_intent/model/sharing_file.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:version/version.dart';
import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/notificationlistener.dart';
import 'package:waterflyiii/pages/navigation.dart';
import 'package:waterflyiii/pages/transaction/attachments.dart';
import 'package:waterflyiii/pages/transaction/bill.dart';
import 'package:waterflyiii/pages/transaction/currencies.dart';
import 'package:waterflyiii/pages/transaction/delete.dart';
import 'package:waterflyiii/pages/transaction/tags.dart';
import 'package:waterflyiii/settings.dart';
import 'package:waterflyiii/stock.dart';
import 'package:waterflyiii/timezonehandler.dart';
import 'package:waterflyiii/widgets/autocompletetext.dart';
import 'package:waterflyiii/widgets/input_number.dart';
import 'package:waterflyiii/widgets/materialiconbutton.dart';

final Logger log = Logger("Pages.Transaction");

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

  // Common values
  late TransactionTypeProperty _transactionType;
  final TextEditingController _titleTextController = TextEditingController();
  final FocusNode _titleFocusNode = FocusNode();
  String? _ownAccountId;
  late tz.TZDateTime _date;
  final TextEditingController _dateTextController = TextEditingController();
  final TextEditingController _timeTextController = TextEditingController();
  CurrencyRead? _localCurrency;
  bool _reconciled = false;
  bool _initiallyReconciled = false;

  // Individual for split transactions, show common for single transaction
  final TextEditingController _sourceAccountTextController =
      TextEditingController();
  final FocusNode _sourceAccountFocusNode = FocusNode();
  AccountTypeProperty _sourceAccountType =
      AccountTypeProperty.swaggerGeneratedUnknown;
  final TextEditingController _destinationAccountTextController =
      TextEditingController();
  final FocusNode _destinationAccountFocusNode = FocusNode();
  AccountTypeProperty _destinationAccountType =
      AccountTypeProperty.swaggerGeneratedUnknown;
  final TextEditingController _localAmountTextController =
      TextEditingController();

  // Always in card view
  final List<TextEditingController> _categoryTextControllers =
      <TextEditingController>[];
  final List<FocusNode> _categoryFocusNodes = <FocusNode>[];
  final List<TextEditingController> _budgetTextControllers =
      <TextEditingController>[];
  final List<FocusNode> _budgetFocusNodes = <FocusNode>[];
  final List<Tags> _tags = <Tags>[];
  final List<TextEditingController> _tagsTextControllers =
      <TextEditingController>[];
  final List<TextEditingController> _noteTextControllers =
      <TextEditingController>[];
  final List<BillRead?> _bills = <BillRead?>[];

  // Individual for split transactions
  final List<TextEditingController> _titleTextControllers =
      <TextEditingController>[];
  final List<FocusNode> _titleFocusNodes = <FocusNode>[];
  final List<TextEditingController> _sourceAccountTextControllers =
      <TextEditingController>[];
  final List<FocusNode> _sourceAccountFocusNodes = <FocusNode>[];
  final List<TextEditingController> _destinationAccountTextControllers =
      <TextEditingController>[];
  final List<FocusNode> _destinationAccountFocusNodes = <FocusNode>[];
  final List<double> _localAmounts = <double>[];
  final List<TextEditingController> _localAmountTextControllers =
      <TextEditingController>[];
  final List<double> _foreignAmounts = <double>[];
  final List<TextEditingController> _foreignAmountTextControllers =
      <TextEditingController>[];
  final List<CurrencyRead?> _foreignCurrencies = <CurrencyRead?>[];
  final List<String?> _transactionJournalIDs = <String?>[];
  final List<String> _deletedSplitIDs = <String>[];

  bool _split = false;
  bool _hasAttachments = false;
  List<AttachmentRead>? _attachments;
  bool _txTypeChipExtended = false;
  bool _showSourceAccountSelection = false;
  bool _showDestinationAccountSelection = false;

  late bool _newTX;

  late TimeZoneHandler _tzHandler;

  // Magic moving!
  // https://m3.material.io/styles/motion/easing-and-duration/applying-easing-and-duration
  final List<AnimationController> _cardsAnimationController =
      <AnimationController>[];
  final List<Animation<double>> _cardsAnimation = <Animation<double>>[];

  bool _saving = false;

  @override
  void initState() {
    super.initState();

    _newTX = widget.transaction == null || widget.clone;

    _tzHandler = context.read<FireflyService>().tzHandler;

    // opening an existing transaction, extract information
    if (widget.transaction != null) {
      TransactionRead transaction = widget.transaction!;
      List<TransactionSplit> transactions = transaction.attributes.transactions;

      // Common values
      /// type
      _transactionType = transactions.first.type;

      /// title
      if (transaction.attributes.groupTitle?.isNotEmpty ?? false) {
        _titleTextController.text = transaction.attributes.groupTitle!;
      } else {
        _titleTextController.text = transactions.first.description;
      }

      /// own account
      switch (_transactionType) {
        case TransactionTypeProperty.withdrawal:
        case TransactionTypeProperty.transfer:
          _ownAccountId = transactions.first.sourceId;
          break;
        case TransactionTypeProperty.deposit:
        case TransactionTypeProperty.openingBalance:
        case TransactionTypeProperty.reconciliation:
          _ownAccountId = transactions.first.destinationId;
          break;
        default:
      }

      /// date
      _date = _tzHandler.sTime(transactions.first.date).toLocal();

      /// account currency
      _localCurrency = CurrencyRead(
        type: "currencies",
        id: transactions.first.currencyId!,
        attributes: Currency(
          code: transactions.first.currencyCode!,
          name: transactions.first.currencyName!,
          symbol: transactions.first.currencySymbol!,
          decimalPlaces: transactions.first.currencyDecimalPlaces,
        ),
      );

      // Reconciled
      _reconciled = transactions.first.reconciled ?? false;

      for (TransactionSplit trans in transactions) {
        // Always in card view
        /// Category
        _categoryTextControllers.add(
          TextEditingController(text: trans.categoryName),
        );
        _categoryFocusNodes.add(FocusNode());

        //// Budget
        _budgetTextControllers.add(
          TextEditingController(text: trans.budgetName),
        );
        _budgetFocusNodes.add(FocusNode());

        /// Tags
        _tags.add(Tags(trans.tags ?? <String>[]));
        _tagsTextControllers.add(
          TextEditingController(text: (_tags.last.tags.isNotEmpty) ? " " : ""),
        );

        /// Notes
        _noteTextControllers.add(TextEditingController(text: trans.notes));

        /// Bill
        if ((trans.billId?.isNotEmpty ?? false) && trans.billId != "0") {
          _bills.add(
            BillRead(
              type: "bill",
              id: trans.billId ?? "",
              attributes: Bill(
                name: trans.billName ?? "",
                amountMin: "",
                amountMax: "",
                date: DateTime.now(),
                repeatFreq: BillRepeatFrequency.swaggerGeneratedUnknown,
              ),
            ),
          );
        } else {
          _bills.add(null);
        }

        // Individual for split transactions
        /// Title
        _titleTextControllers.add(
          TextEditingController(text: trans.description),
        );
        _titleFocusNodes.add(FocusNode());

        /// local amount
        _localAmounts.add(double.tryParse(trans.amount) ?? 0);
        _localAmountTextControllers.add(
          TextEditingController(
            text: _localAmounts.last.toStringAsFixed(
              trans.currencyDecimalPlaces ?? 2,
            ),
          ),
        );

        /// source account
        _sourceAccountTextControllers.add(
          TextEditingController(text: trans.sourceName),
        );
        _sourceAccountFocusNodes.add(FocusNode());
        _sourceAccountType = trans.sourceType!;

        /// target account
        _destinationAccountTextControllers.add(
          TextEditingController(text: trans.destinationName),
        );
        _destinationAccountFocusNodes.add(FocusNode());
        _destinationAccountType = trans.destinationType!;

        /// foreign currency
        //// foreign amount
        _foreignAmounts.add(double.tryParse(trans.foreignAmount ?? '') ?? 0);
        _foreignAmountTextControllers.add(
          TextEditingController(
            text: _foreignAmounts.last.toStringAsFixed(
              trans.foreignCurrencyDecimalPlaces ?? 2,
            ),
          ),
        );
        //// foreign currency
        if (trans.foreignCurrencyCode?.isNotEmpty ?? false) {
          _foreignCurrencies.add(
            CurrencyRead(
              type: "currencies",
              id: trans.foreignCurrencyId!,
              attributes: Currency(
                code: trans.foreignCurrencyCode!,
                name: "", // empty
                symbol: trans.foreignCurrencySymbol!,
                decimalPlaces: trans.foreignCurrencyDecimalPlaces,
              ),
            ),
          );
        } else {
          _foreignCurrencies.add(null);
        }

        //// Journal ID
        _transactionJournalIDs.add(trans.transactionJournalId);

        //// Attachments
        _hasAttachments = _hasAttachments || (trans.hasAttachments ?? false);

        // Card Animations
        _cardsAnimationController.add(
          AnimationController(
            // height 1 = visible - enter = fwd (0->1), exit = reverse (1->0)
            value: 1.0,
            duration: animDurationEmphasizedDecelerate,
            reverseDuration: animDurationEmphasizedDecelerate,
            vsync: this,
          ),
        );
        int i = _cardsAnimationController.length - 1;
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

      // Individual for split transactions, show common for single transaction
      WidgetsBinding.instance.addPostFrameCallback((_) {
        updateTransactionAmounts();
        splitTransactionCheckAccounts();
      });

      // Firefly v6.0.30 (API v2.0.11) and up:
      // API will no longer accept changes to amount and account fields for reconciled transactions
      if (_reconciled &&
          context.read<FireflyService>().apiVersion! >= Version(2, 0, 11)) {
        _initiallyReconciled = true;
      }

      _split = (_localAmounts.length > 1);
    } else {
      // New transaction
      _titleFocusNode.requestFocus();
      _transactionType = TransactionTypeProperty.swaggerGeneratedUnknown;
      _date = _tzHandler.newTXTime().toLocal();

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        splitTransactionAdd();

        // Extract notification
        if (widget.notification != null) {
          final FireflyIii api = context.read<FireflyService>().api;
          final SettingsProvider settings = context.read<SettingsProvider>();

          log.info("Got notification ${widget.notification?.title}");
          _transactionType = TransactionTypeProperty.withdrawal;
          final CurrencyRead defaultCurrency =
              context.read<FireflyService>().defaultCurrency;
          late CurrencyRead? currency;
          late double amount;

          (currency, amount) = await parseNotificationText(
            api,
            widget.notification!.body,
            _localCurrency!,
          );

          // Fallback solution
          currency ??= defaultCurrency;

          // Set date
          _date =
              _tzHandler
                  .notificationTXTime(widget.notification!.date)
                  .toLocal();
          _dateTextController.text = DateFormat.yMMMd().format(_date);
          _timeTextController.text = DateFormat.Hm().format(_date);

          // Title & Note
          final NotificationAppSettings appSettings = await settings
              .notificationGetAppSettings(widget.notification!.appName);
          if (appSettings.includeTitle) {
            _titleTextController.text = widget.notification!.title;
          } else {
            _titleTextController.text = "";
            _noteTextControllers[0].text =
                "${widget.notification!.title} - ${_noteTextControllers[0].text}";
          }

          if (!appSettings.emptyNote) {
            _noteTextControllers[0].text = widget.notification!.body;
          }

          // Check account
          final Response<AccountArray> response = await api.v1AccountsGet(
            type: AccountTypeFilter.assetAccount,
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
              _sourceAccountTextController.text = acc.attributes.name;
              _ownAccountId = acc.id;
              _sourceAccountType = AccountTypeProperty.assetAccount;
              if (currency.id == acc.attributes.currencyId) {
                _localCurrency = currency;
              } else {
                _localCurrency = CurrencyRead(
                  type: "currencies",
                  id: acc.attributes.currencyId!,
                  attributes: Currency(
                    code: acc.attributes.currencyCode!,
                    name: "",
                    symbol: acc.attributes.currencySymbol!,
                    decimalPlaces: acc.attributes.currencyDecimalPlaces,
                  ),
                );
                _foreignCurrencies[0] = currency;
              }
              break;
            }
          }

          // Check currency
          if (currency == _localCurrency) {
            _localAmounts[0] = amount;
            _localAmountTextController.text = amount.toStringAsFixed(
              currency.attributes.decimalPlaces ?? 2,
            );
          } else {
            _foreignCurrencies[0] = currency;
            _foreignAmounts[0] = amount;
            _foreignAmountTextControllers[0].text = amount.toStringAsFixed(
              currency.attributes.decimalPlaces ?? 2,
            );
          }

          setState(() {
            checkTXType();
          });
        }
        // Created from account screen, set account already
        if (widget.accountId != null && mounted) {
          // Check account
          final Response<AccountArray> response = await context
              .read<FireflyService>()
              .api
              .v1AccountsGet(type: AccountTypeFilter.assetAccount);
          if (!response.isSuccessful || response.body == null) {
            log.warning("api account fetch failed");
            return;
          }
          for (AccountRead acc in response.body!.data) {
            if (acc.id == widget.accountId) {
              _sourceAccountTextController.text = acc.attributes.name;
              _sourceAccountType = AccountTypeProperty.assetAccount;
              _ownAccountId = acc.id;
              break;
            }
          }
        }
        // Created from a file share to app
        if (widget.files != null && widget.files!.isNotEmpty) {
          _attachments = <AttachmentRead>[];
          for (SharedFile file in widget.files!) {
            if (file.value == null || file.value!.isEmpty) {
              continue;
            }
            final XFile xfile = XFile(file.value!);
            _attachments!.add(
              AttachmentRead(
                type: "attachments",
                id: _attachments!.length.toString(),
                attributes: Attachment(
                  attachableType: AttachableType.transactionjournal,
                  attachableId: "FAKE",
                  filename: xfile.name,
                  uploadUrl: xfile.path,
                  size: await xfile.length(),
                ),
                links: const ObjectLink(),
              ),
            );
          }
          _hasAttachments = _attachments!.isNotEmpty;
        }
      });
    }

    // If we're cloning, unset some values
    if (widget.clone) {
      _date = _tzHandler.newTXTime().toLocal();
      _reconciled = false;
      _initiallyReconciled = false;
      _transactionJournalIDs.forEachIndexed(
        (int i, _) => _transactionJournalIDs[i] = null,
      );
      _hasAttachments = false;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _dateTextController.text = DateFormat.yMMMd().format(_date);
      _timeTextController.text = DateFormat.Hm().format(_date);
    });
  }

  @override
  void dispose() {
    _titleTextController.dispose();
    _titleFocusNode.dispose();
    _sourceAccountTextController.dispose();
    _sourceAccountFocusNode.dispose();
    _destinationAccountTextController.dispose();
    _destinationAccountFocusNode.dispose();
    _dateTextController.dispose();
    _timeTextController.dispose();
    _localAmountTextController.dispose();

    for (TextEditingController t in _sourceAccountTextControllers) {
      t.dispose();
    }
    for (FocusNode f in _sourceAccountFocusNodes) {
      f.dispose();
    }
    for (TextEditingController t in _destinationAccountTextControllers) {
      t.dispose();
    }
    for (FocusNode f in _destinationAccountFocusNodes) {
      f.dispose();
    }
    for (TextEditingController t in _categoryTextControllers) {
      t.dispose();
    }
    for (FocusNode f in _categoryFocusNodes) {
      f.dispose();
    }
    for (TextEditingController t in _budgetTextControllers) {
      t.dispose();
    }
    for (FocusNode f in _budgetFocusNodes) {
      f.dispose();
    }
    for (TextEditingController t in _tagsTextControllers) {
      t.dispose();
    }
    for (TextEditingController t in _noteTextControllers) {
      t.dispose();
    }
    for (TextEditingController t in _titleTextControllers) {
      t.dispose();
    }
    for (FocusNode f in _titleFocusNodes) {
      f.dispose();
    }
    for (TextEditingController t in _localAmountTextControllers) {
      t.dispose();
    }
    for (TextEditingController t in _foreignAmountTextControllers) {
      t.dispose();
    }

    for (AnimationController a in _cardsAnimationController) {
      a.dispose();
    }

    super.dispose();
  }

  void updateTransactionAmounts() {
    // Individual for split transactions, show common for single transaction
    /// local amount
    if (_localAmounts.sum != 0) {
      _localAmountTextController.text = _localAmounts.sum.toStringAsFixed(
        _localCurrency?.attributes.decimalPlaces ?? 2,
      );
    } else {
      _localAmountTextController.text = "";
    }
  }

  void Function(AnimationStatus) deleteCardAnimated(int i) {
    return (AnimationStatus status) {
      if (status == AnimationStatus.dismissed) {
        splitTransactionRemove(i);
      }
    };
  }

  void splitTransactionRemove(int i) {
    log.fine(() => "removing split $i");
    if (_localAmounts.length < i || _localAmounts.length == 1) {
      log.finer(() => "can't remove, last item");
      return;
    }

    // this we need to dispose later
    TextEditingController t1 = _sourceAccountTextControllers.removeAt(i);
    FocusNode f1 = _sourceAccountFocusNodes.removeAt(i);
    TextEditingController t2 = _destinationAccountTextControllers.removeAt(i);
    FocusNode f2 = _destinationAccountFocusNodes.removeAt(i);
    TextEditingController t3 = _categoryTextControllers.removeAt(i);
    FocusNode f3 = _categoryFocusNodes.removeAt(i);
    TextEditingController t4 = _budgetTextControllers.removeAt(i);
    FocusNode f4 = _budgetFocusNodes.removeAt(i);
    _tags.removeAt(i);
    TextEditingController t5 = _tagsTextControllers.removeAt(i);
    TextEditingController t6 = _noteTextControllers.removeAt(i);
    _bills.removeAt(i);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      t1.dispose();
      f1.dispose();
      t2.dispose();
      f2.dispose();
      t3.dispose();
      f3.dispose();
      t4.dispose();
      f4.dispose();
      t5.dispose();
      t6.dispose();
    });

    _titleTextControllers.removeAt(i).dispose();
    _titleFocusNodes.removeAt(i).dispose();
    _localAmounts.removeAt(i);
    _localAmountTextControllers.removeAt(i).dispose();
    _foreignAmounts.removeAt(i);
    _foreignAmountTextControllers.removeAt(i).dispose();
    _foreignCurrencies.removeAt(i);
    _deletedSplitIDs.add(_transactionJournalIDs.elementAtOrNull(i) ?? "");
    _transactionJournalIDs.removeAt(i);

    _cardsAnimationController.removeAt(i).dispose();
    _cardsAnimation.removeAt(i);

    // Update summary values
    updateTransactionAmounts();
    if (_localAmounts.length == 1) {
      // This is similar to the web interface --> summary text gets deleted when split is removed.
      if (_titleTextControllers.first.text.isNotEmpty) {
        _titleTextController.text = _titleTextControllers.first.text;
      }
    }
    // Check if Source/Destination account selection should still be shown
    if (_sourceAccountTextControllers.every(
      (TextEditingController e) =>
          e.text == _sourceAccountTextControllers.first.text,
    )) {
      _showSourceAccountSelection = false;
    }
    if (_destinationAccountTextControllers.every(
      (TextEditingController e) =>
          e.text == _destinationAccountTextControllers.first.text,
    )) {
      _showDestinationAccountSelection = false;
    }
    splitTransactionCheckAccounts();

    // Redo animationcallbacks due to new "i"s
    for (int i = 0; i < _cardsAnimationController.length; i++) {
      // ignore: invalid_use_of_protected_member
      _cardsAnimationController[i].clearStatusListeners();
      _cardsAnimationController[i].addStatusListener(
        (AnimationStatus status) => deleteCardAnimated(i)(status),
      );
    }

    log.finer(() => "remaining split #: ${_localAmounts.length}");

    setState(() {
      // As firefly doesn't allow editing accounts or sums when reconciled,
      // deactivate reconciled.
      _initiallyReconciled = false;
      _split = (_localAmounts.length > 1);
    });
  }

  void splitTransactionAdd() {
    log.fine(() => "adding split");
    // Update from summary to first when first split is added
    if (_localAmounts.length == 1) {
      _localAmountTextControllers.first.text = _localAmountTextController.text;
    }

    _sourceAccountTextControllers.add(
      TextEditingController(
        text: _sourceAccountTextControllers.firstOrNull?.text,
      ),
    );
    _sourceAccountFocusNodes.add(FocusNode());
    _destinationAccountTextControllers.add(
      TextEditingController(
        text: _destinationAccountTextControllers.firstOrNull?.text,
      ),
    );
    _destinationAccountFocusNodes.add(FocusNode());
    _categoryTextControllers.add(TextEditingController());
    _categoryFocusNodes.add(FocusNode());
    _budgetTextControllers.add(TextEditingController());
    _budgetFocusNodes.add(FocusNode());
    _tags.add(Tags());
    _tagsTextControllers.add(TextEditingController());
    _noteTextControllers.add(TextEditingController());
    _bills.add(null);

    _titleTextControllers.add(TextEditingController());
    _titleFocusNodes.add(FocusNode());
    _localAmounts.add(0);
    _localAmountTextControllers.add(TextEditingController());
    _foreignAmounts.add(0);
    _foreignAmountTextControllers.add(TextEditingController());
    _foreignCurrencies.add(_foreignCurrencies.firstOrNull);
    _transactionJournalIDs.add(null);

    _cardsAnimationController.add(
      AnimationController(
        // height 0 = invisible - enter = fwd (0->1), exit = reverse (1->0)
        value: 0.0,
        duration: animDurationEmphasizedDecelerate,
        reverseDuration: animDurationEmphasizedAccelerate,
        vsync: this,
      ),
    );
    int i = _cardsAnimationController.length - 1;
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

    log.finer(() => "new split #: ${_localAmounts.length}");

    setState(() {
      // As firefly doesn't allow editing accounts or sums when reconciled,
      // deactivate reconciled.
      _initiallyReconciled = false;
      _split = (_localAmounts.length > 1);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cardsAnimationController.last.forward();
    });
  }

  void splitTransactionCalculateAmount() {
    _localAmountTextController.text = _localAmounts.sum.toStringAsFixed(
      _localCurrency?.attributes.decimalPlaces ?? 2,
    );
  }

  void splitTransactionCheckAccounts() {
    bool update = false;

    if (_sourceAccountTextControllers.every(
      (TextEditingController e) =>
          e.text == _sourceAccountTextControllers.first.text,
    )) {
      if (_sourceAccountTextController.text !=
              _sourceAccountTextControllers.first.text &&
          _sourceAccountTextControllers.first.text.isNotEmpty) {
        _sourceAccountTextController.text =
            _sourceAccountTextControllers.first.text;
        update = true;
      }
    } else {
      if (_sourceAccountTextController.text !=
          "<${S.of(context).generalMultiple}>") {
        _sourceAccountTextController.text =
            "<${S.of(context).generalMultiple}>";
        update = true;
      }
    }
    if (_destinationAccountTextControllers.every(
      (TextEditingController e) =>
          e.text == _destinationAccountTextControllers.first.text,
    )) {
      if (_destinationAccountTextController.text !=
              _destinationAccountTextControllers.first.text &&
          _destinationAccountTextControllers.first.text.isNotEmpty) {
        _destinationAccountTextController.text =
            _destinationAccountTextControllers.first.text;
        update = true;
      }
    } else {
      if (_destinationAccountTextController.text !=
          "<${S.of(context).generalMultiple}>") {
        _destinationAccountTextController.text =
            "<${S.of(context).generalMultiple}>";
        update = true;
      }
    }

    // Withdrawal: splits have common source account --> show only target
    // Deposit: splits have common destination account --> show only source
    // Transfer: splits have common accounts for both --> show nothing
    final bool prevShowSource = _showSourceAccountSelection;
    final bool prevShowDest = _showDestinationAccountSelection;
    _showSourceAccountSelection =
        _transactionType == TransactionTypeProperty.deposit &&
        _sourceAccountTextControllers.every(
          (TextEditingController e) =>
              e.text != _sourceAccountTextController.text,
        );
    _showDestinationAccountSelection =
        _transactionType == TransactionTypeProperty.withdrawal &&
        _destinationAccountTextControllers.every(
          (TextEditingController e) =>
              e.text != _destinationAccountTextController.text,
        );
    if (prevShowSource != _showSourceAccountSelection ||
        prevShowDest != _showDestinationAccountSelection) {
      update = true;
    }

    if (update) {
      setState(() {});
    }
  }

  void updateAttachmentCount() async {
    try {
      final FireflyIii api = context.read<FireflyService>().api;
      final Response<AttachmentArray> response = await api
          .v1TransactionsIdAttachmentsGet(id: widget.transaction?.id);
      apiThrowErrorIfEmpty(response, mounted ? context : null);

      _attachments = response.body!.data;
      setState(() {
        _hasAttachments = _attachments?.isNotEmpty ?? false;
      });
    } catch (e, stackTrace) {
      log.severe("Error while fetching autocomplete from API", e, stackTrace);
    }
  }

  @override
  Widget build(BuildContext context) {
    log.finest(() => "build()");
    _localCurrency ??= context.read<FireflyService>().defaultCurrency;

    if (_hasAttachments && _attachments == null) {
      updateAttachmentCount();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _newTX
              ? S.of(context).transactionTitleAdd
              : S.of(context).transactionTitleEdit,
        ),
        actions: <Widget>[
          if (!_newTX) ...<Widget>[
            TransactionDeleteButton(transactionId: widget.transaction?.id),
            const SizedBox(width: 8),
          ],
          FilledButton(
            onPressed:
                _saving
                    ? null
                    : () async {
                      final ScaffoldMessengerState msg = ScaffoldMessenger.of(
                        context,
                      );
                      final NavigatorState nav = Navigator.of(context);
                      final FireflyIii api = context.read<FireflyService>().api;
                      final AuthUser? user =
                          context.read<FireflyService>().user;
                      final TransStock? stock =
                          context.read<FireflyService>().transStock;

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
                      if (_transactionType ==
                          TransactionTypeProperty.swaggerGeneratedUnknown) {
                        error = S.of(context).transactionErrorNoAccounts;
                      }
                      if (error != null) {
                        msg.showSnackBar(
                          SnackBar(
                            content: Text(error),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        return;
                      }
                      // Do stuff
                      setState(() {
                        _saving = true;
                      });
                      late Response<TransactionSingle> resp;

                      // Update existing transaction
                      if (!_newTX) {
                        String id = widget.transaction!.id;
                        List<TransactionSplitUpdate> txS =
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
                            destinationName =
                                _destinationAccountTextController.text;
                          }

                          final TransactionSplitUpdate
                          txSs = TransactionSplitUpdate(
                            amount: _localAmounts[i].toString(),
                            billId: _bills[i]?.id ?? "0",
                            budgetName:
                                (_transactionType ==
                                        TransactionTypeProperty.withdrawal)
                                    ? _budgetTextControllers[i].text
                                    : "",
                            categoryName: _categoryTextControllers[i].text,
                            date: _date,
                            description:
                                _split
                                    ? _titleTextControllers[i].text
                                    : _titleTextController.text,
                            destinationName: destinationName,
                            // :HAX: Since nulled fields are not submitted, we set
                            // the value to 0 so the foreign currency is gone...
                            foreignAmount:
                                _foreignCurrencies[i] != null
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
                        TransactionUpdate txUpdate = TransactionUpdate(
                          groupTitle: _split ? _titleTextController.text : null,
                          transactions: txS,
                        );
                        // Delete old splits
                        for (String id in _deletedSplitIDs) {
                          if (id.isEmpty) {
                            continue;
                          }
                          log.fine(() => "deleting split $id");
                          await api.v1TransactionJournalsIdDelete(id: id);
                        }
                        resp = await api.v1TransactionsIdPut(
                          id: id,
                          body: txUpdate,
                        );
                      } else {
                        // New transaction
                        List<TransactionSplitStore> txS =
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
                            destinationName =
                                _destinationAccountTextController.text;
                          }

                          txS.add(
                            TransactionSplitStore(
                              type: _transactionType,
                              date: _date,
                              amount: _localAmounts[i].toString(),
                              description:
                                  _split
                                      ? _titleTextControllers[i].text
                                      : _titleTextController.text,
                              billId: _bills[i]?.id ?? "0",
                              budgetName:
                                  (_transactionType ==
                                          TransactionTypeProperty.withdrawal)
                                      ? _budgetTextControllers[i].text
                                      : "",
                              categoryName: _categoryTextControllers[i].text,
                              destinationName: destinationName,
                              // :HAX: Since nulled fields are not submitted, we set
                              // the value to 0 so the foreign currency is gone...
                              foreignAmount:
                                  _foreignCurrencies[i] != null
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
                          ValidationErrorResponse valError =
                              ValidationErrorResponse.fromJson(
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
                          error =
                              context.mounted
                                  // ignore: use_build_context_synchronously
                                  ? S.of(context).errorUnknown
                                  : "[nocontext] Unknown error.";
                        }

                        msg.showSnackBar(
                          SnackBar(
                            content: Text(error),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        setState(() {
                          _saving = false;
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
                        TransactionSplit? tx = resp
                            .body
                            ?.data
                            .attributes
                            .transactions
                            .firstWhereOrNull(
                              (TransactionSplit e) =>
                                  e.transactionJournalId != null,
                            );
                        if (tx != null) {
                          String txId = tx.transactionJournalId!;
                          log.finest(() => "uploading to txId $txId");
                          for (AttachmentRead attachment in _attachments!) {
                            log.finest(
                              () =>
                                  "uploading attachment ${attachment.id}: ${attachment.attributes.filename}",
                            );
                            final Response<AttachmentSingle> respAttachment =
                                await api.v1AttachmentsPost(
                                  body: AttachmentStore(
                                    filename: attachment.attributes.filename,
                                    attachableType:
                                        AttachableType.transactionjournal,
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
                            log.finest(
                              () => "attachment id is ${newAttachment.id}",
                            );

                            final File file = File(
                              attachment.attributes.uploadUrl!,
                            );

                            final http.StreamedRequest request =
                                http.StreamedRequest(
                                  HttpMethod.Post,
                                  Uri.parse(
                                    newAttachment.attributes.uploadUrl!,
                                  ),
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
                        SystemChannels.platform.invokeMethod(
                          'SystemNavigator.pop',
                        );
                        nav.pushReplacement(
                          MaterialPageRoute<bool>(
                            builder: (BuildContext context) => const NavPage(),
                          ),
                        );
                      }
                    },
            child: Text(MaterialLocalizations.of(context).saveButtonLabel),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          cacheExtent: 10000,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          children: _transactionDetailBuilder(context),
        ),
      ),
    );
  }

  List<Widget> _transactionDetailBuilder(BuildContext context) {
    log.fine(() => "transactionDetailBuilder()");
    log.finer(() => "splits: ${_localAmounts.length}, split? $_split");

    List<Widget> childs = <Widget>[];
    const Widget hDivider = SizedBox(height: 16);
    const Widget vDivider = SizedBox(width: 16);

    CancelableOperation<Response<AutocompleteAccountArray>>? fetchOpSource;
    CancelableOperation<Response<AutocompleteAccountArray>>? fetchOpDestination;

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
                List<AttachmentRead> dialogAttachments =
                    _attachments ?? <AttachmentRead>[];
                await showDialog<List<AttachmentRead>>(
                  context: context,
                  builder:
                      (BuildContext context) => AttachmentDialog(
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
      SizedBox(
        height:
            64, // 64 is measured height from layout inspector of a normal row.
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(
              width: 130,
              child: NumberInput(
                icon:
                    _localCurrency != null
                        ? SizedBox(
                          width: 24,
                          height: 32,
                          child: FittedBox(
                            child: Text(_localCurrency!.attributes.symbol),
                          ),
                        )
                        : Icon(Icons.monetization_on),
                hintText:
                    _localCurrency?.zero() ??
                    NumberFormat.currency(decimalDigits: 2).format(0),
                decimals: _localCurrency?.attributes.decimalPlaces ?? 2,
                //style: Theme.of(context).textTheme.headlineLarge,
                controller: _localAmountTextController,
                disabled: _split || (_reconciled && _initiallyReconciled),
                onChanged:
                    (String string) =>
                        _localAmounts[0] = double.tryParse(string) ?? 0,
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
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
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
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
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
    childs.add(hDivider);

    // Source Account, floating type element
    childs.add(
      Stack(
        children: <Widget>[
          const SizedBox(height: 64 + 16 + 64), // Padding for Stack
          Row(
            children: <Widget>[
              const Icon(Icons.arrow_back),
              vDivider,
              Expanded(
                child: AutoCompleteText<AutocompleteAccount>(
                  labelText: S.of(context).generalSourceAccount,
                  //labelIcon: Icons.account_balance,
                  textController: _sourceAccountTextController,
                  focusNode: _sourceAccountFocusNode,
                  /*errorText:
                  _transactionType == TransactionTypeProperty.withdrawal &&
                          _sourceAccountId == null
                      ? S.of(context).transactionErrorInvalidAccount
                      : null,*/
                  errorIconOnly: true,
                  onChanged: (_) {
                    // Reset own account & account type when changed
                    if (_sourceAccountType ==
                            AccountTypeProperty.assetAccount ||
                        _sourceAccountType == AccountTypeProperty.debt) {
                      _ownAccountId = null;
                    }
                    _sourceAccountType =
                        AccountTypeProperty.swaggerGeneratedUnknown;
                    checkTXType();
                  },
                  onSelected: (AutocompleteAccount option) {
                    for (TextEditingController e
                        in _sourceAccountTextControllers) {
                      e.text = option.name;
                    }
                    _sourceAccountType = AccountTypeProperty.values.firstWhere(
                      (AccountTypeProperty e) => e.value == option.type,
                      orElse: () => AccountTypeProperty.swaggerGeneratedUnknown,
                    );
                    log.finer(
                      () =>
                          "selected source account ${option.name}, type ${_sourceAccountType.toString()} (${option.type})",
                    );
                    if (_sourceAccountType ==
                            AccountTypeProperty.assetAccount ||
                        _sourceAccountType == AccountTypeProperty.debt) {
                      _ownAccountId = option.id;
                    }
                    checkTXType();
                    checkAccountCurrency(option, true);
                  },
                  displayStringForOption:
                      (AutocompleteAccount option) => option.name,
                  optionsBuilder: (TextEditingValue textEditingValue) async {
                    try {
                      fetchOpSource?.cancel();

                      final FireflyIii api = context.read<FireflyService>().api;
                      fetchOpSource = CancelableOperation<
                        Response<AutocompleteAccountArray>
                      >.fromFuture(
                        api.v1AutocompleteAccountsGet(
                          query: textEditingValue.text,
                          types: _destinationAccountType.allowedOpposingTypes(
                            false,
                          ),
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
                      (_reconciled && _initiallyReconciled) ||
                      _sourceAccountTextController.text ==
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
                const Icon(Icons.arrow_forward),
                vDivider,
                Expanded(
                  child: AutoCompleteText<AutocompleteAccount>(
                    labelText: S.of(context).generalDestinationAccount,
                    textController: _destinationAccountTextController,
                    focusNode: _destinationAccountFocusNode,
                    /*errorText: _transactionType == TransactionTypeProperty.deposit &&
                      _destinationAccountId == null
                  ? S.of(context).transactionErrorInvalidAccount
                  : null,*/
                    onChanged: (String val) {
                      for (TextEditingController e
                          in _destinationAccountTextControllers) {
                        e.text = val;
                      }

                      // Reset own account & account type when changed
                      if (_destinationAccountType ==
                              AccountTypeProperty.assetAccount ||
                          _destinationAccountType == AccountTypeProperty.debt) {
                        _ownAccountId = null;
                      }
                      _destinationAccountType =
                          AccountTypeProperty.swaggerGeneratedUnknown;
                      checkTXType();
                    },
                    errorIconOnly: true,
                    displayStringForOption:
                        (AutocompleteAccount option) => option.name,
                    onSelected: (AutocompleteAccount option) {
                      for (TextEditingController e
                          in _destinationAccountTextControllers) {
                        e.text = option.name;
                      }
                      _destinationAccountType = AccountTypeProperty.values
                          .firstWhere(
                            (AccountTypeProperty e) => e.value == option.type,
                            orElse:
                                () =>
                                    AccountTypeProperty.swaggerGeneratedUnknown,
                          );
                      if (_destinationAccountType ==
                              AccountTypeProperty.assetAccount ||
                          _destinationAccountType == AccountTypeProperty.debt) {
                        _ownAccountId = option.id;
                      }
                      log.finer(
                        () =>
                            "selected destination account ${option.name}, type ${_destinationAccountType.toString()} (${option.type})",
                      );
                      checkTXType();
                      checkAccountCurrency(option, false);
                    },
                    optionsBuilder: (TextEditingValue textEditingValue) async {
                      try {
                        fetchOpDestination?.cancel();

                        final FireflyIii api =
                            context.read<FireflyService>().api;
                        fetchOpDestination = CancelableOperation<
                          Response<AutocompleteAccountArray>
                        >.fromFuture(
                          api.v1AutocompleteAccountsGet(
                            query: textEditingValue.text,
                            types: _sourceAccountType.allowedOpposingTypes(
                              true,
                            ),
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
                        (_reconciled && _initiallyReconciled) ||
                        _destinationAccountTextController.text ==
                            "<${S.of(context).generalMultiple}>",
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: (64 + 16 + 64 - 56) / 2,
            right: 15,
            child: FloatingActionButton.extended(
              extendedIconLabelSpacing: _txTypeChipExtended ? 10 : 0,
              extendedPadding:
                  _txTypeChipExtended ? null : const EdgeInsets.all(16),
              onPressed: null,
              label: AnimatedSize(
                duration: animDurationEmphasized,
                curve: animCurveEmphasized,
                child:
                    _txTypeChipExtended
                        ? Text(_transactionType.friendlyName(context))
                        : const SizedBox(),
              ),
              icon: Icon(_transactionType.verticalIcon),
              backgroundColor: _transactionType.color,
            ),
          ),
        ],
      ),
    );
    childs.add(hDivider);
    // Cards with (Split Title), Category, (Split Amount), Tags, Notes
    for (int i = 0; i < _localAmounts.length; i++) {
      childs.add(
        SizeTransition(
          sizeFactor: _cardsAnimation[i],
          axis: Axis.vertical,
          child: _buildSplitWidget(context, i),
        ),
      );
    }
    childs.add(hDivider);
    childs.add(
      FilledButton.icon(
        onPressed:
            () =>
                _reconciled && _initiallyReconciled
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
    if ((isSource &&
            (_sourceAccountType == AccountTypeProperty.assetAccount ||
                _sourceAccountType == AccountTypeProperty.debt)) ||
        (!isSource &&
            (_destinationAccountType == AccountTypeProperty.assetAccount ||
                _destinationAccountType == AccountTypeProperty.debt) &&
            (_sourceAccountType != AccountTypeProperty.assetAccount &&
                _sourceAccountType != AccountTypeProperty.debt)) ||
        (_sourceAccountType == AccountTypeProperty.swaggerGeneratedUnknown ||
            _destinationAccountType ==
                AccountTypeProperty.swaggerGeneratedUnknown)) {
      if (_localCurrency?.id != option.currencyId.toString()) {
        setState(() {
          _localCurrency = CurrencyRead(
            type: "currencies",
            id: option.currencyId.toString(),
            attributes: Currency(
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
            (_destinationAccountType == AccountTypeProperty.assetAccount ||
                _destinationAccountType == AccountTypeProperty.debt) &&
            (_sourceAccountType == AccountTypeProperty.assetAccount ||
                _destinationAccountType == AccountTypeProperty.debt)) &&
        _localCurrency?.id != option.currencyId) {
      // Only when destination & source account have different currency
      if (!_foreignCurrencies.every(
        (CurrencyRead? e) => e?.id == option.currencyId,
      )) {
        setState(() {
          _foreignCurrencies.fillRange(
            0,
            _foreignCurrencies.length,
            CurrencyRead(
              type: "currencies",
              id: option.currencyId,
              attributes: Currency(
                code: option.currencyCode,
                name: option.currencyName,
                symbol: option.currencySymbol,
                decimalPlaces: option.currencyDecimalPlaces,
              ),
            ),
          );
        });
      }
    }
  }

  void checkTXType() {
    log.finest(() => "checkTXType()");

    TransactionTypeProperty txType = accountsToTransaction(
      _sourceAccountType,
      _destinationAccountType,
    );
    /* WATERFLY CUSTOM - NOT FIREFLY BEHAVIOR!
     * To ease UX, two assumptions:
     * 1. If only source is entered & it's an asset/liability account, it'll be
     *    a withdrawal
     * 2. If only destination is entered & it's an asset/liability account,
     *    it'll be a deposit
     *
     * As _ownAccountId will be set for both of these scenarios, the other one
     * would potentially be created by FF3 when saving. The actual webinterface
     * only does this when saving (but also throws an error when no ownAccount
     * is explicitly selected from the dropdown! Just typing the name [just as
     * in this app] will throw an error!).
     */

    if (txType == TransactionTypeProperty.swaggerGeneratedUnknown &&
        (_sourceAccountType == AccountTypeProperty.assetAccount ||
            _sourceAccountType == AccountTypeProperty.debt) &&
        _destinationAccountType ==
            AccountTypeProperty.swaggerGeneratedUnknown) {
      txType = TransactionTypeProperty.withdrawal;
    } else if (txType == TransactionTypeProperty.swaggerGeneratedUnknown &&
        _sourceAccountType == AccountTypeProperty.swaggerGeneratedUnknown &&
        (_destinationAccountType == AccountTypeProperty.assetAccount ||
            _destinationAccountType == AccountTypeProperty.debt)) {
      txType = TransactionTypeProperty.deposit;
    }

    // Withdrawal: splits have common source account
    // Deposit: splits have common destination account
    // Transfer: splits have common accounts for both
    if (txType == TransactionTypeProperty.withdrawal ||
        txType == TransactionTypeProperty.transfer) {
      for (TextEditingController e in _sourceAccountTextControllers) {
        e.text = _sourceAccountTextController.text;
      }
    }
    if (txType == TransactionTypeProperty.deposit ||
        txType == TransactionTypeProperty.transfer) {
      for (TextEditingController e in _destinationAccountTextControllers) {
        e.text = _destinationAccountTextController.text;
      }
    }

    // Don't change TX type when editing!
    if (!_newTX) return;

    if (_transactionType != txType) {
      setState(() {
        if (txType != TransactionTypeProperty.swaggerGeneratedUnknown) {
          _txTypeChipExtended = true;
          Future<void>.delayed(animDurationEmphasized * 3, () {
            setState(() {
              _txTypeChipExtended = false;
            });
          });
        }
        _transactionType = txType;
      });
    }
  }

  Card _buildSplitWidget(BuildContext context, int i) {
    const Widget hDivider = SizedBox(height: 16);

    CancelableOperation<Response<AutocompleteAccountArray>>? fetchOp;

    return Card(
      key: ValueKey<int>(i),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  // (Split) Transaction title
                  AnimatedHeight(
                    child:
                        _split
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
                    child:
                        _showSourceAccountSelection
                            ? Row(
                              children: <Widget>[
                                Expanded(
                                  child: AutoCompleteText<AutocompleteAccount>(
                                    labelText:
                                        S.of(context).generalSourceAccount,
                                    labelIcon: Icons.arrow_back,
                                    textController:
                                        _sourceAccountTextControllers[i],
                                    focusNode: _sourceAccountFocusNodes[i],
                                    displayStringForOption:
                                        (AutocompleteAccount option) =>
                                            option.name,
                                    onChanged:
                                        (_) => splitTransactionCheckAccounts(),
                                    onSelected:
                                        (_) => splitTransactionCheckAccounts(),
                                    optionsBuilder: (
                                      TextEditingValue textEditingValue,
                                    ) async {
                                      try {
                                        fetchOp?.cancel();

                                        final FireflyIii api =
                                            context.read<FireflyService>().api;
                                        fetchOp = CancelableOperation<
                                          Response<AutocompleteAccountArray>
                                        >.fromFuture(
                                          api.v1AutocompleteAccountsGet(
                                            query: textEditingValue.text,
                                            types: _destinationAccountType
                                                .allowedOpposingTypes(false),
                                          ),
                                        );
                                        final Response<
                                          AutocompleteAccountArray
                                        >?
                                        response =
                                            await fetchOp
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
                    child:
                        _showSourceAccountSelection
                            ? hDivider
                            : const SizedBox.shrink(),
                  ),
                  // (Split) Destination Account
                  AnimatedHeight(
                    child:
                        _showDestinationAccountSelection
                            ? Row(
                              children: <Widget>[
                                Expanded(
                                  child: AutoCompleteText<AutocompleteAccount>(
                                    labelText:
                                        S.of(context).generalDestinationAccount,
                                    labelIcon: Icons.arrow_forward,
                                    textController:
                                        _destinationAccountTextControllers[i],
                                    focusNode: _destinationAccountFocusNodes[i],
                                    onChanged:
                                        (_) => splitTransactionCheckAccounts(),
                                    onSelected:
                                        (_) => splitTransactionCheckAccounts(),
                                    displayStringForOption:
                                        (AutocompleteAccount option) =>
                                            option.name,
                                    optionsBuilder: (
                                      TextEditingValue textEditingValue,
                                    ) async {
                                      try {
                                        final FireflyIii api =
                                            context.read<FireflyService>().api;
                                        fetchOp = CancelableOperation<
                                          Response<AutocompleteAccountArray>
                                        >.fromFuture(
                                          api.v1AutocompleteAccountsGet(
                                            query: textEditingValue.text,
                                            types: _sourceAccountType
                                                .allowedOpposingTypes(true),
                                          ),
                                        );
                                        final Response<
                                          AutocompleteAccountArray
                                        >?
                                        response =
                                            await fetchOp
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
                    child:
                        _showDestinationAccountSelection
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
                    child:
                        (_transactionType == TransactionTypeProperty.withdrawal)
                            ? TransactionBudget(
                              textController: _budgetTextControllers[i],
                              focusNode: _budgetFocusNodes[i],
                            )
                            : const SizedBox.shrink(),
                  ),
                  AnimatedHeight(
                    child:
                        (_transactionType == TransactionTypeProperty.withdrawal)
                            ? hDivider
                            : const SizedBox.shrink(),
                  ),
                  // (Split) Foreign Currency
                  AnimatedHeight(
                    child:
                        (_split || _foreignCurrencies[i] != null)
                            ? Row(
                              children: <Widget>[
                                Expanded(
                                  child: NumberInput(
                                    icon:
                                        (_foreignCurrencies[i] != null)
                                            ? Icon(Icons.currency_exchange)
                                            : Icon(Icons.monetization_on),
                                    controller:
                                        (_foreignCurrencies[i] != null)
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
                                        _reconciled && _initiallyReconciled,
                                  ),
                                ),
                              ],
                            )
                            : const SizedBox.shrink(),
                  ),
                  AnimatedHeight(
                    child:
                        (_split || _foreignCurrencies[i] != null)
                            ? hDivider
                            : const SizedBox.shrink(),
                  ),
                  // (Split) Local Currency (when foreign selected)
                  AnimatedHeight(
                    child:
                        (_split && _foreignCurrencies[i] != null)
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
                                        _reconciled && _initiallyReconciled,
                                  ),
                                ),
                              ],
                            )
                            : const SizedBox.shrink(),
                  ),
                  AnimatedHeight(
                    child:
                        (_split && _foreignCurrencies[i] != null)
                            ? hDivider
                            : const SizedBox.shrink(),
                  ),
                  // Tags (always)
                  TransactionTags(
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
                alignment: Alignment.centerRight,
                child: AnimatedSize(
                  duration: animDurationStandard,
                  curve: animCurveStandard,
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: <Widget>[
                      // Reconciled Button
                      // Reconcile is broken before API V2.0.6
                      // ref https://github.com/dreautall/waterfly-iii/issues/56
                      // ref https://github.com/firefly-iii/firefly-iii/issues/7845
                      if (context.read<FireflyService>().apiVersion! >=
                          Version(2, 0, 6)) ...<Widget>[
                        IconButton(
                          icon: const Icon(Icons.done_outline),
                          isSelected: _reconciled,
                          selectedIcon: const Icon(Icons.done),
                          onPressed:
                              () => setState(() {
                                _reconciled = !_reconciled;
                                _initiallyReconciled = false;
                              }),
                          tooltip: S.of(context).generalReconcile,
                        ),
                        hDivider,
                      ],
                      // Bills Button
                      IconButton(
                        icon: const Icon(Icons.calendar_today),
                        isSelected: _bills[i] != null,
                        selectedIcon: const Icon(Icons.event_available),
                        onPressed: () async {
                          BillRead? newBill = await showDialog<BillRead>(
                            context: context,
                            barrierDismissible: false,
                            builder:
                                (BuildContext context) =>
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
                        onPressed:
                            !(_reconciled && _initiallyReconciled)
                                ? () async {
                                  CurrencyRead? newCurrency =
                                      await showDialog<CurrencyRead>(
                                        context: context,
                                        builder:
                                            (BuildContext context) =>
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
                        tooltip:
                            (_split)
                                ? S.of(context).transactionSplitChangeCurrency
                                : null,
                      ),
                      hDivider,
                      // (Split) Source Account Button (for deposits)
                      if (_split) ...<Widget>[
                        if (!_showSourceAccountSelection &&
                            _transactionType ==
                                TransactionTypeProperty.deposit) ...<Widget>[
                          IconButton(
                            icon: const Icon(Icons.add_business),
                            onPressed:
                                _split &&
                                        !_showSourceAccountSelection &&
                                        _transactionType ==
                                            TransactionTypeProperty.deposit &&
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
                            tooltip:
                                (_split)
                                    ? S
                                        .of(context)
                                        .transactionSplitChangeSourceAccount
                                    : null,
                          ),
                          hDivider,
                        ],
                        // (Split) Destination Account Button (for withdrawals)
                        if (!_showDestinationAccountSelection &&
                            _transactionType ==
                                TransactionTypeProperty.withdrawal) ...<Widget>[
                          IconButton(
                            icon: const Icon(Icons.add_business),
                            onPressed:
                                _split &&
                                        !_showDestinationAccountSelection &&
                                        _transactionType ==
                                            TransactionTypeProperty
                                                .withdrawal &&
                                        !(_reconciled && _initiallyReconciled)
                                    ? () {
                                      log.fine(
                                        () =>
                                            "adding separate destination account for $i",
                                      );
                                      _destinationAccountTextControllers[i]
                                          .text = "";
                                      setState(() {
                                        _showDestinationAccountSelection = true;
                                      });
                                    }
                                    : null,
                            tooltip:
                                (_split)
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
                          onPressed:
                              _split && !(_reconciled && _initiallyReconciled)
                                  ? () {
                                    log.fine(() => "marking $i for deletion");
                                    _cardsAnimationController[i].reverse();
                                  }
                                  : null,
                          tooltip:
                              (_split)
                                  ? S.of(context).transactionSplitDelete
                                  : null,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
  final String? amount =
      (txU.amount == null ||
              double.parse(tx.amount) == double.parse(txU.amount!))
          ? null
          : txU.amount;
  String? foreignAmount;
  if (txU.foreignAmount != null) {
    if (tx.foreignAmount == null) {
      foreignAmount = txU.foreignAmount;
    } else if (double.parse(tx.foreignAmount!) ==
        double.parse(txU.foreignAmount!)) {
      foreignAmount = null;
    } else {
      foreignAmount = txU.foreignAmount;
    }
  }

  return txU.copyWithWrapped(
    amount: Wrapped<String?>.value(amount),
    foreignAmount: Wrapped<String?>.value(foreignAmount),
    foreignCurrencyId:
        tx.foreignCurrencyId == txU.foreignCurrencyId
            ? Wrapped<String?>.value(null)
            : Wrapped<String?>.value(txU.foreignCurrencyId),
    sourceName:
        tx.sourceName == txU.sourceName
            ? Wrapped<String?>.value(null)
            : Wrapped<String?>.value(txU.sourceName),
    destinationName:
        tx.destinationName == txU.destinationName
            ? Wrapped<String?>.value(null)
            : Wrapped<String?>.value(txU.destinationName),
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
      onPressed: () async {
        final FireflyIii api = context.read<FireflyService>().api;
        final NavigatorState nav = Navigator.of(context);
        bool? ok = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) => const DeletionConfirmDialog(),
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
        labelText: S.of(context).transactionFormLabelTitle,
        labelIcon: Icons.receipt_long,
        textController: textController,
        focusNode: focusNode,
        optionsBuilder: (TextEditingValue textEditingValue) async {
          try {
            fetchOp?.cancel();

            final FireflyIii api = context.read<FireflyService>().api;
            fetchOp = CancelableOperation<
              Response<AutocompleteTransactionArray>
            >.fromFuture(
              api.v1AutocompleteTransactionsGet(query: textEditingValue.text),
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
            controller: textController,
            maxLines: null,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: S.of(context).transactionFormLabelNotes,
              icon: const Icon(Icons.description),
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
            labelText: S.of(context).generalCategory,
            labelIcon: Icons.assignment,
            textController: textController,
            focusNode: focusNode,
            optionsBuilder: (TextEditingValue textEditingValue) async {
              try {
                fetchOp?.cancel();

                final FireflyIii api = context.read<FireflyService>().api;
                fetchOp = CancelableOperation<
                  Response<AutocompleteCategoryArray>
                >.fromFuture(
                  api.v1AutocompleteCategoriesGet(query: textEditingValue.text),
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
            labelText: S.of(context).generalBudget,
            labelIcon: Icons.payments,
            textController: widget.textController,
            focusNode: widget.focusNode,
            errorText:
                _budgetId == null
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
                fetchOp?.cancel();

                final FireflyIii api = context.read<FireflyService>().api;
                fetchOp = CancelableOperation<
                  Response<AutocompleteBudgetArray>
                >.fromFuture(
                  api.v1AutocompleteBudgetsGet(query: textEditingValue.text),
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
