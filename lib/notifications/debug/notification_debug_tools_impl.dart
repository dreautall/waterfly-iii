import 'package:waterflyiii/notifications/debug/notification_debug_seed_service.dart';
import 'package:waterflyiii/notifications/debug/notification_debug_test_lab_page.dart';
import 'package:waterflyiii/notifications/debug/notification_debug_tools.dart';
import 'package:waterflyiii/notifications/notification_feature_scope.dart';

NotificationDebugTools createNotificationDebugTools(
  NotificationFeatureScope scope,
) => _NotificationDebugToolsImpl(scope);

class _NotificationDebugToolsImpl implements NotificationDebugTools {
  const _NotificationDebugToolsImpl(this._scope);

  final NotificationFeatureScope _scope;

  @override
  NotificationDebugTestLabPage buildTestLabPage() =>
      NotificationDebugTestLabPage(
        scope: _scope,
        seedService: NotificationDebugSeedService(
          definitionStore: _scope.definitionStore,
          alertStore: _scope.alertStore,
          historyStore: _scope.historyStore,
        ),
      );
}
