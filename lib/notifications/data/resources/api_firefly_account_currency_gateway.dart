import 'package:chopper/chopper.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/notifications/application/resources/firefly_account_currency_gateway.dart';

class ApiFireflyAccountCurrencyGateway
    implements FireflyAccountCurrencyGateway {
  const ApiFireflyAccountCurrencyGateway(this._firefly);

  final FireflyService _firefly;

  @override
  Future<FireflyAccountCurrency> resolveAccountCurrency(
    String accountId,
  ) async {
    await _ensureAuthenticated();
    final Response<AccountSingle> response = await _firefly.api.v1AccountsIdGet(
      id: accountId,
    );
    apiThrowErrorIfEmpty(response, null);
    final AccountProperties account = response.body!.data.attributes;
    final String? id = account.currencyId;
    final String? code = account.currencyCode;
    if (id == null || code == null) {
      throw StateError('Account $accountId has no available currency.');
    }
    return FireflyAccountCurrency(id: id, code: code);
  }

  @override
  Future<bool> hasExchangeRate({
    required String fromCode,
    required String toCode,
  }) async {
    await _ensureAuthenticated();
    final Response<CurrencyExchangeRateArray> direct = await _firefly.api
        .v1ExchangeRatesFromToGet(from: fromCode, to: toCode, limit: 1);
    apiThrowErrorIfEmpty(direct, null);
    if (direct.body!.data.isNotEmpty) return true;

    final Response<CurrencyExchangeRateArray> reverse = await _firefly.api
        .v1ExchangeRatesFromToGet(from: toCode, to: fromCode, limit: 1);
    apiThrowErrorIfEmpty(reverse, null);
    return reverse.body!.data.isNotEmpty;
  }

  Future<void> _ensureAuthenticated() async {
    if (!_firefly.hasApi && !await _firefly.signInFromStorage()) {
      throw StateError('Firefly currency lookup requires authentication.');
    }
  }
}
