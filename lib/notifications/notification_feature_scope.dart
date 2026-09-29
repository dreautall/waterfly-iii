import 'package:waterflyiii/notifications/application/stores/notification_alert_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_definition_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_history_store.dart';
import 'package:waterflyiii/notifications/application/listeners/notification_listener_health_service.dart';
import 'package:waterflyiii/notifications/application/settings/notification_processing_settings.dart';
import 'package:waterflyiii/notifications/application/settings/notification_backup_file_gateway.dart';
import 'package:waterflyiii/notifications/application/history/recent_notification_history.dart';
import 'package:waterflyiii/notifications/application/listeners/notification_access_settings_launcher.dart';
import 'package:waterflyiii/notifications/application/listeners/notification_listener_status.dart';
import 'package:waterflyiii/notifications/application/definitions/save_notification_definition.dart';
import 'package:waterflyiii/notifications/application/rules/notification_rule_operations.dart';
import 'package:waterflyiii/notifications/application/resources/firefly_currency_resolver.dart';
import 'package:waterflyiii/notifications/data/listeners/platform_notification_access_settings_launcher.dart';
import 'package:waterflyiii/notifications/data/listeners/notification_listener_status_loader.dart';
import 'package:waterflyiii/notifications/data/listeners/platform_notification_listener_health_notifier.dart';
import 'package:waterflyiii/notifications/data/notification_store_bundle.dart';
import 'package:waterflyiii/notifications/data/platform/file_picker_notification_backup_file_gateway.dart';
import 'package:waterflyiii/notifications/data/platform/platform_notification_formatting_preferences.dart';
import 'package:waterflyiii/notifications/presentation/definitions/controllers/notification_definitions_view_model.dart';
import 'package:waterflyiii/notifications/presentation/alerts/controllers/notification_alerts_view_model.dart';
import 'package:waterflyiii/notifications/presentation/history/controllers/recent_notifications_view_model.dart';
import 'package:waterflyiii/notifications/presentation/health/controllers/notification_listener_health_view_model.dart';

class NotificationFeatureScope {
  const NotificationFeatureScope({
    required this.definitionStore,
    required this.alertStore,
    required this.historyStore,
    required this.settingsStore,
    required this.definitionsViewModel,
    required this.recentNotificationsViewModel,
    required this.alertsViewModel,
    required this.healthViewModel,
    required this.ruleOperations,
    required this.listenerStatusLoader,
    required this.accessSettingsLauncher,
    this.backupFileGateway = const UnavailableNotificationBackupFileGateway(),
  });

  factory NotificationFeatureScope.encrypted({
    FireflyCurrencyResolver? currencyResolver,
  }) {
    final NotificationStoreBundle stores = NotificationStoreBundle.encrypted(
      currencyResolver: currencyResolver,
    );
    final NotificationRuleOperations ruleOperations =
        NotificationRuleOperations(stores.definitionStore);
    final NotificationListenerHealthService healthService =
        NotificationListenerHealthService(
          store: stores.healthStore,
          definitionStore: stores.definitionStore,
          notifier: const PlatformNotificationListenerHealthNotifier(),
        );
    return NotificationFeatureScope(
      definitionStore: stores.definitionStore,
      alertStore: stores.alertStore,
      historyStore: stores.historyStore,
      settingsStore: stores.settingsStore,
      definitionsViewModel: NotificationDefinitionsViewModel(
        stores.definitionStore,
        SaveNotificationDefinition(
          stores.definitionStore,
          alertStore: stores.alertStore,
          historyStore: stores.historyStore,
        ),
        alertStore: stores.alertStore,
      ),
      recentNotificationsViewModel: RecentNotificationsViewModel(
        RecentNotificationHistory(
          stores.definitionStore,
          stores.alertStore,
          historyStore: stores.historyStore,
          formattingPreferences: platformNotificationFormattingPreferences(),
        ),
      ),
      alertsViewModel: NotificationAlertsViewModel(
        stores.alertStore,
        definitionStore: stores.definitionStore,
        ruleOperations: ruleOperations,
      ),
      healthViewModel: NotificationListenerHealthViewModel(
        store: stores.healthStore,
        service: healthService,
      ),
      ruleOperations: ruleOperations,
      listenerStatusLoader: const PlatformNotificationListenerStatusLoader(),
      accessSettingsLauncher:
          const PlatformNotificationAccessSettingsLauncher(),
      backupFileGateway: const FilePickerNotificationBackupFileGateway(),
    );
  }

  final NotificationDefinitionStore definitionStore;
  final NotificationAlertStore alertStore;
  final NotificationHistoryStore historyStore;
  final NotificationProcessingSettingsStore settingsStore;
  final NotificationDefinitionsViewModel definitionsViewModel;
  final RecentNotificationsViewModel recentNotificationsViewModel;
  final NotificationAlertsViewModel alertsViewModel;
  final NotificationListenerHealthViewModel healthViewModel;
  final NotificationRuleOperations ruleOperations;
  final NotificationListenerStatusLoader listenerStatusLoader;
  final NotificationAccessSettingsLauncher accessSettingsLauncher;
  final NotificationBackupFileGateway backupFileGateway;
}
