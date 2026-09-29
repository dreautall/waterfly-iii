import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_tags_action.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/currency_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/composed_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/date_time_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/firefly_resource_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/literal_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/normalized_amount_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/notification_property_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/value_source.dart';
import 'package:waterflyiii/notifications/presentation/shared/definition_detail_card.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/actions/transaction_action_value_dialog.dart';
import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_editor_section.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_menu_theme.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_date_time_formatter.dart';

import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_editor_shared.dart';

import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_action_summary.dart';
import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_predefined_action_editor.dart';
import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_tag_action_editor.dart';

enum ActionCardAction { edit, delete }

class ActionCardStatus {
  const ActionCardStatus.resolved(this.resolvedValue, {this.mappedValue})
    : errorMessage = null;
  const ActionCardStatus.error(this.errorMessage)
    : resolvedValue = null,
      mappedValue = null;

  final String? resolvedValue;
  final String? mappedValue;
  final String? errorMessage;

  bool get hasError => errorMessage != null;
}

class RuleActionsSection extends StatefulWidget {
  const RuleActionsSection({
    super.key,
    required this.rule,
    required this.actions,
    this.title,
    this.description,
    this.emptyText,
    required this.reviewedPredefinedFields,
    required this.extractors,
    required this.notificationContext,
    required this.activeNotificationContext,
    required this.extractorMode,
    required this.ruleName,
    required this.onAdd,
    required this.onReplaceAt,
    required this.onRemoveAt,
    required this.onRemoveTag,
    required this.onSetPredefinedFieldReviewed,
  });

  final NotificationRule rule;
  final List<NotificationAction> actions;
  final String? title;
  final String? description;
  final String? emptyText;
  final Set<TransactionField> reviewedPredefinedFields;
  final List<RegExpDefinition> extractors;
  final NotificationContext notificationContext;
  final NotificationContext activeNotificationContext;
  final NotificationExtractorMode extractorMode;
  final String ruleName;
  final ValueChanged<NotificationAction> onAdd;
  final void Function(int, NotificationAction) onReplaceAt;
  final ValueChanged<int> onRemoveAt;
  final SetTransactionTagsAction Function(int, String) onRemoveTag;
  final void Function(TransactionField, bool) onSetPredefinedFieldReviewed;

  @override
  State<RuleActionsSection> createState() => RuleActionsSectionState();
}

/// Internal extension host shared by the cohesive action editor modules.
class RuleActionsSectionState extends State<RuleActionsSection> {
  final Set<SetTransactionTagsAction> expandedTagActions =
      <SetTransactionTagsAction>{};
  final Set<NotificationAction> highlightedActions = <NotificationAction>{};
  final Map<NotificationAction, Timer> actionHighlightTimers =
      <NotificationAction, Timer>{};
  final Set<NotificationAction> removingActions = <NotificationAction>{};
  final Map<NotificationAction, Timer> actionRemovalTimers =
      <NotificationAction, Timer>{};

  List<NotificationAction> get actions => widget.actions;
  Set<TransactionField> get reviewedPredefinedFields =>
      widget.reviewedPredefinedFields;
  NotificationContext get activeNotificationContext =>
      widget.activeNotificationContext;
  EvaluationContext get actionEvaluationContext => EvaluationContext(
    notification: activeNotificationContext,
    extractionResults: <String, RegExpEvaluationResult>{
      for (final RegExpDefinition extractor in widget.extractors)
        extractor.id: extractor.evaluate(activeNotificationContext),
    },
    dateTimeExtractorIds: <String>{
      for (final RegExpDefinition extractor in widget.extractors)
        if (extractor.predefinedType ==
            PredefinedRegExpDefinition.notificationDate)
          extractor.id,
    },
    formattingPreferences: notificationFormattingPreferencesOf(context),
  );

  @override
  void dispose() {
    for (final Timer timer in actionHighlightTimers.values) {
      timer.cancel();
    }
    for (final Timer timer in actionRemovalTimers.values) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);
    return RuleEditorSection(
      title:
          widget.title ??
          (widget.rule.isPredefined
              ? strings.notificationsRuleTransactionDetails
              : strings.notificationsRuleActionsTitle),
      description:
          widget.description ??
          (widget.rule.isPredefined
              ? strings.notificationsRulePredefinedActionsDescription
              : strings.notificationsRuleActionsDescription),
      content: actions.isEmpty
          ? RuleEditorEmptyState(
              widget.emptyText ?? strings.notificationsRuleNoActions,
            )
          : widget.rule.isPredefined
          ? predefinedActionGroups()
          : Column(children: actionRows(actions, includeBottomPadding: false)),
      action: widget.rule.isPredefined
          ? null
          : ElevatedButton.icon(
              onPressed: addAction,
              icon: const Icon(Icons.add),
              label: Text(strings.notificationsRuleAddAction),
            ),
    );
  }

  void update(VoidCallback action) => setState(action);

  Color conditionCardBackground(BuildContext context) =>
      Theme.of(context).elevatedButtonTheme.style?.backgroundColor?.resolve(
        const <WidgetState>{},
      ) ??
      Theme.of(context).colorScheme.surfaceContainerLow;

  String sourceText(ValueSource source) {
    if (source is LiteralValueSource) return '"${source.value}"';
    if (source is NotificationPropertyValueSource) return source.property.name;
    if (source is RegExpCaptureValueSource) return source.captureName;
    if (source is DateTimeCaptureValueSource) return source.capture.captureName;
    if (source is NormalizedAmountCaptureValueSource) {
      return source.capture.captureName;
    }
    if (source is FireflyResourceValueSource) return source.resourceId;
    if (source is ComposedValueSource) {
      return source.parts
          .map((ValueSource part) {
            if (part is LiteralValueSource) return '"${part.value}"';
            if (part is RegExpCaptureValueSource) return part.captureName;
            return part.runtimeType.toString();
          })
          .join(' + ');
    }
    return source.runtimeType.toString();
  }

  String resolvedValueText(String value, ValueSource source) {
    final bool isDateTimeCapture =
        source is DateTimeCaptureValueSource ||
        (source is RegExpCaptureValueSource &&
            extractorFor(source)?.predefinedType ==
                PredefinedRegExpDefinition.notificationDate);
    final DateTime? dateTime = isDateTimeCapture
        ? DateTime.tryParse(value.trim())
        : null;
    if (dateTime == null) return value;
    return formatNotificationDateTime(context, dateTime);
  }

  void highlightAction(NotificationAction action) {
    actionHighlightTimers.remove(action)?.cancel();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      update(() => highlightedActions.add(action));
      actionHighlightTimers[action] = Timer(
        const Duration(milliseconds: 2500),
        () {
          if (mounted) {
            update(() => highlightedActions.remove(action));
          }
          actionHighlightTimers.remove(action);
        },
      );
    });
  }

  void animateActionRemoval(
    NotificationAction action,
    VoidCallback onComplete,
  ) {
    if (!removingActions.add(action)) return;
    update(() {});
    actionRemovalTimers[action] = Timer(const Duration(milliseconds: 240), () {
      if (!mounted) return;
      onComplete();
      update(() => removingActions.remove(action));
      actionRemovalTimers.remove(action);
    });
  }

  Widget actionRemovalAnimation(NotificationAction action, Widget child) =>
      ClipRect(
        clipBehavior: removingActions.contains(action)
            ? Clip.hardEdge
            : Clip.none,
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          heightFactor: removingActions.contains(action) ? 0 : 1,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeIn,
            opacity: removingActions.contains(action) ? 0 : 1,
            child: child,
          ),
        ),
      );

  Widget actionHighlightAnimation(NotificationAction action, Widget child) =>
      TweenAnimationBuilder<Color?>(
        duration: const Duration(milliseconds: 1500),
        curve: Curves.easeOut,
        tween: ColorTween(
          end: highlightedActions.contains(action)
              ? Theme.of(context).colorScheme.primary
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
        child: child,
      );
}

extension RuleActionEditor on RuleActionsSectionState {
  List<Widget> actionRows(
    Iterable<NotificationAction> actions, {
    bool includeBottomPadding = true,
  }) {
    final List<NotificationAction> actionList = actions.toList();
    return actionList.indexed.map(((int, NotificationAction) entry) {
      if (entry.$2 is SetTransactionTagsAction) {
        return tagActionCard(
          entry.$1,
          entry.$2 as SetTransactionTagsAction,
          bottomPadding:
              includeBottomPadding || entry.$1 != actionList.length - 1 ? 8 : 0,
        );
      }
      final ActionCardStatus status = actionStatus(entry.$2);
      final bool editable =
          !widget.rule.isPredefined || canAdjustPredefinedAction(entry.$2);
      final bool removableOptional =
          widget.rule.isPredefined && isOptionalPredefinedAction(entry.$2);
      final TransactionField? target = targetFor(entry.$2);
      final bool pendingCurrencyMapping =
          widget.extractorMode == NotificationExtractorMode.basic &&
          widget.rule.isPredefined &&
          entry.$2 is SetTransactionFieldAction &&
          (entry.$2 as SetTransactionFieldAction).target ==
              TransactionField.currency &&
          (entry.$2 as SetTransactionFieldAction).valueSource
              is! CurrencyCaptureValueSource;
      final bool hasVisibleError = status.hasError && !pendingCurrencyMapping;
      final bool needsReview =
          pendingCurrencyMapping ||
          (widget.rule.isPredefined &&
              editable &&
              target != null &&
              !reviewedPredefinedFields.contains(target));
      return actionRemovalAnimation(
        entry.$2,
        Padding(
          padding: EdgeInsets.only(
            bottom: includeBottomPadding || entry.$1 != actionList.length - 1
                ? 8
                : 0,
          ),
          child: actionHighlightAnimation(
            entry.$2,
            IgnorePointer(
              ignoring: !editable && !removableOptional,
              child: DefinitionDetailCard(
                leading: Icon(
                  hasVisibleError
                      ? Icons.cancel_outlined
                      : needsReview
                      ? Icons.error_outline
                      : Icons.playlist_add_check,
                  color: hasVisibleError
                      ? Theme.of(context).colorScheme.error
                      : needsReview
                      ? Theme.of(context).colorScheme.tertiary
                      : null,
                ),
                title: actionSummary(
                  entry.$2,
                  isOptional:
                      widget.rule.isPredefined &&
                      entry.$2 is SetTransactionFieldAction &&
                      (entry.$2 as SetTransactionFieldAction).target ==
                          TransactionField.currency,
                ),
                subtitle: hasVisibleError
                    ? actionStatusWidget(
                        status,
                        entry.$2 is SetTransactionFieldAction
                            ? (entry.$2 as SetTransactionFieldAction)
                                  .valueSource
                            : null,
                        entry.$2 is SetTransactionFieldAction
                            ? (entry.$2 as SetTransactionFieldAction).target
                            : null,
                      )
                    : pendingCurrencyMapping
                    ? Text(
                        status.errorMessage!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      )
                    : needsReview
                    ? Text(
                        S.of(context).notificationsRuleNeedsReview,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      )
                    : actionStatusWidget(
                        status,
                        entry.$2 is SetTransactionFieldAction
                            ? (entry.$2 as SetTransactionFieldAction)
                                  .valueSource
                            : null,
                        entry.$2 is SetTransactionFieldAction
                            ? (entry.$2 as SetTransactionFieldAction).target
                            : null,
                      ),
                trailing: widget.rule.isPredefined
                    ? predefinedActionControls(entry.$2, editable)
                    : PopupMenuButton<ActionCardAction>(
                        tooltip: S.of(context).notificationsRuleActionOptions,
                        position: PopupMenuPosition.under,
                        onSelected: (ActionCardAction action) {
                          if (action == ActionCardAction.edit) {
                            editAction(entry.$1);
                          } else {
                            removeAction(entry.$1);
                          }
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<ActionCardAction>>[
                              PopupMenuItem<ActionCardAction>(
                                value: ActionCardAction.edit,
                                child: Row(
                                  children: <Widget>[
                                    const Icon(Icons.edit_outlined),
                                    const SizedBox(width: 8),
                                    Text(S.of(context).notificationsRuleEdit),
                                  ],
                                ),
                              ),
                              const NotificationMenuDivider(),
                              PopupMenuItem<ActionCardAction>(
                                value: ActionCardAction.delete,
                                child: Row(
                                  children: <Widget>[
                                    const Icon(Icons.delete_outline),
                                    const SizedBox(width: 8),
                                    Text(S.of(context).notificationsRuleDelete),
                                  ],
                                ),
                              ),
                            ],
                        icon: const Icon(Icons.more_vert),
                      ),
                onTap: widget.rule.isPredefined
                    ? editable
                          ? () => editPredefinedAction(
                              this.actions.indexOf(entry.$2),
                              entry.$2,
                            )
                          : null
                    : () => editAction(entry.$1),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  ActionCardStatus actionStatus(NotificationAction action) {
    if (action is! SetTransactionFieldAction) {
      return ActionCardStatus.error(
        S.of(context).notificationsRuleUnsupportedAction,
      );
    }
    final ValueSource source = action.valueSource;
    if (action.target == TransactionField.currency &&
        source is! CurrencyCaptureValueSource) {
      return ActionCardStatus.error(
        S.of(context).notificationsRuleChooseMatchingCurrency,
      );
    }
    final RegExpCaptureValueSource? capture = captureFor(source);
    if (capture != null && extractorFor(capture) == null) {
      return ActionCardStatus.error(
        S
            .of(context)
            .notificationsRuleDeletedCaptureExtractor(capture.captureName),
      );
    }
    if (!widget.rule.isPredefined &&
        capture != null &&
        capture.matchIndex == null) {
      final int matchCount =
          extractorFor(
            capture,
          )?.evaluate(activeNotificationContext).matches.length ??
          0;
      if (matchCount > 1) {
        return ActionCardStatus.error(
          S
              .of(context)
              .notificationsRuleChooseExtractorMatch(
                matchCount,
                extractorName(capture),
              ),
        );
      }
    }
    if (source is CurrencyCaptureValueSource) {
      final String? value = capturedValue(source.capture);
      return value == null
          ? ActionCardStatus.error(
              S
                  .of(context)
                  .notificationsRuleNoCapturedValue(source.capture.captureName),
            )
          : ActionCardStatus.resolved(value);
    }
    if (source is DateTimeCaptureValueSource) {
      final String? value = capturedValue(source.capture);
      return value == null
          ? ActionCardStatus.error(
              S
                  .of(context)
                  .notificationsRuleNoCapturedValue(source.capture.captureName),
            )
          : ActionCardStatus.resolved(
              value,
              mappedValue: source.deriveFromCapture
                  ? source.normalizeCapturedValue(value)
                  : source.normalizedValue,
            );
    }
    if (source is NormalizedAmountCaptureValueSource) {
      final String? value = capturedValue(source.capture);
      return value == null
          ? ActionCardStatus.error(
              S
                  .of(context)
                  .notificationsRuleNoCapturedValue(source.capture.captureName),
            )
          : ActionCardStatus.resolved(
              value,
              mappedValue: NormalizedAmountCaptureValueSource.normalize(value),
            );
    }
    if (source is RegExpCaptureValueSource) {
      final bool isDateTimeTextCapture =
          TransactionFieldSpec.values[action.target]!.valueType ==
              TransactionFieldValueType.text &&
          extractorFor(source)?.predefinedType ==
              PredefinedRegExpDefinition.notificationDate;
      final String? value = isDateTimeTextCapture
          ? source.withDateTimeTextFormat().resolve(actionEvaluationContext)
          : capturedValue(source);
      return value == null
          ? ActionCardStatus.error(
              S
                  .of(context)
                  .notificationsRuleNoCapturedValue(source.captureName),
            )
          : ActionCardStatus.resolved(value);
    }
    if (source is ComposedValueSource) {
      final String? value = source.resolve(actionEvaluationContext);
      if (value != null) return ActionCardStatus.resolved(value);
      final RegExpCaptureValueSource? missingCapture = source.parts
          .whereType<RegExpCaptureValueSource>()
          .where(
            (RegExpCaptureValueSource capture) =>
                capture.resolve(actionEvaluationContext) == null,
          )
          .firstOrNull;
      return ActionCardStatus.error(
        S
            .of(context)
            .notificationsRuleNoCapturedValue(
              missingCapture?.captureName ?? '',
            ),
      );
    }
    return ActionCardStatus.resolved(actionValueText(source, action.target));
  }

  RegExpDefinition? extractorFor(RegExpCaptureValueSource source) =>
      widget.extractors.cast<RegExpDefinition?>().firstWhere(
        (RegExpDefinition? item) => item?.id == source.extractorId,
        orElse: () => null,
      );

  String extractorName(RegExpCaptureValueSource source) =>
      extractorFor(source)?.definitionName ??
      S.of(context).notificationsRuleDeletedExtractor;

  RegExpCaptureValueSource? captureFor(ValueSource source) {
    if (source is CurrencyCaptureValueSource) return source.capture;
    if (source is DateTimeCaptureValueSource) return source.capture;
    if (source is NormalizedAmountCaptureValueSource) return source.capture;
    if (source is RegExpCaptureValueSource) return source;
    return null;
  }

  String? capturedValue(RegExpCaptureValueSource source) {
    final RegExpDefinition? extractor = extractorFor(source);
    if (extractor == null) return null;
    final List<RegExpMatch> matches = extractor
        .evaluate(activeNotificationContext)
        .matches;
    final int selectedMatch = source.matchIndex ?? 0;
    if (selectedMatch >= matches.length) return null;
    final RegExpMatch? match = matches.elementAtOrNull(selectedMatch);
    if (match == null) return null;
    if (match.groupNames.contains(source.captureName)) {
      return match.namedGroup(source.captureName);
    }
    final int? fallbackCaptureIndex = source.fallbackCaptureIndex;
    return fallbackCaptureIndex == null ||
            fallbackCaptureIndex > match.groupCount
        ? null
        : match.group(fallbackCaptureIndex);
  }
}

extension RuleActionWorkflows on RuleActionsSectionState {
  Future<void> removeAction(int index) async {
    final S strings = S.of(context);
    final bool confirmed = await showRuleRemovalConfirmation(
      context,
      title: strings.notificationsRuleRemoveActionTitle,
      content: strings.notificationsRuleRemoveActionDescription(
        widget.ruleName,
      ),
    );
    if (confirmed && mounted && index < actions.length) {
      final NotificationAction action = actions[index];
      animateActionRemoval(action, () => widget.onRemoveAt(index));
    }
  }

  Future<void> addAction() async {
    final NotificationAction? action = await selectTransactionAction(
      context,
      extractors: widget.extractors,
      notificationContext: widget.notificationContext,
      unavailableFields: <TransactionField>{
        for (final NotificationAction action in actions)
          if (targetFor(action) != null) targetFor(action)!,
      },
      allowFireflyResource:
          widget.extractorMode != NotificationExtractorMode.basic,
    );
    if (action != null && mounted) {
      widget.onAdd(action);
      highlightAction(action);
    }
  }

  Future<void> editAction(int index) async {
    final NotificationAction current = actions[index];
    if (current is SetTransactionTagsAction) {
      final NotificationAction? action = await selectTransactionAction(
        context,
        extractors: widget.extractors,
        notificationContext: widget.notificationContext,
        fixedField: TransactionField.tag,
        initialTags: current.tags,
      );
      if (action is SetTransactionTagsAction && mounted) {
        widget.onReplaceAt(index, action);
        update(() {
          expandedTagActions.remove(current);
          expandedTagActions.add(action);
        });
      }
      return;
    }
    if (current is! SetTransactionFieldAction) return;
    final NotificationAction? action = await selectTransactionAction(
      context,
      extractors: widget.extractors,
      notificationContext: widget.notificationContext,
      fixedField: current.target,
      excludedExtractorId: captureFor(current.valueSource)?.extractorId,
      allowFireflyResource:
          widget.extractorMode != NotificationExtractorMode.basic,
      initialSource: current.valueSource,
    );
    if (action is SetTransactionFieldAction && mounted) {
      widget.onReplaceAt(index, action);
      widget.onSetPredefinedFieldReviewed(current.target, false);
    }
  }

  Future<void> editPredefinedAction(
    int index,
    NotificationAction current,
  ) async {
    if (current is! SetTransactionFieldAction) return;
    final RegExpCaptureValueSource? capture = captureFor(current.valueSource);
    if (capture == null) return;
    final NotificationAction? action = await selectTransactionAction(
      context,
      extractors: widget.extractors,
      notificationContext: widget.notificationContext,
      fixedField: current.target,
      captureExtractorId: capture.extractorId,
      captureOnly: true,
    );
    if (action is SetTransactionFieldAction && mounted) {
      widget.onReplaceAt(index, action);
      if (current.target == TransactionField.currency &&
          action.valueSource is CurrencyCaptureValueSource) {
        widget.onSetPredefinedFieldReviewed(current.target, true);
      }
    }
  }
}
