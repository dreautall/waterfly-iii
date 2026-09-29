import 'dart:async';

import 'package:async/async.dart';
import 'package:chopper/chopper.dart' show Response;
import 'package:flutter/services.dart';
import 'package:flutter_sharing_intent/model/sharing_file.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logging/logging.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/layout.dart';
import 'package:waterflyiii/notificationlistener.dart';
import 'package:waterflyiii/notifications/application/processing/notification_transaction_intent_adapter.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_intent.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_patch.dart';
import 'package:waterflyiii/pages/navigation.dart';
import 'package:waterflyiii/pages/transaction/dialogs/delete.dart';
import 'package:waterflyiii/pages/transaction/headersection.dart';
import 'package:waterflyiii/pages/transaction/splitcard.dart';
import 'package:waterflyiii/pages/transaction/state.dart';
import 'package:waterflyiii/pages/transaction/tags.dart';
import 'package:waterflyiii/settings.dart';
import 'package:waterflyiii/stock.dart';
import 'package:waterflyiii/theme.dart';
import 'package:waterflyiii/timezonehandler.dart';
import 'package:waterflyiii/widgets/autocompletetext.dart';

final Logger log = Logger("Pages.Transaction");

bool _savingInProgress = false;

class _NotificationAccountResolutionException implements Exception {
  const _NotificationAccountResolutionException(this.message);

  final String message;

  @override
  String toString() => message;
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

  bool _txTypeChipExtended = false;
  late TransactionTypeProperty _lastTXType;
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

    _tzHandler = context.read<FireflyService>().tzHandler;
    // opening an existing transaction, extract information
    if (widget.transaction != null) {
      _tx = .fromExisting(widget.transaction!, _tzHandler, clone: widget.clone);
      _tx.updateAmount();
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

      final List<String> autoTags = context.read<SettingsProvider>().autoTagAll;
      for (String s in autoTags) {
        _tx.splits.first.tags.add(s);
      }

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        _tx.splits.first.titleFN.requestFocus();
        if (widget.notification != null) {
          try {
            await _applyNotificationIntent(
              widget.notification!.intent,
              widget.notification!.date,
            );
          } catch (error, stackTrace) {
            log.severe(
              "Failed to resolve notification transaction accounts",
              error,
              stackTrace,
            );
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(error.toString()), behavior: .floating),
              );
            }
          }
          if (mounted) {
            final List<String> autoTagsNL = context
                .read<SettingsProvider>()
                .autoTagNL;
            for (String s in autoTagsNL) {
              _tx.splits.first.tags.add(s);
            }
          }
        }

        // Created from account screen, set account already
        if (widget.accountId != null && mounted) {
          final FireflyIii api = context.read<FireflyService>().api;
          final Response<AccountSingle> response = await api.v1AccountsIdGet(
            id: widget.accountId,
          );
          if (response.isSuccessful && response.body != null) {
            final AccountRead acc = response.body!.data;
            final AutocompleteAccount option = AutocompleteAccount(
              id: acc.id,
              name: acc.attributes.name,
              nameWithBalance: acc.attributes.name,
              type: AccountTypeProperty.assetAccount.value!,
              currencyId: acc.attributes.currencyId ?? "",
              currencyName: acc.attributes.currencyName ?? "",
              currencyCode: acc.attributes.currencyCode ?? "",
              currencySymbol: acc.attributes.currencySymbol ?? "",
              currencyDecimalPlaces: acc.attributes.currencyDecimalPlaces ?? 2,
            );
            _tx.selectSourceAccount(option);
          } else {
            log.warning("api account fetch failed");
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
        unawaited(onTXChanged());
      });
    }

    _lastTXType = _tx.type;
    _tx.addListener(onTXChanged);
    onTXChanged();
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
      if (!_tx.newTX) ...<Widget>[
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

                final String? historyEntryId =
                    widget.notification?.historyEntryId;
                if (historyEntryId != null) {
                  try {
                    final bool linked =
                        await linkNotificationTransactionHistory(
                          historyEntryId: historyEntryId,
                          transactionId: newTX.id,
                        );
                    if (!linked) {
                      log.warning(
                        'Could not link transaction ${newTX.id} to notification history $historyEntryId because the history entry is unavailable.',
                      );
                    }
                  } catch (error, stackTrace) {
                    log.warning(
                      'Could not link transaction ${newTX.id} to notification history $historyEntryId.',
                      error,
                      stackTrace,
                    );
                  }
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
          scrollCacheExtent: const .pixels(10000),
          padding: const .symmetric(horizontal: 24, vertical: 16),
          children: _transactionDetailBuilder(context),
        ),
      ),
    );
    if (context.read<LayoutProvider>().currentSize >= .expanded &&
        _tx.newTX &&
        !widget.clone) {
      // Via FAB opened in a dialog
      return body;
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            _tx.newTX
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
                  : context.transactionColor(_tx.type),
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

  Future<void> _applyNotificationIntent(
    TransactionIntent intent,
    DateTime receivedAt,
  ) async {
    final TransactionPatch patch = intent.patch;
    final TransactionSplitState split = _tx.splits.first;
    final String? sourceId = patch.values[TransactionField.sourceAccount];
    final String? destinationId =
        patch.values[TransactionField.destinationAccount];

    _tx.type = TransactionTypeProperty.swaggerGeneratedUnknown;
    _tx.sourceAccountType = AccountTypeProperty.swaggerGeneratedUnknown;
    _tx.destinationAccountType = AccountTypeProperty.swaggerGeneratedUnknown;
    _tx.ownAccountID = null;
    split.sourceAccountTC.text =
        patch.resourceReferences[TransactionField.sourceAccount]?.id ??
        patch.displayValue(TransactionField.sourceAccount);
    split.destinationAccountTC.text =
        patch.resourceReferences[TransactionField.destinationAccount]?.id ??
        patch.displayValue(TransactionField.destinationAccount);
    split.titleTC.text = patch.values[TransactionField.title] ?? '';
    split.noteTC.text = patch.values[TransactionField.notes] ?? '';
    split.categoryTC.text = patch.displayValue(TransactionField.category);
    split.tags = Tags(<String>[
      ...patch.tags,
      if (patch.displayValue(TransactionField.tag).trim().isNotEmpty)
        patch.displayValue(TransactionField.tag).trim(),
    ]);

    final double? amount = double.tryParse(
      (patch.values[TransactionField.amount] ?? '').replaceAll(',', '.'),
    );
    if (amount != null) {
      split.localAmount = amount;
      split.localAmountUpdateText();
    }

    final DateTime date = NotificationTransactionIntentAdapter.transactionDate(
      patch,
      fallbackDate: receivedAt,
    );
    _tx.date = _tzHandler.notificationTXTime(date).toLocal();

    final String? billId = patch.values[TransactionField.subscription];
    if (billId != null) {
      split.bill = BillRead(
        type: 'bill',
        id: billId,
        attributes: BillProperties(
          name: patch.displayValue(TransactionField.subscription),
          amountMin: '',
          amountMax: '',
          date: receivedAt,
          repeatFreq: BillRepeatFrequency.swaggerGeneratedUnknown,
        ),
      );
    }

    final String? piggyBankId = patch.values[TransactionField.piggyBank];
    if (piggyBankId != null) {
      split.piggy = PiggyBankRead(
        type: 'piggybank',
        id: piggyBankId,
        attributes: PiggyBankProperties(
          name: patch.displayValue(TransactionField.piggyBank),
        ),
        links: const ObjectLink(),
      );
    }

    final FireflyIii api = context.read<FireflyService>().api;
    if (sourceId != null) {
      _tx.selectSourceAccount(
        await _resolveNotificationAccount(
          api,
          value: sourceId,
          displayName:
              patch.resourceReferences[TransactionField.sourceAccount]?.id ??
              patch.displayValue(TransactionField.sourceAccount),
          isResourceReference:
              patch.resourceReferences.containsKey(
                TransactionField.sourceAccount,
              ) ||
              patch.displayValues.containsKey(TransactionField.sourceAccount),
        ),
      );
    }
    if (destinationId != null) {
      _tx.selectDestinationAccount(
        await _resolveNotificationAccount(
          api,
          value: destinationId,
          displayName:
              patch
                  .resourceReferences[TransactionField.destinationAccount]
                  ?.id ??
              patch.displayValue(TransactionField.destinationAccount),
          isResourceReference:
              patch.resourceReferences.containsKey(
                TransactionField.destinationAccount,
              ) ||
              patch.displayValues.containsKey(
                TransactionField.destinationAccount,
              ),
        ),
      );
    }

    final String? currencyId = patch.values[TransactionField.currency];
    if (currencyId != null) {
      final String code =
          patch.currencyCodes[TransactionField.currency] ??
          patch.displayValue(TransactionField.currency);
      _tx.localCurrency = CurrencyRead(
        type: 'currencies',
        id: currencyId,
        attributes: CurrencyProperties(
          code: code,
          name: patch.displayValue(TransactionField.currency),
          symbol: code,
          decimalPlaces: _tx.localCurrency.attributes.decimalPlaces,
        ),
      );
      split.localAmountUpdateText();
    }
  }

  Future<AutocompleteAccount> _resolveNotificationAccount(
    FireflyIii api, {
    required String value,
    required String displayName,
    required bool isResourceReference,
  }) async {
    final String unavailableMessage = S
        .of(context)
        .notificationsTransactionAccountUnavailable(displayName);
    String query = displayName;
    if (isResourceReference) {
      final Response<AccountSingle> accountResponse = await api.v1AccountsIdGet(
        id: value,
      );
      apiThrowErrorIfEmpty(accountResponse, mounted ? context : null);
      query = accountResponse.body!.data.attributes.name;
    }
    final Response<AutocompleteAccountArray> response = await api
        .v1AutocompleteAccountsGet(query: query);
    apiThrowErrorIfEmpty(response, mounted ? context : null);
    for (final AutocompleteAccount account in response.body!) {
      final bool matches = isResourceReference
          ? account.id == value
          : account.name.toLowerCase() == value.toLowerCase();
      if (matches) return account;
    }
    throw _NotificationAccountResolutionException(unavailableMessage);
  }

  Widget _buildSplitWidget(BuildContext context, int i) {
    return TransactionSplitCard(
      index: i,
      readOnly: _tx.reconciled && _tx.initiallyReconciled,
      saving: _savingInProgress,
      split: _tx.splits[i],
      tx: _tx,
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

        if (mounted) {
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
