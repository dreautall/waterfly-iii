import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;

import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/widgets/charts.dart';

class LastDaysChart extends StatelessWidget {
  const LastDaysChart({
    super.key,
    required this.lastDaysExpense,
    required this.lastDaysIncome,
  });

  final Map<DateTime, InsightTotalEntry> lastDaysExpense;
  final Map<DateTime, InsightTotalEntry> lastDaysIncome;

  @override
  Widget build(BuildContext context) {
    // Use noon due to dailylight saving time
    final DateTime now = DateTime.now()
        .toLocal()
        .setTimeOfDay(const TimeOfDay(hour: 12, minute: 0));
    final List<DateTime> lastDays = <DateTime>[];
    for (int i = 0; i < 7; i++) {
      lastDays.add(now.subtract(Duration(days: i)));
    }
    bool showCurrency = true;
    CurrencyRead defaultCurrency =
        context.read<FireflyService>().defaultCurrency;

    final List<LabelAmountChart> chartData = <LabelAmountChart>[];

    for (DateTime e in lastDays.reversed) {
      if (!lastDaysExpense.containsKey(e) || !lastDaysIncome.containsKey(e)) {
        continue;
      }
      InsightTotalEntry expense = lastDaysExpense[e]!;
      InsightTotalEntry income = lastDaysIncome[e]!;

      double diff =
          (income.differenceFloat ?? 0) + (expense.differenceFloat ?? 0);

      // Don't show currency when numbers are too big, see #29
      if (diff > 1000) {
        showCurrency = false;
      }

      chartData.add(
        LabelAmountChart(
            DateFormat(
              DateFormat.ABBR_WEEKDAY,
              S.of(context).localeName,
            ).format(e),
            diff),
      );
    }

    return charts.BarChart(
      <charts.Series<LabelAmountChart, String>>[
        charts.Series<LabelAmountChart, String>(
          id: 'LastDays',
          domainFn: (LabelAmountChart entry, _) => entry.label,
          measureFn: (LabelAmountChart entry, _) => entry.amount.abs(),
          data: chartData,
          colorFn: (LabelAmountChart entry, _) => (entry.amount > 0)
              ? charts.MaterialPalette.green.shadeDefault
              : charts.MaterialPalette.red.shadeDefault,
          labelAccessorFn: (LabelAmountChart entry, _) => showCurrency
              ? defaultCurrency.fmt(
                  entry.amount.abs(),
                  decimalDigits: 0,
                  locale: S.of(context).localeName,
                )
              : entry.amount.abs().toStringAsFixed(0),
          outsideLabelStyleAccessorFn: (_, __) => charts.TextStyleSpec(
            color: charts.ColorUtil.fromDartColor(
              Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
      animate: true,
      animationDuration: animDurationEmphasized,
      barRendererDecorator: charts.BarLabelDecorator<String>(),
      primaryMeasureAxis: const charts.NumericAxisSpec(
        renderSpec: charts.NoneRenderSpec<num>(),
      ),
      domainAxis: charts.AxisSpec<String>(
        renderSpec: charts.SmallTickRendererSpec<String>(
          labelStyle: charts.TextStyleSpec(
            color: charts.ColorUtil.fromDartColor(
              Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
      defaultInteractions: false,
    );
  }
}
