import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_sample.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_safety.dart';

void main() {
  test('round-trips a sample override', () {
    final RegExpDefinition extractor =
        RegExpDefinition.createCustomRegExpDefinition(
          'Amount',
          r'(?<amount>\d+)',
          description: 'Finds the transaction amount.',
          sampleOverride: NotificationSample(
            title: 'Card payment',
            body: 'Paid 12.50 CAD',
            receivedAt: DateTime(2026, 9, 23, 14, 30),
          ),
        );

    final RegExpDefinition restored = RegExpDefinition.fromJson(
      extractor.toJson(),
    );

    expect(restored.sampleOverride?.title, 'Card payment');
    expect(restored.description, 'Finds the transaction amount.');
    expect(restored.sampleOverride?.body, 'Paid 12.50 CAD');
    expect(restored.sampleOverride?.receivedAt, DateTime(2026, 9, 23, 14, 30));
  });

  test('defaults a missing description for older JSON', () {
    final RegExpDefinition extractor =
        RegExpDefinition.createCustomRegExpDefinition('Amount', r'\d+');
    final Map<String, dynamic> json = extractor.toJson()..remove('description');

    expect(RegExpDefinition.fromJson(json).description, isEmpty);
  });

  test('predefined amount extractor prefers values with a currency marker', () {
    final RegExpDefinition extractor =
        RegExpDefinition.createPredefinedRegExpDefinition(
          PredefinedRegExpDefinition.amount,
        );

    final RegExpEvaluationResult result = extractor.evaluate(
      NotificationContext(
        title: 'RBC purchase',
        body:
            'A purchase of \$4.99 CAD was made from RBC credit card 9999 at VENDOR.',
        receivedAt: DateTime(2026, 8, 31),
      ),
    );

    expect(result.capturesFor('amount'), <String>['4.99']);
  });

  test('rejects oversized custom extractor input without truncating it', () {
    final RegExpDefinition extractor =
        RegExpDefinition.createCustomRegExpDefinition(
          'Ending value',
          r'(?<value>END)$',
        );

    final RegExpEvaluationResult result = extractor.evaluate(
      NotificationContext(
        title: 'Long notification',
        body:
            '${List<String>.filled(RegExpDefinition.maximumCustomInputLength, 'a').join()}'
            'END',
        receivedAt: DateTime(2026, 9, 26),
      ),
    );

    expect(result.hasMatches, isFalse);
    expect(result.isPatternValid, isTrue);
    expect(result.failure, RegExpEvaluationFailure.inputTooLong);
  });

  test('evaluates custom extractor input at the safety limit', () {
    final RegExpDefinition extractor =
        RegExpDefinition.createCustomRegExpDefinition(
          'Ending value',
          r'(?<value>END)$',
        );
    final String body =
        '${List<String>.filled(RegExpDefinition.maximumCustomInputLength - 3, 'a').join()}END';

    final RegExpEvaluationResult result = extractor.evaluate(
      NotificationContext(
        title: 'Long notification',
        body: body,
        receivedAt: DateTime(2026, 9, 26),
      ),
    );

    expect(result.failure, isNull);
    expect(result.capturesFor('value'), <String>['END']);
  });

  test('does not cap predefined extractor input', () {
    final RegExpDefinition extractor =
        RegExpDefinition.createPredefinedRegExpDefinition(
          PredefinedRegExpDefinition.amount,
        );
    final String body =
        'Paid \$12.50 CAD '
        '${List<String>.filled(RegExpDefinition.maximumCustomInputLength, 'x').join()}';

    final RegExpEvaluationResult result = extractor.evaluate(
      NotificationContext(
        title: 'Long notification',
        body: body,
        receivedAt: DateTime(2026, 9, 26),
      ),
    );

    expect(result.failure, isNull);
    expect(result.capturesFor('amount'), contains('12.50'));
  });

  test('warns about nested quantifiers and repeated wildcards', () {
    expect(
      RegExpSafety.analyze(r'(a+)+$'),
      contains(RegExpSafetyIssue.nestedQuantifier),
    );
    expect(
      RegExpSafety.analyze(r'((a?))+$'),
      contains(RegExpSafetyIssue.nestedQuantifier),
    );
    expect(
      RegExpSafety.analyze(r'.*prefix.*suffix'),
      contains(RegExpSafetyIssue.repeatedWildcard),
    );
    expect(
      RegExpSafety.analyze(r'Paid (?<amount>\d+\.\d{2}) (?<currency>[A-Z]{3})'),
      isEmpty,
    );
  });
}
