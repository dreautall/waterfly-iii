import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'package:chopper/chopper.dart' show Response;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/pages/home/transactions.dart';
import 'package:waterflyiii/pages/navigation.dart';

final Logger log = Logger("Pages.Accounts");

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

  final Logger log = Logger("Pages.Accounts.Page");

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
      log.finer(() => "_handleTabChange(${_tabController.index})");
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
    log.fine(() => "build(tab: ${_tabController.index})");
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
  final int _numberOfItemsPerRequest = 50;
  final PagingController<int, AccountRead> _pagingController =
      PagingController<int, AccountRead>(
    firstPageKey: 0,
    invisibleItemsThreshold: 10,
  );

  final Logger log = Logger("Pages.Accounts.Details");

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener((int pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();

    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final FireflyIii api = context.read<FireflyService>().api;
      final Response<AccountArray> respAccounts = await api.v1AccountsGet(
        type: widget.accountType,
        page: pageKey,
      );
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

      final List<AccountRead> accountList = respAccounts.body!.data;
      final bool isLastPage = accountList.length < _numberOfItemsPerRequest;
      if (isLastPage) {
        _pagingController.appendLastPage(accountList);
      } else {
        final int nextPageKey = pageKey + 1;
        _pagingController.appendPage(accountList, nextPageKey);
      }
    } catch (e, stackTrace) {
      log.severe("_fetchPage($pageKey)", e, stackTrace);
      _pagingController.error = e;
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    log.fine(() => "build()");

    return RefreshIndicator(
      onRefresh: () => Future<void>.sync(() => _pagingController.refresh()),
      child: PagedListView<int, AccountRead>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<AccountRead>(
          itemBuilder: (BuildContext context, AccountRead account, int index) {
            late double currentAmount;
            if (widget.accountType == AccountTypeFilter.liability) {
              currentAmount =
                  double.tryParse(account.attributes.currentDebt ?? "") ?? 0;
            } else {
              currentAmount =
                  double.tryParse(account.attributes.currentBalance ?? "") ?? 0;
            }
            final CurrencyRead currency = CurrencyRead(
              id: account.attributes.currencyId ?? "0",
              type: "currencies",
              attributes: Currency(
                code: account.attributes.currencyCode ?? "",
                name: "",
                symbol: account.attributes.currencySymbol ?? "",
                decimalPlaces: account.attributes.currencyDecimalPlaces,
              ),
            );

            late String subtitle;
            switch (widget.accountType) {
              case AccountTypeFilter.asset:
                subtitle =
                    account.attributes.accountRole?.friendlyName(context) ??
                        S.of(context).generalUnknown;
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
                    subtitle = S.of(context).generalUnknown;
                }
                subtitle += "; ";
                switch (account.attributes.liabilityDirection) {
                  case LiabilityDirection.credit:
                    subtitle += S.of(context).liabilityDirectionCredit;
                    break;
                  case LiabilityDirection.debit:
                    subtitle += S.of(context).liabilityDirectionDebit;
                    break;
                  default:
                    subtitle = S.of(context).generalUnknown;
                }

                if (account.attributes.interest != null &&
                    account.attributes.interestPeriod != null) {
                  subtitle += "; ";
                  subtitle += S.of(context).accountsLiabilitiesInterest(
                        double.tryParse(
                              account.attributes.interest!,
                            ) ??
                            0,
                        account.attributes.interestPeriod!.value
                                ?.replaceAll('-', '') ??
                            "",
                      );
                }
                break;
              default:
                subtitle = S.of(context).generalUnknown;
            }
            return OpenContainer(
              openBuilder: (BuildContext context, Function closedContainer) =>
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
              closedBuilder: (BuildContext context, Function openContainer) =>
                  ListTile(
                title: Text(
                  account.attributes.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  subtitle,
                  maxLines: widget.accountType == AccountTypeFilter.asset ||
                          widget.accountType == AccountTypeFilter.liabilities
                      ? 2
                      : 1,
                ),
                isThreeLine: widget.accountType == AccountTypeFilter.asset ||
                    widget.accountType == AccountTypeFilter.liabilities,
                trailing: RichText(
                  textAlign: TextAlign.end,
                  maxLines: 2,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: <InlineSpan>[
                      TextSpan(
                        text: currency.fmt(currentAmount),
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                          color:
                              (currentAmount < 0) ? Colors.red : Colors.green,
                          fontWeight: FontWeight.bold,
                          fontFeatures: const <FontFeature>[
                            FontFeature.tabularFigures()
                          ],
                        ),
                      ),
                      const TextSpan(text: "\n"),
                      TextSpan(
                        text: account.attributes.currentBalanceDate != null
                            ? DateFormat.yMd().add_Hms().format(account
                                .attributes.currentBalanceDate!
                                .toLocal())
                            : S.of(context).generalNever,
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
                onTap: () => openContainer(),
              ),
            );
          },
        ),
      ),
    );
  }
}
