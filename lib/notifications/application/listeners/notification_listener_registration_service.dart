typedef NotificationListenerEntryPoint = void Function();

abstract interface class NotificationListenerRegistrationGateway {
  bool get isSupported;

  Future<bool> isAccessGranted();

  Future<void> requestPermissionsIfDenied();

  Future<void> initialize(NotificationListenerEntryPoint callback);
}

class NotificationListenerRegistrationService {
  NotificationListenerRegistrationService({
    required NotificationListenerRegistrationGateway gateway,
    required NotificationListenerEntryPoint callback,
  }) : _gateway = gateway,
       _callback = callback;

  final NotificationListenerRegistrationGateway _gateway;
  final NotificationListenerEntryPoint _callback;

  bool _registered = false;
  Future<bool>? _registrationInProgress;

  Future<bool> ensureRegistered() {
    if (_registered) return Future<bool>.value(true);
    return _registrationInProgress ??= _register();
  }

  Future<bool> _register() async {
    try {
      if (!_gateway.isSupported || !await _gateway.isAccessGranted()) {
        return false;
      }
      await _gateway.requestPermissionsIfDenied();
      await _gateway.initialize(_callback);
      _registered = true;
      return true;
    } finally {
      _registrationInProgress = null;
    }
  }
}
