import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/planning/automatic_transaction_readiness.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/literal_value_source.dart';

void main() {
  final NotificationContext notification = NotificationContext(
    title: 'Card payment',
    body: 'Paid 12.50',
    receivedAt: DateTime(2026, 9, 29),
  );

  test('requires title, positive amount, and either account', () {
    final AutomaticTransactionReadiness readiness =
        AutomaticTransactionReadiness.evaluate(
          sharedActions: const <NotificationAction>[],
          extractors: const <RegExpDefinition>[],
          notificationContext: notification,
        );

    expect(readiness.missingRequirements, <AutomaticTransactionRequirement>{
      AutomaticTransactionRequirement.title,
      AutomaticTransactionRequirement.positiveAmount,
      AutomaticTransactionRequirement.account,
    });
  });

  test('accepts a complete shared automatic path', () {
    final AutomaticTransactionReadiness readiness =
        AutomaticTransactionReadiness.evaluate(
          sharedActions: const <NotificationAction>[
            SetTransactionFieldAction(
              target: TransactionField.title,
              valueSource: LiteralValueSource('Card payment'),
            ),
            SetTransactionFieldAction(
              target: TransactionField.amount,
              valueSource: LiteralValueSource('12.50'),
            ),
            SetTransactionFieldAction(
              target: TransactionField.destinationAccount,
              valueSource: LiteralValueSource('Income'),
            ),
          ],
          extractors: const <RegExpDefinition>[],
          notificationContext: notification,
        );

    expect(readiness.isReady, isTrue);
  });

  test('rejects zero and negative amounts', () {
    for (final String amount in <String>['0', '-1']) {
      final AutomaticTransactionReadiness readiness =
          AutomaticTransactionReadiness.evaluate(
            sharedActions: <NotificationAction>[
              const SetTransactionFieldAction(
                target: TransactionField.title,
                valueSource: LiteralValueSource('Card payment'),
              ),
              SetTransactionFieldAction(
                target: TransactionField.amount,
                valueSource: LiteralValueSource(amount),
              ),
              const SetTransactionFieldAction(
                target: TransactionField.sourceAccount,
                valueSource: LiteralValueSource('Checking'),
              ),
            ],
            extractors: const <RegExpDefinition>[],
            notificationContext: notification,
          );

      expect(
        readiness.missingRequirements,
        contains(AutomaticTransactionRequirement.positiveAmount),
      );
    }
  });

  test('conditional actions do not satisfy automatic readiness', () {
    final RegExpDefinition extractor =
        RegExpDefinition.createCustomRegExpDefinition('Body', r'.+');
    final NotificationDefinition definition = NotificationDefinition(
      id: 'definition',
      applicationId: 'com.example.bank',
      name: 'Example Bank',
      sampleTitle: notification.title,
      sampleBody: notification.body,
      createdAt: notification.receivedAt,
      extractorMode: NotificationExtractorMode.advanced,
      transactionCreationMode: TransactionCreationMode.automatic,
      extractors: <RegExpDefinition>[extractor],
      sharedActions: const <NotificationAction>[
        SetTransactionFieldAction(
          target: TransactionField.title,
          valueSource: LiteralValueSource('Card payment'),
        ),
        SetTransactionFieldAction(
          target: TransactionField.amount,
          valueSource: LiteralValueSource('12.50'),
        ),
      ],
      rules: const <NotificationRule>[
        NotificationRule(
          id: 'conditional-account',
          name: 'Conditional account',
          conditions: <NotificationCondition>[],
          actions: <NotificationAction>[
            SetTransactionFieldAction(
              target: TransactionField.sourceAccount,
              valueSource: LiteralValueSource('Checking'),
            ),
          ],
        ),
      ],
    );

    expect(
      definition.automaticTransactionReadiness.missingRequirements,
      <AutomaticTransactionRequirement>{
        AutomaticTransactionRequirement.account,
      },
    );
    expect(definition.status, NotificationDefinitionStatus.needsReview);
  });
}
