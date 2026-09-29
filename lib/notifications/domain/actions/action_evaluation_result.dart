import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_patch.dart';

class ActionEvaluationResult {
  const ActionEvaluationResult.success(this.patch)
    : creationMode = null,
      failureReason = null;

  const ActionEvaluationResult.plan(this.creationMode)
    : patch = null,
      failureReason = null;

  const ActionEvaluationResult.failure(this.failureReason)
    : patch = null,
      creationMode = null;

  final TransactionPatch? patch;
  final TransactionCreationMode? creationMode;
  final String? failureReason;

  bool get succeeded => failureReason == null;
}
