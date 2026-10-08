import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/application/rules/notification_condition_tree.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/value_sources/date_time_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/firefly_resource_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/literal_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/normalized_amount_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/notification_property_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/value_source.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/conditions/condition_builder_dialog.dart';
import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_editor_section.dart';

import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_editor_shared.dart';

import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_condition_clipboard.dart';
import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_condition_renderer.dart';
import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_condition_renderer_groups.dart';

enum ConditionCardAction { edit, duplicate, copy, move, remove }

enum ConditionClipboardOperation { copy, move }

enum GroupConditionAction { paste }

class RuleConditionsSection extends StatefulWidget {
  const RuleConditionsSection({
    super.key,
    required this.conditions,
    required this.extractors,
    required this.notificationContext,
    required this.activeNotificationContext,
    required this.testNotificationContext,
    required this.isTestMode,
    required this.ruleName,
    required this.onReplaceAt,
    required this.onReplaceAll,
    required this.onRemoveAt,
    required this.onMove,
    required this.onDuplicateAt,
    required this.onClipboardChanged,
    this.title,
    this.description,
    this.emptyText,
  });

  final List<NotificationCondition> conditions;
  final List<RegExpDefinition> extractors;
  final NotificationContext notificationContext;
  final NotificationContext activeNotificationContext;
  final NotificationContext testNotificationContext;
  final bool isTestMode;
  final String ruleName;
  final void Function(int, NotificationCondition) onReplaceAt;
  final ValueChanged<List<NotificationCondition>> onReplaceAll;
  final ValueChanged<int> onRemoveAt;
  final void Function(int, int) onMove;
  final NotificationCondition Function(int) onDuplicateAt;
  final ValueChanged<ConditionClipboardOperation?> onClipboardChanged;
  final String? title;
  final String? description;
  final String? emptyText;

  @override
  State<RuleConditionsSection> createState() => RuleConditionsSectionState();
}

/// Internal extension host shared by the condition rendering modules.
class RuleConditionsSectionState extends State<RuleConditionsSection>
    with SingleTickerProviderStateMixin {
  final NotificationConditionTree conditionTree =
      const NotificationConditionTree();
  final Set<NotificationCondition> expandedConditions =
      <NotificationCondition>{};
  final Map<NotificationCondition, GlobalKey> conditionKeys =
      <NotificationCondition, GlobalKey>{};
  final Set<NotificationCondition> highlightedConditions =
      <NotificationCondition>{};
  final Map<NotificationCondition, Timer> conditionHighlightTimers =
      <NotificationCondition, Timer>{};
  final Set<NotificationCondition> removingConditions =
      <NotificationCondition>{};
  final Map<NotificationCondition, Timer> conditionRemovalTimers =
      <NotificationCondition, Timer>{};
  late final RuleConditionClipboardState clipboardState;

  List<NotificationCondition> get conditions => widget.conditions;
  bool get isTestMode => widget.isTestMode;
  NotificationContext get activeNotificationContext =>
      widget.activeNotificationContext;
  NotificationContext get testNotificationContext =>
      widget.testNotificationContext;

  @override
  void initState() {
    super.initState();
    clipboardState = RuleConditionClipboardState(this);
  }

  @override
  void dispose() {
    clipboardState.dispose();
    for (final Timer timer in conditionHighlightTimers.values) {
      timer.cancel();
    }
    for (final Timer timer in conditionRemovalTimers.values) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);
    return RuleEditorSection(
      title: widget.title ?? strings.notificationsRuleConditionsTitle,
      description:
          widget.description ?? strings.notificationsRuleConditionsDescription,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (conditions.isEmpty)
            RuleEditorEmptyState(
              widget.emptyText ?? strings.notificationsRuleNoConditions,
            )
          else
            ...conditionRows(includeBottomPadding: false),
        ],
      ),
      action: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: <Widget>[
          ElevatedButton.icon(
            onPressed: addCondition,
            icon: const Icon(Icons.add),
            label: Text(strings.notificationsRuleAddCondition),
          ),
          if (canPasteInto(null))
            ElevatedButton.icon(
              key: const Key('condition-root-paste'),
              onPressed: pasteConditionAtRoot,
              icon: Icon(
                clipboardState.entry!.isMove
                    ? Icons.drive_file_move_outline
                    : Icons.content_paste_outlined,
              ),
              label: Text(
                clipboardState.entry!.isMove
                    ? strings.notificationsRuleMoveHere
                    : strings.notificationsRulePasteHere,
              ),
            ),
        ],
      ),
    );
  }

  void update(VoidCallback action) => setState(action);

  void replaceConditionAt(int index, NotificationCondition condition) =>
      widget.onReplaceAt(index, condition);

  void replaceConditions(List<NotificationCondition> conditions) =>
      widget.onReplaceAll(conditions);

  String sourceText(ValueSource source) {
    if (source is LiteralValueSource) return '"${source.value}"';
    if (source is NotificationPropertyValueSource) {
      return switch (source.property) {
        NotificationProperty.title =>
          S.of(context).notificationsExtractorNotificationTitle,
        NotificationProperty.body =>
          S.of(context).notificationsExtractorNotificationMessage,
      };
    }
    if (source is RegExpCaptureValueSource) return source.captureName;
    if (source is DateTimeCaptureValueSource) return source.capture.captureName;
    if (source is NormalizedAmountCaptureValueSource) {
      return source.capture.captureName;
    }
    if (source is FireflyResourceValueSource) return source.resourceId;
    return source.runtimeType.toString();
  }

  RegExpDefinition? extractorFor(RegExpCaptureValueSource source) =>
      widget.extractors.cast<RegExpDefinition?>().firstWhere(
        (RegExpDefinition? item) => item?.id == source.extractorId,
        orElse: () => null,
      );

  String extractorName(RegExpCaptureValueSource source) =>
      extractorFor(source)?.definitionName ??
      S.of(context).notificationsRuleDeletedExtractor;

  void highlightCondition(NotificationCondition condition) {
    conditionHighlightTimers.remove(condition)?.cancel();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      update(() => highlightedConditions.add(condition));
      conditionHighlightTimers[condition] = Timer(
        const Duration(milliseconds: 2500),
        () {
          if (mounted) {
            update(() => highlightedConditions.remove(condition));
          }
          conditionHighlightTimers.remove(condition);
        },
      );
    });
  }

  GlobalKey conditionKey(NotificationCondition condition) =>
      conditionKeys.putIfAbsent(condition, GlobalKey.new);

  void revealCondition(NotificationCondition condition) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future<void>.delayed(const Duration(milliseconds: 180), () {
        if (!mounted) return;
        final BuildContext? conditionContext =
            conditionKeys[condition]?.currentContext;
        if (conditionContext != null && conditionContext.mounted) {
          Scrollable.ensureVisible(
            conditionContext,
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeInOut,
            alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
          );
        }
      });
    });
  }

  void animateConditionRemoval(
    NotificationCondition condition,
    VoidCallback onComplete,
  ) {
    if (!removingConditions.add(condition)) return;
    update(() {});
    conditionRemovalTimers[condition] = Timer(
      const Duration(milliseconds: 240),
      () {
        if (!mounted) return;
        onComplete();
        update(() => removingConditions.remove(condition));
        conditionRemovalTimers.remove(condition);
      },
    );
  }
}

extension RuleConditionWorkflows on RuleConditionsSectionState {
  Future<void> addCondition() async {
    final NotificationCondition? condition = await createCondition(
      allowGroupConditions: true,
    );
    if (condition != null && mounted) {
      replaceConditions(<NotificationCondition>[...conditions, condition]);
      highlightCondition(condition);
    }
  }

  Future<void> addConditionToGroup(
    NotificationCondition group,
    int groupDepth,
    List<NotificationCondition> conditions,
    ValueChanged<List<NotificationCondition>> onChanged,
  ) async {
    final NotificationCondition? condition = await createCondition(
      nestingDepth: groupDepth,
      parentGroup: group,
    );
    if (condition != null && mounted) {
      final List<NotificationCondition> updated = <NotificationCondition>[
        ...conditions,
        condition,
      ];
      if (willFlattenGroupChildren(group, updated)) {
        showFlattenedGroupsMessage();
      }
      onChanged(normalizedGroupChildren(group, updated));
      highlightCondition(condition);
    }
  }

  void moveCondition(
    List<NotificationCondition> conditions,
    int fromIndex,
    int toIndex, [
    ValueChanged<List<NotificationCondition>>? onChanged,
  ]) {
    final List<NotificationCondition> updated =
        List<NotificationCondition>.from(conditions);
    final NotificationCondition condition = updated.removeAt(fromIndex);
    updated.insert(toIndex, condition);
    if (onChanged != null) {
      onChanged(updated);
    } else {
      widget.onMove(fromIndex, toIndex);
    }
  }

  Future<void> editCondition(
    ValueChanged<NotificationCondition> onChanged,
    NotificationCondition existingCondition,
  ) async {
    final NotificationCondition? replacement = await createCondition(
      existingCondition: existingCondition,
    );
    if (replacement != null && mounted) onChanged(replacement);
  }

  Future<NotificationCondition?> createCondition({
    NotificationCondition? existingCondition,
    bool allowGroupConditions = true,
    int nestingDepth = 0,
    NotificationCondition? parentGroup,
  }) => selectNotificationCondition(
    context,
    extractors: widget.extractors,
    notificationContext: widget.notificationContext,
    existingCondition: existingCondition,
    allowGroupConditions: allowGroupConditions,
    nestingDepth: nestingDepth,
    parentGroup: parentGroup,
  );

  Future<void> removeCondition(
    int index,
    NotificationCondition condition,
  ) async {
    final S strings = S.of(context);
    final bool confirmed = await showRuleRemovalConfirmation(
      context,
      title: strings.notificationsRuleRemoveConditionTitle,
      content: strings.notificationsRuleRemoveConditionDescription(
        widget.ruleName,
      ),
    );
    if (confirmed && mounted) {
      animateConditionRemoval(condition, () => widget.onRemoveAt(index));
    }
  }

  Future<void> removeNestedCondition(
    NotificationCondition condition,
    VoidCallback onRemove,
  ) async {
    final S strings = S.of(context);
    final bool confirmed = await showRuleRemovalConfirmation(
      context,
      title: strings.notificationsRuleRemoveConditionTitle,
      content: strings.notificationsRuleRemoveConditionDescription(
        widget.ruleName,
      ),
    );
    if (confirmed && mounted) {
      animateConditionRemoval(condition, onRemove);
    }
  }
}
