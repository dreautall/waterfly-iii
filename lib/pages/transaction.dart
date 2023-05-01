import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:badges/badges.dart' as badges;
import 'package:chopper/chopper.dart' show Response;

import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/notificationlistener.dart';
import 'package:waterflyiii/pages/transaction/transaction_attachments.dart';
import 'package:waterflyiii/pages/transaction/transaction_currencies.dart';
import 'package:waterflyiii/pages/transaction/transaction_tags.dart';
import 'package:waterflyiii/settings.dart';
import 'package:waterflyiii/widgets/autocompletetext.dart';
import 'package:waterflyiii/widgets/input_number.dart';
import 'package:waterflyiii/widgets/materialiconbutton.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({
    Key? key,
    this.transaction,
    this.transactionId,
    this.notification,
  }) : super(key: key);

  final String? transactionId;
  final TransactionRead? transaction;
  final NotificationTransaction? notification;

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Common values
  late TransactionTypeProperty _transactionType;
  final FocusNode _typeFocusNode = FocusNode();
  final TextEditingController _titleTextController = TextEditingController();
  final FocusNode _titleFocusNode = FocusNode();
  final TextEditingController _ownAccountTextController =
      TextEditingController();
  final FocusNode _ownAccountFocusNode = FocusNode();
  String? _ownAccountId;
  late DateTime _date;
  final TextEditingController _dateTextController = TextEditingController();
  final TextEditingController _timeTextController = TextEditingController();
  CurrencyRead? _localCurrency;

  // Withdrawal: splits have common source account (= own account)
  // Deposit: splits have common target account (= own account)
  // Transfer: splits have common accounts for both (= own accounts)

  // Individual for split transactions, show common for single transaction
  final TextEditingController _otherAccountTextController =
      TextEditingController();
  final FocusNode _otherAccountFocusNode = FocusNode();
  final TextEditingController _localAmountTextController =
      TextEditingController();
  //double? _foreignAmount = 0.0; // = _foreignAmounts.sum;
  final TextEditingController _foreignAmountTextController =
      TextEditingController();
  CurrencyRead? _foreignCurrency;

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

  // Individual for split transactions
  final List<TextEditingController> _titleTextControllers =
      <TextEditingController>[];
  final List<FocusNode> _titleFocusNodes = <FocusNode>[];
  final List<TextEditingController> _otherAccountTextControllers =
      <TextEditingController>[];
  final List<FocusNode> _otherAccountFocusNodes = <FocusNode>[];
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

  // Magic moving!
  // https://m3.material.io/styles/motion/easing-and-duration/applying-easing-and-duration
  final List<AnimationController> _cardsAnimationController =
      <AnimationController>[];
  final List<Animation<double>> _cardsAnimation = <Animation<double>>[];

  bool _saving = false;

  @override
  void initState() {
    super.initState();

    if (widget.transactionId != null && widget.transaction == null) {
      // :TODO: Fetch transaction while spinner is shown
    }
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
          _ownAccountTextController.text = transactions.first.sourceName ?? "";
          _ownAccountId = transactions.first.sourceId;
          break;
        case TransactionTypeProperty.deposit:
        case TransactionTypeProperty.openingBalance:
          _ownAccountTextController.text =
              transactions.first.destinationName ?? "";
          _ownAccountId = transactions.first.destinationId;
          break;
        default:
      }

      /// date
      _date = transactions.first.date.toLocal();

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

      for (TransactionSplit trans in transactions) {
        // Always in card view
        /// Category
        _categoryTextControllers
            .add(TextEditingController(text: trans.categoryName));
        _categoryFocusNodes.add(FocusNode());

        //// Budget
        _budgetTextControllers
            .add(TextEditingController(text: trans.budgetName));
        _budgetFocusNodes.add(FocusNode());

        /// Tags
        _tags.add(Tags(trans.tags ?? <String>[]));
        _tagsTextControllers.add(TextEditingController(
          text: (_tags.last.tags.isNotEmpty) ? " " : "",
        ));

        /// Notes
        _noteTextControllers.add(TextEditingController(text: trans.notes));

        // Individual for split transactions
        /// Title
        _titleTextControllers
            .add(TextEditingController(text: trans.description));
        _titleFocusNodes.add(FocusNode());

        /// local amount
        _localAmounts.add(double.tryParse(trans.amount) ?? 0);
        _localAmountTextControllers.add(TextEditingController(
          text: _localAmounts.last
              .toStringAsFixed(trans.currencyDecimalPlaces ?? 2),
        ));

        /// other account
        switch (_transactionType) {
          case TransactionTypeProperty.withdrawal:
          case TransactionTypeProperty.transfer:
            _otherAccountTextControllers.add(TextEditingController(
              text: trans.destinationName,
            ));
            break;
          case TransactionTypeProperty.deposit:
          case TransactionTypeProperty.openingBalance:
            _otherAccountTextControllers.add(TextEditingController(
              text: trans.sourceName,
            ));
            break;
          default:
            // Always add one to keep List size correct!
            _otherAccountTextControllers.add(TextEditingController());
        }
        _otherAccountFocusNodes.add(FocusNode());

        /// foreign currency
        //// foreign amount
        _foreignAmounts.add(double.tryParse(trans.foreignAmount ?? '') ?? 0);
        _foreignAmountTextControllers.add(TextEditingController(
          text: _foreignAmounts.last
              .toStringAsFixed(trans.foreignCurrencyDecimalPlaces ?? 2),
        ));
        //// foreign currency
        if (trans.foreignCurrencyCode?.isNotEmpty ?? false) {
          _foreignCurrencies.add(CurrencyRead(
            type: "currencies",
            id: trans.foreignCurrencyId!,
            attributes: Currency(
              code: trans.foreignCurrencyCode!,
              name: "", // empty
              symbol: trans.foreignCurrencySymbol!,
              decimalPlaces: trans.foreignCurrencyDecimalPlaces,
            ),
          ));
        } else {
          _foreignCurrencies.add(null);
        }

        //// Journal ID
        _transactionJournalIDs.add(trans.transactionJournalId);

        //// Attachments
        _hasAttachments = _hasAttachments || (trans.hasAttachments ?? false);

        // Card Animations
        _cardsAnimationController.add(AnimationController(
          // height 1 = visible - enter = fwd (0->1), exit = reverse (1->0)
          value: 1.0,
          duration: animDurationEmphasizedDecelerate,
          reverseDuration: animDurationEmphasizedDecelerate,
          vsync: this,
        ));
        int i = _cardsAnimationController.length - 1;
        _cardsAnimationController.last.addStatusListener(
            (AnimationStatus status) => deleteCardAnimated(i)(status));
        _cardsAnimation.add(CurvedAnimation(
          parent: _cardsAnimationController.last,
          curve: animCurveEmphasizedDecelerate,
          reverseCurve: animCurveEmphasizedAccelerate,
        ));
      }

      // Individual for split transactions, show common for single transaction
      WidgetsBinding.instance.addPostFrameCallback((_) {
        updateTransactionAmounts();
        splitTransactionCheckAccounts();
      });

      _split = (_localAmounts.length > 1);
    } else {
      // New transaction
      _titleFocusNode.requestFocus();
      _transactionType = TransactionTypeProperty.withdrawal;
      _date = DateTime.now();

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        splitTransactionAdd();
        _localCurrency = context.read<FireflyService>().defaultCurrency;

        if (widget.notification != null) {
          final FireflyIii api = context.read<FireflyService>().api;
          final SettingsProvider settings = context.read<SettingsProvider>();

          debugPrint("Got notification ${widget.notification}");
          late CurrencyRead? currency;
          double amount = 0;

          // Try to extract some money
          final Iterable<RegExpMatch> matches =
              rFindMoney.allMatches(widget.notification!.body);
          if (matches.isNotEmpty) {
            RegExpMatch? validMatch;
            for (RegExpMatch match
                in matches.toList(growable: false).reversed) {
              if ((match.namedGroup("postCurrency")?.isNotEmpty ?? false) &&
                  (match.namedGroup("preCurrency")?.isNotEmpty ?? false)) {
                validMatch = match;
                break;
              }
            }
            if (validMatch != null) {
              // extract currency
              String currencyStr = validMatch.namedGroup("preCurrency") ?? "";
              String currencyStrAlt =
                  validMatch.namedGroup("postCurrency") ?? "";
              if (currencyStr.isEmpty) {
                currencyStr = currencyStrAlt;
              }
              if (currencyStr.isEmpty) {
                debugPrint("no currency found");
              }
              if (_localCurrency!.attributes.code == currencyStr ||
                  _localCurrency!.attributes.symbol == currencyStr ||
                  _localCurrency!.attributes.code == currencyStrAlt ||
                  _localCurrency!.attributes.symbol == currencyStrAlt) {
              } else {
                final Response<CurrencyArray> response =
                    await api.v1CurrenciesGet();
                if (!response.isSuccessful || response.body == null) {
                  debugPrint("api currency fetch failed");
                } else {
                  for (CurrencyRead cur in response.body!.data) {
                    if (cur.attributes.code == currencyStr ||
                        cur.attributes.symbol == currencyStr ||
                        cur.attributes.code == currencyStrAlt ||
                        cur.attributes.symbol == currencyStrAlt) {
                      currency = cur;
                      break;
                    }
                  }
                }
              }
              // extract amount
              // Check if string has a decimal separator
              final String amountStr = validMatch.namedGroup("amount") ?? "";
              final String decimalSep =
                  amountStr.length >= 3 ? amountStr[amountStr.length - 3] : "";
              if (decimalSep == "," || decimalSep == ".") {
                final double wholes = double.tryParse(amountStr
                        .substring(0, amountStr.length - 3)
                        .replaceAll(",", "")
                        .replaceAll(".", "")) ??
                    0;
                final double dec = double.tryParse(amountStr
                        .substring(amountStr.length - 2)
                        .replaceAll(",", "")
                        .replaceAll(".", "")) ??
                    0;
                amount = wholes + dec / 100;
              } else {
                amount = double.tryParse(
                        amountStr.replaceAll(",", "").replaceAll(".", "")) ??
                    0;
              }
            } else {
              debugPrint("no currency was found");
            }
          } else {
            debugPrint("regex did not match");
          }
          // Fallback solution
          currency ??= _localCurrency;

          // Set title & date
          _titleTextController.text = widget.notification!.title;
          _date = widget.notification!.date;
          _dateTextController.text = DateFormat.yMMMMd().format(_date);
          _timeTextController.text = DateFormat.Hm().format(_date);

          // Check currency
          if (currency == _localCurrency) {
            _localAmounts[0] = amount;
            _localAmountTextController.text =
                amount.toStringAsFixed(currency?.attributes.decimalPlaces ?? 2);
          } else {
            _foreignCurrency = currency;
            _foreignAmounts[0] = amount;
            _foreignAmountTextController.text =
                amount.toStringAsFixed(currency?.attributes.decimalPlaces ?? 2);
          }
          _noteTextControllers[0].text = widget.notification!.body;

          // Check account
          final Response<AccountArray> response =
              await api.v1AccountsGet(type: AccountTypeFilter.assetAccount);
          if (!response.isSuccessful || response.body == null) {
            debugPrint("api account fetch failed");
            return;
          }
          final NotificationAppSettings appSettings = await settings
              .notificationGetAppSettings(widget.notification!.appName);
          final String settingAppId = appSettings.defaultAccountId ?? "0";
          for (AccountRead acc in response.body!.data) {
            if (acc.id == settingAppId ||
                widget.notification!.body.contains(acc.attributes.name)) {
              _ownAccountTextController.text = acc.attributes.name;
              _ownAccountId = acc.id;
              break;
            }
          }

          setState(() {});
        }
      });
    }

    _dateTextController.text = DateFormat.yMMMMd().format(_date);
    _timeTextController.text = DateFormat.Hm().format(_date);

    // focus node listener for ownaccount
    _ownAccountFocusNode.addListener(() async {
      if (_ownAccountFocusNode.hasFocus) {
        return;
      }
      try {
        final FireflyIii api = context.read<FireflyService>().api;
        final Response<AutocompleteAccountArray> response =
            await api.v1AutocompleteAccountsGet(
          query: _ownAccountTextController.text,
          types: <AccountTypeFilter>[
            AccountTypeFilter.assetAccount,
            AccountTypeFilter.loan,
            AccountTypeFilter.debt,
            AccountTypeFilter.mortgage,
          ],
        );
        if (!response.isSuccessful || response.body == null) {
          if (context.mounted) {
            throw Exception(
              S
                  .of(context)
                  .errorAPIInvalidResponse(response.error?.toString() ?? ""),
            );
          } else {
            throw Exception(
              "[nocontext] Invalid API response: ${response.error}",
            );
          }
        }
        if (response.body!.isEmpty ||
            (response.body!.length > 1 &&
                response.body!.first.name != _ownAccountTextController.text)) {
          setState(() {
            _ownAccountId = null;
          });
        } else {
          _ownAccountTextController.text = response.body!.first.name;
          setState(() {
            _ownAccountId = response.body!.first.id;
          });
          checkAccountCurrency(response.body!.first);
        }
      } catch (e) {
        debugPrint("Error while fetching autocomplete from API: $e");
      }
    });
  }

  @override
  void dispose() {
    _typeFocusNode.dispose();
    _titleTextController.dispose();
    _titleFocusNode.dispose();
    _ownAccountTextController.dispose();
    _ownAccountFocusNode.dispose();
    _dateTextController.dispose();
    _timeTextController.dispose();

    _localAmountTextController.dispose();
    _foreignAmountTextController.dispose();

    for (TextEditingController t in _otherAccountTextControllers) {
      t.dispose();
    }
    for (FocusNode f in _otherAccountFocusNodes) {
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
    _localAmountTextController.text = _localAmounts.sum
        .toStringAsFixed(_localCurrency?.attributes.decimalPlaces ?? 2);

    /// foreign amount & currency
    _foreignCurrency = _foreignCurrencies.first;
    if (_foreignCurrency != null &&
        _foreignCurrencies.every(
            (CurrencyRead? e) => e != null && e.id == _foreignCurrency!.id)) {
      // all same foreign currency --> ok to show in summary
      _foreignAmountTextController.text = _foreignAmounts.sum
          .toStringAsFixed(_foreignCurrency?.attributes.decimalPlaces ?? 2);
    } else {
      _foreignCurrency = null;
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
    debugPrint("removing split $i");
    if (_localAmounts.length < i || _localAmounts.length == 1) {
      debugPrint("can't remove, last item");
      return;
    }

    // this we need to dispose later
    TextEditingController t1 = _otherAccountTextControllers.removeAt(i);
    FocusNode f1 = _otherAccountFocusNodes.removeAt(i);
    TextEditingController t2 = _categoryTextControllers.removeAt(i);
    FocusNode f2 = _categoryFocusNodes.removeAt(i);
    TextEditingController t3 = _budgetTextControllers.removeAt(i);
    FocusNode f3 = _budgetFocusNodes.removeAt(i);
    _tags.removeAt(i);
    TextEditingController t4 = _tagsTextControllers.removeAt(i);
    TextEditingController t5 = _noteTextControllers.removeAt(i);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      t1.dispose();
      f1.dispose();
      t2.dispose();
      f2.dispose();
      t3.dispose();
      f3.dispose();
      t4.dispose();
      t5.dispose();
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
    splitTransactionCheckAccounts();
    if (_localAmounts.length == 1) {
      // This is similar to the web interface --> summary text gets deleted when split is removed.
      if (_titleTextControllers.first.text.isNotEmpty) {
        _titleTextController.text = _titleTextControllers.first.text;
      }
    }

    // Redo animationcallbacks due to new "i"s
    for (int i = 0; i < _cardsAnimationController.length; i++) {
      // ignore: invalid_use_of_protected_member
      _cardsAnimationController[i].clearStatusListeners();
      _cardsAnimationController[i].addStatusListener(
          (AnimationStatus status) => deleteCardAnimated(i)(status));
    }

    debugPrint("remaining split #: ${_localAmounts.length}");

    setState(() {
      _split = (_localAmounts.length > 1);
    });
  }

  void splitTransactionAdd() {
    debugPrint("adding split");
    // Update from summary to first when first split is added
    if (_localAmounts.length == 1) {
      _localAmountTextControllers.first.text = _localAmountTextController.text;
      _foreignAmountTextControllers.first.text =
          _foreignAmountTextController.text;
      _foreignCurrencies.first = _foreignCurrency;
    }

    _otherAccountTextControllers.add(TextEditingController(
      text: _otherAccountTextControllers.firstOrNull?.text,
    ));
    _otherAccountFocusNodes.add(FocusNode());
    _categoryTextControllers.add(TextEditingController());
    _categoryFocusNodes.add(FocusNode());
    _budgetTextControllers.add(TextEditingController());
    _budgetFocusNodes.add(FocusNode());
    _tags.add(Tags());
    _tagsTextControllers.add(TextEditingController());
    _noteTextControllers.add(TextEditingController());

    _titleTextControllers.add(TextEditingController());
    _titleFocusNodes.add(FocusNode());
    _localAmounts.add(0);
    _localAmountTextControllers.add(TextEditingController());
    _foreignAmounts.add(0);
    _foreignAmountTextControllers.add(TextEditingController());
    _foreignCurrencies.add(_foreignCurrencies.firstOrNull);
    _transactionJournalIDs.add(null);

    _cardsAnimationController.add(AnimationController(
      // height 0 = invisible - enter = fwd (0->1), exit = reverse (1->0)
      value: 0.0,
      duration: animDurationEmphasizedDecelerate,
      reverseDuration: animDurationEmphasizedAccelerate,
      vsync: this,
    ));
    int i = _cardsAnimationController.length - 1;
    _cardsAnimationController.last.addStatusListener(
        (AnimationStatus status) => deleteCardAnimated(i)(status));
    _cardsAnimation.add(CurvedAnimation(
      parent: _cardsAnimationController.last,
      curve: animCurveEmphasizedDecelerate,
      reverseCurve: animCurveEmphasizedAccelerate,
    ));

    debugPrint("new split #: ${_localAmounts.length}");

    setState(() {
      _split = (_localAmounts.length > 1);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cardsAnimationController.last.forward();
    });
  }

  void splitTransactionCalculateAmount() {
    _localAmountTextController.text = _localAmounts.sum
        .toStringAsFixed(_localCurrency?.attributes.decimalPlaces ?? 2);
    if (_foreignCurrencies
        .every((CurrencyRead? e) => e?.id == _foreignCurrencies.first?.id)) {
      _foreignAmountTextController.text = _foreignAmounts.sum
          .toStringAsFixed(_foreignCurrency?.attributes.decimalPlaces ?? 2);
    } else {
      _foreignAmountTextController.text = "<${S.of(context).generalMultiple}>";
    }
  }

  void splitTransactionCheckAccounts() {
    bool update = false;
    if (_otherAccountTextControllers.every((TextEditingController e) =>
        e.text == _otherAccountTextControllers.first.text)) {
      if (_otherAccountTextController.text !=
          _otherAccountTextControllers.first.text) {
        _otherAccountTextController.text =
            _otherAccountTextControllers.first.text;
        update = true;
      }
    } else {
      if (_otherAccountTextController.text !=
          "<${S.of(context).generalMultiple}>") {
        _otherAccountTextController.text = "<${S.of(context).generalMultiple}>";
        update = true;
      }
    }
    if (update) {
      setState(() {});
    }
  }

  void updateAttachmentCount() async {
    try {
      final FireflyIii api = context.read<FireflyService>().api;
      final Response<AttachmentArray> response =
          await api.v1TransactionsIdAttachmentsGet(
        id: widget.transaction?.id ?? widget.transactionId,
      );
      if (!response.isSuccessful || response.body == null) {
        if (context.mounted) {
          throw Exception(
            S
                .of(context)
                .errorAPIInvalidResponse(response.error?.toString() ?? ""),
          );
        } else {
          throw Exception(
            "[nocontext] Invalid API response: ${response.error}",
          );
        }
      }
      _attachments = response.body!.data;
      setState(() {
        _hasAttachments = _attachments?.isNotEmpty ?? false;
      });
    } catch (e) {
      debugPrint("Error while fetching autocomplete from API: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("TransactionDetail build()");
    _localCurrency ??= context.read<FireflyService>().defaultCurrency;

    if (_hasAttachments && _attachments == null) {
      updateAttachmentCount();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          (widget.transaction == null)
              ? S.of(context).transactionTitleAdd
              : S.of(context).transactionTitleEdit,
        ),
        actions: <Widget>[
          if (!(widget.transactionId == null && widget.transaction == null))
            IconButton(
              icon: const Icon(Icons.delete),
              tooltip: MaterialLocalizations.of(context).deleteButtonTooltip,
              onPressed: () async {
                final FireflyIii api = context.read<FireflyService>().api;
                final NavigatorState nav = Navigator.of(context);
                bool? ok = await showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    icon: const Icon(Icons.delete),
                    title: Text(S.of(context).transactionTitleDelete),
                    clipBehavior: Clip.hardEdge,
                    actions: <Widget>[
                      TextButton(
                        child: Text(MaterialLocalizations.of(context)
                            .cancelButtonLabel),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      FilledButton(
                        child: Text(MaterialLocalizations.of(context)
                            .deleteButtonTooltip),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ],
                    content: Text(S.of(context).transactionDeleteConfirm),
                  ),
                );
                if (!(ok ?? false)) {
                  return;
                }

                await api.v1TransactionsIdDelete(
                  id: widget.transaction?.id ?? widget.transactionId,
                );
                nav.pop(true);
              },
            ),
          const SizedBox(width: 8),
          FilledButton(
            onPressed: _saving
                ? null
                : () async {
                    final ScaffoldMessengerState msg =
                        ScaffoldMessenger.of(context);
                    final FireflyIii api = context.read<FireflyService>().api;
                    final NavigatorState nav = Navigator.of(context);

                    // Sanity checks
                    String? error;

                    if (_ownAccountId == null) {
                      //error = "Please select an asset account.";
                    }
                    if (_titleTextController.text.isEmpty) {
                      error = S.of(context).transactionErrorTitle;
                    }
                    if (error != null) {
                      msg.showSnackBar(SnackBar(
                        content: Text(error),
                        behavior: SnackBarBehavior.floating,
                      ));
                      return;
                    }
                    // Do stuff
                    setState(() {
                      _saving = true;
                    });
                    late Response<TransactionSingle> resp;

                    if (widget.transaction != null) {
                      String id = widget.transaction!.id;
                      List<TransactionSplitUpdate> txS =
                          <TransactionSplitUpdate>[];
                      for (int i = 0; i < _localAmounts.length; i++) {
                        late String sourceName, destinationName;
                        String? sourceId, destinationId;
                        if (_transactionType ==
                                TransactionTypeProperty.withdrawal ||
                            _transactionType ==
                                TransactionTypeProperty.transfer) {
                          sourceName = _ownAccountTextController.text;
                          sourceId = _ownAccountId;
                          destinationName =
                              _otherAccountTextControllers[i].text;
                          if (destinationName.isEmpty) {
                            destinationName = _otherAccountTextController.text;
                          }
                        } else {
                          destinationName = _ownAccountTextController.text;
                          destinationId = _ownAccountId;
                          sourceName = _otherAccountTextControllers[i].text;
                          if (sourceName.isEmpty) {
                            sourceName = _otherAccountTextController.text;
                          }
                        }
                        txS.add(TransactionSplitUpdate(
                          amount: _localAmounts[i].toString(),
                          budgetName: _budgetTextControllers[i].text,
                          categoryName: _categoryTextControllers[i].text,
                          date: _date,
                          description: _split
                              ? _titleTextControllers[i].text
                              : _titleTextController.text,
                          destinationId: destinationId,
                          destinationName: destinationName,
                          foreignAmount: _split
                              ? _foreignCurrencies[i] != null
                                  ? _foreignAmounts[i].toString()
                                  : "0"
                              : _foreignCurrency != null
                                  ? _foreignAmounts[i].toString()
                                  : "0",
                          foreignCurrencyId: _split
                              ? _foreignCurrencies[i]?.id
                              : _foreignCurrency?.id,
                          notes: _noteTextControllers[i].text,
                          order: i,
                          sourceId: sourceId,
                          sourceName: sourceName,
                          tags: _tags[i].tags,
                          transactionJournalId:
                              _transactionJournalIDs.elementAtOrNull(i),
                          type: _transactionType,
                        ));
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
                        debugPrint("deleting split $id");
                        await api.v1TransactionJournalsIdDelete(id: id);
                      }
                      resp =
                          await api.v1TransactionsIdPut(id: id, body: txUpdate);
                    } else {
                      List<TransactionSplitStore> txS =
                          <TransactionSplitStore>[];
                      for (int i = 0; i < _localAmounts.length; i++) {
                        late String sourceName, destinationName;
                        String? sourceId, destinationId;
                        if (_transactionType ==
                                TransactionTypeProperty.withdrawal ||
                            _transactionType ==
                                TransactionTypeProperty.transfer) {
                          sourceName = _ownAccountTextController.text;
                          sourceId = _ownAccountId;
                          destinationName =
                              _otherAccountTextControllers[i].text;
                          if (destinationName.isEmpty) {
                            destinationName = _otherAccountTextController.text;
                          }
                        } else {
                          destinationName = _ownAccountTextController.text;
                          destinationId = _ownAccountId;
                          sourceName = _otherAccountTextControllers[i].text;
                          if (sourceName.isEmpty) {
                            sourceName = _otherAccountTextController.text;
                          }
                        }
                        txS.add(TransactionSplitStore(
                          type: _transactionType,
                          date: _date,
                          amount: _localAmounts[i].toString(),
                          description: _split
                              ? _titleTextControllers[i].text
                              : _titleTextController.text,
                          budgetName: _budgetTextControllers[i].text,
                          categoryName: _categoryTextControllers[i].text,
                          destinationId: destinationId,
                          destinationName: destinationName,
                          foreignAmount: _split
                              ? _foreignCurrencies[i] != null
                                  ? _foreignAmounts[i].toString()
                                  : "0"
                              : _foreignCurrency != null
                                  ? _foreignAmounts[i].toString()
                                  : "0",
                          foreignCurrencyId: _split
                              ? _foreignCurrencies[i]?.id
                              : _foreignCurrency?.id,
                          notes: _noteTextControllers[i].text,
                          order: i,
                          sourceId: sourceId,
                          sourceName: sourceName,
                          tags: _tags[i].tags,
                          reconciled: false,
                        ));
                      }
                      final TransactionStore newTx = TransactionStore(
                          groupTitle: _split ? _titleTextController.text : null,
                          transactions: txS,
                          applyRules: true,
                          fireWebhooks: true,
                          errorIfDuplicateHash: true);
                      resp = await api.v1TransactionsPost(body: newTx);
                    }

                    // Check if insert/update was successful
                    if (!resp.isSuccessful || resp.body == null) {
                      debugPrint(resp.error.toString());
                      try {
                        ValidationError valError = ValidationError.fromJson(
                          json.decode(resp.error.toString()),
                        );
                        error = valError.message ??
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

                      msg.showSnackBar(SnackBar(
                        content: Text(error),
                        behavior: SnackBarBehavior.floating,
                      ));
                      setState(() {
                        _saving = false;
                      });
                      return;
                    }

                    if (nav.canPop()) {
                      nav.pop(true);
                    } else {
                      // Launched from notification
                      // https://stackoverflow.com/questions/45109557/flutter-how-to-programmatically-exit-the-app
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                    }
                  },
            child: Text(MaterialLocalizations.of(context).saveButtonLabel),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: (widget.transactionId != null && widget.transaction == null)
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                cacheExtent: 10000,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                children: _transactionDetailBuilder(context),
              ),
            ),
    );
  }

  List<Widget> _transactionDetailBuilder(BuildContext context) {
    debugPrint("transactionDetailBuilder()");
    debugPrint("splits: ${_localAmounts.length}, split? $_split");
    bool showAccountSelection =
        _transactionType != TransactionTypeProperty.transfer &&
            _otherAccountTextControllers.every((TextEditingController e) =>
                e.text != _otherAccountTextController.text);

    List<Widget> childs = <Widget>[];
    const Widget hDivider = SizedBox(height: 16);
    const Widget vDivider = SizedBox(width: 16);

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
              badgeColor: Theme.of(context).colorScheme.surfaceVariant,
            ),
            badgeAnimation: const badges.BadgeAnimation.scale(
              animationDuration: animDurationEmphasized,
              curve: animCurveEmphasized,
            ),
            child: MaterialIconButton(
              icon: Icons.attach_file,
              tooltip: S.of(context).transactionAttachments,
              onPressed: () async {
                String? txId = _transactionJournalIDs
                    .firstWhereOrNull((String? element) => element != null);
                if (txId == null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(S.of(context).transactionErrorSaveFirst),
                    behavior: SnackBarBehavior.floating,
                  ));
                  return;
                }
                List<AttachmentRead> dialogAttachments =
                    _attachments ?? <AttachmentRead>[];
                await showDialog<List<AttachmentRead>>(
                  context: context,
                  builder: (BuildContext context) => AttachmentDialog(
                    attachments: dialogAttachments,
                    transactionId: txId,
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
    // Amount, Currency, Local Currency
    childs.add(
      Row(
        children: <Widget>[
          SizedBox(
            width: 150,
            child: NumberInput(
              icon: const Icon(Icons.monetization_on),
              hintText: "0.00",
              decimals: _foreignCurrency?.attributes.decimalPlaces ??
                  _localCurrency?.attributes.decimalPlaces ??
                  2,
              //style: Theme.of(context).textTheme.headlineLarge,
              controller: (_foreignCurrency != null)
                  ? _foreignAmountTextController
                  : _localAmountTextController,
              disabled: _split,
              onChanged: (String string) => (_foreignCurrency != null)
                  ? _foreignAmounts[0] = double.tryParse(string) ?? 0
                  : _localAmounts[0] = double.tryParse(string) ?? 0,
            ),
          ),
          vDivider,
          FilledButton(
            onPressed: () async {
              CurrencyRead? newCurrency = await showDialog<CurrencyRead>(
                context: context,
                builder: (BuildContext context) => CurrencyDialog(
                  currentCurrency: _foreignCurrency ?? _localCurrency!,
                ),
              );
              if (newCurrency == null) {
                return;
              }
              setState(() {
                for (int i = 0; i < _foreignCurrencies.length; i++) {
                  if (newCurrency.id == _localCurrency!.id) {
                    _foreignCurrencies[i] = null;
                  } else {
                    _foreignCurrencies[i] = newCurrency;
                    debugPrint(
                        "foreignAmounts[i] = ${_foreignAmounts[i]}, localAmounts[i] = ${_localAmounts[i]}");
                    if (_foreignAmounts[i] == 0) {
                      _foreignAmounts[i] = _localAmounts[i];
                      _foreignAmountTextControllers[i].text = _foreignAmounts[i]
                          .toStringAsFixed(
                              _foreignCurrencies[i]?.attributes.decimalPlaces ??
                                  2);
                    }
                  }
                }
              });
              updateTransactionAmounts();
            },
            //style: FilledButton.styleFrom(textStyle: Theme.of(context).textTheme.headlineLarge,),
            child: Text(_foreignCurrency?.attributes.code ??
                _localCurrency?.attributes.code ??
                ""),
          ),
          vDivider,
          if (_foreignCurrency != null)
            Expanded(
              child: NumberInput(
                controller: _localAmountTextController,
                disabled: _split,
                hintText: _localCurrency?.zero() ??
                    NumberFormat.currency(
                      decimalDigits: 2,
                    ).format(0),
                decimals: _localCurrency?.attributes.decimalPlaces ?? 2,
                prefixText: "${_localCurrency?.attributes.code} ",
                onChanged: (String string) =>
                    _localAmounts[0] = double.tryParse(string) ?? 0,
              ),
            ),
        ],
      ),
    );
    childs.add(hDivider);
    // Source Account, Type, Destination Account
    childs.add(
      Row(
        children: <Widget>[
          const Icon(Icons.account_balance),
          vDivider,
          Expanded(
            child: AutoCompleteText<AutocompleteAccount>(
              labelText: S.of(context).transactionFormLabelAccountForeign,
              //labelIcon: Icons.account_balance,
              textController: _otherAccountTextController,
              disabled: showAccountSelection,
              focusNode: _otherAccountFocusNode,
              onChanged: (String text) {
                for (TextEditingController e in _otherAccountTextControllers) {
                  e.text = text;
                }
              },
              onSelected: (AutocompleteAccount option) {
                for (TextEditingController e in _otherAccountTextControllers) {
                  e.text = option.name;
                }
              },
              displayStringForOption: (AutocompleteAccount option) =>
                  option.name,
              optionsBuilder: (TextEditingValue textEditingValue) async {
                try {
                  final FireflyIii api = context.read<FireflyService>().api;
                  final Response<AutocompleteAccountArray> response =
                      await api.v1AutocompleteAccountsGet(
                    query: textEditingValue.text,
                    types:
                        _transactionType == TransactionTypeProperty.withdrawal
                            ? _transactionType.destinationAccountTypes
                            : _transactionType.sourceAccountTypes,
                  );
                  if (!response.isSuccessful || response.body == null) {
                    if (context.mounted) {
                      throw Exception(
                        S.of(context).errorAPIInvalidResponse(
                            response.error?.toString() ?? ""),
                      );
                    } else {
                      throw Exception(
                        "[nocontext] Invalid API response: ${response.error}",
                      );
                    }
                  }
                  return response.body!;
                } catch (e) {
                  debugPrint("Error while fetching autocomplete from API: $e");
                  return const Iterable<AutocompleteAccount>.empty();
                }
              },
            ),
          ),
          vDivider,
          MenuAnchor(
            childFocusNode: _typeFocusNode,
            menuChildren: <Widget>[
              MenuItemButton(
                leadingIcon: const Icon(Icons.arrow_back),
                child: Text(S.of(context).transactionTypeWithdrawal),
                onPressed: () {
                  if (_transactionType == TransactionTypeProperty.withdrawal) {
                    return;
                  }
                  setState(() {
                    _transactionType = TransactionTypeProperty.withdrawal;
                  });
                },
              ),
              MenuItemButton(
                leadingIcon: const Icon(Icons.arrow_forward),
                child: Text(S.of(context).transactionTypeDeposit),
                onPressed: () {
                  if (_transactionType == TransactionTypeProperty.deposit) {
                    return;
                  }
                  setState(() {
                    _transactionType = TransactionTypeProperty.deposit;
                  });
                },
              ),
              MenuItemButton(
                leadingIcon: const Icon(Icons.swap_horiz),
                child: Text(S.of(context).transactionTypeDeposit),
                onPressed: () {
                  if (_transactionType == TransactionTypeProperty.transfer) {
                    return;
                  }
                  setState(() {
                    _transactionType = TransactionTypeProperty.transfer;
                    // Clear text controllers
                    _otherAccountTextController.text = "";
                    for (TextEditingController e
                        in _otherAccountTextControllers) {
                      e.text = "";
                    }
                  });
                },
              ),
            ],
            builder: (BuildContext context, MenuController controller,
                Widget? child) {
              return MaterialIconButton(
                icon: _transactionType.icon,
                //iconSize: Theme.of(context).textTheme.headlineLarge!.fontSize!,
                focusNode: _typeFocusNode,
                foregroundColor: Colors.white,
                backgroundColor: _transactionType.color,
                // Disable when editing existing transaction --> not allowed
                onPressed: (widget.transaction != null)
                    ? null
                    : () {
                        if (controller.isOpen) {
                          controller.close();
                        } else {
                          controller.open();
                        }
                      },
              );
            },
          ),
          vDivider,
          Expanded(
            child: AutoCompleteText<AutocompleteAccount>(
              labelText: S.of(context).transactionFormLabelAccountOwn,
              //labelIcon: Icons.account_balance,
              textController: _ownAccountTextController,
              focusNode: _ownAccountFocusNode,
              errorText: _ownAccountId == null
                  ? S.of(context).transactionErrorInvalidAccount
                  : null,
              errorIconOnly: true,
              displayStringForOption: (AutocompleteAccount option) =>
                  option.name,
              onSelected: (AutocompleteAccount option) {
                setState(() {
                  _ownAccountId = option.id;
                });
                debugPrint("selected account $_ownAccountId");
                checkAccountCurrency(option);
              },
              optionsBuilder: (TextEditingValue textEditingValue) async {
                try {
                  final FireflyIii api = context.read<FireflyService>().api;
                  final Response<AutocompleteAccountArray> response =
                      await api.v1AutocompleteAccountsGet(
                    query: textEditingValue.text,
                    types: <AccountTypeFilter>[
                      AccountTypeFilter.assetAccount,
                      AccountTypeFilter.loan,
                      AccountTypeFilter.debt,
                      AccountTypeFilter.mortgage,
                    ],
                  );
                  if (!response.isSuccessful || response.body == null) {
                    if (context.mounted) {
                      throw Exception(
                        S.of(context).errorAPIInvalidResponse(
                            response.error?.toString() ?? ""),
                      );
                    } else {
                      throw Exception(
                        "[nocontext] Invalid API response: ${response.error}",
                      );
                    }
                  }
                  return response.body!;
                } catch (e) {
                  debugPrint("Error while fetching autocomplete from API: $e");
                  return const Iterable<AutocompleteAccount>.empty();
                }
              },
            ),
          ),
        ],
      ),
    );
    childs.add(hDivider);
    // Date & Time
    childs.add(
      // Date/Time select might overflow, so we need to be able to scroll horizontally.
      SizedBox(
        height:
            56, // 56 is measured height from layout inspector of a normal row.
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            const Icon(Icons.event),
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
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );

                  if (pickedDate == null) {
                    return;
                  }

                  setState(() {
                    _date = _date.copyWith(
                      year: pickedDate.year,
                      month: pickedDate.month,
                      day: pickedDate.day,
                    );
                    _dateTextController.text =
                        DateFormat.yMMMMd().format(_date);
                  });
                },
              ),
            ),
            vDivider,
            IntrinsicWidth(
              child: TextFormField(
                controller: _timeTextController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.schedule),
                  border: OutlineInputBorder(),
                ),
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
    // Cards with (Split Title), Category, (Split Amount), Tags, Notes
    for (int i = 0; i < _localAmounts.length; i++) {
      childs.add(
        SizeTransition(
          sizeFactor: _cardsAnimation[i],
          axis: Axis.vertical,
          child: _buildSplitWidget(context, i, showAccountSelection),
        ),
      );
    }
    childs.add(hDivider);
    childs.add(
      FilledButton.icon(
        onPressed: () => splitTransactionAdd(),
        label: Text(S.of(context).transactionSplitAdd),
        icon: const Icon(Icons.call_split),
      ),
    );

    return childs;
  }

  void checkAccountCurrency(AutocompleteAccount option) {
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

  Card _buildSplitWidget(
      BuildContext context, int i, bool showAccountSelection) {
    const Widget hDivider = SizedBox(height: 16);

    return Card(
      key: ValueKey<int>(i),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
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
                  AnimatedHeight(
                    child: showAccountSelection
                        ? Row(
                            children: <Widget>[
                              Expanded(
                                child: AutoCompleteText<AutocompleteAccount>(
                                  labelText: S
                                      .of(context)
                                      .transactionFormLabelAccountForeign,
                                  labelIcon: Icons.account_balance,
                                  textController:
                                      _otherAccountTextControllers[i],
                                  focusNode: _otherAccountFocusNodes[i],
                                  onChanged: (String text) {
                                    splitTransactionCheckAccounts();
                                  },
                                  onSelected: (AutocompleteAccount option) {
                                    splitTransactionCheckAccounts();
                                  },
                                  displayStringForOption:
                                      (AutocompleteAccount option) =>
                                          option.name,
                                  optionsBuilder: (TextEditingValue
                                      textEditingValue) async {
                                    try {
                                      final FireflyIii api =
                                          context.read<FireflyService>().api;
                                      final Response<AutocompleteAccountArray>
                                          response =
                                          await api.v1AutocompleteAccountsGet(
                                        query: textEditingValue.text,
                                        types: _transactionType ==
                                                TransactionTypeProperty
                                                    .withdrawal
                                            ? _transactionType
                                                .destinationAccountTypes
                                            : _transactionType
                                                .sourceAccountTypes,
                                      );
                                      if (!response.isSuccessful ||
                                          response.body == null) {
                                        if (context.mounted) {
                                          throw Exception(
                                            S
                                                .of(context)
                                                .errorAPIInvalidResponse(
                                                    response.error
                                                            ?.toString() ??
                                                        ""),
                                          );
                                        } else {
                                          throw Exception(
                                            "[nocontext] Invalid API response: ${response.error}",
                                          );
                                        }
                                      }
                                      return response.body!;
                                    } catch (e) {
                                      debugPrint(
                                          "Error while fetching autocomplete from API: $e");
                                      return const Iterable<
                                          AutocompleteAccount>.empty();
                                    }
                                  },
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                  AnimatedHeight(
                    child: showAccountSelection
                        ? hDivider
                        : const SizedBox.shrink(),
                  ),
                  TransactionCategory(
                    textController: _categoryTextControllers[i],
                    focusNode: _categoryFocusNodes[i],
                  ),
                  hDivider,
                  TransactionBudget(
                    textController: _budgetTextControllers[i],
                    focusNode: _budgetFocusNodes[i],
                  ),
                  hDivider,
                  AnimatedHeight(
                      child: (_split)
                          ? Row(
                              children: <Widget>[
                                Expanded(
                                  child: NumberInput(
                                    icon: Icon(_transactionType.icon),
                                    controller: (_foreignCurrencies[i] != null)
                                        ? _foreignAmountTextControllers[i]
                                        : _localAmountTextControllers[i],
                                    hintText: _foreignCurrencies[i]?.zero() ??
                                        _localCurrency?.zero() ??
                                        NumberFormat.currency(decimalDigits: 2)
                                            .format(0),
                                    decimals: _foreignCurrencies[i]
                                            ?.attributes
                                            .decimalPlaces ??
                                        _localCurrency
                                            ?.attributes.decimalPlaces ??
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
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox.shrink()),
                  AnimatedHeight(
                    child: (_split) ? hDivider : const SizedBox.shrink(),
                  ),
                  AnimatedHeight(
                    child: (_split && _foreignCurrencies[i] != null)
                        ? Row(
                            children: <Widget>[
                              Expanded(
                                child: NumberInput(
                                  icon: const Icon(Icons.currency_exchange),
                                  controller: _localAmountTextControllers[i],
                                  hintText: _localCurrency?.zero() ??
                                      NumberFormat.currency(decimalDigits: 2)
                                          .format(0),
                                  decimals: _localCurrency
                                          ?.attributes.decimalPlaces ??
                                      2,
                                  prefixText:
                                      "${_localCurrency?.attributes.code} ",
                                  onChanged: (String string) {
                                    _localAmounts[i] =
                                        double.tryParse(string) ?? 0;
                                    splitTransactionCalculateAmount();
                                  },
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
                  TransactionTags(
                    textController: _tagsTextControllers[i],
                    tagsController: _tags[i],
                  ),
                  hDivider,
                  TransactionNote(
                    textController: _noteTextControllers[i],
                  )
                ],
              ),
            ),
            SizedBox(
              width: 48,
              child: Align(
                alignment: Alignment.centerRight,
                child: AnimatedOpacity(
                  opacity: (_split) ? 1 : 0,
                  duration: animDurationStandard,
                  curve: animCurveStandard,
                  child: AnimatedSize(
                    duration: animDurationStandard,
                    curve: animCurveStandard,
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.currency_exchange),
                          onPressed: _split
                              ? () async {
                                  CurrencyRead? newCurrency =
                                      await showDialog<CurrencyRead>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        CurrencyDialog(
                                      currentCurrency: _foreignCurrencies[i] ??
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
                                  setState(() {
                                    _foreignCurrencies[i] = newCurrency;
                                    if (_foreignCurrencies.every(
                                        (CurrencyRead? e) =>
                                            e?.id == newCurrency?.id)) {
                                      _foreignCurrency = newCurrency;
                                    }
                                    splitTransactionCalculateAmount();
                                  });
                                }
                              : null,
                          tooltip: (_split)
                              ? S.of(context).transactionSplitChangeCurrency
                              : null,
                        ),
                        hDivider,
                        if (!showAccountSelection) ...<Widget>[
                          IconButton(
                            icon: const Icon(Icons.add_business),
                            onPressed: _split && !showAccountSelection
                                ? () {
                                    debugPrint(
                                        "adding separate account for $i");
                                    _otherAccountTextControllers[i].text = "";
                                    splitTransactionCheckAccounts();
                                  }
                                : null,
                            tooltip: (_split)
                                ? S.of(context).transactionSplitChangeTarget
                                : null,
                          ),
                          hDivider,
                        ],
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: _split
                              ? () {
                                  debugPrint("marking $i for deletion");
                                  _cardsAnimationController[i].reverse();
                                }
                              : null,
                          tooltip: (_split)
                              ? S.of(context).transactionSplitDelete
                              : null,
                        ),
                      ],
                    ),
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
    debugPrint("TransactionTitle build()");
    return Expanded(
      child: AutoCompleteText<String>(
        labelText: S.of(context).transactionFormLabelTitle,
        labelIcon: Icons.receipt_long,
        textController: textController,
        focusNode: focusNode,
        optionsBuilder: (TextEditingValue textEditingValue) async {
          try {
            final FireflyIii api = context.read<FireflyService>().api;
            final Response<AutocompleteTransactionArray> response = await api
                .v1AutocompleteTransactionsGet(query: textEditingValue.text);
            if (!response.isSuccessful || response.body == null) {
              if (context.mounted) {
                throw Exception(
                  S.of(context).errorAPIInvalidResponse(
                      response.error?.toString() ?? ""),
                );
              } else {
                throw Exception(
                  "[nocontext] Invalid API response: ${response.error}",
                );
              }
            }
            return response.body!.map((AutocompleteTransaction e) => e.name);
          } catch (e) {
            debugPrint("Error while fetching autocomplete from API: $e");
            return const Iterable<String>.empty();
          }
        },
      ),
    );
  }
}

class TransactionNote extends StatelessWidget {
  const TransactionNote({
    super.key,
    required this.textController,
  });

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    debugPrint("TransactionNote build()");
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
                final FireflyIii api = context.read<FireflyService>().api;
                final Response<AutocompleteCategoryArray> response =
                    await api.v1AutocompleteCategoriesGet(
                  query: textEditingValue.text,
                );
                if (!response.isSuccessful || response.body == null) {
                  if (context.mounted) {
                    throw Exception(
                      S.of(context).errorAPIInvalidResponse(
                          response.error?.toString() ?? ""),
                    );
                  } else {
                    throw Exception(
                      "[nocontext] Invalid API response: ${response.error}",
                    );
                  }
                }
                return response.body!.map((AutocompleteCategory e) => e.name);
              } catch (e) {
                debugPrint("Error while fetching autocomplete from API: $e");
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
        final Response<AutocompleteBudgetArray> response =
            await api.v1AutocompleteBudgetsGet(
          query: widget.textController.text,
        );
        if (!response.isSuccessful || response.body == null) {
          if (context.mounted) {
            throw Exception(
              S
                  .of(context)
                  .errorAPIInvalidResponse(response.error?.toString() ?? ""),
            );
          } else {
            throw Exception(
              "[nocontext] Invalid API response: ${response.error}",
            );
          }
        }
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
      } catch (e) {
        debugPrint("Error while fetching autocomplete from API: $e");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: AutoCompleteText<AutocompleteBudget>(
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
                final FireflyIii api = context.read<FireflyService>().api;
                final Response<AutocompleteBudgetArray> response =
                    await api.v1AutocompleteBudgetsGet(
                  query: textEditingValue.text,
                );
                if (!response.isSuccessful || response.body == null) {
                  if (context.mounted) {
                    throw Exception(
                      S.of(context).errorAPIInvalidResponse(
                          response.error?.toString() ?? ""),
                    );
                  } else {
                    throw Exception(
                      "[nocontext] Invalid API response: ${response.error}",
                    );
                  }
                }
                return response.body!;
              } catch (e) {
                debugPrint("Error while fetching autocomplete from API: $e");
                return const Iterable<AutocompleteBudget>.empty();
              }
            },
          ),
        ),
      ],
    );
  }
}
