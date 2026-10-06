import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/notifications/application/resources/firefly_currency_resolver.dart';

class ApiFireflyCurrencyGateway implements FireflyCurrencyGateway {
  const ApiFireflyCurrencyGateway(this._firefly);

  final FireflyService _firefly;

  @override
  Future<List<FireflyCurrency>> search(String query) async {
    if (!_firefly.hasApi && !await _firefly.signInFromStorage()) {
      throw StateError('Firefly currency lookup requires authentication.');
    }
    final AutocompleteCurrencyArray currencies =
        (await _firefly.api.v1AutocompleteCurrenciesGet(query: query)).body ??
        const <AutocompleteCurrency>[];
    return currencies
        .map(
          (AutocompleteCurrency currency) => FireflyCurrency(
            id: currency.id,
            name: currency.name,
            code: currency.code,
            symbol: currency.symbol,
            decimalPlaces: currency.decimalPlaces,
          ),
        )
        .toList();
  }
}
