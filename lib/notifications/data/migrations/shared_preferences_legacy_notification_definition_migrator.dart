import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterflyiii/notifications/application/stores/notification_alert_store.dart';
import 'package:waterflyiii/notifications/application/resources/firefly_currency_resolver.dart';
import 'package:waterflyiii/notifications/application/resources/application_name_resolver.dart';
import 'package:waterflyiii/notifications/data/migrations/legacy_notification_definition_migrator.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_sample.dart';

class SharedPreferencesLegacyNotificationDefinitionMigrator
    implements
        NotificationDefinitionMigrator,
        NotificationDefinitionMigrationCleanup {
  static const String _usedAppsKey = 'NL_USEDAPPS';
  static const String _appSettingsPrefix = 'NL_APP_';
  static const String _historyKey = 'NL_HISTORY';
  static final Logger _log = Logger(
    'Notifications.LegacyNotificationDefinitionMigrator',
  );

  SharedPreferencesLegacyNotificationDefinitionMigrator({
    NotificationMigrationPreferences? preferences,
    NotificationMigrationPreferences? legacyPreferences,
    LegacyNotificationDefinitionMigrator? definitionMigrator,
    FireflyCurrencyResolver? currencyResolver,
    ApplicationNameResolver? applicationNameResolver,
    NotificationAlertStore? alertStore,
  }) : _preferences =
           preferences ??
           const SharedPreferencesAsyncNotificationMigrationPreferences(),
       _legacyPreferences =
           legacyPreferences ??
           const SharedPreferencesNotificationMigrationPreferences(),
       _definitionMigrator =
           definitionMigrator ?? LegacyNotificationDefinitionMigrator(),
       _currencyResolver = currencyResolver,
       _applicationNameResolver = applicationNameResolver,
       _alertStore = alertStore;

  final NotificationMigrationPreferences _preferences;
  final NotificationMigrationPreferences _legacyPreferences;
  final LegacyNotificationDefinitionMigrator _definitionMigrator;
  final FireflyCurrencyResolver? _currencyResolver;
  final ApplicationNameResolver? _applicationNameResolver;
  final NotificationAlertStore? _alertStore;
  final Set<String> _migratedApplicationIds = <String>{};
  final List<NotificationAlert> _pendingReviewAlerts = <NotificationAlert>[];

  @override
  Future<List<NotificationDefinition>> migrate() async {
    _migratedApplicationIds.clear();
    _pendingReviewAlerts.clear();
    final Map<String, NotificationSample> samples = await _legacySamples();
    final List<String> applications = <String>{
      ...?await _preferences.getStringList(_usedAppsKey),
      ...?await _legacyPreferences.getStringList(_usedAppsKey),
    }.toList();
    _log.info(
      'Found ${applications.length} legacy notification registrations and ${samples.length} usable samples.',
    );
    final List<NotificationDefinition> definitions = <NotificationDefinition>[];
    for (final String applicationId in applications) {
      final String settingsKey = '$_appSettingsPrefix$applicationId';
      final String? encodedSettings =
          await _preferences.getString(settingsKey) ??
          await _legacyPreferences.getString(settingsKey);
      Map<String, dynamic>? decodedSettings;
      try {
        if (encodedSettings == null) {
          final String? applicationName = await _resolveApplicationName(
            applicationId,
          );
          final NotificationDefinition husk = _definitionMigrator.createHusk(
            applicationId,
            applicationName: applicationName,
            sample: samples[applicationId],
          );
          _addMigrationResult(applicationId, husk, const <
            LegacyNotificationMigrationIssue
          >[
            LegacyNotificationMigrationIssue(
              NotificationMigrationIssue.missingSettings,
              'The previous notification settings were not found. Complete this configuration manually.',
            ),
          ], definitions);
          continue;
        }
        final Object? decoded = jsonDecode(encodedSettings);
        if (decoded is! Map<String, dynamic>) {
          throw const FormatException('Legacy settings must be a JSON object.');
        }
        decodedSettings = decoded;
        final Object? storedApplicationName = decodedSettings['appName'];
        if (storedApplicationName is! String ||
            storedApplicationName.trim().isEmpty) {
          final String? resolvedApplicationName = await _resolveApplicationName(
            applicationId,
          );
          if (resolvedApplicationName != null) {
            decodedSettings = <String, dynamic>{
              ...decodedSettings,
              'appName': resolvedApplicationName,
            };
          }
        }
        final NotificationSample? sample = samples[applicationId];
        final LegacyResolvedCurrency? resolvedCurrency = await _resolveCurrency(
          applicationId,
          decodedSettings,
          sample,
        );
        final LegacyNotificationMigrationResult? result = _definitionMigrator
            .migrate(
              applicationId,
              decodedSettings,
              sample: sample,
              resolvedCurrency: resolvedCurrency,
            );
        if (result == null) {
          throw const FormatException(
            'Legacy settings did not contain an application name.',
          );
        }
        _addMigrationResult(
          applicationId,
          result.definition,
          result.reviewIssues,
          definitions,
        );
        _log.fine(
          'Migrated legacy notification registration for $applicationId with ${result.reviewIssues.length} review notices.',
        );
      } catch (error, stackTrace) {
        _log.warning(
          'Could not fully migrate legacy notification registration for $applicationId; preserving a reviewable definition.',
          error,
          stackTrace,
        );
        final Object? applicationName =
            decodedSettings?['appName'] ??
            await _resolveApplicationName(applicationId);
        final NotificationDefinition husk = _definitionMigrator.createHusk(
          applicationId,
          applicationName: applicationName is String ? applicationName : null,
          sample: samples[applicationId],
        );
        _addMigrationResult(
          applicationId,
          husk,
          <LegacyNotificationMigrationIssue>[
            _conversionIssue(decodedSettings, error),
          ],
          definitions,
        );
      }
    }
    return definitions;
  }

  Future<String?> _resolveApplicationName(String applicationId) async {
    try {
      return await _applicationNameResolver?.resolve(applicationId);
    } catch (error, stackTrace) {
      _log.warning(
        'Could not resolve the installed application name for $applicationId.',
        error,
        stackTrace,
      );
      return null;
    }
  }

  Future<LegacyResolvedCurrency?> _resolveCurrency(
    String applicationId,
    Map<String, dynamic> settings,
    NotificationSample? sample,
  ) async {
    if (sample == null ||
        ((settings['regex'] as String?)?.isNotEmpty ?? false)) {
      return null;
    }
    final String? token = _definitionMigrator.currencyToken(
      applicationId,
      sample,
    );
    if (token == null) return null;
    try {
      final FireflyCurrency? currency = await _currencyResolver?.resolveUnique(
        token,
      );
      return currency == null
          ? null
          : LegacyResolvedCurrency(token: token, resourceId: currency.id);
    } catch (error, stackTrace) {
      _log.warning(
        'Could not resolve legacy notification currency for $applicationId.',
        error,
        stackTrace,
      );
      return null;
    }
  }

  void _addMigrationResult(
    String applicationId,
    NotificationDefinition definition,
    List<LegacyNotificationMigrationIssue> reviewIssues,
    List<NotificationDefinition> definitions,
  ) {
    final NotificationDefinition persistedDefinition = reviewIssues.isEmpty
        ? definition
        : definition.copyWith(
            requiresMigrationReview: true,
            migrationReviewIssues: <NotificationMigrationIssue>{
              ...definition.migrationReviewIssues,
              ...reviewIssues.map(
                (LegacyNotificationMigrationIssue issue) => issue.reason,
              ),
            },
          );
    definitions.add(persistedDefinition);
    _migratedApplicationIds.add(applicationId);
    for (final LegacyNotificationMigrationIssue issue in reviewIssues) {
      _pendingReviewAlerts.add(
        NotificationAlert.failure(
          kind: NotificationAlertKind.migrationNeedsReview,
          operation: 'Reviewing imported notification settings',
          message: issue.message,
          applicationId: applicationId,
          definitionId: persistedDefinition.id,
          migrationIssue: issue.reason,
        ),
      );
    }
  }

  LegacyNotificationMigrationIssue _conversionIssue(
    Map<String, dynamic>? settings,
    Object error,
  ) {
    final Object? applicationName = settings?['appName'];
    if (settings != null &&
        (applicationName is! String || applicationName.trim().isEmpty)) {
      return const LegacyNotificationMigrationIssue(
        NotificationMigrationIssue.missingApplicationName,
        'Waterfly could not identify the application for this imported setup. Open it and choose the installed application that should use this configuration.',
      );
    }
    if (error is FormatException &&
        ((settings?['regex'] as String?)?.isNotEmpty ?? false)) {
      return const LegacyNotificationMigrationIssue(
        NotificationMigrationIssue.invalidRegularExpression,
        'The imported regular expression is invalid. Update or replace it before using this configuration.',
      );
    }
    return const LegacyNotificationMigrationIssue(
      NotificationMigrationIssue.conversionFailed,
      'The previous notification settings could not be converted. Complete this configuration manually.',
    );
  }

  @override
  Future<void> cleanupMigratedSettings() async {
    if (_migratedApplicationIds.isEmpty) {
      _log.fine('No migrated notification settings require cleanup.');
      return;
    }
    for (final NotificationAlert alert in _pendingReviewAlerts) {
      try {
        await _alertStore?.record(alert);
      } catch (_) {
        // Diagnostics must not prevent cleanup of persisted migrations.
      }
    }
    await _cleanupPreferences(_preferences, 'asynchronous');
    await _cleanupPreferences(_legacyPreferences, 'legacy');
    _log.info(
      'Completed cleanup for ${_migratedApplicationIds.length} migrated notification registrations.',
    );
  }

  Future<Map<String, NotificationSample>> _legacySamples() async {
    final List<String> serializedEntries = <String>[
      ...?await _preferences.getStringList(_historyKey),
      ...?await _legacyPreferences.getStringList(_historyKey),
    ];
    final Map<String, NotificationSample> samples =
        <String, NotificationSample>{};
    for (final String serializedEntry in serializedEntries) {
      try {
        final Map<String, dynamic> entry =
            jsonDecode(serializedEntry) as Map<String, dynamic>;
        final String applicationId = entry['appName'] as String;
        final String title = entry['title'] as String;
        final String body = entry['body'] as String;
        final DateTime receivedAt = DateTime.fromMillisecondsSinceEpoch(
          entry['time'] as int,
        );
        if (title.trim().isEmpty || body.trim().isEmpty) continue;
        final NotificationSample? current = samples[applicationId];
        if (current == null || receivedAt.isAfter(current.receivedAt)) {
          samples[applicationId] = NotificationSample(
            title: title,
            body: body,
            receivedAt: receivedAt,
          );
        }
      } catch (_) {
        // Invalid history records cannot provide migration samples.
      }
    }
    return samples;
  }

  Future<void> _cleanupPreferences(
    NotificationMigrationPreferences preferences,
    String source,
  ) async {
    final List<String> usedApplications =
        await preferences.getStringList(_usedAppsKey) ?? <String>[];
    final Set<String> removedApplicationIds = <String>{};
    for (final String applicationId in _migratedApplicationIds) {
      try {
        await preferences.remove('$_appSettingsPrefix$applicationId');
        removedApplicationIds.add(applicationId);
      } catch (error) {
        await _recordFailure(applicationId, error);
      }
    }
    if (removedApplicationIds.isEmpty) {
      return;
    }

    final List<String> retainedApplications = usedApplications
        .where(
          (String applicationId) =>
              !removedApplicationIds.contains(applicationId),
        )
        .toList();
    try {
      await preferences.setStringList(_usedAppsKey, retainedApplications);
    } catch (error) {
      await _recordFailure('$source-listener-settings', error);
    }
  }

  Future<void> _recordFailure(String applicationId, Object error) async {
    try {
      await _alertStore?.record(
        NotificationAlert.failure(
          kind: NotificationAlertKind.migrationFailed,
          operation: 'Migrating legacy notification settings',
          message: error.toString(),
          applicationId: applicationId,
        ),
      );
    } catch (_) {
      // Diagnostics must not prevent migration of remaining listeners.
    }
  }
}

abstract interface class NotificationMigrationPreferences {
  Future<List<String>?> getStringList(String key);

  Future<String?> getString(String key);

  Future<void> setStringList(String key, List<String> value);

  Future<void> remove(String key);
}

class SharedPreferencesAsyncNotificationMigrationPreferences
    implements NotificationMigrationPreferences {
  const SharedPreferencesAsyncNotificationMigrationPreferences();

  SharedPreferencesAsync get _preferences => SharedPreferencesAsync();

  @override
  Future<String?> getString(String key) => _preferences.getString(key);

  @override
  Future<List<String>?> getStringList(String key) =>
      _preferences.getStringList(key);

  @override
  Future<void> remove(String key) async {
    await _preferences.remove(key);
  }

  @override
  Future<void> setStringList(String key, List<String> value) async {
    await _preferences.setStringList(key, value);
  }
}

class SharedPreferencesNotificationMigrationPreferences
    implements NotificationMigrationPreferences {
  const SharedPreferencesNotificationMigrationPreferences();

  Future<SharedPreferences> get _preferences => SharedPreferences.getInstance();

  @override
  Future<String?> getString(String key) async =>
      (await _preferences).getString(key);

  @override
  Future<List<String>?> getStringList(String key) async =>
      (await _preferences).getStringList(key);

  @override
  Future<void> remove(String key) async {
    await (await _preferences).remove(key);
  }

  @override
  Future<void> setStringList(String key, List<String> value) async {
    await (await _preferences).setStringList(key, value);
  }
}
