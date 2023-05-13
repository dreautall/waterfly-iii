import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;

import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/widgets/charts.dart';

class PiggyChart extends StatefulWidget {
  const PiggyChart(
    this.piggy,
    this.data, {
    super.key,
  });

  final PiggyBankRead piggy;
  final List<PiggyBankEventRead> data;

  @override
  State<PiggyChart> createState() => _PiggyChartState();
}

class _PiggyChartState extends State<PiggyChart> {
  final Logger log = Logger("Pages.Home.Piggybank.Chart");

  DateTime? selectedTime;
  double? selectedValue;

  late CurrencyRead currency;
  late double targetAmount;

  @override
  void initState() {
    super.initState();

    currency = CurrencyRead(
      id: widget.piggy.attributes.currencyId ?? "0",
      type: "currencies",
      attributes: Currency(
        code: widget.piggy.attributes.currencyCode ?? "",
        name: "",
        symbol: widget.piggy.attributes.currencySymbol ?? "",
        decimalPlaces: widget.piggy.attributes.currencyDecimalPlaces,
      ),
    );
    targetAmount =
        double.tryParse(widget.piggy.attributes.targetAmount ?? "") ?? 0;
  }

  String chartLabel() {
    return "${DateFormat(
      DateFormat.ABBR_MONTH_DAY,
      S.of(context).localeName,
    ).format(selectedTime ?? DateTime.now().toLocal())}: ${currency.fmt(selectedValue ?? 0)}";
  }

  @override
  Widget build(BuildContext context) {
    final List<charts.Series<TimeSeriesChart, DateTime>> chartData =
        <charts.Series<TimeSeriesChart, DateTime>>[];
    final List<TimeSeriesChart> data = <TimeSeriesChart>[];

    double total = 0;

    if (widget.piggy.attributes.startDate != null) {
      data.add(TimeSeriesChart(
        widget.piggy.attributes.startDate!,
        0,
      ));
    }

    for (PiggyBankEventRead e in widget.data) {
      final DateTime? date = e.attributes.createdAt ?? e.attributes.updatedAt;
      final double amount = double.tryParse(e.attributes.amount ?? "") ?? 0;
      if (date == null || amount == 0) {
        continue;
      }
      total += amount;
      data.add(TimeSeriesChart(date, total));
    }
    data.add(TimeSeriesChart(DateTime.now().toLocal(), total));
    chartData.add(
      charts.Series<TimeSeriesChart, DateTime>(
        id: widget.piggy.id,
        domainFn: (TimeSeriesChart d, _) => d.time.toLocal(),
        measureFn: (TimeSeriesChart d, _) => d.value,
        data: data,
      ),
    );

    final List<charts.LineAnnotationSegment<Object>> chartAnnotations =
        <charts.LineAnnotationSegment<Object>>[];

    if (targetAmount != 0) {
      chartAnnotations.add(
        charts.LineAnnotationSegment<num>(
          targetAmount,
          charts.RangeAnnotationAxisType.measure,
          color: charts.MaterialPalette.deepOrange.shadeDefault,
          labelAnchor: charts.AnnotationLabelAnchor.start,
          startLabel: S.of(context).generalTarget,
          labelStyleSpec: charts.TextStyleSpec(
            color: charts.ColorUtil.fromDartColor(
              Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }
    if (widget.piggy.attributes.targetDate != null) {
      chartAnnotations.add(
        charts.LineAnnotationSegment<DateTime>(
          widget.piggy.attributes.targetDate!,
          charts.RangeAnnotationAxisType.domain,
          color: charts.MaterialPalette.deepOrange.shadeDefault,
          labelAnchor: charts.AnnotationLabelAnchor.start,
          startLabel: S.of(context).generalTarget,
          labelStyleSpec: charts.TextStyleSpec(
            color: charts.ColorUtil.fromDartColor(
              Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    return charts.TimeSeriesChart(
      chartData,
      animate: true,
      primaryMeasureAxis: charts.NumericAxisSpec(
        tickProviderSpec: const charts.BasicNumericTickProviderSpec(
          //desiredTickCount: 6,
          desiredMaxTickCount: 6,
          desiredMinTickCount: 4,
          zeroBound: true,
        ),
        renderSpec: charts.SmallTickRendererSpec<num>(
          labelStyle: charts.TextStyleSpec(
            color: charts.ColorUtil.fromDartColor(
                Theme.of(context).colorScheme.onSurfaceVariant),
          ),
        ),
      ),
      domainAxis: charts.DateTimeAxisSpec(
        tickFormatterSpec: charts.BasicDateTimeTickFormatterSpec.fromDateFormat(
          DateFormat(
            DateFormat.ABBR_MONTH_DAY,
            S.of(context).localeName,
          ),
        ),
        tickProviderSpec:
            const charts.AutoDateTimeTickProviderSpec(includeTime: false),
        renderSpec: charts.SmallTickRendererSpec<DateTime>(
          labelStyle: charts.TextStyleSpec(
            color: charts.ColorUtil.fromDartColor(
              Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
      defaultRenderer: charts.LineRendererConfig<DateTime>(
        includePoints: true,
      ),
      behaviors: <charts.ChartBehavior<DateTime>>[
        charts.RangeAnnotation<DateTime>(
          chartAnnotations,
        ),
        charts.LinePointHighlighter<DateTime>(
          showHorizontalFollowLine:
              charts.LinePointHighlighterFollowLineType.nearest,
          showVerticalFollowLine:
              charts.LinePointHighlighterFollowLineType.nearest,
          drawFollowLinesAcrossChart: false,
          symbolRenderer: TextSymbolRenderer(chartLabel, context),
        ),
        charts.SelectNearest<DateTime>(
          eventTrigger: charts.SelectionTrigger.tapAndDrag,
        )
      ],
      selectionModels: <charts.SelectionModelConfig<DateTime>>[
        charts.SelectionModelConfig<DateTime>(
          type: charts.SelectionModelType.info,
          changedListener: (charts.SelectionModel<DateTime> model) {
            if (model.hasDatumSelection) {
              selectedTime = model.selectedDatum[0].datum.time;
              selectedValue = model.selectedDatum[0].datum.value;
            } else {
              selectedTime = selectedValue = null;
            }
          },
        )
      ],
    );
  }
}
