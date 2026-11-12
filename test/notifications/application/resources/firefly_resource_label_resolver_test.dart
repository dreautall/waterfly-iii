import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/resources/firefly_resource_label_resolver.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';

class _Gateway implements FireflyResourceLabelGateway {
  int calls = 0;
  Object? error;

  @override
  Future<String> loadLabel(FireflyResourceKind kind, String id) async {
    calls += 1;
    final Object? failure = error;
    if (failure != null) throw failure;
    return '${kind.name} $id';
  }
}

void main() {
  test(
    'deduplicates labels until the foreground cache is invalidated',
    () async {
      final _Gateway gateway = _Gateway();
      final FireflyResourceLabelResolver resolver =
          FireflyResourceLabelResolver(gateway);

      expect(
        await Future.wait(<Future<String>>[
          resolver.resolve(FireflyResourceKind.account, '42'),
          resolver.resolve(FireflyResourceKind.account, '42'),
        ]),
        <String>['account 42', 'account 42'],
      );
      expect(gateway.calls, 1);

      resolver.invalidate();

      expect(
        await resolver.resolve(FireflyResourceKind.account, '42'),
        'account 42',
      );
      expect(gateway.calls, 2);
    },
  );

  test('does not cache failed lookups', () async {
    final _Gateway gateway = _Gateway()..error = StateError('Unavailable');
    final FireflyResourceLabelResolver resolver = FireflyResourceLabelResolver(
      gateway,
    );

    await expectLater(
      resolver.resolve(FireflyResourceKind.account, '42'),
      throwsStateError,
    );
    gateway.error = null;

    expect(
      await resolver.resolve(FireflyResourceKind.account, '42'),
      'account 42',
    );
    expect(gateway.calls, 2);
  });
}
