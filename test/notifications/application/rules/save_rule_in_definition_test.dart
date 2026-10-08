import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/rules/save_rule_in_definition.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import '../../support/in_memory_notification_stores.dart';

void main() {
  NotificationDefinition definitionWith(NotificationRule rule) =>
      NotificationDefinition(
        id: 'definition',
        applicationId: 'com.example.bank',
        name: 'Example Bank',
        extractors: const <RegExpDefinition>[],
        rules: <NotificationRule>[rule],
      );
  const NotificationRule original = NotificationRule(
    id: 'rule',
    name: 'Original',
    conditions: <NotificationCondition>[],
    actions: <NotificationAction>[],
  );

  test(
    'adds, updates, and deletes a rule without dropping definition fields',
    () async {
      final InMemoryNotificationDefinitionStore store =
          InMemoryNotificationDefinitionStore(<NotificationDefinition>[
            definitionWith(original),
          ]);
      final SaveRuleInDefinition workflow = SaveRuleInDefinition(store);
      const NotificationRule added = NotificationRule(
        id: 'added',
        name: 'Added',
        conditions: <NotificationCondition>[],
        actions: <NotificationAction>[],
      );
      const NotificationRule updated = NotificationRule(
        id: 'rule',
        name: 'Updated',
        conditions: <NotificationCondition>[],
        actions: <NotificationAction>[],
      );

      expect(
        (await workflow.add(definitionId: 'definition', rule: added)).succeeded,
        isTrue,
      );
      expect(store.definitions.single.rules, <NotificationRule>[
        original,
        added,
      ]);
      expect(
        (await workflow.update(
          definitionId: 'definition',
          originalRuleId: original.id,
          rule: updated,
        )).succeeded,
        isTrue,
      );
      expect(store.definitions.single.rules, <NotificationRule>[
        updated,
        added,
      ]);
      expect(
        (await workflow.delete(
          definitionId: 'definition',
          ruleId: added.id,
        )).succeeded,
        isTrue,
      );
      expect(store.definitions.single.rules, <NotificationRule>[updated]);
    },
  );

  test('reports a missing definition without saving', () async {
    final SaveRuleInDefinition workflow = SaveRuleInDefinition(
      InMemoryNotificationDefinitionStore(<NotificationDefinition>[]),
    );

    final SaveRuleInDefinitionResult result = await workflow.add(
      definitionId: 'missing',
      rule: original,
    );

    expect(result.status, SaveRuleInDefinitionStatus.definitionNotFound);
  });

  test('preserves definition persistence failures', () async {
    final SaveRuleInDefinitionResult result = await SaveRuleInDefinition(
      _FailingDefinitionStore(),
    ).add(definitionId: 'definition', rule: original);

    expect(result.status, SaveRuleInDefinitionStatus.failed);
    expect(result.error, isA<StateError>());
    expect(result.stackTrace, isNotNull);
  });
}

class _FailingDefinitionStore extends InMemoryNotificationDefinitionStore {
  @override
  Future<List<NotificationDefinition>> load() =>
      Future<List<NotificationDefinition>>.error(
        StateError('Could not load definitions'),
      );
}
