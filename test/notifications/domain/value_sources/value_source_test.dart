import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_formatting_preferences.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/value_sources/literal_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/composed_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/normalized_amount_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/notification_property_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/value_source.dart';

void main() {
  final NotificationContext notification = NotificationContext(
    title: 'Card payment',
    body: 'Paid 12.50 CAD at Market',
    receivedAt: DateTime(2026, 8, 27),
  );
  final EvaluationContext context = EvaluationContext(
    notification: notification,
    extractionResults: <String, RegExpEvaluationResult>{
      'payment': const RegExpEvaluationResult(
        hasMatches: true,
        namedCaptures: <String, List<String>>{
          'amount': <String>['12.50'],
        },
      ),
    },
  );

  group('ValueSource', () {
    // Verifies direct constants and notification properties resolve without an
    // extractor, supporting common title/body mapping definitions.
    test('resolves literal and notification property values', () {
      expect(
        const LiteralValueSource('Groceries').resolve(context),
        'Groceries',
      );
      expect(
        const NotificationPropertyValueSource(
          NotificationProperty.title,
        ).resolve(context),
        'Card payment',
      );
      expect(
        const NotificationPropertyValueSource(
          NotificationProperty.body,
        ).resolve(context),
        'Paid 12.50 CAD at Market',
      );
    });

    test('normalizes legacy amount capture formats', () {
      for (final MapEntry<String, String> example in <String, String>{
        '1 234,56': '1234.56',
        '1,234.56': '1234.56',
        '1.234,56': '1234.56',
        '12,50': '12.50',
        '12.50': '12.50',
        '1 234': '1234',
      }.entries) {
        expect(
          NormalizedAmountCaptureValueSource.normalize(example.key),
          example.value,
        );
      }
      expect(NormalizedAmountCaptureValueSource.normalize('...'), isNull);
    });

    // Verifies named captures take priority and migrated positional fallback
    // still resolves legacy group-one amount patterns.
    test('resolves regex captures and reports missing captures as null', () {
      expect(
        const RegExpCaptureValueSource(
          extractorId: 'payment',
          captureName: 'amount',
        ).resolve(context),
        '12.50',
      );
      expect(
        const RegExpCaptureValueSource(
          extractorId: 'payment',
          captureName: 'currency',
        ).resolve(context),
        isNull,
      );
      final EvaluationContext positionalCaptureContext = EvaluationContext(
        notification: notification,
        extractionResults: const <String, RegExpEvaluationResult>{
          'payment': RegExpEvaluationResult(
            hasMatches: true,
            namedCaptures: <String, List<String>>{},
            positionalCaptures: <int, List<String>>{
              1: <String>['12.50'],
            },
          ),
        },
      );
      expect(
        const RegExpCaptureValueSource(
          extractorId: 'payment',
          captureName: 'amount',
          fallbackCaptureIndex: 1,
        ).resolve(positionalCaptureContext),
        '12.50',
      );
    });

    test('formats date-time captures for composed text', () {
      final EvaluationContext dateTimeContext = EvaluationContext(
        notification: notification,
        dateTimeExtractorIds: const <String>{'date'},
        formattingPreferences: const NotificationFormattingPreferences(
          locale: 'en_US',
          use24HourFormat: true,
        ),
        extractionResults: const <String, RegExpEvaluationResult>{
          'date': RegExpEvaluationResult(
            hasMatches: true,
            namedCaptures: <String, List<String>>{
              'date': <String>['1969-12-31T16:00:22.000'],
            },
          ),
        },
      );
      const RegExpCaptureValueSource rawSource = RegExpCaptureValueSource(
        extractorId: 'date',
        captureName: 'date',
      );
      final RegExpCaptureValueSource source = rawSource
          .withDateTimeTextFormat();

      expect(source.resolve(dateTimeContext), '12/31/1969 16:00');
      expect(rawSource.resolve(dateTimeContext), '1969-12-31T16:00:22.000');
      expect(
        ComposedValueSource(<ValueSource>[rawSource]).resolve(dateTimeContext),
        '12/31/1969 16:00',
      );
      expect(
        ValueSource.fromJson(source.toJson()).resolve(dateTimeContext),
        '12/31/1969 16:00',
      );
      final Map<String, dynamic> sourceJson = source.toJson();
      expect(sourceJson['textFormat'], 'localizedDateTime');
      expect(sourceJson, isNot(contains('dateTimeTextLocale')));
      expect(sourceJson, isNot(contains('dateTimeTextUse24HourFormat')));
      final String twelveHourValue = source.resolve(
        EvaluationContext(
          notification: notification,
          formattingPreferences: const NotificationFormattingPreferences(
            locale: 'en_US',
            use24HourFormat: false,
          ),
          extractionResults: dateTimeContext.extractionResults,
        ),
      )!;
      expect(twelveHourValue, startsWith('12/31/1969 4:00'));
      expect(twelveHourValue, endsWith('PM'));
    });

    // Confirms all concrete value-source type tags deserialize to equivalent
    // runtime values after a definition is stored and reloaded.
    test('round-trips concrete sources through JSON', () {
      final List<ValueSource> sources = <ValueSource>[
        const LiteralValueSource('Groceries'),
        const NotificationPropertyValueSource(NotificationProperty.body),
        const RegExpCaptureValueSource(
          extractorId: 'payment',
          captureName: 'amount',
        ),
        const NormalizedAmountCaptureValueSource(
          capture: RegExpCaptureValueSource(
            extractorId: 'payment',
            captureName: 'amount',
          ),
        ),
        ComposedValueSource(<ValueSource>[
          const LiteralValueSource('Paid '),
          const RegExpCaptureValueSource(
            extractorId: 'payment',
            captureName: 'amount',
          ),
          const LiteralValueSource(' CAD'),
        ]),
      ];

      for (final ValueSource source in sources) {
        final Map<String, dynamic> decoded =
            jsonDecode(jsonEncode(source)) as Map<String, dynamic>;
        expect(
          ValueSource.fromJson(decoded).resolve(context),
          source.resolve(context),
        );
      }
    });

    test('composes parts strictly in order', () {
      final ComposedValueSource source = ComposedValueSource(<ValueSource>[
        const LiteralValueSource('Amount: '),
        const RegExpCaptureValueSource(
          extractorId: 'payment',
          captureName: 'amount',
        ),
        const LiteralValueSource('!'),
      ]);

      expect(source.resolve(context), 'Amount: 12.50!');
      expect(
        ComposedValueSource(<ValueSource>[
          const LiteralValueSource('Amount: '),
          const RegExpCaptureValueSource(
            extractorId: 'payment',
            captureName: 'missing',
          ),
          const LiteralValueSource('!'),
        ]).resolve(context),
        isNull,
      );
    });

    test('guards invalid composition shape and resolved length', () {
      expect(
        () => ComposedValueSource(const <ValueSource>[]),
        throwsFormatException,
      );
      expect(
        () => ComposedValueSource(<ValueSource>[
          ComposedValueSource(const <ValueSource>[
            LiteralValueSource('nested'),
          ]),
        ]),
        throwsFormatException,
      );
      expect(
        () => ComposedValueSource(
          List<ValueSource>.filled(
            ComposedValueSource.maxParts + 1,
            const LiteralValueSource('part'),
          ),
        ),
        throwsFormatException,
      );
      expect(
        () => ComposedValueSource(<ValueSource>[
          LiteralValueSource(
            List<String>.filled(
              ComposedValueSource.maxResolvedLength + 1,
              'x',
            ).join(),
          ),
        ]),
        throwsFormatException,
      );
      final EvaluationContext oversizedContext = EvaluationContext(
        notification: notification,
        extractionResults: <String, RegExpEvaluationResult>{
          'large': RegExpEvaluationResult(
            hasMatches: true,
            namedCaptures: <String, List<String>>{
              'value': <String>[
                List<String>.filled(
                  ComposedValueSource.maxResolvedLength + 1,
                  'x',
                ).join(),
              ],
            },
          ),
        },
      );
      expect(
        ComposedValueSource(const <ValueSource>[
          RegExpCaptureValueSource(extractorId: 'large', captureName: 'value'),
        ]).resolve(oversizedContext),
        isNull,
      );
    });
  });
}
