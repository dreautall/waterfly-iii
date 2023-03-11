import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/transactions.dart';
import 'package:waterflyiii/pages/home_transactions.dart';
import 'package:waterflyiii/swagger_fireflyiii_api/firefly_iii.swagger.dart';

class HomeBalance extends StatefulWidget {
  const HomeBalance({
    super.key,
  });

  @override
  State<HomeBalance> createState() => _HomeBalanceState();
}

class _HomeBalanceState extends State<HomeBalance>
    with AutomaticKeepAliveClientMixin {
  Future<AccountArray> _fetchAccounts() async {
    final api = FireflyProvider.of(context).api;
    if (api == null) {
      throw Exception("API unavailable");
    }

    final respAccounts =
        await api.apiV1AccountsGet(type: AccountTypeFilter.assetAccount);

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
    print("home_balance build()");

    return RefreshIndicator(
      onRefresh: _refreshStats,
      child: FutureBuilder(
        future: _fetchAccounts(),
        builder: (BuildContext context, AsyncSnapshot<AccountArray> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return ListView(
              cacheExtent: 1000,
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                ...snapshot.data!.data.map(
                  (AccountRead account) {
                    final double balance =
                        double.parse(account.attributes.currentBalance ?? "");
                    final String balanceString = balance.abs().toStringAsFixed(
                        account.attributes.currencyDecimalPlaces ?? 2);
                    if (!(account.attributes.active ?? false)) {
                      return const SizedBox();
                    }
                    return ListTile(
                      title: Text(account.attributes.name),
                      subtitle:
                          Text(account.attributes.accountRole!.friendlyName),
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
                                  "${(balance < 0) ? '-' : ''}${account.attributes.currencySymbol}$balanceString",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                color:
                                    (balance < 0) ? Colors.red : Colors.green,
                                fontWeight: FontWeight.bold,
                                fontFeatures: const <FontFeature>[
                                  FontFeature.tabularFigures()
                                ],
                              ),
                            ),
                            const TextSpan(text: "\n"),
                            TextSpan(
                              text:
                                  account.attributes.currentBalanceDate != null
                                      ? DateFormat.yMd().add_Hms().format(
                                          account.attributes.currentBalanceDate!
                                              .toLocal())
                                      : "never",
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => Dialog.fullscreen(
                            child: Scaffold(
                              appBar: AppBar(
                                title: Text(account.attributes.name),
                              ),
                              body: HomeTransactions(accountId: account.id),
                            ),
                          ),
                        );
                      },
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
