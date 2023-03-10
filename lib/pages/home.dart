import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:waterflyiii/pages/navigation.dart';
import 'package:waterflyiii/pages/home_main.dart';
import 'package:waterflyiii/pages/home_transactions.dart';
import 'package:waterflyiii/pages/home_balance.dart';
import 'package:waterflyiii/pages/home_piggybank.dart';
import 'package:waterflyiii/pages/transaction_detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Widget _newTransactionFab;

  final Map<Key, List<Widget>> _actionsMap = <Key, List<Widget>>{};

  List<Widget>? getActions(Key key) => _actionsMap[key];

  void setActions(Key key, List<Widget> actions) {
    _actionsMap[key] = actions;
    if (key == tabPages[_tabController.index].key) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        NavPageScaffold navScaffold = NavPageScaffold.of(context);
        navScaffold.data.setState(() {
          navScaffold.data.appBarActions = actions;
        });
      });
    }
  }

  void disposeActions(Key key) {
    _actionsMap.remove(key);
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 4);
    _tabController.addListener(_handleTabChange);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _newTransactionFab = FloatingActionButton(
        onPressed: () => showDialog<void>(
          context: context,
          builder: (BuildContext context) => const Dialog.fullscreen(
            child: TransactionPage(),
          ),
        ),
        tooltip: S.of(context).formButtonTransactionAdd,
        child: const Icon(Icons.add),
      );

      NavPageScaffold navScaffold = NavPageScaffold.of(context);
      navScaffold.data.setState(() {
        navScaffold.data.appBarBottom = TabBar(
          isScrollable: true,
          controller: _tabController,
          tabs: <Tab>[
            Tab(text: S.of(context).homeTabLabelMain),
            Tab(text: S.of(context).homeTabLabelTransactions),
            Tab(text: S.of(context).homeTabLabelBalance),
            Tab(text: S.of(context).homeTabLabelPiggybanks),
          ],
        );
        navScaffold.data.appBarActions =
            getActions(tabPages[_tabController.index].key ?? const Key(''));
        navScaffold.data.fab = _newTransactionFab;
      });
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
      NavPageScaffold navScaffold = NavPageScaffold.of(context);
      navScaffold.data.setState(() {
        navScaffold.data.fab =
            (_tabController.index < 2) ? _newTransactionFab : null;
        navScaffold.data.appBarActions =
            getActions(tabPages[_tabController.index].key ?? const Key(''));
      });
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
    debugPrint("home build(), tab ${_tabController.index}");
    return HomePageInheritedState(
      data: this,
      child: TabBarView(
        controller: _tabController,
        children: tabPages,
      ),
    );
  }
}

class HomePageInheritedState extends InheritedWidget {
  const HomePageInheritedState({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  final HomePageState data;

  static HomePageInheritedState? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<HomePageInheritedState>();
  }

  static HomePageInheritedState of(BuildContext context) {
    final HomePageInheritedState? result = maybeOf(context);
    assert(result != null, 'No HomePageInheritedState found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(HomePageInheritedState oldWidget) =>
      data != oldWidget.data;
}
