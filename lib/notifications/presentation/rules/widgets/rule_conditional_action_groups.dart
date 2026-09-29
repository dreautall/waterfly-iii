import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_action_group.dart';
import 'package:waterflyiii/notifications/presentation/shared/definition_detail_card.dart';
import 'package:waterflyiii/notifications/presentation/rules/widgets/rename_rule_dialog.dart';
import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_editor_section.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_empty_state.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_menu_theme.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_dialog.dart';

import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_editor_shared.dart';

enum _ConditionalActionCardAction { edit, rename, duplicate, delete }

class RuleConditionalActionGroupsSection extends StatefulWidget {
  const RuleConditionalActionGroupsSection({
    super.key,
    required this.groups,
    required this.onAdd,
    required this.onEdit,
    required this.onReplace,
    required this.onDuplicate,
    required this.onRemove,
    required this.onMove,
  });

  final List<NotificationActionGroup> groups;
  final VoidCallback onAdd;
  final ValueChanged<NotificationActionGroup> onEdit;
  final ValueChanged<NotificationActionGroup> onReplace;
  final NotificationActionGroup Function(NotificationActionGroup group)
  onDuplicate;
  final ValueChanged<String> onRemove;
  final void Function(int fromIndex, int toIndex) onMove;

  @override
  State<RuleConditionalActionGroupsSection> createState() =>
      _RuleConditionalActionGroupsSectionState();
}

class _RuleConditionalActionGroupsSectionState
    extends State<RuleConditionalActionGroupsSection> {
  final Set<String> _highlightedGroupIds = <String>{};
  final Map<String, Timer> _highlightTimers = <String, Timer>{};

  @override
  void dispose() {
    for (final Timer timer in _highlightTimers.values) {
      timer.cancel();
    }
    super.dispose();
  }

  void _duplicate(NotificationActionGroup group) {
    final NotificationActionGroup duplicate = widget.onDuplicate(group);
    _highlightTimers.remove(duplicate.id)?.cancel();
    setState(() => _highlightedGroupIds.add(duplicate.id));
    _highlightTimers[duplicate.id] = Timer(
      const Duration(milliseconds: 1500),
      () {
        if (mounted) {
          setState(() => _highlightedGroupIds.remove(duplicate.id));
        }
        _highlightTimers.remove(duplicate.id);
      },
    );
  }

  Future<void> _rename(NotificationActionGroup group) async {
    final String? name = await showNotificationDialog<String>(
      context: context,
      builder: (BuildContext context) => RenameRuleDialog(
        name: group.name,
        title: S.of(context).notificationsRuleRenameConditionalActionTitle,
        description: S
            .of(context)
            .notificationsRuleRenameConditionalActionDescription,
        nameLabel: S.of(context).notificationsRuleConditionalActionName,
      ),
    );
    if (name == null || name.isEmpty || !mounted) return;
    widget.onReplace(group.copyWith(name: name));
  }

  Future<void> _delete(NotificationActionGroup group) async {
    final bool confirmed = await showRuleRemovalConfirmation(
      context,
      title: S.of(context).notificationsRuleRemoveConditionalActionTitle,
      content: S
          .of(context)
          .notificationsRuleRemoveConditionalActionDescription(group.name),
    );
    if (confirmed && mounted) widget.onRemove(group.id);
  }

  Future<void> _handleAction(
    _ConditionalActionCardAction action,
    NotificationActionGroup group,
  ) async {
    switch (action) {
      case _ConditionalActionCardAction.edit:
        widget.onEdit(group);
        return;
      case _ConditionalActionCardAction.rename:
        await _rename(group);
        return;
      case _ConditionalActionCardAction.duplicate:
        _duplicate(group);
        return;
      case _ConditionalActionCardAction.delete:
        await _delete(group);
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final bool canReorder = widget.groups.length > 1;
    final List<Widget> groupCards = widget.groups.indexed
        .map(
          ((int, NotificationActionGroup) entry) => Padding(
            key: ValueKey<String>(entry.$2.id),
            padding: EdgeInsets.only(
              bottom: entry.$1 == widget.groups.length - 1 ? 0 : 8,
            ),
            child: TweenAnimationBuilder<Color?>(
              duration: const Duration(milliseconds: 1500),
              curve: Curves.easeOut,
              tween: ColorTween(
                end: _highlightedGroupIds.contains(entry.$2.id)
                    ? colors.primary
                    : Colors.transparent,
              ),
              builder: (BuildContext context, Color? color, Widget? child) =>
                  DecoratedBox(
                    position: DecorationPosition.foreground,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: color ?? Colors.transparent,
                        width: 2,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    child: child,
                  ),
              child: DefinitionDetailCard(
                onTap: () => widget.onEdit(entry.$2),
                leading: Icon(
                  entry.$2.conditions.isEmpty || entry.$2.actions.isEmpty
                      ? Icons.error_outline
                      : Icons.alt_route,
                  color: entry.$2.conditions.isEmpty || entry.$2.actions.isEmpty
                      ? colors.tertiary
                      : null,
                ),
                title: Text(entry.$2.name),
                subtitle: Text(
                  !entry.$2.isConfigured
                      ? S.of(context).notificationsRuleNeedsReview
                      : S
                            .of(context)
                            .notificationsDefinitionConditionActionCount(
                              entry.$2.conditions.length,
                              entry.$2.actions.length,
                            ),
                  style: !entry.$2.isConfigured
                      ? TextStyle(color: colors.tertiary)
                      : TextStyle(color: colors.outline),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    PopupMenuButton<_ConditionalActionCardAction>(
                      tooltip: S
                          .of(context)
                          .notificationsRuleConditionalActionOptions,
                      position: PopupMenuPosition.under,
                      onSelected: (_ConditionalActionCardAction action) =>
                          _handleAction(action, entry.$2),
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<_ConditionalActionCardAction>>[
                            PopupMenuItem<_ConditionalActionCardAction>(
                              value: _ConditionalActionCardAction.edit,
                              child: Row(
                                children: <Widget>[
                                  const Icon(Icons.edit_outlined),
                                  const SizedBox(width: 8),
                                  Text(S.of(context).notificationsRuleEdit),
                                ],
                              ),
                            ),
                            PopupMenuItem<_ConditionalActionCardAction>(
                              value: _ConditionalActionCardAction.rename,
                              child: Row(
                                children: <Widget>[
                                  const Icon(Icons.drive_file_rename_outline),
                                  const SizedBox(width: 8),
                                  Text(S.of(context).notificationsRuleRename),
                                ],
                              ),
                            ),
                            const NotificationMenuDivider(),
                            PopupMenuItem<_ConditionalActionCardAction>(
                              value: _ConditionalActionCardAction.duplicate,
                              child: Row(
                                children: <Widget>[
                                  const Icon(Icons.copy_all_outlined),
                                  const SizedBox(width: 8),
                                  Text(
                                    S.of(context).notificationsRuleDuplicate,
                                  ),
                                ],
                              ),
                            ),
                            const NotificationMenuDivider(),
                            PopupMenuItem<_ConditionalActionCardAction>(
                              value: _ConditionalActionCardAction.delete,
                              child: Row(
                                children: <Widget>[
                                  const Icon(Icons.delete_outline),
                                  const SizedBox(width: 8),
                                  Text(S.of(context).notificationsRuleDelete),
                                ],
                              ),
                            ),
                          ],
                    ),
                    if (canReorder)
                      ReorderableDragStartListener(
                        index: entry.$1,
                        child: const Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(Icons.drag_handle),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        )
        .toList();

    return RuleEditorSection(
      title: S.of(context).notificationsRuleConditionalActionsTitle,
      description: S.of(context).notificationsRuleConditionalActionsDescription,
      content: widget.groups.isEmpty
          ? NotificationInlineEmptyState(
              message: S.of(context).notificationsRuleNoConditionalActions,
            )
          : canReorder
          ? ReorderableListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              buildDefaultDragHandles: false,
              onReorderItem: widget.onMove,
              children: groupCards,
            )
          : Column(children: groupCards),
      action: ElevatedButton.icon(
        onPressed: widget.onAdd,
        icon: const Icon(Icons.add),
        label: Text(S.of(context).notificationsRuleAddConditionalActions),
      ),
    );
  }
}
