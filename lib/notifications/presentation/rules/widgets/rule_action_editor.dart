import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/application/resources/firefly_currency_resolver.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/actions/action_evaluation_result.dart';
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
  final Map<String, Future<FireflyCurrencyResolution>>
  dynamicCurrencyResolutions = <String, Future<FireflyCurrencyResolution>>{};
  final Map<String, Future<FireflyCurrency>> fixedCurrencyResolutions =
      <String, Future<FireflyCurrency>>{};

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
    actionRemovalTimers[action] = Timer(animDurationStandard, () {
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
          duration: animDurationStandard,
          curve: animCurveStandard,
          alignment: Alignment.topCenter,
          heightFactor: removingActions.contains(action) ? 0 : 1,
          child: AnimatedOpacity(
            duration: animDurationStandard,
            curve: animCurveStandardAccelerate,
            opacity: removingActions.contains(action) ? 0 : 1,
            child: child,
          ),
        ),
      );

  Widget actionHighlightAnimation(NotificationAction action, Widget child) =>
      TweenAnimationBuilder<Color?>(
        duration: const Duration(milliseconds: 1500),
        curve: animCurveStandardDecelerate,
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
          !isConfiguredCurrencyValueSource(
            (entry.$2 as SetTransactionFieldAction).valueSource,
          );
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
        !isConfiguredCurrencyValueSource(source)) {
      return ActionCardStatus.error(
        S.of(context).notificationsRuleChooseMatchingCurrency,
      );
    }
    final List<RegExpCaptureValueSource> captures = capturesFor(
      source,
    ).toList();
    final RegExpCaptureValueSource? deletedCapture = captures
        .where(
          (RegExpCaptureValueSource capture) => extractorFor(capture) == null,
        )
        .firstOrNull;
    if (deletedCapture != null) {
      return ActionCardStatus.error(
        S
            .of(context)
            .notificationsRuleDeletedCaptureExtractor(
              deletedCapture.captureName,
            ),
      );
    }
    if (!widget.rule.isPredefined) {
      final RegExpCaptureValueSource? ambiguousCapture = captures.where((
        RegExpCaptureValueSource capture,
      ) {
        if (capture.matchIndex != null) return false;
        return extractorFor(
              capture,
            )?.evaluate(activeNotificationContext).matches.length !=
            1;
      }).firstOrNull;
      final int matchCount = ambiguousCapture == null
          ? 0
          : extractorFor(
                  ambiguousCapture,
                )?.evaluate(activeNotificationContext).matches.length ??
                0;
      if (ambiguousCapture != null && matchCount > 1) {
        return ActionCardStatus.error(
          S
              .of(context)
              .notificationsRuleChooseExtractorMatch(
                matchCount,
                extractorName(ambiguousCapture),
              ),
        );
      }
    }
    final ActionEvaluationResult evaluation = action.evaluate(
      actionEvaluationContext,
    );
    if (!evaluation.succeeded) {
      final RegExpCaptureValueSource? unresolvedCapture = captures
          .where(
            (RegExpCaptureValueSource capture) =>
                capturedValue(capture) == null,
          )
          .firstOrNull;
      if (unresolvedCapture != null) {
        return ActionCardStatus.error(
          S
              .of(context)
              .notificationsRuleNoCapturedValue(unresolvedCapture.captureName),
        );
      }
      final TransactionFieldValidationError? validationError =
          TransactionFieldValidationError.values
              .where(
                (TransactionFieldValidationError error) =>
                    error.name == evaluation.failureReason,
              )
              .firstOrNull;
      return ActionCardStatus.error(
        validationError == null
            ? S.of(context).notificationsUnresolved
            : transactionFieldValidationError(context, validationError),
      );
    }
    final String resolvedValue = evaluation.patch!.values[action.target]!;
    if (source is CurrencyCaptureValueSource) {
      return ActionCardStatus.resolved(capturedValue(source.capture));
    }
    if (source is DateTimeCaptureValueSource) {
      final String captured = capturedValue(source.capture)!;
      return ActionCardStatus.resolved(
        captured,
        mappedValue: resolvedValue == captured ? null : resolvedValue,
      );
    }
    if (source is NormalizedAmountCaptureValueSource) {
      final String captured = capturedValue(source.capture)!;
      return ActionCardStatus.resolved(
        captured,
        mappedValue: resolvedValue == captured ? null : resolvedValue,
      );
    }
    return ActionCardStatus.resolved(resolvedValue);
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

  Iterable<RegExpCaptureValueSource> capturesFor(ValueSource source) sync* {
    final RegExpCaptureValueSource? capture = captureFor(source);
    if (capture != null) {
      yield capture;
      return;
    }
    if (source is ComposedValueSource) {
      yield* source.parts.whereType<RegExpCaptureValueSource>();
    }
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
      notificationContext: activeNotificationContext,
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
        notificationContext: activeNotificationContext,
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
      notificationContext: activeNotificationContext,
      fixedField: current.target,
      excludedExtractorId: current.target == TransactionField.currency
          ? null
          : captureFor(current.valueSource)?.extractorId,
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
    if (capture == null && current.target != TransactionField.currency) return;
    final NotificationAction? action = await selectTransactionAction(
      context,
      extractors: widget.extractors,
      notificationContext: activeNotificationContext,
      fixedField: current.target,
      captureExtractorId: capture?.extractorId,
      captureOnly: capture != null,
    );
    if (action is SetTransactionFieldAction && mounted) {
      widget.onReplaceAt(index, action);
      widget.onSetPredefinedFieldReviewed(current.target, true);
    }
  }
}
