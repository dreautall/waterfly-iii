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
import 'package:waterflyiii/pages/navigation.dart';

class BillsPage extends StatefulWidget {
  const BillsPage({super.key});

  @override
  State<BillsPage> createState() => _BillsPageState();
}

enum BillSort {
  alphabeticalAscending("alphabetical", "ascending"),
  alphabeticalDescending("alphabetical", "descending"),
  frequencyAscending("frequency", "ascending"),
  frequencyDescending("frequency", "descending");

  final String type;
  final String direction;

  const BillSort(this.type, this.direction);
}

class _BillsPageState extends State<BillsPage>
    with SingleTickerProviderStateMixin {
  final Logger log = Logger("Pages.Bills");
  late TimeZoneHandler _tzHandler;

  bool isListView = false;
  BillSort sortOrder = BillSort.alphabeticalAscending;

  @override
  void initState() {
    super.initState();

    _tzHandler = context.read<FireflyService>().tzHandler;
  }

  @override
  Widget build(BuildContext context) {
    log.finest(() => "build()");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NavPageElements>().appBarActions = <Widget>[
        if (isListView)
          IconButton(
            icon: const Icon(Icons.sort),
            tooltip: S.of(context).billsChangeSortOrderTooltip,
            onPressed: _showSortOrderPickerDialog,
          ),
        IconButton(
          icon: isListView
              ? const Icon(Icons.table_rows_outlined)
              : const Icon(Icons.view_agenda_outlined),
          tooltip: S.of(context).billsChangeLayoutTooltip,
          onPressed: _showLayoutPickerDialog,
        ),
      ];
    });

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
          return Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: ListView(
              cacheExtent: 1000,
              children: isListView
                  ? _listBuilder(snapshot.data!)
                  : _groupBuilder(snapshot.data!),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _listBuilder(Map<String, List<BillRead>> groupedBills) {
    List<BillRead> billList =
        groupedBills.values.expand((List<BillRead> x) => x).toList();

    switch (sortOrder) {
      case BillSort.alphabeticalAscending:
        billList.sort((BillRead a, BillRead b) =>
            a.attributes.name.compareTo(b.attributes.name));
      case BillSort.alphabeticalDescending:
        billList.sort((BillRead a, BillRead b) =>
            b.attributes.name.compareTo(a.attributes.name));
      case BillSort.frequencyAscending:
        billList.sort((BillRead a, BillRead b) => Enum.compareByIndex(
            a.attributes.repeatFreq, b.attributes.repeatFreq));
      case BillSort.frequencyDescending:
        billList.sort((BillRead a, BillRead b) => Enum.compareByIndex(
            b.attributes.repeatFreq, a.attributes.repeatFreq));
    }

    return billList.map((BillRead bill) => _billRowBuilder(bill)).toList();
  }

  List<Widget> _groupBuilder(Map<String, List<BillRead>> groupedBills) {
    List<Widget> widgets = <Widget>[];

    groupedBills.forEach((String groupTitle, List<BillRead> groupBills) {
      widgets.add(Card(
        clipBehavior: Clip.antiAlias,
        child: ExpansionTile(
          title: Text(
            groupTitle,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
          initiallyExpanded: true,
          collapsedShape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(1, 0, 1, 1),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(11),
                    bottomLeft: Radius.circular(11),
                  )),
              child: Column(
                children: _billGroupedRowBuilder(groupBills),
              ),
            ),
          ],
        ),
      ));
    });

    return widgets;
  }

  List<Widget> _billGroupedRowBuilder(List<BillRead> bills) {
    List<Widget> widgets = <Widget>[];

    for (BillRead bill in bills) {
      widgets.add(_billRowBuilder(bill));
    }

    return widgets;
  }

  Widget _billRowBuilder(BillRead bill) {
    return OpenContainer(
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
      closedBuilder: (BuildContext context, Function openContainer) => ListTile(
        leading: const Icon(Icons.receipt_outlined),
        title: Text(
          bill.attributes.name,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: bill.attributes.active ?? false
                    ? Theme.of(context).colorScheme.onSurface
                    : Theme.of(context).disabledColor,
              ),
        ),
        subtitle: Text(
          S.of(context).billsFrequencySkip(
              bill.attributes.repeatFreq.toString(), bill.attributes.skip ?? 0),
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
    );
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
            .copyWith(color: Theme.of(context).disabledColor),
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

  void _showLayoutPickerDialog() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 16),
                Text(
                  S.of(context).billsDialogLayoutTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: const Icon(Icons.view_agenda_outlined),
                  title: Text(S.of(context).billsLayoutGroupTitle,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                  subtitle: Text(
                    S.of(context).billsLayoutGroupSubtitle,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                  trailing: !isListView
                      ? const Icon(Icons.check)
                      : const SizedBox.shrink(),
                  onTap: () => setState(() {
                    Navigator.pop(context);
                    isListView = false;
                  }),
                ),
                const Divider(indent: 55, endIndent: 20),
                ListTile(
                  leading: const Icon(Icons.table_rows_outlined),
                  title: Text(
                    S.of(context).billsLayoutListTitle,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  subtitle: Text(
                    S.of(context).billsLayoutListSubtitle,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                  trailing: isListView
                      ? const Icon(Icons.check)
                      : const SizedBox.shrink(),
                  onTap: () => setState(() {
                    Navigator.pop(context);
                    isListView = true;
                  }),
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        });
  }

  void _showSortOrderPickerDialog() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 16),
                Text(
                  S.of(context).billsDialogSortTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                ...BillSort.values.map((BillSort value) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        leading: value.direction == "ascending"
                            ? const Icon(Icons.north_east)
                            : const Icon(Icons.south_east),
                        title: Text(
                          S.of(context).billsSortType(value.type),
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        subtitle: Text(
                          S.of(context).billsSortDirection(value.direction),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                        trailing: sortOrder == value
                            ? const Icon(Icons.check)
                            : const SizedBox.shrink(),
                        onTap: () => setState(() {
                          Navigator.pop(context);
                          sortOrder = value;
                        }),
                      ),
                      const Divider(indent: 55, endIndent: 20),
                    ],
                  );
                }),
                const SizedBox(height: 24),
              ],
            ),
          );
        });
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
