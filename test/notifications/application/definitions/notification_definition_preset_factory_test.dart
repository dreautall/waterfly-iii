import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/definitions/notification_definition_preset_factory.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';

void main() {
  const NotificationDefinitionPresetFactory factory =
      NotificationDefinitionPresetFactory();

  test('creates the standard basic definition preset', () {
    final List<RegExpDefinition> extractors = factory.basicExtractors();
    final NotificationRule rule = factory.standardTransactionRule(extractors);

    expect(
      extractors.map((RegExpDefinition item) => item.predefinedType),
      PredefinedRegExpDefinition.values,
    );
    expect(rule.isPredefined, isTrue);
    expect(rule.actions, hasLength(3));
  });
}
