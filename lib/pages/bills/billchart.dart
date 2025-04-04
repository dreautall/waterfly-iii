import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.models.swagger.dart';
import 'package:waterflyiii/widgets/charts.dart';

class BillChart extends StatefulWidget {
  const BillChart({super.key, required this.billId});

  final String billId;

  @override
  State<BillChart> createState() => BillChartState();
}

class BillChartState extends State<BillChart> {
  final SplayTreeMap<DateTime, double> _values =
      SplayTreeMap<DateTime, double>();
  bool loaded = false;

  @override
  void dispose() {
    _values.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Loaded and more than two entries.
    if (loaded && _values.length > 2) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          height: 125,
          child: SfCartesianChart(
            primaryXAxis: DateTimeCategoryAxis(
              dateFormat: DateFormat.yMMM(),
              labelStyle: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.normal),
              axisLine: AxisLine(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            primaryYAxis: NumericAxis(
              labelStyle: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.normal),
              axisLine: AxisLine(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              axisLabelFormatter:
                  (AxisLabelRenderDetails args) => ChartAxisLabel(
                    NumberFormat().format(double.parse(args.text)),
                    args.textStyle,
                  ),
            ),
            series: _getUpdateDataSourceSeries(),
            enableAxisAnimation: false,
            enableSideBySideSeriesPlacement: false,
          ),
        ),
      );
    }

    // Loaded but less than two entries
    if (loaded) {
      return const SizedBox.shrink();
    }

    // Still loading
    return const SizedBox(
      height: 141, // Measured final chart height
      child: Center(child: CircularProgressIndicator()),
    );
  }

  void addTransactions(List<TransactionRead> transactions) {
    setState(() {
      for (TransactionRead transaction in transactions.reversed) {
        for (TransactionSplit split in transaction.attributes.transactions) {
          if (split.billId == widget.billId) {
            double value = _values[split.date] ?? 0;
            value += double.tryParse(split.amount) ?? 0;
            _values[split.date] = value;
          }
        }
      }
    });
  }

  void doneLoading() {
    if (loaded) {
      return;
    }
    setState(() {
      loaded = true;
    });
  }

  List<CartesianSeries<TimeSeriesChart, DateTime>>
  _getUpdateDataSourceSeries() {
    final List<TimeSeriesChart> chartDataBalance = <TimeSeriesChart>[];
    _values.forEach(
      (DateTime d, double v) => chartDataBalance.add(TimeSeriesChart(d, v)),
    );

    return <CartesianSeries<TimeSeriesChart, DateTime>>[
      AreaSeries<TimeSeriesChart, DateTime>(
        dataSource: chartDataBalance,
        xValueMapper: (TimeSeriesChart data, _) => data.time,
        yValueMapper: (TimeSeriesChart data, _) => data.value,
        animationDuration: animDurationEmphasized.inMilliseconds.toDouble() * 2,
        color: Colors.blue,
        opacity: 0.4,
      ),
      LineSeries<TimeSeriesChart, DateTime>(
        dataSource: chartDataBalance,
        xValueMapper: (TimeSeriesChart data, _) => data.time,
        yValueMapper: (TimeSeriesChart data, _) => data.value,
        animationDuration: animDurationEmphasized.inMilliseconds.toDouble() * 2,
        color: Colors.blue,
        markerSettings: const MarkerSettings(
          isVisible: true,
          borderWidth: 0,
          color: Colors.blue,
        ),
      ),
    ];
  }
}
