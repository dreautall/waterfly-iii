import 'dart:async';

import 'package:async/async.dart';
import 'package:chopper/chopper.dart' show Response;
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/pages/transaction.dart';
import 'package:waterflyiii/pages/transaction/dialogs/bill.dart';
import 'package:waterflyiii/pages/transaction/dialogs/currency.dart';
import 'package:waterflyiii/pages/transaction/dialogs/piggy.dart';
import 'package:waterflyiii/pages/transaction/state.dart';
import 'package:waterflyiii/pages/transaction/tags.dart';
import 'package:waterflyiii/pages/transaction/title.dart';
import 'package:waterflyiii/widgets/autocompletetext.dart';
import 'package:waterflyiii/widgets/input_number.dart';

final Logger log = Logger("Pages.Transaction.SplitCard");

class TransactionSplitCard extends StatelessWidget {
  const TransactionSplitCard({
    super.key,
    required this.split,
    required this.tx,
    required this.index,
    required this.saving,
    required this.readOnly,
    required this.onDelete,
  });

  final TransactionSplitState split;
  final TransactionState tx;
  final int index;
  final bool saving;
  final bool readOnly;
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
                        onPressed: saving
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
                        onPressed: saving
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
                        onPressed: saving
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
                      if (tx.newTX) ...<Widget>[
                        hDivider,
                        IconButton(
                          icon: const Icon(Icons.savings_outlined),
                          isSelected: split.piggy != null,
                          selectedIcon: const Icon(Icons.savings),
                          onPressed: saving
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
                              onPressed: saving
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
                              onPressed: saving
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
                            onPressed: saving
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
            disabled: saving,
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
            disabled: saving,
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
