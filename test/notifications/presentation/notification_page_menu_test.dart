import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/application/definitions/save_notification_definition.dart';
import 'package:waterflyiii/notifications/application/history/recent_notification_history.dart';
import 'package:waterflyiii/notifications/application/listeners/notification_access_settings_launcher.dart';
import 'package:waterflyiii/notifications/application/listeners/notification_listener_status.dart';
import 'package:waterflyiii/notifications/application/listeners/notification_listener_health_service.dart';
import 'package:waterflyiii/notifications/application/rules/notification_rule_operations.dart';
import 'package:waterflyiii/notifications/application/settings/notification_processing_settings.dart';
import 'package:waterflyiii/notifications/application/stores/notification_history_store.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/history/notification_history_entry.dart';
import 'package:waterflyiii/notifications/domain/listeners/notification_listener_health_issue.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/notification_feature_scope.dart';
import 'package:waterflyiii/notifications/presentation/alerts/controllers/notification_alerts_view_model.dart';
import 'package:waterflyiii/notifications/presentation/definitions/controllers/notification_definitions_view_model.dart';
import 'package:waterflyiii/notifications/presentation/definitions/pages/notification_definitions_page.dart';
import 'package:waterflyiii/notifications/presentation/definitions/pages/notification_definition_details_page.dart';
import 'package:waterflyiii/notifications/presentation/history/controllers/recent_notifications_view_model.dart';
import 'package:waterflyiii/notifications/presentation/health/controllers/notification_listener_health_view_model.dart';
import 'package:waterflyiii/notifications/presentation/navigation/notification_navigation_coordinator.dart';
import 'package:waterflyiii/notifications/presentation/navigation/notification_page_menu.dart';
import 'package:waterflyiii/notifications/presentation/rules/pages/notification_rule_details_page.dart';
import '../support/in_memory_notification_stores.dart';

class _HistoryStore implements NotificationHistoryStore {
  _HistoryStore(this.entries);
  final List<NotificationHistoryEntry> entries;

  @override
  Future<bool> linkTransaction(
    String historyEntryId,
    String transactionId,
  ) async => false;

  @override
  Future<List<NotificationHistoryEntry>> load() async => entries;
  @override
  Future<void> record(NotificationHistoryEntry entry) async {}
  @override
  Future<void> clearAll() async {}
  @override
  Future<void> clearForApplication(String applicationId) async {}
}

class _SettingsStore implements NotificationProcessingSettingsStore {
  @override
  Future<NotificationProcessingSettings> load() async =>
      NotificationProcessingSettings.defaults;
  @override
  Future<void> save(NotificationProcessingSettings settings) async {}
  @override
  Future<void> reset() async {}
}

void main() {
  testWidgets('coordinator opens a rule draft with history context', (
    WidgetTester tester,
  ) async {
    final InMemoryNotificationDefinitionStore definitions =
        InMemoryNotificationDefinitionStore();
    final InMemoryNotificationAlertStore alerts =
        InMemoryNotificationAlertStore();
    final NotificationNavigationCoordinator coordinator =
        NotificationNavigationCoordinator(
          alertStore: alerts,
          definitionStore: definitions,
          ruleOperations: NotificationRuleOperations(definitions),
        );
    const NotificationDefinition definition = NotificationDefinition(
      id: 'bank',
      applicationId: 'com.example.bank',
      name: 'Example Bank',
      extractors: <RegExpDefinition>[],
      rules: <NotificationRule>[],
    );
    final RecentNotificationHistoryEntry entry = RecentNotificationHistoryEntry(
      notification: NotificationHistoryEntry(
        id: 'delivery',
        applicationId: 'com.example.bank',
        title: 'Card payment',
        body: 'Paid 12 CAD',
        receivedAt: DateTime(2026, 9, 26),
      ),
      definition: definition,
    );
    late BuildContext context;

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: Builder(
          builder: (BuildContext value) {
            context = value;
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    final Future<bool> result = coordinator.createRuleFromNotification(
      context,
      entry,
    );
    await tester.pumpAndSettle();

    final NotificationRuleDetailsPage page = tester.widget(
      find.byType(NotificationRuleDetailsPage),
    );
    expect(page.notificationContext.applicationId, 'com.example.bank');
    expect(page.notificationContext.applicationName, 'Example Bank');
    expect(page.notificationContext.deliveryId, 'delivery');
    expect(page.notificationContext.title, 'Card payment');
    expect(page.notificationContext.body, 'Paid 12 CAD');

    Navigator.of(context).pop();
    await tester.pumpAndSettle();
    expect(await result, isFalse);
  });

  testWidgets('shows an active processing badge without blocking the menu', (
    WidgetTester tester,
  ) async {
    final InMemoryNotificationDefinitionStore definitions =
        InMemoryNotificationDefinitionStore();
    final InMemoryNotificationAlertStore alerts =
        InMemoryNotificationAlertStore();
    final _HistoryStore history = _HistoryStore(<NotificationHistoryEntry>[]);
    final InMemoryNotificationListenerHealthStore health =
        InMemoryNotificationListenerHealthStore(
          NotificationListenerHealthIssue(
            firstOccurredAt: DateTime.utc(2026, 10, 1),
            lastOccurredAt: DateTime.utc(2026, 10, 1),
            occurrenceCount: 1,
          ),
        );
    final NotificationRuleOperations rules = NotificationRuleOperations(
      definitions,
    );
    final NotificationFeatureScope scope = NotificationFeatureScope(
      definitionStore: definitions,
      alertStore: alerts,
      historyStore: history,
      settingsStore: _SettingsStore(),
      definitionsViewModel: NotificationDefinitionsViewModel(
        definitions,
        SaveNotificationDefinition(definitions),
      ),
      recentNotificationsViewModel: RecentNotificationsViewModel(
        RecentNotificationHistory(definitions, alerts, historyStore: history),
      ),
      alertsViewModel: NotificationAlertsViewModel(alerts),
      healthViewModel: NotificationListenerHealthViewModel(
        store: health,
        service: NotificationListenerHealthService(
          store: health,
          definitionStore: definitions,
        ),
      ),
      ruleOperations: rules,
      listenerStatusLoader: const UnavailableNotificationListenerStatusLoader(),
      accessSettingsLauncher:
          const UnavailableNotificationAccessSettingsLauncher(),
    );

    await tester.pumpWidget(
      Provider<NotificationFeatureScope>.value(
        value: scope,
        child: const MaterialApp(
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          home: NotificationDefinitionsPage(showAppBar: true),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('!'), findsOneWidget);
    await tester.tap(find.byTooltip('Notification options'));
    await tester.pumpAndSettle();
    expect(find.text('Alerts'), findsOneWidget);
  });

  testWidgets('loads the alert badge through the alerts ViewModel', (
    WidgetTester tester,
  ) async {
    final NotificationAlert alert = NotificationAlert.failure(
      kind: NotificationAlertKind.evaluationFailed,
      operation: 'evaluate',
      message: 'failed',
    );

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: Scaffold(
          body: NotificationPageMenu(
            alertStore: InMemoryNotificationAlertStore(<NotificationAlert>[
              alert,
            ]),
            definitionStore: InMemoryNotificationDefinitionStore(),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('notifies the parent after the alerts page closes', (
    WidgetTester tester,
  ) async {
    int closeCount = 0;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: Scaffold(
          body: NotificationPageMenu(
            alertStore: InMemoryNotificationAlertStore(),
            definitionStore: InMemoryNotificationDefinitionStore(),
            onPageClosed: () async {
              closeCount++;
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Notification options'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Alerts'));
    await tester.pumpAndSettle();
    expect(find.text('Notification alerts'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(closeCount, 1);
  });

  testWidgets('opens and saves the definition from recent notifications', (
    WidgetTester tester,
  ) async {
    final InMemoryNotificationDefinitionStore definitions =
        InMemoryNotificationDefinitionStore(<NotificationDefinition>[
          const NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            sampleTitle: 'Payment',
            sampleBody: 'Paid 12 CAD',
            extractors: <RegExpDefinition>[],
            rules: <NotificationRule>[],
            extractorMode: NotificationExtractorMode.advanced,
          ),
        ]);
    final InMemoryNotificationAlertStore alerts =
        InMemoryNotificationAlertStore();
    final _HistoryStore history = _HistoryStore(<NotificationHistoryEntry>[
      NotificationHistoryEntry(
        id: 'payment',
        applicationId: 'com.example.bank',
        title: 'Card payment',
        body: 'Paid 12 CAD',
        receivedAt: DateTime(2026, 9, 26),
      ),
    ]);
    final NotificationRuleOperations rules = NotificationRuleOperations(
      definitions,
    );
    final InMemoryNotificationListenerHealthStore health =
        InMemoryNotificationListenerHealthStore();
    final NotificationFeatureScope scope = NotificationFeatureScope(
      definitionStore: definitions,
      alertStore: alerts,
      historyStore: history,
      settingsStore: _SettingsStore(),
      definitionsViewModel: NotificationDefinitionsViewModel(
        definitions,
        SaveNotificationDefinition(definitions),
      ),
      recentNotificationsViewModel: RecentNotificationsViewModel(
        RecentNotificationHistory(definitions, alerts, historyStore: history),
      ),
      alertsViewModel: NotificationAlertsViewModel(
        alerts,
        definitionStore: definitions,
        ruleOperations: rules,
      ),
      healthViewModel: NotificationListenerHealthViewModel(
        store: health,
        service: NotificationListenerHealthService(
          store: health,
          definitionStore: definitions,
        ),
      ),
      ruleOperations: rules,
      listenerStatusLoader: const UnavailableNotificationListenerStatusLoader(),
      accessSettingsLauncher:
          const UnavailableNotificationAccessSettingsLauncher(),
    );
    await tester.pumpWidget(
      Provider<NotificationFeatureScope>.value(
        value: scope,
        child: const MaterialApp(
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          home: Scaffold(body: NotificationPageMenu()),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Notification options'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Recent notifications'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Card payment'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.arrow_drop_down));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Go to definition'));
    await tester.pumpAndSettle();

    expect(find.byType(NotificationDefinitionDetailsPage), findsOneWidget);
    expect(find.text('Example Bank'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Create transaction automatically'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Create transaction automatically'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Save definition'));
    await tester.pumpAndSettle();
    expect(
      definitions.definitions.single.transactionCreationMode,
      TransactionCreationMode.automatic,
    );
  });
}
