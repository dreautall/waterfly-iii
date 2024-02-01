import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.models.swagger.dart';
import 'package:waterflyiii/widgets/charts.dart';

class BillChart extends StatelessWidget {
  const BillChart({
    super.key,
    required this.billId,
    required this.transactions,
  });

  final String billId;
  final List<TransactionRead> transactions;

  @override
  Widget build(BuildContext context) {
    Map<DateTime, double> values = <DateTime, double>{};
    for (TransactionRead transaction in transactions.reversed) {
      for (TransactionSplit split in transaction.attributes.transactions) {
        if (split.billId == billId) {
          values[split.date] = double.tryParse(split.amount) ?? 0;
        }
      }
    }

    final List<LabelAmountChart> chartDataAssets = <LabelAmountChart>[];
    final Map<String, double> balance = <String, double>{};
    final List<LabelAmountChart> chartDataBalance = <LabelAmountChart>[];
    final List<CartesianSeries<LabelAmountChart, String>> chartData =
        <CartesianSeries<LabelAmountChart, String>>[];

    values.forEach((DateTime d, double v) {
      chartDataAssets.add(
          LabelAmountChart(DateFormat(DateFormat.ABBR_MONTH).format(d), v));
      balance[DateFormat(DateFormat.ABBR_MONTH).format(d)] = v;
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

    return SfCartesianChart(
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
      enableAxisAnimation: false,
      enableSideBySideSeriesPlacement: false,
    );
  }
}
