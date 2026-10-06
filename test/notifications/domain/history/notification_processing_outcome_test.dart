import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/domain/history/notification_processing_outcome.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_patch.dart';

void main() {
  test('round-trips a complete recorded processing outcome', () {
    const NotificationProcessingOutcome outcome = NotificationProcessingOutcome(
      status: NotificationProcessingOutcomeStatus.matched,
      definition: NotificationHistoryReference(
        id: 'bank',
        name: 'Example Bank',
      ),
      rule: NotificationHistoryReference(id: 'groceries', name: 'Groceries'),
      conditionalActionGroups: <NotificationHistoryReference>[
        NotificationHistoryReference(
          id: 'large-purchase',
          name: 'Large purchase',
        ),
      ],
      transactionCreationMode: TransactionCreationMode.automatic,
      hasTransactionIntent: true,
      transactionPatch: TransactionPatch(
        <TransactionField, String>{
          TransactionField.amount: '12.50',
          TransactionField.currency: 'CAD',
        },
        tags: <String>['Groceries'],
        displayValues: <TransactionField, String>{
          TransactionField.currency: 'Canadian dollar',
        },
        currencyCodes: <TransactionField, String>{
          TransactionField.currency: 'CAD',
        },
      ),
      transactionId: 'transaction-1',
      transactionCreationOrigin:
          NotificationTransactionCreationOrigin.automatic,
    );

    final NotificationProcessingOutcome restored =
        NotificationProcessingOutcome.fromJson(outcome.toJson());

    expect(restored.status, NotificationProcessingOutcomeStatus.matched);
    expect(restored.definition?.name, 'Example Bank');
    expect(restored.rule?.name, 'Groceries');
    expect(restored.conditionalActionGroups.single.name, 'Large purchase');
    expect(restored.transactionCreationMode, TransactionCreationMode.automatic);
    expect(restored.transactionPatch?.values[TransactionField.amount], '12.50');
    expect(restored.transactionPatch?.tags, <String>['Groceries']);
    expect(
      restored.transactionPatch?.displayValues[TransactionField.currency],
      'Canadian dollar',
    );
    expect(
      restored.transactionPatch?.currencyCodes[TransactionField.currency],
      'CAD',
    );
    expect(restored.transactionId, 'transaction-1');
    expect(
      restored.transactionCreationOrigin,
      NotificationTransactionCreationOrigin.automatic,
    );
    expect(
      restored.effectiveTransactionCreationOrigin,
      NotificationTransactionCreationOrigin.automatic,
    );
  });

  test('infers creation origin for older recorded outcomes', () {
    final NotificationProcessingOutcome automatic =
        NotificationProcessingOutcome.fromJson(<String, dynamic>{
          'status': NotificationProcessingOutcomeStatus.matched.name,
          'transactionCreationMode': TransactionCreationMode.automatic.name,
          'transactionId': 'automatic-transaction',
        });
    final NotificationProcessingOutcome user =
        NotificationProcessingOutcome.fromJson(<String, dynamic>{
          'status': NotificationProcessingOutcomeStatus.matched.name,
          'transactionCreationMode': TransactionCreationMode.prompt.name,
          'transactionId': 'user-transaction',
        });
    final NotificationProcessingOutcome ambiguous =
        NotificationProcessingOutcome.fromJson(<String, dynamic>{
          'status': NotificationProcessingOutcomeStatus.matched.name,
          'transactionId': 'legacy-transaction',
        });

    expect(
      automatic.effectiveTransactionCreationOrigin,
      NotificationTransactionCreationOrigin.automatic,
    );
    expect(
      user.effectiveTransactionCreationOrigin,
      NotificationTransactionCreationOrigin.user,
    );
    expect(ambiguous.effectiveTransactionCreationOrigin, isNull);
  });

  test('removes a transaction link without removing its reusable patch', () {
    const NotificationProcessingOutcome outcome = NotificationProcessingOutcome(
      status: NotificationProcessingOutcomeStatus.matched,
      rule: NotificationHistoryReference(id: 'groceries', name: 'Groceries'),
      transactionCreationMode: TransactionCreationMode.prompt,
      hasTransactionIntent: true,
      transactionPatch: TransactionPatch(<TransactionField, String>{
        TransactionField.amount: '12.50',
      }),
      transactionId: 'transaction-1',
      transactionCreationOrigin: NotificationTransactionCreationOrigin.user,
    );

    final NotificationProcessingOutcome unlinked = outcome
        .withoutTransactionLink();

    expect(unlinked.transactionId, isNull);
    expect(unlinked.transactionCreationOrigin, isNull);
    expect(unlinked.rule, same(outcome.rule));
    expect(unlinked.transactionPatch, same(outcome.transactionPatch));
    expect(unlinked.hasTransactionIntent, isTrue);
  });

  test('metadata-only outcome removes financial values', () {
    const NotificationProcessingOutcome outcome = NotificationProcessingOutcome(
      status: NotificationProcessingOutcomeStatus.matched,
      definition: NotificationHistoryReference(
        id: 'bank',
        name: 'Example Bank',
      ),
      hasTransactionIntent: true,
      transactionPatch: TransactionPatch(<TransactionField, String>{
        TransactionField.amount: '12.50',
        TransactionField.category: 'Groceries',
      }),
    );

    final NotificationProcessingOutcome redacted = outcome
        .withoutSensitiveDetails();

    expect(redacted.definition?.name, 'Example Bank');
    expect(redacted.hasTransactionIntent, isTrue);
    expect(redacted.transactionPatch, isNull);
  });

  test('metadata-only outcome removes detailed failure text', () {
    const NotificationProcessingOutcome outcome = NotificationProcessingOutcome(
      status: NotificationProcessingOutcomeStatus.failed,
      failureMessage: 'Could not parse captured value 12.50.',
    );

    expect(outcome.withoutSensitiveDetails().failureMessage, isNull);
  });
}
