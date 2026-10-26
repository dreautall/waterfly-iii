import 'package:flutter/foundation.dart';
import 'package:waterflyiii/notifications/application/listeners/notification_listener_health_service.dart';
import 'package:waterflyiii/notifications/application/stores/notification_listener_health_store.dart';
import 'package:waterflyiii/notifications/domain/listeners/notification_listener_health_issue.dart';

class NotificationListenerHealthViewModel extends ChangeNotifier {
  NotificationListenerHealthViewModel({
    required NotificationListenerHealthStore store,
    required NotificationListenerHealthService service,
  }) : _store = store,
       _service = service;

  final NotificationListenerHealthStore _store;
  final NotificationListenerHealthService _service;

  NotificationListenerHealthIssue? issue;
  Object? error;
  bool isLoading = false;
  bool isBusy = false;

  Future<void> load() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      issue = await _store.load();
    } catch (loadError) {
      error = loadError;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> retry() => _run(() async {
    issue = await _service.retry(DateTime.now());
  });

  Future<bool> acknowledge() => _run(() async {
    await _service.acknowledge();
    issue = null;
  });

  Future<bool> _run(Future<void> Function() operation) async {
    isBusy = true;
    notifyListeners();
    try {
      await operation();
      error = null;
      return true;
    } catch (operationError) {
      error = operationError;
      return false;
    } finally {
      isBusy = false;
      notifyListeners();
    }
  }
}
