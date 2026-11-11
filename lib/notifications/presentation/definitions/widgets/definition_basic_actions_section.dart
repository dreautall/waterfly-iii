import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_tags_action.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/presentation/definitions/widgets/rule_effective_transaction_preview.dart';
import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_action_editor.dart';

class DefinitionBasicActionsSection extends StatelessWidget {
  const DefinitionBasicActionsSection({
    super.key,
    required this.actions,
    required this.reviewedFields,
    required this.extractors,
    required this.notificationContext,
    required this.onAdd,
    required this.onReplaceAt,
    required this.onRemoveAt,
    required this.onRemoveTag,
    required this.onSetFieldReviewed,
  });

  final List<NotificationAction> actions;
  final Set<TransactionField> reviewedFields;
  final List<RegExpDefinition> extractors;
  final NotificationContext notificationContext;
  final ValueChanged<NotificationAction> onAdd;
  final void Function(int, NotificationAction) onReplaceAt;
  final ValueChanged<int> onRemoveAt;
  final SetTransactionTagsAction Function(int, String) onRemoveTag;
  final void Function(TransactionField, bool) onSetFieldReviewed;

  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);
    final NotificationRule rule = _basicActionsRule(
      strings,
      actions,
      reviewedFields,
    );
    return RuleActionsSection(
      rule: rule,
      actions: actions,
      title: strings.notificationsRuleActionsTitle,
      description: strings.notificationsDefinitionBasicActionsDescription,
      emptyText: strings.notificationsDefinitionNoTransactionFields,
      reviewedPredefinedFields: reviewedFields,
      extractors: extractors,
      notificationContext: notificationContext,
      activeNotificationContext: notificationContext,
      extractorMode: NotificationExtractorMode.basic,
      ruleName: rule.name,
      onAdd: onAdd,
      onReplaceAt: onReplaceAt,
      onRemoveAt: onRemoveAt,
      onRemoveTag: onRemoveTag,
      onSetPredefinedFieldReviewed: onSetFieldReviewed,
    );
  }
}

class DefinitionBasicTransactionPreview extends StatelessWidget {
  const DefinitionBasicTransactionPreview({
    super.key,
    required this.actions,
    required this.reviewedFields,
    required this.extractors,
    required this.notificationContext,
    required this.transactionCreationMode,
  });

  final List<NotificationAction> actions;
  final Set<TransactionField> reviewedFields;
  final List<RegExpDefinition> extractors;
  final NotificationContext notificationContext;
  final TransactionCreationMode transactionCreationMode;

  @override
  Widget build(BuildContext context) {
    return EffectiveTransactionPreviewCard(
      rule: _basicActionsRule(S.of(context), actions, reviewedFields),
      rules: const <NotificationRule>[],
      sharedActions: const <NotificationAction>[],
      extractors: extractors,
      notificationContext: notificationContext,
      transactionCreationMode: transactionCreationMode,
      showProvenance: false,
    );
  }
}

NotificationRule _basicActionsRule(
  S strings,
  List<NotificationAction> actions,
  Set<TransactionField> reviewedFields,
) {
  return NotificationRule(
    id: 'shared-actions',
    name: strings.notificationsDefinitionSetTransactionFields,
    conditions: const <NotificationCondition>[],
    actions: actions,
    isPredefined: true,
    reviewedPredefinedFields: reviewedFields,
  );
}
