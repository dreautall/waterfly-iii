import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/processing/local_notification_id_generator.dart';

void main() {
  test(
    'allocates distinct ids for notifications created in the same instant',
    () {
      final LocalNotificationIdGenerator generator =
          LocalNotificationIdGenerator(currentMilliseconds: () => 42);

      expect(
        <int>[generator.next(), generator.next(), generator.next()],
        <int>[1000042, 1000043, 1000044],
      );
    },
  );

  test('keeps generated ids in the positive dynamic notification range', () {
    final LocalNotificationIdGenerator generator = LocalNotificationIdGenerator(
      currentMilliseconds: () => LocalNotificationIdGenerator.maximumId,
    );

    final List<int> ids = <int>[
      generator.next(),
      generator.next(),
      generator.next(),
    ];

    expect(
      ids,
      everyElement(
        inInclusiveRange(
          LocalNotificationIdGenerator.minimumId,
          LocalNotificationIdGenerator.maximumId,
        ),
      ),
    );
    expect(ids.toSet(), hasLength(ids.length));
  });

  test('wraps to the beginning of the dynamic range', () {
    final LocalNotificationIdGenerator generator = LocalNotificationIdGenerator(
      currentMilliseconds: () =>
          LocalNotificationIdGenerator.maximumId -
          LocalNotificationIdGenerator.minimumId,
    );

    expect(generator.next(), LocalNotificationIdGenerator.maximumId);
    expect(generator.next(), LocalNotificationIdGenerator.minimumId);
  });
}
