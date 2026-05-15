import 'dart:async';

import 'package:async/async.dart';
import 'package:badges/badges.dart' as badges;
import 'package:chopper/chopper.dart' show Response;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sharing_intent/model/sharing_file.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/layout.dart';
import 'package:waterflyiii/notificationlistener.dart';
import 'package:waterflyiii/pages/navigation.dart';
import 'package:waterflyiii/pages/transaction/dialogs/bill.dart';
import 'package:waterflyiii/pages/transaction/dialogs/currency.dart';
import 'package:waterflyiii/pages/transaction/dialogs/delete.dart';
import 'package:waterflyiii/pages/transaction/dialogs/piggy.dart';
import 'package:waterflyiii/pages/transaction/headersection.dart';
import 'package:waterflyiii/pages/transaction/state.dart';
import 'package:waterflyiii/pages/transaction/tags.dart';
import 'package:waterflyiii/pages/transaction/title.dart';
import 'package:waterflyiii/settings.dart';
import 'package:waterflyiii/stock.dart';
import 'package:waterflyiii/timezonehandler.dart';
import 'package:waterflyiii/widgets/autocompletetext.dart';
import 'package:waterflyiii/widgets/input_number.dart';
import 'package:waterflyiii/widgets/materialiconbutton.dart';

final Logger log = Logger("Pages.Transaction");

bool _savingInProgress = false;

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

  bool _txTypeChipExtended = false;
  late TransactionTypeProperty _lastTXType;
  late bool _newTX;
  late TimeZoneHandler _tzHandler;

  // Common fields
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
      if (_tx.attachments == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          updateAttachmentCount();
        });
      }
    } else {
      // New transaction
      _tx = TransactionState(context.read<FireflyService>().defaultCurrency);
      splitTransactionAdd();

      if (widget.notification != null) {
        _tx.date = _tzHandler
            .notificationTXTime(widget.notification!.date)
            .toLocal();
      } else {
        _tx.date = _tzHandler.newTXTime().toLocal();
      }

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        _tx.groupTitleFN.requestFocus();
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
            _tx.addAttachment(
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

  void Function(AnimationStatus) deleteCardAnimated(int i) {
    return (AnimationStatus status) {
      if (status == .dismissed) {
        splitTransactionRemove(i);
      }
    };
  }

  void splitTransactionAdd() {
    log.fine(() => "splitTransactionAdd()");
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

  void splitTransactionRemove(int i) {
    log.fine(() => "removing split $i");
    _tx.splitRemove(i);

    _cardsAnimationController.removeAt(i).dispose();
    _cardsAnimation.removeAt(i);

    // Update summary values
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

                if (_tx.ownAccountID == null) {
                  error = S.of(context).transactionErrorNoAssetAccount;
                }
                if (_tx.groupTitleTC.text.isEmpty &&
                    _tx.splits.first.titleTC.text.isEmpty) {
                  error = S.of(context).transactionErrorTitle;
                }
                if (user == null || stock == null) {
                  error = S.of(context).errorAPIUnavailable;
                }
                if (_tx.type == .swaggerGeneratedUnknown) {
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

                late final TransactionRead newTX;

                try {
                  newTX = await _tx.save(api, user!);
                } catch (e, stack) {
                  log.severe("Failed to save transaction", e, stack);
                  error = e.toString();
                  if (error.isEmpty) {
                    error = (context.mounted
                        ? S.of(context).errorUnknown
                        : "[nocontext] Unknown error.");
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
                await stock!.setTransaction(newTX);

                // Done saving
                setState(() => _savingInProgress = false);

                if (nav.canPop()) {
                  // Popping true means that the TX list will be refreshed.
                  // This should only happen if:
                  // 1. it is a new transaction
                  // 2. the date has been changed (changing the order of the TX list)
                  nav.pop(
                    widget.transaction == null ||
                        _tx.date !=
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
                }
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
        totalAmountTC: _tx.totalAmountTC,
        totalAmountFN: _tx.totalAmountFN,
        saving: _savingInProgress,
        readOnly: _tx.reconciled && _tx.initiallyReconciled,
      ),
    );
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

    _commonSourceTC.text = _tx.hasCommonSourceAccount
        ? _tx.splits.first.sourceAccountTC.text
        : "<${S.of(context).generalMultiple}>";

    _commonDestinationTC.text = _tx.hasCommonDestinationAccount
        ? _tx.splits.first.destinationAccountTC.text
        : "<${S.of(context).generalMultiple}>";

    if (_tx.type != _lastTXType) {
      await handleTXTypeChange();
      _lastTXType = _tx.type;
    }

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

  Widget _buildSplitWidget(BuildContext context, int i) {
    return TransactionSplitCard(
      index: i,
      readOnly: _tx.reconciled && _tx.initiallyReconciled,
      saving: _savingInProgress,
      split: _tx.splits[i],
      tx: _tx,
      newTX: _newTX,
      onDelete: _cardsAnimationController[i].reverse,
    );
  }
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

class TransactionSplitCard extends StatelessWidget {
  const TransactionSplitCard({
    super.key,
    required this.split,
    required this.tx,
    required this.index,
    required this.saving,
    required this.readOnly,
    required this.newTX,
    required this.onDelete,
  });

  final TransactionSplitState split;
  final TransactionState tx;
  final int index;
  final bool saving;
  final bool readOnly;
  final bool newTX;
  final TickerFuture Function() onDelete;

  @override
  Widget build(BuildContext context) {
    const Widget hDivider = SizedBox(height: 16);
    return Card(
      key: ValueKey<int>(index),
      child: Padding(
        padding: const .all(16),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  // (Split) Transaction title
                  AnimatedHeight(
                    child: tx.split
                        ? _buildTitle(context)
                        : const SizedBox.shrink(),
                  ),
                  AnimatedHeight(
                    child: tx.split ? hDivider : const SizedBox.shrink(),
                  ),
                  // (Split) Source Account
                  AnimatedHeight(
                    child: tx.showSplitSourceAccounts
                        ? _buildSourceAccount(context)
                        : const SizedBox.shrink(),
                  ),
                  AnimatedHeight(
                    child: tx.showSplitSourceAccounts
                        ? hDivider
                        : const SizedBox.shrink(),
                  ),
                  // (Split) Destination Account
                  AnimatedHeight(
                    child: tx.showSplitDestinationAccounts
                        ? _buildDestinationAccount(context)
                        : const SizedBox.shrink(),
                  ),
                  AnimatedHeight(
                    child: tx.showSplitDestinationAccounts
                        ? hDivider
                        : const SizedBox.shrink(),
                  ),
                  // Category (always)
                  TransactionCategory(
                    textController: split.categoryTC,
                    focusNode: split.categoryFN,
                  ),
                  hDivider,
                  // Budget (for withdrawals)
                  AnimatedHeight(
                    child: (tx.type == .withdrawal)
                        ? TransactionBudget(
                            textController: split.budgetTC,
                            focusNode: split.budgetFN,
                          )
                        : const SizedBox.shrink(),
                  ),
                  AnimatedHeight(
                    child: (tx.type == .withdrawal)
                        ? hDivider
                        : const SizedBox.shrink(),
                  ),
                  // (Split) Foreign Currency
                  AnimatedHeight(
                    child: (tx.split || split.foreignCurrency != null)
                        ? Row(
                            children: <Widget>[
                              Expanded(
                                child: NumberInput(
                                  icon: (split.foreignCurrency != null)
                                      ? const Icon(Icons.currency_exchange)
                                      : const Icon(Icons.monetization_on),
                                  controller: (split.foreignCurrency != null)
                                      ? split.foreignAmountTC
                                      : split.localAmountTC,
                                  hintText:
                                      split.foreignCurrency?.zero() ??
                                      split.localCurrency.zero(),
                                  decimals:
                                      split
                                          .foreignCurrency
                                          ?.attributes
                                          .decimalPlaces ??
                                      split
                                          .localCurrency
                                          .attributes
                                          .decimalPlaces ??
                                      2,
                                  prefixText:
                                      "${split.foreignCurrency?.attributes.code ?? split.localCurrency.attributes.code} ",
                                  onChanged: (String string) {
                                    if (split.foreignCurrency != null) {
                                      split.foreignAmount =
                                          double.tryParse(string) ?? 0;
                                    } else {
                                      split.localAmount =
                                          double.tryParse(string) ?? 0;
                                    }
                                  },
                                  disabled: saving || readOnly,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                  AnimatedHeight(
                    child: (tx.split || split.foreignCurrency != null)
                        ? hDivider
                        : const SizedBox.shrink(),
                  ),
                  // (Split) Local Currency (when foreign selected)
                  AnimatedHeight(
                    child: (tx.split && split.foreignCurrency != null)
                        ? Row(
                            children: <Widget>[
                              Expanded(
                                child: NumberInput(
                                  icon: const Icon(Icons.currency_exchange),
                                  controller: split.localAmountTC,
                                  hintText: split.localCurrency.zero(),
                                  decimals:
                                      split
                                          .localCurrency
                                          .attributes
                                          .decimalPlaces ??
                                      2,
                                  prefixText:
                                      "${split.localCurrency.attributes.code} ",
                                  onChanged: (String string) {
                                    split.localAmount =
                                        double.tryParse(string) ?? 0;
                                  },
                                  disabled: saving || readOnly,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                  AnimatedHeight(
                    child: (tx.split && split.foreignCurrency != null)
                        ? hDivider
                        : const SizedBox.shrink(),
                  ),
                  // Tags (always)
                  TransactionTags(
                    interactable: !saving,
                    textController: split.tagsTC,
                    tagsController: split.tags,
                  ),
                  // Note (always)
                  hDivider,
                  TransactionNote(textController: split.noteTC),
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
                        isSelected: tx.reconciled,
                        selectedIcon: const Icon(Icons.done),
                        onPressed: _savingInProgress
                            ? null
                            : () {
                                tx.reconciled = !tx.reconciled;
                                tx.initiallyReconciled = false;
                                tx.notify();
                              },
                        tooltip: S.of(context).generalReconcile,
                      ),
                      hDivider,
                      // Bills Button
                      IconButton(
                        icon: const Icon(Icons.calendar_today),
                        isSelected: split.bill != null,
                        selectedIcon: const Icon(Icons.event_available),
                        onPressed: _savingInProgress
                            ? null
                            : () async {
                                BillRead? newBill = await showDialog<BillRead>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) =>
                                      BillDialog(currentBill: split.bill),
                                );
                                // Back button returns "null"
                                if (newBill == null) {
                                  return;
                                }
                                // Delete bill returns id "0"
                                if (newBill.id.isEmpty || newBill.id == "0") {
                                  newBill = null;
                                }
                                if (newBill != split.bill) {
                                  split.bill = newBill;
                                  tx.notify();
                                }
                              },
                        tooltip: S.of(context).transactionDialogBillTitle,
                      ),
                      hDivider,
                      // Foreign Currency Button
                      IconButton(
                        icon: const Icon(Icons.currency_exchange),
                        isSelected: split.foreignCurrency != null,
                        onPressed: _savingInProgress
                            ? null
                            : !readOnly
                            ? () async {
                                CurrencyRead? newCurrency =
                                    await showDialog<CurrencyRead>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          CurrencyDialog(
                                            currentCurrency:
                                                split.foreignCurrency ??
                                                split.localCurrency,
                                          ),
                                    );
                                if (newCurrency == null) {
                                  return;
                                }

                                if (newCurrency.id == split.localCurrency.id) {
                                  newCurrency = null;
                                  split.foreignAmount = 0;
                                  split.foreignAmountTC.text = "";
                                }

                                log.fine(
                                  () =>
                                      "adding foreign currency ${newCurrency?.id ?? "null"} for $index",
                                );

                                split.foreignCurrency = newCurrency;
                                tx.notify();
                              }
                            : null,
                        tooltip: (tx.split)
                            ? S.of(context).transactionSplitChangeCurrency
                            : null,
                      ),
                      // Piggy Bank Button
                      // Only on new TX (similar to Firefly webinterface)
                      if (newTX) ...<Widget>[
                        hDivider,
                        IconButton(
                          icon: const Icon(Icons.savings_outlined),
                          isSelected: split.piggy != null,
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
                                              currentPiggy: split.piggy,
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
                                  if (newPiggy != split.piggy) {
                                    split.piggy = newPiggy;
                                    tx.notify();
                                  }
                                },
                          tooltip: S.of(context).transactionDialogPiggyTitle,
                        ),
                        hDivider,
                        // (Split) Source Account Button (for deposits)
                        if (tx.split) ...<Widget>[
                          if (!tx.showSplitSourceAccounts &&
                              tx.type == .deposit) ...<Widget>[
                            IconButton(
                              icon: const Icon(Icons.add_business),
                              onPressed: _savingInProgress
                                  ? null
                                  : tx.split &&
                                        !tx.showSplitSourceAccounts &&
                                        tx.type == .deposit &&
                                        !readOnly
                                  ? () {
                                      log.fine(
                                        () =>
                                            "adding separate source account for $index",
                                      );
                                      split.sourceAccountTC.text = "";
                                      tx.notify();
                                    }
                                  : null,
                              tooltip: (tx.split)
                                  ? S
                                        .of(context)
                                        .transactionSplitChangeSourceAccount
                                  : null,
                            ),
                            hDivider,
                          ],
                          // (Split) Destination Account Button (for withdrawals)
                          if (!tx.showSplitDestinationAccounts &&
                              tx.type == .withdrawal) ...<Widget>[
                            IconButton(
                              icon: const Icon(Icons.add_business),
                              onPressed: _savingInProgress
                                  ? null
                                  : tx.split &&
                                        !tx.showSplitDestinationAccounts &&
                                        tx.type == .withdrawal &&
                                        !readOnly
                                  ? () {
                                      log.fine(
                                        () =>
                                            "adding separate destination account for $index",
                                      );
                                      tx.notify();
                                      split.destinationAccountTC.text = "";
                                    }
                                  : null,
                              tooltip: (tx.split)
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
                                : tx.split && !readOnly
                                ? () {
                                    log.fine(
                                      () => "marking $index for deletion",
                                    );
                                    onDelete();
                                  }
                                : null,
                            tooltip: (tx.split)
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
    );
  }

  Widget _buildTitle(BuildContext context) => Row(
    children: <Widget>[
      TransactionTitle(textController: split.titleTC, focusNode: split.titleFN),
    ],
  );

  Widget _buildSourceAccount(BuildContext context) {
    CancelableOperation<Response<AutocompleteAccountArray>>? fetchOp;

    return Row(
      children: <Widget>[
        Expanded(
          child: AutoCompleteText<AutocompleteAccount>(
            disabled: _savingInProgress,
            labelText: S.of(context).generalSourceAccount,
            labelIcon: Icons.logout,
            textController: split.sourceAccountTC,
            focusNode: split.sourceAccountFN,
            displayStringForOption: (AutocompleteAccount option) => option.name,
            // onChanged not required - monitored via FocusNode
            onSelected: (AutocompleteAccount option) {
              split.sourceAccountTC.text = option.name;
              // Notify to remove text field again
              if (tx.hasCommonSourceAccount) {
                tx.notify();
              }
            },
            optionsBuilder: (TextEditingValue textEditingValue) async {
              try {
                unawaited(fetchOp?.cancel());

                final FireflyIii api = context.read<FireflyService>().api;
                fetchOp =
                    CancelableOperation<
                      Response<AutocompleteAccountArray>
                    >.fromFuture(
                      api.v1AutocompleteAccountsGet(
                        query: textEditingValue.text,
                        types: tx.destinationAccountType.allowedOpposingTypes(
                          false,
                        ),
                      ),
                    );
                final Response<AutocompleteAccountArray>? response =
                    await fetchOp?.valueOrCancellation();
                if (response == null) {
                  // Cancelled
                  return const Iterable<AutocompleteAccount>.empty();
                }
                apiThrowErrorIfEmpty(
                  response,
                  context.mounted ? context : null,
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
          ),
        ),
      ],
    );
  }

  Widget _buildDestinationAccount(BuildContext context) {
    CancelableOperation<Response<AutocompleteAccountArray>>? fetchOp;

    return Row(
      children: <Widget>[
        Expanded(
          child: AutoCompleteText<AutocompleteAccount>(
            disabled: _savingInProgress,
            labelText: S.of(context).generalDestinationAccount,
            labelIcon: Icons.login,
            textController: split.destinationAccountTC,
            focusNode: split.destinationAccountFN,
            // onChanged not required - monitored via FocusNode
            onSelected: (AutocompleteAccount option) {
              split.destinationAccountTC.text = option.name;
              // Notify to remove text field again
              if (tx.hasCommonDestinationAccount) {
                tx.notify();
              }
            },
            displayStringForOption: (AutocompleteAccount option) => option.name,
            optionsBuilder: (TextEditingValue textEditingValue) async {
              try {
                final FireflyIii api = context.read<FireflyService>().api;
                fetchOp =
                    CancelableOperation<
                      Response<AutocompleteAccountArray>
                    >.fromFuture(
                      api.v1AutocompleteAccountsGet(
                        query: textEditingValue.text,
                        types: tx.sourceAccountType.allowedOpposingTypes(true),
                      ),
                    );
                final Response<AutocompleteAccountArray>? response =
                    await fetchOp?.valueOrCancellation();
                if (response == null) {
                  // Cancelled
                  return const Iterable<AutocompleteAccount>.empty();
                }
                apiThrowErrorIfEmpty(
                  response,
                  context.mounted ? context : null,
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
