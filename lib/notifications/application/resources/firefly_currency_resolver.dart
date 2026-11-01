class FireflyCurrency {
  const FireflyCurrency({
    required this.id,
    required this.name,
    required this.code,
    required this.symbol,
    this.decimalPlaces = 2,
  });

  final String id;
  final String name;
  final String code;
  final String symbol;
  final int decimalPlaces;
}

enum FireflyCurrencyResolutionStatus { resolved, unavailable, ambiguous }

class FireflyCurrencyResolution {
  const FireflyCurrencyResolution._({required this.status, this.currency});

  const FireflyCurrencyResolution.resolved(FireflyCurrency currency)
    : this._(
        status: FireflyCurrencyResolutionStatus.resolved,
        currency: currency,
      );

  const FireflyCurrencyResolution.unavailable()
    : this._(status: FireflyCurrencyResolutionStatus.unavailable);

  const FireflyCurrencyResolution.ambiguous()
    : this._(status: FireflyCurrencyResolutionStatus.ambiguous);

  final FireflyCurrencyResolutionStatus status;
  final FireflyCurrency? currency;
}

class FireflyCurrencyUnavailableException implements Exception {
  const FireflyCurrencyUnavailableException(this.id);

  final String id;

  @override
  String toString() => 'Currency $id is unavailable.';
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
    return (await inspect(token)).currency;
  }

  Future<FireflyCurrencyResolution> inspect(String token) async {
    final List<FireflyCurrency> matches = await _gateway.search(token);
    late final List<FireflyCurrency> candidates;
    if (_isIsoCode(token)) {
      candidates = filterCurrenciesByCode(
        matches.isEmpty ? await _gateway.search('') : matches,
        token,
      ).toList();
    } else {
      candidates = matches;
    }
    return switch (candidates.length) {
      0 => const FireflyCurrencyResolution.unavailable(),
      1 => FireflyCurrencyResolution.resolved(candidates.single),
      _ => const FireflyCurrencyResolution.ambiguous(),
    };
  }

  Future<FireflyCurrency> resolveById(String id) async {
    final List<FireflyCurrency> currencies = await _gateway.search('');
    for (final FireflyCurrency currency in currencies) {
      if (currency.id == id) return currency;
    }
    throw FireflyCurrencyUnavailableException(id);
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
