import 'package:waterflyiii/notifications/application/stores/notification_definition_store.dart';
import 'package:waterflyiii/notifications/application/rules/resolve_notification_alert_rule.dart';
import 'package:waterflyiii/notifications/application/rules/save_rule_in_definition.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';

class NotificationRuleOperations {
  NotificationRuleOperations(NotificationDefinitionStore store)
    : _resolveAlertRule = ResolveNotificationAlertRule(store),
      _saveRule = SaveRuleInDefinition(store);

  final ResolveNotificationAlertRule _resolveAlertRule;
  final SaveRuleInDefinition _saveRule;

  Future<ResolveNotificationAlertRuleResult> resolveAlertRule(
    NotificationAlert alert,
  ) => _resolveAlertRule(alert);

  Future<SaveRuleInDefinitionResult> add({
    required String definitionId,
    required NotificationRule rule,
  }) => _saveRule.add(definitionId: definitionId, rule: rule);

  Future<SaveRuleInDefinitionResult> update({
    required String definitionId,
    required String originalRuleId,
    required NotificationRule rule,
  }) => _saveRule.update(
    definitionId: definitionId,
    originalRuleId: originalRuleId,
    rule: rule,
  );

  Future<SaveRuleInDefinitionResult> delete({
    required String definitionId,
    required String ruleId,
  }) => _saveRule.delete(definitionId: definitionId, ruleId: ruleId);
}
