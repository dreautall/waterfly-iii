import 'dart:async';

import 'package:animations/animations.dart';
import 'package:chopper/chopper.dart' show Response;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:version/version.dart';
import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/pages/home.dart';
import 'package:waterflyiii/pages/home/transactions/filter.dart';
import 'package:waterflyiii/pages/transaction.dart';
import 'package:waterflyiii/pages/transaction/delete.dart';
import 'package:waterflyiii/settings.dart';
import 'package:waterflyiii/stock.dart';
import 'package:waterflyiii/timezonehandler.dart';

class HomeTransactions extends StatefulWidget {
  const HomeTransactions({super.key, this.filters});

  final TransactionFilters? filters;

  @override
  State<HomeTransactions> createState() => _HomeTransactionsState();
}

class _HomeTransactionsState extends State<HomeTransactions>
    with AutomaticKeepAliveClientMixin {
  final Logger log = Logger("Pages.Home.Transaction");

  final int _numberOfPostsPerRequest = 50;
  late PagingState<int, TransactionRead> _pagingState;

  DateTime? _lastDate;
  List<int> _rowsWithDate = <int>[];
  late TransStock _stock;
  late TimeZoneHandler _tzHandler;

  final TransactionFilters _filters = TransactionFilters();
  final ValueNotifier<bool> _tagsHidden = ValueNotifier<bool>(false);
  final Map<String, double> _runningBalancesByTransactionId =
      <String, double>{};
  double? _lastCalculatedBalance;

  bool _isRevenueOrExpense(ShortAccountTypeProperty? type) {
    return type == ShortAccountTypeProperty.revenue ||
        type == ShortAccountTypeProperty.expense;
  }

  double _updateBalance(
    double balance,
    double amount,
    TransactionTypeProperty? type,
  ) {
    if (type == TransactionTypeProperty.withdrawal ||
        type == TransactionTypeProperty.transfer) {
      return balance + amount;
    } else {
      return balance - amount;
    }
  }

  @override
  void initState() {
    super.initState();
    _tzHandler = context.read<FireflyService>().tzHandler;
    _pagingState = PagingState<int, TransactionRead>();
    _tagsHidden.value = context.read<SettingsProvider>().hideTags;

    // Only add filter button when in own tab
    if (widget.filters == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<PageActions>().set(widget.key!, <Widget>[
          ValueListenableBuilder<bool>(
            valueListenable: _tagsHidden,
            builder:
                (BuildContext context, bool value, _) => IconButton(
                  icon: const Icon(Icons.bookmarks_outlined),
                  selectedIcon: Icon(
                    Icons.bookmarks,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  isSelected: !value,
                  tooltip: S.of(context).homeTransactionsSettingsShowTags,
                  onPressed: () async {
                    final SettingsProvider settings =
                        context.read<SettingsProvider>();
                    settings.hideTags = !settings.hideTags;
                    _tagsHidden.value = settings.hideTags;
                  },
                ),
          ),
          ChangeNotifierProvider<TransactionFilters>.value(
            value: _filters,
            builder:
                (BuildContext context, _) => IconButton(
                  icon: const Icon(Icons.filter_alt_outlined),
                  selectedIcon: Icon(
                    Icons.filter_alt,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  isSelected: context.watch<TransactionFilters>().hasFilters,
                  tooltip: S.of(context).homeTransactionsActionFilter,
                  onPressed: () async {
                    TransactionFilters oldFilters = _filters.copyWith();
                    final SettingsProvider settings =
                        context.read<SettingsProvider>();
                    final bool oldShowFutureTXs = settings.showFutureTXs;
                    bool? ok = await showDialog<bool>(
                      context: context,
                      builder:
                          (BuildContext context) => FilterDialog(
                            // passed by reference -> auto updated
                            filters: _filters,
                          ),
                    );
                    if (ok == null || !ok) {
                      if (settings.showFutureTXs != oldShowFutureTXs) {
                        settings.showFutureTXs = oldShowFutureTXs;
                        setState(() {
                          _pagingState = _pagingState.reset();
                        });
                      }
                      _filters.account = oldFilters.account;
                      _filters.budget = oldFilters.budget;
                      _filters.category = oldFilters.category;
                      _filters.currency = oldFilters.currency;
                      _filters.text = oldFilters.text;
                      _filters.bill = oldFilters.bill;
                      _filters.tags = oldFilters.tags;

                      return;
                    }
                    if (oldFilters == _filters &&
                        settings.showFutureTXs == oldShowFutureTXs) {
                      return;
                    }
                    _filters.updateFilters();
                    _rowsWithDate = <int>[];
                    _lastDate = null;
                    setState(() {
                      _pagingState = _pagingState.reset();
                    });
                  },
                ),
          ),
        ]);
      });
    }

    _stock = context.read<FireflyService>().transStock!;

    _stock.addListener(notifRefresh);
  }

  @override
  void dispose() {
    _stock.removeListener(notifRefresh);

    super.dispose();
  }

  void notifRefresh() {
    setState(() {
      _lastCalculatedBalance = null;
      _pagingState = _pagingState.reset();
    });
  }

  void _fetchPage() async {
    if (_pagingState.isLoading) return;

    final TransStock? stock = context.read<FireflyService>().transStock;
    if (stock == null) {
      throw Exception("Stock not available");
    }

    setState(() {
      _pagingState = _pagingState.copyWith(isLoading: true, error: null);
    });

    try {
      late List<TransactionRead> transactionList;

      final int pageKey = (_pagingState.keys?.last ?? 0) + 1;
      log.finest(
        "Getting page $pageKey (${_pagingState.pages?.length} pages loaded)",
      );

      if (widget.filters != null) {
        _filters.account = widget.filters!.account;
        _filters.text = widget.filters!.text;
        _filters.currency = widget.filters!.currency;
        _filters.category = widget.filters!.category;
        _filters.budget = widget.filters!.budget;
        _filters.bill = widget.filters!.bill;
        _filters.tags = widget.filters!.tags;
        _filters.updateFilters();
      }

      // Faster than searching for an account, and also has cache (stock) behind
      // This search should never have additional filters!
      if (widget.filters?.account != null) {
        transactionList = await stock.getAccount(
          id: _filters.account!.id,
          page: pageKey,
          limit: _numberOfPostsPerRequest,
          end:
              context.read<SettingsProvider>().showFutureTXs
                  ? null
                  : DateFormat('yyyy-MM-dd', 'en_US').format(_tzHandler.sNow()),
          start:
              (context.read<FireflyService>().apiVersion! >= Version(2, 0, 9))
                  ? null
                  : "1900-01-01",
        );
      } else if (_filters.hasFilters) {
        String query = _filters.text ?? "";
        if (_filters.account != null) {
          query = "account_id:${_filters.account!.id} $query";
        }
        if (_filters.currency != null) {
          query = "currency_is:${_filters.currency!.attributes.code} $query";
        }
        if (_filters.category != null) {
          query =
              (_filters.category!.id == "-1")
                  ? "has_no_category:true $query"
                  : "category_is:\"${_filters.category!.attributes.name}\" $query";
        }
        if (_filters.budget != null) {
          query =
              (_filters.budget!.id == "-1")
                  ? "has_no_budget:true $query"
                  : "budget_is:\"${_filters.budget!.attributes.name}\" $query";
        }
        if (_filters.bill != null) {
          query =
              (_filters.bill!.id == "-1")
                  ? "has_no_bill:true $query"
                  : "bill_is:\"${_filters.bill!.attributes.name}\" $query";
        }
        if (_filters.tags != null) {
          for (String tag in _filters.tags!.tags) {
            query = "tag_is:\"$tag\" $query";
          }
        }
        if (!context.read<SettingsProvider>().showFutureTXs) {
          query = "date_before:today $query ";
        }
        log.fine(() => "Search query: $query");
        transactionList = await stock.getSearch(query: query, page: pageKey);
      } else {
        transactionList = await stock.get(
          page: pageKey,
          limit: _numberOfPostsPerRequest,
          end:
              context.read<SettingsProvider>().showFutureTXs
                  ? null
                  : DateFormat('yyyy-MM-dd', 'en_US').format(_tzHandler.sNow()),
          start:
              (context.read<FireflyService>().apiVersion! >= Version(2, 0, 9))
                  ? null
                  : "1900-01-01",
        );
      }

      if (_filters.account != null) {
        AccountRead account = _filters.account!;
        // Attempt to retrieve the opening balance
        double balance =
            _lastCalculatedBalance ??
            double.tryParse(account.attributes.currentBalance!) ?? 0.0;
        // If the account is a revenue/expense account, we need to invert the balance
        if (_lastCalculatedBalance == null &&
            _isRevenueOrExpense(account.attributes.type)) {
          balance *= -1;
        }
        for (TransactionRead item in transactionList) {
          // Attempt to retrieve the transaction total amount
          final TransactionSplit tx = item.attributes.transactions.first;
          final double amount = double.tryParse(tx.amount) ?? 0.0;
          // Should never be the case
          if (amount == 0.0) {
            continue;
          }
          _runningBalancesByTransactionId[item.id] = balance;
          balance = _updateBalance(balance, amount, tx.type);
          _lastCalculatedBalance = balance;
        }
      }

      final bool isLastPage = transactionList.length < _numberOfPostsPerRequest;

      if (mounted) {
        setState(() {
          _pagingState = _pagingState.copyWith(
            pages: <List<TransactionRead>>[
              ...?_pagingState.pages,
              transactionList,
            ],
            keys: <int>[...?_pagingState.keys, pageKey],
            hasNextPage: !isLastPage,
            isLoading: false,
            error: null,
          );
        });
      }
    } catch (e, stackTrace) {
      log.severe("_fetchPage()", e, stackTrace);
      if (mounted) {
        setState(() {
          _pagingState = _pagingState.copyWith(error: e, isLoading: false);
        });
      }
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    log.finest(() => "build()");
    super.build(context);

    return RefreshIndicator(
      onRefresh:
          () => Future<void>.sync(() {
            _rowsWithDate = <int>[];
            _lastDate = null;
            context.read<FireflyService>().transStock!.clear();
            setState(() {
              _pagingState = _pagingState.reset();
            });
          }),
      child: PagedListView<int, TransactionRead>(
        state: _pagingState,
        fetchNextPage: _fetchPage,
        builderDelegate: PagedChildBuilderDelegate<TransactionRead>(
          animateTransitions: true,
          transitionDuration: animDurationStandard,
          invisibleItemsThreshold: 10,
          itemBuilder: transactionRowBuilder,
          noMoreItemsIndicatorBuilder: (_) => const SizedBox(height: 68),
        ),
      ),
      //itemExtent: 80,
    );
  }

  Widget transactionRowBuilder(
    BuildContext context,
    TransactionRead item,
    int index
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
    List<String> tags = <String>[];
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
      if (trans.tags?.isNotEmpty ?? false) {
        tags = trans.tags!;
      }
      amount += double.parse(trans.amount);
      if (trans.foreignAmount?.isNotEmpty ?? false) {
        final double foreignAmount = double.parse(trans.foreignAmount!);
        final String foreignSymbol =
            trans.foreignCurrencySymbol ?? trans.foreignCurrencyCode ?? "";
        if (foreignAmount != 0 && foreignSymbol.isNotEmpty) {
          foreignAmounts[foreignSymbol] =
              (foreignAmounts[foreignSymbol] ?? 0) + foreignAmount;
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
      subtitle.add(
        const WidgetSpan(
          baseline: TextBaseline.ideographic,
          alignment: PlaceholderAlignment.middle,
          child: Padding(
            padding: EdgeInsets.only(right: 2),
            child: Icon(Icons.attachment),
          ),
        ),
      );
    }
    if (transactions.first.type == TransactionTypeProperty.transfer) {
      subtitle.add(
        TextSpan(text: "(${S.of(context).transactionTypeTransfer})"),
      );
      subtitle.add(
        const WidgetSpan(
          baseline: TextBaseline.ideographic,
          alignment: PlaceholderAlignment.middle,
          child: Padding(
            padding: EdgeInsets.only(right: 2),
            child: Icon(Icons.arrow_right_alt),
          ),
        ),
      );
    }
    subtitle.add(
      TextSpan(
        text:
            (transactions.first.type == TransactionTypeProperty.withdrawal ||
                    transactions.first.type == TransactionTypeProperty.transfer)
                ? destinationName
                : sourceName,
      ),
    );
    subtitle.add(const TextSpan(text: "\n"));
    if (category.isNotEmpty) {
      subtitle.add(
        TextSpan(
          text: category,
          style: const TextStyle(fontStyle: FontStyle.italic),
        ),
      );
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

    Widget transactionWidget = OpenContainer(
      openBuilder:
          (BuildContext context, Function closedContainer) =>
              TransactionPage(transaction: item),
      openColor: Theme.of(context).cardColor,
      closedColor: Theme.of(context).cardColor,
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
      ),
      closedElevation: 0,
      closedBuilder:
          (BuildContext context, Function openContainer) => GestureDetector(
            onLongPressStart: (LongPressStartDetails details) async {
              final Size screenSize = MediaQuery.of(context).size;
              final Offset offset = details.globalPosition;
              HapticFeedback.vibrate();
              final Function? func = await showMenu<Function>(
                context: context,
                position: RelativeRect.fromLTRB(
                  offset.dx,
                  offset.dy,
                  screenSize.width - offset.dx,
                  screenSize.height - offset.dy,
                ),
                items: <PopupMenuEntry<Function>>[
                  PopupMenuItem<Function>(
                    value: () async {
                      bool? ok = await Navigator.push(
                        context,
                        MaterialPageRoute<bool>(
                          builder:
                              (BuildContext context) => TransactionPage(
                                transaction: item,
                                clone: true,
                              ),
                        ),
                      );
                      if (ok ?? false) {
                        _rowsWithDate = <int>[];
                        _lastDate = null;
                        if (context.mounted) {
                          context.read<FireflyService>().transStock!.clear();
                        }
                      }
                      setState(() {
                        _pagingState = _pagingState.reset();
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.copy),
                        const SizedBox(width: 12),
                        Text(S.of(context).transactionDuplicate),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem<Function>(
                    value: () async {
                      final FireflyIii api = context.read<FireflyService>().api;
                      bool? ok = await showDialog<bool>(
                        context: context,
                        builder:
                            (BuildContext context) =>
                                const DeletionConfirmDialog(),
                      );
                      if (!(ok ?? false)) {
                        return;
                      }

                      await api.v1TransactionsIdDelete(id: item.id);
                      _rowsWithDate = <int>[];
                      _lastDate = null;
                      if (context.mounted) {
                        context.read<FireflyService>().transStock!.clear();
                      }
                      setState(() {
                        _pagingState = _pagingState.reset();
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.delete),
                        const SizedBox(width: 12),
                        Text(
                          MaterialLocalizations.of(context).deleteButtonTooltip,
                        ),
                      ],
                    ),
                  ),
                ],
                clipBehavior: Clip.hardEdge,
              );
              if (func == null) {
                return;
              }
              func();
            },
            child: ListTile(
              leading: CircleAvatar(
                foregroundColor: Colors.white,
                backgroundColor: transactions.first.type.color,
                child: Icon(transactions.first.type.icon),
              ),
              title: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              subtitle: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: subtitle,
                      ),
                    ),
                  ),
                  if (!context.watch<SettingsProvider>().hideTags &&
                      tags.isNotEmpty) ...<Widget>[
                    Wrap(
                      children:
                          tags
                              .map(
                                (String tag) => Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        const Icon(
                                          Icons.label_outline,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 5),
                                        Flexible(
                                          child: RichText(
                                            overflow: TextOverflow.fade,
                                            text: TextSpan(
                                              style:
                                                  Theme.of(
                                                    context,
                                                  ).textTheme.bodyMedium,
                                              text: tag,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                  ],
                ],
              ),
              isThreeLine: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
              trailing: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 100,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (foreignText.isNotEmpty)
                      Text(
                        foreignText,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.blue),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    Text(
                      currency.fmt(amount),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: transactions.first.type.color,
                            fontFeatures: const <FontFeature>[
                              FontFeature.tabularFigures(),
                            ],
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (reconciled)
                      const Icon(
                        Icons.check,
                        size: 16,
                      ),
                    if (_filters.account != null)
                      Text(
                        currency.fmt(_runningBalancesByTransactionId[item.id] ?? 0.0),
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
            ),
          ),
      onClosed: (bool? refresh) async {

        if (_filters.account != null) {
          // Reset last balance calculated
          FireflyIii api = context.read<FireflyService>().api;
          // Retrieve the account to get the current balance
          final Response<AccountSingle> respAccount = await api.v1AccountsIdGet(
            id: _filters.account!.id,
          );
          apiThrowErrorIfEmpty(respAccount, mounted ? context : null);
          final AccountRead account = respAccount.body!.data;
          _lastCalculatedBalance = double.tryParse(account.attributes.currentBalance!) ?? 0.0;
          // If the account is a revenue/expense account, we need to invert the balance
          if (_isRevenueOrExpense(account.attributes.type)) {
            _lastCalculatedBalance =
                _lastCalculatedBalance != null
                    ? _lastCalculatedBalance! * -1
                    : 0;
          }
        }

        if (refresh ?? false == true) {
          _rowsWithDate = <int>[];
          _lastDate = null;
          if (context.mounted) {
            context.read<FireflyService>().transStock!.clear();
          }
        }
        setState(() {
          _pagingState = _pagingState.reset();
        });
      },
    );

    // Date
    DateTime date = _tzHandler.sTime(transactions.first.date).toLocal();
    // Show Date Banner when:
    // 1. _lastDate is not set (= first element)
    // 2. _lastDate has a different day than current date (= date changed) and
    //    is an earlier date (= scrolling down)
    // 3. index indicates we have to.
    if (_lastDate == null ||
        (_lastDate!.clearTime() != date.clearTime() &&
            date.clearTime().isBefore(_lastDate!.clearTime())) ||
        _rowsWithDate.contains(index)) {
      // Add date row
      _rowsWithDate.add(index);
      transactionWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 0, 8),
            child: Text(
              DateFormat.yMMMMEEEEd().format(date),
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
