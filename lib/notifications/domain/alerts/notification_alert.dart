import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';

enum NotificationAlertKind {
  migrationFailed,
  migrationNeedsReview,
  definitionInvalid,
  evaluationFailed,
  actionFailed,
}

enum NotificationMigrationIssue {
  automaticCreationPaused,
  missingAutomaticAccount,
  missingApplicationName,
  missingSettings,
  invalidRegularExpression,
  expressionDoesNotMatchSample,
  ambiguousAmount,
  amountNotFound,
  sampleMissing,
  currencyUnresolved,
  conversionFailed,
}

extension NotificationAlertKindLabel on NotificationAlertKind {
  String get label => switch (this) {
    NotificationAlertKind.migrationFailed => 'Migration failed',
    NotificationAlertKind.migrationNeedsReview => 'Migration needs review',
    NotificationAlertKind.definitionInvalid => 'Definition invalid',
    NotificationAlertKind.evaluationFailed => 'Rule evaluation failed',
    NotificationAlertKind.actionFailed => 'Action failed',
  };
}

class NotificationAlert {
  const NotificationAlert({
    required this.fingerprint,
    required this.kind,
    required this.operation,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
    required this.occurrenceCount,
    this.applicationId,
    this.definitionId,
    this.ruleId,
    this.ruleName,
    this.actionId,
    this.actionName,
    this.notification,
    this.migrationIssue,
  });

  final String fingerprint;
  final NotificationAlertKind kind;
  final String operation;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int occurrenceCount;
  final String? applicationId;
  final String? definitionId;
  final String? ruleId;
  final String? ruleName;
  final String? actionId;
  final String? actionName;
  final NotificationContext? notification;
  final NotificationMigrationIssue? migrationIssue;

  factory NotificationAlert.failure({
    required NotificationAlertKind kind,
    required String operation,
    required String message,
    String? applicationId,
    String? definitionId,
    String? ruleId,
    String? ruleName,
    String? actionId,
    String? actionName,
    NotificationContext? notification,
    NotificationMigrationIssue? migrationIssue,
  }) {
    final DateTime now = DateTime.now();
    return NotificationAlert(
      fingerprint:
          '${kind.name}:${applicationId ?? ''}:${definitionId ?? ''}:${ruleId ?? ''}:${actionId ?? ''}:$message',
      kind: kind,
      operation: operation,
      message: message,
      createdAt: now,
      updatedAt: now,
      occurrenceCount: 1,
      applicationId: applicationId,
      definitionId: definitionId,
      ruleId: ruleId,
      ruleName: ruleName,
      actionId: actionId,
      actionName: actionName,
      notification: notification,
      migrationIssue: migrationIssue,
    );
  }

  NotificationAlert recordAnotherOccurrence({
    NotificationContext? notification,
  }) {
    return NotificationAlert(
      fingerprint: fingerprint,
      kind: kind,
      operation: operation,
      message: message,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      occurrenceCount: occurrenceCount + 1,
      applicationId: applicationId,
      definitionId: definitionId,
      ruleId: ruleId,
      ruleName: ruleName,
      actionId: actionId,
      actionName: actionName,
      notification: notification ?? this.notification,
      migrationIssue: migrationIssue,
    );
  }

  factory NotificationAlert.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic>? notification =
        json['notification'] as Map<String, dynamic>?;
    return NotificationAlert(
      fingerprint: json['fingerprint'] as String,
      kind: NotificationAlertKind.values.byName(json['kind'] as String),
      operation: json['operation'] as String,
      message: json['message'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      occurrenceCount: json['occurrenceCount'] as int,
      applicationId: json['applicationId'] as String?,
      definitionId: json['definitionId'] as String?,
      ruleId: json['ruleId'] as String?,
      ruleName: json['ruleName'] as String?,
      actionId: json['actionId'] as String?,
      actionName: json['actionName'] as String?,
      migrationIssue: _migrationIssueFromJson(json['migrationIssue']),
      notification: notification == null
          ? null
          : NotificationContext(
              applicationId: notification['applicationId'] as String?,
              applicationName: notification['applicationName'] as String?,
              deliveryId: notification['deliveryId'] as String?,
              title: notification['title'] as String,
              body: notification['body'] as String,
              receivedAt: DateTime.parse(notification['receivedAt'] as String),
            ),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'fingerprint': fingerprint,
    'kind': kind.name,
    'operation': operation,
    'message': message,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'occurrenceCount': occurrenceCount,
    'applicationId': applicationId,
    'definitionId': definitionId,
    'ruleId': ruleId,
    'ruleName': ruleName,
    'actionId': actionId,
    'actionName': actionName,
    'migrationIssue': migrationIssue?.name,
    'notification': notification == null
        ? null
        : <String, dynamic>{
            'applicationId': notification!.applicationId,
            'applicationName': notification!.applicationName,
            'deliveryId': notification!.deliveryId,
            'title': notification!.title,
            'body': notification!.body,
            'receivedAt': notification!.receivedAt.toIso8601String(),
          },
  };
}

NotificationMigrationIssue? _migrationIssueFromJson(Object? value) {
  if (value is! String) return null;
  return NotificationMigrationIssue.values
      .where((NotificationMigrationIssue issue) => issue.name == value)
      .firstOrNull;
}
