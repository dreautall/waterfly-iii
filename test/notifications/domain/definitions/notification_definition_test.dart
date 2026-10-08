import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/value_exists_condition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_definition_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_action_group.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/literal_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';

void main() {
  test('unconfigured conditional actions require review, not setup', () {
    const NotificationRule rule = NotificationRule(
      id: 'rule',
      name: 'Deposits',
      conditions: <NotificationCondition>[],
      actions: <NotificationAction>[],
      conditionalActionGroups: <NotificationActionGroup>[
        NotificationActionGroup(
          id: 'optional',
          name: 'Optional details',
          conditions: <NotificationCondition>[],
          actions: <NotificationAction>[],
        ),
      ],
    );
    final NotificationDefinition definition = NotificationDefinition(
      id: 'definition',
      applicationId: 'com.example.bank',
      name: 'Bank',
      sampleTitle: 'Payment',
      sampleBody: 'Paid 12 CAD',
      extractors: <RegExpDefinition>[
        RegExpDefinition.createCustomRegExpDefinition('Amount', r'\d+'),
      ],
      rules: const <NotificationRule>[rule],
      extractorMode: NotificationExtractorMode.advanced,
    );

    expect(rule.hasUnconfiguredConditionalActions, isTrue);
    expect(definition.status, NotificationDefinitionStatus.needsReview);
    final NotificationRule configuredRule = rule.copyWith(
      conditionalActionGroups: const <NotificationActionGroup>[
        NotificationActionGroup(
          id: 'optional',
          name: 'Optional details',
          conditions: <NotificationCondition>[
            ValueExistsCondition(LiteralValueSource('deposit')),
          ],
          actions: <NotificationAction>[
            SetTransactionFieldAction(
              target: TransactionField.title,
              valueSource: LiteralValueSource('Deposit'),
            ),
          ],
        ),
      ],
    );
    expect(configuredRule.hasUnconfiguredConditionalActions, isFalse);
    expect(
      definition.copyWith(rules: <NotificationRule>[configuredRule]).status,
      NotificationDefinitionStatus.ready,
    );
    expect(
      definition.copyWith(sampleBody: '').status,
      NotificationDefinitionStatus.needsSetup,
    );
    expect(
      definition
          .copyWith(
            rules: <NotificationRule>[
              rule.copyWith(
                actions: <NotificationAction>[
                  SetTransactionFieldAction(
                    target: TransactionField.currency,
                    valueSource: RegExpCaptureValueSource(
                      extractorId: definition.extractors.single.id,
                      captureName: 'amount',
                    ),
                  ),
                ],
              ),
            ],
          )
          .status,
      NotificationDefinitionStatus.needsSetup,
    );
  });

  test('copies all definition settings while replacing selected fields', () {
    final RegExpDefinition extractor =
        RegExpDefinition.createPredefinedRegExpDefinition(
          PredefinedRegExpDefinition.amount,
        );
    final NotificationDefinition definition = NotificationDefinition(
      id: 'payment',
      applicationId: 'com.example.bank',
      name: 'Example Bank',
      sampleTitle: 'Card payment',
      sampleBody: 'Paid 12.50 CAD',
      createdAt: DateTime(2026, 9, 8),
      extractors: <RegExpDefinition>[extractor],
      rules: const <NotificationRule>[],
      extractorMode: NotificationExtractorMode.basic,
      transactionCreationMode: TransactionCreationMode.automatic,
    );

    final NotificationDefinition copied = definition.copyWith(
      name: 'Updated Example Bank',
    );

    expect(copied.name, 'Updated Example Bank');
    expect(copied.id, definition.id);
    expect(copied.applicationId, definition.applicationId);
    expect(copied.sampleTitle, definition.sampleTitle);
    expect(copied.sampleBody, definition.sampleBody);
    expect(copied.createdAt, definition.createdAt);
    expect(copied.extractors, definition.extractors);
    expect(copied.rules, definition.rules);
    expect(copied.extractorMode, definition.extractorMode);
    expect(copied.transactionCreationMode, definition.transactionCreationMode);
  });

  // Keeps a registration unconfigured when its guided sample input is
  // cancelled, then marks it ready after its required setup exists.
  test(
    'derives readiness status from the guided registration requirements',
    () {
      const NotificationDefinition incomplete = NotificationDefinition(
        id: 'bank-payment-definition',
        applicationId: 'com.example.bank',
        name: 'Example Bank payments',
        extractors: <RegExpDefinition>[],
        rules: <NotificationRule>[],
      );
      final NotificationDefinition complete = NotificationDefinition(
        id: incomplete.id,
        applicationId: incomplete.applicationId,
        name: incomplete.name,
        sampleTitle: 'Card payment',
        sampleBody: 'Paid 12.50 CAD',
        extractors: <RegExpDefinition>[
          RegExpDefinition.createPredefinedRegExpDefinition(
            PredefinedRegExpDefinition.amount,
          ),
        ],
        rules: const <NotificationRule>[
          NotificationRule(
            id: 'transaction',
            name: 'Transaction',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
        ],
        extractorMode: NotificationExtractorMode.basic,
      );

      expect(incomplete.status, NotificationDefinitionStatus.notConfigured);
      expect(incomplete.extractorMode, NotificationExtractorMode.notConfigured);
      expect(complete.status, NotificationDefinitionStatus.ready);
      expect(
        complete.copyWith(requiresMigrationReview: true).status,
        NotificationDefinitionStatus.needsReview,
      );

      final RegExpDefinition repeatedAmount =
          RegExpDefinition.createCustomRegExpDefinition(
            'Amounts',
            r'(?<amount>\d+)',
          );
      final NotificationDefinition needsReview = NotificationDefinition(
        id: incomplete.id,
        applicationId: incomplete.applicationId,
        name: incomplete.name,
        sampleTitle: 'Card payment',
        sampleBody: 'Paid 12 and 15 CAD',
        extractors: <RegExpDefinition>[repeatedAmount],
        rules: <NotificationRule>[
          NotificationRule(
            id: 'transaction',
            name: 'Transaction details',
            isPredefined: true,
            conditions: const <NotificationCondition>[],
            actions: <NotificationAction>[
              SetTransactionFieldAction(
                target: TransactionField.amount,
                valueSource: RegExpCaptureValueSource(
                  extractorId: repeatedAmount.id,
                  captureName: 'amount',
                ),
              ),
            ],
          ),
        ],
        extractorMode: NotificationExtractorMode.basic,
      );
      expect(needsReview.status, NotificationDefinitionStatus.needsReview);

      final NotificationDefinition incompleteBasicMapping =
          NotificationDefinition(
            id: incomplete.id,
            applicationId: incomplete.applicationId,
            name: incomplete.name,
            sampleTitle: 'Card payment',
            sampleBody: 'Paid CAD',
            extractors: <RegExpDefinition>[repeatedAmount],
            rules: <NotificationRule>[
              NotificationRule(
                id: 'transaction',
                name: 'Transaction details',
                isPredefined: true,
                conditions: const <NotificationCondition>[],
                actions: <NotificationAction>[
                  SetTransactionFieldAction(
                    target: TransactionField.amount,
                    valueSource: RegExpCaptureValueSource(
                      extractorId: repeatedAmount.id,
                      captureName: 'amount',
                    ),
                  ),
                ],
              ),
            ],
            extractorMode: NotificationExtractorMode.basic,
          );
      expect(
        incompleteBasicMapping.status,
        NotificationDefinitionStatus.needsReview,
      );

      final NotificationDefinition unresolvedCurrency = NotificationDefinition(
        id: incomplete.id,
        applicationId: incomplete.applicationId,
        name: incomplete.name,
        sampleTitle: 'Card payment',
        sampleBody: 'Paid 12 CAD',
        extractors: <RegExpDefinition>[repeatedAmount],
        rules: <NotificationRule>[
          NotificationRule(
            id: 'transaction-currency',
            name: 'Transaction details',
            conditions: const <NotificationCondition>[],
            actions: <NotificationAction>[
              SetTransactionFieldAction(
                target: TransactionField.currency,
                valueSource: RegExpCaptureValueSource(
                  extractorId: repeatedAmount.id,
                  captureName: 'amount',
                ),
              ),
            ],
          ),
        ],
        extractorMode: NotificationExtractorMode.advanced,
      );
      expect(
        unresolvedCurrency.status,
        NotificationDefinitionStatus.needsSetup,
      );
    },
  );

  test('restores legacy extractors as advanced without replacing them', () {
    final NotificationDefinition restored = NotificationDefinition.fromJson(
      <String, dynamic>{
        'id': 'legacy',
        'applicationId': 'com.example.bank',
        'name': 'Example Bank',
        'extractors': <Map<String, dynamic>>[
          RegExpDefinition.createCustomRegExpDefinition(
            'Legacy amount',
            r'(?<amount>\d+)',
          ).toJson(),
        ],
        'rules': <Map<String, dynamic>>[],
      },
    );

    expect(restored.extractorMode, NotificationExtractorMode.advanced);
    expect(restored.extractors.single.definitionName, 'Legacy amount');
  });

  test('uses a safe extractor mode fallback for unknown persisted values', () {
    final NotificationDefinition restored =
        NotificationDefinition.fromJson(<String, dynamic>{
          'id': 'definition',
          'applicationId': 'com.example.bank',
          'name': 'Example Bank',
          'extractorMode': 'futureMode',
          'extractors': <Map<String, dynamic>>[],
          'rules': <Map<String, dynamic>>[],
        });

    expect(restored.extractorMode, NotificationExtractorMode.notConfigured);
  });

  // Verifies the persisted definition contract and app scoping together so a
  // restored configuration produces the same patch only for its own app.
  test('round-trips and evaluates only notifications from its application', () {
    final RegExpDefinition extractor =
        RegExpDefinition.createCustomRegExpDefinition(
          'Payment amount',
          r'Paid (?<amount>\d+\.\d{2})',
        );
    final NotificationDefinition definition = NotificationDefinition(
      id: 'bank-payment-definition',
      applicationId: 'com.example.bank',
      name: 'Example Bank payments',
      sampleTitle: 'Card payment',
      sampleBody: 'Paid 12.50 CAD at Market',
      createdAt: DateTime(2026, 9, 6, 14, 58),
      extractors: <RegExpDefinition>[extractor],
      sharedActions: const <NotificationAction>[
        SetTransactionFieldAction(
          target: TransactionField.sourceAccount,
          valueSource: LiteralValueSource('Checking'),
        ),
      ],
      reviewedSharedActionFields: const <TransactionField>{
        TransactionField.sourceAccount,
      },
      rules: <NotificationRule>[
        NotificationRule(
          id: 'set-amount',
          name: 'Set amount',
          conditions: const <NotificationCondition>[],
          actions: <SetTransactionFieldAction>[
            SetTransactionFieldAction(
              target: TransactionField.amount,
              valueSource: RegExpCaptureValueSource(
                extractorId: extractor.id,
                captureName: 'amount',
              ),
            ),
            const SetTransactionFieldAction(
              target: TransactionField.category,
              valueSource: LiteralValueSource('Groceries'),
            ),
          ],
        ),
      ],
      requiresMigrationReview: true,
      migrationReviewIssues: const <NotificationMigrationIssue>{
        NotificationMigrationIssue.currencyUnresolved,
      },
    );

    final Map<String, dynamic> json =
        jsonDecode(jsonEncode(definition)) as Map<String, dynamic>;
    final NotificationDefinition restored = NotificationDefinition.fromJson(
      json,
    );

    final NotificationDefinitionEvaluationResult? result = restored.evaluate(
      NotificationContext(
        applicationId: 'com.example.bank',
        title: 'Card payment',
        body: 'Paid 12.50 CAD at Market',
        receivedAt: DateTime(2026, 8, 27),
      ),
    );

    expect(restored.id, definition.id);
    expect(restored.sampleTitle, definition.sampleTitle);
    expect(restored.sampleBody, definition.sampleBody);
    expect(restored.createdAt, definition.createdAt);
    expect(restored.requiresMigrationReview, isTrue);
    expect(restored.migrationReviewIssues, <NotificationMigrationIssue>{
      NotificationMigrationIssue.currencyUnresolved,
    });
    expect(restored.extractors.single.id, extractor.id);
    expect(restored.sharedActions, hasLength(1));
    expect(restored.reviewedSharedActionFields, <TransactionField>{
      TransactionField.sourceAccount,
    });
    expect(
      result?.effectiveTransactionIntent?.patch.values,
      <TransactionField, String>{
        TransactionField.sourceAccount: 'Checking',
        TransactionField.amount: '12.50',
        TransactionField.category: 'Groceries',
      },
    );
    expect(
      restored.evaluate(
        NotificationContext(
          applicationId: 'com.other.bank',
          title: 'Card payment',
          body: 'Paid 12.50 CAD at Market',
          receivedAt: DateTime(2026, 8, 27),
        ),
      ),
      isNull,
    );

    // Verifies a required extractor suppresses otherwise-valid definitions on
    // a normal miss, avoiding alerts and transaction plans for unrelated text.
    final NotificationDefinition requiredExtractorDefinition =
        NotificationDefinition(
          id: 'required-extractor-definition',
          applicationId: 'com.example.bank',
          name: 'Required extractor',
          extractors: <RegExpDefinition>[
            RegExpDefinition.createCustomRegExpDefinition(
              'Payment amount',
              r'Paid (?<amount>\d+\.\d{2})',
              isRequiredForMatch: true,
            ),
          ],
          rules: const <NotificationRule>[],
        );
    expect(
      requiredExtractorDefinition.evaluate(
        NotificationContext(
          applicationId: 'com.example.bank',
          title: 'Statement',
          body: 'Your statement is ready',
          receivedAt: DateTime(2026, 8, 30),
        ),
      ),
      isNull,
    );
  });
}
