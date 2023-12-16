import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'package:chopper/chopper.dart' show Response;

import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
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
  });

  AccountRead? account;
  String? text;
  CurrencyRead? currency;
  CategoryRead? category;
  BudgetRead? budget;
  BillRead? bill;

  bool _hasFilters = false;
  bool get hasFilters => _hasFilters;

  void updateFilters() {
    _hasFilters = account != null ||
        text != null ||
        currency != null ||
        category != null ||
        budget != null ||
        bill != null;
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
  }) =>
      TransactionFilters(
        account: account ?? this.account,
        text: text ?? this.text,
        currency: currency ?? this.currency,
        category: category ?? this.category,
        budget: budget ?? this.budget,
        bill: bill ?? this.bill,
      );

  void reset() {
    account = null;
    text = null;
    currency = null;
    category = null;
    budget = null;
    bill = null;
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
  const FilterDialog({
    super.key,
    required this.filters,
  });

  final TransactionFilters filters;

  Future<FilterData> _getData(BuildContext context) async {
    final FireflyIii api = context.read<FireflyService>().api;

    // Accounts
    final Response<AccountArray> respAccounts =
        await api.v1AccountsGet(type: AccountTypeFilter.assetAccount);
    if (!respAccounts.isSuccessful || respAccounts.body == null) {
      if (context.mounted) {
        throw Exception(
          S
              .of(context)
              .errorAPIInvalidResponse(respAccounts.error?.toString() ?? ""),
        );
      } else {
        throw Exception(
          "[nocontext] Invalid API response: ${respAccounts.error}",
        );
      }
    }

    // Currencies
    final Response<CurrencyArray> respCurrencies = await api.v1CurrenciesGet();
    if (!respCurrencies.isSuccessful || respCurrencies.body == null) {
      if (context.mounted) {
        throw Exception(
          S
              .of(context)
              .errorAPIInvalidResponse(respCurrencies.error?.toString() ?? ""),
        );
      } else {
        throw Exception(
          "[nocontext] Invalid API response: ${respCurrencies.error}",
        );
      }
    }

    // Categories
    final Response<CategoryArray> respCats = await api.v1CategoriesGet();
    if (!respCats.isSuccessful || respCats.body == null) {
      if (context.mounted) {
        throw Exception(
          S
              .of(context)
              .errorAPIInvalidResponse(respCats.error?.toString() ?? ""),
        );
      } else {
        throw Exception(
          "[nocontext] Invalid API response: ${respCats.error}",
        );
      }
    }

    // Budgets
    final Response<BudgetArray> respBudgets = await api.v1BudgetsGet();
    if (!respBudgets.isSuccessful || respBudgets.body == null) {
      if (context.mounted) {
        throw Exception(
          S
              .of(context)
              .errorAPIInvalidResponse(respBudgets.error?.toString() ?? ""),
        );
      } else {
        throw Exception(
          "[nocontext] Invalid API response: ${respBudgets.error}",
        );
      }
    }

    // Bills
    final Response<BillArray> respBills = await api.v1BillsGet();
    if (!respBills.isSuccessful || respBills.body == null) {
      if (context.mounted) {
        throw Exception(
          S
              .of(context)
              .errorAPIInvalidResponse(respBills.error?.toString() ?? ""),
        );
      } else {
        throw Exception(
          "[nocontext] Invalid API response: ${respBills.error}",
        );
      }
    }

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
    return AlertDialog(
      icon: const Icon(Icons.tune),
      title: Text(S.of(context).homeTransactionsDialogFilterTitle),
      clipBehavior: Clip.hardEdge,
      actions: <Widget>[
        TextButton(
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          onPressed: () {
            context.read<SettingsProvider>().setShowFutureTXs(oldShowFutureTXs);
            Navigator.of(context).pop();
          },
        ),
        OutlinedButton(
          child: Text(S.of(context).generalReset),
          onPressed: () {
            filters.reset();
            context.read<SettingsProvider>().setShowFutureTXs(false);
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
              builder:
                  (BuildContext context, AsyncSnapshot<FilterData> snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  List<Widget> child = <Widget>[];
                  final double inputWidth =
                      MediaQuery.of(context).size.width - 128 - 24;

                  // Show future TXs
                  child.add(
                    SizedBox(
                      width: inputWidth,
                      child: CheckboxListTile(
                        value: context.watch<SettingsProvider>().showFutureTXs,
                        onChanged: (bool? value) => context
                            .read<SettingsProvider>()
                            .setShowFutureTXs(value ?? false),
                        title: Text(S
                            .of(context)
                            .homeTransactionsDialogFilterFutureTransactions),
                      ),
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
                  final List<DropdownMenuEntry<AccountRead>> accountOptions =
                      <DropdownMenuEntry<AccountRead>>[
                    DropdownMenuEntry<AccountRead>(
                      value: AccountRead(
                        id: "0",
                        type: "dummy",
                        attributes: Account(
                          name: S
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
                    accountOptions.add(DropdownMenuEntry<AccountRead>(
                      value: e,
                      label: e.attributes.name,
                    ));
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
                  final List<DropdownMenuEntry<CurrencyRead>> currencyOptions =
                      <DropdownMenuEntry<CurrencyRead>>[
                    DropdownMenuEntry<CurrencyRead>(
                      value: CurrencyRead(
                        id: "0",
                        type: "dummy",
                        attributes: Currency(
                          name: S
                              .of(context)
                              .homeTransactionsDialogFilterCurrenciesAll,
                          code: "",
                          symbol: "",
                        ),
                      ),
                      label: S
                          .of(context)
                          .homeTransactionsDialogFilterCurrenciesAll,
                    ),
                  ];
                  CurrencyRead? currentCurrency = currencyOptions.first.value;
                  for (CurrencyRead e in snapshot.data!.currencies) {
                    currencyOptions.add(DropdownMenuEntry<CurrencyRead>(
                      value: e,
                      label: e.attributes.name,
                    ));
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
                  final List<DropdownMenuEntry<CategoryRead>> categoryOptions =
                      <DropdownMenuEntry<CategoryRead>>[
                    DropdownMenuEntry<CategoryRead>(
                      value: CategoryRead(
                        id: "0",
                        type: "dummy",
                        attributes: Category(
                          name: S
                              .of(context)
                              .homeTransactionsDialogFilterCategoriesAll,
                        ),
                      ),
                      label: S
                          .of(context)
                          .homeTransactionsDialogFilterCategoriesAll,
                    ),
                    DropdownMenuEntry<CategoryRead>(
                      value: CategoryRead(
                        id: "-1",
                        type: "dummy",
                        attributes: Category(
                          name: S
                              .of(context)
                              .homeTransactionsDialogFilterCategoryUnset,
                        ),
                      ),
                      label: S
                          .of(context)
                          .homeTransactionsDialogFilterCategoryUnset,
                    ),
                  ];
                  CategoryRead? currentCategory = categoryOptions.first.value;
                  if (filters.category?.id == "-1") {
                    currentCategory = categoryOptions.last.value;
                  }
                  for (CategoryRead e in snapshot.data!.categories) {
                    categoryOptions.add(DropdownMenuEntry<CategoryRead>(
                      value: e,
                      label: e.attributes.name,
                    ));
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
                  final List<DropdownMenuEntry<BudgetRead>> budgetOptions =
                      <DropdownMenuEntry<BudgetRead>>[
                    DropdownMenuEntry<BudgetRead>(
                      value: BudgetRead(
                        id: "0",
                        type: "dummy",
                        attributes: Budget(
                          name: S
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
                        attributes: Budget(
                          name: S
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
                    budgetOptions.add(DropdownMenuEntry<BudgetRead>(
                      value: e,
                      label: e.attributes.name,
                    ));
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
                  final List<DropdownMenuEntry<BillRead>> billOptions =
                      <DropdownMenuEntry<BillRead>>[
                    DropdownMenuEntry<BillRead>(
                      value: BillRead(
                        id: "0",
                        type: "dummy",
                        attributes: Bill(
                          amountMax: "0",
                          amountMin: "0",
                          date: DateTime.now(),
                          repeatFreq:
                              BillRepeatFrequency.swaggerGeneratedUnknown,
                          name: S
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
                        attributes: Bill(
                          amountMax: "0",
                          amountMin: "0",
                          date: DateTime.now(),
                          repeatFreq:
                              BillRepeatFrequency.swaggerGeneratedUnknown,
                          name: S
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
                    billOptions.add(DropdownMenuEntry<BillRead>(
                      value: e,
                      label: e.attributes.name,
                    ));
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

                  return Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: child,
                    ),
                  );
                } else if (snapshot.hasError) {
                  log.severe("error getting filter data", snapshot.error,
                      snapshot.stackTrace);
                  Navigator.pop(context);
                  return const SizedBox.shrink();
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
