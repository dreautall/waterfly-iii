import 'package:waterflyiii/notifications/domain/actions/action_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_definition_evaluator.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_patch.dart';

enum AutomaticTransactionRequirement { title, positiveAmount, account }

class AutomaticTransactionReadiness {
  const AutomaticTransactionReadiness(this.missingRequirements);

  final Set<AutomaticTransactionRequirement> missingRequirements;

  bool get isReady => missingRequirements.isEmpty;

  factory AutomaticTransactionReadiness.evaluate({
    required List<NotificationAction> sharedActions,
    required List<RegExpDefinition> extractors,
    required NotificationContext notificationContext,
  }) {
    final List<ActionEvaluationResult> results =
        NotificationDefinitionEvaluator(
          extractors: extractors,
          rules: const <NotificationRule>[],
          sharedActions: sharedActions,
          transactionCreationMode: TransactionCreationMode.automatic,
        ).evaluate(notificationContext).sharedActions;
    final TransactionPatch patch = TransactionPatch.merge(
      results.map((ActionEvaluationResult result) => result.patch),
    );
    final String? title = patch.values[TransactionField.title];
    final String? amount = patch.values[TransactionField.amount];
    final num? parsedAmount = amount == null
        ? null
        : num.tryParse(amount.trim().replaceAll(',', '.'));
    final String? sourceAccount = patch.values[TransactionField.sourceAccount];
    final String? destinationAccount =
        patch.values[TransactionField.destinationAccount];
    return AutomaticTransactionReadiness(<AutomaticTransactionRequirement>{
      if (title?.trim().isEmpty ?? true) AutomaticTransactionRequirement.title,
      if (parsedAmount == null || !parsedAmount.isFinite || parsedAmount <= 0)
        AutomaticTransactionRequirement.positiveAmount,
      if ((sourceAccount?.trim().isEmpty ?? true) &&
          (destinationAccount?.trim().isEmpty ?? true))
        AutomaticTransactionRequirement.account,
    });
  }
}
