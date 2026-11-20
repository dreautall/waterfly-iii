import 'package:waterflyiii/main.dart' as application;
import 'package:waterflyiii/notifications/debug/notification_debug_tools_impl.dart';

Future<void> main() => application.runWaterflyApp(
  notificationDebugToolsFactory: createNotificationDebugTools,
);
