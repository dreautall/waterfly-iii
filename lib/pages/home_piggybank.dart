import 'dart:ui';

import 'package:chopper/chopper.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/swagger_fireflyiii_api/firefly_iii.swagger.dart';

import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;

class HomePiggybank extends StatefulWidget {
  const HomePiggybank({
    super.key,
  });

  @override
  State<HomePiggybank> createState() => _HomePiggybankState();
}

class _HomePiggybankState extends State<HomePiggybank>
    with AutomaticKeepAliveClientMixin {
  Future<PiggyBankArray> _fetchAccounts() async {
    final api = FireflyProvider.of(context).api;
    if (api == null) {
      throw Exception("API unavailable");
    }

    final respAccounts = await api.apiV1PiggyBanksGet();

    if (!respAccounts.isSuccessful || respAccounts.body == null) {
      throw Exception("Invalid Response from API");
    }

    return Future.value(respAccounts.body);
  }

  Future<void> _refreshStats() async {
    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("home_piggybank build()");

    return RefreshIndicator(
      onRefresh: _refreshStats,
      child: FutureBuilder(
        future: _fetchAccounts(),
        builder:
            (BuildContext context, AsyncSnapshot<PiggyBankArray> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return ListView(
              cacheExtent: 1000,
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                ...snapshot.data!.data.map(
                  (PiggyBankRead piggy) {
                    final double currentAmount =
                        double.tryParse(piggy.attributes.currentAmount ?? "") ??
                            0;
                    final String currentString = currentAmount
                        .abs()
                        .toStringAsFixed(
                            piggy.attributes.currencyDecimalPlaces ?? 2);
                    final double targetAmount =
                        double.tryParse(piggy.attributes.targetAmount ?? "") ??
                            0;
                    final String targetString = targetAmount
                        .abs()
                        .toStringAsFixed(
                            piggy.attributes.currencyDecimalPlaces ?? 2);
                    if (!(piggy.attributes.active ?? false)) {
                      return const SizedBox();
                    }
                    return Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(piggy.attributes.name),
                          subtitle:
                              Text("Linked to ${piggy.attributes.accountName}"),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                          ),
                          isThreeLine: false,
                          trailing: RichText(
                            textAlign: TextAlign.end,
                            maxLines: 2,
                            text: TextSpan(
                              style: Theme.of(context).textTheme.bodyMedium,
                              children: <InlineSpan>[
                                TextSpan(
                                  text:
                                      "${(currentAmount < 0) ? '-' : ''}${piggy.attributes.currencySymbol}$currentString",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                    color: (currentAmount < 0)
                                        ? Colors.red
                                        : Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontFeatures: const <FontFeature>[
                                      FontFeature.tabularFigures()
                                    ],
                                  ),
                                ),
                                targetAmount != 0
                                    ? const TextSpan(text: "\n")
                                    : const TextSpan(),
                                targetAmount != 0
                                    ? TextSpan(
                                        text:
                                            "${(piggy.attributes.percentage ?? 0).round()}% of ${piggy.attributes.currencySymbol}$targetString")
                                    : const TextSpan(),
                              ],
                            ),
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  PiggyDetails(piggy: piggy),
                            );
                          },
                        ),
                        piggy.attributes.percentage != null
                            ? LinearProgressIndicator(
                                value: piggy.attributes.percentage! / 100,
                              )
                            : const Divider(height: 0),
                      ],
                    );
                  },
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error!.toString());
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
    );
  }
}

class PiggyDetails extends StatefulWidget {
  const PiggyDetails({
    super.key,
    required this.piggy,
  });

  final PiggyBankRead piggy;

  @override
  State<PiggyDetails> createState() => _PiggyDetailsState();
}

class TimeSeriesChart {
  final DateTime time;
  final double value;

  TimeSeriesChart(this.time, this.value);
}

class _PiggyDetailsState extends State<PiggyDetails> {
  Future<List<PiggyBankEventRead>> _fetchChart() async {
    final api = FireflyProvider.of(context).api;
    if (api == null) {
      throw Exception("API unavailable");
    }

    final resp = await api.apiV1PiggyBanksIdEventsGet(id: widget.piggy.id);
    if (!resp.isSuccessful || resp.body == null || resp.body!.data.isEmpty) {
      throw Exception("Invalid Response from API");
    }

    return resp.body!.data.sortedBy<DateTime>((PiggyBankEventRead e) =>
        e.attributes.createdAt ?? e.attributes.updatedAt ?? DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final double currentAmount =
        double.tryParse(widget.piggy.attributes.currentAmount ?? "") ?? 0;
    final String currentString = currentAmount
        .abs()
        .toStringAsFixed(widget.piggy.attributes.currencyDecimalPlaces ?? 2);
    final double targetAmount =
        double.tryParse(widget.piggy.attributes.targetAmount ?? "") ?? 0;
    final String targetString = targetAmount
        .abs()
        .toStringAsFixed(widget.piggy.attributes.currencyDecimalPlaces ?? 2);
    final double leftAmount =
        double.tryParse(widget.piggy.attributes.leftToSave ?? "") ?? 0;
    final String leftString = leftAmount
        .abs()
        .toStringAsFixed(widget.piggy.attributes.currencyDecimalPlaces ?? 2);
    final DateTime? startDate = widget.piggy.attributes.startDate?.toLocal();
    final DateTime? targetDate = widget.piggy.attributes.targetDate?.toLocal();

    String infoText = "";

    if (targetAmount != 0) {
      infoText +=
          "Target amount: ${widget.piggy.attributes.currencySymbol}$targetString\n";
    }
    infoText +=
        "Saved so far: ${widget.piggy.attributes.currencySymbol}$currentString\n";
    if (leftAmount != 0) {
      infoText +=
          "Left to save: ${widget.piggy.attributes.currencySymbol}$leftString\n";
    }
    if (startDate != null) {
      infoText +=
          "Start date: ${DateFormat(DateFormat.YEAR_MONTH_DAY).format(startDate)}\n";
    }
    if (targetDate != null) {
      infoText +=
          "Target date: ${DateFormat(DateFormat.YEAR_MONTH_DAY).format(targetDate)}\n";
    }

    return SimpleDialog(
      title: Text(widget.piggy.attributes.name),
      clipBehavior: Clip.hardEdge,
      children: <Widget>[
        widget.piggy.attributes.percentage != null
            ? LinearProgressIndicator(
                value: widget.piggy.attributes.percentage! / 100,
              )
            : const Divider(height: 0),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
          child: Text(infoText.strip()),
        ),
        FutureBuilder(
            future: _fetchChart(),
            builder: (BuildContext context,
                AsyncSnapshot<List<PiggyBankEventRead>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                final List<charts.Series<TimeSeriesChart, DateTime>> chartData =
                    [];
                final List<charts.TickSpec<DateTime>> ticks = [];
                final List<TimeSeriesChart> data = [];

                double total = 0;

                if (widget.piggy.attributes.startDate != null) {
                  data.add(TimeSeriesChart(
                    widget.piggy.attributes.startDate!,
                    0,
                  ));
                  ticks.add(charts.TickSpec(
                      widget.piggy.attributes.startDate!.toLocal()));
                }

                for (PiggyBankEventRead e in snapshot.data!) {
                  final DateTime? date =
                      e.attributes.createdAt ?? e.attributes.updatedAt;
                  final amount =
                      double.tryParse(e.attributes.amount ?? "") ?? 0;
                  if (date == null || amount == 0) {
                    continue;
                  }
                  total += amount;
                  data.add(TimeSeriesChart(date, total));
                  ticks.add(charts.TickSpec(date.toLocal()));
                }
                chartData.add(
                  charts.Series<TimeSeriesChart, DateTime>(
                    id: widget.piggy.id,
                    domainFn: (TimeSeriesChart d, _) => d.time.toLocal(),
                    measureFn: (TimeSeriesChart d, _) => d.value,
                    data: data,
                  ),
                );

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    height: 300,
                    child: charts.TimeSeriesChart(
                      chartData,
                      animate: true,
                      primaryMeasureAxis: charts.NumericAxisSpec(
                        tickProviderSpec:
                            const charts.BasicNumericTickProviderSpec(
                          //desiredTickCount: 6,
                          desiredMaxTickCount: 6,
                          desiredMinTickCount: 4,
                          zeroBound: true,
                        ),
                        renderSpec: charts.SmallTickRendererSpec(
                          labelStyle: charts.TextStyleSpec(
                            color: charts.ColorUtil.fromDartColor(
                                Theme.of(context).colorScheme.onSurfaceVariant),
                          ),
                        ),
                      ),
                      domainAxis: charts.DateTimeAxisSpec(
                        tickFormatterSpec: charts.BasicDateTimeTickFormatterSpec
                            .fromDateFormat(
                                DateFormat(DateFormat.ABBR_MONTH_DAY)),
                        tickProviderSpec:
                            const charts.AutoDateTimeTickProviderSpec(
                                includeTime: false),
                        renderSpec: charts.SmallTickRendererSpec(
                          labelStyle: charts.TextStyleSpec(
                            color: charts.ColorUtil.fromDartColor(
                                Theme.of(context).colorScheme.onSurfaceVariant),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                print("has error ${snapshot.error}, popping view");
                Navigator.of(context).pop();
                return const SizedBox();
              } else {
                return const Padding(
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }),
        OverflowBar(
          alignment: MainAxisAlignment.end,
          children: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ],
    );
  }
}
