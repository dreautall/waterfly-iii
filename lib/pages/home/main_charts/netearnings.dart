import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;

import 'package:waterflyiii/animations.dart';
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
