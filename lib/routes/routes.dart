import 'dart:ui' show VoidCallback;

import 'package:flutter_sharing_intent/model/sharing_file.dart';
import 'package:kaisel/kaisel.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart'
    show TransactionRead;
import 'package:waterflyiii/notificationlistener.dart';

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
  List<Object?> get props => [onSuccess];
}

// Main App Tabs
final class DashboardRoute extends AppRoute {
  const DashboardRoute();
}

final class AccountsRoute extends AppRoute {
  const AccountsRoute();
}

final class CategoriesRoute extends AppRoute {
  const CategoriesRoute();
}

final class BillsRoute extends AppRoute {
  const BillsRoute();
}

final class SettingsRoute extends AppRoute {
  const SettingsRoute();
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
  List<Object?> get props => [
    transaction,
    notification,
    files,
    clone,
    accountId,
  ];
}
