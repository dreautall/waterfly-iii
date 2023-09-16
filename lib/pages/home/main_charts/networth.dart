import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/widgets/charts.dart';

class NetWorthChart extends StatelessWidget {
  const NetWorthChart({
    super.key,
    required this.earned,
    required this.spent,
    required this.balance,
  });

  final Map<DateTime, double> earned;
  final Map<DateTime, double> spent;
  final Map<DateTime, double> balance;

  @override
  Widget build(BuildContext context) {
    final List<LabelAmountChart> chartDataEarned = <LabelAmountChart>[];
    final List<LabelAmountChart> chartDataSpent = <LabelAmountChart>[];
    final List<LabelAmountChart> chartDataBalance = <LabelAmountChart>[];
    final List<ChartSeries<LabelAmountChart, String>> chartData =
        <ChartSeries<LabelAmountChart, String>>[];

    earned.forEach((DateTime d, double v) => chartDataEarned
        .add(LabelAmountChart(DateFormat(DateFormat.ABBR_MONTH).format(d), v)));
    spent.forEach((DateTime d, double v) => chartDataSpent
        .add(LabelAmountChart(DateFormat(DateFormat.ABBR_MONTH).format(d), v)));
    balance.forEach((DateTime d, double v) => chartDataBalance
        .add(LabelAmountChart(DateFormat(DateFormat.ABBR_MONTH).format(d), v)));

    debugPrint("${earned.entries.first.key}: ${earned.entries.first.value}");
    debugPrint("${spent.entries.first.key}: ${spent.entries.first.value}");
    debugPrint("${balance.entries.first.key}: ${balance.entries.first.value}");

    chartData.add(
      SplineSeries<LabelAmountChart, String>(
        dataSource: chartDataBalance,
        xValueMapper: (LabelAmountChart data, _) => data.label,
        yValueMapper: (LabelAmountChart data, _) => data.amount,
        legendItemText: "Balance",
        animationDuration: animDurationEmphasized.inMilliseconds.toDouble() * 2,
        color: Colors.blue,
        markerSettings: const MarkerSettings(
          isVisible: true,
        ),
      ),
    );

    chartData.add(
      ColumnSeries<LabelAmountChart, String>(
        dataSource: chartDataEarned,
        xValueMapper: (LabelAmountChart data, _) => data.label,
        yValueMapper: (LabelAmountChart data, _) => data.amount,
        legendItemText: "Earned",
        animationDuration: animDurationEmphasized.inMilliseconds.toDouble() * 2,
        color: Colors.green,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(2),
          topRight: Radius.circular(2),
        ),
      ),
    );
    chartData.add(
      ColumnSeries<LabelAmountChart, String>(
        dataSource: chartDataSpent,
        xValueMapper: (LabelAmountChart data, _) => data.label,
        yValueMapper: (LabelAmountChart data, _) => data.amount,
        legendItemText: "Spent",
        animationDuration: animDurationEmphasized.inMilliseconds.toDouble() * 2,
        color: Colors.red,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(2),
          bottomRight: Radius.circular(2),
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(
          labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.normal,
              ),
          axisLine:
              AxisLine(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
        primaryYAxis: NumericAxis(
          labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.normal,
              ),
          axisLine:
              AxisLine(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
        series: chartData,
        enableAxisAnimation: true,
        enableSideBySideSeriesPlacement: false,
      ),
    );
  }
}
