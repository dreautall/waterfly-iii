import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/stores/notification_alert_store.dart';
import 'package:waterflyiii/notifications/application/resources/firefly_currency_resolver.dart';
import 'package:waterflyiii/notifications/application/resources/application_name_resolver.dart';
import 'package:waterflyiii/notifications/data/migrations/shared_preferences_legacy_notification_definition_migrator.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';

class _Preferences implements NotificationMigrationPreferences {
  _Preferences([Map<String, Object>? values])
    : values = <String, Object>{...?values};

  final Map<String, Object> values;
  final Set<String> failingRemovals = <String>{};

  @override
  Future<String?> getString(String key) async => values[key] as String?;

  @override
  Future<List<String>?> getStringList(String key) async {
    final List<String>? value = values[key] as List<String>?;
    return value == null ? null : List<String>.of(value);
  }

  @override
  Future<void> remove(String key) async {
    if (failingRemovals.contains(key)) {
      throw StateError('Could not remove $key');
    }
    values.remove(key);
  }

  @override
  Future<void> setStringList(String key, List<String> value) async {
    values[key] = List<String>.of(value);
  }
}

class _AlertStore implements NotificationAlertStore {
  final List<NotificationAlert> alerts = <NotificationAlert>[];

  @override
  Future<void> record(NotificationAlert alert) async => alerts.add(alert);

  @override
  Future<List<NotificationAlert>> load() async =>
      List<NotificationAlert>.of(alerts);

  @override
  Future<void> clearAll() async => alerts.clear();

  @override
  Future<void> clearForApplication(String applicationId) async {
    alerts.removeWhere(
      (NotificationAlert alert) => alert.applicationId == applicationId,
    );
  }

  @override
  Future<void> dismiss(String fingerprint) async {
    alerts.removeWhere(
      (NotificationAlert alert) => alert.fingerprint == fingerprint,
    );
  }

  @override
  Future<void> restore(NotificationAlert alert) async => alerts.add(alert);
}

class _CurrencyGateway implements FireflyCurrencyGateway {
  _CurrencyGateway({this.currencies = const <FireflyCurrency>[], this.error});

  final List<FireflyCurrency> currencies;
  final Object? error;

  @override
  Future<List<FireflyCurrency>> search(String query) async {
    if (error != null) throw error!;
    return currencies;
  }
}

class _ApplicationNameResolver implements ApplicationNameResolver {
  const _ApplicationNameResolver(this.names);

  final Map<String, String> names;

  @override
  Future<String?> resolve(String applicationId) async => names[applicationId];
}

void main() {
  const String usedAppsKey = 'NL_USEDAPPS';
  const String appSettingsPrefix = 'NL_APP_';
  const String historyKey = 'NL_HISTORY';

  String settings(String appName) => jsonEncode(<String, dynamic>{
    'appName': appName,
    'includeTitle': true,
    'autoAdd': false,
    'emptyNote': false,
  });

  test('merges both preference backends and prefers async settings', () async {
    final _Preferences asynchronous = _Preferences(<String, Object>{
      usedAppsKey: <String>['com.example.bank'],
      '${appSettingsPrefix}com.example.bank': settings('Current Bank'),
    });
    final _Preferences legacy = _Preferences(<String, Object>{
      usedAppsKey: <String>['com.example.bank', 'com.example.card'],
      '${appSettingsPrefix}com.example.bank': settings('Legacy Bank'),
      '${appSettingsPrefix}com.example.card': settings('Legacy Card'),
    });
    final SharedPreferencesLegacyNotificationDefinitionMigrator migrator =
        SharedPreferencesLegacyNotificationDefinitionMigrator(
          preferences: asynchronous,
          legacyPreferences: legacy,
        );

    final List<NotificationDefinition> definitions = await migrator.migrate();

    expect(
      definitions.map((NotificationDefinition definition) => definition.name),
      <String>['Current Bank', 'Legacy Card'],
    );

    await migrator.cleanupMigratedSettings();

    expect(asynchronous.values[usedAppsKey], isEmpty);
    expect(legacy.values[usedAppsKey], isEmpty);
    expect(
      asynchronous.values,
      isNot(contains('${appSettingsPrefix}com.example.bank')),
    );
    expect(
      legacy.values,
      isNot(contains('${appSettingsPrefix}com.example.bank')),
    );
    expect(
      legacy.values,
      isNot(contains('${appSettingsPrefix}com.example.card')),
    );
  });

  test(
    'replaces invalid application settings with a reviewable husk',
    () async {
      final _Preferences asynchronous = _Preferences(<String, Object>{
        usedAppsKey: <String>['com.example.valid', 'com.example.invalid'],
        '${appSettingsPrefix}com.example.valid': settings('Valid Bank'),
        '${appSettingsPrefix}com.example.invalid': '{invalid',
      });
      final _Preferences legacy = _Preferences();
      final _AlertStore alertStore = _AlertStore();
      final SharedPreferencesLegacyNotificationDefinitionMigrator migrator =
          SharedPreferencesLegacyNotificationDefinitionMigrator(
            preferences: asynchronous,
            legacyPreferences: legacy,
            alertStore: alertStore,
          );

      final List<NotificationDefinition> definitions = await migrator.migrate();
      await migrator.cleanupMigratedSettings();

      expect(definitions, hasLength(2));
      final NotificationDefinition husk = definitions.singleWhere(
        (NotificationDefinition definition) =>
            definition.applicationId == 'com.example.invalid',
      );
      expect(husk.name, 'com.example.invalid');
      expect(husk.status, NotificationDefinitionStatus.notConfigured);
      expect(husk.requiresMigrationReview, isTrue);
      expect(husk.migrationReviewIssues, <NotificationMigrationIssue>{
        NotificationMigrationIssue.conversionFailed,
      });
      expect(asynchronous.values[usedAppsKey], isEmpty);
      expect(
        asynchronous.values,
        isNot(contains('${appSettingsPrefix}com.example.invalid')),
      );
      final NotificationAlert huskAlert = alertStore.alerts.singleWhere(
        (NotificationAlert alert) =>
            alert.applicationId == 'com.example.invalid',
      );
      expect(huskAlert.kind, NotificationAlertKind.migrationNeedsReview);
      expect(huskAlert.definitionId, husk.id);
      expect(
        huskAlert.migrationIssue,
        NotificationMigrationIssue.conversionFailed,
      );
    },
  );

  test(
    'creates a husk when an application settings record is missing',
    () async {
      final _Preferences asynchronous = _Preferences(<String, Object>{
        usedAppsKey: <String>['com.example.missing'],
      });
      final _AlertStore alertStore = _AlertStore();
      final SharedPreferencesLegacyNotificationDefinitionMigrator migrator =
          SharedPreferencesLegacyNotificationDefinitionMigrator(
            preferences: asynchronous,
            legacyPreferences: _Preferences(),
            alertStore: alertStore,
          );

      final NotificationDefinition husk = (await migrator.migrate()).single;
      expect(husk.applicationId, 'com.example.missing');
      expect(husk.status, NotificationDefinitionStatus.notConfigured);
      expect(husk.requiresMigrationReview, isTrue);
      expect(husk.migrationReviewIssues, <NotificationMigrationIssue>{
        NotificationMigrationIssue.missingSettings,
      });
      expect(alertStore.alerts, isEmpty);

      await migrator.cleanupMigratedSettings();

      expect(asynchronous.values[usedAppsKey], isEmpty);
      expect(alertStore.alerts.single.message, contains('were not found'));
      expect(
        alertStore.alerts.single.migrationIssue,
        NotificationMigrationIssue.missingSettings,
      );
    },
  );

  test('preserves an invalid regex in an advanced configuration', () async {
    final _Preferences asynchronous = _Preferences(<String, Object>{
      usedAppsKey: <String>['com.example.bank'],
      '${appSettingsPrefix}com.example.bank': jsonEncode(<String, dynamic>{
        'appName': 'Example Bank',
        'regex': '[',
      }),
      historyKey: <String>[
        jsonEncode(<String, dynamic>{
          'appName': 'com.example.bank',
          'title': 'Card payment',
          'body': 'Paid USD 12.50',
          'time': 1000,
        }),
      ],
    });
    final SharedPreferencesLegacyNotificationDefinitionMigrator migrator =
        SharedPreferencesLegacyNotificationDefinitionMigrator(
          preferences: asynchronous,
          legacyPreferences: _Preferences(),
        );

    final NotificationDefinition definition = (await migrator.migrate()).single;

    expect(definition.name, 'Example Bank');
    expect(definition.sampleTitle, 'Card payment');
    expect(definition.sampleBody, 'Paid USD 12.50');
    expect(definition.extractorMode, NotificationExtractorMode.advanced);
    expect(definition.extractors.first.regExpSource, '[');
    expect(definition.rules, hasLength(1));
    expect(definition.status, NotificationDefinitionStatus.needsSetup);
  });

  test('recovers a missing name from installed application metadata', () async {
    final _Preferences asynchronous = _Preferences(<String, Object>{
      usedAppsKey: <String>['com.example.bank'],
      '${appSettingsPrefix}com.example.bank': jsonEncode(<String, dynamic>{
        'includeTitle': true,
      }),
    });
    final _AlertStore alertStore = _AlertStore();
    final SharedPreferencesLegacyNotificationDefinitionMigrator migrator =
        SharedPreferencesLegacyNotificationDefinitionMigrator(
          preferences: asynchronous,
          legacyPreferences: _Preferences(),
          applicationNameResolver: const _ApplicationNameResolver(
            <String, String>{'com.example.bank': 'Installed Bank'},
          ),
          alertStore: alertStore,
        );

    final NotificationDefinition definition = (await migrator.migrate()).single;
    await migrator.cleanupMigratedSettings();

    expect(definition.name, 'Installed Bank');
    expect(
      alertStore.alerts.where(
        (NotificationAlert alert) =>
            alert.migrationIssue ==
            NotificationMigrationIssue.missingApplicationName,
      ),
      isEmpty,
    );
  });

  test('classifies missing names and invalid expressions for review', () async {
    final _Preferences asynchronous = _Preferences(<String, Object>{
      usedAppsKey: <String>['com.example.unnamed', 'com.example.invalid'],
      '${appSettingsPrefix}com.example.unnamed': jsonEncode(<String, dynamic>{
        'includeTitle': true,
      }),
      '${appSettingsPrefix}com.example.invalid': jsonEncode(<String, dynamic>{
        'appName': 'Invalid expression',
        'regex': '[',
      }),
    });
    final _AlertStore alertStore = _AlertStore();
    final SharedPreferencesLegacyNotificationDefinitionMigrator migrator =
        SharedPreferencesLegacyNotificationDefinitionMigrator(
          preferences: asynchronous,
          legacyPreferences: _Preferences(),
          alertStore: alertStore,
        );

    final List<NotificationDefinition> definitions = await migrator.migrate();
    await migrator.cleanupMigratedSettings();

    expect(
      definitions
          .singleWhere(
            (NotificationDefinition definition) =>
                definition.applicationId == 'com.example.unnamed',
          )
          .migrationReviewIssues,
      contains(NotificationMigrationIssue.missingApplicationName),
    );
    expect(
      definitions
          .singleWhere(
            (NotificationDefinition definition) =>
                definition.applicationId == 'com.example.invalid',
          )
          .migrationReviewIssues,
      contains(NotificationMigrationIssue.invalidRegularExpression),
    );
    expect(
      alertStore.alerts.map((NotificationAlert alert) => alert.migrationIssue),
      containsAll(<NotificationMigrationIssue>[
        NotificationMigrationIssue.missingApplicationName,
        NotificationMigrationIssue.invalidRegularExpression,
      ]),
    );
    expect(
      alertStore.alerts
          .map((NotificationAlert alert) => alert.message)
          .join(' '),
      isNot(contains('FormatException')),
    );
  });

  test('retains an application when its settings cannot be removed', () async {
    final String settingsKey = '${appSettingsPrefix}com.example.bank';
    final _Preferences asynchronous = _Preferences(<String, Object>{
      usedAppsKey: <String>['com.example.bank'],
      settingsKey: settings('Example Bank'),
    })..failingRemovals.add(settingsKey);
    final SharedPreferencesLegacyNotificationDefinitionMigrator migrator =
        SharedPreferencesLegacyNotificationDefinitionMigrator(
          preferences: asynchronous,
          legacyPreferences: _Preferences(),
        );

    await migrator.migrate();
    await migrator.cleanupMigratedSettings();

    expect(asynchronous.values[usedAppsKey], <String>['com.example.bank']);
    expect(asynchronous.values, contains(settingsKey));
  });

  test('uses the newest valid history entry as the migration sample', () async {
    String history(int time, String title, String body) =>
        jsonEncode(<String, dynamic>{
          'appName': 'com.example.bank',
          'title': title,
          'body': body,
          'time': time,
        });
    final _Preferences asynchronous = _Preferences(<String, Object>{
      usedAppsKey: <String>['com.example.bank'],
      '${appSettingsPrefix}com.example.bank': settings('Example Bank'),
      historyKey: <String>[
        history(1000, 'Old title', 'Paid USD 10.00'),
        '{invalid',
      ],
    });
    final _Preferences legacy = _Preferences(<String, Object>{
      historyKey: <String>[
        history(2000, 'Latest title', 'Paid USD 20.00'),
        history(3000, '', 'Missing title'),
      ],
    });
    final SharedPreferencesLegacyNotificationDefinitionMigrator migrator =
        SharedPreferencesLegacyNotificationDefinitionMigrator(
          preferences: asynchronous,
          legacyPreferences: legacy,
        );

    final NotificationDefinition definition = (await migrator.migrate()).single;

    expect(definition.sampleTitle, 'Latest title');
    expect(definition.sampleBody, 'Paid USD 20.00');
    expect(
      definition.sampleReceivedAt,
      DateTime.fromMillisecondsSinceEpoch(2000),
    );
  });

  test('resolves and guards an imported sample currency', () async {
    final _Preferences asynchronous = _Preferences(<String, Object>{
      usedAppsKey: <String>['com.example.bank'],
      '${appSettingsPrefix}com.example.bank': settings('Example Bank'),
      historyKey: <String>[
        jsonEncode(<String, dynamic>{
          'appName': 'com.example.bank',
          'title': 'Card payment',
          'body': 'Paid USD 12.50',
          'time': 1000,
        }),
      ],
    });
    final SharedPreferencesLegacyNotificationDefinitionMigrator migrator =
        SharedPreferencesLegacyNotificationDefinitionMigrator(
          preferences: asynchronous,
          legacyPreferences: _Preferences(),
          currencyResolver: FireflyCurrencyResolver(
            _CurrencyGateway(
              currencies: const <FireflyCurrency>[
                FireflyCurrency(
                  id: 'currency-1',
                  name: 'US dollar',
                  code: 'USD',
                  symbol: r'$',
                ),
              ],
            ),
          ),
        );

    final NotificationDefinition definition = (await migrator.migrate()).single;

    expect(definition.status, NotificationDefinitionStatus.ready);
    expect(
      definition
          .evaluate(
            NotificationContext(
              applicationId: 'com.example.bank',
              title: 'Card payment',
              body: 'Paid USD 12.50',
              receivedAt: DateTime.fromMillisecondsSinceEpoch(1000),
            ),
          )
          ?.effectiveTransactionIntent
          ?.patch
          .values[TransactionField.currency],
      'currency-1',
    );
  });

  test('keeps migration reviewable when currency lookup fails', () async {
    final _Preferences asynchronous = _Preferences(<String, Object>{
      usedAppsKey: <String>['com.example.bank'],
      '${appSettingsPrefix}com.example.bank': settings('Example Bank'),
      historyKey: <String>[
        jsonEncode(<String, dynamic>{
          'appName': 'com.example.bank',
          'title': 'Card payment',
          'body': 'Paid USD 12.50',
          'time': 1000,
        }),
      ],
    });
    final _AlertStore alertStore = _AlertStore();
    final SharedPreferencesLegacyNotificationDefinitionMigrator migrator =
        SharedPreferencesLegacyNotificationDefinitionMigrator(
          preferences: asynchronous,
          legacyPreferences: _Preferences(),
          alertStore: alertStore,
          currencyResolver: FireflyCurrencyResolver(
            _CurrencyGateway(error: StateError('API unavailable')),
          ),
        );

    await migrator.migrate();

    await migrator.cleanupMigratedSettings();

    expect(alertStore.alerts, hasLength(1));
    expect(
      alertStore.alerts.single.message,
      contains('could not be resolved uniquely'),
    );
  });

  test('records review alerts only during migration cleanup', () async {
    final _Preferences asynchronous = _Preferences(<String, Object>{
      usedAppsKey: <String>['com.example.bank'],
      '${appSettingsPrefix}com.example.bank': settings('Example Bank'),
    });
    final _AlertStore alertStore = _AlertStore();
    final SharedPreferencesLegacyNotificationDefinitionMigrator migrator =
        SharedPreferencesLegacyNotificationDefinitionMigrator(
          preferences: asynchronous,
          legacyPreferences: _Preferences(),
          alertStore: alertStore,
        );

    final List<NotificationDefinition> definitions = await migrator.migrate();

    expect(definitions.single.status, NotificationDefinitionStatus.needsSetup);
    expect(alertStore.alerts, isEmpty);

    await migrator.cleanupMigratedSettings();

    expect(alertStore.alerts, hasLength(1));
    expect(
      alertStore.alerts.single.kind,
      NotificationAlertKind.migrationNeedsReview,
    );
    expect(alertStore.alerts.single.definitionId, definitions.single.id);
  });
}
