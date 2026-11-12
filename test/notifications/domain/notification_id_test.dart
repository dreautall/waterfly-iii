import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/domain/notification_id.dart';

void main() {
  test('generates unique UUIDv4 notification identifiers', () {
    final Set<String> ids = <String>{
      for (int index = 0; index < 100; index += 1) newNotificationId(),
    };

    expect(ids, hasLength(100));
    for (final String id in ids) {
      expect(
        id,
        matches(
          RegExp(
            r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
          ),
        ),
      );
    }
  });
}
