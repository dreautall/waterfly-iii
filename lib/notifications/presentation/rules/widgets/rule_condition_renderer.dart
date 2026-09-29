import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/conditions/all_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/any_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/condition_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/conditions/not_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/presentation/shared/definition_detail_card.dart';

import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_condition_editor.dart';
import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_condition_clipboard.dart';
import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_condition_renderer_groups.dart';
import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_condition_summary.dart';

extension RuleConditionRenderer on RuleConditionsSectionState {
  List<Widget> conditionRows({bool includeBottomPadding = true}) => conditions
      .indexed
      .map(
        ((int, NotificationCondition) entry) => conditionNode(
          entry.$2,
          onChanged: (NotificationCondition condition) =>
              replaceConditionAt(entry.$1, condition),
          onEdit: () => editCondition(
            (NotificationCondition condition) =>
                replaceConditionAt(entry.$1, condition),
            entry.$2,
          ),
          onRemove: () => removeCondition(entry.$1, entry.$2),
          onDuplicate: () => duplicateRootCondition(entry.$1, entry.$2),
          onMoveUp: entry.$1 == 0
              ? null
              : () => moveCondition(conditions, entry.$1, entry.$1 - 1),
          onMoveDown: entry.$1 == conditions.length - 1
              ? null
              : () => moveCondition(conditions, entry.$1, entry.$1 + 1),
          includeBottomPadding:
              includeBottomPadding || entry.$1 != conditions.length - 1,
        ),
      )
      .toList();

  Widget conditionNode(
    NotificationCondition condition, {
    required ValueChanged<NotificationCondition> onChanged,
    required VoidCallback onEdit,
    required VoidCallback onRemove,
    VoidCallback? onDuplicate,
    VoidCallback? onMoveUp,
    VoidCallback? onMoveDown,
    NotificationCondition? moveRemovalCondition,
    int depth = 0,
    int groupDepth = 0,
    bool includeBottomPadding = true,
  }) {
    final EdgeInsets padding = EdgeInsets.only(
      left: depth == 0 ? 0 : 16,
      bottom: includeBottomPadding ? 8 : 0,
    );
    if (condition is AllCondition) {
      return groupConditionNode(
        condition: condition,
        conditions: condition.conditions,
        title: S.of(context).notificationsRuleAllConditionsMatch,
        icon: Icons.done_all,
        createGroup: AllCondition.new,
        padding: padding,
        onChanged: onChanged,
        onRemove: onRemove,
        onMoveUp: onMoveUp,
        onMoveDown: onMoveDown,
        depth: depth,
        groupDepth: groupDepth,
      );
    }
    if (condition is AnyCondition) {
      return groupConditionNode(
        condition: condition,
        conditions: condition.conditions,
        title: S.of(context).notificationsRuleAnyConditionMatches,
        icon: Icons.call_split,
        createGroup: AnyCondition.new,
        padding: padding,
        onChanged: onChanged,
        onRemove: onRemove,
        onMoveUp: onMoveUp,
        onMoveDown: onMoveDown,
        depth: depth,
        groupDepth: groupDepth,
      );
    }
    if (condition is NotCondition) {
      return conditionRemovalAnimation(
        condition,
        Padding(
          padding: padding,
          child: KeyedSubtree(
            key: conditionKey(condition),
            child: conditionHighlightAnimation(
              condition,
              expandableConditionCard(
                condition: condition,
                leading: conditionLeading(
                  condition,
                  Icons.not_interested_outlined,
                ),
                title: Text(
                  S.of(context).notificationsRuleConditionDoesNotMatch,
                ),
                subtitle: notConditionSubtitle(condition),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                  child: conditionNode(
                    condition.condition,
                    onChanged: (NotificationCondition child) =>
                        replaceNotCondition(condition, child, onChanged),
                    onEdit: () => editCondition(
                      (NotificationCondition child) =>
                          replaceNotCondition(condition, child, onChanged),
                      condition.condition,
                    ),
                    onRemove: onRemove,
                    onDuplicate: null,
                    moveRemovalCondition: moveRemovalCondition ?? condition,
                    depth: 0,
                    groupDepth: groupDepth + 1,
                    includeBottomPadding: false,
                  ),
                ),
                actions: notOverflowMenu(),
              ),
            ),
          ),
        ),
      );
    }

    return conditionRemovalAnimation(
      condition,
      Padding(
        padding: padding,
        child: KeyedSubtree(
          key: conditionKey(condition),
          child: conditionHighlightAnimation(
            condition,
            conditionCard(
              onPressed: onEdit,
              leading: conditionLeading(condition, Icons.rule),
              title: conditionTitle(condition),
              subtitle: conditionResultSubtitle(
                condition,
                conditionConfigurationSubtitle(condition),
              ),
              trailing: conditionOverflowMenu(
                onEdit: onEdit,
                onRemove: onRemove,
                onDuplicate: onDuplicate,
                onCopy: () => copyCondition(condition),
                canMove: hasMoveTarget(
                  condition,
                  moveRemovalCondition ?? condition,
                ),
                onMove: () => moveConditionToClipboard(
                  condition,
                  moveRemovalCondition ?? condition,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget groupConditionNode({
    required NotificationCondition condition,
    required List<NotificationCondition> conditions,
    required String title,
    required IconData icon,
    required NotificationCondition Function(List<NotificationCondition>)
    createGroup,
    required EdgeInsets padding,
    required ValueChanged<NotificationCondition> onChanged,
    required VoidCallback onRemove,
    required VoidCallback? onMoveUp,
    required VoidCallback? onMoveDown,
    required int depth,
    required int groupDepth,
  }) {
    void updateGroup(
      List<NotificationCondition> children, {
      required bool expand,
    }) {
      if (willFlattenGroupChildren(condition, children)) {
        showFlattenedGroupsMessage();
      }
      final NotificationCondition updated = createGroup(
        normalizedGroupChildren(condition, children),
      );
      replaceExpandedCondition(condition, updated);
      if (expand) expandedConditions.add(updated);
      onChanged(updated);
    }

    return conditionRemovalAnimation(
      condition,
      Padding(
        padding: padding,
        child: KeyedSubtree(
          key: conditionKey(condition),
          child: conditionHighlightAnimation(
            condition,
            groupConditionCard(
              title: title,
              icon: icon,
              conditions: conditions,
              condition: condition,
              onChanged: (List<NotificationCondition> children) =>
                  updateGroup(children, expand: false),
              onRemove: onRemove,
              onMoveUp: onMoveUp,
              onMoveDown: onMoveDown,
              depth: depth,
              onPaste: (List<NotificationCondition> children) =>
                  updateGroup(children, expand: true),
              groupDepth: groupDepth + 1,
            ),
          ),
        ),
      ),
    );
  }

  Widget conditionHighlightAnimation(
    NotificationCondition condition,
    Widget child,
  ) => TweenAnimationBuilder<Color?>(
    duration: const Duration(milliseconds: 1500),
    curve: Curves.easeOut,
    tween: ColorTween(
      end: isMovingCondition(condition)
          ? Theme.of(context).colorScheme.primary
          : highlightedConditions.contains(condition)
          ? Theme.of(context).colorScheme.primary
          : Colors.transparent,
    ),
    builder: (BuildContext context, Color? color, Widget? child) =>
        DecoratedBox(
          key: isMovingCondition(condition)
              ? const Key('condition-move-source')
              : null,
          position: DecorationPosition.foreground,
          decoration: BoxDecoration(
            border: Border.all(color: color ?? Colors.transparent, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: child,
        ),
    child: child,
  );

  bool isMovingCondition(NotificationCondition condition) =>
      identical(clipboardState.entry?.sourceCondition, condition);

  bool isUnavailableMoveTarget(NotificationCondition condition) =>
      (clipboardState.entry?.isMove ?? false) &&
      !isMovingCondition(condition) &&
      (condition is AllCondition || condition is AnyCondition) &&
      !canPasteInto(condition);

  Widget conditionRemovalAnimation(
    NotificationCondition condition,
    Widget child,
  ) => ClipRect(
    clipBehavior: removingConditions.contains(condition)
        ? Clip.hardEdge
        : Clip.none,
    child: AnimatedAlign(
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeInOut,
      alignment: Alignment.topCenter,
      heightFactor: removingConditions.contains(condition) ? 0 : 1,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeIn,
        opacity: removingConditions.contains(condition) ? 0 : 1,
        child: child,
      ),
    ),
  );

  Widget conditionCard({
    required VoidCallback onPressed,
    required Widget leading,
    required Widget title,
    required Widget? subtitle,
    required Widget trailing,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(8)),
  }) => DefinitionDetailCard(
    leading: leading,
    title: title,
    subtitle: subtitle,
    trailing: trailing,
    onTap: onPressed,
    borderRadius: borderRadius,
  );

  Widget? conditionResultSubtitle(
    NotificationCondition condition,
    Widget? source,
  ) {
    if (!isTestMode) {
      return conditionModeSubtitle(source ?? const SizedBox.shrink());
    }
    final ConditionEvaluationResult result = condition.evaluate(
      testEvaluationContext,
    );
    final Color color = result.isDiagnosticFailure
        ? Theme.of(context).colorScheme.tertiary
        : result.matches
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.outline;
    return conditionModeSubtitle(
      conditionTestSummary(
        condition,
        status: result.isDiagnosticFailure
            ? S.of(context).notificationsRuleCouldNotEvaluate
            : result.matches
            ? S.of(context).notificationsRuleMatches
            : S.of(context).notificationsRuleDoesNotMatch,
        statusColor: color,
      ),
    );
  }

  Widget conditionLeading(NotificationCondition condition, IconData icon) {
    final Widget child;
    if (!isTestMode) {
      child = Icon(icon, key: const ValueKey<String>('configuration'));
    } else {
      final ConditionEvaluationResult result = condition.evaluate(
        testEvaluationContext,
      );
      child = Icon(
        result.isDiagnosticFailure
            ? Icons.error_outline
            : result.matches
            ? Icons.check_circle_outline
            : Icons.circle_outlined,
        key: const ValueKey<String>('test'),
        color: result.isDiagnosticFailure
            ? Theme.of(context).colorScheme.tertiary
            : result.matches
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.outline,
      );
    }
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 180),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      transitionBuilder: (Widget child, Animation<double> animation) =>
          FadeTransition(
            key: const Key('condition-leading-fade'),
            opacity: animation,
            child: child,
          ),
      child: child,
    );
  }

  Widget notConditionSubtitle(NotCondition condition) {
    if (!isTestMode) {
      return conditionModeSubtitle(
        Text(
          S.of(context).notificationsRuleConditionCount(1),
          style: TextStyle(color: Theme.of(context).colorScheme.outline),
        ),
      );
    }
    final ConditionEvaluationResult result = condition.evaluate(
      testEvaluationContext,
    );
    final ConditionEvaluationResult nestedResult = condition.condition.evaluate(
      testEvaluationContext,
    );
    final Color statusColor = result.isDiagnosticFailure
        ? Theme.of(context).colorScheme.tertiary
        : result.matches
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.outline;
    final String nestedStatus = nestedResult.isDiagnosticFailure
        ? S.of(context).notificationsRuleCouldNotEvaluate
        : nestedResult.matches
        ? S.of(context).notificationsRuleMatches
        : S.of(context).notificationsRuleDoesNotMatch;
    return conditionModeSubtitle(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            result.isDiagnosticFailure
                ? S.of(context).notificationsRuleCouldNotEvaluate
                : result.matches
                ? S.of(context).notificationsRuleMatches
                : S.of(context).notificationsRuleDoesNotMatch,
            style: TextStyle(color: statusColor),
          ),
          const SizedBox(height: 3),
          Text(
            S.of(context).notificationsRuleNestedConditionResult(nestedStatus),
            style: TextStyle(color: Theme.of(context).colorScheme.outline),
          ),
        ],
      ),
    );
  }

  Widget groupConditionSubtitle(
    NotificationCondition condition,
    List<NotificationCondition> conditions,
  ) {
    if (!isTestMode) {
      return conditionModeSubtitle(
        Text(
          S.of(context).notificationsRuleConditionCount(conditions.length),
          style: TextStyle(color: Theme.of(context).colorScheme.outline),
        ),
      );
    }

    final List<ConditionEvaluationResult> results = conditions
        .map(
          (NotificationCondition child) =>
              child.evaluate(testEvaluationContext),
        )
        .toList();
    final int matched = results
        .where((ConditionEvaluationResult result) => result.matches)
        .length;
    final int unresolved = results
        .where((ConditionEvaluationResult result) => result.isDiagnosticFailure)
        .length;
    final ConditionEvaluationResult result = condition.evaluate(
      testEvaluationContext,
    );
    final Color statusColor = result.isDiagnosticFailure
        ? Theme.of(context).colorScheme.tertiary
        : result.matches
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.outline;
    return conditionModeSubtitle(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            result.isDiagnosticFailure
                ? S.of(context).notificationsRuleCouldNotEvaluate
                : result.matches
                ? S.of(context).notificationsRuleMatches
                : S.of(context).notificationsRuleDoesNotMatch,
            style: TextStyle(color: statusColor),
          ),
          const SizedBox(height: 3),
          Text(
            <String>[
              S
                  .of(context)
                  .notificationsRuleConditionMatchSummary(
                    matched,
                    conditions.length,
                  ),
              if (unresolved > 0)
                S
                    .of(context)
                    .notificationsRuleConditionUnresolvedSummary(unresolved),
            ].join(' · '),
            style: TextStyle(color: Theme.of(context).colorScheme.outline),
          ),
        ],
      ),
    );
  }

  Widget conditionModeSubtitle(Widget child) => AnimatedSize(
    duration: const Duration(milliseconds: 240),
    curve: Curves.easeInOut,
    alignment: Alignment.topLeft,
    child: AnimatedSwitcher(
      duration: const Duration(milliseconds: 180),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) =>
          Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[...previousChildren, ?currentChild],
          ),
      transitionBuilder: (Widget child, Animation<double> animation) =>
          FadeTransition(
            key: const Key('condition-mode-fade'),
            opacity: animation,
            child: child,
          ),
      child: KeyedSubtree(key: ValueKey<bool>(isTestMode), child: child),
    ),
  );
}
