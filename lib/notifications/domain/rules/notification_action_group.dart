import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_sample.dart';

class NotificationActionGroup {
  const NotificationActionGroup({
    required this.id,
    required this.name,
    required this.conditions,
    required this.actions,
    this.sampleOverride,
  });

  final String id;
  final String name;
  final List<NotificationCondition> conditions;
  final List<NotificationAction> actions;
  final NotificationSample? sampleOverride;

  bool get isConfigured => conditions.isNotEmpty && actions.isNotEmpty;

  NotificationActionGroup copyWith({
    String? id,
    String? name,
    List<NotificationCondition>? conditions,
    List<NotificationAction>? actions,
    NotificationSample? sampleOverride,
  }) => NotificationActionGroup(
    id: id ?? this.id,
    name: name ?? this.name,
    conditions: conditions ?? this.conditions,
    actions: actions ?? this.actions,
    sampleOverride: sampleOverride ?? this.sampleOverride,
  );

  NotificationActionGroup withoutSampleOverride() => NotificationActionGroup(
    id: id,
    name: name,
    conditions: conditions,
    actions: actions,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'name': name,
    'conditions': conditions
        .map((NotificationCondition condition) => condition.toJson())
        .toList(),
    'actions': actions
        .map((NotificationAction action) => action.toJson())
        .toList(),
    if (sampleOverride != null) 'sampleOverride': sampleOverride!.toJson(),
  };

  factory NotificationActionGroup.fromJson(
    Map<String, dynamic> json,
  ) => NotificationActionGroup(
    id: json['id'] as String,
    name: json['name'] as String,
    conditions: (json['conditions'] as List<dynamic>)
        .map(
          (dynamic condition) =>
              NotificationCondition.fromJson(condition as Map<String, dynamic>),
        )
        .toList(),
    actions: (json['actions'] as List<dynamic>)
        .map(
          (dynamic action) =>
              NotificationAction.fromJson(action as Map<String, dynamic>),
        )
        .toList(),
    sampleOverride: switch (json['sampleOverride']) {
      final Map<String, dynamic> sample => NotificationSample.fromJson(sample),
      _ => null,
    },
  );
}
