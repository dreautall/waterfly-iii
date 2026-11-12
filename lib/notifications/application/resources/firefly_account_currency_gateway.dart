class FireflyAccountCurrency {
  const FireflyAccountCurrency({required this.id, required this.code});

  final String id;
  final String code;
}

abstract interface class FireflyAccountCurrencyGateway {
  Future<FireflyAccountCurrency> resolveAccountCurrency(String accountId);

  Future<bool> hasExchangeRate({
    required String fromCode,
    required String toCode,
  });
}
