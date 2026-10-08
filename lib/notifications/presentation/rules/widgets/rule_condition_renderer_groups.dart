import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/conditions/all_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/any_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/not_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/presentation/shared/definition_expandable_detail_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_menu_theme.dart';

import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_editor_shared.dart';

import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_condition_editor.dart';
import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_condition_clipboard.dart';
import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_condition_renderer.dart';

extension RuleConditionGroupRenderer on RuleConditionsSectionState {
  Widget expandableConditionCard({
    required NotificationCondition condition,
    required Widget leading,
    required Widget title,
    required Widget subtitle,
    required Widget child,
    Widget? actions,
    bool alignChevronWithNestedCards = false,
  }) {
    final bool expanded = expandedConditions.contains(condition);
    return DefinitionExpandableDetailCard(
      expanded: expanded,
      onTap: () => update(() {
        if (!expandedConditions.add(condition)) {
          expandedConditions.remove(condition);
        }
      }),
      leading: leading,
      title: title,
      subtitle: subtitle,
      expandedHeaderBorderRadius: const BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
      headerOpacity: isUnavailableMoveTarget(condition) ? 0.55 : 1,
      trailing: SizedBox(
        width: actions == null ? 48 : 96,
        height: 48,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ?actions,
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: alignChevronWithNestedCards ? 16 : 0,
                ),
                child: Center(
                  child: AnimatedRotation(
                    turns: expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeInOut,
                    child: const Icon(Icons.expand_more),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bellyColor: Theme.of(context).scaffoldBackgroundColor,
      bellyBorder: Border(
        left: BorderSide(color: conditionCardBackground(context), width: 3),
        bottom: BorderSide(color: conditionCardBackground(context), width: 3),
        right: BorderSide(color: conditionCardBackground(context), width: 3),
      ),
      bellyBorderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      ),
      belly: child,
    );
  }

  Color conditionCardBackground(BuildContext context) =>
      Theme.of(context).elevatedButtonTheme.style?.backgroundColor?.resolve(
        const <WidgetState>{},
      ) ??
      Theme.of(context).colorScheme.surfaceContainerLow;

  void replaceExpandedCondition(
    NotificationCondition previous,
    NotificationCondition replacement,
  ) => transferExpandedConditions(previous, replacement);

  void transferExpandedConditions(
    NotificationCondition previous,
    NotificationCondition replacement,
  ) {
    if (expandedConditions.remove(previous)) {
      expandedConditions.add(replacement);
    }
    switch ((previous, replacement)) {
      case (final AllCondition previous, final AllCondition replacement):
        transferExpandedConditionChildren(
          previous.conditions,
          replacement.conditions,
        );
      case (final AnyCondition previous, final AnyCondition replacement):
        transferExpandedConditionChildren(
          previous.conditions,
          replacement.conditions,
        );
      case (final NotCondition previous, final NotCondition replacement):
        transferExpandedConditions(previous.condition, replacement.condition);
    }
  }

  void transferExpandedConditionChildren(
    List<NotificationCondition> previous,
    List<NotificationCondition> replacement,
  ) {
    for (
      int index = 0;
      index < previous.length && index < replacement.length;
      index += 1
    ) {
      transferExpandedConditions(previous[index], replacement[index]);
    }
  }

  void replaceNotCondition(
    NotCondition previous,
    NotificationCondition child,
    ValueChanged<NotificationCondition> onChanged,
  ) {
    final NotificationCondition replacement = normalizedCondition(
      NotCondition(child),
    );
    replaceExpandedCondition(previous, replacement);
    onChanged(replacement);
  }

  List<NotificationCondition> normalizedGroupChildren(
    NotificationCondition group,
    List<NotificationCondition> conditions,
  ) => conditionTree.normalizeGroupChildren(group, conditions);

  bool willFlattenGroupChildren(
    NotificationCondition group,
    List<NotificationCondition> conditions,
  ) => conditionTree.willFlattenGroupChildren(group, conditions);

  void showFlattenedGroupsMessage() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(S.of(context).notificationsRuleFlattenedGroups)),
      snackBarAnimationStyle: ruleEditorMessageAnimation,
    );
  }

  NotificationCondition normalizedCondition(NotificationCondition condition) =>
      conditionTree.normalize(condition);

  Widget conditionOverflowMenu({
    VoidCallback? onEdit,
    required VoidCallback onRemove,
    VoidCallback? onDuplicate,
    required VoidCallback onCopy,
    required bool canMove,
    required VoidCallback onMove,
  }) => PopupMenuButton<ConditionCardAction>(
    tooltip: S.of(context).notificationsRuleConditionOptions,
    position: PopupMenuPosition.under,
    icon: const Icon(Icons.more_vert),
    onSelected: (ConditionCardAction action) => switch (action) {
      ConditionCardAction.edit => onEdit?.call(),
      ConditionCardAction.duplicate => onDuplicate?.call(),
      ConditionCardAction.copy => onCopy(),
      ConditionCardAction.move => onMove(),
      ConditionCardAction.remove => onRemove(),
    },
    itemBuilder: (BuildContext context) =>
        <PopupMenuEntry<ConditionCardAction>>[
          if (onEdit != null) ...<PopupMenuEntry<ConditionCardAction>>[
            PopupMenuItem<ConditionCardAction>(
              value: ConditionCardAction.edit,
              child: Row(
                children: <Widget>[
                  const Icon(Icons.edit_outlined),
                  const SizedBox(width: 8),
                  Text(S.of(context).notificationsRuleEdit),
                ],
              ),
            ),
            const NotificationMenuDivider(),
          ],
          PopupMenuItem<ConditionCardAction>(
            enabled: onDuplicate != null,
            value: ConditionCardAction.duplicate,
            child: Row(
              children: <Widget>[
                const Icon(Icons.copy_all_outlined),
                const SizedBox(width: 8),
                Text(S.of(context).notificationsRuleDuplicate),
              ],
            ),
          ),
          PopupMenuItem<ConditionCardAction>(
            value: ConditionCardAction.copy,
            child: Row(
              children: <Widget>[
                const Icon(Icons.copy_outlined),
                const SizedBox(width: 8),
                Text(S.of(context).notificationsRuleCopy),
              ],
            ),
          ),
          PopupMenuItem<ConditionCardAction>(
            enabled: canMove,
            value: ConditionCardAction.move,
            child: Row(
              children: <Widget>[
                const Icon(Icons.drive_file_move_outline),
                const SizedBox(width: 8),
                Text(S.of(context).notificationsRuleMove),
              ],
            ),
          ),
          const NotificationMenuDivider(),
          PopupMenuItem<ConditionCardAction>(
            value: ConditionCardAction.remove,
            child: Row(
              children: <Widget>[
                const Icon(Icons.delete_outline),
                const SizedBox(width: 8),
                Text(S.of(context).notificationsRuleDelete),
              ],
            ),
          ),
        ],
  );

  Widget groupConditionCard({
    required NotificationCondition condition,
    required String title,
    required IconData icon,
    required List<NotificationCondition> conditions,
    required ValueChanged<List<NotificationCondition>> onChanged,
    required VoidCallback onRemove,
    required VoidCallback? onMoveUp,
    required VoidCallback? onMoveDown,
    required int depth,
    required int groupDepth,
    required ValueChanged<List<NotificationCondition>> onPaste,
  }) => expandableConditionCard(
    condition: condition,
    alignChevronWithNestedCards: true,
    leading: conditionLeading(condition, icon),
    title: Text(title),
    subtitle: groupConditionSubtitle(condition, conditions),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: Column(
        children: <Widget>[
          for (final (int index, NotificationCondition child)
              in conditions.indexed)
            conditionNode(
              child,
              onChanged: (NotificationCondition condition) {
                final List<NotificationCondition> updated =
                    List<NotificationCondition>.from(conditions);
                updated[index] = condition;
                onChanged(updated);
              },
              onEdit: () => editCondition((NotificationCondition condition) {
                final List<NotificationCondition> updated =
                    List<NotificationCondition>.from(conditions);
                updated[index] = condition;
                onChanged(updated);
              }, child),
              onRemove: () => removeNestedCondition(child, () {
                final List<NotificationCondition> updated =
                    List<NotificationCondition>.from(conditions);
                updated.removeAt(index);
                onChanged(updated);
              }),
              onDuplicate: () {
                final NotificationCondition duplicate = cloneCondition(child);
                final List<NotificationCondition> updated =
                    List<NotificationCondition>.from(conditions)
                      ..insert(index + 1, duplicate);
                if (willFlattenGroupChildren(condition, updated)) {
                  showFlattenedGroupsMessage();
                }
                onChanged(normalizedGroupChildren(condition, updated));
                highlightCondition(duplicate);
              },
              onMoveUp: index == 0
                  ? null
                  : () =>
                        moveCondition(conditions, index, index - 1, onChanged),
              onMoveDown: index == conditions.length - 1
                  ? null
                  : () =>
                        moveCondition(conditions, index, index + 1, onChanged),
              depth: 0,
              groupDepth: groupDepth,
            ),
          conditionFooter(
            onAdd: () => addConditionToGroup(
              condition,
              groupDepth,
              conditions,
              onChanged,
            ),
            onRemove: onRemove,
          ),
        ],
      ),
    ),
    actions: conditionPasteAction(condition, conditions, onPaste),
  );
}
