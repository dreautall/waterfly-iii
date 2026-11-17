import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';

abstract interface class NotificationDefinitionStore {
  Future<List<NotificationDefinition>> load();

  Future<void> save(List<NotificationDefinition> definitions);
}

class NotificationDefinitionMutation<T> {
  const NotificationDefinitionMutation.changed(this.value) : changed = true;

  const NotificationDefinitionMutation.unchanged(this.value) : changed = false;

  final T value;
  final bool changed;
}

abstract interface class AtomicNotificationDefinitionStore
    implements NotificationDefinitionStore {
  Future<T> mutate<T>(
    NotificationDefinitionMutation<T> Function(
      List<NotificationDefinition> definitions,
    )
    mutation,
  );
}

Future<T> mutateNotificationDefinitions<T>(
  NotificationDefinitionStore store,
  NotificationDefinitionMutation<T> Function(
    List<NotificationDefinition> definitions,
  )
  mutation,
) async {
  if (store is AtomicNotificationDefinitionStore) {
    return store.mutate(mutation);
  }
  final List<NotificationDefinition> definitions =
      List<NotificationDefinition>.of(await store.load());
  final NotificationDefinitionMutation<T> result = mutation(definitions);
  if (result.changed) await store.save(definitions);
  return result.value;
}
