import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/listeners/notification_listener_registration_service.dart';

class _RegistrationGateway implements NotificationListenerRegistrationGateway {
  bool supported = true;
  bool accessGranted = true;
  Object? initializationError;
  int accessChecks = 0;
  int permissionRequests = 0;
  int initializations = 0;
  NotificationListenerEntryPoint? callback;

  @override
  bool get isSupported => supported;

  @override
  Future<void> initialize(NotificationListenerEntryPoint callback) async {
    initializations += 1;
    final Object? error = initializationError;
    if (error != null) throw error;
    this.callback = callback;
  }

  @override
  Future<bool> isAccessGranted() async {
    accessChecks += 1;
    return accessGranted;
  }

  @override
  Future<void> requestPermissionsIfDenied() async {
    permissionRequests += 1;
  }
}

void main() {
  test('does nothing on unsupported platforms', () async {
    final _RegistrationGateway gateway = _RegistrationGateway()
      ..supported = false;
    final NotificationListenerRegistrationService service =
        NotificationListenerRegistrationService(
          gateway: gateway,
          callback: () {},
        );

    expect(await service.ensureRegistered(), isFalse);
    expect(gateway.accessChecks, 0);
    expect(gateway.permissionRequests, 0);
    expect(gateway.initializations, 0);
  });

  test('waits for notification access before initializing', () async {
    final _RegistrationGateway gateway = _RegistrationGateway()
      ..accessGranted = false;
    final NotificationListenerRegistrationService service =
        NotificationListenerRegistrationService(
          gateway: gateway,
          callback: () {},
        );

    expect(await service.ensureRegistered(), isFalse);
    expect(gateway.permissionRequests, 0);
    expect(gateway.initializations, 0);

    gateway.accessGranted = true;

    expect(await service.ensureRegistered(), isTrue);
    expect(gateway.permissionRequests, 1);
    expect(gateway.initializations, 1);
  });

  test('registers the callback only once after access is granted', () async {
    final _RegistrationGateway gateway = _RegistrationGateway();
    int callbackInvocations = 0;
    final NotificationListenerRegistrationService service =
        NotificationListenerRegistrationService(
          gateway: gateway,
          callback: () => callbackInvocations += 1,
        );

    expect(await service.ensureRegistered(), isTrue);
    expect(await service.ensureRegistered(), isTrue);
    gateway.callback!();

    expect(gateway.accessChecks, 1);
    expect(gateway.permissionRequests, 1);
    expect(gateway.initializations, 1);
    expect(callbackInvocations, 1);
  });

  test('allows initialization to be retried after a failure', () async {
    final _RegistrationGateway gateway = _RegistrationGateway()
      ..initializationError = StateError('Initialization failed');
    final NotificationListenerRegistrationService service =
        NotificationListenerRegistrationService(
          gateway: gateway,
          callback: () {},
        );

    await expectLater(service.ensureRegistered(), throwsStateError);

    gateway.initializationError = null;

    expect(await service.ensureRegistered(), isTrue);
    expect(gateway.initializations, 2);
  });
}
