import 'dart:convert';
import 'dart:ui';

import 'package:chopper/chopper.dart' show Response;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/widgets/input_number.dart';
import 'package:waterflyiii/widgets/materialiconbutton.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';

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
    final FireflyIii? api = FireflyProvider.of(context).api;
    if (api == null) {
      throw Exception("API unavailable");
    }

    final Response<PiggyBankArray> respAccounts = await api.v1PiggyBanksGet();

    if (!respAccounts.isSuccessful || respAccounts.body == null) {
      throw Exception("Invalid Response from API");
    }

    return Future<PiggyBankArray>.value(respAccounts.body);
  }

  Future<void> _refreshStats() async {
    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    debugPrint("home_piggybank build()");

    return RefreshIndicator(
      onRefresh: _refreshStats,
      child: FutureBuilder<PiggyBankArray>(
        future: _fetchAccounts(),
        builder:
            (BuildContext context, AsyncSnapshot<PiggyBankArray> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            if (snapshot.data!.data.isEmpty) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "No piggy banks set up.",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Icon(
                      Icons.savings_outlined,
                      size: 200,
                    ),
                    Text(
                      "Create some in the webinterface!",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              );
            }
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
                      return const SizedBox.shrink();
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
                          leading: CircleAvatar(
                            child: Container(
                              constraints: const BoxConstraints(
                                minHeight: 40,
                                maxHeight: 40,
                                minWidth: 40,
                                maxWidth: 40,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  stops: <double>[
                                    0,
                                    (piggy.attributes.percentage ?? 100) / 100,
                                    (piggy.attributes.percentage ?? 100) / 100,
                                  ],
                                  colors: <Color>[
                                    Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    Theme.of(context)
                                        .colorScheme
                                        .surfaceVariant,
                                  ],
                                ),
                              ),
                              child: const Icon(Icons.savings_outlined),
                            ),
                          ),
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
                            showDialog<void>(
                              context: context,
                              builder: (BuildContext context) =>
                                  PiggyDetails(piggy: piggy),
                            ).then((_) => setState(() {}));
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
    final FireflyIii? api = FireflyProvider.of(context).api;
    if (api == null) {
      throw Exception("API unavailable");
    }

    final Response<PiggyBankEventArray> resp =
        await api.v1PiggyBanksIdEventsGet(id: currentPiggy.id);
    if (!resp.isSuccessful || resp.body == null || resp.body!.data.isEmpty) {
      throw Exception("Invalid Response from API");
    }

    return resp.body!.data.sortedBy<DateTime>((PiggyBankEventRead e) =>
        e.attributes.createdAt ?? e.attributes.updatedAt ?? DateTime.now());
  }

  late PiggyBankRead currentPiggy;

  @override
  void initState() {
    super.initState();

    currentPiggy = widget.piggy;
  }

  @override
  Widget build(BuildContext context) {
    final double currentAmount =
        double.tryParse(currentPiggy.attributes.currentAmount ?? "") ?? 0;
    final String currentString = currentAmount
        .abs()
        .toStringAsFixed(currentPiggy.attributes.currencyDecimalPlaces ?? 2);
    final double targetAmount =
        double.tryParse(currentPiggy.attributes.targetAmount ?? "") ?? 0;
    final String targetString = targetAmount
        .abs()
        .toStringAsFixed(currentPiggy.attributes.currencyDecimalPlaces ?? 2);
    final double leftAmount =
        double.tryParse(currentPiggy.attributes.leftToSave ?? "") ?? 0;
    final String leftString = leftAmount
        .abs()
        .toStringAsFixed(currentPiggy.attributes.currencyDecimalPlaces ?? 2);
    final DateTime? startDate = currentPiggy.attributes.startDate?.toLocal();
    final DateTime? targetDate = currentPiggy.attributes.targetDate?.toLocal();

    String infoText = "";

    if (targetAmount != 0) {
      infoText +=
          "Target amount: ${currentPiggy.attributes.currencySymbol}$targetString\n";
    }
    infoText +=
        "Saved so far: ${currentPiggy.attributes.currencySymbol}$currentString\n";
    if (leftAmount != 0) {
      infoText +=
          "Left to save: ${currentPiggy.attributes.currencySymbol}$leftString\n";
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
      title: Text(currentPiggy.attributes.name),
      clipBehavior: Clip.hardEdge,
      children: <Widget>[
        currentPiggy.attributes.percentage != null
            ? LinearProgressIndicator(
                value: currentPiggy.attributes.percentage! / 100,
              )
            : const Divider(height: 0),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
          child: Text(infoText.trim()),
        ),
        FutureBuilder<List<PiggyBankEventRead>>(
            future: _fetchChart(),
            builder: (BuildContext context,
                AsyncSnapshot<List<PiggyBankEventRead>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                final List<charts.Series<TimeSeriesChart, DateTime>> chartData =
                    <charts.Series<TimeSeriesChart, DateTime>>[];
                final List<charts.TickSpec<DateTime>> ticks =
                    <charts.TickSpec<DateTime>>[];
                final List<TimeSeriesChart> data = <TimeSeriesChart>[];

                double total = 0;

                if (currentPiggy.attributes.startDate != null) {
                  data.add(TimeSeriesChart(
                    currentPiggy.attributes.startDate!,
                    0,
                  ));
                  ticks.add(charts.TickSpec<DateTime>(
                      currentPiggy.attributes.startDate!.toLocal()));
                }

                for (PiggyBankEventRead e in snapshot.data!) {
                  final DateTime? date =
                      e.attributes.createdAt ?? e.attributes.updatedAt;
                  final double amount =
                      double.tryParse(e.attributes.amount ?? "") ?? 0;
                  if (date == null || amount == 0) {
                    continue;
                  }
                  total += amount;
                  data.add(TimeSeriesChart(date, total));
                  ticks.add(charts.TickSpec<DateTime>(date.toLocal()));
                }
                chartData.add(
                  charts.Series<TimeSeriesChart, DateTime>(
                    id: currentPiggy.id,
                    domainFn: (TimeSeriesChart d, _) => d.time.toLocal(),
                    measureFn: (TimeSeriesChart d, _) => d.value,
                    data: data,
                  ),
                );

                final charts.TimeSeriesChart chart = charts.TimeSeriesChart(
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
                    tickFormatterSpec:
                        charts.BasicDateTimeTickFormatterSpec.fromDateFormat(
                            DateFormat(DateFormat.ABBR_MONTH_DAY)),
                    tickProviderSpec: const charts.AutoDateTimeTickProviderSpec(
                        includeTime: false),
                    renderSpec: charts.SmallTickRendererSpec<DateTime>(
                      labelStyle: charts.TextStyleSpec(
                        color: charts.ColorUtil.fromDartColor(
                            Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                    ),
                  ),
                  defaultRenderer:
                      charts.LineRendererConfig<DateTime>(includePoints: true),
                  behaviors: targetAmount != 0
                      ? <charts.ChartBehavior<DateTime>>[
                          charts.RangeAnnotation<DateTime>(
                            <charts.LineAnnotationSegment<num>>[
                              charts.LineAnnotationSegment<num>(
                                targetAmount,
                                charts.RangeAnnotationAxisType.measure,
                                color: charts
                                    .MaterialPalette.deepOrange.shadeDefault,
                                labelAnchor: charts.AnnotationLabelAnchor.start,
                                startLabel: "Target",
                              )
                            ],
                          ),
                        ]
                      : <charts.ChartBehavior<DateTime>>[],
                );

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    height: 300,
                    child: chart,
                  ),
                );
              } else if (snapshot.hasError) {
                debugPrint("has error ${snapshot.error}, popping view");
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
            FilledButton(
              onPressed: () async {
                PiggyBankSingle? newPiggy = await showDialog<PiggyBankSingle>(
                  context: context,
                  builder: (BuildContext context) =>
                      PiggyAdjustBalance(piggy: currentPiggy),
                );
                if (newPiggy == null) {
                  return;
                }
                setState(() {
                  currentPiggy = newPiggy.data;
                });
              },
              child: const Icon(Icons.price_change_outlined),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ],
    );
  }
}

class PiggyAdjustBalance extends StatefulWidget {
  const PiggyAdjustBalance({
    super.key,
    required this.piggy,
  });

  final PiggyBankRead piggy;

  @override
  State<PiggyAdjustBalance> createState() => _PiggyAdjustBalanceState();
}

class _PiggyAdjustBalanceState extends State<PiggyAdjustBalance> {
  final TextEditingController _amountTextController = TextEditingController();
  TransactionTypeProperty _transactionType = TransactionTypeProperty.deposit;

  late double currentAmount;
  late String currentString;

  @override
  void initState() {
    super.initState();

    currentAmount =
        double.tryParse(widget.piggy.attributes.currentAmount ?? "") ?? 0;
    currentString = currentAmount
        .abs()
        .toStringAsFixed(widget.piggy.attributes.currencyDecimalPlaces ?? 2);
  }

  @override
  void dispose() {
    _amountTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text("Save/Spend Money"),
      clipBehavior: Clip.hardEdge,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                  "Current Balance: ${widget.piggy.attributes.currencySymbol}$currentString"),
              const SizedBox(height: 16),
              Row(
                children: <Widget>[
                  MaterialIconButton(
                    icon: _transactionType.icon,
                    foregroundColor: Colors.white,
                    backgroundColor: _transactionType.color,
                    onPressed: () {
                      setState(() {
                        if (_transactionType ==
                            TransactionTypeProperty.deposit) {
                          _transactionType = TransactionTypeProperty.withdrawal;
                        } else {
                          _transactionType = TransactionTypeProperty.deposit;
                        }
                      });
                    },
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: NumberInput(
                      controller: _amountTextController,
                      hintText: "0.00",
                      decimals:
                          widget.piggy.attributes.currencyDecimalPlaces ?? 2,
                      prefixText: "${widget.piggy.attributes.currencyCode} ",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
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
            FilledButton(
              onPressed: () async {
                final FireflyIii? api = FireflyProvider.of(context).api;
                final NavigatorState nav = Navigator.of(context);

                double amount =
                    double.tryParse(_amountTextController.text) ?? 0;
                if (amount == 0) {
                  nav.pop();
                }
                if (_transactionType == TransactionTypeProperty.withdrawal) {
                  amount *= -1;
                }
                final double totalAmount = currentAmount + amount;
                if (api == null) {
                  throw Exception("Can't get API instance");
                }
                final Response<PiggyBankSingle> resp =
                    await api.v1PiggyBanksIdPut(
                  id: widget.piggy.id,
                  body: PiggyBankUpdate(
                    currentAmount: totalAmount.toStringAsFixed(
                        widget.piggy.attributes.currencyDecimalPlaces ?? 2),
                  ),
                );
                if (!resp.isSuccessful || resp.body == null) {
                  late String error;
                  try {
                    ValidationError valError = ValidationError.fromJson(
                        json.decode(resp.error.toString()));
                    error = valError.message ?? "Unknown error.";
                  } catch (e) {
                    error = "Unknown error.";
                  }

                  if (context.mounted) {
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        icon: const Icon(Icons.error),
                        title: const Text("Error"),
                        clipBehavior: Clip.hardEdge,
                        actions: <Widget>[
                          FilledButton(
                            child: const Text('Dismiss'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                        content: Text(error),
                      ),
                    );
                  }
                  return;
                }
                nav.pop(resp.body);
              },
              child: const Text("Save"),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ],
    );
  }
}
