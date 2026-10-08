import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_evaluation_result.dart';

void main() {
  group('RegExpDefinition evaluation', () {
    test('restores predefined extractors with the current preset pattern', () {
      final RegExpDefinition definition =
          RegExpDefinition.fromJson(<String, dynamic>{
            'id': 'currency',
            'name': 'Currency',
            'source': r'old currency regex',
            'type': RegExpDefinitionType.predefined.index,
            'predefinedType': PredefinedRegExpDefinition.currency.name,
          });

      expect(
        definition.regExpSource,
        PredefinedRegExpDefinition.currency.source,
      );
    });

    test('preserves the legacy predefined amount and currency pattern', () {
      final RegExpDefinition
      definition = RegExpDefinition.fromJson(<String, dynamic>{
        'id': 'legacy-currency',
        'name': 'Amount and currency',
        'source':
            r'(?:^|\s)(?<preCurrency>(?:[^\r\n\t\f\v 0-9]){0,3})\s*(?<amount>\d[.,\s\d]+(?:[.,]\d+)?)\s*(?<postCurrency>(?:[^\r\n\t\f\v 0-9]){0,3})(?:$|\s)',
        'type': RegExpDefinitionType.predefined.index,
      });
      final NotificationContext context = NotificationContext(
        title: '',
        body: 'Paid EUR 12.50 CAD',
        receivedAt: DateTime(2026, 8, 31),
      );

      final RegExpEvaluationResult result = definition.evaluate(context);

      expect(result.capturesFor('amount'), <String>['12.50 ']);
      expect(result.capturesFor('preCurrency'), <String>['EUR']);
      expect(result.capturesFor('postCurrency'), <String>['CAD']);
    });

    test(
      'predefined extractors capture their corresponding notification fields',
      () {
        final NotificationContext context = NotificationContext(
          title: 'Card payment',
          body: 'Paid EUR 12.50 CAD at Market',
          receivedAt: DateTime(2026, 8, 31, 12, 30),
        );

        expect(
          RegExpDefinition.createPredefinedRegExpDefinition(
            PredefinedRegExpDefinition.notificationTitle,
          ).evaluate(context).capturesFor('title'),
          <String>['Card payment'],
        );
        expect(
          RegExpDefinition.createPredefinedRegExpDefinition(
            PredefinedRegExpDefinition.notificationMessage,
          ).evaluate(context).capturesFor('message'),
          <String>['Paid EUR 12.50 CAD at Market'],
        );
        expect(
          RegExpDefinition.createPredefinedRegExpDefinition(
            PredefinedRegExpDefinition.amount,
          ).evaluate(context).capturesFor('amount'),
          <String>['12.50'],
        );
        expect(
          RegExpDefinition.createPredefinedRegExpDefinition(
            PredefinedRegExpDefinition.amount,
          ).evaluate(context).matches.single.group(0)?.trim(),
          'EUR 12.50 CAD',
        );
        expect(
          RegExpDefinition.createPredefinedRegExpDefinition(
            PredefinedRegExpDefinition.currency,
          ).evaluate(context).capturesFor('preCurrency'),
          <String>['EUR'],
        );
        expect(
          RegExpDefinition.createPredefinedRegExpDefinition(
            PredefinedRegExpDefinition.currency,
          ).evaluate(context).capturesFor('postCurrency'),
          <String>['CAD'],
        );
        expect(
          RegExpDefinition.createPredefinedRegExpDefinition(
            PredefinedRegExpDefinition.notificationDate,
          ).evaluate(context).capturesFor('date'),
          <String>['2026-08-31T12:30:00.000'],
        );
      },
    );

    test(
      'currency extractor captures valid prefix and suffix in one match',
      () {
        final NotificationContext context = NotificationContext(
          title: 'Card payment',
          body: r'Paid $ 4.99 CAD from account 9999 at VENDOR.',
          receivedAt: DateTime(2026, 8, 31),
        );

        final RegExpEvaluationResult result =
            RegExpDefinition.createPredefinedRegExpDefinition(
              PredefinedRegExpDefinition.currency,
            ).evaluate(context);

        expect(result.matches, hasLength(1));
        expect(result.matches.single.group(0)?.trim(), r'$ 4.99 CAD');
        expect(result.capturesFor('preCurrency'), <String>[r'$']);
        expect(result.capturesFor('postCurrency'), <String>['CAD']);
      },
    );

    test('currency extractor excludes trailing sentence punctuation', () {
      final NotificationContext context = NotificationContext(
        title: 'Card payment',
        body: r'A purchase of $4.99 CAD was made at VENDOR $9.00.',
        receivedAt: DateTime(2026, 8, 31),
      );

      final RegExpEvaluationResult result =
          RegExpDefinition.createPredefinedRegExpDefinition(
            PredefinedRegExpDefinition.currency,
          ).evaluate(context);

      expect(
        result.matches.map((RegExpMatch match) => match.group(0)?.trim()),
        <String?>[r'$4.99 CAD', r'$9.00'],
      );
      expect(result.capturesFor('postCurrency'), <String>['CAD']);
    });

    // Verifies named and positional captures are both available so migrated
    // legacy patterns and new named-capture definitions share one evaluator.
    test('returns named captures from a notification context', () {
      final RegExpDefinition definition =
          RegExpDefinition.createCustomRegExpDefinition(
            'Payment amount',
            r'Paid (?<amount>\d+\.\d{2}) (?<currency>[A-Z]{3})',
          );
      final NotificationContext context = NotificationContext(
        applicationId: 'com.example.bank',
        applicationName: 'Example Bank',
        title: 'Card payment',
        body: 'Paid 12.50 CAD at Market',
        receivedAt: DateTime(2026, 8, 27),
      );

      final RegExpEvaluationResult result = definition.evaluate(context);

      expect(result.hasMatches, isTrue);
      expect(result.isPatternValid, isTrue);
      expect(result.capturesFor('amount'), <String>['12.50']);
      expect(result.capturesFor('currency'), <String>['CAD']);
      expect(result.capturesForIndex(1), <String>['12.50']);
    });

    // Distinguishes normal no-match input from invalid configuration so only
    // the latter needs a diagnostics alert.
    test('returns no matches for a valid pattern that does not match', () {
      final RegExpDefinition definition =
          RegExpDefinition.createCustomRegExpDefinition(
            'Payment amount',
            r'Paid (?<amount>\d+)',
          );
      final NotificationContext context = NotificationContext(
        title: 'Card payment',
        body: 'No payment details',
        receivedAt: DateTime(2026, 8, 27),
      );

      final RegExpEvaluationResult result = definition.evaluate(context);

      expect(result.hasMatches, isFalse);
      expect(result.isPatternValid, isTrue);
      expect(result.namedCaptures, isEmpty);
    });

    // Ensures a malformed user pattern becomes structured evaluation data and
    // cannot crash notification handling on the listener callback.
    test('reports an invalid custom pattern without throwing', () {
      final RegExpDefinition definition =
          RegExpDefinition.createCustomRegExpDefinition('Broken pattern', '[');
      final NotificationContext context = NotificationContext(
        title: 'Card payment',
        body: 'Paid 12.50 CAD',
        receivedAt: DateTime(2026, 8, 27),
      );

      final RegExpEvaluationResult result = definition.evaluate(context);

      expect(result.hasMatches, isFalse);
      expect(result.isPatternValid, isFalse);
      expect(result.error, isNotNull);
    });
  });
}
