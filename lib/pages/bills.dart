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
import 'package:waterflyiii/timezonehandler.dart';

class BillsPage extends StatefulWidget {
  const BillsPage({super.key});

  @override
  State<BillsPage> createState() => _BillsPageState();
}

class _BillsPageState extends State<BillsPage>
    with SingleTickerProviderStateMixin {
  final Logger log = Logger("Pages.Bills");
  late TimeZoneHandler _tzHandler;

  @override
  void initState() {
    super.initState();

    _tzHandler = context.read<FireflyService>().tzHandler;
  }

  @override
  Widget build(BuildContext context) {
    log.finest(() => "build()");

    return RefreshIndicator(
      onRefresh: () async => setState(() {}),
      child: FutureBuilder<Map<String, List<BillRead>>>(
        future: _fetchBills(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, List<BillRead>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
            log.severe(
              "error fetching bills",
              snapshot.error,
              snapshot.stackTrace,
            );
            return Center(
              child: Text(
                S.of(context).billsErrorLoading,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.error),
              ),
            );
          }
          return ListView(
            cacheExtent: 1000,
            children: _groupBuilder(snapshot.data!),
          );
        },
      ),
    );
  }

  List<Widget> _groupBuilder(Map<String, List<BillRead>> bills) {
    List<Widget> widgets = <Widget>[];

    bills.forEach((String groupTitle, List<BillRead> groupBills) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 16),
          child: Text(
            groupTitle,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      );

      widgets.addAll(_billRowBuilder(groupBills));
    });

    return widgets;
  }

  List<Widget> _billRowBuilder(List<BillRead> bills) {
    List<Widget> widgets = <Widget>[];

    for (BillRead bill in bills) {
      widgets.add(OpenContainer(
        openBuilder: (BuildContext context, Function closedContainer) =>
            BillDetails(bill: bill),
        openColor: Theme.of(context).cardColor,
        closedColor: Theme.of(context).cardColor,
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            bottomLeft: Radius.circular(16),
          ),
        ),
        closedElevation: 0,
        closedBuilder: (BuildContext context, Function openContainer) =>
            ListTile(
          title: Text(
            bill.attributes.name,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: bill.attributes.active ?? false
                      ? Theme.of(context).colorScheme.onSurface
                      : Theme.of(context).disabledColor,
                ),
          ),
          subtitle: Text(
            S.of(context).billsFrequency(bill.attributes.repeatFreq.toString()),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: bill.attributes.active ?? false
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).disabledColor,
                ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
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
                    color: Colors.red,
                    fontFeatures: const <FontFeature>[
                      FontFeature.tabularFigures()
                    ],
                  ),
                ),
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

    return "${min != max ? "~ " : ""}${currency.fmt((min + max) / 2)}";
  }

  TextSpan _getExpectedDate(BillRead item) {
    if (!(item.attributes.active ?? false)) {
      // Bill is inactive
      return TextSpan(
        text: S.of(context).billsInactive,
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: Theme.of(context).colorScheme.secondary),
      );
    } else if (item.attributes.paidDates?.isNotEmpty ?? false) {
      // Bill was paid this period
      return TextSpan(
          text: S.of(context).billsPaidOn(
                _tzHandler
                    .sTime(item.attributes.paidDates!.last.date!)
                    .toLocal(),
              ),
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Theme.of(context).colorScheme.primary));
    } else if (item.attributes.nextExpectedMatch != null) {
      // Bill expected this period
      return TextSpan(
        text: S.of(context).billsExpectedOn(
              _tzHandler.sTime(item.attributes.nextExpectedMatch!).toLocal(),
            ),
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: Colors.orangeAccent),
      );
    } else {
      // Bill not expected this period
      return TextSpan(
        text: S.of(context).billsNotExpected,
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: Colors.orangeAccent),
      );
    }
  }

  Future<Map<String, List<BillRead>>> _fetchBills() async {
    final FireflyIii api = context.read<FireflyService>().api;
    // Start date set to first day of this month (period)
    final DateTime start = DateTime.now().copyWith(day: 1);
    // End date set to first day of upcoming month (period)
    final DateTime end = start.copyWith(month: start.month + 1);
    List<BillRead> bills = <BillRead>[];
    late Response<BillArray> response;
    int pageNumber = 0;

    do {
      pageNumber += 1;
      response = await api.v1BillsGet(
        page: pageNumber,
        start: DateFormat('yyyy-MM-dd', 'en_US').format(start),
        end: DateFormat('yyyy-MM-dd', 'en_US').format(end),
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
      String key = bill.attributes.objectGroupTitle ??
          (context.mounted ? S.of(context).billsUngrouped : "");
      if (!billsMap.containsKey(key)) {
        billsMap[key] = <BillRead>[];
      }

      billsMap[key]!.add(bill);
    }

    return billsMap;
  }
}