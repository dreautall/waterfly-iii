import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/swagger_fireflyiii_api/firefly_iii.swagger.dart';

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
                    final double balance =
                        double.parse(piggy.attributes.currentAmount ?? "");
                    final String balanceString = balance.abs().toStringAsFixed(
                        piggy.attributes.currencyDecimalPlaces ?? 2);
                    final double targetAmount =
                        double.parse(piggy.attributes.targetAmount ?? "");
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
                                      "${(balance < 0) ? '-' : ''}${piggy.attributes.currencySymbol}$balanceString",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                    color: (balance < 0)
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
                                            "${(piggy.attributes.percentage ?? 0).round()}% of ${piggy.attributes.currencySymbol}$targetAmount")
                                    : const TextSpan(),
                              ],
                            ),
                          ),
                          onTap: () {
                            // Piggybank Chart Dialog!
                            /*showDialog(
                          context: context,
                          builder: (BuildContext context) => Dialog.fullscreen(
                            child: Scaffold(
                              appBar: AppBar(
                                title: Text(piggy.attributes.name),
                              ),
                              body: :TODO:,
                            ),
                          ),
                        );*/
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
