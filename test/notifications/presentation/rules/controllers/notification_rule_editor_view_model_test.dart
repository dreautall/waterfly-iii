import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_tags_action.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/value_exists_condition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_sample.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_action_group.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/literal_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';
import 'package:waterflyiii/notifications/presentation/rules/controllers/notification_rule_editor_view_model.dart';

void main() {
  test('tracks name and test-mode changes in the rule draft', () {
    final NotificationRuleEditorViewModel viewModel =
        NotificationRuleEditorViewModel(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Original',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12.50 CAD',
            receivedAt: DateTime(2026, 9, 8),
          ),
          isTestMode: false,
        );

    viewModel.updateName('Updated');
    viewModel.updateDescription('Handles payment notifications.');
    viewModel.toggleTestMode();

    expect(viewModel.currentRule.name, 'Updated');
    expect(viewModel.currentRule.description, 'Handles payment notifications.');
    expect(viewModel.isDirty, isTrue);
    expect(viewModel.isTestMode, isTrue);
  });

  test('updates condition and action collections through typed commands', () {
    final NotificationRuleEditorViewModel viewModel =
        NotificationRuleEditorViewModel(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Original',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12.50 CAD',
            receivedAt: DateTime(2026, 9, 8),
          ),
          isTestMode: false,
        );
    const ValueExistsCondition firstCondition = ValueExistsCondition(
      LiteralValueSource('first'),
    );
    const ValueExistsCondition secondCondition = ValueExistsCondition(
      LiteralValueSource('second'),
    );
    const SetTransactionTagsAction firstAction = SetTransactionTagsAction(
      <String>['first'],
    );
    const SetTransactionTagsAction secondAction = SetTransactionTagsAction(
      <String>['second'],
    );

    viewModel
      ..addCondition(firstCondition)
      ..replaceConditionAt(0, secondCondition)
      ..replaceConditions(<NotificationCondition>[
        firstCondition,
        secondCondition,
      ])
      ..removeConditionAt(0)
      ..addAction(firstAction)
      ..replaceActionAt(0, secondAction);

    expect(viewModel.currentRule.conditions, <NotificationCondition>[
      secondCondition,
    ]);
    expect(viewModel.currentRule.actions, <NotificationAction>[secondAction]);

    viewModel.removeActionAt(0);

    expect(viewModel.currentRule.actions, isEmpty);
    expect(viewModel.isDirty, isTrue);
  });

  test('adding and removing a condition restores a clean draft', () {
    final NotificationRuleEditorViewModel viewModel =
        NotificationRuleEditorViewModel(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Original',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12.50 CAD',
            receivedAt: DateTime(2026, 9, 8),
          ),
          isTestMode: false,
        );

    viewModel.replaceConditions(<NotificationCondition>[
      const ValueExistsCondition(LiteralValueSource('temporary')),
    ]);
    expect(viewModel.isDirty, isTrue);

    viewModel.removeConditionAt(0);

    expect(viewModel.currentRule.conditions, isEmpty);
    expect(viewModel.isDirty, isFalse);
  });

  test('adding and removing an action restores a clean draft', () {
    final NotificationRuleEditorViewModel viewModel =
        NotificationRuleEditorViewModel(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Original',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12.50 CAD',
            receivedAt: DateTime(2026, 9, 8),
          ),
          isTestMode: false,
        );

    viewModel.addAction(const SetTransactionTagsAction(<String>['temporary']));
    expect(viewModel.isDirty, isTrue);

    viewModel.removeActionAt(0);

    expect(viewModel.currentRule.actions, isEmpty);
    expect(viewModel.isDirty, isFalse);
  });

  test('adds, reorders, edits, and removes conditional action groups', () {
    const NotificationActionGroup first = NotificationActionGroup(
      id: 'first',
      name: 'First',
      conditions: <NotificationCondition>[
        ValueExistsCondition(LiteralValueSource('first')),
      ],
      actions: <NotificationAction>[
        SetTransactionTagsAction(<String>['first']),
      ],
    );
    const NotificationActionGroup second = NotificationActionGroup(
      id: 'second',
      name: 'Second',
      conditions: <NotificationCondition>[
        ValueExistsCondition(LiteralValueSource('second')),
      ],
      actions: <NotificationAction>[
        SetTransactionTagsAction(<String>['second']),
      ],
    );
    final NotificationRuleEditorViewModel viewModel =
        NotificationRuleEditorViewModel(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Original',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12.50 CAD',
            receivedAt: DateTime(2026, 9, 8),
          ),
          isTestMode: false,
        );

    viewModel
      ..addConditionalActionGroup(first)
      ..addConditionalActionGroup(second)
      ..moveConditionalActionGroup(1, 0)
      ..replaceConditionalActionGroup(first.copyWith(name: 'Updated first'));

    expect(
      viewModel.conditionalActionGroups.map(
        (NotificationActionGroup group) => group.name,
      ),
      <String>['Second', 'Updated first'],
    );

    viewModel
      ..removeConditionalActionGroup(second.id)
      ..removeConditionalActionGroup(first.id);

    expect(viewModel.conditionalActionGroups, isEmpty);
    expect(viewModel.isDirty, isFalse);
  });

  test('duplicates a conditional action group after the source', () {
    const NotificationActionGroup first = NotificationActionGroup(
      id: 'first',
      name: 'First',
      conditions: <NotificationCondition>[
        ValueExistsCondition(LiteralValueSource('first')),
      ],
      actions: <NotificationAction>[
        SetTransactionTagsAction(<String>['first']),
      ],
    );
    const NotificationActionGroup second = NotificationActionGroup(
      id: 'second',
      name: 'Second',
      conditions: <NotificationCondition>[],
      actions: <NotificationAction>[],
    );
    final NotificationRuleEditorViewModel viewModel =
        NotificationRuleEditorViewModel(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Original',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
            conditionalActionGroups: <NotificationActionGroup>[first, second],
          ),
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12.50 CAD',
            receivedAt: DateTime(2026, 9, 8),
          ),
          isTestMode: false,
        );

    final NotificationActionGroup duplicate = viewModel
        .duplicateConditionalActionGroup(first);

    expect(
      viewModel.conditionalActionGroups.map(
        (NotificationActionGroup group) => group.id,
      ),
      <String>[first.id, duplicate.id, second.id],
    );
    expect(duplicate.id, isNot(first.id));
    expect(duplicate.name, first.name);
    expect(duplicate.conditions, isNot(same(first.conditions)));
    expect(duplicate.conditions.single, isNot(same(first.conditions.single)));
    expect(duplicate.actions, isNot(same(first.actions)));
    expect(duplicate.actions.single, isNot(same(first.actions.single)));
    expect(viewModel.isDirty, isTrue);
  });

  test('removing an optional action clears its orphaned review state', () {
    final NotificationRuleEditorViewModel viewModel =
        NotificationRuleEditorViewModel(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Original',
            isPredefined: true,
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12.50 CAD',
            receivedAt: DateTime(2026, 9, 8),
          ),
          isTestMode: false,
        );

    viewModel
      ..addAction(
        const SetTransactionFieldAction(
          target: TransactionField.notes,
          valueSource: LiteralValueSource('temporary'),
        ),
      )
      ..setPredefinedFieldReviewed(TransactionField.notes, true);
    expect(viewModel.isDirty, isTrue);

    viewModel.removeActionAt(0);

    expect(viewModel.currentRule.actions, isEmpty);
    expect(viewModel.reviewedPredefinedFields, isEmpty);
    expect(viewModel.isDirty, isFalse);
  });

  test('tracks predefined review and test notification changes', () {
    final NotificationRuleEditorViewModel viewModel =
        NotificationRuleEditorViewModel(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Original',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12.50 CAD',
            receivedAt: DateTime(2026, 9, 8),
          ),
          isTestMode: false,
        );
    final NotificationContext updatedContext = NotificationContext(
      title: 'Cash withdrawal',
      body: 'Withdrew 20 CAD',
      receivedAt: DateTime(2026, 9, 9),
    );

    viewModel
      ..setPredefinedFieldReviewed(TransactionField.amount, true)
      ..updateTestNotificationContext(updatedContext);

    expect(viewModel.reviewedPredefinedFields, <TransactionField>{
      TransactionField.amount,
    });
    expect(viewModel.testNotificationContext, updatedContext);

    viewModel.setPredefinedFieldReviewed(TransactionField.amount, false);

    expect(viewModel.reviewedPredefinedFields, isEmpty);
  });

  test('tracks sample override edits and clears in the rule draft', () {
    final NotificationSample originalSample = NotificationSample(
      title: 'Card payment',
      body: 'Paid 12.50 CAD',
      receivedAt: DateTime(2026, 9, 8),
    );
    final NotificationRuleEditorViewModel viewModel =
        NotificationRuleEditorViewModel(
          rule: NotificationRule(
            id: 'rule',
            name: 'Original',
            conditions: const <NotificationCondition>[],
            actions: const <NotificationAction>[],
            sampleOverride: originalSample,
          ),
          notificationContext: NotificationContext(
            title: originalSample.title,
            body: originalSample.body,
            receivedAt: originalSample.receivedAt,
          ),
          isTestMode: false,
        );
    final NotificationSample updatedSample = NotificationSample(
      title: 'Cash withdrawal',
      body: 'Withdrew 20 CAD',
      receivedAt: DateTime(2026, 9, 9),
    );

    expect(viewModel.isDirty, isFalse);

    viewModel.updateSampleOverride(updatedSample);

    expect(viewModel.isDirty, isTrue);
    expect(viewModel.currentRule.sampleOverride, updatedSample);

    viewModel.updateSampleOverride(originalSample);

    expect(viewModel.isDirty, isFalse);

    viewModel.clearSampleOverride();

    expect(viewModel.isDirty, isTrue);
    expect(viewModel.currentRule.sampleOverride, isNull);
  });

  test('switches sample context and test context through sample commands', () {
    final NotificationContext notificationContext = NotificationContext(
      applicationId: 'app',
      title: 'Received sample',
      body: 'Received body',
      receivedAt: DateTime(2026, 9, 8),
    );
    final NotificationContext definitionSampleContext = NotificationContext(
      applicationId: 'app',
      title: 'Definition sample',
      body: 'Definition body',
      receivedAt: DateTime(2026, 9, 7),
    );
    final NotificationRuleEditorViewModel viewModel =
        NotificationRuleEditorViewModel(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Original',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
          notificationContext: notificationContext,
          definitionSampleContext: definitionSampleContext,
          isTestMode: false,
        );
    final NotificationSample override = NotificationSample(
      title: 'Edited sample',
      body: 'Edited body',
      receivedAt: DateTime(2026, 9, 9),
    );

    viewModel.updateSampleOverride(override);

    expect(viewModel.usesDefinitionSample, isFalse);
    expect(viewModel.sampleNotificationContext.title, 'Edited sample');
    expect(viewModel.testNotificationContext.title, 'Edited sample');
    expect(viewModel.testNotificationContext.body, 'Edited body');

    viewModel.clearSampleOverride();

    expect(viewModel.usesDefinitionSample, isTrue);
    expect(viewModel.sampleNotificationContext, definitionSampleContext);
    expect(
      viewModel.testNotificationContext.title,
      definitionSampleContext.title,
    );
    expect(
      viewModel.testNotificationContext.body,
      definitionSampleContext.body,
    );
  });

  test('moves, duplicates, and clones conditions through commands', () {
    const ValueExistsCondition first = ValueExistsCondition(
      LiteralValueSource('first'),
    );
    const ValueExistsCondition second = ValueExistsCondition(
      LiteralValueSource('second'),
    );
    final NotificationRuleEditorViewModel viewModel =
        NotificationRuleEditorViewModel(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Original',
            conditions: <NotificationCondition>[first, second],
            actions: <NotificationAction>[],
          ),
          notificationContext: NotificationContext(
            title: 'Sample',
            body: 'Body',
            receivedAt: DateTime(2026, 9, 8),
          ),
          isTestMode: false,
        );

    viewModel
      ..moveCondition(1, 0)
      ..duplicateConditionAt(0);

    expect(
      viewModel.conditions
          .map((NotificationCondition condition) => condition.toJson())
          .toList(),
      <Map<String, dynamic>>[second.toJson(), second.toJson(), first.toJson()],
    );
    expect(viewModel.conditions[0], isNot(same(viewModel.conditions[1])));
    expect(viewModel.isDirty, isTrue);
  });

  test('removes a tag through the typed action command', () {
    final NotificationRuleEditorViewModel viewModel =
        NotificationRuleEditorViewModel(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Original',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[
              SetTransactionTagsAction(<String>['one', 'two']),
            ],
          ),
          notificationContext: NotificationContext(
            title: 'Sample',
            body: 'Body',
            receivedAt: DateTime(2026, 9, 8),
          ),
          isTestMode: false,
        );

    viewModel.removeTagFromAction(0, 'one');

    expect(
      (viewModel.actions.single as SetTransactionTagsAction).tags,
      <String>['two'],
    );
  });

  test('exposes immutable collection snapshots', () {
    final NotificationRuleEditorViewModel viewModel =
        NotificationRuleEditorViewModel(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Original',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12.50 CAD',
            receivedAt: DateTime(2026, 9, 8),
          ),
          isTestMode: false,
        );

    expect(
      () => viewModel.conditions.add(
        const ValueExistsCondition(LiteralValueSource('value')),
      ),
      throwsUnsupportedError,
    );
    expect(
      () => viewModel.reviewedPredefinedFields.add(TransactionField.amount),
      throwsUnsupportedError,
    );
  });

  test('creates optional predefined actions from matching extractors', () {
    final NotificationRuleEditorViewModel viewModel =
        NotificationRuleEditorViewModel(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Original',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12.50 CAD',
            receivedAt: DateTime(2026, 9, 8),
          ),
          isTestMode: false,
        );
    final RegExpDefinition currency =
        RegExpDefinition.createPredefinedRegExpDefinition(
          PredefinedRegExpDefinition.currency,
        );
    final RegExpDefinition title =
        RegExpDefinition.createPredefinedRegExpDefinition(
          PredefinedRegExpDefinition.notificationTitle,
        );
    final RegExpDefinition message =
        RegExpDefinition.createPredefinedRegExpDefinition(
          PredefinedRegExpDefinition.notificationMessage,
        );

    viewModel
      ..addOptionalPredefinedAction(
        field: TransactionField.currency,
        extractors: <RegExpDefinition>[currency, title, message],
      )
      ..addOptionalPredefinedAction(
        field: TransactionField.title,
        extractors: <RegExpDefinition>[currency, title, message],
      )
      ..addOptionalPredefinedAction(
        field: TransactionField.notes,
        extractors: <RegExpDefinition>[currency, title, message],
      );

    final List<SetTransactionFieldAction> actions = viewModel.actions
        .whereType<SetTransactionFieldAction>()
        .toList();
    final RegExpCaptureValueSource currencyCapture =
        actions[0].valueSource as RegExpCaptureValueSource;
    final RegExpCaptureValueSource titleCapture =
        actions[1].valueSource as RegExpCaptureValueSource;
    final RegExpCaptureValueSource notesCapture =
        actions[2].valueSource as RegExpCaptureValueSource;

    expect(
      actions.map((SetTransactionFieldAction action) => action.target),
      <TransactionField>[
        TransactionField.currency,
        TransactionField.title,
        TransactionField.notes,
      ],
    );
    expect(currencyCapture.extractorId, currency.id);
    expect(currencyCapture.captureName, 'postCurrency');
    expect(titleCapture.extractorId, title.id);
    expect(titleCapture.captureName, 'title');
    expect(notesCapture.extractorId, message.id);
    expect(notesCapture.captureName, 'message');
  });

  test('prepares immutable requirement availability for the section', () {
    final RegExpDefinition extractor =
        RegExpDefinition.createCustomRegExpDefinition(
          'Amount',
          r'Paid (?<amount>\d+)',
        );
    final NotificationRuleEditorViewModel viewModel =
        NotificationRuleEditorViewModel(
          rule: NotificationRule(
            id: 'rule',
            name: 'Original',
            conditions: const <NotificationCondition>[],
            actions: <NotificationAction>[
              SetTransactionFieldAction(
                target: TransactionField.amount,
                valueSource: RegExpCaptureValueSource(
                  extractorId: extractor.id,
                  captureName: 'amount',
                ),
              ),
            ],
          ),
          notificationContext: NotificationContext(
            title: 'Payment',
            body: 'Paid 12',
            receivedAt: DateTime(2026, 9, 8),
          ),
          isTestMode: false,
        );

    final List<NotificationRuleRequirementGroup> groups = viewModel
        .requirementGroups(<RegExpDefinition>[extractor]);

    expect(groups, hasLength(1));
    expect(groups.single.extractor, extractor);
    expect(groups.single.available, isTrue);
    expect(
      () => groups.add(
        const NotificationRuleRequirementGroup(
          extractor: null,
          available: false,
        ),
      ),
      throwsUnsupportedError,
    );
  });
}
