import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
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
  late CurrencyRead _currency;
  late TimeZoneHandler _tzHandler;

  late Future<BillTransactionDetails> _futureFetch;

  @override
  void initState() {
    log.finest(() => "initState()");

    super.initState();

    _tzHandler = context.read<FireflyService>().tzHandler;
    _futureFetch = _fetchBillDetails();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BillTransactionDetails>(
      future: _futureFetch,
      builder: (BuildContext context,
          AsyncSnapshot<BillTransactionDetails> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          BillTransactionDetails billTransactionDetails = snapshot.data!;
          BillRead bill = billTransactionDetails.bill;
          List<TransactionRead> transactions =
              billTransactionDetails.transactions;

          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 16),
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          S.of(context).billsDetailsTitle,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                      ),
                      ListTile(
                          title: bill.attributes.amountMax ==
                                  bill.attributes.amountMin
                              ? Text(S.of(context).billExactAmountAndFrequency(
                                  _currency.fmt(
                                      double.tryParse(bill.attributes.amountMin) ??
                                          0),
                                  bill.attributes.repeatFreq.toString()))
                              : Text(S.of(context).billAmountAndFrequency(
                                  _currency.fmt(
                                      double.tryParse(bill.attributes.amountMin) ??
                                          0),
                                  _currency.fmt(
                                      double.tryParse(bill.attributes.amountMax) ??
                                          0),
                                  bill.attributes.repeatFreq.toString()))),
                      ListTile(
                        title: Text(S.of(context).billIsActive),
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
                        title: Text(S.of(context).billNextExpectedMatch),
                        trailing: Text(
                          DateFormat.yMMMMd().format(_tzHandler
                              .sTime(bill.attributes.payDates![0])
                              .toLocal()),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        S.of(context).billsChartTitle,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: 125,
                      child: BillChart(
                          billId: widget.billId, transactions: transactions),
                    )
                  ],
                )),
                const SizedBox(height: 16),
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          S.of(context).billsConnectedTransactionsTitle,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                      ),
                      transactions.isNotEmpty
                          ? ListView.separated(
                              shrinkWrap: true,
                              cacheExtent: 1000,
                              padding: const EdgeInsets.all(8),
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: transactions.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  _transactionWidgetBuilder(
                                      context, transactions[index]),
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(height: 5),
                            )
                          : Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: Text(
                                S.of(context).billNoTransactions,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
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

  Widget _transactionWidgetBuilder(
      BuildContext context, TransactionRead transaction) {
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
        title: Text(DateFormat.yMMMMd().format(date)),
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
          ),
        ),
        onTap: () => openContainer(),
      ),
    );
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

  Future<BillTransactionDetails> _fetchBillDetails() async {
    BillRead bill = await _fetchBill();
    _currency = _getCurrencyForBill(bill);

    return BillTransactionDetails(
      bill: bill,
      transactions: await _fetchBillTransactions(bill),
    );
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

    return response.body!.data;
  }

  Future<List<TransactionRead>> _fetchBillTransactions(BillRead bill) async {
    final FireflyIii api = context.read<FireflyService>().api;
    List<TransactionRead> transactions = <TransactionRead>[];
    late Response<TransactionArray> response;
    int pageNumber = 0;

    do {
      pageNumber += 1;
      response = await api.v1BillsIdTransactionsGet(
        id: bill.id,
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

      transactions.addAll(response.body!.data);
    } while ((response.body!.meta.pagination?.currentPage ?? 1) <
        (response.body!.meta.pagination?.totalPages ?? 1));

    return transactions;
  }

  CurrencyRead _getCurrencyForBill(BillRead bill) {
    return CurrencyRead(
      id: "0",
      type: "currencies",
      attributes: Currency(
        code: bill.attributes.currencyCode ?? "",
        name: "",
        symbol: bill.attributes.currencySymbol ?? "",
        decimalPlaces: bill.attributes.currencyDecimalPlaces,
      ),
    );
  }
}

class BillTransactionDetails {
  const BillTransactionDetails(
      {required this.bill, required this.transactions});

  final BillRead bill;
  final List<TransactionRead> transactions;
}
