import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_tags_action.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/currency_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/actions/transaction_action_value_dialog.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';

import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_editor_shared.dart';

import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_action_editor.dart';

extension RulePredefinedActionEditor on RuleActionsSectionState {
  Widget predefinedActionGroups() {
    final List<NotificationAction> fixedActions = actions
        .where(
          (NotificationAction action) =>
              !isOptionalPredefinedAction(action) &&
              !canAdjustPredefinedAction(action),
        )
        .toList();
    final List<NotificationAction> adjustableActions = actions
        .where(
          (NotificationAction action) =>
              isOptionalPredefinedAction(action) ||
              canAdjustPredefinedAction(action),
        )
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (fixedActions.isNotEmpty) ...<Widget>[
          Text(
            S.of(context).notificationsRuleFixedMappings,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          if (widget.extractorMode ==
              NotificationExtractorMode.basic) ...<Widget>[
            const SizedBox(height: 4),
            Text(
              S.of(context).notificationsRuleFixedMappingsDescription,
              style: context.notificationSectionDescription,
            ),
          ],
          const SizedBox(height: 8),
          ...actionRows(fixedActions),
        ],
        if (fixedActions.isNotEmpty) const SizedBox(height: 16),
        Text(
          S.of(context).notificationsRuleAdjustableMappings,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 4),
        Text(
          S.of(context).notificationsRuleAdjustableMappingsDescription,
          style: context.notificationSectionDescription,
        ),
        const SizedBox(height: 8),
        if (adjustableActions.isNotEmpty) ...<Widget>[
          ...actionRows(adjustableActions),
        ],
        ElevatedButton.icon(
          onPressed: addOptionalPredefinedField,
          icon: const Icon(Icons.add),
          label: Text(S.of(context).notificationsRuleAddOptionalField),
        ),
      ],
    );
  }

  Widget? predefinedActionControls(NotificationAction action, bool editable) {
    final TransactionField? target = targetFor(action);
    if (target == null) return null;
    final List<Widget> controls = <Widget>[];
    if (target == TransactionField.currency && editable) {
      controls.add(
        IconButton(
          tooltip: S.of(context).notificationsRuleEditCurrencyMapping,
          onPressed: () =>
              editPredefinedAction(actions.indexOf(action), action),
          icon: const Icon(Icons.edit_outlined),
        ),
      );
      controls.add(
        IconButton(
          tooltip: S.of(context).notificationsRuleRemoveOptionalMapping,
          onPressed: () => removeAction(actions.indexOf(action)),
          icon: const Icon(Icons.delete_outline),
        ),
      );
    } else if (editable) {
      controls.add(
        IconButton(
          tooltip: reviewedPredefinedFields.contains(target)
              ? S.of(context).notificationsRuleMarkMappingNeedsReview
              : S.of(context).notificationsRuleMarkMappingDone,
          onPressed: () => togglePredefinedReview(action, target),
          icon: Icon(
            reviewedPredefinedFields.contains(target)
                ? Icons.check_circle
                : Icons.check_circle_outline,
          ),
        ),
      );
    }
    if (target != TransactionField.currency &&
        optionalPredefinedFields.contains(target)) {
      controls.add(
        IconButton(
          tooltip: S.of(context).notificationsRuleRemoveOptionalMapping,
          onPressed: () => removeAction(actions.indexOf(action)),
          icon: const Icon(Icons.delete_outline),
        ),
      );
    }
    return Row(mainAxisSize: MainAxisSize.min, children: controls);
  }

  TransactionField? targetFor(NotificationAction action) => switch (action) {
    SetTransactionFieldAction(:final TransactionField target) => target,
    SetTransactionTagsAction() => TransactionField.tag,
    _ => null,
  };

  void togglePredefinedReview(
    NotificationAction action,
    TransactionField target,
  ) {
    if (target == TransactionField.currency &&
        (action as SetTransactionFieldAction).valueSource
            is! CurrencyCaptureValueSource) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            S.of(context).notificationsRuleChooseMatchingCurrencyBeforeReview,
          ),
        ),
        snackBarAnimationStyle: ruleEditorMessageAnimation,
      );
      return;
    }
    widget.onSetPredefinedFieldReviewed(
      target,
      !reviewedPredefinedFields.contains(target),
    );
  }

  bool canAdjustPredefinedAction(NotificationAction action) {
    if (action is! SetTransactionFieldAction) return false;
    if (action.target == TransactionField.currency) return true;
    final RegExpCaptureValueSource? capture = captureFor(action.valueSource);
    if (capture == null) return false;
    final RegExpDefinition? extractor = extractorFor(capture);
    if (extractor == null) return false;
    final List<RegExpMatch> matches = extractor
        .evaluate(widget.notificationContext)
        .matches;
    return matches.length > 1 ||
        matches.any(
          (RegExpMatch match) =>
              match.groupNames
                  .where(
                    (String name) =>
                        match.namedGroup(name)?.isNotEmpty ?? false,
                  )
                  .length >
              1,
        );
  }

  static const Set<TransactionField> optionalPredefinedFields =
      <TransactionField>{
        TransactionField.currency,
        TransactionField.title,
        TransactionField.notes,
      };

  bool isOptionalPredefinedAction(NotificationAction action) =>
      action is SetTransactionFieldAction &&
      optionalPredefinedFields.contains(action.target);

  Future<void> addOptionalPredefinedField() async {
    final Set<TransactionField> configuredFields = actions
        .whereType<SetTransactionFieldAction>()
        .map((SetTransactionFieldAction action) => action.target)
        .toSet();
    final NotificationAction? action =
        await selectOptionalPredefinedTransactionAction(
          context,
          extractors: widget.extractors,
          notificationContext: widget.notificationContext,
          unavailableFields: configuredFields,
          allowFireflyResource:
              widget.extractorMode != NotificationExtractorMode.basic,
        );
    if (action is SetTransactionFieldAction && mounted) {
      widget.onAdd(action);
      widget.onSetPredefinedFieldReviewed(action.target, true);
      highlightAction(action);
    }
  }
}
