import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/application/listeners/notification_access_settings_launcher.dart';
import 'package:waterflyiii/notifications/application/settings/notification_processing_settings.dart';
import 'package:waterflyiii/notifications/application/stores/notification_history_store.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/history/notification_history_entry.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/presentation/settings/pages/notification_processing_settings_page.dart';

import '../../support/in_memory_notification_stores.dart';

class _HistoryStore implements NotificationHistoryStore {
  _HistoryStore([List<NotificationHistoryEntry>? entries])
    : entries = entries ?? <NotificationHistoryEntry>[];

  List<NotificationHistoryEntry> entries;
  bool cleared = false;
  final List<String> clearedApplicationIds = <String>[];

  @override
  Future<bool> linkTransaction(
    String historyEntryId,
    String transactionId,
  ) async => false;

  @override
  Future<void> clearAll() async {
    cleared = true;
    entries = <NotificationHistoryEntry>[];
  }

  @override
  Future<void> clearForApplication(String applicationId) async {
    clearedApplicationIds.add(applicationId);
    entries = entries
        .where(
          (NotificationHistoryEntry entry) =>
              entry.applicationId != applicationId,
        )
        .toList();
  }

  @override
  Future<List<NotificationHistoryEntry>> load() async => entries;

  @override
  Future<void> record(NotificationHistoryEntry entry) async {}
}

class _SettingsStore implements NotificationProcessingSettingsStore {
  NotificationProcessingSettings settings =
      NotificationProcessingSettings.defaults;
  bool resetCalled = false;

  @override
  Future<NotificationProcessingSettings> load() async => settings;

  @override
  Future<void> reset() async {
    resetCalled = true;
    settings = NotificationProcessingSettings.defaults;
  }

  @override
  Future<void> save(NotificationProcessingSettings settings) async {
    this.settings = settings;
  }
}

class _AccessSettingsLauncher implements NotificationAccessSettingsLauncher {
  int openCount = 0;

  @override
  Future<bool> openNotificationAccessSettings() async {
    openCount++;
    return true;
  }
}

void main() {
  testWidgets('disables actions that have no data to act on', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: NotificationProcessingSettingsPage(
          definitionStore: InMemoryNotificationDefinitionStore(),
          historyStore: _HistoryStore(),
          alertStore: InMemoryNotificationAlertStore(),
          settingsStore: _SettingsStore(),
          accessSettingsLauncher: _AccessSettingsLauncher(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text('Add at least one application before creating a backup.'),
      findsOneWidget,
    );
    expect(
      find.ancestor(
        of: find.text('Create backup'),
        matching: find.byType(ElevatedButton),
      ),
      findsNothing,
    );
    expect(
      find.ancestor(
        of: find.text('Restore backup'),
        matching: find.byType(ElevatedButton),
      ),
      findsOneWidget,
    );

    await tester.scrollUntilVisible(find.text('Clear recent history'), 300);
    await tester.pumpAndSettle();
    for (final String action in <String>[
      'Clear recent history',
      'Clear processing alerts',
      'Delete all application registrations',
      'Remove notification setup',
    ]) {
      expect(
        find.ancestor(
          of: find.text(action),
          matching: find.byType(ElevatedButton),
        ),
        findsNothing,
      );
    }
  });

  testWidgets('enables actions when their data exists', (
    WidgetTester tester,
  ) async {
    const NotificationDefinition definition = NotificationDefinition(
      id: 'bank',
      applicationId: 'com.example.bank',
      name: 'Example Bank',
      extractors: <RegExpDefinition>[],
      rules: <NotificationRule>[],
    );
    final NotificationHistoryEntry history = NotificationHistoryEntry(
      id: 'history',
      applicationId: definition.applicationId,
      title: 'Payment',
      body: r'$10',
      receivedAt: DateTime(2026, 10),
    );
    final NotificationAlert alert = NotificationAlert.failure(
      kind: NotificationAlertKind.evaluationFailed,
      operation: 'Evaluating notification',
      message: 'Could not evaluate notification.',
    );

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: NotificationProcessingSettingsPage(
          definitionStore: InMemoryNotificationDefinitionStore(
            const <NotificationDefinition>[definition],
          ),
          historyStore: _HistoryStore(<NotificationHistoryEntry>[history]),
          alertStore: InMemoryNotificationAlertStore(<NotificationAlert>[
            alert,
          ]),
          settingsStore: _SettingsStore(),
          accessSettingsLauncher: _AccessSettingsLauncher(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.ancestor(
        of: find.text('Create backup'),
        matching: find.byType(ElevatedButton),
      ),
      findsOneWidget,
    );

    await tester.scrollUntilVisible(find.text('Clear recent history'), 300);
    await tester.pumpAndSettle();
    for (final String action in <String>[
      'Clear recent history',
      'Clear processing alerts',
      'Delete all application registrations',
      'Remove notification setup',
    ]) {
      expect(
        find.ancestor(
          of: find.text(action),
          matching: find.byType(ElevatedButton),
        ),
        findsOneWidget,
      );
    }
  });

  testWidgets('renders settings sections and saves history storage mode', (
    WidgetTester tester,
  ) async {
    final _SettingsStore settingsStore = _SettingsStore();

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: NotificationProcessingSettingsPage(
          definitionStore: InMemoryNotificationDefinitionStore(),
          historyStore: _HistoryStore(),
          alertStore: InMemoryNotificationAlertStore(),
          settingsStore: settingsStore,
          accessSettingsLauncher: _AccessSettingsLauncher(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Backup and restore'), findsOneWidget);
    expect(find.text('History and stored data'), findsOneWidget);
    expect(find.text('Clear history and alerts'), findsOneWidget);

    await tester.tap(find.text('Recent notification history'));
    await tester.pumpAndSettle();
    final Divider choiceDivider = tester.widget<Divider>(
      find.byType(Divider).first,
    );
    expect(choiceDivider.indent, 16);
    expect(choiceDivider.endIndent, 16);
    expect(
      choiceDivider.color,
      Theme.of(
        tester.element(find.byType(Divider).first),
      ).colorScheme.outlineVariant,
    );
    await tester.tap(find.text('Metadata only').last);
    await tester.pumpAndSettle();

    expect(
      settingsStore.settings.historyStorageMode,
      NotificationHistoryStorageMode.metadataOnly,
    );
  });

  testWidgets(
    'deletes all registrations without resetting settings or access',
    (WidgetTester tester) async {
      const NotificationDefinition definition = NotificationDefinition(
        id: 'bank',
        applicationId: 'com.example.bank',
        name: 'Example Bank',
        extractors: <RegExpDefinition>[],
        rules: <NotificationRule>[],
      );
      final InMemoryNotificationDefinitionStore definitionStore =
          InMemoryNotificationDefinitionStore(const <NotificationDefinition>[
            definition,
          ]);
      final _HistoryStore historyStore =
          _HistoryStore(<NotificationHistoryEntry>[
            NotificationHistoryEntry(
              id: 'history',
              applicationId: definition.applicationId,
              title: 'Payment',
              body: r'$10',
              receivedAt: DateTime(2026, 10),
            ),
          ]);
      final InMemoryNotificationAlertStore alertStore =
          InMemoryNotificationAlertStore(<NotificationAlert>[
            NotificationAlert.failure(
              kind: NotificationAlertKind.evaluationFailed,
              operation: 'Evaluating notification',
              message: 'Could not evaluate notification.',
              applicationId: definition.applicationId,
            ),
          ]);
      final _SettingsStore settingsStore = _SettingsStore()
        ..settings = const NotificationProcessingSettings(
          historyStorageMode: NotificationHistoryStorageMode.metadataOnly,
        );
      final _AccessSettingsLauncher accessSettingsLauncher =
          _AccessSettingsLauncher();

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          home: NotificationProcessingSettingsPage(
            definitionStore: definitionStore,
            historyStore: historyStore,
            alertStore: alertStore,
            settingsStore: settingsStore,
            accessSettingsLauncher: accessSettingsLauncher,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.scrollUntilVisible(
        find.text('Delete all application registrations'),
        300,
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete all application registrations'));
      await tester.pumpAndSettle();
      expect(find.text('Delete 1 application registration?'), findsOneWidget);
      expect(
        find.textContaining(
          'Processing preferences and notification access will not change.',
        ),
        findsOneWidget,
      );

      await tester.tap(find.text('Delete all application registrations').last);
      await tester.pumpAndSettle();

      expect(definitionStore.definitions, isEmpty);
      expect(historyStore.entries, isEmpty);
      expect(alertStore.alerts, isEmpty);
      expect(settingsStore.resetCalled, isFalse);
      expect(
        settingsStore.settings.historyStorageMode,
        NotificationHistoryStorageMode.metadataOnly,
      );
      expect(accessSettingsLauncher.openCount, 0);
      expect(find.text('1 application registration deleted.'), findsOneWidget);
      expect(
        find.ancestor(
          of: find.text('Delete all application registrations'),
          matching: find.byType(ElevatedButton),
        ),
        findsNothing,
      );
    },
  );

  testWidgets('removes setup and opens notification access settings', (
    WidgetTester tester,
  ) async {
    const NotificationDefinition definition = NotificationDefinition(
      id: 'bank',
      applicationId: 'com.example.bank',
      name: 'Example Bank',
      extractors: <RegExpDefinition>[],
      rules: <NotificationRule>[],
    );
    final InMemoryNotificationDefinitionStore definitionStore =
        InMemoryNotificationDefinitionStore(const <NotificationDefinition>[
          definition,
        ]);
    final _HistoryStore historyStore = _HistoryStore();
    final InMemoryNotificationAlertStore alertStore =
        InMemoryNotificationAlertStore();
    final _SettingsStore settingsStore = _SettingsStore()
      ..settings = const NotificationProcessingSettings(
        historyStorageMode: NotificationHistoryStorageMode.metadataOnly,
      );
    final _AccessSettingsLauncher accessSettingsLauncher =
        _AccessSettingsLauncher();

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: NotificationProcessingSettingsPage(
          definitionStore: definitionStore,
          historyStore: historyStore,
          alertStore: alertStore,
          settingsStore: settingsStore,
          accessSettingsLauncher: accessSettingsLauncher,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Remove notification setup'),
      300,
    );
    await tester.pumpAndSettle();
    expect(find.text('Remove saved setup'), findsOneWidget);
    await tester.tap(find.text('Remove notification setup'));
    await tester.pumpAndSettle();
    expect(find.text('Remove notification setup?'), findsOneWidget);

    await tester.tap(find.text('Remove notification setup').last);
    await tester.pumpAndSettle();

    expect(definitionStore.definitions, isEmpty);
    expect(historyStore.cleared, isTrue);
    expect(settingsStore.resetCalled, isTrue);
    expect(
      settingsStore.settings.historyStorageMode,
      NotificationHistoryStorageMode.full,
    );
    expect(accessSettingsLauncher.openCount, 1);
    expect(find.textContaining('Notification setup removed'), findsOneWidget);
  });
}
