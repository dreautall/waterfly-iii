import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/actions/action_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_definition_evaluator.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_definition_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_action_group_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_rule_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_action_group.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_patch.dart';
import 'package:waterflyiii/notifications/presentation/shared/message_status_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';
import 'package:waterflyiii/notifications/presentation/shared/transaction_patch_summary.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_date_time_formatter.dart';

class EffectiveTransactionPreviewCard extends StatelessWidget {
  const EffectiveTransactionPreviewCard({
    super.key,
    required this.rule,
    required this.rules,
    this.sharedActions = const <NotificationAction>[],
    required this.extractors,
    required this.notificationContext,
    required this.transactionCreationMode,
    this.showProvenance = true,
  });

  final NotificationRule rule;
  final List<NotificationRule> rules;
  final List<NotificationAction> sharedActions;
  final List<RegExpDefinition> extractors;
  final NotificationContext notificationContext;
  final TransactionCreationMode transactionCreationMode;
  final bool showProvenance;

  @override
  Widget build(BuildContext context) {
    final NotificationDefinitionEvaluationResult evaluation = _evaluatePreview(
      context,
    );
    final String previewRuleId = '__preview_${rule.id}';
    final TransactionPatch patch =
        evaluation.effectiveTransactionIntent?.patch ??
        _partialPatch(evaluation, previewRuleId);
    final S strings = S.of(context);
    final List<_PreviewValue> values = _previewValues(
      evaluation,
      patch,
      strings,
    );
    final Map<TransactionField, String> displayValues =
        <TransactionField, String>{
          for (final _PreviewValue value in values)
            if (value.field != TransactionField.tag) value.field: value.value,
        };
    final Map<TransactionField, TransactionFieldProvenance> fieldProvenance =
        showProvenance
        ? <TransactionField, TransactionFieldProvenance>{
            for (final _PreviewValue value in values)
              if (value.field != TransactionField.tag)
                value.field: _provenance(value, strings),
          }
        : const <TransactionField, TransactionFieldProvenance>{};
    final _PreviewValue? tagValue = values
        .where((_PreviewValue value) => value.field == TransactionField.tag)
        .firstOrNull;
    final TransactionPatch displayPatch = TransactionPatch(
      patch.values,
      tags: patch.tags,
      displayValues: displayValues,
      currencyCodes: patch.currencyCodes,
      resourceReferences: patch.resourceReferences,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          strings.notificationsDefinitionResolvedTransaction,
          style: context.notificationSectionTitle,
        ),
        const SizedBox(height: 4),
        Text(
          strings.notificationsDefinitionResolvedTransactionDescription,
          style: context.notificationSectionDescription,
        ),
        const SizedBox(height: 12),
        if (values.isEmpty)
          MessageStatusCard(
            status: MessageStatus.informational,
            message: strings.notificationsDefinitionNoResolvedTransactionFields,
          )
        else
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TransactionPatchSummary(
                patch: displayPatch,
                fieldProvenance: fieldProvenance,
                tagProvenance: !showProvenance || tagValue == null
                    ? null
                    : _provenance(tagValue, strings),
              ),
            ),
          ),
      ],
    );
  }

  NotificationDefinitionEvaluationResult _evaluatePreview(
    BuildContext context,
  ) {
    final NotificationRule previewRule = rule.copyWith(
      id: '__preview_${rule.id}',
      conditions: const <NotificationCondition>[],
    );
    return NotificationDefinitionEvaluator(
      extractors: extractors,
      rules: <NotificationRule>[previewRule],
      sharedActions: sharedActions,
      transactionCreationMode: transactionCreationMode,
      formattingPreferences: notificationFormattingPreferencesOf(context),
    ).evaluate(notificationContext);
  }

  TransactionPatch _partialPatch(
    NotificationDefinitionEvaluationResult evaluation,
    String previewRuleId,
  ) => TransactionPatch.merge(<TransactionPatch?>[
    ...evaluation.sharedActions.map(
      (ActionEvaluationResult result) => result.patch,
    ),
    evaluation.ruleResults[previewRuleId]?.patch,
  ]);

  List<_PreviewValue> _previewValues(
    NotificationDefinitionEvaluationResult evaluation,
    TransactionPatch patch,
    S strings,
  ) {
    final String previewRuleId = '__preview_${rule.id}';
    final TransactionPatch sharedPatch = _patchFor(evaluation.sharedActions);
    final NotificationRuleEvaluationResult? ruleResult =
        evaluation.ruleResults[previewRuleId];
    final TransactionPatch alwaysPatch = _patchFor(
      ruleResult?.actions ?? const <ActionEvaluationResult>[],
    );
    final Map<TransactionField, List<String>> sourcesByField =
        <TransactionField, List<String>>{};
    void addSources(TransactionPatch sourcePatch, String source) {
      for (final TransactionField field in sourcePatch.values.keys) {
        sourcesByField.putIfAbsent(field, () => <String>[]).add(source);
      }
    }

    addSources(
      sharedPatch,
      strings.notificationsDefinitionPreviewSharedActions,
    );
    addSources(alwaysPatch, strings.notificationsDefinitionPreviewThisRule);
    for (final NotificationActionGroup group in rule.conditionalActionGroups) {
      final NotificationActionGroupEvaluationResult? groupResult =
          ruleResult?.conditionalGroups[group.id];
      if (groupResult?.matches ?? false) {
        addSources(groupResult!.patch, group.name);
      }
    }

    NotificationActionGroup? sourceGroupForField(TransactionField field) {
      for (final NotificationActionGroup group
          in rule.conditionalActionGroups.reversed) {
        if (ruleResult?.conditionalGroups[group.id]?.patch.values.containsKey(
              field,
            ) ??
            false) {
          return group;
        }
      }
      return null;
    }

    String sourceForField(TransactionField field) {
      final NotificationActionGroup? group = sourceGroupForField(field);
      if (group != null) return group.name;
      if (alwaysPatch.values.containsKey(field)) {
        return strings.notificationsDefinitionPreviewThisRule;
      }
      if (sharedPatch.values.containsKey(field)) {
        return strings.notificationsDefinitionPreviewSharedActions;
      }
      return strings.notificationsDefinitionPreviewThisRule;
    }

    String sourceForTag(String tag) {
      for (final NotificationActionGroup group
          in rule.conditionalActionGroups.reversed) {
        if (ruleResult?.conditionalGroups[group.id]?.patch.tags.contains(tag) ??
            false) {
          return group.name;
        }
      }
      if (alwaysPatch.tags.contains(tag)) {
        return strings.notificationsDefinitionPreviewThisRule;
      }
      return strings.notificationsDefinitionPreviewSharedActions;
    }

    String displayValueForField(MapEntry<TransactionField, String> entry) {
      return entry.value;
    }

    final Set<String> tagSources = patch.tags.map(sourceForTag).toSet();
    return <_PreviewValue>[
      for (final MapEntry<TransactionField, String> entry
          in patch.values.entries)
        _PreviewValue(
          field: entry.key,
          value: displayValueForField(entry),
          source: sourceForField(entry.key),
          overriddenSources: (sourcesByField[entry.key] ?? const <String>[])
              .reversed
              .skip(1)
              .toSet()
              .toList()
              .reversed
              .toList(),
        ),
      if (patch.tags.isNotEmpty)
        _PreviewValue(
          field: TransactionField.tag,
          value: patch.tags.join(', '),
          source: tagSources.length == 1
              ? tagSources.single
              : strings.notificationsDefinitionPreviewMultipleRules,
        ),
    ];
  }

  TransactionPatch _patchFor(List<ActionEvaluationResult> results) {
    return TransactionPatch.merge(
      results.map((ActionEvaluationResult result) => result.patch),
    );
  }

  TransactionFieldProvenance _provenance(_PreviewValue value, S strings) =>
      TransactionFieldProvenance(
        source: strings.notificationsDefinitionPreviewSetBy(value.source),
        overrides: value.overriddenSources.isEmpty
            ? null
            : strings.notificationsDefinitionPreviewOverrides(
                value.overriddenSources.join(', '),
              ),
      );
}

class _PreviewValue {
  const _PreviewValue({
    required this.field,
    required this.value,
    required this.source,
    this.overriddenSources = const <String>[],
  });

  final TransactionField field;
  final String value;
  final String source;
  final List<String> overriddenSources;
}
