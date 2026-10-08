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
      expect(split.date, DateTime(2026, 4, 10, 8, 15, 30));
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
    });

    test('uses the notification date when no date fields are configured', () {
      const TransactionPatch patch = TransactionPatch(
        <TransactionField, String>{},
      );
      final DateTime fallback = DateTime(2026, 5, 6, 7, 8, 9);

      expect(
        NotificationTransactionIntentAdapter.transactionDate(
          patch,
          fallbackDate: fallback,
        ),
        fallback,
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

      expect(store.transactions.single.date, DateTime(2026, 4, 10, 11, 15, 30));
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

      expect(store.transactions.single.date, DateTime(2026, 1, 2, 1, 4, 5));
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
