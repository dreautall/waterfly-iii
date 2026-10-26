import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/domain/actions/action_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_formatting_preferences.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/firefly_resource_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/composed_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/currency_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/date_time_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/literal_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/value_source.dart';

void main() {
  final EvaluationContext context = EvaluationContext(
    notification: NotificationContext(
      title: 'Card payment',
      body: 'Paid 12.50 CAD at Market',
      receivedAt: DateTime(2026, 8, 27),
    ),
    extractionResults: const <String, RegExpEvaluationResult>{},
  );

  group('SetTransactionFieldAction', () {
    // Verifies resolved values become a patch for exactly the requested field,
    // avoiding accidental changes to unrelated transaction properties.
    test('produces a patch when its source resolves', () {
      const SetTransactionFieldAction action = SetTransactionFieldAction(
        target: TransactionField.category,
        valueSource: LiteralValueSource('Groceries'),
      );

      final ActionEvaluationResult result = action.evaluate(context);

      expect(result.succeeded, isTrue);
      expect(result.patch?.values, <TransactionField, String>{
        TransactionField.category: 'Groceries',
      });
    });

    test('formats date-time captures used as transaction text', () {
      final EvaluationContext dateTimeContext = EvaluationContext(
        notification: context.notification,
        dateTimeExtractorIds: const <String>{'notification-date'},
        formattingPreferences: const NotificationFormattingPreferences(
          locale: 'en_US',
          use24HourFormat: true,
        ),
        extractionResults: const <String, RegExpEvaluationResult>{
          'notification-date': RegExpEvaluationResult(
            hasMatches: true,
            namedCaptures: <String, List<String>>{
              'date': <String>['1969-12-31T16:00:22.000'],
            },
          ),
        },
      );
      const RegExpCaptureValueSource capture = RegExpCaptureValueSource(
        extractorId: 'notification-date',
        captureName: 'date',
      );

      expect(
        const SetTransactionFieldAction(
          target: TransactionField.title,
          valueSource: capture,
        ).evaluate(dateTimeContext).patch?.values[TransactionField.title],
        '12/31/1969 16:00',
      );
      expect(
        SetTransactionFieldAction(
          target: TransactionField.notes,
          valueSource: ComposedValueSource(<ValueSource>[
            const LiteralValueSource('Received '),
            capture,
          ]),
        ).evaluate(dateTimeContext).patch?.values[TransactionField.notes],
        'Received 12/31/1969 16:00',
      );
      expect(capture.resolve(dateTimeContext), '1969-12-31T16:00:22.000');
    });

    // Verifies unresolved captures are explicit failures, enabling the
    // processor to report a repairable action diagnostic.
    test('fails without producing a patch when its source is unresolved', () {
      const SetTransactionFieldAction action = SetTransactionFieldAction(
        target: TransactionField.amount,
        valueSource: RegExpCaptureValueSource(
          extractorId: 'payment',
          captureName: 'amount',
        ),
      );

      final ActionEvaluationResult result = action.evaluate(context);

      expect(result.succeeded, isFalse);
      expect(result.patch, isNull);
      expect(
        result.failureReason,
        'Could not set amount: capture "amount" from extractor "payment" '
        'did not resolve.',
      );
    });

    test('uses the extractor display name in an unresolved capture failure', () {
      final EvaluationContext namedContext = EvaluationContext(
        notification: context.notification,
        extractionResults: const <String, RegExpEvaluationResult>{},
        extractorNames: const <String, String>{'payment-id': 'Payment amount'},
      );
      const SetTransactionFieldAction action = SetTransactionFieldAction(
        target: TransactionField.amount,
        valueSource: RegExpCaptureValueSource(
          extractorId: 'payment-id',
          captureName: 'amount',
        ),
      );

      expect(
        action.evaluate(namedContext).failureReason,
        'Could not set amount: capture "amount" from extractor "Payment amount" '
        'did not resolve.',
      );
    });

    test('resolves the selected extractor match occurrence', () {
      final EvaluationContext captureContext = EvaluationContext(
        notification: context.notification,
        extractionResults: const <String, RegExpEvaluationResult>{
          'payment': RegExpEvaluationResult(
            hasMatches: true,
            namedCaptures: <String, List<String>>{
              'amount': <String>['12.50', '20.00'],
            },
          ),
        },
      );
      const SetTransactionFieldAction action = SetTransactionFieldAction(
        target: TransactionField.amount,
        valueSource: RegExpCaptureValueSource(
          extractorId: 'payment',
          captureName: 'amount',
          matchIndex: 1,
        ),
      );

      expect(
        action.evaluate(captureContext).patch?.values[TransactionField.amount],
        '20.00',
      );
    });

    test('rejects an invalid amount literal', () {
      const SetTransactionFieldAction action = SetTransactionFieldAction(
        target: TransactionField.amount,
        valueSource: LiteralValueSource('twelve dollars'),
      );

      final ActionEvaluationResult result = action.evaluate(context);

      expect(result.succeeded, isFalse);
      expect(
        result.failureReason,
        TransactionFieldValidationError.invalidAmount.name,
      );
    });

    test('accepts built text only for text transaction fields', () {
      final ComposedValueSource source = ComposedValueSource(
        const <LiteralValueSource>[
          LiteralValueSource('Card'),
          LiteralValueSource(' payment'),
        ],
      );
      expect(
        SetTransactionFieldAction(
          target: TransactionField.title,
          valueSource: source,
        ).evaluate(context).patch?.values[TransactionField.title],
        'Card payment',
      );
      expect(
        SetTransactionFieldAction(
          target: TransactionField.amount,
          valueSource: source,
        ).evaluate(context).failureReason,
        'Built text can only set the title or notes field.',
      );
    });

    test('rejects non-finite amount literals', () {
      const SetTransactionFieldAction action = SetTransactionFieldAction(
        target: TransactionField.amount,
        valueSource: LiteralValueSource('NaN'),
      );

      expect(
        action.evaluate(context).failureReason,
        TransactionFieldValidationError.invalidAmount.name,
      );
    });

    test('accepts a matching Firefly resource selection', () {
      const SetTransactionFieldAction action = SetTransactionFieldAction(
        target: TransactionField.category,
        valueSource: FireflyResourceValueSource(
          resourceKind: FireflyResourceKind.category,
          resourceId: '42',
        ),
      );

      final ActionEvaluationResult result = action.evaluate(context);

      expect(result.succeeded, isTrue);
      expect(result.patch?.values[TransactionField.category], '42');
      expect(
        result.patch?.resourceReferences[TransactionField.category]?.id,
        '42',
      );
    });

    test('maps a captured currency to the selected Firefly currency', () {
      final EvaluationContext currencyContext = EvaluationContext(
        notification: context.notification,
        extractionResults: const <String, RegExpEvaluationResult>{
          'currency': RegExpEvaluationResult(
            hasMatches: true,
            namedCaptures: <String, List<String>>{
              'currency': <String>['CAD'],
            },
          ),
        },
      );
      const SetTransactionFieldAction action = SetTransactionFieldAction(
        target: TransactionField.currency,
        valueSource: CurrencyCaptureValueSource(
          capture: RegExpCaptureValueSource(
            extractorId: 'currency',
            captureName: 'currency',
          ),
          resourceId: '4',
          expectedValue: 'CAD',
        ),
      );

      final ActionEvaluationResult result = action.evaluate(currencyContext);

      expect(result.succeeded, isTrue);
      expect(result.patch?.values[TransactionField.currency], '4');
      expect(
        result.patch?.resourceReferences[TransactionField.currency]?.id,
        '4',
      );

      final SetTransactionFieldAction restored =
          NotificationAction.fromJson(
                jsonDecode(jsonEncode(action)) as Map<String, dynamic>,
              )
              as SetTransactionFieldAction;
      expect(restored.valueSource, isA<CurrencyCaptureValueSource>());
      expect(restored.valueSource.resolve(currencyContext), '4');
      expect(
        restored.valueSource.resolve(
          EvaluationContext(
            notification: context.notification,
            extractionResults: const <String, RegExpEvaluationResult>{
              'currency': RegExpEvaluationResult(
                hasMatches: true,
                namedCaptures: <String, List<String>>{
                  'currency': <String>['USD'],
                },
              ),
            },
          ),
        ),
        isNull,
      );
    });

    test(
      'normalizes a captured date only when the selected capture resolves',
      () {
        final EvaluationContext dateContext = EvaluationContext(
          notification: context.notification,
          extractionResults: const <String, RegExpEvaluationResult>{
            'date': RegExpEvaluationResult(
              hasMatches: true,
              namedCaptures: <String, List<String>>{
                'date': <String>['27 Aug 2026'],
              },
            ),
          },
        );
        const SetTransactionFieldAction action = SetTransactionFieldAction(
          target: TransactionField.date,
          valueSource: DateTimeCaptureValueSource(
            capture: RegExpCaptureValueSource(
              extractorId: 'date',
              captureName: 'date',
            ),
            field: TransactionField.date,
            normalizedValue: '2026-08-27',
          ),
        );

        expect(
          action.evaluate(dateContext).patch?.values[TransactionField.date],
          '2026-08-27',
        );
        expect(action.evaluate(context).succeeded, isFalse);

        final SetTransactionFieldAction restored =
            NotificationAction.fromJson(
                  jsonDecode(jsonEncode(action)) as Map<String, dynamic>,
                )
                as SetTransactionFieldAction;
        expect(restored.valueSource, isA<DateTimeCaptureValueSource>());
      },
    );

    test('derives date and time from a captured notification timestamp', () {
      final EvaluationContext dateTimeContext = EvaluationContext(
        notification: context.notification,
        extractionResults: const <String, RegExpEvaluationResult>{
          'notification-date-time': RegExpEvaluationResult(
            hasMatches: true,
            namedCaptures: <String, List<String>>{
              'dateTime': <String>['2026-09-01T10:22:14.152812'],
            },
          ),
        },
      );
      const RegExpCaptureValueSource capture = RegExpCaptureValueSource(
        extractorId: 'notification-date-time',
        captureName: 'dateTime',
      );
      const SetTransactionFieldAction dateAction = SetTransactionFieldAction(
        target: TransactionField.date,
        valueSource: DateTimeCaptureValueSource(
          capture: capture,
          field: TransactionField.date,
          normalizedValue: '',
          deriveFromCapture: true,
        ),
      );
      const SetTransactionFieldAction timeAction = SetTransactionFieldAction(
        target: TransactionField.time,
        valueSource: DateTimeCaptureValueSource(
          capture: capture,
          field: TransactionField.time,
          normalizedValue: '',
          deriveFromCapture: true,
        ),
      );

      expect(
        dateAction
            .evaluate(dateTimeContext)
            .patch
            ?.values[TransactionField.date],
        '2026-09-01',
      );
      expect(
        timeAction
            .evaluate(dateTimeContext)
            .patch
            ?.values[TransactionField.time],
        '10:22:14',
      );

      final SetTransactionFieldAction restored =
          NotificationAction.fromJson(
                jsonDecode(jsonEncode(timeAction)) as Map<String, dynamic>,
              )
              as SetTransactionFieldAction;
      expect(
        (restored.valueSource as DateTimeCaptureValueSource).deriveFromCapture,
        isTrue,
      );
    });

    test('rejects a normalized capture for a different transaction field', () {
      const SetTransactionFieldAction action = SetTransactionFieldAction(
        target: TransactionField.time,
        valueSource: DateTimeCaptureValueSource(
          capture: RegExpCaptureValueSource(
            extractorId: 'date',
            captureName: 'date',
          ),
          field: TransactionField.date,
          normalizedValue: '2026-08-27',
        ),
      );

      expect(
        action.evaluate(context).failureReason,
        'A normalized date or time capture can only set its matching field.',
      );
    });

    // Confirms field actions and their value sources survive persistence so
    // restored definitions retain executable behavior.
    test('round-trips through JSON', () {
      const SetTransactionFieldAction action = SetTransactionFieldAction(
        target: TransactionField.notes,
        valueSource: LiteralValueSource('Imported from notification'),
      );

      final Map<String, dynamic> decoded =
          jsonDecode(jsonEncode(action)) as Map<String, dynamic>;
      final SetTransactionFieldAction restored =
          NotificationAction.fromJson(decoded) as SetTransactionFieldAction;

      expect(restored.target, TransactionField.notes);
      expect(
        restored.valueSource.resolve(context),
        'Imported from notification',
      );
    });
  });
}
