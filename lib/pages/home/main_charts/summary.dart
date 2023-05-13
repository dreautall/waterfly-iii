import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;

import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/widgets/charts.dart';

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
        } else if (prevDate != null && date.day >= 15 && prevDate!.day < 15) {
          ticks.add(
              charts.TickSpec<DateTime>(DateTime(date.year, date.month, 15)));
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
        animationDuration: animDurationEmphasized,
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
            DateFormat(
              DateFormat.ABBR_MONTH_DAY,
              S.of(context).localeName,
            ),
          ),
          tickProviderSpec: charts.StaticDateTimeTickProviderSpec(ticks),
          renderSpec: charts.SmallTickRendererSpec<DateTime>(
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
