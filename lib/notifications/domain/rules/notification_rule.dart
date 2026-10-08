import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/actions/action_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/conditions/condition_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_sample.dart';
import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_intent.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_rule_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_action_group_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_patch.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_action_group.dart';
import 'package:waterflyiii/notifications/domain/value_sources/currency_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/composed_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/date_time_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/normalized_amount_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/value_source.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_rule_requirement.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/all_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/any_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/not_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/value_contains_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/value_exists_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/values_equal_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/numeric_values_comparison_condition.dart';

class NotificationRule {
  const NotificationRule({
    required this.id,
    required this.name,
    this.description = '',
    required this.conditions,
    required this.actions,
    this.conditionalActionGroups = const <NotificationActionGroup>[],
    this.isPredefined = false,
    this.reviewedPredefinedFields = const <TransactionField>{},
    this.sampleOverride,
  });

  final String id;
  final String name;
  final String description;
  final List<NotificationCondition> conditions;
  final List<NotificationAction> actions;
  final List<NotificationActionGroup> conditionalActionGroups;
  final bool isPredefined;
  final Set<TransactionField> reviewedPredefinedFields;
  final NotificationSample? sampleOverride;

  bool get hasUnconfiguredConditionalActions => conditionalActionGroups.any(
    (NotificationActionGroup group) => !group.isConfigured,
  );

  List<NotificationRuleRequirement> get requirements =>
      <NotificationRuleRequirement>{
        for (final NotificationCondition condition in conditions)
          ..._requirementsForCondition(condition),
        for (final NotificationAction action in actions)
          ..._requirementsForAction(action),
        for (final NotificationActionGroup group in conditionalActionGroups)
          if (group.isConfigured)
            for (final NotificationCondition condition in group.conditions)
              ..._requirementsForCondition(condition),
        for (final NotificationActionGroup group in conditionalActionGroups)
          if (group.isConfigured)
            for (final NotificationAction action in group.actions)
              ..._requirementsForAction(action),
      }.toList();

  NotificationRule copyWith({
    String? id,
    String? name,
    String? description,
    List<NotificationCondition>? conditions,
    List<NotificationAction>? actions,
    List<NotificationActionGroup>? conditionalActionGroups,
    bool? isPredefined,
    Set<TransactionField>? reviewedPredefinedFields,
    NotificationSample? sampleOverride,
  }) => NotificationRule(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    conditions: conditions ?? this.conditions,
    actions: actions ?? this.actions,
    conditionalActionGroups:
        conditionalActionGroups ?? this.conditionalActionGroups,
    isPredefined: isPredefined ?? this.isPredefined,
    reviewedPredefinedFields:
        reviewedPredefinedFields ?? this.reviewedPredefinedFields,
    sampleOverride: sampleOverride ?? this.sampleOverride,
  );

  NotificationRule withoutSampleOverride() => NotificationRule(
    id: id,
    name: name,
    description: description,
    conditions: conditions,
    actions: actions,
    conditionalActionGroups: conditionalActionGroups,
    isPredefined: isPredefined,
    reviewedPredefinedFields: reviewedPredefinedFields,
  );

  NotificationRuleEvaluationResult evaluate(
    EvaluationContext context, {
    TransactionCreationMode? transactionCreationMode,
  }) {
    final List<NotificationRuleRequirement> unmetRequirements =
        _selectionRequirements
            .where(
              (NotificationRuleRequirement requirement) =>
                  !requirement.isAvailable(context),
            )
            .toList();
    if (unmetRequirements.isNotEmpty) {
      return NotificationRuleEvaluationResult(
        matches: false,
        conditions: const <ConditionEvaluationResult>[],
        actions: const <ActionEvaluationResult>[],
        patch: const TransactionPatch(<TransactionField, String>{}),
        unmetRequirements: unmetRequirements,
      );
    }
    final List<ConditionEvaluationResult> conditionResults = conditions
        .map((NotificationCondition condition) => condition.evaluate(context))
        .toList();
    final bool matches = conditionResults.every(
      (ConditionEvaluationResult result) => result.matches,
    );
    if (!matches) {
      return NotificationRuleEvaluationResult(
        matches: false,
        conditions: conditionResults,
        actions: const <ActionEvaluationResult>[],
        patch: const TransactionPatch(<TransactionField, String>{}),
      );
    }

    final List<ActionEvaluationResult> actionResults = _evaluateActions(
      actions,
      context,
    );
    final List<TransactionPatch?> patches = <TransactionPatch?>[
      ...actionResults.map((ActionEvaluationResult result) => result.patch),
    ];
    final Map<String, NotificationActionGroupEvaluationResult> groupResults =
        <String, NotificationActionGroupEvaluationResult>{};
    for (final NotificationActionGroup group in conditionalActionGroups) {
      if (!group.isConfigured) {
        groupResults[group.id] = const NotificationActionGroupEvaluationResult(
          matches: false,
          conditions: <ConditionEvaluationResult>[],
          actions: <ActionEvaluationResult>[],
          patch: TransactionPatch(<TransactionField, String>{}),
        );
        continue;
      }
      final List<ConditionEvaluationResult> conditions = group.conditions
          .map((NotificationCondition condition) => condition.evaluate(context))
          .toList();
      final bool groupMatches =
          conditions.isNotEmpty &&
          conditions.every(
            (ConditionEvaluationResult result) => result.matches,
          );
      final List<ActionEvaluationResult> actions = groupMatches
          ? _evaluateActions(group.actions, context)
          : const <ActionEvaluationResult>[];
      if (groupMatches) {
        patches.addAll(
          actions.map((ActionEvaluationResult result) => result.patch),
        );
      }
      groupResults[group.id] = NotificationActionGroupEvaluationResult(
        matches: groupMatches,
        conditions: conditions,
        actions: actions,
        patch: _patchFor(actions),
      );
    }
    final TransactionPatch patch = TransactionPatch.merge(patches);

    return NotificationRuleEvaluationResult(
      matches: true,
      conditions: conditionResults,
      actions: actionResults,
      patch: patch,
      conditionalGroups: groupResults,
      transactionIntent: transactionCreationMode == null
          ? null
          : TransactionIntent(mode: transactionCreationMode, patch: patch),
    );
  }

  List<NotificationAction> get allActions => <NotificationAction>[
    ...actions,
    for (final NotificationActionGroup group in conditionalActionGroups)
      if (group.isConfigured) ...group.actions,
  ];

  Set<NotificationRuleRequirement> get _selectionRequirements =>
      <NotificationRuleRequirement>{
        for (final NotificationCondition condition in conditions)
          ..._requirementsForCondition(condition),
        for (final NotificationAction action in actions)
          ..._requirementsForAction(action),
      };

  List<ActionEvaluationResult> _evaluateActions(
    List<NotificationAction> actions,
    EvaluationContext context,
  ) => actions
      .map((NotificationAction action) => action.evaluate(context))
      .toList();

  TransactionPatch _patchFor(List<ActionEvaluationResult> results) {
    return TransactionPatch.merge(
      results.map((ActionEvaluationResult result) => result.patch),
    );
  }

  Iterable<NotificationRuleRequirement> _requirementsForAction(
    NotificationAction action,
  ) sync* {
    if (action is SetTransactionFieldAction) {
      yield* _requirementsForValueSource(action.valueSource);
    }
  }

  Set<NotificationRuleRequirement> _requirementsForCondition(
    NotificationCondition condition,
  ) => switch (condition) {
    AllCondition(:final List<NotificationCondition> conditions) =>
      <NotificationRuleRequirement>{
        for (final NotificationCondition nested in conditions)
          ..._requirementsForCondition(nested),
      },
    AnyCondition(:final List<NotificationCondition> conditions) =>
      _sharedRequirements(conditions),
    NotCondition() => <NotificationRuleRequirement>{},
    ValueExistsCondition(:final ValueSource valueSource) =>
      _requirementsForValueSource(valueSource).toSet(),
    ValueContainsCondition(
      :final ValueSource value,
      :final ValueSource substring,
    ) =>
      <NotificationRuleRequirement>{
        ..._requirementsForValueSource(value),
        ..._requirementsForValueSource(substring),
      },
    ValuesEqualCondition(:final ValueSource left, :final ValueSource right) ||
    NumericValuesComparisonCondition(
      :final ValueSource left,
      :final ValueSource right,
    ) => <NotificationRuleRequirement>{
      ..._requirementsForValueSource(left),
      ..._requirementsForValueSource(right),
    },
    _ => <NotificationRuleRequirement>{},
  };

  Set<NotificationRuleRequirement> _sharedRequirements(
    List<NotificationCondition> conditions,
  ) {
    if (conditions.isEmpty) return <NotificationRuleRequirement>{};
    final Iterator<NotificationCondition> iterator = conditions.iterator;
    iterator.moveNext();
    final Set<NotificationRuleRequirement> requirements =
        _requirementsForCondition(iterator.current);
    while (iterator.moveNext()) {
      requirements.retainAll(_requirementsForCondition(iterator.current));
    }
    return requirements;
  }

  Iterable<NotificationRuleRequirement> _requirementsForValueSource(
    ValueSource source,
  ) sync* {
    if (source is ComposedValueSource) {
      for (final ValueSource part in source.parts) {
        yield* _requirementsForValueSource(part);
      }
      return;
    }
    final RegExpCaptureValueSource? capture = switch (source) {
      RegExpCaptureValueSource() => source,
      CurrencyCaptureValueSource(:final RegExpCaptureValueSource capture) =>
        capture,
      DateTimeCaptureValueSource(:final RegExpCaptureValueSource capture) =>
        capture,
      NormalizedAmountCaptureValueSource(
        :final RegExpCaptureValueSource capture,
      ) =>
        capture,
      _ => null,
    };
    if (capture != null) yield NotificationRuleRequirement(capture);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'name': name,
    if (description.isNotEmpty) 'description': description,
    'conditions': conditions
        .map((NotificationCondition condition) => condition.toJson())
        .toList(),
    'actions': actions
        .map((NotificationAction action) => action.toJson())
        .toList(),
    'conditionalActionGroups': conditionalActionGroups
        .map((NotificationActionGroup group) => group.toJson())
        .toList(),
    'isPredefined': isPredefined,
    if (reviewedPredefinedFields.isNotEmpty)
      'reviewedPredefinedFields': reviewedPredefinedFields
          .map((TransactionField field) => field.name)
          .toList(),
    if (sampleOverride != null) 'sampleOverride': sampleOverride!.toJson(),
  };

  factory NotificationRule.fromJson(Map<String, dynamic> json) {
    return NotificationRule(
      id: json['id'] as String,
      name: json['name'] as String,
      description:
          json['description'] as String? ??
          _predefinedDescription(
            json['name'] as String,
            json['isPredefined'] as bool? ?? false,
          ),
      conditions: (json['conditions'] as List<dynamic>)
          .map(
            (dynamic condition) => NotificationCondition.fromJson(
              condition as Map<String, dynamic>,
            ),
          )
          .toList(),
      actions: (json['actions'] as List<dynamic>)
          .map(
            (dynamic action) =>
                NotificationAction.fromJson(action as Map<String, dynamic>),
          )
          .toList(),
      conditionalActionGroups:
          (json['conditionalActionGroups'] as List<dynamic>? ?? <dynamic>[])
              .map(
                (dynamic group) => NotificationActionGroup.fromJson(
                  group as Map<String, dynamic>,
                ),
              )
              .toList(),
      isPredefined: json['isPredefined'] as bool? ?? false,
      reviewedPredefinedFields:
          (json['reviewedPredefinedFields'] as List<dynamic>? ?? <dynamic>[])
              .map(
                (dynamic field) =>
                    TransactionField.values.byName(field as String),
              )
              .toSet(),
      sampleOverride: switch (json['sampleOverride']) {
        final Map<String, dynamic> sample => NotificationSample.fromJson(
          sample,
        ),
        _ => null,
      },
    );
  }

  static String _predefinedDescription(String name, bool isPredefined) {
    if (!isPredefined) return '';
    return switch (name) {
      'Transaction details' =>
        'Maps the notification amount, date, and time to transaction fields.',
      _ => '',
    };
  }
}
