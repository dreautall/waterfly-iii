import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/processing/dynamic_currency_patch_resolver.dart';
import 'package:waterflyiii/notifications/application/resources/firefly_currency_resolver.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_patch.dart';

class _CurrencyGateway implements FireflyCurrencyGateway {
  const _CurrencyGateway(this.currencies);

  final List<FireflyCurrency> currencies;

  @override
  Future<List<FireflyCurrency>> search(String query) async => currencies
      .where(
        (FireflyCurrency currency) =>
            query.isEmpty ||
            currency.code.toLowerCase() == query.toLowerCase() ||
            currency.symbol == query,
      )
      .toList();
}

void main() {
  const List<FireflyCurrency> currencies = <FireflyCurrency>[
    FireflyCurrency(id: '1', name: 'Euro', code: 'EUR', symbol: '€'),
    FireflyCurrency(id: '2', name: 'US dollar', code: 'USD', symbol: r'$'),
    FireflyCurrency(
      id: '3',
      name: 'Canadian dollar',
      code: 'CAD',
      symbol: r'$',
    ),
  ];
  const DynamicCurrencyPatchResolver resolver = DynamicCurrencyPatchResolver(
    FireflyCurrencyResolver(_CurrencyGateway(currencies)),
  );

  test('resolves a dynamic ISO code to canonical currency metadata', () async {
    final TransactionPatch resolved = await resolver.resolve(
      const TransactionPatch(
        <TransactionField, String>{TransactionField.currency: 'eur'},
        dynamicCurrencyValues: <TransactionField, String>{
          TransactionField.currency: 'eur',
        },
      ),
    );

    expect(resolved.values[TransactionField.currency], '1');
    expect(resolved.displayValues[TransactionField.currency], 'Euro');
    expect(resolved.currencyCodes[TransactionField.currency], 'EUR');
    expect(resolved.dynamicCurrencyValues, isEmpty);
    expect(resolved.resourceReferences[TransactionField.currency]?.id, '1');
  });

  test('rejects an ambiguous dynamic symbol', () {
    expect(
      () => resolver.resolve(
        const TransactionPatch(
          <TransactionField, String>{TransactionField.currency: r'$'},
          dynamicCurrencyValues: <TransactionField, String>{
            TransactionField.currency: r'$',
          },
        ),
      ),
      throwsA(
        isA<NotificationCurrencyResolutionException>().having(
          (NotificationCurrencyResolutionException error) => error.message,
          'message',
          contains('Could not uniquely match'),
        ),
      ),
    );
  });

  test('hydrates fixed currency IDs for automatic safety checks', () async {
    final TransactionPatch resolved = await resolver.resolve(
      const TransactionPatch(<TransactionField, String>{
        TransactionField.currency: '3',
      }),
    );

    expect(resolved.values[TransactionField.currency], '3');
    expect(resolved.currencyCodes[TransactionField.currency], 'CAD');
  });
}
