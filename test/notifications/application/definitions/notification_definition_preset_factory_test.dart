import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/definitions/notification_definition_preset_factory.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/normalized_amount_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';

void main() {
  const NotificationDefinitionPresetFactory factory =
      NotificationDefinitionPresetFactory();

  test('creates the standard basic definition preset', () {
    final List<RegExpDefinition> extractors = factory.basicExtractors();
    final NotificationRule rule = factory.standardTransactionRule(
      extractors,
      includeNotificationText: true,
    );

    expect(
      extractors.map((RegExpDefinition item) => item.predefinedType),
      PredefinedRegExpDefinition.values,
    );
    expect(rule.isPredefined, isTrue);
    expect(
      rule.actions.whereType<SetTransactionFieldAction>().map(
        (SetTransactionFieldAction action) => action.target,
      ),
      <TransactionField>[
        TransactionField.title,
        TransactionField.amount,
        TransactionField.date,
        TransactionField.time,
        TransactionField.notes,
      ],
    );
    final List<SetTransactionFieldAction> actions = rule.actions
        .whereType<SetTransactionFieldAction>()
        .toList();
    final RegExpDefinition titleExtractor = extractors.firstWhere(
      (RegExpDefinition extractor) =>
          extractor.predefinedType ==
          PredefinedRegExpDefinition.notificationTitle,
    );
    final RegExpDefinition messageExtractor = extractors.firstWhere(
      (RegExpDefinition extractor) =>
          extractor.predefinedType ==
          PredefinedRegExpDefinition.notificationMessage,
    );
    expect(
      actions.first.valueSource,
      isA<RegExpCaptureValueSource>()
          .having(
            (RegExpCaptureValueSource source) => source.extractorId,
            'extractorId',
            titleExtractor.id,
          )
          .having(
            (RegExpCaptureValueSource source) => source.captureName,
            'captureName',
            'title',
          ),
    );
    expect(
      actions[1].valueSource,
      isA<NormalizedAmountCaptureValueSource>().having(
        (NormalizedAmountCaptureValueSource source) =>
            source.capture.captureName,
        'captureName',
        'amount',
      ),
    );
    expect(
      actions.last.valueSource,
      isA<RegExpCaptureValueSource>()
          .having(
            (RegExpCaptureValueSource source) => source.extractorId,
            'extractorId',
            messageExtractor.id,
          )
          .having(
            (RegExpCaptureValueSource source) => source.captureName,
            'captureName',
            'message',
          ),
    );
  });

  test('normalizes grouped decimal amounts captured by the Basic preset', () {
    final List<RegExpDefinition> extractors = factory.basicExtractors();
    final NotificationRule rule = factory.standardTransactionRule(extractors);
    final NotificationContext notification = NotificationContext(
      title: 'Card payment',
      body: 'Paid 1 234,56 EUR',
      receivedAt: DateTime(2026, 10, 31),
    );
    final EvaluationContext context = EvaluationContext(
      notification: notification,
      extractionResults: <String, RegExpEvaluationResult>{
        for (final RegExpDefinition extractor in extractors)
          extractor.id: extractor.evaluate(notification),
      },
    );
    final SetTransactionFieldAction amountAction = rule.actions
        .whereType<SetTransactionFieldAction>()
        .singleWhere(
          (SetTransactionFieldAction action) =>
              action.target == TransactionField.amount,
        );

    expect(
      amountAction.evaluate(context).patch?.values[TransactionField.amount],
      '1234.56',
    );
  });
}
