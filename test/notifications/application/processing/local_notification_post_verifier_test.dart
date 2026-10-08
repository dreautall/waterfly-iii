import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/processing/local_notification_post_verifier.dart';

void main() {
  test('returns when the posted notification becomes active', () async {
    int checks = 0;
    bool posted = false;
    final List<Duration> delays = <Duration>[];
    final LocalNotificationPostVerifier verifier =
        LocalNotificationPostVerifier(
          loadActiveNotificationIds: () async {
            checks += 1;
            return checks < 2 ? const <int>[] : const <int>[42];
          },
          delay: (Duration duration) async => delays.add(duration),
        );

    await verifier.postAndVerify(
      id: 42,
      description: 'Test notification',
      post: () async => posted = true,
    );

    expect(posted, isTrue);
    expect(checks, 2);
    expect(delays, const <Duration>[Duration(milliseconds: 50)]);
  });

  test('fails when Android never reports the notification active', () async {
    int checks = 0;
    final LocalNotificationPostVerifier verifier =
        LocalNotificationPostVerifier(
          loadActiveNotificationIds: () async {
            checks += 1;
            return const <int>[];
          },
          delay: (Duration duration) async {},
        );

    await expectLater(
      verifier.postAndVerify(
        id: 42,
        description: 'Manual transaction prompt',
        post: () async {},
      ),
      throwsA(
        isA<StateError>().having(
          (StateError error) => error.message,
          'message',
          contains('did not become active in Android'),
        ),
      ),
    );
    expect(checks, 3);
  });

  test('surfaces posting failures without checking active notifications', () {
    int checks = 0;
    final LocalNotificationPostVerifier verifier =
        LocalNotificationPostVerifier(
          loadActiveNotificationIds: () async {
            checks += 1;
            return const <int>[];
          },
        );

    expect(
      verifier.postAndVerify(
        id: 42,
        description: 'Test notification',
        post: () => Future<void>.error(StateError('post failed')),
      ),
      throwsA(isA<StateError>()),
    );
    expect(checks, 0);
  });
}
