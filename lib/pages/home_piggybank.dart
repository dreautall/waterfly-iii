import 'dart:convert';
import 'dart:ui';

import 'package:chopper/chopper.dart' show Response;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:waterflyiii/animations.dart';
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
    final FireflyIii api = context.read<FireflyService>().api;

    final Response<PiggyBankArray> respAccounts = await api.v1PiggyBanksGet();

    if (!respAccounts.isSuccessful || respAccounts.body == null) {
      if (context.mounted) {
        throw Exception(
          S
              .of(context)
              .errorAPIInvalidResponse(respAccounts.error?.toString() ?? ""),
        );
      } else {
        throw Exception(
          "[nocontext] Invalid API response: ${respAccounts.error}",
        );
      }
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
                      S.of(context).homePiggyNoAccounts,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Icon(
                      Icons.savings_outlined,
                      size: 200,
                    ),
                    Text(
                      S.of(context).homePiggyNoAccountsSubtitle,
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
                    final CurrencyRead currency = CurrencyRead(
                      id: piggy.attributes.currencyId ?? "0",
                      type: "currencies",
                      attributes: Currency(
                        code: piggy.attributes.currencyCode ?? "",
                        name: "",
                        symbol: piggy.attributes.currencySymbol ?? "",
                        decimalPlaces: piggy.attributes.currencyDecimalPlaces,
                      ),
                    );
                    final double targetAmount =
                        double.tryParse(piggy.attributes.targetAmount ?? "") ??
                            0;
                    if (!(piggy.attributes.active ?? false)) {
                      return const SizedBox.shrink();
                    }
                    return Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(piggy.attributes.name),
                          subtitle: (piggy.attributes.accountName != null)
                              ? Text(S.of(context).homePiggyLinked(
                                  piggy.attributes.accountName!))
                              : const Text(""),
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
                                  text: currency.fmt(currentAmount),
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
                                        text: S.of(context).numPercentOf(
                                              (piggy.attributes.percentage ??
                                                      0) /
                                                  100,
                                              currency.fmt(targetAmount),
                                            ))
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
    final FireflyIii api = context.read<FireflyService>().api;

    final Response<PiggyBankEventArray> resp =
        await api.v1PiggyBanksIdEventsGet(id: currentPiggy.id);
    if (!resp.isSuccessful || resp.body == null) {
      if (context.mounted) {
        throw Exception(
          S.of(context).errorAPIInvalidResponse(resp.error?.toString() ?? ""),
        );
      } else {
        throw Exception(
          "[nocontext] Invalid API response: ${resp.error}",
        );
      }
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
    final double targetAmount =
        double.tryParse(currentPiggy.attributes.targetAmount ?? "") ?? 0;
    final double leftAmount =
        double.tryParse(currentPiggy.attributes.leftToSave ?? "") ?? 0;
    final DateTime? startDate = currentPiggy.attributes.startDate?.toLocal();
    final DateTime? targetDate = currentPiggy.attributes.targetDate?.toLocal();
    final CurrencyRead currency = CurrencyRead(
      id: currentPiggy.attributes.currencyId ?? "0",
      type: "currencies",
      attributes: Currency(
        code: currentPiggy.attributes.currencyCode ?? "",
        name: "",
        symbol: currentPiggy.attributes.currencySymbol ?? "",
        decimalPlaces: currentPiggy.attributes.currencyDecimalPlaces,
      ),
    );

    String infoText = "";

    if (targetAmount != 0) {
      infoText += S.of(context).homePiggyTarget(currency.fmt(targetAmount));
      infoText += "\n";
    }
    infoText += S.of(context).homePiggySaved(currency.fmt(currentAmount));
    infoText += "\n";
    if (leftAmount != 0) {
      infoText += S.of(context).homePiggyRemaining(currency.fmt(leftAmount));
      infoText += "\n";
    }
    if (startDate != null) {
      infoText += S.of(context).homePiggyDateStart(startDate);
      infoText += "\n";
    }
    if (targetDate != null) {
      infoText += S.of(context).homePiggyDateTarget(targetDate);
      infoText += "\n";
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
        AnimatedHeight(
          child: FutureBuilder<List<PiggyBankEventRead>>(
              future: _fetchChart(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<PiggyBankEventRead>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                      child: Text(S.of(context).homeTransactionsEmpty),
                    );
                  }
                  final List<charts.Series<TimeSeriesChart, DateTime>>
                      chartData = <charts.Series<TimeSeriesChart, DateTime>>[];
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
                      tickProviderSpec:
                          const charts.BasicNumericTickProviderSpec(
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
                      tickProviderSpec:
                          const charts.AutoDateTimeTickProviderSpec(
                              includeTime: false),
                      renderSpec: charts.SmallTickRendererSpec<DateTime>(
                        labelStyle: charts.TextStyleSpec(
                          color: charts.ColorUtil.fromDartColor(
                              Theme.of(context).colorScheme.onSurfaceVariant),
                        ),
                      ),
                    ),
                    defaultRenderer: charts.LineRendererConfig<DateTime>(
                        includePoints: true),
                    behaviors: targetAmount != 0
                        ? <charts.ChartBehavior<DateTime>>[
                            charts.RangeAnnotation<DateTime>(
                              <charts.LineAnnotationSegment<num>>[
                                charts.LineAnnotationSegment<num>(
                                  targetAmount,
                                  charts.RangeAnnotationAxisType.measure,
                                  color: charts
                                      .MaterialPalette.deepOrange.shadeDefault,
                                  labelAnchor:
                                      charts.AnnotationLabelAnchor.start,
                                  startLabel: S.of(context).generalTarget,
                                  labelStyleSpec: charts.TextStyleSpec(
                                    color: charts.ColorUtil.fromDartColor(
                                        Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant),
                                  ),
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
        ),
        OverflowBar(
          alignment: MainAxisAlignment.end,
          children: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: Text(S.of(context).formButtonClose),
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
  late CurrencyRead currency;

  @override
  void initState() {
    super.initState();

    currentAmount =
        double.tryParse(widget.piggy.attributes.currentAmount ?? "") ?? 0;
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
  }

  @override
  void dispose() {
    _amountTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(S.of(context).homePiggyAdjustDialogTitle),
      clipBehavior: Clip.hardEdge,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(S.of(context).homePiggySaved(currency.fmt(currentAmount))),
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
                      decimals: currency.attributes.decimalPlaces ?? 2,
                      prefixText: "${currency.attributes.code} ",
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
              child: Text(S.of(context).formButtonClose),
            ),
            const SizedBox(width: 12),
            FilledButton(
              onPressed: () async {
                final FireflyIii api = context.read<FireflyService>().api;
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
                debugPrint(
                    "New piggy bank total = $totalAmount out of $currentAmount + $amount");
                final Response<PiggyBankSingle> resp =
                    await api.v1PiggyBanksIdPut(
                  id: widget.piggy.id,
                  body: PiggyBankUpdate(
                    currentAmount: totalAmount.toStringAsFixed(
                        currency.attributes.decimalPlaces ?? 2),
                  ),
                );
                if (!resp.isSuccessful || resp.body == null) {
                  late String error;
                  try {
                    ValidationError valError = ValidationError.fromJson(
                        json.decode(resp.error.toString()));
                    if (context.mounted) {
                      error = valError.message ?? S.of(context).errorUnknown;
                    } else {
                      error = "[nocontext] Unknown error";
                    }
                  } catch (e) {
                    if (context.mounted) {
                      error = S.of(context).errorUnknown;
                    } else {
                      error = "[nocontext] Unknown error.";
                    }
                  }

                  if (context.mounted) {
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        icon: const Icon(Icons.error),
                        title: Text(S.of(context).generalError),
                        clipBehavior: Clip.hardEdge,
                        actions: <Widget>[
                          FilledButton(
                            child: Text(S.of(context).generalDismiss),
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
              child: Text(S.of(context).formButtonSave),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ],
    );
  }
}
