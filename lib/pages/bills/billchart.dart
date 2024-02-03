import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.models.swagger.dart';
import 'package:waterflyiii/widgets/charts.dart';

class BillChart extends StatefulWidget {
  const BillChart({
    super.key,
    required this.billId,
  });

  final String billId;

  @override
  State<BillChart> createState() => BillChartState();
}

class BillChartState extends State<BillChart> {
  final SplayTreeMap<DateTime, double> _values =
      SplayTreeMap<DateTime, double>();

  @override
  void dispose() {
    _values.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_values.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
            height: 125,
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
              series: _getUpdateDataSourceSeries(),
              enableAxisAnimation: false,
              enableSideBySideSeriesPlacement: false,
            )
        ),
      );
    }
    else {
      return const SizedBox(height: 0);
    }
  }

  void addTransactions(List<TransactionRead> transactions) {
    setState(() {
      for (TransactionRead transaction in transactions.reversed) {
        for (TransactionSplit split in transaction.attributes.transactions) {
          if (split.billId == widget.billId) {
            _values[split.date] = double.tryParse(split.amount) ?? 0;
          }
        }
      }
    });
  }

  List<CartesianSeries<LabelAmountChart, String>> _getUpdateDataSourceSeries() {
    final List<LabelAmountChart> chartDataBalance = <LabelAmountChart>[];
    _values.forEach((DateTime d, double v) => chartDataBalance
        .add(LabelAmountChart(DateFormat(DateFormat.ABBR_MONTH).format(d), v)));

    return <CartesianSeries<LabelAmountChart, String>>[
      AreaSeries<LabelAmountChart, String>(
        dataSource: chartDataBalance,
        xValueMapper: (LabelAmountChart data, _) => data.label,
        yValueMapper: (LabelAmountChart data, _) => data.amount,
        animationDuration: animDurationEmphasized.inMilliseconds.toDouble() * 2,
        color: Colors.blue,
        opacity: 0.4,
      ),
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
    ];
  }
}
