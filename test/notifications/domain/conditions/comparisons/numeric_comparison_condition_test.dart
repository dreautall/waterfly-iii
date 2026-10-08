import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/domain/conditions/all_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/any_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/not_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/values_greater_than_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/values_greater_than_or_equal_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/values_less_than_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/values_less_than_or_equal_condition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/value_sources/literal_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';

void main() {
  final EvaluationContext context = EvaluationContext(
    notification: NotificationContext(
      title: 'Card payment',
      body: 'Paid 12.50 CAD',
      receivedAt: DateTime(2026, 9, 1),
    ),
    extractionResults: const <String, RegExpEvaluationResult>{},
  );

  group('Ordering comparison conditions', () {
    test('evaluates greater-than and less-than comparisons', () {
      expect(
        const ValuesGreaterThanCondition(
          left: LiteralValueSource('12.50'),
          right: LiteralValueSource('10'),
        ).evaluate(context).matches,
        isTrue,
      );
      expect(
        const ValuesLessThanCondition(
          left: LiteralValueSource('9,50'),
          right: LiteralValueSource('10'),
        ).evaluate(context).matches,
        isTrue,
      );
    });

    test('includes equal numeric values for inclusive comparisons', () {
      expect(
        const ValuesGreaterThanOrEqualCondition(
          left: LiteralValueSource('10'),
          right: LiteralValueSource('10'),
        ).evaluate(context).matches,
        isTrue,
      );
      expect(
        const ValuesLessThanOrEqualCondition(
          left: LiteralValueSource('10'),
          right: LiteralValueSource('10'),
        ).evaluate(context).matches,
        isTrue,
      );
    });

    test('orders matching date, date-time, and time values', () {
      expect(
        const ValuesGreaterThanCondition(
          left: LiteralValueSource('2026-09-02'),
          right: LiteralValueSource('2026-09-01'),
        ).evaluate(context).matches,
        isTrue,
      );
      expect(
        const ValuesLessThanCondition(
          left: LiteralValueSource('2026-09-01T10:30:00'),
          right: LiteralValueSource('2026-09-01T11:30:00'),
        ).evaluate(context).matches,
        isTrue,
      );
      expect(
        const ValuesGreaterThanOrEqualCondition(
          left: LiteralValueSource('10:30:00'),
          right: LiteralValueSource('10:30'),
        ).evaluate(context).matches,
        isTrue,
      );
    });

    test('fails safely for equal, unresolved, and incompatible values', () {
      expect(
        const ValuesGreaterThanCondition(
          left: LiteralValueSource('10'),
          right: LiteralValueSource('10'),
        ).evaluate(context).failureReason,
        'The left value is not greater than the right value.',
      );
      expect(
        const ValuesLessThanCondition(
          left: LiteralValueSource('not a number'),
          right: LiteralValueSource('10'),
        ).evaluate(context).failureReason,
        'Both values must have the same type.',
      );
      expect(
        const ValuesLessThanCondition(
          left: LiteralValueSource('first'),
          right: LiteralValueSource('second'),
        ).evaluate(context).failureReason,
        'Text values cannot be ordered.',
      );
      expect(
        const ValuesLessThanCondition(
          left: RegExpCaptureValueSource(
            extractorId: 'missing',
            captureName: 'amount',
          ),
          right: LiteralValueSource('10'),
        ).evaluate(context).failureReason,
        'A value source did not resolve.',
      );
    });

    test('round-trips numeric comparisons through JSON', () {
      const NotificationCondition condition = ValuesGreaterThanOrEqualCondition(
        left: LiteralValueSource('12.50'),
        right: LiteralValueSource('10'),
      );

      final Map<String, dynamic> json =
          jsonDecode(jsonEncode(condition)) as Map<String, dynamic>;
      final NotificationCondition restored = NotificationCondition.fromJson(
        json,
      );

      expect(restored, isA<ValuesGreaterThanOrEqualCondition>());
      expect(restored.evaluate(context).matches, isTrue);
    });

    test(
      'evaluates and restores numeric conditions nested in boolean groups',
      () {
        const NotificationCondition condition = AllCondition(
          <NotificationCondition>[
            ValuesGreaterThanCondition(
              left: LiteralValueSource('12.50'),
              right: LiteralValueSource('10'),
            ),
            AnyCondition(<NotificationCondition>[
              ValuesLessThanCondition(
                left: LiteralValueSource('12.50'),
                right: LiteralValueSource('10'),
              ),
              NotCondition(
                ValuesLessThanCondition(
                  left: LiteralValueSource('12.50'),
                  right: LiteralValueSource('10'),
                ),
              ),
            ]),
          ],
        );

        final Map<String, dynamic> json =
            jsonDecode(jsonEncode(condition)) as Map<String, dynamic>;
        final NotificationCondition restored = NotificationCondition.fromJson(
          json,
        );

        expect(condition.evaluate(context).matches, isTrue);
        expect(restored, isA<AllCondition>());
        expect(restored.evaluate(context).matches, isTrue);
      },
    );
  });
}
