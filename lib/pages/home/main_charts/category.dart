import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/widgets/charts.dart';

class CategoryChart extends StatelessWidget {
  const CategoryChart({
    super.key,
    required this.data,
  });

  final List<InsightGroupEntry> data;

  @override
  Widget build(BuildContext context) {
    List<LabelAmountChart> chartData = <LabelAmountChart>[];

    for (InsightGroupEntry e in data) {
      if (e.name.isEmpty || e.differenceFloat == 0) {
        continue;
      }
      chartData.add(
        LabelAmountChart(
          e.name,
          e.differenceFloat,
        ),
      );
    }

    chartData.sort((LabelAmountChart a, LabelAmountChart b) =>
        a.amount.compareTo(b.amount));

    if (data.length > 5) {
      LabelAmountChart otherData = chartData.skip(5).reduce(
            (LabelAmountChart v, LabelAmountChart e) =>
                LabelAmountChart(S.of(context).catOther, v.amount + e.amount),
          );
      chartData = chartData.take(5).toList();

      if (otherData.amount != 0) {
        chartData.add(otherData);
      }
    }

    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: SfCircularChart(
        legend: Legend(
          isVisible: true,
          position: LegendPosition.right,
          itemPadding: 4,
          textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontWeight: FontWeight.normal,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
          alignment: ChartAlignment.center,
          isResponsive: true,
        ),
        series: <CircularSeries<LabelAmountChart, String>>[
          PieSeries<LabelAmountChart, String>(
            dataSource: chartData,
            xValueMapper: (LabelAmountChart data, _) => data.label,
            yValueMapper: (LabelAmountChart data, _) => data.amount.abs(),
            dataLabelMapper: (LabelAmountChart data, _) =>
                data.amount.abs().toStringAsFixed(0),
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              textStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              connectorLineSettings: ConnectorLineSettings(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            animationDuration:
                animDurationEmphasized.inMilliseconds.toDouble() * 2,
          ),
        ],
        palette: possibleChartColorsDart,
        margin: EdgeInsets.zero,
      ),
    );
  }
}
