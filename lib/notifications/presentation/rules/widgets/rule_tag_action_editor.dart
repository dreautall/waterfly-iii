import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_tags_action.dart';
import 'package:waterflyiii/notifications/presentation/shared/definition_expandable_detail_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';

import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_action_editor.dart';

extension RuleTagActionEditor on RuleActionsSectionState {
  Widget tagActionCard(
    int index,
    SetTransactionTagsAction action, {
    required double bottomPadding,
  }) {
    final bool expanded = expandedTagActions.contains(action);
    return actionRemovalAnimation(
      action,
      Padding(
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: actionHighlightAnimation(
          action,
          DefinitionExpandableDetailCard(
            expanded: expanded,
            onTap: () => update(() {
              if (!expandedTagActions.add(action)) {
                expandedTagActions.remove(action);
              }
            }),
            leading: const Icon(Icons.playlist_add_check),
            title: Text(S.of(context).notificationsRuleSetTransactionTags),
            subtitle: Text(
              S
                  .of(context)
                  .notificationsRuleSelectedTagCount(action.tags.length),
              style: context.notificationSupportingText,
            ),
            expandedHeaderBorderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            trailing: SizedBox(
              width: 48,
              child: Center(
                child: AnimatedRotation(
                  turns: expanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeInOut,
                  child: const Icon(Icons.expand_more),
                ),
              ),
            ),
            bellyColor: Theme.of(context).scaffoldBackgroundColor,
            bellyBorder: Border(
              left: BorderSide(
                color: conditionCardBackground(context),
                width: 3,
              ),
              bottom: BorderSide(
                color: conditionCardBackground(context),
                width: 3,
              ),
              right: BorderSide(
                color: conditionCardBackground(context),
                width: 3,
              ),
            ),
            bellyBorderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            bellyPadding: const EdgeInsets.fromLTRB(12, 12, 8, 12),
            belly: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Wrap(
                  spacing: 8,
                  runSpacing: 0,
                  children: action.tags
                      .map(
                        (String tag) => InputChip(
                          label: Text(tag),
                          onDeleted: () => removeTagFromAction(index, tag),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    ElevatedButton.icon(
                      onPressed: () => editAction(index),
                      icon: const Icon(Icons.add),
                      label: Text(S.of(context).notificationsRuleAddTags),
                    ),
                    const Spacer(),
                    IconButton(
                      tooltip: S.of(context).notificationsRuleRemoveActionTitle,
                      onPressed: () => removeAction(index),
                      icon: const Icon(Icons.delete_outline),
                      iconSize: 18,
                      style: IconButton.styleFrom(
                        minimumSize: const Size(40, 40),
                        maximumSize: const Size(40, 40),
                        padding: EdgeInsets.zero,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.errorContainer,
                        foregroundColor: Theme.of(
                          context,
                        ).colorScheme.onErrorContainer,
                        shape: const CircleBorder(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void removeTagFromAction(int index, String tag) {
    final SetTransactionTagsAction current =
        actions[index] as SetTransactionTagsAction;
    final SetTransactionTagsAction replacement = widget.onRemoveTag(index, tag);
    update(() {
      expandedTagActions.remove(current);
      expandedTagActions.add(replacement);
    });
  }
}
