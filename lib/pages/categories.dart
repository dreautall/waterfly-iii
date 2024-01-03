import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'package:waterflyiii/pages/navigation.dart';

final Logger log = Logger("Pages.Categories");

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({
    super.key,
  });

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Logger log = Logger("Pages.Categories.Page");

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(_handleTabChange);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NavPageElements>().appBarBottom = TabBar(
        isScrollable: true,
        controller: _tabController,
        tabAlignment: TabAlignment.start,
        tabs: const <Tab>[
          Tab(text: "Expense Categories"),
          Tab(text: "Income Categories"),
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

  final List<Widget> _tabPages = <Widget>[
    const Placeholder(),
    const Placeholder(),
  ];

  @override
  Widget build(BuildContext context) {
    log.fine(() => "build(tab: ${_tabController.index})");
    return TabBarView(
      controller: _tabController,
      children: _tabPages,
    );
  }
}
