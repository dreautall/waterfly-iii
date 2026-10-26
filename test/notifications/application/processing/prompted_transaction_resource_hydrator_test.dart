import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/processing/prompted_transaction_resource_hydrator.dart';
import 'package:waterflyiii/notifications/application/resources/firefly_currency_resolver.dart';
import 'package:waterflyiii/notifications/application/resources/firefly_resource_label_resolver.dart';
import 'package:waterflyiii/notifications/domain/transactions/firefly_resource_reference.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_patch.dart';

class _LabelGateway implements FireflyResourceLabelGateway {
  @override
  Future<String> loadLabel(FireflyResourceKind kind, String id) async =>
      '${kind.name} $id';
}

class _CurrencyGateway implements FireflyCurrencyGateway {
  @override
  Future<List<FireflyCurrency>> search(String query) async =>
      const <FireflyCurrency>[
        FireflyCurrency(
          id: '4',
          name: 'Canadian dollar',
          code: 'CAD',
          symbol: r'$',
          decimalPlaces: 2,
        ),
      ];
}

void main() {
  late PromptedTransactionResourceHydrator hydrator;

  setUp(() {
    hydrator = PromptedTransactionResourceHydrator(
      labelResolver: FireflyResourceLabelResolver(_LabelGateway()),
      currencyResolver: FireflyCurrencyResolver(_CurrencyGateway()),
    );
  });

  test(
    'hydrates prompted resource labels while preserving canonical IDs',
    () async {
      final PromptedTransactionResources resources = await hydrator.hydrate(
        const TransactionPatch(
          <TransactionField, String>{
            TransactionField.sourceAccount: '1',
            TransactionField.category: '2',
            TransactionField.subscription: '3',
            TransactionField.currency: '4',
            TransactionField.piggyBank: '5',
          },
          resourceReferences: <TransactionField, FireflyResourceReference>{
            TransactionField.sourceAccount: FireflyResourceReference(
              kind: FireflyResourceKind.account,
              id: '1',
            ),
            TransactionField.category: FireflyResourceReference(
              kind: FireflyResourceKind.category,
              id: '2',
            ),
            TransactionField.subscription: FireflyResourceReference(
              kind: FireflyResourceKind.subscription,
              id: '3',
            ),
            TransactionField.currency: FireflyResourceReference(
              kind: FireflyResourceKind.currency,
              id: '4',
            ),
            TransactionField.piggyBank: FireflyResourceReference(
              kind: FireflyResourceKind.piggyBank,
              id: '5',
            ),
          },
        ),
      );

      expect(resources.patch.values[TransactionField.category], '2');
      expect(resources.patch.displayValues, <TransactionField, String>{
        TransactionField.category: 'category 2',
        TransactionField.subscription: 'subscription 3',
        TransactionField.currency: 'Canadian dollar',
        TransactionField.piggyBank: 'piggyBank 5',
      });
      expect(resources.patch.currencyCodes[TransactionField.currency], 'CAD');
      expect(resources.currency?.id, '4');
      expect(
        resources.patch.displayValues,
        isNot(contains(TransactionField.sourceAccount)),
      );
    },
  );

  test('preserves literal and existing display values', () async {
    final PromptedTransactionResources resources = await hydrator.hydrate(
      const TransactionPatch(
        <TransactionField, String>{
          TransactionField.category: 'Groceries',
          TransactionField.title: 'Card payment',
        },
        displayValues: <TransactionField, String>{
          TransactionField.title: 'Existing title',
        },
      ),
    );

    expect(
      resources.patch.displayValue(TransactionField.category),
      'Groceries',
    );
    expect(
      resources.patch.displayValue(TransactionField.title),
      'Existing title',
    );
    expect(resources.currency, isNull);
  });
}
