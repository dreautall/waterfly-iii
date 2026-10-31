import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/definitions/notification_definition_preset_factory.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
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
}
