import 'dart:async';

import 'package:chopper/chopper.dart' show Response;
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/pages/transaction/tags.dart';
import 'package:waterflyiii/settings.dart';

final Logger log = Logger("Pages.Home.Transaction.Filter");

class TransactionFilters with ChangeNotifier {
  TransactionFilters({
    this.account,
    this.text,
    this.currency,
    this.category,
    this.budget,
    this.bill,
    this.tags,
  });

  AccountRead? account;
  String? text;
  CurrencyRead? currency;
  CategoryRead? category;
  BudgetRead? budget;
  BillRead? bill;
  Tags? tags = Tags();

  bool _hasFilters = false;
  bool get hasFilters => _hasFilters;

  void updateFilters() {
    _hasFilters =
        account != null ||
        text != null ||
        currency != null ||
        category != null ||
        budget != null ||
        bill != null ||
        (tags?.tags.isNotEmpty ?? false);
    log.finest(() => "notify TransactionFilters, filters? $hasFilters");
    notifyListeners();
  }

  TransactionFilters copyWith({
    AccountRead? account,
    String? text,
    CurrencyRead? currency,
    CategoryRead? category,
    BudgetRead? budget,
    BillRead? bill,
    Tags? tags,
  }) => TransactionFilters(
    account: account ?? this.account,
    text: text ?? this.text,
    currency: currency ?? this.currency,
    category: category ?? this.category,
    budget: budget ?? this.budget,
    bill: bill ?? this.bill,
    tags: tags ?? this.tags,
  );

  void reset() {
    account = null;
    text = null;
    currency = null;
    category = null;
    budget = null;
    bill = null;
    tags = Tags();
  }
}

class FilterData {
  FilterData(
    this.accounts,
    this.currencies,
    this.categories,
    this.budgets,
    this.bills,
  );

  final List<AccountRead> accounts;
  final List<CurrencyRead> currencies;
  final List<CategoryRead> categories;
  final List<BudgetRead> budgets;
  final List<BillRead> bills;
}

class FilterDialog extends StatelessWidget {
  const FilterDialog({super.key, required this.filters});

  final TransactionFilters filters;

  Future<FilterData> _getData(BuildContext context) async {
    final FireflyIii api = context.read<FireflyService>().api;

    final (
      Response<AccountArray> respAccounts,
      Response<CurrencyArray> respCurrencies,
      Response<CategoryArray> respCats,
      Response<BudgetArray> respBudgets,
      Response<BillArray> respBills,
    ) = await (
          api.v1AccountsGet(type: AccountTypeFilter.assetAccount),
          api.v1CurrenciesGet(),
          api.v1CategoriesGet(),
          api.v1BudgetsGet(),
          api.v1BillsGet(),
        ).wait;
    apiThrowErrorIfEmpty(respAccounts, context.mounted ? context : null);
    apiThrowErrorIfEmpty(respCurrencies, context.mounted ? context : null);
    apiThrowErrorIfEmpty(respCats, context.mounted ? context : null);
    apiThrowErrorIfEmpty(respBudgets, context.mounted ? context : null);
    apiThrowErrorIfEmpty(respBills, context.mounted ? context : null);

    return FilterData(
      respAccounts.body!.data,
      respCurrencies.body!.data,
      respCats.body!.data,
      respBudgets.body!.data,
      respBills.body!.data,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Logger log = Logger("Pages.Home.Transaction.Filter.Dialog");

    log.finest(() => "build()");
    final bool oldShowFutureTXs =
        context.read<SettingsProvider>().showFutureTXs;
    final TransactionDateFilter oldTransactionDateFilter =
        context.read<SettingsProvider>().transactionDateFilter;

    return AlertDialog(
      icon: const Icon(Icons.tune),
      title: Text(S.of(context).homeTransactionsDialogFilterTitle),
      clipBehavior: Clip.hardEdge,
      actions: <Widget>[
        TextButton(
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          onPressed: () {
            // Revert on cancel
            context.read<SettingsProvider>().showFutureTXs = oldShowFutureTXs;
            context.read<SettingsProvider>().setTransactionDateFilter(
              oldTransactionDateFilter,
            );
            Navigator.of(context).pop();
          },
        ),
        OutlinedButton(
          child: Text(S.of(context).generalReset),
          onPressed: () {
            filters.reset();
            // Reset to defaults
            context.read<SettingsProvider>().showFutureTXs = false;
            context.read<SettingsProvider>().setTransactionDateFilter(
              TransactionDateFilter.all,
            );
            Navigator.of(context).pop(true);
          },
        ),
        FilledButton(
          child: Text(MaterialLocalizations.of(context).saveButtonLabel),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FutureBuilder<FilterData>(
              future: _getData(context),
              builder: (
                BuildContext context,
                AsyncSnapshot<FilterData> snapshot,
              ) {
                if (snapshot.hasData && snapshot.data != null) {
                  final List<Widget> child = <Widget>[];
                  final double inputWidth =
                      MediaQuery.of(context).size.width - 128 - 24;

                  // Show future TXs
                  child.add(
                    SizedBox(
                      width: inputWidth,
                      child: CheckboxListTile(
                        value: context.watch<SettingsProvider>().showFutureTXs,
                        onChanged:
                            (bool? value) =>
                                context.read<SettingsProvider>().showFutureTXs =
                                    value ?? false,
                        title: Text(
                          S
                              .of(context)
                              .homeTransactionsDialogFilterFutureTransactions,
                        ),
                      ),
                    ),
                  );
                  child.add(const SizedBox(height: 12));

                  // Transaction Date Filter Dropdown
                  child.add(
                    DropdownMenu<TransactionDateFilter>(
                      initialSelection:
                          context
                              .read<SettingsProvider>()
                              .transactionDateFilter,
                      leadingIcon: const Icon(Icons.date_range),
                      label: Text(
                        S.of(context).homeTransactionsDialogFilterDateRange,
                      ),
                      dropdownMenuEntries:
                          TransactionDateFilter.values
                              .map(
                                (TransactionDateFilter filter) =>
                                    DropdownMenuEntry<TransactionDateFilter>(
                                      value: filter,
                                      label: _getFilterName(context, filter),
                                    ),
                              )
                              .toList(),
                      onSelected: (TransactionDateFilter? newValue) {
                        if (newValue != null) {
                          context
                              .read<SettingsProvider>()
                              .setTransactionDateFilter(newValue);
                        }
                      },
                      width: inputWidth,
                    ),
                  );
                  child.add(const SizedBox(height: 12));

                  // Search Term
                  child.add(
                    SizedBox(
                      width: inputWidth,
                      child: TextFormField(
                        decoration: InputDecoration(
                          filled: false,
                          border: const OutlineInputBorder(),
                          labelText:
                              S.of(context).homeTransactionsDialogFilterSearch,
                          prefixIcon: const Icon(Icons.search),
                        ),
                        initialValue: filters.text,
                        onChanged: (String value) {
                          filters.text = value;
                          if (value.isEmpty) {
                            filters.text = null;
                          }
                        },
                      ),
                    ),
                  );
                  child.add(const SizedBox(height: 12));

                  // Account Select
                  final List<DropdownMenuEntry<AccountRead>>
                  accountOptions = <DropdownMenuEntry<AccountRead>>[
                    DropdownMenuEntry<AccountRead>(
                      value: AccountRead(
                        id: "0",
                        type: "dummy",
                        attributes: AccountProperties(
                          name:
                              S
                                  .of(context)
                                  .homeTransactionsDialogFilterAccountsAll,
                          type:
                              ShortAccountTypeProperty.swaggerGeneratedUnknown,
                        ),
                      ),
                      label:
                          S.of(context).homeTransactionsDialogFilterAccountsAll,
                    ),
                  ];
                  AccountRead? currentAccount = accountOptions.first.value;
                  for (AccountRead e in snapshot.data!.accounts) {
                    accountOptions.add(
                      DropdownMenuEntry<AccountRead>(
                        value: e,
                        label: e.attributes.name,
                      ),
                    );
                    if (filters.account?.id == e.id) {
                      currentAccount = e;
                    }
                  }
                  child.add(
                    DropdownMenu<AccountRead>(
                      initialSelection: currentAccount,
                      leadingIcon: const Icon(Icons.account_balance),
                      label: Text(S.of(context).generalAccount),
                      dropdownMenuEntries: accountOptions,
                      onSelected: (AccountRead? account) {
                        if ((account?.id ?? "0") == "0") {
                          filters.account = null;
                        } else {
                          filters.account = account;
                        }
                      },
                      width: inputWidth,
                    ),
                  );
                  child.add(const SizedBox(height: 12));

                  // Currency Select
                  final List<DropdownMenuEntry<CurrencyRead>>
                  currencyOptions = <DropdownMenuEntry<CurrencyRead>>[
                    DropdownMenuEntry<CurrencyRead>(
                      value: CurrencyRead(
                        id: "0",
                        type: "dummy",
                        attributes: CurrencyProperties(
                          name:
                              S
                                  .of(context)
                                  .homeTransactionsDialogFilterCurrenciesAll,
                          code: "",
                          symbol: "",
                        ),
                      ),
                      label:
                          S
                              .of(context)
                              .homeTransactionsDialogFilterCurrenciesAll,
                    ),
                  ];
                  CurrencyRead? currentCurrency = currencyOptions.first.value;
                  final List<CurrencyRead> currencies =
                      snapshot.data!.currencies;
                  currencies.removeWhere(
                    (CurrencyRead currency) =>
                        currency.attributes.enabled != true,
                  );
                  for (CurrencyRead e in currencies) {
                    currencyOptions.add(
                      DropdownMenuEntry<CurrencyRead>(
                        value: e,
                        label: e.attributes.name,
                      ),
                    );
                    if (filters.currency?.id == e.id) {
                      currentCurrency = e;
                    }
                  }
                  child.add(
                    DropdownMenu<CurrencyRead>(
                      initialSelection: currentCurrency,
                      leadingIcon: const Icon(Icons.money),
                      label: Text(S.of(context).generalCurrency),
                      dropdownMenuEntries: currencyOptions,
                      onSelected: (CurrencyRead? currency) {
                        if ((currency?.id ?? "0") == "0") {
                          filters.currency = null;
                        } else {
                          filters.currency = currency;
                        }
                      },
                      width: inputWidth,
                    ),
                  );
                  child.add(const SizedBox(height: 12));

                  // Category Select
                  final List<DropdownMenuEntry<CategoryRead>>
                  categoryOptions = <DropdownMenuEntry<CategoryRead>>[
                    DropdownMenuEntry<CategoryRead>(
                      value: CategoryRead(
                        id: "0",
                        type: "dummy",
                        attributes: CategoryProperties(
                          name:
                              S
                                  .of(context)
                                  .homeTransactionsDialogFilterCategoriesAll,
                        ),
                      ),
                      label:
                          S
                              .of(context)
                              .homeTransactionsDialogFilterCategoriesAll,
                    ),
                    DropdownMenuEntry<CategoryRead>(
                      value: CategoryRead(
                        id: "-1",
                        type: "dummy",
                        attributes: CategoryProperties(
                          name:
                              S
                                  .of(context)
                                  .homeTransactionsDialogFilterCategoryUnset,
                        ),
                      ),
                      label:
                          S
                              .of(context)
                              .homeTransactionsDialogFilterCategoryUnset,
                    ),
                  ];
                  CategoryRead? currentCategory = categoryOptions.first.value;
                  if (filters.category?.id == "-1") {
                    currentCategory = categoryOptions.last.value;
                  }
                  for (CategoryRead e in snapshot.data!.categories) {
                    categoryOptions.add(
                      DropdownMenuEntry<CategoryRead>(
                        value: e,
                        label: e.attributes.name,
                      ),
                    );
                    if (filters.category?.id == e.id) {
                      currentCategory = e;
                    }
                  }
                  child.add(
                    DropdownMenu<CategoryRead>(
                      initialSelection: currentCategory,
                      leadingIcon: const Icon(Icons.assignment),
                      label: Text(S.of(context).generalCategory),
                      dropdownMenuEntries: categoryOptions,
                      onSelected: (CategoryRead? category) {
                        if ((category?.id ?? "0") == "0") {
                          filters.category = null;
                        } else {
                          filters.category = category;
                        }
                      },
                      width: inputWidth,
                    ),
                  );
                  child.add(const SizedBox(height: 12));

                  // Budget Select
                  final List<DropdownMenuEntry<BudgetRead>>
                  budgetOptions = <DropdownMenuEntry<BudgetRead>>[
                    DropdownMenuEntry<BudgetRead>(
                      value: BudgetRead(
                        id: "0",
                        type: "dummy",
                        attributes: BudgetProperties(
                          name:
                              S
                                  .of(context)
                                  .homeTransactionsDialogFilterBudgetsAll,
                        ),
                      ),
                      label:
                          S.of(context).homeTransactionsDialogFilterBudgetsAll,
                    ),
                    DropdownMenuEntry<BudgetRead>(
                      value: BudgetRead(
                        id: "-1",
                        type: "dummy",
                        attributes: BudgetProperties(
                          name:
                              S
                                  .of(context)
                                  .homeTransactionsDialogFilterBudgetUnset,
                        ),
                      ),
                      label:
                          S.of(context).homeTransactionsDialogFilterBudgetUnset,
                    ),
                  ];
                  BudgetRead? currentBudget = budgetOptions.first.value;
                  if (filters.budget?.id == "-1") {
                    currentBudget = budgetOptions.last.value;
                  }
                  for (BudgetRead e in snapshot.data!.budgets) {
                    budgetOptions.add(
                      DropdownMenuEntry<BudgetRead>(
                        value: e,
                        label: e.attributes.name,
                      ),
                    );
                    if (filters.budget?.id == e.id) {
                      currentBudget = e;
                    }
                  }
                  child.add(
                    DropdownMenu<BudgetRead>(
                      initialSelection: currentBudget,
                      leadingIcon: const Icon(Icons.payments),
                      label: Text(S.of(context).generalBudget),
                      dropdownMenuEntries: budgetOptions,
                      onSelected: (BudgetRead? budget) {
                        if ((budget?.id ?? "0") == "0") {
                          filters.budget = null;
                        } else {
                          filters.budget = budget;
                        }
                      },
                      width: inputWidth,
                    ),
                  );
                  child.add(const SizedBox(height: 12));

                  // Bill Select
                  final List<DropdownMenuEntry<BillRead>>
                  billOptions = <DropdownMenuEntry<BillRead>>[
                    DropdownMenuEntry<BillRead>(
                      value: BillRead(
                        id: "0",
                        type: "dummy",
                        attributes: BillProperties(
                          amountMax: "0",
                          amountMin: "0",
                          date: DateTime.now(),
                          repeatFreq:
                              BillRepeatFrequency.swaggerGeneratedUnknown,
                          name:
                              S
                                  .of(context)
                                  .homeTransactionsDialogFilterBillsAll,
                        ),
                      ),
                      label: S.of(context).homeTransactionsDialogFilterBillsAll,
                    ),
                    DropdownMenuEntry<BillRead>(
                      value: BillRead(
                        id: "-1",
                        type: "dummy",
                        attributes: BillProperties(
                          amountMax: "0",
                          amountMin: "0",
                          date: DateTime.now(),
                          repeatFreq:
                              BillRepeatFrequency.swaggerGeneratedUnknown,
                          name:
                              S
                                  .of(context)
                                  .homeTransactionsDialogFilterBillUnset,
                        ),
                      ),
                      label:
                          S.of(context).homeTransactionsDialogFilterBillUnset,
                    ),
                  ];
                  BillRead? currentBill = billOptions.first.value;
                  if (filters.bill?.id == "-1") {
                    currentBill = billOptions.last.value;
                  }
                  for (BillRead e in snapshot.data!.bills) {
                    billOptions.add(
                      DropdownMenuEntry<BillRead>(
                        value: e,
                        label: e.attributes.name!,
                      ),
                    );
                    if (filters.bill?.id == e.id) {
                      currentBill = e;
                    }
                  }
                  child.add(
                    DropdownMenu<BillRead>(
                      initialSelection: currentBill,
                      leadingIcon: const Icon(Icons.calendar_today),
                      label: Text(S.of(context).generalBill),
                      dropdownMenuEntries: billOptions,
                      onSelected: (BillRead? bill) {
                        if ((bill?.id ?? "0") == "0") {
                          filters.bill = null;
                        } else {
                          filters.bill = bill;
                        }
                      },
                      width: inputWidth,
                    ),
                  );
                  child.add(const SizedBox(height: 12));

                  // Tag Select
                  final TextEditingController tagsTextController =
                      TextEditingController();
                  filters.tags ??= Tags();
                  child.add(
                    TransactionTags(
                      textController: tagsTextController,
                      tagsController: filters.tags!,
                      enableAdd: false,
                    ),
                  );
                  child.add(const SizedBox(height: 12));

                  return Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: child,
                    ),
                  );
                } else if (snapshot.hasError) {
                  log.severe(
                    "error getting filter data",
                    snapshot.error,
                    snapshot.stackTrace,
                  );
                  Navigator.pop(context);
                  return const SizedBox.shrink();
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  String _getFilterName(BuildContext context, TransactionDateFilter filter) {
    switch (filter) {
      case TransactionDateFilter.currentMonth:
        return S.of(context).generalDateRangeCurrentMonth;
      case TransactionDateFilter.last30Days:
        return S.of(context).generalDateRangeLast30Days;
      case TransactionDateFilter.currentYear:
        return S.of(context).generalDateRangeCurrentYear;
      case TransactionDateFilter.lastYear:
        return S.of(context).generalDateRangeLastYear;
      case TransactionDateFilter.all:
        return S.of(context).generalDateRangeAll;
    }
  }
}
