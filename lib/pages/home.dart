import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'package:waterflyiii/pages/home/balance.dart';
import 'package:waterflyiii/pages/home/main.dart';
import 'package:waterflyiii/pages/home/piggybank.dart';
import 'package:waterflyiii/pages/home/transactions.dart';
import 'package:waterflyiii/pages/navigation.dart';
import 'package:waterflyiii/pages/transaction.dart';

final Logger log = Logger("Pages.Home");

class PageActions extends ChangeNotifier {
  final Map<Key, List<Widget>> _map = <Key, List<Widget>>{};
  List<Widget>? get(Key key) => _map[key];

  final Logger log = Logger("Pages.Home.PageActions");

  void set(Key key, List<Widget>? actions) {
    if (actions == null) {
      _map.remove(key);
    } else {
      _map[key] = actions;
    }
    log.finest("notify PageActions->set()");
    notifyListeners();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final Logger log = Logger("Pages.Home.Page");

  late TabController _tabController;
  late Widget _newTransactionFab;

  final PageActions _actions = PageActions();

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 4);
    _tabController.addListener(_handleTabChange);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _newTransactionFab = OpenContainer(
        openBuilder: (BuildContext context, Function closedContainer) {
          return const TransactionPage();
        },
        openColor: Theme.of(context).cardColor,
        closedColor: Theme.of(context).colorScheme.primaryContainer,
        closedShape: Theme.of(context).floatingActionButtonTheme.shape ??
            const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
        closedElevation:
            Theme.of(context).floatingActionButtonTheme.elevation ?? 6,
        closedBuilder: (BuildContext context, Function openContainer) {
          return FloatingActionButton(
            onPressed: () => openContainer(),
            tooltip: S.of(context).formButtonTransactionAdd,
            child: const Icon(Icons.add),
          );
        },
      );

      context.read<NavPageElements>().setAppBarBottom(TabBar(
            isScrollable: true,
            controller: _tabController,
            tabs: <Tab>[
              Tab(text: S.of(context).homeTabLabelMain),
              Tab(text: S.of(context).homeTabLabelTransactions),
              Tab(text: S.of(context).homeTabLabelBalance),
              Tab(text: S.of(context).homeTabLabelPiggybanks),
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
      log.finer("_handleTabChange(${_tabController.index})");
      context
          .read<NavPageElements>()
          .setFab((_tabController.index < 2) ? _newTransactionFab : null);
      context.read<NavPageElements>().setAppBarActions(
          _actions.get(tabPages[_tabController.index].key ?? const Key('')));
    }
  }

  late List<Tab> tabs;

  static const List<Widget> tabPages = <Widget>[
    HomeMain(key: Key("HomeMain")),
    HomeTransactions(key: Key("HomeTransactions")),
    HomeBalance(key: Key("HomeBalance")),
    HomePiggybank(key: Key("HomePiggybanks")),
  ];

  @override
  Widget build(BuildContext context) {
    log.finest("build(tab: ${_tabController.index})");
    return ChangeNotifierProvider<PageActions>.value(
      value: _actions,
      child: TabBarView(
        controller: _tabController,
        children: tabPages,
      ),
    );
  }
}
