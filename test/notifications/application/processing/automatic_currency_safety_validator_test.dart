import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/processing/automatic_currency_safety_validator.dart';
import 'package:waterflyiii/notifications/application/resources/firefly_account_currency_gateway.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_intent.dart';
import 'package:waterflyiii/notifications/domain/transactions/firefly_resource_reference.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_patch.dart';

class _AccountCurrencyGateway implements FireflyAccountCurrencyGateway {
  _AccountCurrencyGateway({required this.exchangeRateAvailable});

  final bool exchangeRateAvailable;
  int exchangeRateChecks = 0;
  final List<String> resolvedAccountIds = <String>[];

  @override
  Future<FireflyAccountCurrency> resolveAccountCurrency(
    String accountId,
  ) async {
    resolvedAccountIds.add(accountId);
    return const FireflyAccountCurrency(id: 'account-eur', code: 'EUR');
  }

  @override
  Future<bool> hasExchangeRate({
    required String fromCode,
    required String toCode,
  }) async {
    exchangeRateChecks++;
    return exchangeRateAvailable;
  }
}

void main() {
  TransactionIntent intent({
    required TransactionCreationMode mode,
    String currencyId = 'account-eur',
    String currencyCode = 'EUR',
  }) => TransactionIntent(
    mode: mode,
    patch: TransactionPatch(
      <TransactionField, String>{
        TransactionField.sourceAccount: 'account',
        TransactionField.currency: currencyId,
      },
      currencyCodes: <TransactionField, String>{
        TransactionField.currency: currencyCode,
      },
      resourceReferences: const <TransactionField, FireflyResourceReference>{
        TransactionField.sourceAccount: FireflyResourceReference(
          kind: FireflyResourceKind.account,
          id: 'account',
        ),
      },
    ),
  );

  test('allows automatic creation when account currency matches', () async {
    final _AccountCurrencyGateway gateway = _AccountCurrencyGateway(
      exchangeRateAvailable: false,
    );

    await AutomaticCurrencySafetyValidator(
      gateway,
    ).validate(intent(mode: TransactionCreationMode.automatic));

    expect(gateway.exchangeRateChecks, 0);
  });

  test('does not resolve captured account names as IDs', () async {
    final _AccountCurrencyGateway gateway = _AccountCurrencyGateway(
      exchangeRateAvailable: false,
    );
    final TransactionIntent baseIntent = intent(
      mode: TransactionCreationMode.automatic,
    );
    final TransactionIntent namedDestination = baseIntent.withPatch(
      TransactionPatch(
        <TransactionField, String>{
          ...baseIntent.patch.values,
          TransactionField.destinationAccount: 'Merchant',
        },
        currencyCodes: baseIntent.patch.currencyCodes,
        resourceReferences: baseIntent.patch.resourceReferences,
      ),
    );

    await AutomaticCurrencySafetyValidator(gateway).validate(namedDestination);

    expect(gateway.resolvedAccountIds, <String>['account']);
  });

  test(
    'allows automatic cross-currency creation with an exchange rate',
    () async {
      final _AccountCurrencyGateway gateway = _AccountCurrencyGateway(
        exchangeRateAvailable: true,
      );

      await AutomaticCurrencySafetyValidator(gateway).validate(
        intent(
          mode: TransactionCreationMode.automatic,
          currencyId: 'usd',
          currencyCode: 'USD',
        ),
      );

      expect(gateway.exchangeRateChecks, 1);
    },
  );

  test('rejects automatic cross-currency creation without a rate', () {
    final _AccountCurrencyGateway gateway = _AccountCurrencyGateway(
      exchangeRateAvailable: false,
    );

    expect(
      () => AutomaticCurrencySafetyValidator(gateway).validate(
        intent(
          mode: TransactionCreationMode.automatic,
          currencyId: 'usd',
          currencyCode: 'USD',
        ),
      ),
      throwsA(
        isA<NotificationAutomaticCurrencyException>().having(
          (NotificationAutomaticCurrencyException error) => error.message,
          'message',
          contains('use Prompt for creation'),
        ),
      ),
    );
  });

  test('does not guard prompted transactions', () async {
    final _AccountCurrencyGateway gateway = _AccountCurrencyGateway(
      exchangeRateAvailable: false,
    );

    await AutomaticCurrencySafetyValidator(gateway).validate(
      intent(
        mode: TransactionCreationMode.prompt,
        currencyId: 'usd',
        currencyCode: 'USD',
      ),
    );

    expect(gateway.exchangeRateChecks, 0);
  });
}
