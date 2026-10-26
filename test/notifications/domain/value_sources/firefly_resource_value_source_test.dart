import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/firefly_resource_value_source.dart';

void main() {
  test('persists only the Firefly resource kind and identifier', () {
    const FireflyResourceValueSource source = FireflyResourceValueSource(
      resourceKind: FireflyResourceKind.account,
      resourceId: '42',
    );

    expect(source.toJson(), <String, dynamic>{
      'type': FireflyResourceValueSource.type,
      'resourceKind': 'account',
      'resourceId': '42',
    });
  });

  test('ignores display names from older serialized definitions', () {
    final FireflyResourceValueSource source =
        FireflyResourceValueSource.fromJson(<String, dynamic>{
          'type': FireflyResourceValueSource.type,
          'resourceKind': 'account',
          'resourceId': '42',
          'displayName': 'Old account name',
        });

    expect(source.resourceId, '42');
    expect(source.toJson(), isNot(contains('displayName')));
  });
}
