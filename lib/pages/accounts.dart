import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:chopper/chopper.dart' show Response;

import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/pages/navigation.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({
    super.key,
  });

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 4);
    _tabController.addListener(_handleTabChange);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NavPageElements>().setAppBarBottom(TabBar(
            isScrollable: true,
            controller: _tabController,
            tabs: <Tab>[
              Tab(text: S.of(context).accountsLabelAsset),
              Tab(text: S.of(context).accountsLabelExpense),
              Tab(text: S.of(context).accountsLabelRevenue),
              Tab(text: S.of(context).accountsLabelLiabilities),
            ],
          ));
      // Call once to set fab/page actions
      _handleTabChange();
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();

    super.dispose();
  }

  void _handleTabChange() {
    if (!_tabController.indexIsChanging) {
      debugPrint("_handleTabChange()");
    }
  }

  late List<Tab> tabs;

  static const List<Widget> tabPages = <Widget>[
    AccountDetails(accountType: AccountTypeFilter.asset),
    AccountDetails(accountType: AccountTypeFilter.expense),
    AccountDetails(accountType: AccountTypeFilter.revenue),
    AccountDetails(accountType: AccountTypeFilter.liabilities),
  ];

  @override
  Widget build(BuildContext context) {
    debugPrint("accounts build(), tab ${_tabController.index}");
    return TabBarView(
      controller: _tabController,
      children: tabPages,
    );
  }
}

class AccountDetails extends StatefulWidget {
  const AccountDetails({
    Key? key,
    required this.accountType,
  }) : super(key: key);

  final AccountTypeFilter accountType;

  @override
  State<AccountDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails>
    with AutomaticKeepAliveClientMixin {
  Future<AccountArray> _fetchData() async {
    final FireflyIii api = context.read<FireflyService>().api;

    final Response<AccountArray> respAccounts =
        await api.v1AccountsGet(type: widget.accountType);
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
    debugPrint("accounts_detail build()");

    return RefreshIndicator(
        onRefresh: () => _refreshStats(),
        child: FutureBuilder<AccountArray>(
          future: _fetchData(),
          builder:
              (BuildContext context, AsyncSnapshot<AccountArray> snapshot) {
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
              snapshot.data!.data.sort(
                (AccountRead a, AccountRead b) {
                  if (!(a.attributes.active ?? true)) {
                    return 1;
                  }
                  if (!(b.attributes.active ?? true)) {
                    return -1;
                  }
                  return a.attributes.order?.compareTo(
                        b.attributes.order ?? 0,
                      ) ??
                      0;
                },
              );
              return ListView(
                cacheExtent: 1000,
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  ...snapshot.data!.data.map(
                    (AccountRead account) {
                      late double currentAmount;
                      if (widget.accountType == AccountTypeFilter.liability) {
                        currentAmount = double.tryParse(
                                account.attributes.currentDebt ?? "") ??
                            0;
                      } else {
                        currentAmount = double.tryParse(
                                account.attributes.currentBalance ?? "") ??
                            0;
                      }
                      final CurrencyRead currency = CurrencyRead(
                        id: account.attributes.currencyId ?? "0",
                        type: "currencies",
                        attributes: Currency(
                          code: account.attributes.currencyCode ?? "",
                          name: "",
                          symbol: account.attributes.currencySymbol ?? "",
                          decimalPlaces:
                              account.attributes.currencyDecimalPlaces,
                        ),
                      );

                      late String subtitle;
                      switch (widget.accountType) {
                        case AccountTypeFilter.asset:
                          switch (account.attributes.accountRole) {
                            case AccountRoleProperty.cashwalletasset:
                              subtitle =
                                  S.of(context).accountRoleAssetCashWallet;
                              break;
                            case AccountRoleProperty.ccasset:
                              subtitle = S.of(context).accountRoleAssetCC;
                              break;
                            case AccountRoleProperty.defaultasset:
                              subtitle = S.of(context).accountRoleAssetDefault;
                              break;
                            case AccountRoleProperty.savingasset:
                              subtitle = S.of(context).accountRoleAssetSavings;
                              break;
                            case AccountRoleProperty.sharedasset:
                              subtitle = S.of(context).accountRoleAssetShared;
                              break;
                            default:
                              subtitle = "Unknown";
                          }
                          if (account.attributes.iban != null) {
                            subtitle += "\nIBAN: ${account.attributes.iban!}";
                          }
                          break;
                        case AccountTypeFilter.expense:
                          subtitle = account.attributes.iban ?? "";
                          break;
                        case AccountTypeFilter.revenue:
                          subtitle = account.attributes.iban ?? "";
                          break;
                        case AccountTypeFilter.liabilities:
                          switch (account.attributes.liabilityType) {
                            case LiabilityType.debt:
                              subtitle = S.of(context).liabilityTypeDebt;
                              break;
                            case LiabilityType.loan:
                              subtitle = S.of(context).liabilityTypeLoan;
                              break;
                            case LiabilityType.mortgage:
                              subtitle = S.of(context).liabilityTypeMortgage;
                              break;
                            default:
                              subtitle = "Unknown";
                          }
                          subtitle += "; ";
                          switch (account.attributes.liabilityDirection) {
                            case LiabilityDirection.credit:
                              subtitle +=
                                  S.of(context).liabilityDirectionCredit;
                              break;
                            case LiabilityDirection.debit:
                              subtitle += S.of(context).liabilityDirectionDebit;
                              break;
                            default:
                              subtitle = "Unknown";
                          }
                          break;
                        default:
                          subtitle = "Unknown";
                      }
                      return ListTile(
                        title: Text(account.attributes.name),
                        subtitle: Text(
                          subtitle,
                          maxLines: 2,
                        ),
                        isThreeLine: true,
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
                              const TextSpan(text: "\n"),
                              TextSpan(
                                text: DateFormat.yMd().format(account
                                        .attributes.currentBalanceDate
                                        ?.toLocal() ??
                                    DateTime.now().toLocal()),
                              ),
                            ],
                          ),
                        ),
                        enabled: account.attributes.active ?? true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                          ),
                        ),
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
        ));
  }
}
