import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:chopper/chopper.dart' show Response;
import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;

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
    final List<charts.Series<TimeSeriesChart, DateTime>> chartData =
        <charts.Series<TimeSeriesChart, DateTime>>[];
    final List<charts.TickSpec<DateTime>> ticks = <charts.TickSpec<DateTime>>[];
    final List<DateTime> addedTicks = <DateTime>[];

    for (ChartDataSet e in data) {
      final List<TimeSeriesChart> accountData = <TimeSeriesChart>[];

      final Map<String, dynamic> entries = e.entries! as Map<String, dynamic>;
      DateTime? prevDate;
      entries.forEach((String key, dynamic value) {
        final DateTime date = DateTime.parse(key);
        DateTime? tickDate;
        if (prevDate != null && date.month != prevDate!.month) {
          tickDate = DateTime(date.year, date.month, 1);
        } else if (prevDate != null && date.day >= 15 && prevDate!.day < 15) {
          tickDate = DateTime(date.year, date.month, 15);
        }
        if (tickDate != null && !addedTicks.contains(tickDate)) {
          ticks.add(charts.TickSpec<DateTime>(tickDate));
          addedTicks.add(tickDate);
        }
        accountData.add(TimeSeriesChart(
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
          data: accountData,
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
                Theme.of(context).colorScheme.onSurfaceVariant,
              ),
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
                Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
        defaultInteractions: false,
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
          DateFormat('yyyy-MM-dd').format(now.copyWith(month: now.month - 24)),
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

    // Initialize table variables
    DateTime? latestDate;
    for (ChartDataSet e in respChartData.body!) {
      if (latestDate == null ||
          (e.endDate != null && e.endDate!.isAfter(latestDate))) {
        latestDate = e.endDate;
      }
      currencies.add(CurrencyRead(
        id: e.currencyId ?? "0",
        type: "currencies",
        attributes: Currency(
          code: e.currencyCode ?? "",
          name: "",
          symbol: e.currencySymbol ?? "",
          decimalPlaces: e.currencyDecimalPlaces,
        ),
      ));
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
              final List<charts.Series<TimeSeriesChart, DateTime>> chartData =
                  <charts.Series<TimeSeriesChart, DateTime>>[];
              final List<charts.TickSpec<DateTime>> ticks =
                  <charts.TickSpec<DateTime>>[];
              final List<DateTime> addedTicks = <DateTime>[];

              for (ChartDataSet e in snapshot.data!) {
                final List<TimeSeriesChart> data = <TimeSeriesChart>[];

                final Map<String, dynamic> entries =
                    e.entries! as Map<String, dynamic>;
                DateTime? prevDate;
                entries.forEach((String key, dynamic value) {
                  final DateTime date = DateTime.parse(key);
                  DateTime? tickDate;
                  if (prevDate != null && date.month != prevDate!.month) {
                    tickDate = DateTime(date.year, date.month, 1);
                  } else if (prevDate != null &&
                      date.day >= 15 &&
                      prevDate!.day < 15) {
                    tickDate = DateTime(date.year, date.month, 15);
                  }
                  if (tickDate != null && !addedTicks.contains(tickDate)) {
                    ticks.add(charts.TickSpec<DateTime>(tickDate));
                    addedTicks.add(tickDate);
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

              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: SizedBox(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: charts.TimeSeriesChart(
                        chartData,
                        animate: true,
                        animationDuration: animDurationEmphasized,
                        primaryMeasureAxis: charts.NumericAxisSpec(
                          tickProviderSpec:
                              const charts.BasicNumericTickProviderSpec(
                            //desiredTickCount: 6,
                            desiredMaxTickCount: 6,
                            desiredMinTickCount: 4,
                          ),
                          renderSpec: charts.SmallTickRendererSpec<num>(
                            labelStyle: charts.TextStyleSpec(
                              color: charts.ColorUtil.fromDartColor(
                                Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ),
                        domainAxis: charts.DateTimeAxisSpec(
                          tickFormatterSpec: charts
                              .BasicDateTimeTickFormatterSpec.fromDateFormat(
                            DateFormat(
                              DateFormat.ABBR_MONTH_DAY,
                              S.of(context).localeName,
                            ),
                          ),
                          tickProviderSpec:
                              charts.StaticDateTimeTickProviderSpec(ticks),
                          renderSpec: charts.SmallTickRendererSpec<DateTime>(
                            labelStyle: charts.TextStyleSpec(
                              color: charts.ColorUtil.fromDartColor(
                                Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                          viewport: charts.DateTimeExtents(
                            start: DateTime.now()
                                .toLocal()
                                .subtract(const Duration(days: 90)),
                            end: DateTime.now().toLocal(),
                          ),
                        ),
                        behaviors: <charts.ChartBehavior<DateTime>>[
                          charts.PanAndZoomBehavior<DateTime>(),
                          charts.LinePointHighlighter<DateTime>(
                            selectionModelType: charts.SelectionModelType.info,
                            showHorizontalFollowLine: charts
                                .LinePointHighlighterFollowLineType.nearest,
                            showVerticalFollowLine: charts
                                .LinePointHighlighterFollowLineType.nearest,
                            drawFollowLinesAcrossChart: false,
                          ),
                          charts.SelectNearest<DateTime>(
                            selectionModelType: charts.SelectionModelType.info,
                            eventTrigger: charts.SelectionTrigger.pressHold,
                          ),
                        ],
                        defaultInteractions: false,
                        selectionModels: <charts
                            .SelectionModelConfig<DateTime>>[
                          charts.SelectionModelConfig<DateTime>(
                            type: charts.SelectionModelType.info,
                            changedListener:
                                (charts.SelectionModel<DateTime> model) {
                              if (model.hasDatumSelection) {
                                for (charts.SeriesDatum<DateTime> datum
                                    in model.selectedDatum) {
                                  final int i =
                                      accounts.indexOf(datum.series.id);
                                  if (i == -1) {
                                    continue;
                                  }
                                  balances[i] = datum.datum.value;
                                }
                                date.value =
                                    model.selectedDatum.first.datum.time;
                              }
                            },
                          )
                        ],
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
                          color: charts.ColorUtil.toDartColor(
                            possibleChartColors[i % possibleChartColors.length],
                          ),
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
