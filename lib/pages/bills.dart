import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'package:chopper/chopper.dart' show Response;

import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/pages/bills/billdetails.dart';

class BillsPage extends StatefulWidget {
  const BillsPage({super.key});

  @override
  State<BillsPage> createState() => _BillsPageState();
}

class _BillsPageState extends State<BillsPage>
    with SingleTickerProviderStateMixin {
  final Logger log = Logger("Pages.Bills");

  @override
  Widget build(BuildContext context) {
    log.finest(() => "build()");

    return RefreshIndicator(
      onRefresh: _refreshStats,
      child: FutureBuilder<Map<String, List<BillRead>>>(
        future: _fetchBills(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, List<BillRead>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return ListView(
              cacheExtent: 1000,
              padding: const EdgeInsets.all(8),
              children: _groupBuilder(snapshot.data!),
            );
          } else if (snapshot.hasError) {
            log.severe(
                "error fetching bills", snapshot.error, snapshot.stackTrace);
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
      ),
    );
  }

  Future<Map<String, List<BillRead>>> _fetchBills() async {
    final FireflyIii api = context.read<FireflyService>().api;
    final DateTime today = DateTime.now();
    List<BillRead> bills = <BillRead>[];
    late Response<BillArray> response;
    int pageNumber = 0;

    do {
      pageNumber += 1;
      response = await api.v1BillsGet(
        page: pageNumber,
        start: DateTime(today.year, today.month, 1).toString(),
        end: DateTime(today.year, today.month + 1, 0).toString(),
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

      bills.addAll(response.body!.data);
    } while ((response.body!.meta.pagination?.currentPage ?? 1) <
        (response.body!.meta.pagination?.totalPages ?? 1));

    bills.sort((BillRead a, BillRead b) => (a.attributes.objectGroupOrder ?? 0)
        .compareTo(b.attributes.objectGroupOrder ?? 0));
    Map<String, List<BillRead>> billsMap = <String, List<BillRead>>{};

    for (BillRead bill in bills) {
      String key =
          bill.attributes.objectGroupTitle ?? S.of(context).billsUngrouped;
      if (!billsMap.containsKey(key)) {
        billsMap[key] = <BillRead>[];
      }

      billsMap[key]!.add(bill);
    }

    return billsMap;
  }

  Future<void> _refreshStats() async {
    setState(() {});
  }

  List<Widget> _groupBuilder(Map<String, List<BillRead>> bills) {
    List<Widget> widgets = <Widget>[];

    bills.forEach((String groupTitle, List<BillRead> groupBills) {
      widgets.add(Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          groupTitle,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.grey,
              ),
        ),
      ));

      widgets.addAll(_billRowBuilder(groupBills));

      widgets.add(const SizedBox(height: 16));
    });

    return widgets;
  }

  List<Widget> _billRowBuilder(List<BillRead> bills) {
    List<Widget> widgets = <Widget>[];

    for (BillRead bill in bills) {
      widgets.add(OpenContainer(
        openBuilder: (BuildContext context, Function closedContainer) =>
            Scaffold(
          appBar: AppBar(
            title: Text(bill.attributes.name),
          ),
          body: BillDetails(billId: bill.id),
        ),
        openColor: Theme.of(context).cardColor,
        closedColor: Theme.of(context).cardColor,
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        closedElevation: 0,
        closedBuilder: (BuildContext context, Function openContainer) =>
            ListTile(
          title: Text(bill.attributes.name),
          subtitle: Text(
            S.of(context).billFrequency(bill.attributes.repeatFreq.toString()),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.grey,
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
              style: Theme.of(context).textTheme.bodyMedium,
              children: <InlineSpan>[
                TextSpan(
                    text: _getAverageBillAmount(bill),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontFeatures: const <FontFeature>[
                        FontFeature.tabularFigures()
                      ],
                    )),
                const TextSpan(text: "\n"),
                _getExpectedDate(bill),
              ],
            ),
          ),
          onTap: () => openContainer(),
        ),
      ));
    }

    return widgets;
  }

  String _getAverageBillAmount(BillRead item) {
    double min = double.tryParse(item.attributes.amountMin) ?? 0;
    double max = double.tryParse(item.attributes.amountMax) ?? 0;

    final CurrencyRead currency = CurrencyRead(
      id: "0",
      type: "currencies",
      attributes: Currency(
        code: item.attributes.currencyCode ?? "",
        name: "",
        symbol: item.attributes.currencySymbol ?? "",
        decimalPlaces: item.attributes.currencyDecimalPlaces,
      ),
    );

    return "~${currency.fmt((min + max) / 2)}";
  }

  TextSpan _getExpectedDate(BillRead item) {
    if (!item.attributes.active!) {
      return TextSpan(
          text: S.of(context).billInactive,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.grey));
    } else if (item.attributes.paidDates!.isNotEmpty) {
      // Bill was paid this period
      return TextSpan(
          text: S
              .of(context)
              .billPaidOn(item.attributes.paidDates![0].date!.toLocal()),
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Theme.of(context).colorScheme.primary));
    } else if (item.attributes.nextExpectedMatch != null) {
      // Bill expected this period
      return TextSpan(
          text: S
              .of(context)
              .billExpectedOn(item.attributes.nextExpectedMatch!.toLocal()),
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.orangeAccent));
    } else {
      // Bill not expected this period
      return TextSpan(
          text: S.of(context).billNotExpected,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.orangeAccent));
    }
  }
}
