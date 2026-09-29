import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/domain/conditions/all_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/any_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/condition_nesting.dart';
import 'package:waterflyiii/notifications/domain/conditions/not_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/value_exists_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/values_greater_than_condition.dart';
import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/value_sources/literal_value_source.dart';

void main() {
  final EvaluationContext context = EvaluationContext(
    notification: NotificationContext(
      title: 'Card payment',
      body: 'Paid 12.50 CAD',
      receivedAt: DateTime(2026, 8, 27),
    ),
    extractionResults: const <String, RegExpEvaluationResult>{},
  );

  const NotificationCondition trueCondition = ValueExistsCondition(
    LiteralValueSource('value'),
  );
  const NotificationCondition falseCondition = ValuesGreaterThanCondition(
    left: LiteralValueSource('10'),
    right: LiteralValueSource('20'),
  );

  group('Composite conditions', () {
    // Confirms nested boolean composition preserves all/any/not semantics so
    // complex user-defined matching logic evaluates predictably.
    test('all, any, and not evaluate nested conditions', () {
      expect(
        const AllCondition(<NotificationCondition>[
          trueCondition,
          falseCondition,
        ]).evaluate(context).matches,
        isFalse,
      );
      expect(
        const AnyCondition(<NotificationCondition>[
          falseCondition,
          trueCondition,
        ]).evaluate(context).matches,
        isTrue,
      );
      expect(
        const NotCondition(trueCondition).evaluate(context).matches,
        isFalse,
      );
      expect(
        const NotCondition(falseCondition).evaluate(context).matches,
        isTrue,
      );
    });

    test('preserves diagnostic failures unless an any branch matches', () {
      const NotificationCondition diagnosticCondition =
          ValuesGreaterThanCondition(
            left: LiteralValueSource('2026-09-02'),
            right: LiteralValueSource('2026-09-01T10:30:00'),
          );

      expect(
        const NotCondition(diagnosticCondition).evaluate(context).matches,
        isFalse,
      );
      expect(
        const NotCondition(
          diagnosticCondition,
        ).evaluate(context).isDiagnosticFailure,
        isTrue,
      );
      expect(
        const AnyCondition(<NotificationCondition>[
          diagnosticCondition,
          trueCondition,
        ]).evaluate(context).isDiagnosticFailure,
        isFalse,
      );
      expect(
        const AnyCondition(<NotificationCondition>[
          diagnosticCondition,
          falseCondition,
        ]).evaluate(context).isDiagnosticFailure,
        isTrue,
      );
    });

    // Confirms nested condition type metadata survives persistence, which is
    // required before saved definitions can be evaluated after an app restart.
    test('round-trips nested conditions through JSON', () {
      const NotificationCondition condition =
          AllCondition(<NotificationCondition>[
            ValueExistsCondition(LiteralValueSource('value')),
            NotCondition(
              ValuesGreaterThanCondition(
                left: LiteralValueSource('10'),
                right: LiteralValueSource('20'),
              ),
            ),
          ]);

      final Map<String, dynamic> decoded =
          jsonDecode(jsonEncode(condition)) as Map<String, dynamic>;
      final NotificationCondition restored = NotificationCondition.fromJson(
        decoded,
      );

      expect(restored.evaluate(context).matches, isTrue);
    });

    test('counts all, any, and not toward the nesting depth', () {
      const NotificationCondition atMaximum = AllCondition(
        <NotificationCondition>[
          AnyCondition(<NotificationCondition>[NotCondition(trueCondition)]),
        ],
      );
      const NotificationCondition overMaximum = NotCondition(atMaximum);

      expect(conditionNestingDepth(atMaximum), maximumConditionNestingDepth);
      expect(
        conditionNestingDepth(overMaximum),
        maximumConditionNestingDepth + 1,
      );
    });
  });
}
