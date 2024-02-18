import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'package:chopper/chopper.dart' show Response;
import 'package:syncfusion_flutter_charts/charts.dart' show SortingOrder;

import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/pages/bills/billdetails.dart';
import 'package:waterflyiii/settings.dart';
import 'package:waterflyiii/timezonehandler.dart';
import 'package:waterflyiii/pages/navigation.dart';

class BillsPage extends StatefulWidget {
  const BillsPage({super.key});

  @override
  State<BillsPage> createState() => _BillsPageState();
}

enum BillsLayout {
  grouped,
  list,
}

enum BillsSort {
  name,
  frequency,
}

class _BillsPageState extends State<BillsPage>
    with SingleTickerProviderStateMixin {
  final Logger log = Logger("Pages.Bills");
  late SettingsProvider _settings;
  late TimeZoneHandler _tzHandler;

  BillsLayout get _billsLayout => _settings.billsLayout;
  set _billsLayout(BillsLayout value) {
    _settings.setBillsLayout(value);
  }

  BillsSort get _billsSort => _settings.billsSort;
  set _billsSort(BillsSort value) {
    _settings.setBillsSort(value);
  }

  SortingOrder get _billsSortOrder => _settings.billsSortOrder;
  set _billsSortOrder(SortingOrder value) {
    _settings.setBillsSortOrder(value);
  }

  @override
  void initState() {
    super.initState();

    _settings = context.read<SettingsProvider>();
    _tzHandler = context.read<FireflyService>().tzHandler;
  }

  @override
  Widget build(BuildContext context) {
    log.finest(() => "build()");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NavPageElements>().appBarActions = <Widget>[
        if (_billsLayout == BillsLayout.list)
          IconButton(
            icon: const Icon(Icons.sort),
            tooltip: S.of(context).billsChangeSortOrderTooltip,
            onPressed: _showSortOrderPickerDialog,
          ),
        IconButton(
          icon: _billsLayout == BillsLayout.list
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
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: _billsLayout == BillsLayout.list
                ? _listBuilder(snapshot.data!)
                : _groupBuilder(snapshot.data!),
          );
        },
      ),
    );
  }

  Widget _listBuilder(Map<String, List<BillRead>> groupedBills) {
    List<BillRead> billList =
        groupedBills.values.expand((List<BillRead> x) => x).toList();

    switch (_billsSort) {
      case BillsSort.name:
        billList.sort((BillRead a, BillRead b) =>
            _billsSortOrder == SortingOrder.ascending
                ? a.attributes.name.compareTo(b.attributes.name)
                : b.attributes.name.compareTo(a.attributes.name));
      case BillsSort.frequency:
        billList.sort((BillRead a, BillRead b) =>
            _billsSortOrder == SortingOrder.ascending
                ? Enum.compareByIndex(
                    a.attributes.repeatFreq, b.attributes.repeatFreq)
                : Enum.compareByIndex(
                    b.attributes.repeatFreq, a.attributes.repeatFreq));
    }

    return ListView.builder(
      itemCount: billList.length,
      itemBuilder: (BuildContext _, int i) => _billRowBuilder(billList[i]),
    );
  }

  Widget _groupBuilder(Map<String, List<BillRead>> groupedBills) {
    return ListView(
      cacheExtent: 1000,
      children: <Widget>[
        ...groupedBills.keys.map((String groupName) => Card(
              clipBehavior: Clip.hardEdge,
              child: ExpansionTile(
                title: Text(
                  groupName,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
                initiallyExpanded: true,
                collapsedShape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    child: Column(
                      children: groupedBills[groupName]!
                          .map((BillRead bill) => _billRowBuilder(bill))
                          .toList(),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  Widget _billRowBuilder(BillRead bill) {
    return OpenContainer(
      openBuilder: (BuildContext context, Function closedContainer) =>
          BillDetails(bill: bill),
      openColor: _billsLayout == BillsLayout.list
          ? Theme.of(context).cardColor
          : Theme.of(context).colorScheme.surfaceVariant,
      closedColor: _billsLayout == BillsLayout.list
          ? Theme.of(context).cardColor
          : Theme.of(context).colorScheme.surfaceVariant,
      closedShape: RoundedRectangleBorder(
        borderRadius: _billsLayout == BillsLayout.list
            ? const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              )
            : const BorderRadius.all(Radius.circular(12)),
      ),
      closedElevation: 0,
      closedBuilder: (BuildContext context, Function openContainer) => ListTile(
        leading: const CircleAvatar(child: Icon(Icons.receipt_outlined)),
        title: Text(
          bill.attributes.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        titleTextStyle: ListTileTheme.of(context).titleTextStyle ??
            Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: bill.attributes.active ?? false
                      ? Theme.of(context).colorScheme.onSurface
                      : Theme.of(context).disabledColor,
                ),
        subtitle: Text(
          S.of(context).billsFrequencySkip(
              bill.attributes.repeatFreq.toString(), bill.attributes.skip ?? 0),
          maxLines: 2,
        ),
        subtitleTextStyle: ListTileTheme.of(context).subtitleTextStyle ??
            Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: bill.attributes.active ?? false
                      ? Theme.of(context).colorScheme.onSurface
                      : Theme.of(context).disabledColor,
                ),
        shape: RoundedRectangleBorder(
          borderRadius: _billsLayout == BillsLayout.list
              ? const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                )
              : const BorderRadius.all(Radius.circular(12)),
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
    // Bill is inactive
    if (!(item.attributes.active ?? false)) {
      return TextSpan(
        text: S.of(context).billsInactive,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).disabledColor,
            ),
      );
    }
    // Bill was paid this period
    if (item.attributes.paidDates?.isNotEmpty ?? false) {
      return TextSpan(
        text: S.of(context).billsPaidOn(
              _tzHandler.sTime(item.attributes.paidDates!.last.date!).toLocal(),
            ),
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      );
    }
    // Bill expected this period
    if (item.attributes.nextExpectedMatch != null) {
      return TextSpan(
        text: S.of(context).billsExpectedOn(
              _tzHandler.sTime(item.attributes.nextExpectedMatch!).toLocal(),
            ),
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.orangeAccent,
            ),
      );
    }

    // Bill not expected this period
    return TextSpan(
      text: S.of(context).billsNotExpected,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Colors.orangeAccent,
          ),
    );
  }

  void _showLayoutPickerDialog() => showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) => SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              const SizedBox(height: 16),
              ListTile(
                leading: _billsLayout == BillsLayout.grouped
                    ? const Icon(Icons.view_agenda)
                    : const Icon(Icons.view_agenda_outlined),
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
                trailing: _billsLayout == BillsLayout.grouped
                    ? const Icon(Icons.check)
                    : const SizedBox.shrink(),
                onTap: () => setState(() {
                  _billsLayout = BillsLayout.grouped;
                  Navigator.pop(context);
                }),
              ),
              const Divider(indent: 16, endIndent: 16),
              ListTile(
                leading: _billsLayout == BillsLayout.list
                    ? const Icon(Icons.table_rows)
                    : const Icon(Icons.table_rows_outlined),
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
                trailing: _billsLayout == BillsLayout.list
                    ? const Icon(Icons.check)
                    : const SizedBox.shrink(),
                onTap: () => setState(() {
                  _billsLayout = BillsLayout.list;
                  _billsSort = BillsSort.name;
                  _billsSortOrder = SortingOrder.ascending;
                  Navigator.pop(context);
                }),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      );

  void _showSortOrderPickerDialog() => showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.sort),
                title: Text(
                  S.of(context).billsSortName,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                subtitle: Text(
                  S.of(context).billsSortAlphabetical,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
                trailing: _billsSort == BillsSort.name
                    ? _billsSortOrder == SortingOrder.ascending
                        ? const Icon(Icons.north)
                        : const Icon(Icons.south)
                    : const SizedBox.shrink(),
                onTap: () => _onSortSelected(BillsSort.name),
              ),
              const Divider(indent: 16, endIndent: 16),
              ListTile(
                leading: const Icon(Icons.sort),
                title: Text(
                  S.of(context).billsSortFrequency,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                subtitle: Text(
                  S.of(context).billsSortByTimePeriod,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
                trailing: _billsSort == BillsSort.frequency
                    ? _billsSortOrder == SortingOrder.ascending
                        ? const Icon(Icons.north)
                        : const Icon(Icons.south)
                    : const SizedBox.shrink(),
                onTap: () => _onSortSelected(BillsSort.frequency),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      });

  void _onSortSelected(BillsSort newSort) {
    setState(() {
      if (_billsSort == newSort) {
        _billsSortOrder = _billsSortOrder == SortingOrder.ascending
            ? SortingOrder.descending
            : SortingOrder.ascending;
      } else {
        _billsSort = newSort;
        _billsSortOrder = SortingOrder.ascending;
      }
    });
    Navigator.pop(context);
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
      apiThrowErrorIfEmpty(response, mounted ? context : null);

      bills.addAll(response.body!.data);
    } while ((response.body!.meta.pagination?.currentPage ?? 1) <
        (response.body!.meta.pagination?.totalPages ?? 1));

    bills.sort((BillRead a, BillRead b) => (a.attributes.objectGroupOrder ?? 0)
        .compareTo(b.attributes.objectGroupOrder ?? 0));
    Map<String, List<BillRead>> billsMap = <String, List<BillRead>>{};

    for (BillRead bill in bills) {
      String key = bill.attributes.objectGroupTitle ??
          (mounted ? S.of(context).billsUngrouped : "");
      if (!billsMap.containsKey(key)) {
        billsMap[key] = <BillRead>[];
      }

      billsMap[key]!.add(bill);
    }

    return billsMap;
  }
}
