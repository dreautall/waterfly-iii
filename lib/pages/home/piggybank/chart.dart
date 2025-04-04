import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/widgets/charts.dart';

class PiggyChart extends StatefulWidget {
  const PiggyChart(this.piggy, this.data, {super.key});

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

  @override
  Widget build(BuildContext context) {
    log.finest(() => "build()");

    final List<CartesianSeries<TimeSeriesChart, DateTime>> chartData =
        <CartesianSeries<TimeSeriesChart, DateTime>>[];
    final List<TimeSeriesChart> data = <TimeSeriesChart>[];

    double total = 0;

    if (widget.piggy.attributes.startDate != null) {
      data.add(TimeSeriesChart(widget.piggy.attributes.startDate!, 0));
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
      LineSeries<TimeSeriesChart, DateTime>(
        dataSource: data,
        xValueMapper: (TimeSeriesChart data, _) => data.time,
        yValueMapper: (TimeSeriesChart data, _) => data.value,
        legendItemText: widget.piggy.id,
        animationDuration: animDurationEmphasized.inMilliseconds.toDouble() * 2,
        color: Colors.blue,
        markerSettings: const MarkerSettings(
          isVisible: true,
          borderWidth: 0,
          color: Colors.blue,
        ),
      ),
    );

    final List<PlotBand> targetAnnotation = <PlotBand>[];
    if (targetAmount != 0) {
      targetAnnotation.add(
        PlotBand(
          start: targetAmount,
          end: targetAmount,
          borderColor: Colors.deepOrange,
          borderWidth: 3,
          text: S.of(context).generalTarget,
          textAngle: 0,
          textStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.normal,
            color: Colors.deepOrange,
          ),
          verticalTextAlignment: TextAnchor.start,
          horizontalTextAlignment: TextAnchor.start,
          verticalTextPadding: '-1%',
          horizontalTextPadding: '1%',
        ),
      );
    }

    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(
        labelStyle: Theme.of(
          context,
        ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.normal),
        dateFormat: DateFormat(DateFormat.ABBR_MONTH_DAY),
        axisLine: AxisLine(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        minorTicksPerInterval: 1,
      ),
      primaryYAxis: NumericAxis(
        labelStyle: Theme.of(
          context,
        ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.normal),
        axisLine: AxisLine(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        plotBands: targetAnnotation,
        maximum: targetAmount != 0 ? targetAmount : null,
        axisLabelFormatter:
            (AxisLabelRenderDetails args) => ChartAxisLabel(
              NumberFormat().format(double.parse(args.text)),
              args.textStyle,
            ),
      ),
      series: chartData,
      palette: possibleChartColorsDart,
      enableAxisAnimation: true,
      trackballBehavior: TrackballBehavior(
        enable: true,
        activationMode: ActivationMode.longPress,
        lineType: TrackballLineType.vertical,
        tooltipSettings: InteractiveTooltip(
          decimalPlaces: currency.attributes.decimalPlaces ?? 2,
          format:
              "point.x ${currency.fmt(123, decimalDigits: 0).replaceAll("123", "point.y")}",
          canShowMarker: false,
        ),
        tooltipDisplayMode: TrackballDisplayMode.nearestPoint,
        markerSettings: const TrackballMarkerSettings(
          markerVisibility: TrackballVisibilityMode.visible,
        ),
        shouldAlwaysShow: true,
      ),
    );
  }
}
