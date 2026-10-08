import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/value_contains_condition.dart';
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

  group('Value contains condition', () {
    test('matches text containment without regard to case', () {
      expect(
        const ValueContainsCondition(
          value: LiteralValueSource('Paid 12.50 CAD'),
          substring: LiteralValueSource('12.50'),
        ).evaluate(context).matches,
        isTrue,
      );
      expect(
        const ValueContainsCondition(
          value: LiteralValueSource('Paid 12.50 CAD'),
          substring: LiteralValueSource('paid'),
        ).evaluate(context).matches,
        isTrue,
      );
      expect(
        const ValueContainsCondition(
          value: LiteralValueSource('CAFÉ PAYMENT'),
          substring: LiteralValueSource('café'),
        ).evaluate(context).matches,
        isTrue,
      );
      expect(
        const ValueContainsCondition(
          value: LiteralValueSource('Paid 12.50 CAD'),
          substring: LiteralValueSource('refund'),
        ).evaluate(context).failureReason,
        'The value does not contain the expected text.',
      );
    });

    test('fails safely when a value source is unresolved', () {
      expect(
        const ValueContainsCondition(
          value: RegExpCaptureValueSource(
            extractorId: 'missing',
            captureName: 'merchant',
          ),
          substring: LiteralValueSource('shop'),
        ).evaluate(context).failureReason,
        'A value source did not resolve.',
      );
    });

    test('round-trips through JSON', () {
      const NotificationCondition condition = ValueContainsCondition(
        value: LiteralValueSource('Paid 12.50 CAD'),
        substring: LiteralValueSource('CAD'),
      );

      final Map<String, dynamic> json =
          jsonDecode(jsonEncode(condition)) as Map<String, dynamic>;
      final NotificationCondition restored = NotificationCondition.fromJson(
        json,
      );

      expect(restored, isA<ValueContainsCondition>());
      expect(restored.evaluate(context).matches, isTrue);
    });
  });
}
