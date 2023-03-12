import 'dart:async';
import 'dart:ui';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/transactions.dart';
import 'package:waterflyiii/pages/home.dart';
import 'package:waterflyiii/pages/transaction_detail.dart';
import 'package:waterflyiii/swagger_fireflyiii_api/firefly_iii.swagger.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TransactionFilters {
  TransactionFilters({this.account, this.text});

  AccountRead? account;
  String? text;
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
      PagingController(
    firstPageKey: 0,
    invisibleItemsThreshold: 20,
  );

  DateTime? _lastDate;

  final TransactionFilters _filters = TransactionFilters();

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener((pageKey) {
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
              tooltip: 'Filter List',
              onPressed: () async {
                TransactionFilters oldFilters = TransactionFilters(
                    text: _filters.text, account: _filters.account);
                bool? ok = await showDialog<bool>(
                  context: context,
                  builder: (context) => FilterDialog(
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
      final api = FireflyProvider.of(context).api;
      if (api == null) {
        throw Exception("API unavailable");
      }
      late Future<Response<TransactionArray>> searchFunc;
      if (_filters.text != null) {
        String query = _filters.text!;
        if (_filters.account != null) {
          query = "account_id:${_filters.account!.id} $query";
        }
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
      final response = await searchFunc;
      if (!response.isSuccessful || response.body == null) {
        throw Exception("Invalid Response from API");
      }
      final transactionList = response.body!.data;
      final isLastPage = transactionList.length < _numberOfPostsPerRequest;
      if (isLastPage) {
        _pagingController.appendLastPage(transactionList);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(transactionList, nextPageKey);
      }
    } catch (e) {
      print("error --> $e");
      _pagingController.error = e;
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    print("home_transactions build()");
    super.build(context);

    return RefreshIndicator(
      onRefresh: () => Future.sync(() => _pagingController.refresh()),
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
      return const Text("No transactions found");
    }
    String category = "";
    int categories = 0;
    String notes = "";
    bool hasAttachments = false;
    double amount = 0.0;
    double foreignAmount = 0.0;
    String? foreignCurrency;
    int? foreignCurrencyDecimalPlaces;
    String sourceName = "";
    String destinationName = "";
    bool reconciled = false;
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
        notes += trans.notes!.strip();
      }
      if (trans.hasAttachments != null && trans.hasAttachments!) {
        hasAttachments = true;
      }
      amount += double.parse(trans.amount);
      if (trans.foreignAmount != null) {
        foreignAmount += double.parse(trans.foreignAmount!);
        foreignCurrency = trans.foreignCurrencySymbol;
        foreignCurrencyDecimalPlaces = trans.foreignCurrencyDecimalPlaces;
      }
      if (sourceName == "") {
        sourceName = trans.sourceName!;
      } else if (sourceName != trans.sourceName!) {
        sourceName = "multiple";
      }
      if (destinationName == "") {
        destinationName = trans.destinationName!;
      } else if (destinationName != trans.destinationName!) {
        destinationName = "multiple";
      }
    }
    if (categories > 1) {
      category = "$categories categories";
    }

    // Title
    late String title;
    if (item.attributes.groupTitle != null &&
        item.attributes.groupTitle!.isNotEmpty) {
      title = item.attributes.groupTitle!;
    } else {
      title = transactions.first.description;
    }
    // Subtitle
    List<InlineSpan> subtitle = [];
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
      subtitle.add(const TextSpan(text: "(Transfer) "));
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
            TextSpan(
              text: (foreignCurrency != null)
                  ? "$foreignCurrency${foreignAmount.toStringAsFixed(foreignCurrencyDecimalPlaces!)}  "
                  : "",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.blue,
                  ),
            ),
            TextSpan(
              text:
                  "${transactions.first.currencySymbol}${amount.toStringAsFixed(transactions.first.currencyDecimalPlaces!)}",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: transactions.first.type.color,
                fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
              ),
            ),
            const TextSpan(text: "\n"),
            reconciled
                ? const WidgetSpan(
                    baseline: TextBaseline.ideographic,
                    alignment: PlaceholderAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.only(right: 2),
                      child: Icon(Icons.check),
                    ),
                  )
                : const TextSpan(),
            TextSpan(
              text: (transactions.first.type == TransactionTypeProperty.deposit)
                  ? destinationName
                  : sourceName,
            ),
          ],
        ),
      ),
      onTap: () async {
        final refresh = await showDialog(
          context: context,
          builder: (BuildContext context) => Dialog.fullscreen(
            child: TransactionPage(transaction: item),
          ),
        );
        if (refresh != null && refresh) {
          _pagingController.refresh();
        }

        /*Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionPage(transaction: item),
          ),
        );*/
      },
    );

    // Date
    DateTime date = transactions.first.date.toLocal();
    if (_lastDate == null || _lastDate!.clearTime() != date.clearTime()) {
      // Add date row
      transactionWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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

class FilterDialog extends StatelessWidget {
  const FilterDialog({
    super.key,
    required this.filters,
  });

  final TransactionFilters filters;

  Future<List<AccountRead>>? _getAccounts(BuildContext context) async {
    final api = FireflyProvider.of(context).api;
    if (api == null) {
      throw Exception("Can't get API instance");
    }
    final response =
        await api.v1AccountsGet(type: AccountTypeFilter.assetAccount);
    if (!response.isSuccessful || response.body == null) {
      throw Exception("Invalid Response from API");
    }
    return response.body!.data;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.tune),
      title: const Text("Select filters"),
      clipBehavior: Clip.hardEdge,
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FutureBuilder<List<AccountRead>>(
            future: _getAccounts(context),
            builder: (BuildContext context,
                AsyncSnapshot<List<AccountRead>> snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                List<Widget> child = [];

                // Search Term
                child.add(
                  TextFormField(
                    //controller: _keyTextController,
                    //readOnly: _formSubmitted,
                    decoration: const InputDecoration(
                      filled: false,
                      border: OutlineInputBorder(),
                      labelText: "Search Term",
                      prefixIcon: Icon(Icons.search),
                    ),
                    initialValue: filters.text,
                    onChanged: (String value) {
                      filters.text = value;
                    },
                  ),
                );
                child.add(const SizedBox(height: 12));

                // Account Select
                List<DropdownMenuEntry<AccountRead>> accountOptions = [
                  DropdownMenuEntry<AccountRead>(
                    value: AccountRead(
                      id: "0",
                      type: "dummy",
                      attributes: Account(
                          name: "<All Accounts>",
                          type:
                              ShortAccountTypeProperty.swaggerGeneratedUnknown),
                    ),
                    label: "<All Accounts>",
                  )
                ];
                AccountRead? currentAccount = accountOptions.first.value;
                for (AccountRead e in snapshot.data!) {
                  accountOptions.add(DropdownMenuEntry<AccountRead>(
                    value: e,
                    label: e.attributes.name,
                  ));
                  if (filters.account != null && filters.account!.id == e.id) {
                    currentAccount = e;
                  }
                }

                child.add(
                  DropdownMenu<AccountRead>(
                    initialSelection: currentAccount,
                    leadingIcon: const Icon(Icons.account_balance),
                    label: const Text('Account'),
                    dropdownMenuEntries: accountOptions,
                    onSelected: (AccountRead? account) {
                      if (account == null || account.id == "0") {
                        filters.account = null;
                      } else {
                        filters.account = account;
                      }
                    },
                  ),
                );

                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: child,
                  ),
                );
              } else if (snapshot.hasError) {
                Navigator.pop(context);
                return const CircularProgressIndicator();
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
