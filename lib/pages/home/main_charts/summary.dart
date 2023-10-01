import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:chopper/chopper.dart' show Response;
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/widgets/charts.dart';

class SummaryChart extends StatelessWidget {
  const SummaryChart({
    super.key,
    required this.data,
  });

  final List<ChartDataSet> data;

  @override
  Widget build(BuildContext context) {
    final List<ChartSeries<TimeSeriesChart, DateTime>> chartData =
        <ChartSeries<TimeSeriesChart, DateTime>>[];

    for (ChartDataSet e in data) {
      chartData.add(
        LineSeries<TimeSeriesChart, DateTime>(
          dataSource: e.toChart(),
          xValueMapper: (TimeSeriesChart data, _) => data.time,
          yValueMapper: (TimeSeriesChart data, _) => data.value,
          legendItemText: e.label,
          animationDuration:
              animDurationEmphasized.inMilliseconds.toDouble() * 2,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: SfCartesianChart(
        primaryXAxis: DateTimeAxis(
          labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.normal,
              ),
          dateFormat: DateFormat(DateFormat.ABBR_MONTH_DAY),
          axisLine:
              AxisLine(color: Theme.of(context).colorScheme.onSurfaceVariant),
          minorTicksPerInterval: 1,
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
        palette: possibleChartColorsDart,
        enableAxisAnimation: true,
      ),
    );
  }
}

class SummaryChartPopup extends StatefulWidget {
  const SummaryChartPopup({
    super.key,
  });

  @override
  State<SummaryChartPopup> createState() => _SummaryChartPopupState();
}

class _SummaryChartPopupState extends State<SummaryChartPopup> {
  List<CurrencyRead> currencies = <CurrencyRead>[];
  List<double> balances = <double>[];
  List<String> accounts = <String>[];
  ValueNotifier<DateTime?> date = ValueNotifier<DateTime?>(null);

  Future<List<ChartDataSet>> _fetchData(BuildContext context) async {
    final FireflyIii api = context.read<FireflyService>().api;
    final DateTime now = DateTime.now().toLocal().clearTime();

    final Response<ChartLine> respChartData =
        await api.v1ChartAccountOverviewGet(
      start:
          DateFormat('yyyy-MM-dd').format(now.copyWith(month: now.month - 36)),
      end: DateFormat('yyyy-MM-dd').format(now),
    );
    if (!respChartData.isSuccessful ||
        respChartData.body == null ||
        respChartData.body!.isEmpty) {
      if (context.mounted) {
        throw Exception(
          S
              .of(context)
              .errorAPIInvalidResponse(respChartData.error?.toString() ?? ""),
        );
      } else {
        throw Exception(
          "[nocontext] Invalid API response: ${respChartData.error}",
        );
      }
    }

    currencies.clear();
    balances.clear();
    accounts.clear();

    // Initialize table variables
    DateTime? latestDate;
    for (ChartDataSet e in respChartData.body!) {
      if (latestDate == null ||
          (e.endDate != null && e.endDate!.isAfter(latestDate))) {
        latestDate = e.endDate;
      }
      currencies.add(
        CurrencyRead(
          id: e.currencyId ?? "0",
          type: "currencies",
          attributes: Currency(
            code: e.currencyCode ?? "",
            name: "",
            symbol: e.currencySymbol ?? "",
            decimalPlaces: e.currencyDecimalPlaces,
          ),
        ),
      );
      final Map<String, dynamic> entries = e.entries! as Map<String, dynamic>;
      balances.add(double.tryParse(entries.entries.last.value) ?? 0);
      accounts.add(e.label!);
    }
    if (latestDate == null) {
      date.value == DateTime.now().toLocal();
    }
    date.value = latestDate!.clearTime();

    return respChartData.body!;
  }

  void trackballPositionChange(TrackballArgs args,
      List<ChartSeries<TimeSeriesChart, DateTime>> chartData) {
    if (args.chartPointInfo.chartDataPoint == null) {
      return;
    }

    int i = 0;
    for (ChartSeries<TimeSeriesChart, DateTime> chart in chartData) {
      balances[i] =
          chart.dataSource![args.chartPointInfo.dataPointIndex!].value;
      i++;
    }
    date.value = args.chartPointInfo.chartDataPoint!.x.toLocal();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(S.of(context).homeMainChartAccountsTitle),
      clipBehavior: Clip.hardEdge,
      insetPadding: const EdgeInsets.all(12),
      children: <Widget>[
        FutureBuilder<List<ChartDataSet>>(
          future: _fetchData(context),
          builder: (BuildContext context,
              AsyncSnapshot<List<ChartDataSet>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              final List<ChartSeries<TimeSeriesChart, DateTime>> chartData =
                  <ChartSeries<TimeSeriesChart, DateTime>>[];

              for (ChartDataSet e in snapshot.data!) {
                if (e.label == null || e.label!.isEmpty) {
                  continue;
                }
                chartData.add(
                  FastLineSeries<TimeSeriesChart, DateTime>(
                    dataSource: e.toChart(),
                    xValueMapper: (TimeSeriesChart data, _) => data.time,
                    yValueMapper: (TimeSeriesChart data, _) => data.value,
                    legendItemText: e.label,
                    animationDuration:
                        animDurationEmphasized.inMilliseconds.toDouble() * 2,
                  ),
                );
              }

              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: SizedBox(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: SfCartesianChart(
                        primaryXAxis: DateTimeAxis(
                          enableAutoIntervalOnZooming: true,
                          labelStyle:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                          dateFormat: DateFormat(DateFormat.ABBR_MONTH_DAY),
                          axisLine: AxisLine(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant),
                          minorTicksPerInterval: 3,
                          zoomFactor: 0.09,
                          zoomPosition: 1,
                        ),
                        primaryYAxis: NumericAxis(
                          labelStyle:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                          axisLine: AxisLine(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant),
                          axisLabelFormatter: (AxisLabelRenderDetails args) =>
                              ChartAxisLabel(
                                  NumberFormat()
                                      .format(double.parse(args.text)),
                                  args.textStyle),
                        ),
                        series: chartData,
                        enableAxisAnimation: true,
                        palette: possibleChartColorsDart,
                        tooltipBehavior: TooltipBehavior(
                          enable: false,
                        ),
                        crosshairBehavior: CrosshairBehavior(enable: false),
                        zoomPanBehavior: ZoomPanBehavior(
                          enablePanning: true,
                          enablePinching: true,
                          zoomMode: ZoomMode.x,
                          enableDoubleTapZooming: true,
                        ),
                        trackballBehavior: TrackballBehavior(
                          enable: true,
                          activationMode: ActivationMode.longPress,
                          lineType: TrackballLineType.vertical,
                          tooltipDisplayMode: TrackballDisplayMode.none,
                          markerSettings: const TrackballMarkerSettings(
                            markerVisibility: TrackballVisibilityMode.visible,
                          ),
                          shouldAlwaysShow: true,
                        ),
                        onTrackballPositionChanging: (TrackballArgs args) =>
                            trackballPositionChange(args, chartData),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                    child: ValueListenableBuilder<DateTime?>(
                      valueListenable: date,
                      builder: (BuildContext context, DateTime? value,
                              Widget? child) =>
                          SummaryTable(
                        accounts: accounts,
                        balances: balances,
                        currencies: currencies,
                        date: value!,
                      ),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              log.severe("Error getting chart card data", snapshot.error,
                  snapshot.stackTrace);
              Navigator.of(context).pop();
              return const SizedBox.shrink();
            } else {
              return const Padding(
                padding: EdgeInsets.all(8),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

class SummaryTable extends StatelessWidget {
  const SummaryTable({
    super.key,
    required this.currencies,
    required this.balances,
    required this.accounts,
    required this.date,
  });

  final List<CurrencyRead> currencies;
  final List<double> balances;
  final List<String> accounts;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: Text(
            S.of(context).generalBalanceOn(date),
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        Table(
          //border: TableBorder.all(), // :DEBUG:
          columnWidths: const <int, TableColumnWidth>{
            0: FixedColumnWidth(24),
            1: FlexColumnWidth(),
            2: IntrinsicColumnWidth(),
          },
          children: <TableRow>[
            ...accounts.mapIndexed(
              (int i, String account) {
                final CurrencyRead currency = currencies[i];
                final double balance = balances[i];
                return TableRow(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "⬤",
                        style: TextStyle(
                          color: possibleChartColorsDart[
                              i % possibleChartColorsDart.length],
                          textBaseline: TextBaseline.ideographic,
                          height: 1.3,
                        ),
                      ),
                    ),
                    Text(account),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        currency.fmt(
                          balance,
                          locale: S.of(context).localeName,
                        ),
                        style: TextStyle(
                          color: (balance < 0) ? Colors.red : Colors.green,
                          fontWeight: FontWeight.bold,
                          fontFeatures: const <FontFeature>[
                            FontFeature.tabularFigures()
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
