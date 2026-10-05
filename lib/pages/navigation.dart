import 'package:animations/animations.dart';
import 'package:kaisel/kaisel.dart';
import 'package:logging/logging.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/layout.dart';
import 'package:waterflyiii/pages/accounts.dart';
import 'package:waterflyiii/pages/bills.dart';
import 'package:waterflyiii/pages/categories.dart';
import 'package:waterflyiii/pages/home.dart';
import 'package:waterflyiii/pages/settings.dart';
import 'package:waterflyiii/routes/routes.dart';

final Logger log = Logger("Pages.Navigation");

class NavDestination {
  const NavDestination(this.label, this.icon, this.selectedIcon);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

class NavPageElements with ChangeNotifier {
  NavPageElements(this.defaultTitle);
  final Widget defaultTitle;

  List<Widget>? _appBarActions;
  List<Widget>? get appBarActions => _appBarActions;
  set appBarActions(List<Widget>? value) {
    if (value == appBarActions) {
      log.finer(() => "NavPageElements->setAppBarActions equal, skipping");
      return;
    }
    _appBarActions = value;
    log.finest(() => "notify NavPageElements->setAppBarActions()");
    notifyListeners();
  }

  Widget? _appBarBottom;
  Widget? get appBarBottom => _appBarBottom;
  set appBarBottom(Widget? value) {
    if (value == appBarBottom) {
      log.finer(() => "NavPageElements->setAppBarBottom equal, skipping");
      return;
    }
    _appBarBottom = value;
    log.finest(() => "notify NavPageElements->setAppBarBottom()");
    notifyListeners();
  }

  Widget? _fab;
  Widget? get fab => _fab;
  set fab(Widget? value) {
    if (value == fab) {
      log.finer(() => "NavPageElements->setFab equal, skipping");
      return;
    }
    _fab = value;
    log.finest(() => "notify NavPageElements->setFab()");
    notifyListeners();
  }

  Widget? _appBarTitle;
  Widget get appBarTitle => _appBarTitle ?? defaultTitle;
  set appBarTitle(Widget value) {
    if (value == appBarTitle) {
      log.finer(() => "NavPageElements->setAppBarTitle equal, skipping");
      return;
    }
    _appBarTitle = value;
    log.finest(() => "notify NavPageElements->setAppBarTitle()");
    notifyListeners();
  }
}

class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => NavPageState();
}

class NavPageState extends State<NavPage> with TickerProviderStateMixin {
  final Logger log = Logger("Pages.Navigation.Page");

  late TabController _tabController;
  int screenIndex = 0;
  final List<NavigableRoute> navRoutes = <NavigableRoute>[
    const DashboardRouter(),
    const AccountsView(),
    const CategoriesView(),
    const BillsView(),
    const SettingsRoute(),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _tabController = TabController(vsync: this, length: navRoutes.length);
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  void navOnDestinationSelected(BuildContext context, int index) {
    if (screenIndex == index) {
      return;
    }
    /*if (navDestinations[index].pageHandler is SettingsPage) {
      // :TODO: implement
      //context.push(const SettingsRoute());
    } else {*/
    context.read<NavPageElements>().appBarActions = null;
    context.read<NavPageElements>().appBarBottom = null;
    context.read<NavPageElements>().fab = null;
    context.read<NavPageElements>().appBarTitle = Text(
      navRoutes[index].label(context),
    );

    screenIndex = index;
    //}
  }

  @override
  Widget build(BuildContext context) {
    return KaiselBranchedShell.specs(
      initialBranch: 0,
      branches: <KaiselBranchSpec<NavigatorRoute>>[
        KaiselBranchSpec<DashboardRoute>(
          initial: const DashboardRouter(),
          builder: (BuildContext context, DashboardRoute route) =>
              switch (route) {
                DashboardRouter() => const HomePage(),
              },
        ),
        KaiselBranchSpec<AccountsRoute>(
          initial: const AccountsView(),
          builder: (BuildContext context, AccountsRoute route) =>
              switch (route) {
                AccountsView() => const AccountsPage(),
              },
        ),
        KaiselBranchSpec<CategoriesRoute>(
          initial: const CategoriesView(),
          builder: (BuildContext context, CategoriesRoute route) =>
              switch (route) {
                CategoriesView() => const CategoriesPage(),
              },
        ),
        KaiselBranchSpec<BillsRoute>(
          initial: const BillsView(),
          builder: (BuildContext context, BillsRoute route) => switch (route) {
            BillsView() => const BillsPage(),
          },
        ),
        KaiselBranchSpec<SettingsRoute>(
          initial: const SettingsRoute(),
          builder: (BuildContext context, SettingsRoute route) =>
              switch (route) {
                SettingsRoute() => const SettingsPage(),
              },
        ),
      ],
      lazy: true,
      chromeBuilder:
          (
            BuildContext context,
            int activeBranch,
            Widget branchContent,
            Function(int) switchBranch,
          ) {
            final NavigableRoute currentPage = navRoutes[activeBranch];
            log.finest(() => "nav build(page: $activeBranch)");

            return ChangeNotifierProvider<NavPageElements>(
              create: (_) => NavPageElements(Text(navRoutes[0].label(context))),
              builder: (BuildContext context, _) => Scaffold(
                appBar: AppBar(
                  title: context.select((NavPageElements n) => n.appBarTitle),
                  actions: context.select(
                    (NavPageElements n) => n.appBarActions,
                  ),
                ),
                drawer: context.watch<LayoutProvider>().currentSize >= .medium
                    ? null
                    : NavigationDrawer(
                        selectedIndex: activeBranch,
                        onDestinationSelected: (int index) {
                          Navigator.of(context).pop();
                          if (index == 4) {
                            context.push(const SettingsRoute());
                            return;
                          }
                          switchBranch(index);
                          navOnDestinationSelected(context, index);
                        },
                        children: <Widget>[
                          Padding(
                            padding: const .symmetric(
                              horizontal: 28,
                              vertical: 16,
                            ),
                            child: Text(
                              'Waterfly III',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                          ...navRoutes.map(
                            (NavigableRoute destination) =>
                                NavigationDrawerDestination(
                                  label: Text(destination.label(context)),
                                  icon: destination.icon,
                                  selectedIcon: destination.selectedIcon,
                                ),
                          ),
                          const Divider(indent: 28, endIndent: 28),
                          Padding(
                            padding: const .symmetric(
                              horizontal: 28,
                              vertical: 16,
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                final FireflyService ff = context
                                    .read<FireflyService>();
                                final bool? ok = await showDialog<bool>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      const LogoutConfirmDialog(),
                                );
                                if (!(ok ?? false)) {
                                  return;
                                }

                                await ff.signOut();
                              },
                              child: Text(
                                S.of(context).formButtonLogout,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                body: Row(
                  children: <Widget>[
                    if (context.watch<LayoutProvider>().currentSize >= .medium)
                      NavigationRail(
                        selectedIndex: activeBranch,
                        labelType: NavigationRailLabelType.all,
                        minWidth: 80,
                        onDestinationSelected: (int index) =>
                            navOnDestinationSelected(context, index),
                        leading:
                            (context.watch<LayoutProvider>().currentSize >=
                                .expanded)
                            ? SizedBox(
                                height: 56,
                                child: AnimatedSwitcher(
                                  duration: animDurationEmphasizedDecelerate,
                                  switchInCurve: animCurveEmphasizedDecelerate,
                                  reverseDuration:
                                      animDurationEmphasizedAccelerate,
                                  switchOutCurve: animCurveEmphasizedAccelerate,
                                  child: context.select(
                                    (NavPageElements n) => n.fab,
                                  ),
                                ),
                              )
                            : null,
                        groupAlignment:
                            (context.watch<LayoutProvider>().currentSize >=
                                .expanded)
                            ? 0
                            : -1,
                        destinations: navRoutes.map((
                          NavigableRoute destination,
                        ) {
                          return NavigationRailDestination(
                            label: Text(destination.label(context)),
                            icon: destination.icon,
                            selectedIcon: destination.selectedIcon,
                          );
                        }).toList(),
                        trailingAtBottom: true,
                        trailing: GestureDetector(
                          onTap: () async {
                            final FireflyService ff = context
                                .read<FireflyService>();
                            final bool? ok = await showDialog<bool>(
                              context: context,
                              builder: (BuildContext context) =>
                                  const LogoutConfirmDialog(),
                            );
                            if (!(ok ?? false)) {
                              return;
                            }

                            await ff.signOut();
                          },
                          child: Text(
                            S.of(context).formButtonLogout,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                    Expanded(
                      child: PageTransitionSwitcher(
                        duration: animDurationStandard,
                        transitionBuilder:
                            (
                              Widget child,
                              Animation<double> primary,
                              Animation<double> secondary,
                            ) => FadeThroughTransition(
                              animation: primary,
                              secondaryAnimation: secondary,
                              child: child,
                            ),
                        child: Column(
                          key: ValueKey<String>(currentPage.label(context)),
                          children: <Widget>[
                            context.select(
                                  (NavPageElements n) => n.appBarBottom,
                                ) ??
                                const SizedBox.shrink(),
                            Expanded(child: branchContent),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                floatingActionButton:
                    context.watch<LayoutProvider>().currentSize >= .expanded
                    ? null
                    : context.select((NavPageElements n) => n.fab),
              ),
            );
          },
    );
  }
}

class LogoutConfirmDialog extends StatelessWidget {
  const LogoutConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.logout),
      title: Text(S.of(context).formButtonLogout),
      clipBehavior: .hardEdge,
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
