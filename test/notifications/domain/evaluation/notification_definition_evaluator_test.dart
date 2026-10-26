import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/value_exists_condition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_definition_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_definition_evaluator.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_action_group_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_action_group.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/composed_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/literal_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/value_source.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';

void main() {
  // Ensures extractors run before rules so capture-based actions see values
  // from the same notification instead of failing due to ordering.
  test('evaluates extractors before rules resolve their captures', () {
    final RegExpDefinition extractor =
        RegExpDefinition.createCustomRegExpDefinition(
          'Payment amount',
          r'Paid (?<amount>\d+\.\d{2})',
        );
    final NotificationRule rule = NotificationRule(
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
    );
    final NotificationDefinitionEvaluator evaluator =
        NotificationDefinitionEvaluator(
          extractors: <RegExpDefinition>[extractor],
          rules: <NotificationRule>[rule],
          transactionCreationMode: TransactionCreationMode.prompt,
        );

    final NotificationDefinitionEvaluationResult result = evaluator.evaluate(
      NotificationContext(
        title: 'Card payment',
        body: 'Paid 12.50 CAD at Market',
        receivedAt: DateTime(2026, 8, 27),
      ),
    );

    expect(
      result.extractionResults[extractor.id]?.capturesFor('amount'),
      <String>['12.50'],
    );
    expect(result.ruleResults[rule.id]?.matches, isTrue);
    expect(
      result.ruleResults[rule.id]?.patch.values,
      <TransactionField, String>{
        TransactionField.amount: '12.50',
        TransactionField.category: 'Groceries',
      },
    );
  });

  test('merges shared actions with the first matching rule', () {
    const List<SetTransactionFieldAction> sharedActions =
        <SetTransactionFieldAction>[
          SetTransactionFieldAction(
            target: TransactionField.sourceAccount,
            valueSource: LiteralValueSource('Main checking'),
          ),
          SetTransactionFieldAction(
            target: TransactionField.category,
            valueSource: LiteralValueSource('Unassigned'),
          ),
        ];
    const NotificationRule firstMatch = NotificationRule(
      id: 'grocery',
      name: 'Grocery purchases',
      conditions: <NotificationCondition>[],
      actions: <SetTransactionFieldAction>[
        SetTransactionFieldAction(
          target: TransactionField.category,
          valueSource: LiteralValueSource('Groceries'),
        ),
      ],
    );
    const NotificationRule laterMatch = NotificationRule(
      id: 'later',
      name: 'Later rule',
      conditions: <NotificationCondition>[],
      actions: <SetTransactionFieldAction>[
        SetTransactionFieldAction(
          target: TransactionField.sourceAccount,
          valueSource: LiteralValueSource('Other account'),
        ),
      ],
    );
    final NotificationDefinitionEvaluationResult result =
        const NotificationDefinitionEvaluator(
          extractors: <RegExpDefinition>[],
          rules: <NotificationRule>[firstMatch, laterMatch],
          sharedActions: sharedActions,
          transactionCreationMode: TransactionCreationMode.prompt,
        ).evaluate(
          NotificationContext(
            title: 'Card payment',
            body: 'Paid 12.50 CAD',
            receivedAt: DateTime(2026, 9, 20),
          ),
        );

    expect(result.selectedRuleId, 'grocery');
    expect(result.ruleResults.containsKey('later'), isFalse);
    expect(
      result.effectiveTransactionIntent?.patch.values,
      <TransactionField, String>{
        TransactionField.sourceAccount: 'Main checking',
        TransactionField.category: 'Groceries',
      },
    );
  });

  test('creates a transaction from shared actions without a matching rule', () {
    final NotificationDefinitionEvaluationResult result =
        const NotificationDefinitionEvaluator(
          extractors: <RegExpDefinition>[],
          rules: <NotificationRule>[],
          sharedActions: <SetTransactionFieldAction>[
            SetTransactionFieldAction(
              target: TransactionField.sourceAccount,
              valueSource: LiteralValueSource('Main checking'),
            ),
            SetTransactionFieldAction(
              target: TransactionField.category,
              valueSource: LiteralValueSource('Unassigned'),
            ),
          ],
          transactionCreationMode: TransactionCreationMode.prompt,
        ).evaluate(
          NotificationContext(
            title: 'Card payment',
            body: 'Paid 12.50 CAD',
            receivedAt: DateTime(2026, 9, 20),
          ),
        );

    expect(result.selectedRuleId, isNull);
    expect(result.ruleResults, isEmpty);
    expect(
      result.effectiveTransactionIntent?.patch.values,
      <TransactionField, String>{
        TransactionField.sourceAccount: 'Main checking',
        TransactionField.category: 'Unassigned',
      },
    );
  });

  test(
    'selects the next rule when an earlier rule cannot meet its requirements',
    () {
      final RegExpDefinition vendor =
          RegExpDefinition.createCustomRegExpDefinition(
            'Vendor',
            r'at (?<vendor>[^.]+)',
          );
      const NotificationRule fallbackRule = NotificationRule(
        id: 'fallback',
        name: 'Fallback',
        conditions: <NotificationCondition>[],
        actions: <SetTransactionFieldAction>[
          SetTransactionFieldAction(
            target: TransactionField.category,
            valueSource: LiteralValueSource('Unassigned'),
          ),
        ],
      );
      final NotificationRule purchaseRule = NotificationRule(
        id: 'purchase',
        name: 'Purchase',
        conditions: const <NotificationCondition>[],
        actions: <SetTransactionFieldAction>[
          SetTransactionFieldAction(
            target: TransactionField.title,
            valueSource: RegExpCaptureValueSource(
              extractorId: vendor.id,
              captureName: 'vendor',
            ),
          ),
        ],
      );

      final NotificationDefinitionEvaluationResult result =
          NotificationDefinitionEvaluator(
            extractors: <RegExpDefinition>[vendor],
            rules: <NotificationRule>[purchaseRule, fallbackRule],
            transactionCreationMode: TransactionCreationMode.prompt,
          ).evaluate(
            NotificationContext(
              title: 'Deposit received',
              body:
                  'A deposit of 334.90 was made to your RBC account Chequing.',
              receivedAt: DateTime(2026, 9, 22),
            ),
          );

      expect(result.ruleResults[purchaseRule.id]?.requirementsMet, isFalse);
      expect(result.ruleResults[purchaseRule.id]?.conditions, isEmpty);
      expect(result.selectedRuleId, fallbackRule.id);
      expect(
        result.effectiveTransactionIntent?.patch.values,
        <TransactionField, String>{TransactionField.category: 'Unassigned'},
      );
    },
  );

  test('falls back when a composed action capture is unavailable', () {
    final RegExpDefinition vendor =
        RegExpDefinition.createCustomRegExpDefinition(
          'Vendor',
          r'at (?<vendor>[^.]+)',
        );
    final NotificationRule composedRule = NotificationRule(
      id: 'composed',
      name: 'Composed title',
      conditions: const <NotificationCondition>[],
      actions: <SetTransactionFieldAction>[
        SetTransactionFieldAction(
          target: TransactionField.title,
          valueSource: ComposedValueSource(<ValueSource>[
            const LiteralValueSource('Purchase at '),
            RegExpCaptureValueSource(
              extractorId: vendor.id,
              captureName: 'vendor',
            ),
          ]),
        ),
      ],
    );
    const NotificationRule fallbackRule = NotificationRule(
      id: 'fallback',
      name: 'Fallback',
      conditions: <NotificationCondition>[],
      actions: <SetTransactionFieldAction>[
        SetTransactionFieldAction(
          target: TransactionField.title,
          valueSource: LiteralValueSource('Purchase'),
        ),
      ],
    );

    final NotificationDefinitionEvaluationResult result =
        NotificationDefinitionEvaluator(
          extractors: <RegExpDefinition>[vendor],
          rules: <NotificationRule>[composedRule, fallbackRule],
          transactionCreationMode: TransactionCreationMode.prompt,
        ).evaluate(
          NotificationContext(
            title: 'Card payment',
            body: 'Purchase notification without a vendor',
            receivedAt: DateTime(2026, 9, 29),
          ),
        );

    expect(result.ruleResults[composedRule.id]?.requirementsMet, isFalse);
    expect(result.selectedRuleId, fallbackRule.id);
    expect(
      result.effectiveTransactionIntent?.patch.values[TransactionField.title],
      'Purchase',
    );
  });

  test('ignores requirements of conditional groups that do not match', () {
    const NotificationRule rule = NotificationRule(
      id: 'deposit',
      name: 'Deposits',
      conditions: <NotificationCondition>[],
      actions: <SetTransactionFieldAction>[
        SetTransactionFieldAction(
          target: TransactionField.category,
          valueSource: LiteralValueSource('Deposit'),
        ),
      ],
      conditionalActionGroups: <NotificationActionGroup>[
        NotificationActionGroup(
          id: 'salary',
          name: 'Salary source',
          conditions: <NotificationCondition>[
            ValueExistsCondition(LiteralValueSource('')),
          ],
          actions: <SetTransactionFieldAction>[
            SetTransactionFieldAction(
              target: TransactionField.sourceAccount,
              valueSource: RegExpCaptureValueSource(
                extractorId: 'missing',
                captureName: 'account',
              ),
            ),
          ],
        ),
      ],
    );

    final NotificationDefinitionEvaluationResult result =
        const NotificationDefinitionEvaluator(
          extractors: <RegExpDefinition>[],
          rules: <NotificationRule>[rule],
          transactionCreationMode: TransactionCreationMode.prompt,
        ).evaluate(
          NotificationContext(
            title: 'Deposit received',
            body: 'A deposit was received.',
            receivedAt: DateTime(2026, 9, 22),
          ),
        );

    expect(result.selectedRuleId, rule.id);
    expect(result.ruleResults[rule.id]?.requirementsMet, isTrue);
    expect(
      result.effectiveTransactionIntent?.patch.values,
      <TransactionField, String>{TransactionField.category: 'Deposit'},
    );
  });

  test('skips rule selection when a shared action requirement is unmet', () {
    const NotificationRule rule = NotificationRule(
      id: 'deposit',
      name: 'Deposits',
      conditions: <NotificationCondition>[],
      actions: <SetTransactionFieldAction>[],
    );

    final NotificationDefinitionEvaluationResult result =
        const NotificationDefinitionEvaluator(
          extractors: <RegExpDefinition>[],
          rules: <NotificationRule>[rule],
          sharedActions: <SetTransactionFieldAction>[
            SetTransactionFieldAction(
              target: TransactionField.title,
              valueSource: RegExpCaptureValueSource(
                extractorId: 'missing',
                captureName: 'title',
              ),
            ),
          ],
          transactionCreationMode: TransactionCreationMode.prompt,
        ).evaluate(
          NotificationContext(
            title: 'Deposit received',
            body: 'A deposit was received.',
            receivedAt: DateTime(2026, 9, 22),
          ),
        );

    expect(result.selectedRuleId, isNull);
    expect(result.ruleResults, isEmpty);
    expect(result.sharedActions, isEmpty);
    expect(result.sharedRequirementsMet, isFalse);
    expect(result.effectiveTransactionIntent, isNull);
  });

  test('suppresses the transaction when a matching group action fails', () {
    const NotificationRule rule = NotificationRule(
      id: 'deposit',
      name: 'Deposits',
      conditions: <NotificationCondition>[],
      actions: <SetTransactionFieldAction>[],
      conditionalActionGroups: <NotificationActionGroup>[
        NotificationActionGroup(
          id: 'salary',
          name: 'Salary source',
          conditions: <NotificationCondition>[
            ValueExistsCondition(LiteralValueSource('salary')),
          ],
          actions: <SetTransactionFieldAction>[
            SetTransactionFieldAction(
              target: TransactionField.sourceAccount,
              valueSource: RegExpCaptureValueSource(
                extractorId: 'missing',
                captureName: 'account',
              ),
            ),
          ],
        ),
      ],
    );

    final NotificationDefinitionEvaluationResult result =
        const NotificationDefinitionEvaluator(
          extractors: <RegExpDefinition>[],
          rules: <NotificationRule>[rule],
          transactionCreationMode: TransactionCreationMode.prompt,
        ).evaluate(
          NotificationContext(
            title: 'Deposit received',
            body: 'A salary deposit was received.',
            receivedAt: DateTime(2026, 9, 22),
          ),
        );

    expect(result.selectedRuleId, rule.id);
    expect(
      result.ruleResults[rule.id]?.conditionalGroups['salary']?.succeeded,
      isFalse,
    );
    expect(result.effectiveTransactionIntent, isNull);
  });

  test('applies all matching conditional groups in order', () {
    const NotificationRule rule = NotificationRule(
      id: 'deposit',
      name: 'Deposits',
      conditions: <NotificationCondition>[],
      actions: <SetTransactionFieldAction>[
        SetTransactionFieldAction(
          target: TransactionField.sourceAccount,
          valueSource: LiteralValueSource('Fallback'),
        ),
      ],
      conditionalActionGroups: <NotificationActionGroup>[
        NotificationActionGroup(
          id: 'salary',
          name: 'Salary',
          conditions: <NotificationCondition>[
            ValueExistsCondition(LiteralValueSource('salary')),
          ],
          actions: <SetTransactionFieldAction>[
            SetTransactionFieldAction(
              target: TransactionField.sourceAccount,
              valueSource: LiteralValueSource('Employer'),
            ),
          ],
        ),
        NotificationActionGroup(
          id: 'specific-employer',
          name: 'Specific employer',
          conditions: <NotificationCondition>[
            ValueExistsCondition(LiteralValueSource('ACME')),
          ],
          actions: <SetTransactionFieldAction>[
            SetTransactionFieldAction(
              target: TransactionField.sourceAccount,
              valueSource: LiteralValueSource('ACME income'),
            ),
          ],
        ),
      ],
    );

    final NotificationDefinitionEvaluationResult result =
        const NotificationDefinitionEvaluator(
          extractors: <RegExpDefinition>[],
          rules: <NotificationRule>[rule],
          transactionCreationMode: TransactionCreationMode.prompt,
        ).evaluate(
          NotificationContext(
            title: 'Deposit',
            body: 'Salary from ACME',
            receivedAt: DateTime(2026, 9, 23),
          ),
        );

    expect(
      result.effectiveTransactionIntent?.patch.values,
      <TransactionField, String>{TransactionField.sourceAccount: 'ACME income'},
    );
    expect(
      result.ruleResults[rule.id]?.conditionalGroups.values.where(
        (NotificationActionGroupEvaluationResult group) => group.matches,
      ),
      hasLength(2),
    );
  });
}
