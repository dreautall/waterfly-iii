import 'package:animations/animations.dart';
import 'package:chopper/chopper.dart' show Response;
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/pages/bills/billchart.dart';
import 'package:waterflyiii/pages/transaction.dart';
import 'package:waterflyiii/timezonehandler.dart';

class BillDetails extends StatefulWidget {
  const BillDetails({super.key, required this.bill});

  final BillRead bill;

  @override
  State<BillDetails> createState() => _BillDetailsState();
}

class _BillDetailsState extends State<BillDetails> {
  final Logger log = Logger("Pages.Bills.Details");
  PagingState<int, TransactionRead> _pagingState =
      PagingState<int, TransactionRead>();
  final GlobalKey<BillChartState> _billChartKey = GlobalKey<BillChartState>();

  late final CurrencyRead _currency;
  late final TimeZoneHandler _tzHandler;

  @override
  void initState() {
    log.finest(() => "initState()");

    super.initState();

    _currency = CurrencyRead(
      id: "0",
      type: "currencies",
      attributes: Currency(
        code: widget.bill.attributes.currencyCode ?? "",
        name: "",
        symbol: widget.bill.attributes.currencySymbol ?? "",
        decimalPlaces: widget.bill.attributes.currencyDecimalPlaces,
      ),
    );
    _tzHandler = context.read<FireflyService>().tzHandler;
  }

  @override
  Widget build(BuildContext context) {
    log.finest(() => "build()");

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bill.attributes.name),
        elevation: 1,
        scrolledUnderElevation: 1,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Column(
        children: <Widget>[
          AnimatedHeight(
            child: Card(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 1),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.info_outline),
                    ),
                    title:
                        widget.bill.attributes.amountMax ==
                                widget.bill.attributes.amountMin
                            ? Text(
                              S
                                  .of(context)
                                  .billsExactAmountAndFrequency(
                                    _currency.fmt(
                                      double.tryParse(
                                            widget.bill.attributes.amountMin,
                                          ) ??
                                          0,
                                    ),
                                    widget.bill.attributes.repeatFreq
                                        .toString(),
                                    widget.bill.attributes.skip ?? 0,
                                  ),
                            )
                            : Text(
                              S
                                  .of(context)
                                  .billsAmountAndFrequency(
                                    _currency.fmt(
                                      double.tryParse(
                                            widget.bill.attributes.amountMin,
                                          ) ??
                                          0,
                                    ),
                                    _currency.fmt(
                                      double.tryParse(
                                            widget.bill.attributes.amountMax,
                                          ) ??
                                          0,
                                    ),
                                    widget.bill.attributes.repeatFreq
                                        .toString(),
                                    widget.bill.attributes.skip ?? 0,
                                  ),
                            ),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      child: Icon(
                        widget.bill.attributes.active ?? false
                            ? Icons.check_box_outlined
                            : Icons.check_box_outline_blank,
                      ),
                    ),
                    title: Text(
                      widget.bill.attributes.active ?? false
                          ? S.of(context).billsIsActive
                          : S.of(context).billsNotActive,
                    ),
                  ),
                  ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.calendar_month),
                    ),
                    title: Text(S.of(context).billsNextExpectedMatch),
                    trailing: Text(
                      DateFormat.yMMMMd().format(
                        _tzHandler
                            .sTime(widget.bill.attributes.payDates![0])
                            .toLocal(),
                      ),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  const SizedBox(height: 8),
                  BillChart(key: _billChartKey, billId: widget.bill.id),
                ],
              ),
            ),
          ),
          Expanded(
            /*child: RawScrollbar(
              radius: const Radius.circular(12),
              thickness: 5,
              thumbVisibility: true,
              thumbColor: Theme.of(context).colorScheme.outlineVariant,
              crossAxisMargin: 4,
              mainAxisMargin: 4,*/
            child: PagedListView<int, TransactionRead>(
              state: _pagingState,
              fetchNextPage: _fetchPage,
              physics: const ClampingScrollPhysics(),
              builderDelegate: PagedChildBuilderDelegate<TransactionRead>(
                animateTransitions: true,
                transitionDuration: animDurationStandard,
                invisibleItemsThreshold: 20,
                itemBuilder: _transactionRowBuilder,
                noItemsFoundIndicatorBuilder: _emptyListBuilder,
              ),
            ),
            //),
          ),
        ],
      ),
    );
  }

  Widget _transactionRowBuilder(
    BuildContext context,
    TransactionRead transaction,
    int index,
  ) {
    DateTime date =
        _tzHandler
            .sTime(transaction.attributes.transactions.first.date)
            .toLocal();

    return OpenContainer(
      openBuilder:
          (BuildContext context, Function closedContainer) =>
              FutureBuilder<TransactionRead>(
                future: _fetchFullTx(transaction.id),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<TransactionRead> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData &&
                      snapshot.data != null) {
                    return TransactionPage(transaction: snapshot.data);
                  }
                  if (snapshot.hasError) {
                    Navigator.of(context).pop();
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
      openColor: Theme.of(context).cardColor,
      closedColor:
          Theme.of(context).dialogTheme.backgroundColor ?? Colors.white,
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      closedElevation: 0,
      closedBuilder:
          (BuildContext context, Function openContainer) => ListTile(
            title: Text.rich(_getTransactionTitle(transaction)),
            subtitle: Text(
              DateFormat.yMMMMd().format(date),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            isThreeLine: false,
            trailing: RichText(
              textAlign: TextAlign.end,
              maxLines: 2,
              text: TextSpan(
                text: _getTransactionAmount(transaction),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.red,
                  fontFeatures: const <FontFeature>[
                    FontFeature.tabularFigures(),
                  ],
                ),
                children: <InlineSpan>[
                  const TextSpan(text: "\n"),
                  TextSpan(
                    text: _getTransactionSource(transaction),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () => openContainer(),
          ),
    );
  }

  TextSpan _getTransactionTitle(TransactionRead transaction) {
    if (transaction.attributes.groupTitle != null) {
      return TextSpan(
        text: transaction.attributes.groupTitle,
        children: <InlineSpan>[
          TextSpan(
            text: " (${S.of(context).generalMultiple})",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      );
    }

    return TextSpan(
      text: transaction.attributes.transactions.first.description,
    );
  }

  String _getTransactionAmount(TransactionRead transaction) {
    double amount = 0;
    for (TransactionSplit split in transaction.attributes.transactions) {
      if (split.billId == widget.bill.id) {
        amount += double.tryParse(split.amount) ?? 0;
      }
    }

    return _currency.fmt(amount);
  }

  String _getTransactionSource(TransactionRead transaction) {
    for (TransactionSplit split in transaction.attributes.transactions) {
      if (split.billId == widget.bill.id) {
        return split.sourceName!;
      }
    }
    return "";
  }

  Widget _emptyListBuilder(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            text: S.of(context).billsNoTransactions,
            style: Theme.of(context).textTheme.titleMedium,
            children: <InlineSpan>[
              const TextSpan(text: "\n\n"),
              TextSpan(
                text: S.of(context).billsListEmpty,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _fetchPage() async {
    if (_pagingState.isLoading) return;

    try {
      final FireflyIii api = context.read<FireflyService>().api;

      final int pageKey = (_pagingState.keys?.last ?? 0) + 1;
      log.finest(
        "Getting page $pageKey (${_pagingState.pages?.length} items loaded so far)",
      );

      Response<TransactionArray> response = await api.v1BillsIdTransactionsGet(
        id: widget.bill.id,
        page: pageKey,
      );
      apiThrowErrorIfEmpty(response, mounted ? context : null);

      _billChartKey.currentState!.doneLoading();
      List<TransactionRead> transactions = response.body!.data;
      _billChartKey.currentState!.addTransactions(transactions);

      final bool isLastPage =
          (response.body!.meta.pagination?.currentPage ?? 1) ==
          (response.body!.meta.pagination?.totalPages ?? 1);

      if (mounted) {
        setState(() {
          _pagingState = _pagingState.copyWith(
            pages: <List<TransactionRead>>[
              ...?_pagingState.pages,
              transactions,
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

  Future<TransactionRead> _fetchFullTx(String id) async {
    final FireflyIii api = context.read<FireflyService>().api;

    Response<TransactionSingle> response = await api.v1TransactionsIdGet(
      id: id,
    );
    apiThrowErrorIfEmpty(response, mounted ? context : null);

    return response.body!.data;
  }
}
