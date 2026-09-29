class FireflyCurrency {
  const FireflyCurrency({
    required this.id,
    required this.name,
    required this.code,
    required this.symbol,
  });

  final String id;
  final String name;
  final String code;
  final String symbol;
}

abstract interface class FireflyCurrencyGateway {
  Future<List<FireflyCurrency>> search(String query);
}

class FireflyCurrencyResolver {
  const FireflyCurrencyResolver(this._gateway);

  final FireflyCurrencyGateway _gateway;

  Future<List<FireflyCurrency>> search(String query) async {
    final List<FireflyCurrency> matches = await _gateway.search(query);
    if (matches.isNotEmpty || !_isIsoCode(query)) return matches;
    return filterCurrenciesByCode(await _gateway.search(''), query).toList();
  }

  Future<FireflyCurrency?> resolveUnique(String token) async {
    final List<FireflyCurrency> matches = await _gateway.search(token);
    if (_isIsoCode(token)) {
      final List<FireflyCurrency> exactMatches = filterCurrenciesByCode(
        matches.isEmpty ? await _gateway.search('') : matches,
        token,
      ).toList();
      if (exactMatches.length == 1) return exactMatches.single;
      return null;
    }
    return matches.length == 1 ? matches.single : null;
  }

  static bool _isIsoCode(String value) =>
      RegExp(r'^[A-Za-z]{3}$').hasMatch(value);
}

Iterable<FireflyCurrency> filterCurrenciesByCode(
  Iterable<FireflyCurrency> currencies,
  String code,
) {
  final String normalizedCode = code.toUpperCase();
  return currencies.where(
    (FireflyCurrency currency) => currency.code.toUpperCase() == normalizedCode,
  );
}
