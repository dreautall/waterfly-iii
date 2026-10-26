import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:waterflyiii/notifications/application/settings/notification_processing_settings.dart';
import 'package:waterflyiii/notifications/domain/conditions/condition_nesting.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_action_group.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';

class NotificationProcessingBackup {
  const NotificationProcessingBackup({
    required this.definitions,
    required this.settings,
  });

  final List<NotificationDefinition> definitions;
  final NotificationProcessingSettings settings;
}

class NotificationProcessingConfigurationService {
  const NotificationProcessingConfigurationService();

  static const String backupFormat = 'waterfly-notification-processing-backup';
  static const int formatVersion = 1;
  static const String _backupEntryName = 'notification-processing.bkp';
  static const String _backupPassword =
      'waterfly-iii-notification-processing-backup-v1';

  Uint8List createBackup({
    required List<NotificationDefinition> definitions,
    required NotificationProcessingSettings settings,
    required DateTime exportedAt,
  }) {
    final Map<String, dynamic> payload = <String, dynamic>{
      'format': backupFormat,
      'version': formatVersion,
      'exportedAt': exportedAt.toIso8601String(),
      'settings': settings.toJson(),
      'definitions': definitions
          .map((NotificationDefinition definition) => definition.toJson())
          .toList(),
    };
    final Archive archive = Archive()
      ..addFile(
        ArchiveFile.string(
          _backupEntryName,
          const JsonEncoder.withIndent('  ').convert(payload),
        ),
      );
    return ZipEncoder(password: _backupPassword).encodeBytes(archive);
  }

  NotificationProcessingBackup readBackup(Uint8List archiveBytes) {
    final Map<String, dynamic> data = _readBackupPayload(archiveBytes);
    _validateBundle(data, expectedFormat: backupFormat);
    final Object? definitions = data['definitions'];
    final Object? settings = data['settings'];
    if (definitions is! List<dynamic> || settings is! Map<String, dynamic>) {
      throw const FormatException('Invalid notification settings backup.');
    }
    return NotificationProcessingBackup(
      definitions: _definitionsFromJson(definitions),
      settings: NotificationProcessingSettings.fromJson(settings),
    );
  }

  Map<String, dynamic> _readBackupPayload(Uint8List archiveBytes) {
    try {
      final Archive archive = ZipDecoder().decodeBytes(
        archiveBytes,
        password: _backupPassword,
      );
      final ArchiveFile entry = archive.files.singleWhere(
        (ArchiveFile file) => file.isFile && file.name.endsWith('.bkp'),
        orElse: () => throw const FormatException(
          'Invalid notification settings backup.',
        ),
      );
      final Uint8List? bytes = entry.readBytes();
      if (bytes == null) {
        throw const FormatException('Invalid notification settings backup.');
      }
      final Object? payload = jsonDecode(utf8.decode(bytes));
      if (payload is! Map<String, dynamic>) {
        throw const FormatException('Invalid notification settings backup.');
      }
      return payload;
    } on FormatException {
      rethrow;
    } catch (_) {
      throw const FormatException('Invalid notification settings backup.');
    }
  }

  void _validateBundle(
    Map<String, dynamic> data, {
    required String expectedFormat,
  }) {
    if (data['format'] != expectedFormat || data['version'] != formatVersion) {
      throw const FormatException('Unsupported notification settings file.');
    }
  }

  List<NotificationDefinition> _definitionsFromJson(List<dynamic> values) {
    final List<NotificationDefinition> definitions = values
        .map(
          (dynamic value) =>
              NotificationDefinition.fromJson(value as Map<String, dynamic>),
        )
        .toList();
    for (final NotificationDefinition definition in definitions) {
      final bool exceedsMaximum = definition.rules.any(
        (NotificationRule rule) =>
            rule.conditions.any(
              (NotificationCondition condition) =>
                  conditionNestingDepth(condition) >
                  maximumConditionNestingDepth,
            ) ||
            rule.conditionalActionGroups.any(
              (NotificationActionGroup group) => group.conditions.any(
                (NotificationCondition condition) =>
                    conditionNestingDepth(condition) >
                    maximumConditionNestingDepth,
              ),
            ),
      );
      if (exceedsMaximum) {
        throw const FormatException(
          'Notification condition nesting exceeds the supported maximum.',
        );
      }
    }
    return definitions;
  }
}
