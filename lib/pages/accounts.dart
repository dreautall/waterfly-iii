import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'package:chopper/chopper.dart' show Response;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/pages/home/accounts/row.dart';
import 'package:waterflyiii/pages/home/accounts/search.dart';
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
      context.read<NavPageElements>().appBarBottom = TabBar(
        isScrollable: true,
        controller: _tabController,
        tabs: <Tab>[
          Tab(text: S.of(context).accountsLabelAsset),
          Tab(text: S.of(context).accountsLabelExpense),
          Tab(text: S.of(context).accountsLabelRevenue),
          Tab(text: S.of(context).accountsLabelLiabilities),
        ],
      );
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
    firstPageKey: 1,
    invisibleItemsThreshold: 10,
  );

  final Logger log = Logger("Pages.Accounts.Details");

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener((int pageKey) {
      _fetchPage(pageKey);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NavPageElements>().appBarActions = <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          tooltip: MaterialLocalizations.of(context).searchFieldLabel,
          onPressed: () {
            log.finest(() => "pressed search button");
            Navigator.of(context).push(
              CupertinoPageRoute<bool>(
                builder: (BuildContext context) => AccountSearch(
                  type: widget.accountType,
                ),
                fullscreenDialog: false,
              ),
            );
          },
        ),
      ];
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
          itemBuilder: accountRowBuilder,
        ),
      ),
    );
  }
}
