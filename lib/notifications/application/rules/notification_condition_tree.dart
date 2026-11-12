import 'package:waterflyiii/notifications/domain/conditions/all_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/any_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/not_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';

class NotificationConditionTree {
  const NotificationConditionTree();

  NotificationCondition clone(NotificationCondition condition) =>
      NotificationCondition.fromJson(condition.toJson());

  List<NotificationCondition> normalizeGroupChildren(
    NotificationCondition group,
    List<NotificationCondition> conditions,
  ) => <NotificationCondition>[
    for (final NotificationCondition condition in conditions)
      ...switch (normalize(condition)) {
        AllCondition(:final List<NotificationCondition> conditions)
            when group is AllCondition =>
          conditions,
        AnyCondition(:final List<NotificationCondition> conditions)
            when group is AnyCondition =>
          conditions,
        final NotificationCondition condition => <NotificationCondition>[
          condition,
        ],
      },
  ];

  bool willFlattenGroupChildren(
    NotificationCondition group,
    List<NotificationCondition> conditions,
  ) => conditions.any((NotificationCondition condition) {
    final NotificationCondition normalized = normalize(condition);
    return (group is AllCondition && normalized is AllCondition) ||
        (group is AnyCondition && normalized is AnyCondition);
  });

  NotificationCondition normalize(NotificationCondition condition) {
    if (condition case AllCondition(
      :final List<NotificationCondition> conditions,
    )) {
      final List<NotificationCondition> normalized = normalizeGroupChildren(
        condition,
        conditions,
      );
      return _sameConditions(conditions, normalized)
          ? condition
          : AllCondition(normalized);
    }
    if (condition case AnyCondition(
      :final List<NotificationCondition> conditions,
    )) {
      final List<NotificationCondition> normalized = normalizeGroupChildren(
        condition,
        conditions,
      );
      return _sameConditions(conditions, normalized)
          ? condition
          : AnyCondition(normalized);
    }
    if (condition case NotCondition(:final NotificationCondition condition)) {
      final NotificationCondition normalized = normalize(condition);
      return normalized is NotCondition
          ? normalized.condition
          : NotCondition(normalized);
    }
    return condition;
  }

  bool contains(NotificationCondition parent, NotificationCondition target) =>
      childrenOf(parent).any(
        (NotificationCondition child) =>
            identical(child, target) || contains(child, target),
      );

  bool isDirectChild(
    NotificationCondition parent,
    NotificationCondition child,
  ) => childrenOf(
    parent,
  ).any((NotificationCondition item) => identical(item, child));

  bool canPaste({
    required List<NotificationCondition> roots,
    required NotificationCondition source,
    required NotificationCondition? removal,
    required NotificationCondition? target,
  }) {
    if (removal == null) return true;
    if (target == null) {
      return !identical(source, removal) ||
          !roots.any(
            (NotificationCondition condition) => identical(condition, removal),
          );
    }
    return !identical(removal, target) &&
        !contains(removal, target) &&
        (!identical(source, removal) || !isDirectChild(target, removal));
  }

  bool hasMoveTarget({
    required List<NotificationCondition> roots,
    required NotificationCondition source,
    required NotificationCondition removal,
  }) {
    if (!identical(source, removal) ||
        !roots.any(
          (NotificationCondition condition) => identical(condition, removal),
        )) {
      return true;
    }

    bool hasTarget(NotificationCondition condition) {
      if ((condition is AllCondition || condition is AnyCondition) &&
          !identical(condition, removal) &&
          !contains(removal, condition) &&
          !isDirectChild(condition, removal)) {
        return true;
      }
      return childrenOf(condition).any(hasTarget);
    }

    return roots.any(hasTarget);
  }

  NotificationConditionTreeMoveResult move({
    required List<NotificationCondition> roots,
    required NotificationCondition removal,
    required NotificationCondition? target,
    required NotificationCondition pasted,
  }) {
    final Map<NotificationCondition, NotificationCondition> replacements =
        <NotificationCondition, NotificationCondition>{};
    final Set<NotificationCondition> removedContainers =
        <NotificationCondition>{};

    NotificationCondition? moveNode(NotificationCondition condition) {
      if (identical(condition, removal)) return null;
      if (condition is AllCondition) {
        final AllCondition updated = AllCondition(
          identical(condition, target)
              ? normalizeGroupChildren(condition, <NotificationCondition>[
                  for (final NotificationCondition child
                      in condition.conditions)
                    if (moveNode(child) case final NotificationCondition moved)
                      moved,
                  pasted,
                ])
              : <NotificationCondition>[
                  for (final NotificationCondition child
                      in condition.conditions)
                    if (moveNode(child) case final NotificationCondition moved)
                      moved,
                ],
        );
        replacements[condition] = updated;
        return updated;
      }
      if (condition is AnyCondition) {
        final AnyCondition updated = AnyCondition(
          identical(condition, target)
              ? normalizeGroupChildren(condition, <NotificationCondition>[
                  for (final NotificationCondition child
                      in condition.conditions)
                    if (moveNode(child) case final NotificationCondition moved)
                      moved,
                  pasted,
                ])
              : <NotificationCondition>[
                  for (final NotificationCondition child
                      in condition.conditions)
                    if (moveNode(child) case final NotificationCondition moved)
                      moved,
                ],
        );
        replacements[condition] = updated;
        return updated;
      }
      if (condition is NotCondition) {
        final NotificationCondition? child = moveNode(condition.condition);
        if (child == null) {
          removedContainers.add(condition);
          return null;
        }
        final NotCondition updated = NotCondition(child);
        replacements[condition] = updated;
        return updated;
      }
      return condition;
    }

    return NotificationConditionTreeMoveResult(
      conditions: <NotificationCondition>[
        for (final NotificationCondition condition in roots)
          if (moveNode(condition) case final NotificationCondition moved) moved,
        if (target == null) pasted,
      ],
      replacements: replacements,
      removedContainers: removedContainers,
    );
  }

  List<NotificationCondition> childrenOf(NotificationCondition condition) =>
      switch (condition) {
        AllCondition(:final List<NotificationCondition> conditions) ||
        AnyCondition(
          :final List<NotificationCondition> conditions,
        ) => conditions,
        NotCondition(:final NotificationCondition condition) =>
          <NotificationCondition>[condition],
        _ => const <NotificationCondition>[],
      };

  bool _sameConditions(
    List<NotificationCondition> first,
    List<NotificationCondition> second,
  ) =>
      first.length == second.length &&
      first.indexed.every(
        ((int, NotificationCondition) entry) =>
            identical(entry.$2, second[entry.$1]),
      );
}

class NotificationConditionTreeMoveResult {
  const NotificationConditionTreeMoveResult({
    required this.conditions,
    required this.replacements,
    required this.removedContainers,
  });

  final List<NotificationCondition> conditions;
  final Map<NotificationCondition, NotificationCondition> replacements;
  final Set<NotificationCondition> removedContainers;
}
