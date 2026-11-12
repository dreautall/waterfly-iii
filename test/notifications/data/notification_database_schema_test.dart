import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/data/migrations/notification_database_schema.dart';

void main() {
  test('uses the platform SQLCipher memory security default', () {
    expect(NotificationDatabaseSchema.schema.onConfigure, isNull);
  });
}
