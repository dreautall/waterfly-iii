import 'dart:async';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'package:chopper/chopper.dart' show Response;
import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;

import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/pages/home/main_charts/category.dart';
import 'package:waterflyiii/pages/home/main_charts/lastdays.dart';
import 'package:waterflyiii/pages/home/main_charts/netearnings.dart';
import 'package:waterflyiii/pages/home/main_charts/summary.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain>
    with AutomaticKeepAliveClientMixin {
  final Logger log = Logger("Pages.Home.Main");

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
    final FireflyIii api = context.read<FireflyService>().api;

    // Use noon due to dailylight saving time
    final DateTime now = DateTime.now()
        .toLocal()
        .setTimeOfDay(const TimeOfDay(hour: 12, minute: 0));
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
        if (context.mounted) {
          throw Exception(
            S.of(context).errorAPIInvalidResponse(
                respInsightExpense.error?.toString() ?? ""),
          );
        } else {
          throw Exception(
            "[nocontext] Invalid API response: ${respInsightExpense.error}",
          );
        }
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
        if (context.mounted) {
          throw Exception(
            S.of(context).errorAPIInvalidResponse(
                respInsightIncome.error?.toString() ?? ""),
          );
        } else {
          throw Exception(
            "[nocontext] Invalid API response: ${respInsightIncome.error}",
          );
        }
      }
      lastDaysIncome[e] = respInsightIncome.body!.isNotEmpty
          ? respInsightIncome.body!.first
          : InsightTotalEntry(differenceFloat: 0);
    }

    return true;
  }

  Future<bool> _fetchOverviewChart() async {
    final FireflyIii api = context.read<FireflyService>().api;

    final DateTime now = DateTime.now().toLocal().clearTime();

    final Response<ChartLine> respChartData =
        await api.v1ChartAccountOverviewGet(
      start:
          DateFormat('yyyy-MM-dd').format(now.copyWith(month: now.month - 3)),
      end: DateFormat('yyyy-MM-dd').format(now),
    );
    if (!respChartData.isSuccessful ||
        respChartData.body == null ||
        respChartData.body!.isEmpty) {
      if (context.mounted) {
        throw Exception(
          S
              .of(context)
              .errorAPIInvalidResponse(respChartData.error?.toString() ?? ""),
        );
      } else {
        throw Exception(
          "[nocontext] Invalid API response: ${respChartData.error}",
        );
      }
    }
    overviewChartData = respChartData.body!;

    return true;
  }

  Future<bool> _fetchLastMonths() async {
    final FireflyIii api = context.read<FireflyService>().api;

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
        if (context.mounted) {
          throw Exception(
            S.of(context).errorAPIInvalidResponse(
                respInsightExpense.error?.toString() ?? ""),
          );
        } else {
          throw Exception(
            "[nocontext] Invalid API response: ${respInsightExpense.error}",
          );
        }
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
        if (context.mounted) {
          throw Exception(
            S.of(context).errorAPIInvalidResponse(
                respInsightIncome.error?.toString() ?? ""),
          );
        } else {
          throw Exception(
            "[nocontext] Invalid API response: ${respInsightIncome.error}",
          );
        }
      }
      lastMonthsIncome[e] = respInsightIncome.body!.isNotEmpty
          ? respInsightIncome.body!.first
          : InsightTotalEntry(differenceFloat: 0);
    }

    // If too big digits are present (>10000), only show two columns to avoid
    // wrapping issues. See #30.
    double maxNum = 0;
    lastMonthsIncome.forEach((_, InsightTotalEntry value) {
      if ((value.differenceFloat ?? 0) > maxNum) {
        maxNum = value.differenceFloat ?? 0;
      }
    });
    lastMonthsExpense.forEach((_, InsightTotalEntry value) {
      if ((value.differenceFloat ?? 0) > maxNum) {
        maxNum = value.differenceFloat ?? 0;
      }
    });
    if (maxNum > 10000) {
      lastMonthsIncome.remove(lastMonthsIncome.keys.first);
      lastMonthsExpense.remove(lastMonthsIncome.keys.first);
    }

    return true;
  }

  Future<bool> _fetchCategories() async {
    final FireflyIii api = context.read<FireflyService>().api;

    final DateTime now = DateTime.now().toLocal().clearTime();

    final Response<CategoryArray> respCatData = await api.v1CategoriesGet();
    if (!respCatData.isSuccessful || respCatData.body == null) {
      if (context.mounted) {
        throw Exception(
          S
              .of(context)
              .errorAPIInvalidResponse(respCatData.error?.toString() ?? ""),
        );
      } else {
        throw Exception(
          "[nocontext] Invalid API response: ${respCatData.error}",
        );
      }
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
    final FireflyIii api = context.read<FireflyService>().api;

    final Response<BudgetArray> respBudgetInfos = await api.v1BudgetsGet();
    if (!respBudgetInfos.isSuccessful || respBudgetInfos.body == null) {
      if (context.mounted) {
        throw Exception(
          S
              .of(context)
              .errorAPIInvalidResponse(respBudgetInfos.error?.toString() ?? ""),
        );
      } else {
        throw Exception(
          "[nocontext] Invalid API response: ${respBudgetInfos.error}",
        );
      }
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
      if (context.mounted) {
        throw Exception(
          S
              .of(context)
              .errorAPIInvalidResponse(respBudgets.error?.toString() ?? ""),
        );
      } else {
        throw Exception(
          "[nocontext] Invalid API response: ${respBudgets.error}",
        );
      }
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
    log.finest(() => "build()");

    CurrencyRead defaultCurrency =
        context.read<FireflyService>().defaultCurrency;

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
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(S.of(context).homeMainChartDailyAvg),
                  Text(
                    defaultCurrency.fmt(
                      sevenDayTotal / 7,
                      locale: S.of(context).localeName,
                    ),
                    style: TextStyle(
                      color: sevenDayTotal < 0 ? Colors.red : Colors.green,
                      fontWeight: FontWeight.bold,
                      fontFeatures: const <FontFeature>[
                        FontFeature.tabularFigures()
                      ],
                    ),
                  ),
                ],
              );
            },
            height: 125,
            child: () => LastDaysChart(
              lastDaysExpense: lastDaysExpense,
              lastDaysIncome: lastDaysIncome,
            ),
          ),
          const SizedBox(height: 8),
          ChartCard(
            title: S.of(context).homeMainChartCategoriesTitle,
            future: _fetchCategories(),
            height: 175,
            child: () => CategoryChart(
              catChartData: catChartData,
              possibleChartColors: possibleChartColors,
            ),
          ),
          const SizedBox(height: 8),
          ChartCard(
            title: S.of(context).homeMainChartAccountsTitle,
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
                      S.of(context).generalAccount,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        S.of(context).generalBalance,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
                ...overviewChartData.mapIndexed((int i, ChartDataSet e) {
                  final Map<String, dynamic> entries =
                      e.entries! as Map<String, dynamic>;
                  final double balance =
                      double.tryParse(entries.entries.last.value) ?? 0;
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
                          defaultCurrency.fmt(
                            balance,
                            locale: S.of(context).localeName,
                          ),
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
            title: S.of(context).homeMainChartNetearningsTitle,
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
                              DateFormat(
                                DateFormat.MONTH,
                                S.of(context).localeName,
                              ).format(e),
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
                    Text(S.of(context).generalIncome),
                    ...lastMonthsIncome.entries.toList().reversed.map(
                          (MapEntry<DateTime, InsightTotalEntry> e) => Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              defaultCurrency.fmt(
                                e.value.differenceFloat ?? 0,
                                locale: S.of(context).localeName,
                              ),
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
                    Text(S.of(context).generalExpenses),
                    ...lastMonthsExpense.entries.toList().reversed.map(
                          (MapEntry<DateTime, InsightTotalEntry> e) => Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              defaultCurrency.fmt(
                                e.value.differenceFloat ?? 0,
                                locale: S.of(context).localeName,
                              ),
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
                    Text(
                      S.of(context).generalSum,
                      style: const TextStyle(fontWeight: FontWeight.bold),
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
                            defaultCurrency.fmt(
                              sum,
                              locale: S.of(context).localeName,
                            ),
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
          AnimatedHeight(
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
                            S.of(context).homeMainBudgetTitle,
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
                  (double.tryParse(budget.attributes.spent ?? "0") ?? 0).abs();
              final double available =
                  double.tryParse(budget.attributes.amount) ?? 0;
              Budget? budgetInfo = budgetInfos[budget.attributes.budgetId];
              if (budgetInfo == null || available == 0) {
                continue;
              }
              final CurrencyRead currency = CurrencyRead(
                id: budget.attributes.currencyId ?? "0",
                type: "currencies",
                attributes: Currency(
                  code: budget.attributes.currencyCode ?? "",
                  name: budget.attributes.currencyName ?? "",
                  symbol: budget.attributes.currencySymbol ?? "",
                  decimalPlaces: budget.attributes.currencyDecimalPlaces,
                ),
              );
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
                        text: S.of(context).homeMainBudgetInterval(
                              budget.attributes.start.toLocal(),
                              budget.attributes.end.toLocal(),
                              budget.attributes.period ?? "",
                            ),
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
                    S.of(context).numPercent(spent / available),
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: lineColor),
                  ),
                  Text(
                    S.of(context).homeMainBudgetSum(
                          currency.fmt(
                            (available - spent).abs(),
                            decimalDigits: 0,
                            locale: S.of(context).localeName,
                          ),
                          (spent > available) ? "over" : "leftfrom",
                          currency.fmt(
                            available,
                            decimalDigits: 0,
                            locale: S.of(context).localeName,
                          ),
                        ),
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
  const ChartCard({
    super.key,
    required this.title,
    required this.child,
    required this.future,
    this.height = 150,
    this.summary,
  });

  final String title;
  final Widget Function() child;
  final Future<bool> future;
  final Widget Function()? summary;
  final double height;

  @override
  Widget build(BuildContext context) {
    List<Widget> summaryWidgets = <Widget>[];

    return AnimatedHeight(
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
