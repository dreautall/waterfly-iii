import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/resources/firefly_currency_resolver.dart';

class _CurrencyGateway implements FireflyCurrencyGateway {
  _CurrencyGateway(this.responses);

  final Map<String, List<FireflyCurrency>> responses;
  final List<String> queries = <String>[];

  @override
  Future<List<FireflyCurrency>> search(String query) async {
    queries.add(query);
    return responses[query] ?? const <FireflyCurrency>[];
  }
}

void main() {
  const FireflyCurrency usd = FireflyCurrency(
    id: '1',
    name: 'US dollar',
    code: 'USD',
    symbol: r'$',
  );
  const FireflyCurrency cad = FireflyCurrency(
    id: '2',
    name: 'Canadian dollar',
    code: 'CAD',
    symbol: r'$',
  );

  test('preserves editor search and exact-code fallback behavior', () async {
    final _CurrencyGateway gateway = _CurrencyGateway(
      <String, List<FireflyCurrency>>{
        'usd': const <FireflyCurrency>[],
        '': const <FireflyCurrency>[usd, cad],
      },
    );
    final FireflyCurrencyResolver resolver = FireflyCurrencyResolver(gateway);

    expect(await resolver.search('usd'), const <FireflyCurrency>[usd]);
    expect(gateway.queries, <String>['usd', '']);
  });

  test('resolves one exact ISO currency code from broad matches', () async {
    final FireflyCurrencyResolver resolver = FireflyCurrencyResolver(
      _CurrencyGateway(<String, List<FireflyCurrency>>{
        'USD': const <FireflyCurrency>[usd, cad],
      }),
    );

    expect(await resolver.resolveUnique('USD'), same(usd));
  });

  test('does not resolve an ambiguous currency symbol', () async {
    final FireflyCurrencyResolver resolver = FireflyCurrencyResolver(
      _CurrencyGateway(<String, List<FireflyCurrency>>{
        r'$': const <FireflyCurrency>[usd, cad],
      }),
    );

    expect(await resolver.resolveUnique(r'$'), isNull);
  });

  test('does not accept a fuzzy result for an ISO code', () async {
    final FireflyCurrencyResolver resolver = FireflyCurrencyResolver(
      _CurrencyGateway(<String, List<FireflyCurrency>>{
        'USD': const <FireflyCurrency>[cad],
      }),
    );

    expect(await resolver.resolveUnique('USD'), isNull);
  });
}
