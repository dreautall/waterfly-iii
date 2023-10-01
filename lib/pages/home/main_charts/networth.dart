import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/widgets/charts.dart';

class NetWorthChart extends StatelessWidget {
  const NetWorthChart({
    super.key,
    required this.assets,
    required this.liabilities,
  });

  final Map<DateTime, double> assets;
  final Map<DateTime, double> liabilities;

  @override
  Widget build(BuildContext context) {
    final List<LabelAmountChart> chartDataAssets = <LabelAmountChart>[];
    final List<LabelAmountChart> chartDataLiabilities = <LabelAmountChart>[];
    final Map<String, double> balance = <String, double>{};
    final List<LabelAmountChart> chartDataBalance = <LabelAmountChart>[];
    final List<ChartSeries<LabelAmountChart, String>> chartData =
        <ChartSeries<LabelAmountChart, String>>[];

    assets.forEach((DateTime d, double v) {
      chartDataAssets.add(
          LabelAmountChart(DateFormat(DateFormat.ABBR_MONTH).format(d), v));
      balance[DateFormat(DateFormat.ABBR_MONTH).format(d)] = v;
    });
    liabilities.forEach((DateTime d, double v) {
      chartDataLiabilities.add(LabelAmountChart(
          DateFormat(DateFormat.ABBR_MONTH).format(d), v.abs()));
      balance[DateFormat(DateFormat.ABBR_MONTH).format(d)] =
          (balance[DateFormat(DateFormat.ABBR_MONTH).format(d)] ?? 0) + v;
    });
    balance.forEach(
        (String d, double v) => chartDataBalance.add(LabelAmountChart(d, v)));

    chartData.add(
      AreaSeries<LabelAmountChart, String>(
        dataSource: chartDataAssets,
        xValueMapper: (LabelAmountChart data, _) => data.label,
        yValueMapper: (LabelAmountChart data, _) => data.amount,
        animationDuration: animDurationEmphasized.inMilliseconds.toDouble() * 2,
        color: Colors.green,
        opacity: 0.4,
      ),
    );
    chartData.add(
      AreaSeries<LabelAmountChart, String>(
        dataSource: chartDataLiabilities,
        xValueMapper: (LabelAmountChart data, _) => data.label,
        yValueMapper: (LabelAmountChart data, _) => data.amount,
        animationDuration: animDurationEmphasized.inMilliseconds.toDouble() * 2,
        color: Colors.red,
        opacity: 0.4,
      ),
    );
    chartData.add(
      AreaSeries<LabelAmountChart, String>(
        dataSource: chartDataBalance,
        xValueMapper: (LabelAmountChart data, _) => data.label,
        yValueMapper: (LabelAmountChart data, _) => data.amount,
        animationDuration: animDurationEmphasized.inMilliseconds.toDouble() * 2,
        color: Colors.blue,
        opacity: 0.4,
      ),
    );

    chartData.add(
      LineSeries<LabelAmountChart, String>(
        dataSource: chartDataAssets,
        xValueMapper: (LabelAmountChart data, _) => data.label,
        yValueMapper: (LabelAmountChart data, _) => data.amount,
        animationDuration: animDurationEmphasized.inMilliseconds.toDouble() * 2,
        color: Colors.green,
        markerSettings: const MarkerSettings(
          isVisible: true,
          borderWidth: 0,
          color: Colors.green,
        ),
      ),
    );
    chartData.add(
      LineSeries<LabelAmountChart, String>(
        dataSource: chartDataLiabilities,
        xValueMapper: (LabelAmountChart data, _) => data.label,
        yValueMapper: (LabelAmountChart data, _) => data.amount,
        animationDuration: animDurationEmphasized.inMilliseconds.toDouble() * 2,
        color: Colors.red,
        markerSettings: const MarkerSettings(
          isVisible: true,
          borderWidth: 0,
          color: Colors.red,
        ),
      ),
    );
    chartData.add(
      LineSeries<LabelAmountChart, String>(
        dataSource: chartDataBalance,
        xValueMapper: (LabelAmountChart data, _) => data.label,
        yValueMapper: (LabelAmountChart data, _) => data.amount,
        animationDuration: animDurationEmphasized.inMilliseconds.toDouble() * 2,
        color: Colors.blue,
        markerSettings: const MarkerSettings(
          isVisible: true,
          borderWidth: 0,
          color: Colors.blue,
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
          axisLabelFormatter: (AxisLabelRenderDetails args) => ChartAxisLabel(
              NumberFormat().format(double.parse(args.text)), args.textStyle),
        ),
        series: chartData,
        enableAxisAnimation: true,
        enableSideBySideSeriesPlacement: false,
      ),
    );
  }
}
