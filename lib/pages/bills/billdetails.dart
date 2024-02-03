import 'dart:math';
import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:waterflyiii/extensions.dart';

import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/pages/bills/billchart.dart';
import 'package:waterflyiii/timezonehandler.dart';
import 'package:waterflyiii/pages/transaction.dart';

class BillDetails extends StatefulWidget {
  const BillDetails({super.key, required this.billId});

  final String billId;

  @override
  State<BillDetails> createState() => _BillDetailsState();
}

class _BillDetailsState extends State<BillDetails> {
  final Logger log = Logger("Pages.BillDetails");
  final PagingController<int, TransactionRead> _pagingController =
      PagingController<int, TransactionRead>(
    firstPageKey: 1,
    invisibleItemsThreshold: 20,
  );
  final GlobalKey<BillChartState> _billChartKey = GlobalKey<BillChartState>();

  late CurrencyRead _currency;
  late TimeZoneHandler _tzHandler;
  late Future<BillRead> _futureFetch;

  @override
  void initState() {
    log.finest(() => "initState()");

    super.initState();

    _tzHandler = context.read<FireflyService>().tzHandler;
    _futureFetch = _fetchBill();
    _pagingController
        .addPageRequestListener((int pageKey) => _fetchPage(pageKey));
  }

  @override
  void dispose() {
    _pagingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BillRead>(
      future: _futureFetch,
      builder: (BuildContext context, AsyncSnapshot<BillRead> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          BillRead bill = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: <Widget>[
                Card(
                  margin: const EdgeInsets.all(0),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                          title: bill.attributes.amountMax ==
                                  bill.attributes.amountMin
                              ? Text(S.of(context).billsExactAmountAndFrequency(
                                  _currency.fmt(
                                      double.tryParse(bill.attributes.amountMin) ??
                                          0),
                                  bill.attributes.repeatFreq.toString()))
                              : Text(S.of(context).billsAmountAndFrequency(
                                  _currency.fmt(
                                      double.tryParse(bill.attributes.amountMin) ??
                                          0),
                                  _currency.fmt(
                                      double.tryParse(bill.attributes.amountMax) ??
                                          0),
                                  bill.attributes.repeatFreq.toString()))),
                      ListTile(
                        title: Text(S.of(context).billsIsActive),
                        trailing: Text.rich(TextSpan(
                          text: bill.attributes.active!
                              ? S.of(context).yes
                              : S.of(context).no,
                          children: <InlineSpan>[
                            WidgetSpan(
                                child: Icon(
                              bill.attributes.active!
                                  ? Icons.check
                                  : Icons.close,
                              color: bill.attributes.active!
                                  ? Colors.green
                                  : Colors.red,
                            )),
                          ],
                          style: Theme.of(context).textTheme.bodyLarge,
                        )),
                      ),
                      ListTile(
                        title: Text(S.of(context).billsNextExpectedMatch),
                        trailing: Text(
                          DateFormat.yMMMMd().format(_tzHandler
                              .sTime(bill.attributes.payDates![0])
                              .toLocal()),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      BillChart(key: _billChartKey, billId: bill.id),
                    ],
                  ),
                ),
                Expanded(
                  child: PagedListView<int, TransactionRead>(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<TransactionRead>(
                        animateTransitions: true,
                        transitionDuration: animDurationStandard,
                        itemBuilder: _transactionRowBuilder,
                        noItemsFoundIndicatorBuilder: (BuildContext context) =>
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Text.rich(
                                    textAlign: TextAlign.center,
                                    TextSpan(
                                        text: S.of(context).billsNoTransactions,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                        children: <InlineSpan>[
                                          const TextSpan(text: "\n\n"),
                                          TextSpan(
                                            text: S.of(context).billsListEmpty,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          )
                                        ])),
                              ),
                            )),
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          log.severe(
              "error fetching bill", snapshot.error, snapshot.stackTrace);
          return Text(snapshot.error!.toString());
        } else {
          return const Padding(
            padding: EdgeInsets.all(8),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _transactionRowBuilder(
      BuildContext context, TransactionRead transaction, int index) {
    DateTime date = _tzHandler
        .sTime(transaction.attributes.transactions.first.date)
        .toLocal();

    return OpenContainer(
      openBuilder: (BuildContext context, Function closedContainer) =>
          TransactionPage(transaction: transaction),
      openColor: Theme.of(context).cardColor,
      closedColor: Theme.of(context).dialogBackgroundColor,
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      closedElevation: 0,
      closedBuilder: (BuildContext context, Function openContainer) => ListTile(
        title: Text.rich(_getTransactionTitle(transaction)),
        subtitle: Text(
          DateFormat.yMMMMd().format(date),
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Theme.of(context).colorScheme.secondary),
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
                fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
              ),
              children: <InlineSpan>[
                const TextSpan(text: "\n"),
                TextSpan(
                  text: _getTransactionSource(transaction),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                )
              ]),
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
                    ))
          ]);
    } else {
      return TextSpan(
        text: transaction.attributes.transactions.first.description,
      );
    }
  }

  String _getTransactionAmount(TransactionRead transaction) {
    double amount = 0;
    for (TransactionSplit split in transaction.attributes.transactions) {
      if (split.billId == widget.billId) {
        amount += double.tryParse(split.amount) ?? 0;
      }
    }

    return _currency.fmt(amount);
  }

  String _getTransactionSource(TransactionRead transaction) {
    for (TransactionSplit split in transaction.attributes.transactions) {
      if (split.billId == widget.billId) {
        return split.sourceName!;
      }
    }
    return "";
  }

  Future<BillRead> _fetchBill() async {
    final FireflyIii api = context.read<FireflyService>().api;
    // Set start date at epoch to ensure we fetch the whole history
    final DateTime start = DateTime.utc(-271821, 04, 20);
    final DateTime now = DateTime.now();
    // Set end date to the first day of upcoming month (period)
    final DateTime end = now.copyWith(month: now.month + 1, day: 1);

    Response<BillSingle> response = await api.v1BillsIdGet(
      id: widget.billId,
      start: start.toString(),
      end: end.toString(),
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

    BillRead bill = response.body!.data;
    _currency = CurrencyRead(
      id: "0",
      type: "currencies",
      attributes: Currency(
        code: bill.attributes.currencyCode ?? "",
        name: "",
        symbol: bill.attributes.currencySymbol ?? "",
        decimalPlaces: bill.attributes.currencyDecimalPlaces,
      ),
    );

    return bill;
  }

  Future<void> _fetchPage(int page) async {
    final FireflyIii api = context.read<FireflyService>().api;

    Response<TransactionArray> response = await api.v1BillsIdTransactionsGet(
      id: widget.billId,
      page: page,
      limit: 5,
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

    List<TransactionRead> transactions = response.body!.data;
    _billChartKey.currentState!.addTransactions(transactions);

    if ((response.body!.meta.pagination?.currentPage ?? 1) ==
        (response.body!.meta.pagination?.totalPages ?? 1)) {
      _pagingController.appendLastPage(transactions);
    } else {
      _pagingController.appendPage(transactions, page + 1);
    }
  }
}
