import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;

import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/widgets/charts.dart';

class CategoryChart extends StatelessWidget {
  const CategoryChart({
    super.key,
    required this.catChartData,
  });

  final Map<String, Category> catChartData;

  @override
  Widget build(BuildContext context) {
    List<LabelAmountChart> data = <LabelAmountChart>[];
    CurrencyRead defaultCurrency =
        context.read<FireflyService>().defaultCurrency;

    catChartData.forEach((_, Category e) {
      double sum = 0;
      if (e.spent == null) {
        return;
      }
      for (CategorySpent f in e.spent!) {
        sum += double.tryParse(f.sum ?? "") ?? 0;
      }
      if (sum == 0) {
        return;
      }
      data.add(
        LabelAmountChart(
          e.name,
          sum,
        ),
      );
    });

    data.sort((LabelAmountChart a, LabelAmountChart b) =>
        a.amount.compareTo(b.amount));

    if (data.length > 5) {
      LabelAmountChart otherData = data.skip(5).reduce(
            (LabelAmountChart v, LabelAmountChart e) =>
                LabelAmountChart(S.of(context).catOther, v.amount + e.amount),
          );
      data = data.take(5).toList();

      if (otherData.amount != 0) {
        data.add(otherData);
      }
    }

    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: charts.PieChart<String>(
        <charts.Series<LabelAmountChart, String>>[
          charts.Series<LabelAmountChart, String>(
            id: 'Categories',
            domainFn: (LabelAmountChart entry, _) => entry.label,
            measureFn: (LabelAmountChart entry, _) => entry.amount.abs(),
            data: data,
            labelAccessorFn: (LabelAmountChart entry, _) =>
                entry.amount.abs().toStringAsFixed(0),
            /*defaultCurrency.fmt(
              entry.amount.abs(),
              locale: S.of(context).localeName,
              decimalDigits: 0,
            ),*/
            colorFn: (_, int? i) => possibleChartColors[i ?? 5],
          ),
        ],
        animate: true,
        animationDuration: animDurationEmphasized,
        defaultRenderer: charts.ArcRendererConfig<String>(
          arcRendererDecorators: <charts.ArcLabelDecorator<String>>[
            charts.ArcLabelDecorator<String>(
              insideLabelStyleSpec: charts.TextStyleSpec(
                fontSize:
                    Theme.of(context).textTheme.labelSmall!.fontSize!.round(),
              ),
              outsideLabelStyleSpec: charts.TextStyleSpec(
                fontSize:
                    Theme.of(context).textTheme.labelSmall!.fontSize!.round(),
                color: charts.ColorUtil.fromDartColor(
                  Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              leaderLineStyleSpec: charts.ArcLabelLeaderLineStyleSpec(
                length: 10.0,
                thickness: 1.0,
                color: charts.ColorUtil.fromDartColor(
                  Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            )
          ],
        ),
        behaviors: <charts.ChartBehavior<String>>[
          charts.DatumLegend<String>(
            position: charts.BehaviorPosition.end,
            horizontalFirst: false,
            cellPadding: const EdgeInsets.only(right: 4, bottom: 4),
            showMeasures: false, // Not formattable :(
            legendDefaultMeasure: charts.LegendDefaultMeasure.firstValue,
            desiredMaxRows: 6,
            measureFormatter: (num? value) {
              return value == null
                  ? '-'
                  : defaultCurrency.fmt(
                      value,
                      locale: S.of(context).localeName,
                    );
            },
            entryTextStyle: charts.TextStyleSpec(
              fontSize:
                  Theme.of(context).textTheme.labelMedium!.fontSize!.round(),
            ),
          ),
        ],
        defaultInteractions: false,
      ),
    );
  }
}
