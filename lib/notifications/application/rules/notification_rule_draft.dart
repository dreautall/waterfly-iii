import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_action_group.dart';
import 'package:waterflyiii/notifications/application/shared/json_equality.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';

class NotificationRuleDraft {
  NotificationRuleDraft.fromRule(this._original)
    : name = _original.name,
      description = _original.description,
      conditions = List<NotificationCondition>.from(_original.conditions),
      actions = List<NotificationAction>.from(_original.actions),
      conditionalActionGroups = List<NotificationActionGroup>.from(
        _original.conditionalActionGroups,
      ),
      reviewedPredefinedFields = Set<TransactionField>.from(
        _original.reviewedPredefinedFields,
      );

  NotificationRule _original;
  String name;
  String description;
  List<NotificationCondition> conditions;
  List<NotificationAction> actions;
  List<NotificationActionGroup> conditionalActionGroups;
  Set<TransactionField> reviewedPredefinedFields;

  NotificationRule build() => _original.copyWith(
    name: name.trim(),
    description: description.trim(),
    conditions: List<NotificationCondition>.from(conditions),
    actions: List<NotificationAction>.from(actions),
    conditionalActionGroups: List<NotificationActionGroup>.from(
      conditionalActionGroups,
    ),
    reviewedPredefinedFields: Set<TransactionField>.from(
      reviewedPredefinedFields,
    ),
  );

  bool get isDirty =>
      !jsonStructuresEqual(build().toJson(), _original.toJson());

  void acceptChanges() {
    _original = build();
  }
}
