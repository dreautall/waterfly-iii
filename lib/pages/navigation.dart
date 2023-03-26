import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/pages/home.dart';
import 'package:waterflyiii/pages/settings.dart';

class NavDestination {
  const NavDestination(
    this.label,
    this.pageHandler,
    this.icon,
    this.selectedIcon,
  );

  final String label;
  final Widget pageHandler;
  final Widget icon;
  final Widget selectedIcon;
}

class NavPageElements with ChangeNotifier {
  List<Widget>? appBarActions;
  PreferredSizeWidget? appBarBottom;
  Widget? fab;

  void setAppBarActions(List<Widget>? actions) {
    if (actions == appBarActions) {
      return;
    }
    appBarActions = actions;
    debugPrint("notify NavPageElements->setAppBarActions()");
    notifyListeners();
  }

  void setAppBarBottom(PreferredSizeWidget? bottom) {
    if (bottom == appBarBottom) {
      return;
    }
    appBarBottom = bottom;
    debugPrint("notify NavPageElements->setAppBarBottom()");
    notifyListeners();
  }

  void setFab(Widget? newFab) {
    if (newFab == fab) {
      return;
    }
    fab = newFab;
    debugPrint("notify NavPageElements->setFab()");
    notifyListeners();
  }
}

class NavPage extends StatefulWidget {
  const NavPage({Key? key}) : super(key: key);

  @override
  State<NavPage> createState() => NavPageState();
}

class NavPageState extends State<NavPage> with TickerProviderStateMixin {
  late TabController _tabController;

  int screenIndex = 0;

  late List<NavDestination> navDestinations;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    navDestinations = <NavDestination>[
      NavDestination(
        S.of(context).navigationMain,
        const HomePage(),
        const Icon(Icons.dashboard_outlined),
        const Icon(Icons.dashboard),
      ),
      NavDestination(
        S.of(context).navigationAccounts,
        const Placeholder(color: Colors.red, key: ValueKey<String>("accounts")),
        const Icon(Icons.account_balance_outlined),
        const Icon(Icons.account_balance),
      ),
      NavDestination(
        S.of(context).navigationSettings,
        const SettingsPage(),
        const Icon(Icons.settings_outlined),
        const Icon(Icons.settings),
      ),
    ];

    _tabController = TabController(vsync: this, length: navDestinations.length);
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NavDestination currentPage = navDestinations[screenIndex];
    debugPrint("nav build(), page $screenIndex");

    return ChangeNotifierProvider<NavPageElements>(
      create: (_) => NavPageElements(),
      builder: (BuildContext context, _) => Scaffold(
        appBar: AppBar(
          title: Text(currentPage.label),
          actions: context.select((NavPageElements n) => n.appBarActions),
          bottom: context.select((NavPageElements n) => n.appBarBottom),
        ),
        drawer: NavigationDrawer(
          selectedIndex: screenIndex,
          onDestinationSelected: (int index) {
            context.read<NavPageElements>().setAppBarActions(null);
            context.read<NavPageElements>().setAppBarBottom(null);
            context.read<NavPageElements>().setFab(null);
            setState(() {
              screenIndex = index;
            });
            Navigator.pop(context); // closes the drawer
          },
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
              child: Text(
                'Waterfly III',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            ...navDestinations.map((NavDestination destination) {
              return NavigationDrawerDestination(
                label: Text(destination.label),
                icon: destination.icon,
                selectedIcon: destination.selectedIcon,
              );
            }),
            const Divider(indent: 28, endIndent: 28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
              child: GestureDetector(
                onTap: () {
                  context.read<FireflyService>().signOut();
                },
                child: Text(
                  S.of(context).formButtonLogout,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            )
          ],
        ),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          reverseDuration: const Duration(milliseconds: 200),
          switchInCurve: const Cubic(0.05, 0.7, 0.1, 1.0),
          switchOutCurve: const Cubic(0.3, 0.0, 0.8, 0.15),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: const Offset(0, 0),
              ).animate(animation),
              child: child,
            );
          },
          child: currentPage.pageHandler,
        ),
        floatingActionButton: context.select((NavPageElements n) => n.fab),
      ),
    );
  }
}
