import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/domain/actions/action_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_tags_action.dart';
import 'package:waterflyiii/notifications/domain/conditions/value_exists_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/any_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/value_contains_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/values_equal_condition.dart';
import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_sample.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_rule_requirement.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_action_group.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule_diagnostics.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_rule_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/composed_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/literal_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/notification_property_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/value_source.dart';

void main() {
  final EvaluationContext context = EvaluationContext(
    notification: NotificationContext(
      title: 'Card payment',
      body: 'Paid 12.50 CAD at Market',
      receivedAt: DateTime(2026, 8, 27),
    ),
    extractionResults: const <String, RegExpEvaluationResult>{
      'payment': RegExpEvaluationResult(
        hasMatches: true,
        namedCaptures: <String, List<String>>{
          'amount': <String>['12.50'],
          'currency': <String>['CAD'],
        },
      ),
    },
  );

  group('NotificationRule', () {
    test('round-trips a sample override', () {
      final NotificationRule rule = NotificationRule(
        id: 'payment-rule',
        name: 'Card payment',
        description: 'Handles card payment notifications.',
        conditions: const <NotificationCondition>[],
        actions: const <NotificationAction>[],
        sampleOverride: NotificationSample(
          title: 'Card payment',
          body: 'Paid 12.50 CAD',
          receivedAt: DateTime(2026, 9, 23, 14, 30),
        ),
      );

      final NotificationRule restored = NotificationRule.fromJson(
        rule.toJson(),
      );

      expect(restored.sampleOverride?.title, 'Card payment');
      expect(restored.description, 'Handles card payment notifications.');
      expect(restored.sampleOverride?.body, 'Paid 12.50 CAD');
      expect(
        restored.sampleOverride?.receivedAt,
        DateTime(2026, 9, 23, 14, 30),
      );
    });

    test('round-trips a conditional action sample override', () {
      final NotificationRule rule = NotificationRule(
        id: 'payment-rule',
        name: 'Card payment',
        conditions: const <NotificationCondition>[],
        actions: const <NotificationAction>[],
        conditionalActionGroups: <NotificationActionGroup>[
          NotificationActionGroup(
            id: 'merchant',
            name: 'Merchant category',
            conditions: const <NotificationCondition>[],
            actions: const <NotificationAction>[],
            sampleOverride: NotificationSample(
              title: 'Card payment',
              body: 'Paid at Corner Store',
              receivedAt: DateTime(2026, 9, 27, 16, 30),
            ),
          ),
        ],
      );

      final NotificationActionGroup restored = NotificationRule.fromJson(
        rule.toJson(),
      ).conditionalActionGroups.single;

      expect(restored.sampleOverride?.title, 'Card payment');
      expect(restored.sampleOverride?.body, 'Paid at Corner Store');
      expect(
        restored.sampleOverride?.receivedAt,
        DateTime(2026, 9, 27, 16, 30),
      );
    });

    test('defaults a missing description for older JSON', () {
      const NotificationRule rule = NotificationRule(
        id: 'payment-rule',
        name: 'Card payment',
        conditions: <NotificationCondition>[],
        actions: <NotificationAction>[],
      );
      final Map<String, dynamic> json = rule.toJson()..remove('description');

      expect(NotificationRule.fromJson(json).description, isEmpty);
    });

    // Verifies a fully matching rule combines action patches, which is the
    // basis for building a complete dry-run transaction intent.
    test('applies actions when every condition matches', () {
      final NotificationRule rule = const NotificationRule(
        id: 'payment-rule',
        name: 'CAD payment',
        conditions: <ValuesEqualCondition>[
          ValuesEqualCondition(
            left: RegExpCaptureValueSource(
              extractorId: 'payment',
              captureName: 'currency',
            ),
            right: LiteralValueSource('CAD'),
          ),
        ],
        actions: <SetTransactionFieldAction>[
          SetTransactionFieldAction(
            target: TransactionField.amount,
            valueSource: RegExpCaptureValueSource(
              extractorId: 'payment',
              captureName: 'amount',
            ),
          ),
          SetTransactionFieldAction(
            target: TransactionField.category,
            valueSource: LiteralValueSource('Groceries'),
          ),
        ],
      );

      final NotificationRuleEvaluationResult result = rule.evaluate(context);

      expect(result.matches, isTrue);
      expect(result.patch.values, <TransactionField, String>{
        TransactionField.amount: '12.50',
        TransactionField.category: 'Groceries',
      });
      expect(
        result.actions.every(
          (ActionEvaluationResult action) => action.succeeded,
        ),
        isTrue,
      );
    });

    test('combines scalar fields with a multi-tag action', () {
      const NotificationRule rule = NotificationRule(
        id: 'tagged-payment',
        name: 'Tagged payment',
        conditions: <ValueExistsCondition>[
          ValueExistsCondition(LiteralValueSource('payment')),
        ],
        actions: <NotificationAction>[
          SetTransactionFieldAction(
            target: TransactionField.category,
            valueSource: LiteralValueSource('Groceries'),
          ),
          SetTransactionTagsAction(<String>['Market', 'Weekly']),
        ],
      );

      final NotificationRuleEvaluationResult result = rule.evaluate(context);

      expect(result.patch.values, <TransactionField, String>{
        TransactionField.category: 'Groceries',
      });

      expect(result.patch.tags, <String>['Market', 'Weekly']);
    });

    test('skips incomplete conditional action groups entirely', () {
      const NotificationRule rule = NotificationRule(
        id: 'payment-rule',
        name: 'Card payment',
        conditions: <NotificationCondition>[],
        actions: <NotificationAction>[
          SetTransactionFieldAction(
            target: TransactionField.title,
            valueSource: LiteralValueSource('Card payment'),
          ),
        ],
        conditionalActionGroups: <NotificationActionGroup>[
          NotificationActionGroup(
            id: 'missing-condition',
            name: 'Missing condition',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[
              SetTransactionFieldAction(
                target: TransactionField.amount,
                valueSource: RegExpCaptureValueSource(
                  extractorId: 'missing',
                  captureName: 'amount',
                ),
              ),
            ],
          ),
          NotificationActionGroup(
            id: 'missing-action',
            name: 'Missing action',
            conditions: <NotificationCondition>[
              ValueExistsCondition(
                RegExpCaptureValueSource(
                  extractorId: 'missing',
                  captureName: 'value',
                ),
              ),
            ],
            actions: <NotificationAction>[],
          ),
        ],
      );

      final NotificationRuleEvaluationResult result = rule.evaluate(context);

      expect(rule.requirements, isEmpty);
      expect(rule.allActions, hasLength(1));
      expect(
        rule
            .diagnostics(
              extractors: const <RegExpDefinition>[],
              notificationContext: context.notification,
            )
            .incompleteFields,
        isEmpty,
      );
      expect(result.matches, isTrue);
      expect(result.patch.values, <TransactionField, String>{
        TransactionField.title: 'Card payment',
      });
      for (final String groupId in <String>[
        'missing-condition',
        'missing-action',
      ]) {
        expect(result.conditionalGroups[groupId]?.matches, isFalse);
        expect(result.conditionalGroups[groupId]?.conditions, isEmpty);
        expect(result.conditionalGroups[groupId]?.actions, isEmpty);
      }
    });

    test(
      'skips conditions and actions when a required capture is unavailable',
      () {
        const NotificationRule rule = NotificationRule(
          id: 'missing-capture',
          name: 'Missing capture',
          conditions: <ValueExistsCondition>[
            ValueExistsCondition(
              RegExpCaptureValueSource(
                extractorId: 'payment',
                captureName: 'merchant',
              ),
            ),
          ],
          actions: <SetTransactionFieldAction>[
            SetTransactionFieldAction(
              target: TransactionField.category,
              valueSource: LiteralValueSource('Groceries'),
            ),
          ],
        );

        final NotificationRuleEvaluationResult result = rule.evaluate(context);

        expect(result.matches, isFalse);
        expect(result.actions, isEmpty);
        expect(result.patch.isEmpty, isTrue);
        expect(result.conditions, isEmpty);
        expect(result.unmetRequirements.single.capture.captureName, 'merchant');
      },
    );

    test('requires captures shared by every any-condition branch', () {
      const NotificationRule rule = NotificationRule(
        id: 'merchant-rule',
        name: 'Merchant rule',
        conditions: <NotificationCondition>[
          AnyCondition(<NotificationCondition>[
            ValueContainsCondition(
              value: RegExpCaptureValueSource(
                extractorId: 'payment',
                captureName: 'merchant',
              ),
              substring: LiteralValueSource('Walmart'),
            ),
            ValueContainsCondition(
              value: RegExpCaptureValueSource(
                extractorId: 'payment',
                captureName: 'merchant',
              ),
              substring: LiteralValueSource('Save On Foods'),
            ),
          ]),
        ],
        actions: <NotificationAction>[
          SetTransactionFieldAction(
            target: TransactionField.category,
            valueSource: LiteralValueSource('Food'),
          ),
        ],
      );

      expect(rule.requirements, hasLength(1));
      expect(rule.requirements.single.capture.captureName, 'merchant');
      expect(rule.evaluate(context).unmetRequirements, hasLength(1));
    });

    test('requires every capture used by a composed action value', () {
      final NotificationRule rule = NotificationRule(
        id: 'composed-title',
        name: 'Composed title',
        conditions: const <NotificationCondition>[],
        actions: <NotificationAction>[
          SetTransactionFieldAction(
            target: TransactionField.title,
            valueSource: ComposedValueSource(const <ValueSource>[
              LiteralValueSource('Payment: '),
              RegExpCaptureValueSource(
                extractorId: 'payment',
                captureName: 'amount',
              ),
              LiteralValueSource(' at '),
              RegExpCaptureValueSource(
                extractorId: 'payment',
                captureName: 'merchant',
              ),
            ]),
          ),
        ],
      );

      expect(
        rule.requirements
            .map(
              (NotificationRuleRequirement requirement) =>
                  requirement.capture.captureName,
            )
            .toSet(),
        <String>{'amount', 'merchant'},
      );
      expect(
        rule.evaluate(context).unmetRequirements.single.capture.captureName,
        'merchant',
      );
    });

    // Verifies planning remains declarative and carries the definition mode
    // and patch, preventing the dry-run evaluator from performing writes.
    test('produces a dry-run transaction intent', () {
      const NotificationRule rule = NotificationRule(
        id: 'planned-payment',
        name: 'Planned payment',
        conditions: <ValueExistsCondition>[
          ValueExistsCondition(LiteralValueSource('payment')),
        ],
        actions: <NotificationAction>[
          SetTransactionFieldAction(
            target: TransactionField.title,
            valueSource: NotificationPropertyValueSource(
              NotificationProperty.title,
            ),
          ),
        ],
      );

      final NotificationRuleEvaluationResult result = rule.evaluate(
        context,
        transactionCreationMode: TransactionCreationMode.automatic,
      );

      expect(result.transactionIntent?.mode, TransactionCreationMode.automatic);
      expect(
        result.transactionIntent?.patch.values[TransactionField.title],
        'Card payment',
      );
    });

    // Confirms rules retain their polymorphic conditions/actions after local
    // persistence, rather than restoring only their descriptive fields.
    test('round-trips conditions and actions through JSON', () {
      const NotificationRule rule = NotificationRule(
        id: 'payment-rule',
        name: 'CAD payment',
        isPredefined: true,
        reviewedPredefinedFields: <TransactionField>{TransactionField.amount},
        conditions: <ValuesEqualCondition>[
          ValuesEqualCondition(
            left: RegExpCaptureValueSource(
              extractorId: 'payment',
              captureName: 'currency',
            ),
            right: LiteralValueSource('CAD'),
          ),
        ],
        actions: <SetTransactionFieldAction>[
          SetTransactionFieldAction(
            target: TransactionField.category,
            valueSource: LiteralValueSource('Groceries'),
          ),
        ],
        conditionalActionGroups: <NotificationActionGroup>[
          NotificationActionGroup(
            id: 'merchant',
            name: 'Market merchant',
            conditions: <ValueContainsCondition>[
              ValueContainsCondition(
                value: NotificationPropertyValueSource(
                  NotificationProperty.body,
                ),
                substring: LiteralValueSource('Market'),
              ),
            ],
            actions: <SetTransactionFieldAction>[
              SetTransactionFieldAction(
                target: TransactionField.title,
                valueSource: LiteralValueSource('Market purchase'),
              ),
            ],
          ),
        ],
      );

      final Map<String, dynamic> decoded =
          jsonDecode(jsonEncode(rule)) as Map<String, dynamic>;
      final NotificationRule restored = NotificationRule.fromJson(decoded);

      expect(restored.id, rule.id);
      expect(restored.name, rule.name);
      expect(restored.isPredefined, isTrue);
      expect(restored.reviewedPredefinedFields, <TransactionField>{
        TransactionField.amount,
      });
      expect(
        restored.evaluate(context).patch.values,
        <TransactionField, String>{
          TransactionField.category: 'Groceries',
          TransactionField.title: 'Market purchase',
        },
      );
      expect(restored.conditionalActionGroups.single.id, 'merchant');
      expect(restored.conditionalActionGroups.single.name, 'Market merchant');
    });
  });
}
