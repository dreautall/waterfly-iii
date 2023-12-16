import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:chopper/chopper.dart' show Response;
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/widgets/charts.dart';

class NetEarningsChart extends StatelessWidget {
  const NetEarningsChart({
    super.key,
    required this.expenses,
    required this.income,
  });

  final Map<DateTime, InsightTotalEntry> expenses;
  final Map<DateTime, InsightTotalEntry> income;

  @override
  Widget build(BuildContext context) {
    List<LabelAmountChart> incomeChartData = <LabelAmountChart>[];
    List<LabelAmountChart> expenseChartData = <LabelAmountChart>[];

    income.forEach((DateTime key, InsightTotalEntry value) {
      incomeChartData.add(
        LabelAmountChart(
          DateFormat(DateFormat.YEAR_MONTH).format(key),
          value.differenceFloat ?? 0,
        ),
      );
    });
    expenses.forEach((DateTime key, InsightTotalEntry value) {
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
        animationDuration: animDurationEmphasized,
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
        defaultInteractions: false,
      ),
    );
  }
}

class NetEarningsChartPopup extends StatefulWidget {
  const NetEarningsChartPopup({
    super.key,
  });

  @override
  State<NetEarningsChartPopup> createState() => _NetEarningsChartPopupState();
}

class _NetEarningsChartPopupState extends State<NetEarningsChartPopup> {
  int monthOffset = 0;

  Future<Map<String, double>> _fetchData(BuildContext context) async {
    final FireflyIii api = context.read<FireflyService>().api;

    final Map<String, double> chartData = <String, double>{};

    DateTime now = DateTime.now()
        .toLocal()
        .setTimeOfDay(const TimeOfDay(hour: 12, minute: 0));
    if (monthOffset != 0) {
      now = now.copyWith(month: now.month - monthOffset);
    }

    final Response<InsightGroup> respCatIncomeData =
        await api.v1InsightIncomeCategoryGet(
      start: DateFormat('yyyy-MM-dd', 'en_US').format(now.copyWith(day: 1)),
      end: DateFormat('yyyy-MM-dd', 'en_US')
          .format(now.copyWith(day: 0, month: now.month + 1)),
    );
    final Response<InsightGroup> respCatExpenseData =
        await api.v1InsightExpenseCategoryGet(
      start: DateFormat('yyyy-MM-dd', 'en_US').format(now.copyWith(day: 1)),
      end: DateFormat('yyyy-MM-dd', 'en_US')
          .format(now.copyWith(day: 0, month: now.month + 1)),
    );

    if (!respCatExpenseData.isSuccessful || respCatExpenseData.body == null) {
      if (context.mounted) {
        throw Exception(
          S.of(context).errorAPIInvalidResponse(
              respCatExpenseData.error?.toString() ?? ""),
        );
      } else {
        throw Exception(
          "[nocontext] Invalid API response: ${respCatExpenseData.error}",
        );
      }
    }

    for (InsightGroupEntry cat in respCatIncomeData.body!) {
      if ((cat.name?.isEmpty ?? true) || cat.differenceFloat == 0) {
        continue;
      }
      chartData[cat.name!] = cat.differenceFloat!;
    }
    for (InsightGroupEntry cat in respCatExpenseData.body!) {
      if ((cat.name?.isEmpty ?? true) || cat.differenceFloat == 0) {
        continue;
      }
      double income = chartData.remove(cat.name) ?? 0;
      chartData[cat.name!] = cat.differenceFloat! + income;
    }

    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now()
        .toLocal()
        .setTimeOfDay(const TimeOfDay(hour: 12, minute: 0));
    final DateTime currentMonth = now.copyWith(month: now.month - monthOffset);

    return SimpleDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(DateFormat.yMMMM().format(currentMonth)),
          Row(
            children: <Widget>[
              IconButton(
                onPressed: () => setState(() {
                  monthOffset++;
                }),
                icon: const Icon(Icons.arrow_back),
              ),
              IconButton(
                onPressed: monthOffset == 0
                    ? null
                    : () => setState(() {
                          if (monthOffset != 0) {
                            monthOffset--;
                          }
                        }),
                icon: const Icon(Icons.arrow_forward),
              ),
            ],
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      insetPadding: const EdgeInsets.all(12),
      children: <Widget>[
        FutureBuilder<Map<String, double>>(
          future: _fetchData(context),
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, double>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              final List<WFChartData> chartData = <WFChartData>[];

              double min = 0;
              double max = 0;
              double currentSum = 0;

              for (MapEntry<String, double> e in snapshot.data!.entries.toList()
                ..sort(
                  (MapEntry<String, double> a, MapEntry<String, double> b) =>
                      b.value.compareTo(a.value),
                )) {
                if (e.value != 0) {
                  chartData.add(WFChartData(e.key, e.value));
                  currentSum += e.value;
                  if (currentSum < 0 && currentSum < min) {
                    min = currentSum;
                  }
                  if (currentSum > 0 && currentSum > max) {
                    max = currentSum;
                  }
                }
              }

              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: SizedBox(
                      height: 400,
                      width: MediaQuery.of(context).size.width,
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(
                          labelRotation: 90,
                          labelStyle:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                          axisLine: AxisLine(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          interval: 1,
                        ),
                        primaryYAxis: NumericAxis(
                          labelStyle:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                          axisLine: AxisLine(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant),
                          axisLabelFormatter: (AxisLabelRenderDetails args) =>
                              ChartAxisLabel(
                                  NumberFormat()
                                      .format(double.parse(args.text)),
                                  args.textStyle),
                          minimum: min,
                          maximum: max,
                          decimalPlaces: 0,
                        ),
                        series: <ChartSeries<WFChartData, String>>[
                          WaterfallSeries<WFChartData, String>(
                            dataSource: chartData,
                            negativePointsColor: Colors.red,
                            intermediateSumColor: Colors.orange,
                            totalSumColor: Colors.black,
                            color: Colors.green,
                            xValueMapper: (WFChartData data, _) => data.label,
                            yValueMapper: (WFChartData data, _) => data.value,
                            intermediateSumPredicate: (WFChartData data, _) =>
                                data.isIntermediate,
                            totalSumPredicate: (WFChartData data, _) =>
                                data.isTotal,
                            width: 0.95,
                            dataLabelMapper: (WFChartData data, _) =>
                                data.value!.abs().toStringAsFixed(0),
                            dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                              angle: 90,
                              alignment: ChartAlignment.center,
                              labelAlignment: ChartDataLabelAlignment.outer,
                              labelPosition: ChartDataLabelPosition.outside,
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                        ],
                        enableAxisAnimation: true,
                        palette: possibleChartColorsDart,
                        tooltipBehavior: TooltipBehavior(
                          enable: false,
                        ),
                        crosshairBehavior: CrosshairBehavior(enable: false),
                        zoomPanBehavior: ZoomPanBehavior(
                          enablePanning: true,
                          enablePinching: true,
                          zoomMode: ZoomMode.x,
                          enableDoubleTapZooming: true,
                        ),
                      ),
                    ),
                  ),
                  /*Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                    child: ValueListenableBuilder<DateTime?>(
                      valueListenable: date,
                      builder: (BuildContext context, DateTime? value,
                              Widget? child) =>
                          Placeholder(),
                      SummaryTable(
                        accounts: accounts,
                        balances: balances,
                        currencies: currencies,
                        date: value!,
                      ),
                    ),
                  ),*/
                ],
              );
            } else if (snapshot.hasError) {
              log.severe("error getting chart card data", snapshot.error,
                  snapshot.stackTrace);
              Navigator.of(context).pop();
              return const SizedBox.shrink();
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
      ],
    );
  }
}
