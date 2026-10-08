import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';

void main() {
  // Keeps the alert fingerprint and first-seen time stable so persistence can
  // merge repeat failures into one future diagnostics card.
  test(
    'increments an existing alert occurrence without changing its identity',
    () {
      final NotificationAlert alert = NotificationAlert.failure(
        kind: NotificationAlertKind.definitionInvalid,
        operation: 'Validating notification definition',
        message: 'Required transaction fields are incomplete.',
        applicationId: 'com.example.bank',
      );

      final NotificationAlert repeatedAlert = alert.recordAnotherOccurrence();

      expect(repeatedAlert.fingerprint, alert.fingerprint);
      expect(repeatedAlert.createdAt, alert.createdAt);
      expect(repeatedAlert.occurrenceCount, 2);
    },
  );

  test('keeps rule alert identity stable when the rule is renamed', () {
    final NotificationAlert beforeRename = NotificationAlert.failure(
      kind: NotificationAlertKind.evaluationFailed,
      operation: 'Evaluating notification rule "Old name"',
      message: 'Both values must have the same type.',
      applicationId: 'com.example.bank',
      definitionId: 'bank-payment',
      ruleId: 'compare-payment-date',
    );
    final NotificationAlert afterRename = NotificationAlert.failure(
      kind: NotificationAlertKind.evaluationFailed,
      operation: 'Evaluating notification rule "New name"',
      message: 'Both values must have the same type.',
      applicationId: 'com.example.bank',
      definitionId: 'bank-payment',
      ruleId: 'compare-payment-date',
    );

    expect(afterRename.fingerprint, beforeRename.fingerprint);
  });

  test('keeps action failures distinct within the same rule', () {
    final NotificationAlert firstAction = NotificationAlert.failure(
      kind: NotificationAlertKind.actionFailed,
      operation: 'Applying Set amount for "Set payment"',
      message: 'The value source did not resolve.',
      applicationId: 'com.example.bank',
      definitionId: 'bank-payment',
      ruleId: 'set-payment',
      actionId: 'action-0',
    );
    final NotificationAlert secondAction = NotificationAlert.failure(
      kind: NotificationAlertKind.actionFailed,
      operation: 'Applying Set date for "Set payment"',
      message: 'The value source did not resolve.',
      applicationId: 'com.example.bank',
      definitionId: 'bank-payment',
      ruleId: 'set-payment',
      actionId: 'action-1',
    );

    expect(secondAction.fingerprint, isNot(firstAction.fingerprint));
  });

  // Retains enough notification context after serialization for a diagnostics
  // page to replay the failed input against an updated definition.
  test('round-trips a replayable notification alert through JSON', () {
    final NotificationAlert alert = NotificationAlert.failure(
      kind: NotificationAlertKind.evaluationFailed,
      operation: 'Evaluating notification definition',
      message: 'Unexpected error',
      applicationId: 'com.example.bank',
      definitionId: 'bank-payment',
      ruleId: 'set-transaction',
      ruleName: 'Set transaction',
      actionId: 'action-0',
      actionName: 'Set amount',
      migrationIssue: NotificationMigrationIssue.invalidRegularExpression,
      notification: NotificationContext(
        applicationId: 'com.example.bank',
        applicationName: 'Example Bank',
        deliveryId: 'android:notification:42',
        title: 'Card payment',
        body: 'Paid 12.50 CAD',
        receivedAt: DateTime(2026, 8, 30),
      ),
    );

    final NotificationAlert restored = NotificationAlert.fromJson(
      alert.toJson(),
    );

    expect(restored.fingerprint, alert.fingerprint);
    expect(restored.definitionId, 'bank-payment');
    expect(restored.ruleId, 'set-transaction');
    expect(restored.ruleName, 'Set transaction');
    expect(restored.actionId, 'action-0');
    expect(restored.actionName, 'Set amount');
    expect(
      restored.migrationIssue,
      NotificationMigrationIssue.invalidRegularExpression,
    );
    expect(restored.notification?.applicationName, 'Example Bank');
    expect(restored.notification?.deliveryId, 'android:notification:42');
    expect(restored.notification?.body, 'Paid 12.50 CAD');
  });

  test('loads alerts saved before migration issue codes were added', () {
    final Map<String, dynamic> json = NotificationAlert.failure(
      kind: NotificationAlertKind.migrationNeedsReview,
      operation: 'Reviewing imported notification settings',
      message: 'Review the imported setup.',
    ).toJson()..remove('migrationIssue');

    expect(NotificationAlert.fromJson(json).migrationIssue, isNull);
  });
}
