typedef ActiveNotificationIdsLoader = Future<Iterable<int>> Function();
typedef NotificationPostOperation = Future<void> Function();
typedef VerificationDelay = Future<void> Function(Duration duration);

class LocalNotificationPostVerifier {
  LocalNotificationPostVerifier({
    required ActiveNotificationIdsLoader loadActiveNotificationIds,
    VerificationDelay delay = Future<void>.delayed,
    List<Duration> verificationDelays = const <Duration>[
      Duration.zero,
      Duration(milliseconds: 50),
      Duration(milliseconds: 150),
    ],
  }) : _loadActiveNotificationIds = loadActiveNotificationIds,
       _delay = delay,
       _verificationDelays = verificationDelays;

  final ActiveNotificationIdsLoader _loadActiveNotificationIds;
  final VerificationDelay _delay;
  final List<Duration> _verificationDelays;

  Future<void> postAndVerify({
    required int id,
    required String description,
    required NotificationPostOperation post,
  }) async {
    await post();
    for (final Duration delay in _verificationDelays) {
      if (delay > Duration.zero) await _delay(delay);
      final Iterable<int> activeIds = await _loadActiveNotificationIds();
      if (activeIds.contains(id)) return;
    }
    throw StateError(
      '$description was accepted by the notification plugin but did not '
      'become active in Android.',
    );
  }
}
