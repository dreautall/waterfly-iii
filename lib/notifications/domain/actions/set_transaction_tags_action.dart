import 'package:waterflyiii/notifications/domain/actions/action_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_patch.dart';

class SetTransactionTagsAction implements NotificationAction {
  const SetTransactionTagsAction(this.tags);

  static const String type = 'setTransactionTags';

  final List<String> tags;

  @override
  ActionEvaluationResult evaluate(EvaluationContext context) {
    final List<String> normalizedTags = <String>[];
    for (final String tag in tags) {
      final String normalizedTag = tag.trim();
      if (normalizedTag.isEmpty) continue;
      if (!normalizedTags.any(
        (String existing) =>
            existing.toLowerCase() == normalizedTag.toLowerCase(),
      )) {
        normalizedTags.add(normalizedTag);
      }
    }
    if (normalizedTags.isEmpty) {
      return const ActionEvaluationResult.failure(
        'Select at least one transaction tag.',
      );
    }
    return ActionEvaluationResult.success(
      TransactionPatch(
        const <TransactionField, String>{},
        tags: normalizedTags,
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'type': type,
    'tags': tags,
  };

  factory SetTransactionTagsAction.fromJson(Map<String, dynamic> json) =>
      SetTransactionTagsAction((json['tags'] as List<dynamic>).cast<String>());
}
