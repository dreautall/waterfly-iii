import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule_diagnostics.dart';
import 'package:waterflyiii/notifications/presentation/shared/definition_detail_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_empty_state.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';

class DefinitionRulesSection extends StatelessWidget {
  const DefinitionRulesSection({
    super.key,
    required this.rules,
    required this.extractors,
    required this.notificationContext,
    required this.onEditRule,
    required this.onAddRule,
    required this.onMoveRule,
  });

  final List<NotificationRule> rules;
  final List<RegExpDefinition> extractors;
  final NotificationContext notificationContext;
  final ValueChanged<NotificationRule> onEditRule;
  final VoidCallback onAddRule;
  final void Function(String ruleId, int targetIndex) onMoveRule;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          S.of(context).notificationsDefinitionRulesHeading,
          style: context.notificationSectionTitle,
        ),
        const SizedBox(height: 4),
        Text(
          S.of(context).notificationsDefinitionRulesOrderDescription,
          style: context.notificationSectionDescription,
        ),
        const SizedBox(height: 12),
        if (rules.isEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: NotificationInlineEmptyState(
              message: S.of(context).notificationsDefinitionNoRules,
            ),
          )
        else if (rules.length == 1)
          _RuleCard(
            rule: rules.single,
            extractors: extractors,
            notificationContext: notificationContext,
            onTap: () => onEditRule(rules.single),
            trailing: const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(Icons.chevron_right),
            ),
            blocksFollowingRules: false,
          )
        else
          ReorderableListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            buildDefaultDragHandles: false,
            proxyDecorator:
                (Widget child, int index, Animation<double> animation) => child,
            onReorderItem: (int oldIndex, int newIndex) {
              onMoveRule(rules[oldIndex].id, newIndex);
            },
            children: rules.indexed
                .map(
                  ((int, NotificationRule) entry) => _RuleCard(
                    key: ValueKey<String>(entry.$2.id),
                    rule: entry.$2,
                    extractors: extractors,
                    notificationContext: notificationContext,
                    onTap: () => onEditRule(entry.$2),
                    trailing: ReorderableDragStartListener(
                      index: entry.$1,
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(Icons.drag_handle),
                      ),
                    ),
                    blocksFollowingRules:
                        entry.$2.conditions.isEmpty &&
                        entry.$1 < rules.length - 1,
                    bottomPadding: entry.$1 == rules.length - 1 ? 0 : 8,
                  ),
                )
                .toList(),
          ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: onAddRule,
          icon: const Icon(Icons.add),
          label: Text(S.of(context).notificationsDefinitionAddRule),
        ),
      ],
    );
  }
}

class _RuleCard extends StatelessWidget {
  const _RuleCard({
    super.key,
    required this.rule,
    required this.extractors,
    required this.notificationContext,
    required this.onTap,
    required this.trailing,
    required this.blocksFollowingRules,
    this.bottomPadding = 0,
  });

  final NotificationRule rule;
  final List<RegExpDefinition> extractors;
  final NotificationContext notificationContext;
  final VoidCallback onTap;
  final Widget trailing;
  final bool blocksFollowingRules;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    final int incompleteActionCount = rule
        .diagnostics(
          extractors: extractors,
          notificationContext: notificationContext,
        )
        .incompleteFields
        .length;
    final bool needsSetup = incompleteActionCount > 0;
    final bool needsReview = rule.hasUnconfiguredConditionalActions;
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: DefinitionDetailCard(
        onTap: onTap,
        leading: Icon(
          needsSetup
              ? Icons.cancel_outlined
              : needsReview
              ? Icons.error_outline
              : blocksFollowingRules
              ? Icons.warning_amber_outlined
              : Icons.rule,
          color: needsSetup
              ? colors.error
              : needsReview
              ? colors.tertiary
              : blocksFollowingRules
              ? colors.tertiary
              : null,
        ),
        title: Text(rule.name),
        subtitle: _subtitle(
          context,
          needsSetup: needsSetup,
          needsReview: needsReview,
          blocksFollowingRules: blocksFollowingRules,
        ),
        trailing: trailing,
      ),
    );
  }

  Widget? _subtitle(
    BuildContext context, {
    required bool needsSetup,
    required bool needsReview,
    required bool blocksFollowingRules,
  }) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final List<Widget> lines = <Widget>[
      if (needsSetup)
        Text(
          S.of(context).notificationsRuleNeedsSetup,
          style: TextStyle(color: colors.error),
        )
      else if (needsReview)
        Text(
          S.of(context).notificationsRuleNeedsReview,
          style: TextStyle(color: colors.tertiary),
        )
      else if (blocksFollowingRules)
        Text(
          S.of(context).notificationsDefinitionRuleShadowsFollowing,
          style: TextStyle(color: colors.tertiary),
        ),
      if (rule.description.isNotEmpty)
        Text(
          rule.description,
          style: context.notificationSupportingText,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        )
      else if (!needsSetup && !needsReview && !blocksFollowingRules)
        Text(
          rule.conditionalActionGroups.isEmpty
              ? S
                    .of(context)
                    .notificationsDefinitionConditionActionCount(
                      rule.conditions.length,
                      rule.actions.length,
                    )
              : S
                    .of(context)
                    .notificationsDefinitionRuleConditionActionGroupCount(
                      rule.conditions.length,
                      rule.actions.length,
                      rule.conditionalActionGroups.length,
                    ),
          style: context.notificationSupportingText,
        ),
    ];
    if (lines.isEmpty) return null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines,
    );
  }
}
