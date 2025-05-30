import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart';
import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/timezonehandler.dart';
import 'package:waterflyiii/widgets/charts.dart';

class LastDaysChart extends StatelessWidget {
  const LastDaysChart({
    super.key,
    required this.expenses,
    required this.incomes,
  });

  final Map<DateTime, double> expenses;
  final Map<DateTime, double> incomes;

  @override
  Widget build(BuildContext context) {
    final TimeZoneHandler tzHandler = context.read<FireflyService>().tzHandler;
    // Use noon due to daylight saving time
    final TZDateTime now = tzHandler.sNow().setTimeOfDay(
      const TimeOfDay(hour: 12, minute: 0),
    );
    final List<DateTime> lastDays = <DateTime>[];
    for (int i = 0; i < 7; i++) {
      lastDays.add(
        now
            .subtract(Duration(days: i))
            .setTimeOfDay(const TimeOfDay(hour: 12, minute: 0)),
      );
    }
    bool showCurrency = true;
    final CurrencyRead defaultCurrency =
        context.read<FireflyService>().defaultCurrency;

    final List<LabelAmountChart> chartData = <LabelAmountChart>[];

    for (DateTime e in lastDays.reversed) {
      if (!expenses.containsKey(e) || !incomes.containsKey(e)) {
        continue;
      }
      final double expense = expenses[e]!;
      final double income = incomes[e]!;

      final double diff = income + expense;

      // Don't show currency when numbers are too big, see #29
      if (showCurrency && diff.abs() >= 1000) {
        showCurrency = false;
      }

      chartData.add(
        LabelAmountChart(DateFormat(DateFormat.ABBR_WEEKDAY).format(e), diff),
      );
    }

    return charts.BarChart(
      <charts.Series<LabelAmountChart, String>>[
        charts.Series<LabelAmountChart, String>(
          id: 'LastDays',
          domainFn: (LabelAmountChart entry, _) => entry.label,
          measureFn: (LabelAmountChart entry, _) => entry.amount.abs(),
          data: chartData,
          colorFn:
              (LabelAmountChart entry, _) =>
                  (entry.amount > 0)
                      ? charts.MaterialPalette.green.shadeDefault
                      : charts.MaterialPalette.red.shadeDefault,
          labelAccessorFn:
              (LabelAmountChart entry, _) =>
                  showCurrency
                      ? defaultCurrency.fmt(
                        entry.amount.abs(),
                        decimalDigits: 0,
                      )
                      // Use compact number formatting for numbers over 10.000
                      : entry.amount.abs() >= 100000
                      ? NumberFormat.compact().format(entry.amount.abs())
                      : entry.amount.abs().toStringAsFixed(0),
          outsideLabelStyleAccessorFn:
              (_, _) => charts.TextStyleSpec(
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
