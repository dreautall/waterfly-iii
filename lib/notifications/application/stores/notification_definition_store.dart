import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';

abstract interface class NotificationDefinitionStore {
  Future<List<NotificationDefinition>> load();

  Future<void> save(List<NotificationDefinition> definitions);
}
