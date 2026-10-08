import 'package:flutter/foundation.dart';
import 'package:waterflyiii/notifications/application/rules/notification_rule_draft.dart';
import 'package:waterflyiii/notifications/application/shared/json_equality.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_tags_action.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context_factories.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_sample.dart';
import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_rule_requirement.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/notification_id.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_action_group.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';

class NotificationRuleEditorViewModel extends ChangeNotifier {
  NotificationRuleEditorViewModel({
    required NotificationRule rule,
    required NotificationContext notificationContext,
    required this.isTestMode,
    NotificationContext? definitionSampleContext,
  }) : _draft = NotificationRuleDraft.fromRule(rule),
       _originalSampleOverride = rule.sampleOverride,
       _sampleOverride = rule.sampleOverride,
       _notificationContext = notificationContext,
       _definitionSampleContext = definitionSampleContext,
       testNotificationContext = notificationContext;

  final NotificationRuleDraft _draft;
  NotificationSample? _originalSampleOverride;
  final NotificationContext _notificationContext;
  final NotificationContext? _definitionSampleContext;
  NotificationSample? _sampleOverride;
  bool _usesDefinitionSample = false;

  List<NotificationCondition> get conditions =>
      List<NotificationCondition>.unmodifiable(_draft.conditions);
  List<NotificationAction> get actions =>
      List<NotificationAction>.unmodifiable(_draft.actions);
  List<NotificationActionGroup> get conditionalActionGroups =>
      List<NotificationActionGroup>.unmodifiable(
        _draft.conditionalActionGroups,
      );
  Set<TransactionField> get reviewedPredefinedFields =>
      Set<TransactionField>.unmodifiable(_draft.reviewedPredefinedFields);
  NotificationContext testNotificationContext;
  bool isTestMode;

  NotificationSample? get sampleOverride => _sampleOverride;
  bool get usesDefinitionSample => _usesDefinitionSample;

  NotificationContext get sampleNotificationContext {
    final NotificationSample? override = _sampleOverride;
    if (override == null) {
      return _usesDefinitionSample
          ? _definitionSampleContext ?? _notificationContext
          : _notificationContext;
    }
    return override.toNotificationContext(
      applicationId: _notificationContext.applicationId,
      applicationName: _notificationContext.applicationName,
      deliveryId: _notificationContext.deliveryId,
    );
  }

  bool get isDirty =>
      _draft.isDirty ||
      !jsonStructuresEqual(
        _sampleOverride?.toJson(),
        _originalSampleOverride?.toJson(),
      );

  void acceptChanges() {
    _draft.acceptChanges();
    _originalSampleOverride = _sampleOverride;
    notifyListeners();
  }

  NotificationRule get currentRule {
    final NotificationRule rule = _draft.build();
    return _sampleOverride == null
        ? rule.withoutSampleOverride()
        : rule.copyWith(sampleOverride: _sampleOverride);
  }

  List<NotificationRuleRequirementGroup> requirementGroups(
    Iterable<RegExpDefinition> extractors, {
    Iterable<NotificationAction> inheritedActions =
        const <NotificationAction>[],
  }) {
    final List<RegExpDefinition> extractorList = extractors.toList();
    final EvaluationContext context = EvaluationContext(
      notification: sampleNotificationContext,
      extractionResults: <String, RegExpEvaluationResult>{
        for (final RegExpDefinition extractor in extractorList)
          extractor.id: extractor.evaluate(sampleNotificationContext),
      },
    );
    final Map<String, List<NotificationRuleRequirement>> grouped =
        <String, List<NotificationRuleRequirement>>{};
    final Set<String> inheritedExtractorIds =
        NotificationRule(
              id: currentRule.id,
              name: currentRule.name,
              conditions: const <NotificationCondition>[],
              actions: inheritedActions.toList(),
            ).requirements
            .map(
              (NotificationRuleRequirement requirement) =>
                  requirement.capture.extractorId,
            )
            .toSet();
    final NotificationRule requirementRule = currentRule.copyWith(
      actions: <NotificationAction>[
        ...inheritedActions,
        ...currentRule.actions,
      ],
    );
    for (final NotificationRuleRequirement requirement
        in requirementRule.requirements) {
      grouped
          .putIfAbsent(
            requirement.capture.extractorId,
            () => <NotificationRuleRequirement>[],
          )
          .add(requirement);
    }
    return List<NotificationRuleRequirementGroup>.unmodifiable(
      grouped.entries.map((
        MapEntry<String, List<NotificationRuleRequirement>> entry,
      ) {
        final RegExpDefinition? extractor = extractorList
            .cast<RegExpDefinition?>()
            .firstWhere(
              (RegExpDefinition? item) => item?.id == entry.key,
              orElse: () => null,
            );
        return NotificationRuleRequirementGroup(
          extractor: extractor,
          requirements: List<NotificationRuleRequirement>.unmodifiable(
            entry.value,
          ),
          available: entry.value.every(
            (NotificationRuleRequirement requirement) =>
                requirement.isAvailable(context),
          ),
          inherited: inheritedExtractorIds.contains(entry.key),
        );
      }),
    );
  }

  void updateName(String value) {
    _draft.name = value;
    notifyListeners();
  }

  void updateDescription(String value) {
    _draft.description = value;
    notifyListeners();
  }

  void addCondition(NotificationCondition condition) {
    _draft.conditions = <NotificationCondition>[
      ..._draft.conditions,
      condition,
    ];
    notifyListeners();
  }

  void replaceConditionAt(int index, NotificationCondition condition) {
    final List<NotificationCondition> updated =
        List<NotificationCondition>.from(_draft.conditions);
    updated[index] = condition;
    _draft.conditions = updated;
    notifyListeners();
  }

  void replaceConditions(List<NotificationCondition> conditions) {
    _draft.conditions = List<NotificationCondition>.from(conditions);
    notifyListeners();
  }

  void moveCondition(int fromIndex, int toIndex) {
    final List<NotificationCondition> updated =
        List<NotificationCondition>.from(_draft.conditions);
    final NotificationCondition condition = updated.removeAt(fromIndex);
    updated.insert(toIndex, condition);
    _draft.conditions = updated;
    notifyListeners();
  }

  NotificationCondition cloneCondition(NotificationCondition condition) =>
      NotificationCondition.fromJson(condition.toJson());

  NotificationCondition duplicateConditionAt(int index) {
    final NotificationCondition duplicate = cloneCondition(
      _draft.conditions[index],
    );
    final List<NotificationCondition> updated =
        List<NotificationCondition>.from(_draft.conditions)
          ..insert(index + 1, duplicate);
    _draft.conditions = updated;
    notifyListeners();
    return duplicate;
  }

  void removeConditionAt(int index) {
    final List<NotificationCondition> updated =
        List<NotificationCondition>.from(_draft.conditions)..removeAt(index);
    _draft.conditions = updated;
    notifyListeners();
  }

  void addAction(NotificationAction action) {
    _draft.actions = <NotificationAction>[..._draft.actions, action];
    notifyListeners();
  }

  void addConditionalActionGroup(NotificationActionGroup group) {
    _draft.conditionalActionGroups = <NotificationActionGroup>[
      ..._draft.conditionalActionGroups,
      group,
    ];
    notifyListeners();
  }

  NotificationActionGroup duplicateConditionalActionGroup(
    NotificationActionGroup group,
  ) {
    final int index = _draft.conditionalActionGroups.indexWhere(
      (NotificationActionGroup current) => current.id == group.id,
    );
    final NotificationActionGroup duplicate = NotificationActionGroup.fromJson(
      group.toJson(),
    ).copyWith(id: newNotificationId());
    final List<NotificationActionGroup> groups =
        List<NotificationActionGroup>.from(_draft.conditionalActionGroups)
          ..insert(index + 1, duplicate);
    _draft.conditionalActionGroups = groups;
    notifyListeners();
    return duplicate;
  }

  void replaceConditionalActionGroup(NotificationActionGroup group) {
    _draft.conditionalActionGroups = _draft.conditionalActionGroups
        .map(
          (NotificationActionGroup current) =>
              current.id == group.id ? group : current,
        )
        .toList();
    notifyListeners();
  }

  void removeConditionalActionGroup(String groupId) {
    _draft.conditionalActionGroups = _draft.conditionalActionGroups
        .where((NotificationActionGroup group) => group.id != groupId)
        .toList();
    notifyListeners();
  }

  void moveConditionalActionGroup(int fromIndex, int toIndex) {
    final List<NotificationActionGroup> groups =
        List<NotificationActionGroup>.from(_draft.conditionalActionGroups);
    final NotificationActionGroup group = groups.removeAt(fromIndex);
    groups.insert(toIndex.clamp(0, groups.length), group);
    _draft.conditionalActionGroups = groups;
    notifyListeners();
  }

  void addOptionalPredefinedAction({
    required TransactionField field,
    required Iterable<RegExpDefinition> extractors,
  }) {
    final (PredefinedRegExpDefinition, String) capture = switch (field) {
      TransactionField.currency => (
        PredefinedRegExpDefinition.currency,
        'postCurrency',
      ),
      TransactionField.title => (
        PredefinedRegExpDefinition.notificationTitle,
        'title',
      ),
      TransactionField.notes => (
        PredefinedRegExpDefinition.notificationMessage,
        'message',
      ),
      _ => throw ArgumentError.value(field, 'field'),
    };
    final RegExpDefinition extractor = extractors.firstWhere(
      (RegExpDefinition extractor) => extractor.predefinedType == capture.$1,
    );
    addAction(
      SetTransactionFieldAction(
        target: field,
        valueSource: RegExpCaptureValueSource(
          extractorId: extractor.id,
          captureName: capture.$2,
        ),
      ),
    );
  }

  void replaceActionAt(int index, NotificationAction action) {
    final List<NotificationAction> updated = List<NotificationAction>.from(
      _draft.actions,
    );
    updated[index] = action;
    _draft.actions = updated;
    notifyListeners();
  }

  void removeActionAt(int index) {
    final NotificationAction removed = _draft.actions[index];
    final List<NotificationAction> updated = List<NotificationAction>.from(
      _draft.actions,
    )..removeAt(index);
    _draft.actions = updated;
    if (removed case SetTransactionFieldAction(
      :final TransactionField target,
    )) {
      final bool targetStillConfigured = updated
          .whereType<SetTransactionFieldAction>()
          .any((SetTransactionFieldAction action) => action.target == target);
      if (!targetStillConfigured) {
        _draft.reviewedPredefinedFields = Set<TransactionField>.from(
          _draft.reviewedPredefinedFields,
        )..remove(target);
      }
    }
    notifyListeners();
  }

  SetTransactionTagsAction removeTagFromAction(int index, String tag) {
    final SetTransactionTagsAction current =
        _draft.actions[index] as SetTransactionTagsAction;
    final List<String> remainingTags = List<String>.from(current.tags)
      ..remove(tag);
    final SetTransactionTagsAction replacement = SetTransactionTagsAction(
      remainingTags,
    );
    replaceActionAt(index, replacement);
    return replacement;
  }

  void setPredefinedFieldReviewed(TransactionField field, bool reviewed) {
    final Set<TransactionField> updated = Set<TransactionField>.from(
      _draft.reviewedPredefinedFields,
    );
    if (reviewed) {
      updated.add(field);
    } else {
      updated.remove(field);
    }
    _draft.reviewedPredefinedFields = updated;
    notifyListeners();
  }

  void updateTestNotificationContext(NotificationContext value) {
    testNotificationContext = value;
    notifyListeners();
  }

  void updateSampleOverride(NotificationSample value) {
    _sampleOverride = value;
    _usesDefinitionSample = false;
    testNotificationContext = sampleNotificationContext;
    notifyListeners();
  }

  void clearSampleOverride() {
    _sampleOverride = null;
    _usesDefinitionSample = true;
    testNotificationContext = sampleNotificationContext;
    notifyListeners();
  }

  void toggleTestMode() {
    isTestMode = !isTestMode;
    notifyListeners();
  }
}

@immutable
class NotificationRuleRequirementGroup {
  const NotificationRuleRequirementGroup({
    required this.extractor,
    required this.available,
    this.requirements = const <NotificationRuleRequirement>[],
    this.inherited = false,
  });

  final RegExpDefinition? extractor;
  final bool available;
  final List<NotificationRuleRequirement> requirements;
  final bool inherited;
}
