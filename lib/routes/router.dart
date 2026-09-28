import 'package:flutter_sharing_intent/model/sharing_file.dart';
import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.models.swagger.dart';
import 'package:waterflyiii/notificationlistener.dart';
import 'package:waterflyiii/pages/lock.dart' show LockPage;
import 'package:waterflyiii/pages/login.dart' show LoginPage;
import 'package:waterflyiii/pages/splash.dart';
import 'package:waterflyiii/pages/transaction.dart' show TransactionPage;
import 'package:waterflyiii/routes/routes.dart';

Widget buildScreen(BuildContext context, AppRoute route) => switch (route) {
  SplashRoute() => const SplashPage(),
  LoginRoute() => const LoginPage(),
  LockRoute(:final VoidCallback onSuccess) => LockPage(onSuccess: onSuccess),
  DashboardRoute() => throw UnimplementedError(),
  AccountsRoute() => throw UnimplementedError(),
  CategoriesRoute() => throw UnimplementedError(),
  BillsRoute() => throw UnimplementedError(),
  SettingsRoute() => throw UnimplementedError(),
  TransactionDetail(
    :final TransactionRead? transaction,
    :final NotificationTransaction? notification,
    :final List<SharedFile>? files,
    :final bool clone,
    :final String? accountId,
  ) =>
    TransactionPage(
      transaction: transaction,
      notification: notification,
      files: files,
      clone: clone,
      accountId: accountId,
    ),
};
