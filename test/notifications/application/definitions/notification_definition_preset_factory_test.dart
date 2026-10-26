import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/definitions/notification_definition_preset_factory.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/notification_property_value_source.dart';

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
    expect(
      rule.actions.whereType<SetTransactionFieldAction>().first.valueSource,
      isA<NotificationPropertyValueSource>(),
    );
  });
}
