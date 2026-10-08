import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/rules/resolve_notification_alert_rule.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import '../../support/in_memory_notification_stores.dart';

void main() {
  const NotificationRule rule = NotificationRule(
    id: 'current-rule',
    name: 'Balance low',
    conditions: <NotificationCondition>[],
    actions: <NotificationAction>[],
  );
  const NotificationDefinition definition = NotificationDefinition(
    id: 'current-definition',
    applicationId: 'com.example.bank',
    name: 'Example Bank',
    extractors: <RegExpDefinition>[],
    rules: <NotificationRule>[rule],
  );

  NotificationAlert alert({
    String definitionId = 'old-definition',
    String ruleId = 'old-rule',
  }) => NotificationAlert.failure(
    kind: NotificationAlertKind.evaluationFailed,
    operation: 'evaluate',
    message: 'failed',
    applicationId: 'com.example.bank',
    definitionId: definitionId,
    ruleId: ruleId,
    ruleName: rule.name,
  );

  test('recovers a rule by name in the stored definition', () async {
    final ResolveNotificationAlertRule resolver = ResolveNotificationAlertRule(
      InMemoryNotificationDefinitionStore(<NotificationDefinition>[definition]),
    );

    final ResolveNotificationAlertRuleResult result = await resolver(
      alert(definitionId: definition.id),
    );

    expect(result.succeeded, isTrue);
    expect(result.definition, definition);
    expect(result.rule, rule);
  });

  test('recovers a rule from exactly one matching definition', () async {
    final ResolveNotificationAlertRule resolver = ResolveNotificationAlertRule(
      InMemoryNotificationDefinitionStore(<NotificationDefinition>[definition]),
    );

    final ResolveNotificationAlertRuleResult result = await resolver(alert());

    expect(result.succeeded, isTrue);
    expect(result.definition, definition);
    expect(result.rule, rule);
  });

  test('does not choose between ambiguous matching definitions', () async {
    final ResolveNotificationAlertRule resolver = ResolveNotificationAlertRule(
      InMemoryNotificationDefinitionStore(<NotificationDefinition>[
        definition,
        definition.copyWith(id: 'another-definition'),
      ]),
    );

    final ResolveNotificationAlertRuleResult result = await resolver(alert());

    expect(result.status, ResolveNotificationAlertRuleStatus.notFound);
  });
}
