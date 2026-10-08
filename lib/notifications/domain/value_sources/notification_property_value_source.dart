import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';
import 'package:waterflyiii/notifications/domain/value_sources/value_source.dart';

enum NotificationProperty { title, body }

class NotificationPropertyValueSource implements ValueSource {
  const NotificationPropertyValueSource(this.property);

  static const String type = 'notificationProperty';

  final NotificationProperty property;

  @override
  String resolve(EvaluationContext context) {
    switch (property) {
      case NotificationProperty.title:
        return context.notification.title;
      case NotificationProperty.body:
        return context.notification.body;
    }
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'type': type,
    'property': property.name,
  };

  factory NotificationPropertyValueSource.fromJson(Map<String, dynamic> json) {
    return NotificationPropertyValueSource(
      NotificationProperty.values.byName(json['property'] as String),
    );
  }
}
