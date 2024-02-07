import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'package:chopper/chopper.dart' show Response;

import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/pages/home/transactions.dart';
import 'package:waterflyiii/services/firefly_api_service.dart';

class HomeBalance extends StatefulWidget {
  const HomeBalance({
    super.key,
  });

  @override
  State<HomeBalance> createState() => _HomeBalanceState();
}

class _HomeBalanceState extends State<HomeBalance>
    with AutomaticKeepAliveClientMixin {
  final Logger log = Logger("Pages.Home.Balance");

  Future<AccountArray> _fetchAccounts() async {
    final FireflyIii api = context.read<FireflyService>().api;

    final Response<AccountArray> respAccounts =
        await api.v1AccountsGet(type: AccountTypeFilter.assetAccount);

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

    return Future<AccountArray>.value(respAccounts.body);
  }

  Future<void> _refreshStats() async {
    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    log.finest(() => "build()");

    return RefreshIndicator(
      onRefresh: _refreshStats,
      child: FutureBuilder<AccountArray>(
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
                    if (!(account.attributes.active ?? false)) {
                      return const SizedBox.shrink();
                    }
                    final double balance =
                        double.parse(account.attributes.currentBalance ?? "");
                    final CurrencyRead currency = CurrencyRead(
                      id: account.attributes.currencyId ?? "",
                      type: "currencies",
                      attributes: Currency(
                        code: account.attributes.currencyCode ?? "",
                        name: "",
                        symbol: account.attributes.currencySymbol ?? "",
                        decimalPlaces: account.attributes.currencyDecimalPlaces,
                      ),
                    );

                    return OpenContainer(
                      openBuilder:
                          (BuildContext context, Function closedContainer) =>
                              Scaffold(
                        appBar: AppBar(
                          title: Text(account.attributes.name),
                        ),
                        body: HomeTransactions(accountId: account.id),
                      ),
                      openColor: Theme.of(context).cardColor,
                      closedColor: Theme.of(context).cardColor,
                      closedShape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                        ),
                      ),
                      closedElevation: 0,
                      closedBuilder:
                          (BuildContext context, Function openContainer) =>
                              ListTile(
                        title: Text(account.attributes.name),
                        subtitle: Text(account.attributes.accountRole
                                ?.friendlyName(context) ??
                            S.of(context).generalUnknown),
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
                                text: currency.fmt(balance),
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
                                text: account.attributes.currentBalanceDate !=
                                        null
                                    ? DateFormat.yMd().add_Hms().format(account
                                        .attributes.currentBalanceDate!
                                        .toLocal())
                                    : S.of(context).generalNever,
                              ),
                            ],
                          ),
                        ),
                        onTap: () => openContainer(),
                      ),
                    );
                  },
                ),
              ],
            );
          } else if (snapshot.hasError) {
            log.severe(
                "error fetching accounts", snapshot.error, snapshot.stackTrace);
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
