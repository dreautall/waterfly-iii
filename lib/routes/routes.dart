import 'package:flutter_sharing_intent/model/sharing_file.dart';
import 'package:kaisel/kaisel.dart';
import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart'
    show TransactionRead;
import 'package:waterflyiii/notificationlistener.dart';

abstract interface class NavigableRoute {
  String label(BuildContext context);

  Widget get icon;

  Widget get selectedIcon;
}

sealed class AppRoute extends KaiselRoute {
  const AppRoute();
}

// Full-Page Overlay Screens (outside normal app)
final class SplashRoute extends AppRoute {
  const SplashRoute();
}

final class LoginRoute extends AppRoute {
  const LoginRoute();
}

final class LockRoute extends AppRoute {
  const LockRoute(this.onSuccess);

  final VoidCallback onSuccess;

  @override
  List<Object?> get props => <Object?>[onSuccess];
}

// Main App Tabs
final class NavigatorRoute extends AppRoute {
  const NavigatorRoute();
}

sealed class DashboardRoute extends NavigatorRoute implements NavigableRoute {
  const DashboardRoute();

  @override
  Widget get icon => const Icon(Icons.dashboard);

  @override
  Widget get selectedIcon => const Icon(Icons.dashboard_outlined);

  @override
  String label(BuildContext context) => S.of(context).navigationMain;
}

sealed class AccountsRoute extends NavigatorRoute implements NavigableRoute {
  const AccountsRoute();

  @override
  Widget get icon => const Icon(Icons.account_balance);

  @override
  Widget get selectedIcon => const Icon(Icons.account_balance_outlined);

  @override
  String label(BuildContext context) => S.of(context).navigationAccounts;
}

sealed class CategoriesRoute extends NavigatorRoute implements NavigableRoute {
  const CategoriesRoute();

  @override
  Widget get icon => const Icon(Icons.assignment);

  @override
  Widget get selectedIcon => const Icon(Icons.assignment_outlined);

  @override
  String label(BuildContext context) => S.of(context).navigationCategories;
}

sealed class BillsRoute extends NavigatorRoute implements NavigableRoute {
  const BillsRoute();

  @override
  Widget get icon => const Icon(Icons.receipt_long);

  @override
  Widget get selectedIcon => const Icon(Icons.receipt_outlined);

  @override
  String label(BuildContext context) => S.of(context).navigationBills;
}

// SettingsRoute is "faked", it does not extend on the Navigator since it is
// pushed on top instead of opening via the drawer.
final class SettingsRoute extends NavigatorRoute implements NavigableRoute {
  const SettingsRoute();

  @override
  Widget get icon => const Icon(Icons.settings);

  @override
  Widget get selectedIcon => const Icon(Icons.settings_outlined);

  @override
  String label(BuildContext context) => S.of(context).generalSettings;
}

// DashboardRoute screens
final class DashboardRouter extends DashboardRoute {
  const DashboardRouter();
}

final class MainDashboardView extends DashboardRouter {
  const MainDashboardView();
}

final class TransactionsView extends DashboardRouter {
  const TransactionsView();
}

final class BalanceView extends DashboardRouter {
  const BalanceView();
}

final class PiggyView extends DashboardRouter {
  const PiggyView();
}

// AccountsRoute screens
final class AccountsView extends AccountsRoute {
  const AccountsView();
}

// CategoriesRoute screens
final class CategoriesView extends CategoriesRoute {
  const CategoriesView();
}

// BillsRoute screens
final class BillsView extends BillsRoute {
  const BillsView();
}

// Detail Screens
final class TransactionDetail extends AppRoute {
  const TransactionDetail({
    this.transaction,
    this.notification,
    this.files,
    this.clone = false,
    this.accountId,
  });

  final TransactionRead? transaction;
  final NotificationTransaction? notification;
  final List<SharedFile>? files;
  final bool clone;
  final String? accountId;

  @override
  List<Object?> get props => <Object?>[
    transaction,
    notification,
    files,
    clone,
    accountId,
  ];
}
