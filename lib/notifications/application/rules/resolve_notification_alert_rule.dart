import 'package:waterflyiii/notifications/application/stores/notification_definition_store.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';

enum ResolveNotificationAlertRuleStatus { resolved, notFound, failed }

class ResolveNotificationAlertRuleResult {
  const ResolveNotificationAlertRuleResult._(
    this.status, {
    this.definition,
    this.rule,
  });

  const ResolveNotificationAlertRuleResult.resolved({
    required NotificationDefinition definition,
    required NotificationRule rule,
  }) : this._(
         ResolveNotificationAlertRuleStatus.resolved,
         definition: definition,
         rule: rule,
       );

  const ResolveNotificationAlertRuleResult.notFound()
    : this._(ResolveNotificationAlertRuleStatus.notFound);

  const ResolveNotificationAlertRuleResult.failed()
    : this._(ResolveNotificationAlertRuleStatus.failed);

  final ResolveNotificationAlertRuleStatus status;
  final NotificationDefinition? definition;
  final NotificationRule? rule;

  bool get succeeded => status == ResolveNotificationAlertRuleStatus.resolved;
}

class ResolveNotificationAlertRule {
  const ResolveNotificationAlertRule(this._store);

  final NotificationDefinitionStore _store;

  Future<ResolveNotificationAlertRuleResult> call(
    NotificationAlert alert,
  ) async {
    final String? definitionId = alert.definitionId;
    final String? ruleId = alert.ruleId;
    final String? ruleName = alert.ruleName;
    if (definitionId == null || (ruleId == null && ruleName == null)) {
      return const ResolveNotificationAlertRuleResult.notFound();
    }
    try {
      final List<NotificationDefinition> definitions = await _store.load();
      NotificationDefinition? definition = definitions
          .cast<NotificationDefinition?>()
          .firstWhere(
            (NotificationDefinition? candidate) =>
                candidate?.id == definitionId,
            orElse: () => null,
          );
      NotificationRule? rule = ruleId == null
          ? null
          : definition?.rules.cast<NotificationRule?>().firstWhere(
              (NotificationRule? candidate) => candidate?.id == ruleId,
              orElse: () => null,
            );
      if (rule == null && definition != null && ruleName != null) {
        rule = definition.rules.cast<NotificationRule?>().firstWhere(
          (NotificationRule? candidate) => candidate?.name == ruleName,
          orElse: () => null,
        );
      }
      if (definition == null && ruleName != null) {
        final List<NotificationDefinition> candidates = definitions
            .where(
              (NotificationDefinition candidate) =>
                  candidate.applicationId == alert.applicationId &&
                  candidate.rules.any(
                    (NotificationRule candidateRule) =>
                        candidateRule.name == ruleName,
                  ),
            )
            .toList();
        if (candidates.length == 1) {
          definition = candidates.single;
          rule = definition.rules.firstWhere(
            (NotificationRule candidate) => candidate.name == ruleName,
          );
        }
      }
      if (definition == null || rule == null) {
        return const ResolveNotificationAlertRuleResult.notFound();
      }
      return ResolveNotificationAlertRuleResult.resolved(
        definition: definition,
        rule: rule,
      );
    } catch (_) {
      return const ResolveNotificationAlertRuleResult.failed();
    }
  }
}
