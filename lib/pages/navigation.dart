import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/pages/accounts.dart';
import 'package:waterflyiii/pages/home.dart';
import 'package:waterflyiii/pages/settings.dart';

final Logger log = Logger("Pages.Navigation");

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
      log.finer(() => "NavPageElements->setAppBarActions equal, skipping");
      return;
    }
    appBarActions = actions;
    log.finest(() => "notify NavPageElements->setAppBarActions()");
    notifyListeners();
  }

  void setAppBarBottom(PreferredSizeWidget? bottom) {
    if (bottom == appBarBottom) {
      log.finer(() => "NavPageElements->setAppBarBottom equal, skipping");
      return;
    }
    appBarBottom = bottom;
    log.finest(() => "notify NavPageElements->setAppBarBottom()");
    notifyListeners();
  }

  void setFab(Widget? newFab) {
    if (newFab == fab) {
      log.finer(() => "NavPageElements->setFab equal, skipping");
      return;
    }
    fab = newFab;
    log.finest(() => "notify NavPageElements->setFab()");
    notifyListeners();
  }
}

class NavPage extends StatefulWidget {
  const NavPage({Key? key}) : super(key: key);

  @override
  State<NavPage> createState() => NavPageState();
}

class NavPageState extends State<NavPage> with TickerProviderStateMixin {
  final Logger log = Logger("Pages.Navigation.Page");

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
        const AccountsPage(),
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
    log.finest(() => "nav build(page: $screenIndex)");

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
                onTap: () async {
                  final FireflyService ff = context.read<FireflyService>();
                  bool? ok = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) =>
                        const LogoutConfirmDialog(),
                  );
                  if (!(ok ?? false)) {
                    return;
                  }

                  ff.signOut();
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
          duration: const Duration(milliseconds: 100),
          switchInCurve: animCurveStandard,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: Tween<double>(
                begin: 0,
                end: 1,
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

class LogoutConfirmDialog extends StatelessWidget {
  const LogoutConfirmDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.logout),
      title: Text(S.of(context).formButtonLogout),
      clipBehavior: Clip.hardEdge,
      actions: <Widget>[
        TextButton(
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FilledButton(
          child: Text(S.of(context).formButtonLogout),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
      content: Text(S.of(context).logoutConfirmation),
    );
  }
}
