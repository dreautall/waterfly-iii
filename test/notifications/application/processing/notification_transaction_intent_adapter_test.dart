import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/notifications/application/processing/notification_transaction_intent_adapter.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_intent.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/transactions/firefly_resource_reference.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_patch.dart';

void main() {
  group('NotificationTransactionIntentAdapter', () {
    test('maps a complete automatic withdrawal to a Firefly store', () {
      const TransactionIntent intent = TransactionIntent(
        mode: TransactionCreationMode.automatic,
        patch: TransactionPatch(
          <TransactionField, String>{
            TransactionField.title: 'Coffee',
            TransactionField.amount: '4,50',
            TransactionField.date: '2026-04-10',
            TransactionField.time: '08:15:30',
            TransactionField.sourceAccount: 'account-1',
            TransactionField.category: 'category-2',
            TransactionField.currency: 'currency-3',
            TransactionField.subscription: 'bill-4',
            TransactionField.piggyBank: '5',
            TransactionField.notes: 'Morning coffee',
            TransactionField.tag: 'tag-6',
          },
          tags: <String>['Breakfast'],
          displayValues: <TransactionField, String>{
            TransactionField.tag: 'Coffee shop',
          },
          resourceReferences: <TransactionField, FireflyResourceReference>{
            TransactionField.sourceAccount: FireflyResourceReference(
              kind: FireflyResourceKind.account,
              id: 'account-1',
            ),
            TransactionField.category: FireflyResourceReference(
              kind: FireflyResourceKind.category,
              id: 'category-2',
            ),
            TransactionField.currency: FireflyResourceReference(
              kind: FireflyResourceKind.currency,
              id: 'currency-3',
            ),
            TransactionField.subscription: FireflyResourceReference(
              kind: FireflyResourceKind.subscription,
              id: 'bill-4',
            ),
            TransactionField.piggyBank: FireflyResourceReference(
              kind: FireflyResourceKind.piggyBank,
              id: '5',
            ),
          },
        ),
      );

      final TransactionStore store =
          NotificationTransactionIntentAdapter.toStore(
            intent,
            fallbackDate: DateTime(2026, 1, 2, 3, 4, 5),
          );
      final TransactionSplitStore split = store.transactions.single;

      expect(split.type, TransactionTypeProperty.withdrawal);
      expect(split.description, 'Coffee');
      expect(split.amount, '4.5');
      expect(split.date, DateTime(2026, 4, 10, 8, 15));
      expect(split.sourceId, 'account-1');
      expect(split.categoryId, 'category-2');
      expect(split.currencyId, 'currency-3');
      expect(split.billId, 'bill-4');
      expect(split.piggyBankId, 5);
      expect(split.notes, 'Morning coffee');
      expect(split.tags, <String>['Breakfast', 'Coffee shop']);
    });

    test('infers deposit and transfer from configured accounts', () {
      expect(
        NotificationTransactionIntentAdapter.transactionTypeFor(
          sourceId: null,
          destinationId: 'destination',
        ),
        TransactionTypeProperty.deposit,
      );
      expect(
        NotificationTransactionIntentAdapter.transactionTypeFor(
          sourceId: 'source',
          destinationId: 'destination',
        ),
        TransactionTypeProperty.transfer,
      );
      expect(
        NotificationTransactionIntentAdapter.transactionTypeFor(
          sourceId: 'source',
          destinationId: null,
          destinationName: 'Merchant',
          destinationIsDynamic: true,
        ),
        TransactionTypeProperty.withdrawal,
      );
      expect(
        NotificationTransactionIntentAdapter.transactionTypeFor(
          sourceId: null,
          sourceName: 'Checking',
          destinationId: null,
          destinationName: 'Merchant',
          destinationIsDynamic: true,
        ),
        TransactionTypeProperty.withdrawal,
      );
    });

    test('maps named accounts separately from fixed account IDs', () {
      const TransactionIntent intent = TransactionIntent(
        mode: TransactionCreationMode.automatic,
        patch: TransactionPatch(
          <TransactionField, String>{
            TransactionField.title: 'Coffee',
            TransactionField.amount: '4.50',
            TransactionField.sourceAccount: 'account-1',
            TransactionField.destinationAccount: 'Coffee Shop',
          },
          resourceReferences: <TransactionField, FireflyResourceReference>{
            TransactionField.sourceAccount: FireflyResourceReference(
              kind: FireflyResourceKind.account,
              id: 'account-1',
            ),
          },
          dynamicAccountValues: <TransactionField, String>{
            TransactionField.destinationAccount: 'Coffee Shop',
          },
        ),
      );

      final TransactionStore store =
          NotificationTransactionIntentAdapter.toStore(
            intent,
            fallbackDate: DateTime(2026, 1, 2),
          );
      final TransactionSplitStore split = store.transactions.single;

      expect(split.type, TransactionTypeProperty.withdrawal);
      expect(split.sourceId, 'account-1');
      expect(split.sourceName, isNull);
      expect(split.destinationId, isNull);
      expect(split.destinationName, 'Coffee Shop');
    });

    test('maps a captured source account as a name', () {
      const TransactionIntent intent = TransactionIntent(
        mode: TransactionCreationMode.automatic,
        patch: TransactionPatch(
          <TransactionField, String>{
            TransactionField.title: 'Salary',
            TransactionField.amount: '1000.00',
            TransactionField.sourceAccount: 'Employer',
            TransactionField.destinationAccount: 'account-2',
          },
          resourceReferences: <TransactionField, FireflyResourceReference>{
            TransactionField.destinationAccount: FireflyResourceReference(
              kind: FireflyResourceKind.account,
              id: 'account-2',
            ),
          },
          dynamicAccountValues: <TransactionField, String>{
            TransactionField.sourceAccount: 'Employer',
          },
        ),
      );

      final TransactionSplitStore split =
          NotificationTransactionIntentAdapter.toStore(
            intent,
            fallbackDate: DateTime(2026, 1, 2),
          ).transactions.single;

      expect(split.type, TransactionTypeProperty.deposit);
      expect(split.sourceId, isNull);
      expect(split.sourceName, 'Employer');
      expect(split.destinationId, 'account-2');
      expect(split.destinationName, isNull);
    });

    test('normalizes a grouped amount from a persisted patch', () {
      const TransactionIntent intent = TransactionIntent(
        mode: TransactionCreationMode.automatic,
        patch: TransactionPatch(<TransactionField, String>{
          TransactionField.title: 'Rent',
          TransactionField.amount: '1.000,00',
          TransactionField.sourceAccount: 'account-1',
        }),
      );

      final TransactionStore store =
          NotificationTransactionIntentAdapter.toStore(
            intent,
            fallbackDate: DateTime(2026, 1, 2),
          );

      expect(store.transactions.single.amount, '1000.0');
    });

    test('uses the notification date at minute precision by default', () {
      const TransactionPatch patch = TransactionPatch(
        <TransactionField, String>{},
      );
      final DateTime fallback = DateTime(2026, 5, 6, 7, 8, 9);

      expect(
        NotificationTransactionIntentAdapter.transactionDate(
          patch,
          fallbackDate: fallback,
        ),
        DateTime(2026, 5, 6, 7, 8),
      );
    });

    test('transforms an explicitly configured transaction date', () {
      const TransactionIntent intent = TransactionIntent(
        mode: TransactionCreationMode.automatic,
        patch: TransactionPatch(<TransactionField, String>{
          TransactionField.title: 'Coffee',
          TransactionField.amount: '4.50',
          TransactionField.date: '2026-04-10',
          TransactionField.time: '08:15:30',
          TransactionField.sourceAccount: 'account-1',
        }),
      );

      final TransactionStore store =
          NotificationTransactionIntentAdapter.toStore(
            intent,
            fallbackDate: DateTime(2026, 1, 2, 3, 4, 5),
            transformDate: (DateTime date) =>
                date.add(const Duration(hours: 3)),
          );

      expect(store.transactions.single.date, DateTime(2026, 4, 10, 11, 15));
    });

    test('transforms the notification fallback date', () {
      const TransactionIntent intent = TransactionIntent(
        mode: TransactionCreationMode.automatic,
        patch: TransactionPatch(<TransactionField, String>{
          TransactionField.title: 'Coffee',
          TransactionField.amount: '4.50',
          TransactionField.sourceAccount: 'account-1',
        }),
      );

      final TransactionStore store =
          NotificationTransactionIntentAdapter.toStore(
            intent,
            fallbackDate: DateTime(2026, 1, 2, 3, 4, 5),
            transformDate: (DateTime date) =>
                date.subtract(const Duration(hours: 2)),
          );

      expect(store.transactions.single.date, DateTime(2026, 1, 2, 1, 4));
    });

    test('rejects missing automatic fields', () {
      const TransactionIntent intent = TransactionIntent(
        mode: TransactionCreationMode.automatic,
        patch: TransactionPatch(<TransactionField, String>{
          TransactionField.amount: '12.00',
        }),
      );

      expect(
        () => NotificationTransactionIntentAdapter.toStore(
          intent,
          fallbackDate: DateTime(2026),
        ),
        throwsFormatException,
      );
    });
  });

  test('transaction intent JSON retains resource reference metadata', () {
    const TransactionIntent intent = TransactionIntent(
      mode: TransactionCreationMode.prompt,
      patch: TransactionPatch(
        <TransactionField, String>{
          TransactionField.sourceAccount: 'account-1',
          TransactionField.currency: 'currency-2',
        },
        resourceReferences: <TransactionField, FireflyResourceReference>{
          TransactionField.sourceAccount: FireflyResourceReference(
            kind: FireflyResourceKind.account,
            id: 'account-1',
          ),
          TransactionField.currency: FireflyResourceReference(
            kind: FireflyResourceKind.currency,
            id: 'currency-2',
          ),
        },
        currencyCodes: <TransactionField, String>{
          TransactionField.currency: 'EUR',
        },
        dynamicAccountValues: <TransactionField, String>{
          TransactionField.destinationAccount: 'Market',
        },
      ),
    );

    final TransactionIntent restored = TransactionIntent.fromJson(
      intent.toJson(),
    );

    expect(restored.mode, TransactionCreationMode.prompt);
    expect(restored.patch.values[TransactionField.sourceAccount], 'account-1');
    expect(
      restored.patch.resourceReferences[TransactionField.sourceAccount]?.id,
      'account-1',
    );
    expect(restored.patch.currencyCodes[TransactionField.currency], 'EUR');
    expect(
      restored.patch.dynamicAccountValues[TransactionField.destinationAccount],
      'Market',
    );
  });

  test('later patch values replace matching display metadata', () {
    final TransactionPatch merged = TransactionPatch.merge(
      const <TransactionPatch>[
        TransactionPatch(
          <TransactionField, String>{TransactionField.category: '1'},
          displayValues: <TransactionField, String>{
            TransactionField.category: 'Groceries',
          },
        ),
        TransactionPatch(<TransactionField, String>{
          TransactionField.category: 'Replacement',
        }),
      ],
    );

    expect(merged.values[TransactionField.category], 'Replacement');
    expect(merged.displayValue(TransactionField.category), 'Replacement');
    expect(merged.displayValues, isNot(contains(TransactionField.category)));
  });
}
