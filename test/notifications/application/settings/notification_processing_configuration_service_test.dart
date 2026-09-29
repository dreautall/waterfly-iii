import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/settings/notification_processing_configuration_service.dart';
import 'package:waterflyiii/notifications/application/settings/notification_processing_settings.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/conditions/all_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/not_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/value_exists_condition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/value_sources/literal_value_source.dart';

const NotificationDefinition definition = NotificationDefinition(
  id: 'bank',
  applicationId: 'com.example.bank',
  name: 'Example Bank',
  extractors: <RegExpDefinition>[],
  rules: <NotificationRule>[],
);

const String backupPassword = 'waterfly-iii-notification-processing-backup-v1';

void main() {
  const NotificationProcessingConfigurationService service =
      NotificationProcessingConfigurationService();

  test('round-trips an obfuscated zipped processing backup payload', () {
    const NotificationProcessingSettings settings =
        NotificationProcessingSettings(
          historyStorageMode: NotificationHistoryStorageMode.metadataOnly,
          historyRetention: NotificationHistoryRetention.ninetyDays,
        );
    final Uint8List payload = service.createBackup(
      definitions: const <NotificationDefinition>[definition],
      settings: settings,
      exportedAt: DateTime(2026, 9, 25, 12, 0),
    );

    final NotificationProcessingBackup backup = service.readBackup(payload);

    expect(payload.take(2), <int>[0x50, 0x4b]);
    expect(utf8.decode(payload, allowMalformed: true), isNot(contains('bank')));
    expect(
      utf8.decode(payload, allowMalformed: true),
      isNot(contains('waterfly-notification-processing-backup')),
    );
    expect(backup.definitions.single.name, definition.name);
    expect(backup.settings.historyStorageMode, settings.historyStorageMode);
    expect(backup.settings.historyRetention, settings.historyRetention);
  });

  test('rejects unsupported payloads', () {
    expect(
      () => service.readBackup(
        _backupArchive(<String, dynamic>{
          'format': 'unexpected',
          'version': 1,
          'definitions': <dynamic>[],
          'settings': NotificationProcessingSettings.defaults.toJson(),
        }),
      ),
      throwsA(isA<FormatException>()),
    );
  });

  test('rejects payloads without required backup data', () {
    expect(
      () => service.readBackup(
        _backupArchive(<String, dynamic>{
          'format': 'waterfly-notification-processing-backup',
          'version': 1,
        }),
      ),
      throwsA(isA<FormatException>()),
    );
  });

  test('rejects definitions exceeding the condition nesting limit', () {
    const NotificationDefinition deeplyNestedDefinition =
        NotificationDefinition(
          id: 'deep',
          applicationId: 'com.example.bank',
          name: 'Deep conditions',
          extractors: <RegExpDefinition>[],
          rules: <NotificationRule>[
            NotificationRule(
              id: 'rule',
              name: 'Rule',
              conditions: <NotificationCondition>[
                AllCondition(<NotificationCondition>[
                  NotCondition(
                    NotCondition(
                      NotCondition(
                        ValueExistsCondition(LiteralValueSource('value')),
                      ),
                    ),
                  ),
                ]),
              ],
              actions: <NotificationAction>[],
            ),
          ],
        );

    expect(
      () => service.readBackup(
        service.createBackup(
          definitions: const <NotificationDefinition>[deeplyNestedDefinition],
          settings: NotificationProcessingSettings.defaults,
          exportedAt: DateTime(2026, 9, 26),
        ),
      ),
      throwsA(
        isA<FormatException>().having(
          (FormatException error) => error.message,
          'message',
          'Notification condition nesting exceeds the supported maximum.',
        ),
      ),
    );
  });
}

Uint8List _backupArchive(Map<String, dynamic> payload) {
  final Archive archive = Archive()
    ..addFile(
      ArchiveFile.string(
        'notification-processing.bkp',
        const JsonEncoder.withIndent('  ').convert(payload),
      ),
    );
  return ZipEncoder(password: backupPassword).encodeBytes(archive);
}
