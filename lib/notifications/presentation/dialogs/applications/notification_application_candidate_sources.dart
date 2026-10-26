import 'package:flutter/services.dart';
import 'package:waterflyiii/notifications/application/definitions/notification_application_candidates.dart';
import 'package:waterflyiii/notifications/application/stores/notification_history_store.dart';
import 'package:waterflyiii/notifications/domain/history/notification_history_entry.dart';

class MethodChannelNotificationManifestPackageSource
    implements NotificationManifestPackageSource {
  const MethodChannelNotificationManifestPackageSource({
    MethodChannel channel = const MethodChannel(
      'waterflyiii/notification_apps',
    ),
  }) : _channel = channel;

  final MethodChannel _channel;

  @override
  Future<Iterable<String>> loadPackageIds() async =>
      await _channel.invokeListMethod<String>('manifestQueryPackages') ??
      const <String>[];
}

class NotificationHistoryStorePackageSource
    implements NotificationHistoryPackageSource {
  const NotificationHistoryStorePackageSource(this._historyStore);

  final NotificationHistoryStore _historyStore;

  @override
  Future<Iterable<String>> loadPackageIds() async =>
      (await _historyStore.load()).map(
        (NotificationHistoryEntry notification) => notification.applicationId,
      );
}

class EmptyNotificationHistoryPackageSource
    implements NotificationHistoryPackageSource {
  const EmptyNotificationHistoryPackageSource();

  @override
  Future<Iterable<String>> loadPackageIds() async => const <String>[];
}
