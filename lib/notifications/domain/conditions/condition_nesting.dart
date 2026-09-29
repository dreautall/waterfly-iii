import 'package:waterflyiii/notifications/domain/conditions/all_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/any_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/not_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';

const int maximumConditionNestingDepth = 3;

int conditionNestingDepth(NotificationCondition condition) =>
    switch (condition) {
      final AllCondition group => 1 + _maximumDepth(group.conditions),
      final AnyCondition group => 1 + _maximumDepth(group.conditions),
      final NotCondition negation =>
        1 + conditionNestingDepth(negation.condition),
      _ => 0,
    };

int _maximumDepth(List<NotificationCondition> conditions) => conditions.isEmpty
    ? 0
    : conditions
          .map(conditionNestingDepth)
          .reduce((int current, int next) => current > next ? current : next);
