import 'package:waterflyiii/notifications/application/stores/notification_alert_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_definition_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_history_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_listener_health_store.dart';
import 'package:waterflyiii/notifications/application/settings/notification_processing_settings.dart';
import 'package:waterflyiii/notifications/application/resources/firefly_currency_resolver.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:waterflyiii/data/database/database_provider.dart';
import 'package:waterflyiii/notifications/data/repositories/sqlcipher_notification_alert_store.dart';
import 'package:waterflyiii/notifications/data/repositories/sqlcipher_notification_history_store.dart';
import 'package:waterflyiii/notifications/data/database/notification_database_provider.dart';
import 'package:waterflyiii/notifications/data/repositories/notification_definition_repository.dart';
import 'package:waterflyiii/notifications/data/repositories/notification_history_repository.dart';
import 'package:waterflyiii/notifications/data/repositories/shared_preferences_notification_processing_settings_store.dart';
import 'package:waterflyiii/notifications/data/repositories/shared_preferences_notification_listener_health_store.dart';

class NotificationStoreBundle {
  const NotificationStoreBundle({
    required this.definitionStore,
    required this.alertStore,
    required this.historyStore,
    required this.healthStore,
    required this.settingsStore,
  });

  factory NotificationStoreBundle.encrypted({
    FireflyCurrencyResolver? currencyResolver,
  }) {
    final DatabaseProvider<Database> database =
        NotificationDatabaseProvider.create();
    final NotificationAlertStore alertStore = SqlcipherNotificationAlertStore(
      database,
    );
    final NotificationDefinitionStore definitionStore =
        NotificationDefinitionRepository.encryptedDatabase(
          database,
          alertStore: alertStore,
          currencyResolver: currencyResolver,
        );
    return NotificationStoreBundle(
      definitionStore: definitionStore,
      alertStore: alertStore,
      historyStore: NotificationHistoryRepository(
        SqlcipherNotificationHistoryStore(database),
        settingsStore:
            const SharedPreferencesNotificationProcessingSettingsStore(),
      ),
      healthStore: const SharedPreferencesNotificationListenerHealthStore(),
      settingsStore:
          const SharedPreferencesNotificationProcessingSettingsStore(),
    );
  }

  final NotificationDefinitionStore definitionStore;
  final NotificationAlertStore alertStore;
  final NotificationHistoryStore historyStore;
  final NotificationListenerHealthStore healthStore;
  final NotificationProcessingSettingsStore settingsStore;
}
