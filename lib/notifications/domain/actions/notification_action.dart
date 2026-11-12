import 'package:waterflyiii/notifications/domain/actions/action_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_tags_action.dart';
import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';

abstract interface class NotificationAction {
  ActionEvaluationResult evaluate(EvaluationContext context);

  Map<String, dynamic> toJson();

  static NotificationAction fromJson(Map<String, dynamic> json) {
    switch (json['type'] as String) {
      case SetTransactionFieldAction.type:
        return SetTransactionFieldAction.fromJson(json);
      case SetTransactionTagsAction.type:
        return SetTransactionTagsAction.fromJson(json);
      default:
        throw FormatException(
          'Unknown notification action type: ${json['type']}',
        );
    }
  }
}
