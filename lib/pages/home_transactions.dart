import 'dart:async';
import 'dart:ui';
import 'package:chopper/chopper.dart' show Response;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/pages/home.dart';
import 'package:waterflyiii/pages/transaction_detail.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TransactionFilters {
  TransactionFilters({this.account, this.text, this.currency});

  AccountRead? account;
  String? text;
  CurrencyRead? currency;

  bool get hasFilters => account != null || text != null || currency != null;
}

class HomeTransactions extends StatefulWidget {
  const HomeTransactions({Key? key, this.accountId}) : super(key: key);

  final String? accountId;

  @override
  State<HomeTransactions> createState() => _HomeTransactionsState();
}

class _HomeTransactionsState extends State<HomeTransactions>
    with AutomaticKeepAliveClientMixin {
  final int _numberOfPostsPerRequest = 50;

  final PagingController<int, TransactionRead> _pagingController =
      PagingController<int, TransactionRead>(
    firstPageKey: 0,
    invisibleItemsThreshold: 20,
  );

  DateTime? _lastDate;

  final TransactionFilters _filters = TransactionFilters();

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener((int pageKey) {
      _fetchPage(pageKey);
    });

    // Only add button when in own tab
    if (widget.accountId == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        HomePageInheritedState homePageState =
            HomePageInheritedState.of(context);
        homePageState.data.setActions(
          widget.key!,
          <Widget>[
            IconButton(
              // :TODO: turn blue when filter is set.. if feasible
              icon: const Icon(Icons.tune),
              tooltip: S.of(context).homeTransactionsActionFilter,
              onPressed: () async {
                TransactionFilters oldFilters = TransactionFilters(
                  text: _filters.text,
                  account: _filters.account,
                  currency: _filters.currency,
                );
                bool? ok = await showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) => FilterDialog(
                    filters: _filters, // passed by reference -> auto updated
                  ),
                );
                if (ok == null || !ok) {
                  return;
                }
                if (oldFilters == _filters) {
                  return;
                }
                _pagingController.refresh();
              },
            ),
          ],
        );
      });
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();

    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final FireflyIii api = FireflyProvider.of(context).api;
      late Future<Response<TransactionArray>> searchFunc;
      if (_filters.hasFilters) {
        String query = _filters.text!;
        if (_filters.account != null) {
          query = "account_id:${_filters.account!.id} $query";
        }
        if (_filters.currency != null) {
          query = "currency_is:${_filters.currency!.attributes.code} $query";
        }
        debugPrint("Search query: $query");
        searchFunc = api.v1SearchTransactionsGet(query: query, page: pageKey);
      } else {
        searchFunc = (widget.accountId != null || _filters.account != null)
            ? api.v1AccountsIdTransactionsGet(
                id: widget.accountId ?? _filters.account!.id,
                page: pageKey,
                end: DateFormat('yyyy-MM-dd').format(DateTime.now().toLocal()))
            : api.v1TransactionsGet(
                page: pageKey,
                end: DateFormat('yyyy-MM-dd').format(DateTime.now().toLocal()),
              );
      }
      final Response<TransactionArray> response = await searchFunc;
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
      final List<TransactionRead> transactionList = response.body!.data;
      final bool isLastPage = transactionList.length < _numberOfPostsPerRequest;
      if (isLastPage) {
        _pagingController.appendLastPage(transactionList);
      } else {
        final int nextPageKey = pageKey + 1;
        _pagingController.appendPage(transactionList, nextPageKey);
      }
    } catch (e) {
      debugPrint("error --> $e");
      _pagingController.error = e;
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    debugPrint("home_transactions build()");
    super.build(context);

    return RefreshIndicator(
      onRefresh: () => Future<void>.sync(() => _pagingController.refresh()),
      child: PagedListView<int, TransactionRead>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<TransactionRead>(
          itemBuilder: transactionRowBuilder,
        ),
        //itemExtent: 80,
      ),
    );
  }

  Widget transactionRowBuilder(
    BuildContext context,
    TransactionRead item,
    int index,
  ) {
    List<TransactionSplit> transactions = item.attributes.transactions;
    if (transactions.isEmpty) {
      return Text(S.of(context).homeTransactionsEmpty);
    }
    String category = "";
    int categories = 0;
    String notes = "";
    bool hasAttachments = false;
    double amount = 0.0;
    final Map<String, double> foreignAmounts = <String, double>{};
    final Map<String, CurrencyRead> foreignCurrencies =
        <String, CurrencyRead>{};
    String foreignText = "";
    String sourceName = "";
    String destinationName = "";
    late bool reconciled;
    for (TransactionSplit trans in transactions) {
      if (trans.categoryName?.isNotEmpty ?? false) {
        categories++;
        if (category.isEmpty) {
          category = trans.categoryName!;
        }
      }
      if (trans.notes?.isNotEmpty ?? false) {
        if (notes.isNotEmpty) {
          notes += "\n";
        }
        notes += trans.notes!.trim();
      }
      if (trans.hasAttachments ?? false) {
        hasAttachments = true;
      }
      amount += double.parse(trans.amount);
      if (trans.foreignAmount?.isNotEmpty ?? false) {
        final double amount = double.parse(trans.foreignAmount!);
        final String foreignSymbol =
            trans.foreignCurrencySymbol ?? trans.foreignCurrencyCode ?? "";
        if (amount != 0 && foreignSymbol.isNotEmpty) {
          foreignAmounts[foreignSymbol] =
              foreignAmounts[foreignSymbol] ?? 0 + amount;
          foreignCurrencies[foreignSymbol] = CurrencyRead(
            id: trans.foreignCurrencyId ?? "0",
            type: "currencies",
            attributes: Currency(
              code: trans.foreignCurrencyCode ?? "",
              name: "",
              symbol: trans.foreignCurrencySymbol ?? "",
              decimalPlaces: trans.foreignCurrencyDecimalPlaces,
            ),
          );
        }
      }
      if (sourceName == "") {
        sourceName = trans.sourceName!;
      } else if (sourceName != trans.sourceName!) {
        sourceName = S.of(context).generalMultiple;
      }
      if (destinationName == "") {
        destinationName = trans.destinationName!;
      } else if (destinationName != trans.destinationName!) {
        destinationName = S.of(context).generalMultiple;
      }
    }
    if (categories > 1) {
      category = S.of(context).homeTransactionsMultipleCategories(categories);
    }

    // Title
    late String title;
    if (item.attributes.groupTitle?.isNotEmpty ?? false) {
      title = item.attributes.groupTitle!;
    } else {
      title = transactions.first.description;
    }
    // Subtitle
    List<InlineSpan> subtitle = <InlineSpan>[];
    if (hasAttachments) {
      subtitle.add(const WidgetSpan(
        baseline: TextBaseline.ideographic,
        alignment: PlaceholderAlignment.middle,
        child: Padding(
          padding: EdgeInsets.only(right: 2),
          child: Icon(Icons.attachment),
        ),
      ));
    }
    if (transactions.first.type == TransactionTypeProperty.transfer) {
      subtitle.add(
        TextSpan(text: "(${S.of(context).transactionTypeTransfer}) "),
      );
    }
    subtitle.add(TextSpan(
      text: (transactions.first.type == TransactionTypeProperty.withdrawal)
          ? destinationName
          : sourceName,
    ));
    subtitle.add(const TextSpan(text: "\n"));
    if (category.isNotEmpty) {
      subtitle.add(TextSpan(
        text: category,
        style: const TextStyle(fontStyle: FontStyle.italic),
      ));
    }
    if (notes.isNotEmpty) {
      subtitle.add(
        TextSpan(
          text: "\n$notes",
          style: const TextStyle(fontStyle: FontStyle.italic),
        ),
      );
    }

    reconciled = transactions.first.reconciled ?? false;
    final CurrencyRead currency = CurrencyRead(
      id: transactions.first.currencyId ?? "0",
      type: "currencies",
      attributes: Currency(
        code: transactions.first.currencyCode ?? "",
        name: transactions.first.currencyName ?? "",
        symbol: transactions.first.currencySymbol ?? "",
        decimalPlaces: transactions.first.currencyDecimalPlaces,
      ),
    );
    if (foreignAmounts.isNotEmpty) {
      foreignAmounts.forEach((String cur, double amount) {
        if (foreignCurrencies.containsKey(cur)) {
          foreignText += "${foreignCurrencies[cur]!.fmt(amount)} ";
        }
      });
      foreignText += " ";
    }

    Widget transactionWidget = ListTile(
      leading: CircleAvatar(
        foregroundColor: Colors.white,
        backgroundColor: transactions.first.type.color,
        child: Icon(transactions.first.type.icon),
      ),
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: RichText(
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: subtitle,
        ),
      ),
      isThreeLine: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
      ),
      trailing: RichText(
        textAlign: TextAlign.end,
        maxLines: 2,
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: <InlineSpan>[
            if (foreignText.isNotEmpty)
              TextSpan(
                text: foreignText,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.blue,
                    ),
              ),
            TextSpan(
              text: currency.fmt(amount),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: transactions.first.type.color,
                fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
              ),
            ),
            const TextSpan(text: "\n"),
            if (reconciled)
              const WidgetSpan(
                baseline: TextBaseline.ideographic,
                alignment: PlaceholderAlignment.middle,
                child: Padding(
                  padding: EdgeInsets.only(right: 2),
                  child: Icon(Icons.check),
                ),
              ),
            TextSpan(
              text: (transactions.first.type == TransactionTypeProperty.deposit)
                  ? destinationName
                  : sourceName,
            ),
          ],
        ),
      ),
      onTap: () async {
        final bool? refresh = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) => Dialog.fullscreen(
            child: TransactionPage(transaction: item),
          ),
        );
        if (refresh ?? false) {
          _pagingController.refresh();
        }
      },
    );

    // Date
    DateTime date = transactions.first.date.toLocal();
    if (_lastDate == null || _lastDate!.clearTime() != date.clearTime()) {
      // Add date row
      transactionWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 0, 8),
            child: Text(
              DateFormat.yMd().format(date),
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          transactionWidget,
        ],
      );
      _lastDate = date;
    }

    return transactionWidget;
  }
}

class FilterData {
  FilterData(this.accounts, this.currencies);

  final List<AccountRead> accounts;
  final List<CurrencyRead> currencies;
}

class FilterDialog extends StatelessWidget {
  const FilterDialog({
    super.key,
    required this.filters,
  });

  final TransactionFilters filters;

  Future<FilterData> _getData(BuildContext context) async {
    final FireflyIii api = FireflyProvider.of(context).api;

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

    return FilterData(
      respAccounts.body!.data,
      respCurrencies.body!.data,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.tune),
      title: Text(S.of(context).homeTransactionsDialogFilterTitle),
      clipBehavior: Clip.hardEdge,
      actions: <Widget>[
        TextButton(
          child: Text(S.of(context).formButtonCancel),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(S.of(context).formButtonSave),
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

                  // Search Term
                  child.add(
                    TextFormField(
                      //controller: _keyTextController,
                      //readOnly: _formSubmitted,
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
                  );
                  child.add(const SizedBox(height: 12));

                  // Account Select
                  List<DropdownMenuEntry<AccountRead>> accountOptions =
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
                    )
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
                    ),
                  );
                  child.add(const SizedBox(height: 12));

                  // Currency Select
                  List<DropdownMenuEntry<CurrencyRead>> currencyOptions =
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
                    )
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
