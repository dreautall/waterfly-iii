import 'dart:async';
import 'dart:ui';

import 'package:chopper/chopper.dart' show Response;
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/widgets/animatedheightcard.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';

import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain>
    with AutomaticKeepAliveClientMixin {
  final Map<DateTime, InsightTotalEntry> lastDaysExpense =
      <DateTime, InsightTotalEntry>{};
  final Map<DateTime, InsightTotalEntry> lastDaysIncome =
      <DateTime, InsightTotalEntry>{};
  final Map<DateTime, InsightTotalEntry> lastMonthsExpense =
      <DateTime, InsightTotalEntry>{};
  final Map<DateTime, InsightTotalEntry> lastMonthsIncome =
      <DateTime, InsightTotalEntry>{};
  List<ChartDataSet> overviewChartData = <ChartDataSet>[];
  final Map<String, Category> catChartData = <String, Category>{};
  final Map<String, Budget> budgetInfos = <String, Budget>{};

  final List<charts.Color> possibleChartColors = <charts.Color>[
    charts.MaterialPalette.blue.shadeDefault,
    charts.MaterialPalette.deepOrange.shadeDefault,
    charts.MaterialPalette.purple.shadeDefault,
    charts.MaterialPalette.teal.shadeDefault,
    charts.MaterialPalette.lime.shadeDefault,
    charts.MaterialPalette.cyan.shadeDefault,
  ];

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _fetchLastDays() async {
    final FireflyIii? api = FireflyProvider.of(context).api;
    if (api == null) {
      throw Exception("API unavailable");
    }

    final DateTime now = DateTime.now().toLocal().clearTime();
    final List<DateTime> lastDays = <DateTime>[];
    for (int i = 0; i < 7; i++) {
      lastDays.add(now.subtract(Duration(days: i)));
    }

    lastDaysExpense.clear();
    lastDaysIncome.clear();
    for (DateTime e in lastDays) {
      final Response<InsightTotal> respInsightExpense =
          await api.v1InsightExpenseTotalGet(
        start: DateFormat('yyyy-MM-dd').format(e),
        end: DateFormat('yyyy-MM-dd').format(e),
      );
      if (!respInsightExpense.isSuccessful || respInsightExpense.body == null) {
        throw Exception("Invalid Response from API");
      }
      lastDaysExpense[e] = respInsightExpense.body!.isNotEmpty
          ? respInsightExpense.body!.first
          : InsightTotalEntry(differenceFloat: 0);
      final Response<InsightTotal> respInsightIncome =
          await api.v1InsightIncomeTotalGet(
        start: DateFormat('yyyy-MM-dd').format(e),
        end: DateFormat('yyyy-MM-dd').format(e),
      );
      if (!respInsightIncome.isSuccessful || respInsightIncome.body == null) {
        throw Exception("Invalid Response from API");
      }
      lastDaysIncome[e] = respInsightIncome.body!.isNotEmpty
          ? respInsightIncome.body!.first
          : InsightTotalEntry(differenceFloat: 0);
    }

    return true;
  }

  Future<bool> _fetchOverviewChart() async {
    final FireflyIii? api = FireflyProvider.of(context).api;
    if (api == null) {
      throw Exception("API unavailable");
    }

    final DateTime now = DateTime.now().toLocal().clearTime();

    final Response<ChartLine> respChartData =
        await api.v1ChartAccountOverviewGet(
      start:
          DateFormat('yyyy-MM-dd').format(now.copyWith(month: now.month - 12)),
      end: DateFormat('yyyy-MM-dd').format(now),
    );
    if (!respChartData.isSuccessful ||
        respChartData.body == null ||
        respChartData.body!.isEmpty) {
      throw Exception("Invalid Response from API");
    }
    overviewChartData = respChartData.body!;

    return true;
  }

  Future<bool> _fetchLastMonths() async {
    final FireflyIii? api = FireflyProvider.of(context).api;
    if (api == null) {
      throw Exception("API unavailable");
    }

    final DateTime now = DateTime.now().toLocal().clearTime();
    final List<DateTime> lastMonths = <DateTime>[];
    for (int i = 0; i < 3; i++) {
      lastMonths.add(DateTime(now.year, now.month - i, (i == 0) ? now.day : 1));
    }

    lastMonthsExpense.clear();
    lastMonthsIncome.clear();
    for (DateTime e in lastMonths) {
      late DateTime start;
      late DateTime end;
      if (e == lastMonths.first) {
        start = e.copyWith(day: 1);
        end = e;
      } else {
        start = e;
        end = e.copyWith(month: e.month + 1, day: 0);
      }
      final Response<InsightTotal> respInsightExpense =
          await api.v1InsightExpenseTotalGet(
        start: DateFormat('yyyy-MM-dd').format(start),
        end: DateFormat('yyyy-MM-dd').format(end),
      );
      if (!respInsightExpense.isSuccessful || respInsightExpense.body == null) {
        throw Exception("Invalid Response from API");
      }
      lastMonthsExpense[e] = respInsightExpense.body!.isNotEmpty
          ? respInsightExpense.body!.first
          : InsightTotalEntry(differenceFloat: 0);
      final Response<InsightTotal> respInsightIncome =
          await api.v1InsightIncomeTotalGet(
        start: DateFormat('yyyy-MM-dd').format(start),
        end: DateFormat('yyyy-MM-dd').format(end),
      );
      if (!respInsightIncome.isSuccessful || respInsightIncome.body == null) {
        throw Exception("Invalid Response from API");
      }
      lastMonthsIncome[e] = respInsightIncome.body!.isNotEmpty
          ? respInsightIncome.body!.first
          : InsightTotalEntry(differenceFloat: 0);
    }

    return true;
  }

  Future<bool> _fetchCategories() async {
    final FireflyIii? api = FireflyProvider.of(context).api;
    if (api == null) {
      throw Exception("API unavailable");
    }

    final DateTime now = DateTime.now().toLocal().clearTime();

    final Response<CategoryArray> respCatData = await api.v1CategoriesGet();
    if (!respCatData.isSuccessful || respCatData.body == null) {
      throw Exception("Invalid Response from API");
    }

    for (CategoryRead e in respCatData.body!.data) {
      final Response<CategorySingle> respCat = await api.v1CategoriesIdGet(
        id: e.id,
        start: DateFormat('yyyy-MM-dd').format(now.copyWith(day: 1)),
        end: DateFormat('yyyy-MM-dd').format(now),
      );

      if (!respCat.isSuccessful || respCat.body == null) {
        continue;
      }

      catChartData[respCat.body!.data.id] = respCat.body!.data.attributes;
    }

    return true;
  }

  Future<List<BudgetLimitRead>> _fetchBudgets() async {
    final FireflyIii? api = FireflyProvider.of(context).api;
    if (api == null) {
      throw Exception("API unavailable");
    }

    final Response<BudgetArray> respBudgetInfos = await api.v1BudgetsGet();
    if (!respBudgetInfos.isSuccessful || respBudgetInfos.body == null) {
      throw Exception("Invalid Response from API");
    }

    for (BudgetRead budget in respBudgetInfos.body!.data) {
      budgetInfos[budget.id] = budget.attributes;
    }

    final DateTime now = DateTime.now().toLocal().clearTime();
    final Response<BudgetLimitArray> respBudgets = await api.v1BudgetLimitsGet(
      start: DateFormat('yyyy-MM-dd').format(now.copyWith(day: 1)),
      end: DateFormat('yyyy-MM-dd').format(now),
    );

    if (!respBudgets.isSuccessful || respBudgets.body == null) {
      throw Exception("Invalid Response from API");
    }

    respBudgets.body!.data.sort((BudgetLimitRead a, BudgetLimitRead b) {
      Budget? budgetA = budgetInfos[a.attributes.budgetId];
      Budget? budgetB = budgetInfos[b.attributes.budgetId];

      if (budgetA == null && budgetB != null) {
        return -1;
      } else if (budgetA != null && budgetB == null) {
        return 1;
      } else if (budgetA == null && budgetB == null) {
        return 0;
      }
      int compare = (budgetA!.order ?? -1).compareTo(budgetB!.order ?? -1);
      if (compare != 0) {
        return compare;
      }
      return a.attributes.start.compareTo(b.attributes.start);
    });

    return respBudgets.body!.data;
  }

  Future<void> _refreshStats() async {
    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    debugPrint("home_main build()");

    CurrencyRead defaultCurrency = FireflyProvider.of(context).defaultCurrency;

    return RefreshIndicator(
      onRefresh: _refreshStats,
      child: ListView(
        cacheExtent: 1000,
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          ChartCard(
            title: S.of(context).homeMainChartDailyTitle,
            future: _fetchLastDays(),
            summary: () {
              double sevenDayTotal = 0;
              lastDaysExpense.forEach((DateTime _, InsightTotalEntry e) =>
                  sevenDayTotal -= (e.differenceFloat ?? 0).abs());
              lastDaysIncome.forEach((DateTime _, InsightTotalEntry e) =>
                  sevenDayTotal += (e.differenceFloat ?? 0).abs());
              return Text(S
                  .of(context)
                  //.homeMainChartDailyAvg(sevenDayTotal / 7),
                  .homeMainChartDailyAvg(
                    defaultCurrency.fmtCurrency(
                      sevenDayTotal / 7,
                      locale: S.of(context).localeName,
                    ),
                  ));
            },
            height: 125,
            child: () => LastDaysChart(
              lastDaysExpense: lastDaysExpense,
              lastDaysIncome: lastDaysIncome,
            ),
          ),
          const SizedBox(height: 8),
          ChartCard(
            title: "Category Summary",
            future: _fetchCategories(),
            height: 175,
            child: () => CategoryChart(
              catChartData: catChartData,
              possibleChartColors: possibleChartColors,
            ),
          ),
          const SizedBox(height: 8),
          ChartCard(
            title: "Account Summary",
            future: _fetchOverviewChart(),
            summary: () => Table(
              //border: TableBorder.all(), // :DEBUG:
              columnWidths: const <int, TableColumnWidth>{
                0: FixedColumnWidth(24),
                1: FlexColumnWidth(),
                2: IntrinsicColumnWidth(),
              },
              children: <TableRow>[
                TableRow(
                  children: <Widget>[
                    const SizedBox.shrink(),
                    Text(
                      "Account",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Balance",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
                ...overviewChartData.mapIndexed((int i, ChartDataSet e) {
                  final Map<String, dynamic> entries =
                      e.entries! as Map<String, dynamic>;
                  final double balance =
                      (double.tryParse(entries.entries.last.value) ?? 0);
                  final String balanceString = balance.abs().toStringAsFixed(
                      defaultCurrency.attributes.decimalPlaces ?? 2);
                  return TableRow(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "⬤",
                          style: TextStyle(
                            color: charts.ColorUtil.toDartColor(
                                possibleChartColors[
                                    i % possibleChartColors.length]),
                            textBaseline: TextBaseline.ideographic,
                            height: 1.3,
                          ),
                        ),
                      ),
                      Text(e.label!),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "${(balance < 0) ? '-' : ''}${defaultCurrency.attributes.symbol}$balanceString",
                          style: TextStyle(
                            color: (balance < 0) ? Colors.red : Colors.green,
                            fontWeight: FontWeight.bold,
                            fontFeatures: const <FontFeature>[
                              FontFeature.tabularFigures()
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
            height: 175,
            child: () => SummaryChart(
              overviewChartData: overviewChartData,
              possibleChartColors: possibleChartColors,
            ),
          ),
          const SizedBox(height: 8),
          ChartCard(
            title: "Net Earnings",
            future: _fetchLastMonths(),
            summary: () => Table(
              // border: TableBorder.all(), // :DEBUG:
              columnWidths: const <int, TableColumnWidth>{
                0: FixedColumnWidth(24),
                1: IntrinsicColumnWidth(),
                2: FlexColumnWidth(),
                3: FlexColumnWidth(),
                4: FlexColumnWidth(),
              },
              children: <TableRow>[
                TableRow(
                  children: <Widget>[
                    const SizedBox.shrink(),
                    const SizedBox.shrink(),
                    ...lastMonthsIncome.keys.toList().reversed.map(
                          (DateTime e) => Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              DateFormat(DateFormat.ABBR_MONTH).format(e),
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                        ),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "⬤",
                        style: TextStyle(
                          color: Colors.green,
                          textBaseline: TextBaseline.ideographic,
                          height: 1.3,
                        ),
                      ),
                    ),
                    const Text("Income"),
                    ...lastMonthsIncome.entries.toList().reversed.map(
                          (MapEntry<DateTime, InsightTotalEntry> e) => Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "${defaultCurrency.attributes.symbol}${(e.value.differenceFloat ?? 0).toStringAsFixed(defaultCurrency.attributes.decimalPlaces ?? 2)}",
                              style: const TextStyle(
                                fontFeatures: <FontFeature>[
                                  FontFeature.tabularFigures()
                                ],
                              ),
                            ),
                          ),
                        ),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "⬤",
                        style: TextStyle(
                          color: Colors.red,
                          textBaseline: TextBaseline.ideographic,
                          height: 1.3,
                        ),
                      ),
                    ),
                    const Text("Expenses"),
                    ...lastMonthsExpense.entries.toList().reversed.map(
                          (MapEntry<DateTime, InsightTotalEntry> e) => Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "-${defaultCurrency.attributes.symbol}${(e.value.differenceFloat ?? 0).abs().toStringAsFixed(defaultCurrency.attributes.decimalPlaces ?? 2)}",
                              style: const TextStyle(
                                fontFeatures: <FontFeature>[
                                  FontFeature.tabularFigures()
                                ],
                              ),
                            ),
                          ),
                        ),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    const SizedBox.shrink(),
                    const Text(
                      "Sum",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    ...lastMonthsIncome.entries.toList().reversed.map(
                      (MapEntry<DateTime, InsightTotalEntry> e) {
                        final double income = e.value.differenceFloat ?? 0;
                        double expense = 0;
                        if (lastMonthsExpense.containsKey(e.key)) {
                          expense =
                              lastMonthsExpense[e.key]!.differenceFloat ?? 0;
                        }
                        double sum = income + expense;
                        return Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "${(sum < 0) ? '-' : ''}${defaultCurrency.attributes.symbol}${sum.abs().toStringAsFixed(defaultCurrency.attributes.decimalPlaces ?? 2)}",
                            style: TextStyle(
                              color: (sum < 0) ? Colors.red : Colors.green,
                              fontWeight: FontWeight.bold,
                              fontFeatures: const <FontFeature>[
                                FontFeature.tabularFigures()
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            child: () => NetEarningsChart(
              lastMonthsExpense: lastMonthsExpense,
              lastMonthsIncome: lastMonthsIncome,
            ),
          ),
          const SizedBox(height: 8),
          AnimatedHeightCard(
            child: Card(
              clipBehavior: Clip.hardEdge,
              child: FutureBuilder<List<BudgetLimitRead>>(
                future: _fetchBudgets(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<BudgetLimitRead>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            "Budgets for this month",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        BudgetList(
                          budgetInfos: budgetInfos,
                          snapshot: snapshot,
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
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
            ),
          ),
          const SizedBox(height: 68),
        ],
      ),
    );
  }
}

class BudgetList extends StatelessWidget {
  const BudgetList({
    super.key,
    required this.budgetInfos,
    required this.snapshot,
  });

  final Map<String, Budget> budgetInfos;
  final AsyncSnapshot<List<BudgetLimitRead>> snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final List<Widget> widgets = <Widget>[];
            for (BudgetLimitRead budget in snapshot.data!) {
              final double spent =
                  double.parse(budget.attributes.spent ?? "0").abs();
              final double available =
                  double.tryParse(budget.attributes.amount) ?? 0;
              Budget? budgetInfo = budgetInfos[budget.attributes.budgetId];
              if (budgetInfo == null || available == 0) {
                continue;
              }
              Color lineColor = Colors.green;
              Color? bgColor;
              double value = spent / available;
              if (spent > available) {
                lineColor = Colors.red;
                bgColor = Colors.green;
                value = value % 1;
              }

              if (widgets.isNotEmpty) {
                widgets.add(const SizedBox(height: 8));
              }
              widgets.add(
                RichText(
                  text: TextSpan(
                    children: <InlineSpan>[
                      TextSpan(
                        text: budgetInfo.name,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      TextSpan(
                        text:
                            " (${DateFormat(DateFormat.ABBR_MONTH_DAY).format(budget.attributes.start.toLocal())} to ${DateFormat(DateFormat.ABBR_MONTH_DAY).format(budget.attributes.end.toLocal())}, ${budget.attributes.period})",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              );
              widgets.add(Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "${(spent / available * 100).round()}%",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: lineColor),
                  ),
                  Text(
                    "${(available - spent).abs().round()}${budget.attributes.currencySymbol!} ${(spent > available) ? "over" : "left from"} ${available.round()}${budget.attributes.currencySymbol!}",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: lineColor),
                  ),
                ],
              ));
              widgets.add(LinearProgressIndicator(
                color: lineColor,
                backgroundColor: bgColor,
                value: value,
              ));
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widgets,
            );
          },
        ),
      ),
    );
  }
}

class ChartCard extends StatelessWidget {
  const ChartCard(
      {super.key,
      required this.title,
      required this.child,
      required this.future,
      this.height = 150,
      this.summary});

  final String title;
  final Widget Function() child;
  final Future<bool> future;
  final Widget Function()? summary;
  final double height;

  @override
  Widget build(BuildContext context) {
    List<Widget> summaryWidgets = <Widget>[];

    return AnimatedHeightCard(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: FutureBuilder<bool>(
          future: future,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              if (summary != null) {
                summaryWidgets.add(const Divider(indent: 16, endIndent: 16));
                summaryWidgets.add(
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                    child: summary!(),
                  ),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                    ),
                    child: SizedBox(
                      height: height,
                      child: child(),
                    ),
                  ),
                  ...summaryWidgets,
                ],
              );
            } else if (snapshot.hasError) {
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
      ),
    );
  }
}

class TimeSeriesChart {
  final DateTime time;
  final double value;

  TimeSeriesChart(this.time, this.value);
}

class SummaryChart extends StatelessWidget {
  const SummaryChart({
    super.key,
    required this.overviewChartData,
    required this.possibleChartColors,
  });

  final List<ChartDataSet> overviewChartData;
  final List<charts.Color> possibleChartColors;

  @override
  Widget build(BuildContext context) {
    final List<charts.Series<TimeSeriesChart, DateTime>> chartData =
        <charts.Series<TimeSeriesChart, DateTime>>[];
    final List<charts.TickSpec<DateTime>> ticks = <charts.TickSpec<DateTime>>[];

    for (ChartDataSet e in overviewChartData) {
      final List<TimeSeriesChart> data = <TimeSeriesChart>[];

      final Map<String, dynamic> entries = e.entries! as Map<String, dynamic>;
      DateTime? prevDate;
      entries.forEach((String key, dynamic value) {
        final DateTime date = DateTime.parse(key);
        if (prevDate != null && date.month != prevDate!.month) {
          ticks.add(
              charts.TickSpec<DateTime>(DateTime(date.year, date.month, 1)));
        }
        data.add(TimeSeriesChart(
          date,
          double.tryParse(value) ?? 0,
        ));
        prevDate = date;
      });

      chartData.add(
        charts.Series<TimeSeriesChart, DateTime>(
          id: e.label!,
          seriesColor: possibleChartColors[
              chartData.length % possibleChartColors.length],
          domainFn: (TimeSeriesChart summary, _) => summary.time,
          measureFn: (TimeSeriesChart summary, _) => summary.value,
          data: data,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: charts.TimeSeriesChart(
        chartData,
        animate: true,
        primaryMeasureAxis: charts.NumericAxisSpec(
          tickProviderSpec: const charts.BasicNumericTickProviderSpec(
            //desiredTickCount: 6,
            desiredMaxTickCount: 6,
            desiredMinTickCount: 4,
          ),
          renderSpec: charts.SmallTickRendererSpec<num>(
            labelStyle: charts.TextStyleSpec(
              color: charts.ColorUtil.fromDartColor(
                  Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ),
        ),
        domainAxis: charts.DateTimeAxisSpec(
          tickFormatterSpec:
              charts.BasicDateTimeTickFormatterSpec.fromDateFormat(
                  DateFormat(DateFormat.ABBR_STANDALONE_MONTH)),
          tickProviderSpec: charts.StaticDateTimeTickProviderSpec(ticks),
          renderSpec: charts.SmallTickRendererSpec<DateTime>(
            labelStyle: charts.TextStyleSpec(
              color: charts.ColorUtil.fromDartColor(
                  Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ),
        ),
      ),
    );
  }
}

class LabelAmountChart {
  final String label;
  final double amount;

  LabelAmountChart(this.label, this.amount);
}

class LastDaysChart extends StatelessWidget {
  const LastDaysChart({
    super.key,
    required this.lastDaysExpense,
    required this.lastDaysIncome,
  });

  final Map<DateTime, InsightTotalEntry> lastDaysExpense;
  final Map<DateTime, InsightTotalEntry> lastDaysIncome;

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now().toLocal().clearTime();
    final List<DateTime> lastDays = <DateTime>[];
    for (int i = 0; i < 7; i++) {
      lastDays.add(now.subtract(Duration(days: i)));
    }
    CurrencyRead defaultCurrency = FireflyProvider.of(context).defaultCurrency;

    final List<LabelAmountChart> chartData = <LabelAmountChart>[];

    for (DateTime e in lastDays.reversed) {
      if (!lastDaysExpense.containsKey(e) || !lastDaysIncome.containsKey(e)) {
        continue;
      }
      InsightTotalEntry expense = lastDaysExpense[e]!;
      InsightTotalEntry income = lastDaysIncome[e]!;

      double diff =
          (income.differenceFloat ?? 0) + (expense.differenceFloat ?? 0);

      chartData.add(
        LabelAmountChart(DateFormat(DateFormat.ABBR_WEEKDAY).format(e), diff),
      );
    }

    return charts.BarChart(
      <charts.Series<LabelAmountChart, String>>[
        charts.Series<LabelAmountChart, String>(
          id: 'LastDays',
          domainFn: (LabelAmountChart entry, _) => entry.label,
          measureFn: (LabelAmountChart entry, _) => entry.amount.abs(),
          data: chartData,
          colorFn: (LabelAmountChart entry, _) => (entry.amount > 0)
              ? charts.MaterialPalette.green.shadeDefault
              : charts.MaterialPalette.red.shadeDefault,
          labelAccessorFn: (LabelAmountChart entry, _) =>
              '${defaultCurrency.attributes.symbol}${entry.amount.abs().round().toString()}',
          outsideLabelStyleAccessorFn: (_, __) => charts.TextStyleSpec(
            color: charts.ColorUtil.fromDartColor(
                Theme.of(context).colorScheme.onSurfaceVariant),
          ),
        ),
      ],
      animate: true,
      barRendererDecorator: charts.BarLabelDecorator<String>(),
      primaryMeasureAxis: const charts.NumericAxisSpec(
        renderSpec: charts.NoneRenderSpec<num>(),
      ),
      domainAxis: charts.AxisSpec<String>(
        renderSpec: charts.SmallTickRendererSpec<String>(
          labelStyle: charts.TextStyleSpec(
            color: charts.ColorUtil.fromDartColor(
                Theme.of(context).colorScheme.onSurfaceVariant),
          ),
        ),
      ),
    );
  }
}

class NetEarningsChart extends StatelessWidget {
  const NetEarningsChart({
    super.key,
    required this.lastMonthsExpense,
    required this.lastMonthsIncome,
  });

  final Map<DateTime, InsightTotalEntry> lastMonthsExpense;
  final Map<DateTime, InsightTotalEntry> lastMonthsIncome;

  @override
  Widget build(BuildContext context) {
    List<LabelAmountChart> incomeChartData = <LabelAmountChart>[];
    List<LabelAmountChart> expenseChartData = <LabelAmountChart>[];

    lastMonthsIncome.forEach((DateTime key, InsightTotalEntry value) {
      incomeChartData.add(
        LabelAmountChart(
          DateFormat(DateFormat.YEAR_MONTH).format(key),
          value.differenceFloat ?? 0,
        ),
      );
    });
    lastMonthsExpense.forEach((DateTime key, InsightTotalEntry value) {
      expenseChartData.add(
        LabelAmountChart(
          DateFormat(DateFormat.YEAR_MONTH).format(key),
          value.differenceFloat ?? 0,
        ),
      );
    });
    incomeChartData = incomeChartData.reversed.toList();
    expenseChartData = expenseChartData.reversed.toList();

    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: charts.BarChart(
        <charts.Series<LabelAmountChart, String>>[
          charts.Series<LabelAmountChart, String>(
            id: 'Income',
            domainFn: (LabelAmountChart entry, _) => entry.label,
            measureFn: (LabelAmountChart entry, _) => entry.amount.abs(),
            data: incomeChartData,
            colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
          ),
          charts.Series<LabelAmountChart, String>(
            id: 'Expense',
            domainFn: (LabelAmountChart entry, _) => entry.label,
            measureFn: (LabelAmountChart entry, _) => entry.amount.abs(),
            data: expenseChartData,
            colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
          ),
        ],
        animate: true,
        primaryMeasureAxis: charts.NumericAxisSpec(
          tickProviderSpec:
              const charts.BasicNumericTickProviderSpec(desiredTickCount: 5),
          renderSpec: charts.SmallTickRendererSpec<num>(
            labelStyle: charts.TextStyleSpec(
              color: charts.ColorUtil.fromDartColor(
                  Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ),
        ),
        domainAxis: charts.AxisSpec<String>(
          renderSpec: charts.SmallTickRendererSpec<String>(
            labelStyle: charts.TextStyleSpec(
              color: charts.ColorUtil.fromDartColor(
                  Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryChart extends StatelessWidget {
  const CategoryChart({
    super.key,
    required this.catChartData,
    required this.possibleChartColors,
  });

  final Map<String, Category> catChartData;
  final List<charts.Color> possibleChartColors;

  @override
  Widget build(BuildContext context) {
    List<LabelAmountChart> data = <LabelAmountChart>[];
    CurrencyRead defaultCurrency = FireflyProvider.of(context).defaultCurrency;

    catChartData.forEach((_, Category e) {
      double sum = 0;
      if (e.spent == null) {
        return;
      }
      for (CategorySpent f in e.spent!) {
        sum += double.tryParse(f.sum ?? "") ?? 0;
      }
      if (sum == 0) {
        return;
      }
      data.add(
        LabelAmountChart(
          e.name,
          sum,
        ),
      );
    });

    data.sort((LabelAmountChart a, LabelAmountChart b) =>
        a.amount.compareTo(b.amount));

    if (data.length > 5) {
      LabelAmountChart otherData = data.skip(5).reduce(
          (LabelAmountChart v, LabelAmountChart e) =>
              LabelAmountChart("Other", v.amount + e.amount));
      data = data.take(5).toList();

      if (otherData.amount != 0) {
        data.add(otherData);
      }
    }

    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: charts.PieChart<String>(
        <charts.Series<LabelAmountChart, String>>[
          charts.Series<LabelAmountChart, String>(
            id: 'Categories',
            domainFn: (LabelAmountChart entry, _) => entry.label,
            measureFn: (LabelAmountChart entry, _) => entry.amount.abs(),
            data: data,
            labelAccessorFn: (LabelAmountChart entry, _) =>
                "${entry.amount.abs().round()}",
            colorFn: (_, int? i) => possibleChartColors[i ?? 5],
          ),
        ],
        animate: true,
        defaultRenderer: charts.ArcRendererConfig<String>(
          arcRendererDecorators: <charts.ArcLabelDecorator<String>>[
            charts.ArcLabelDecorator<String>(
              insideLabelStyleSpec: charts.TextStyleSpec(
                fontSize:
                    Theme.of(context).textTheme.labelSmall!.fontSize!.round(),
              ),
              outsideLabelStyleSpec: charts.TextStyleSpec(
                fontSize: 12,
                color: charts.ColorUtil.fromDartColor(
                    Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            )
          ],
        ),
        behaviors: <charts.ChartBehavior<String>>[
          charts.DatumLegend<String>(
            position: charts.BehaviorPosition.end,
            horizontalFirst: false,
            cellPadding: const EdgeInsets.only(right: 4, bottom: 4),
            showMeasures: false, // Not formattable :(
            legendDefaultMeasure: charts.LegendDefaultMeasure.firstValue,
            desiredMaxRows: 6,
            measureFormatter: (num? value) {
              return value == null
                  ? '-'
                  : '${defaultCurrency.attributes.symbol}${value.toStringAsFixed(defaultCurrency.attributes.decimalPlaces ?? 2)}';
            },
            entryTextStyle: charts.TextStyleSpec(
              fontSize:
                  Theme.of(context).textTheme.labelMedium!.fontSize!.round(),
            ),
          ),
        ],
      ),
    );
  }
}
