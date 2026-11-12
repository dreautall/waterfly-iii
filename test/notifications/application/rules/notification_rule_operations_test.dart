import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/rules/notification_rule_operations.dart';
import 'package:waterflyiii/notifications/application/rules/resolve_notification_alert_rule.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import '../../support/in_memory_notification_stores.dart';

void main() {
  const NotificationRule existingRule = NotificationRule(
    id: 'rule',
    name: 'Balance low',
    conditions: <NotificationCondition>[],
    actions: <NotificationAction>[],
  );
  const NotificationDefinition definition = NotificationDefinition(
    id: 'definition',
    applicationId: 'com.example.bank',
    name: 'Example Bank',
    extractors: <RegExpDefinition>[],
    rules: <NotificationRule>[existingRule],
  );

  test('creates rules and resolves alert rule targets', () async {
    final InMemoryNotificationDefinitionStore store =
        InMemoryNotificationDefinitionStore(<NotificationDefinition>[
          definition,
        ]);
    final NotificationRuleOperations operations = NotificationRuleOperations(
      store,
    );
    const NotificationRule addedRule = NotificationRule(
      id: 'added',
      name: 'New rule',
      conditions: <NotificationCondition>[],
      actions: <NotificationAction>[],
    );

    expect(
      (await operations.add(
        definitionId: definition.id,
        rule: addedRule,
      )).succeeded,
      isTrue,
    );
    final ResolveNotificationAlertRuleResult resolution = await operations
        .resolveAlertRule(
          NotificationAlert.failure(
            kind: NotificationAlertKind.evaluationFailed,
            operation: 'evaluate',
            message: 'failed',
            applicationId: definition.applicationId,
            definitionId: definition.id,
            ruleId: existingRule.id,
            ruleName: existingRule.name,
          ),
        );

    expect(resolution.succeeded, isTrue);
    expect(resolution.definition?.id, definition.id);
    expect(
      resolution.definition?.rules.map((NotificationRule rule) => rule.id),
      <String>[existingRule.id, addedRule.id],
    );
    expect(resolution.rule?.id, existingRule.id);
  });
}
