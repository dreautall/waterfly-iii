import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/application/rules/notification_condition_tree.dart';
import 'package:waterflyiii/notifications/domain/conditions/all_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/any_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_evaluation_result.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_date_time_formatter.dart';

import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_condition_editor.dart';
import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_condition_renderer_groups.dart';
import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_condition_summary.dart';

class RuleConditionClipboardState {
  RuleConditionClipboardState(TickerProvider vsync) {
    fade = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 300),
    );
    opacity = CurvedAnimation(parent: fade, curve: Curves.easeInOut);
  }

  ConditionClipboardEntry? entry;
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? snackBarController;
  ScaffoldMessengerState? messenger;
  late final AnimationController fade;
  late final CurvedAnimation opacity;
  ValueNotifier<Widget>? display;

  void dispose() {
    final ScaffoldFeatureController<SnackBar, SnackBarClosedReason>?
    controller = snackBarController;
    if (controller != null) {
      final ScaffoldMessengerState? currentMessenger = messenger;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (currentMessenger?.mounted ?? false) controller.close();
      });
    }
    snackBarController = null;
    messenger = null;
    opacity.dispose();
    fade.dispose();
    display?.dispose();
  }
}

extension RuleConditionClipboard on RuleConditionsSectionState {
  Widget? conditionPasteAction(
    NotificationCondition target,
    List<NotificationCondition> conditions,
    ValueChanged<List<NotificationCondition>> onPaste,
  ) {
    if (!canPasteInto(target)) return null;
    final ConditionClipboardEntry entry = clipboardState.entry!;
    void paste() {
      final NotificationCondition pasted = cloneCondition(entry.condition);
      if (entry.isMove) {
        moveClipboardCondition(entry, target, pasted);
      } else {
        onPaste(<NotificationCondition>[...conditions, pasted]);
      }
      hideClipboardSnackBar();
      setClipboard(null);
      highlightCondition(pasted);
      revealCondition(pasted);
    }

    if (entry.isMove) {
      return IconButton(
        tooltip: S.of(context).notificationsRuleMoveHere,
        onPressed: paste,
        icon: const Icon(Icons.drive_file_move_outline),
      );
    }
    return IconButton(
      tooltip: S.of(context).notificationsRulePaste,
      onPressed: paste,
      icon: const Icon(Icons.content_paste_outlined),
    );
  }

  Widget notOverflowMenu() => PopupMenuButton<GroupConditionAction>(
    tooltip: S.of(context).notificationsRuleConditionOptions,
    position: PopupMenuPosition.under,
    icon: const Icon(Icons.more_vert),
    itemBuilder: (BuildContext context) =>
        <PopupMenuEntry<GroupConditionAction>>[
          PopupMenuItem<GroupConditionAction>(
            enabled: false,
            value: GroupConditionAction.paste,
            child: Row(
              children: <Widget>[
                const Icon(Icons.content_paste_outlined),
                const SizedBox(width: 8),
                Text(S.of(context).notificationsRulePaste),
              ],
            ),
          ),
        ],
  );

  void copyCondition(NotificationCondition condition) {
    final ConditionClipboardEntry entry = ConditionClipboardEntry(
      condition: cloneCondition(condition),
    );
    setClipboard(entry);
    showClipboardSnackBar(entry);
  }

  void setClipboard(ConditionClipboardEntry? entry) {
    update(() => clipboardState.entry = entry);
    widget.onClipboardChanged(
      entry == null
          ? null
          : entry.isMove
          ? ConditionClipboardOperation.move
          : ConditionClipboardOperation.copy,
    );
  }

  void pasteConditionAtRoot() {
    if (!canPasteInto(null)) return;
    final ConditionClipboardEntry entry = clipboardState.entry!;
    final NotificationCondition pasted = cloneCondition(entry.condition);
    if (entry.isMove) {
      moveClipboardCondition(entry, null, pasted);
    } else {
      replaceConditions(<NotificationCondition>[...conditions, pasted]);
    }
    hideClipboardSnackBar();
    setClipboard(null);
    highlightCondition(pasted);
    revealCondition(pasted);
  }

  void moveConditionToClipboard(
    NotificationCondition condition,
    NotificationCondition removalCondition,
  ) {
    final ConditionClipboardEntry entry = ConditionClipboardEntry(
      condition: cloneCondition(condition),
      sourceCondition: condition,
      removalCondition: removalCondition,
    );
    setClipboard(entry);
    showClipboardSnackBar(entry);
  }

  void showClipboardSnackBar(ConditionClipboardEntry entry) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final Widget notice = clipboardNotice(entry, colors);
    if (clipboardState.display case final ValueNotifier<Widget> display) {
      display.value = notice;
    } else {
      clipboardState.display = ValueNotifier<Widget>(notice);
    }
    if (clipboardState.snackBarController != null) {
      clipboardState.fade.forward();
      return;
    }
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar();
    clipboardState.messenger = messenger;
    final ScaffoldFeatureController<SnackBar, SnackBarClosedReason> controller =
        messenger.showSnackBar(
          SnackBar(
            duration: const Duration(days: 1),
            behavior: SnackBarBehavior.fixed,
            padding: EdgeInsets.zero,
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: FadeTransition(
                opacity: clipboardState.opacity,
                child: Material(
                  key: const Key('condition-clipboard-surface'),
                  elevation: 8,
                  color: colors.surfaceContainerHigh,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: colors.outlineVariant),
                  ),
                  child: ValueListenableBuilder<Widget>(
                    valueListenable: clipboardState.display!,
                    builder:
                        (BuildContext context, Widget displayed, Widget? _) =>
                            displayed,
                  ),
                ),
              ),
            ),
          ),
          snackBarAnimationStyle: AnimationStyle.noAnimation,
        );
    clipboardState.snackBarController = controller;
    clipboardState.fade.forward();
    controller.closed.then((SnackBarClosedReason _) {
      if (!mounted ||
          !identical(clipboardState.snackBarController, controller)) {
        return;
      }
      clipboardState.snackBarController = null;
      if (identical(clipboardState.entry, entry)) {
        setClipboard(null);
      }
    });
  }

  void cancelConditionClipboard() {
    if (clipboardState.entry == null) return;
    hideClipboardSnackBar();
    setClipboard(null);
  }

  void hideClipboardSnackBar() {
    final ScaffoldFeatureController<SnackBar, SnackBarClosedReason>?
    controller = clipboardState.snackBarController;
    if (controller == null) return;
    clipboardState.fade.reverse().then((_) {
      if (!mounted ||
          !identical(clipboardState.snackBarController, controller) ||
          !clipboardState.fade.isDismissed) {
        return;
      }
      clipboardState.snackBarController = null;
      controller.close();
    });
  }

  Widget clipboardNotice(
    ConditionClipboardEntry entry,
    ColorScheme colors,
  ) => Padding(
    padding: const EdgeInsets.fromLTRB(12, 10, 8, 10),
    child: Row(
      key: Key(
        entry.isMove ? 'condition-move-snackbar' : 'condition-copy-snackbar',
      ),
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: colors.primaryContainer,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(
            entry.isMove ? Icons.drive_file_move_outline : Icons.copy_outlined,
            color: colors.onPrimaryContainer,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                entry.isMove
                    ? S.of(context).notificationsRuleMovingCondition
                    : S.of(context).notificationsRuleCopyingCondition,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: colors.onSurface),
              ),
              const SizedBox(height: 3),
              conditionTitle(entry.condition),
              const SizedBox(height: 3),
              Text(
                S.of(context).notificationsRuleSelectMoveDestination,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: colors.outline),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        TextButton(
          onPressed: cancelConditionClipboard,
          style: TextButton.styleFrom(foregroundColor: colors.primary),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
      ],
    ),
  );

  bool canPasteInto(NotificationCondition? target) {
    final ConditionClipboardEntry? entry = clipboardState.entry;
    if (entry == null) return false;
    return conditionTree.canPaste(
      roots: conditions,
      source: entry.sourceCondition ?? entry.condition,
      removal: entry.removalCondition,
      target: target,
    );
  }

  bool hasMoveTarget(
    NotificationCondition source,
    NotificationCondition removal,
  ) => conditionTree.hasMoveTarget(
    roots: conditions,
    source: source,
    removal: removal,
  );

  void moveClipboardCondition(
    ConditionClipboardEntry entry,
    NotificationCondition? target,
    NotificationCondition pasted,
  ) {
    final List<NotificationCondition> targetChildren = switch (target) {
      AllCondition(conditions: final List<NotificationCondition> conditions) =>
        conditions,
      AnyCondition(conditions: final List<NotificationCondition> conditions) =>
        conditions,
      _ => const <NotificationCondition>[],
    };
    if (target != null &&
        willFlattenGroupChildren(target, <NotificationCondition>[
          ...targetChildren,
          pasted,
        ])) {
      showFlattenedGroupsMessage();
    }
    final NotificationConditionTreeMoveResult result = conditionTree.move(
      roots: conditions,
      removal: entry.removalCondition!,
      target: target,
      pasted: pasted,
    );
    for (final MapEntry<NotificationCondition, NotificationCondition> entry
        in result.replacements.entries) {
      if (expandedConditions.remove(entry.key) ||
          identical(entry.key, target)) {
        expandedConditions.add(entry.value);
      }
    }
    expandedConditions.removeAll(result.removedContainers);
    replaceConditions(result.conditions);
  }

  void duplicateRootCondition(int index, NotificationCondition condition) {
    final NotificationCondition duplicate = widget.onDuplicateAt(index);
    highlightCondition(duplicate);
  }

  NotificationCondition cloneCondition(NotificationCondition condition) =>
      conditionTree.clone(condition);

  Widget conditionFooter({
    VoidCallback? onAdd,
    required VoidCallback onRemove,
  }) => Padding(
    padding: EdgeInsets.zero,
    child: Row(
      children: <Widget>[
        if (onAdd != null)
          ElevatedButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.add),
            label: Text(S.of(context).notificationsRuleAddCondition),
          ),
        const Spacer(),
        IconButton(
          tooltip: S.of(context).notificationsRuleDeleteCondition,
          onPressed: onRemove,
          icon: const Icon(Icons.delete_outline),
          iconSize: 18,
          style: IconButton.styleFrom(
            minimumSize: const Size(40, 40),
            maximumSize: const Size(40, 40),
            padding: EdgeInsets.zero,
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
            foregroundColor: Theme.of(context).colorScheme.onErrorContainer,
            shape: const CircleBorder(),
          ),
        ),
      ],
    ),
  );

  EvaluationContext get conditionEvaluationContext => EvaluationContext(
    notification: activeNotificationContext,
    extractionResults: <String, RegExpEvaluationResult>{
      for (final RegExpDefinition extractor in widget.extractors)
        extractor.id: extractor.evaluate(activeNotificationContext),
    },
    formattingPreferences: notificationFormattingPreferencesOf(context),
  );

  EvaluationContext get testEvaluationContext => EvaluationContext(
    notification: testNotificationContext,
    extractionResults: <String, RegExpEvaluationResult>{
      for (final RegExpDefinition extractor in widget.extractors)
        extractor.id: extractor.evaluate(testNotificationContext),
    },
    formattingPreferences: notificationFormattingPreferencesOf(context),
  );
}

class ConditionClipboardEntry {
  const ConditionClipboardEntry({
    required this.condition,
    this.sourceCondition,
    this.removalCondition,
  });

  final NotificationCondition condition;
  final NotificationCondition? sourceCondition;
  final NotificationCondition? removalCondition;

  bool get isMove => sourceCondition != null;
}
