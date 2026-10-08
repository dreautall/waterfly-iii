import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';
import 'package:waterflyiii/notifications/presentation/definitions/controllers/notification_definition_editor_view_model.dart';

void main() {
  const NotificationDefinition definition = NotificationDefinition(
    id: 'definition',
    applicationId: 'com.example.bank',
    name: 'Example Bank',
    extractors: <RegExpDefinition>[],
    rules: <NotificationRule>[],
  );

  test('marks a persisted definition as saved', () async {
    final NotificationDefinitionEditorViewModel viewModel =
        NotificationDefinitionEditorViewModel(definition);

    final NotificationDefinitionSaveResult result = await viewModel.save(
      sampleTitle: 'Card payment',
      sampleBody: 'Paid 12.50 CAD',
      persist: (NotificationDefinition updated) async => true,
    );

    expect(result.succeeded, isTrue);
    expect(viewModel.isSaving, isFalse);
    expect(viewModel.isDirty, isFalse);
  });

  test(
    'acknowledges migration review only after persistence succeeds',
    () async {
      final NotificationDefinitionEditorViewModel viewModel =
          NotificationDefinitionEditorViewModel(
            definition.copyWith(
              requiresMigrationReview: true,
              migrationReviewIssues: const <NotificationMigrationIssue>{
                NotificationMigrationIssue.currencyUnresolved,
              },
            ),
          );
      NotificationDefinition? persisted;

      final NotificationDefinitionSaveResult result = await viewModel.save(
        sampleTitle: 'Card payment',
        sampleBody: 'Paid 12.50 CAD',
        persist: (NotificationDefinition updated) async {
          persisted = updated;
          return true;
        },
      );

      expect(result.succeeded, isTrue);
      expect(persisted?.requiresMigrationReview, isFalse);
      expect(persisted?.migrationReviewIssues, isEmpty);
      expect(
        viewModel
            .currentDefinition(
              sampleTitle: 'Card payment',
              sampleBody: 'Paid 12.50 CAD',
            )
            .requiresMigrationReview,
        isFalse,
      );
    },
  );

  test('restores saving state and propagates persistence failures', () async {
    final NotificationDefinitionEditorViewModel viewModel =
        NotificationDefinitionEditorViewModel(definition);

    await expectLater(
      viewModel.save(
        sampleTitle: '',
        sampleBody: '',
        persist: (NotificationDefinition updated) async =>
            throw StateError('no'),
      ),
      throwsStateError,
    );

    expect(viewModel.isSaving, isFalse);
  });

  test(
    'does not mark the draft saved when persistence returns false',
    () async {
      final NotificationDefinitionEditorViewModel viewModel =
          NotificationDefinitionEditorViewModel(definition);

      final NotificationDefinitionSaveResult result = await viewModel.save(
        sampleTitle: 'Card payment',
        sampleBody: 'Paid 12.50 CAD',
        persist: (NotificationDefinition updated) async => false,
      );

      expect(result.succeeded, isFalse);
      expect(result.failed, isTrue);
      expect(viewModel.isDirty, isTrue);
    },
  );

  test(
    'blocks saves with actions that reference a deleted extractor',
    () async {
      final NotificationDefinitionEditorViewModel viewModel =
          NotificationDefinitionEditorViewModel(definition);
      const NotificationRule rule = NotificationRule(
        id: 'rule',
        name: 'Rule',
        conditions: <NotificationCondition>[],
        actions: <NotificationAction>[
          SetTransactionFieldAction(
            target: TransactionField.amount,
            valueSource: RegExpCaptureValueSource(
              extractorId: 'missing',
              captureName: 'amount',
            ),
          ),
        ],
      );
      viewModel.applySetup(
        mode: NotificationExtractorMode.advanced,
        extractors: const <RegExpDefinition>[],
        rules: <NotificationRule>[rule],
      );

      final NotificationDefinitionSaveResult result = await viewModel.save(
        sampleTitle: 'Card payment',
        sampleBody: 'Paid 12.50 CAD',
        persist: (NotificationDefinition updated) async => true,
      );

      expect(result.hasDanglingActions, isTrue);
      expect(result.danglingActionCount, 1);
    },
  );

  test('applies setup transitions through typed editor commands', () {
    final NotificationDefinitionEditorViewModel viewModel =
        NotificationDefinitionEditorViewModel(definition);
    final RegExpDefinition extractor =
        RegExpDefinition.createPredefinedRegExpDefinition(
          PredefinedRegExpDefinition.amount,
        );
    final NotificationRule rule = const NotificationRule(
      id: 'rule',
      name: 'Transaction details',
      isPredefined: true,
      conditions: <NotificationCondition>[],
      actions: <NotificationAction>[],
      reviewedPredefinedFields: <TransactionField>{TransactionField.amount},
    );

    viewModel.applySetup(
      mode: NotificationExtractorMode.basic,
      extractors: <RegExpDefinition>[extractor],
      rules: <NotificationRule>[rule],
    );
    viewModel.clearPredefinedReviews();
    viewModel.convertToAdvanced();
    viewModel.setTransactionCreationMode(true);

    expect(viewModel.extractorMode, NotificationExtractorMode.advanced);
    expect(viewModel.rules, isEmpty);
    expect(
      viewModel.transactionCreationMode,
      TransactionCreationMode.automatic,
    );
  });

  test('creates standard setup templates for each extractor mode', () {
    final NotificationDefinitionEditorViewModel viewModel =
        NotificationDefinitionEditorViewModel(definition);

    viewModel.configure(NotificationExtractorMode.basic);
    expect(
      viewModel.extractors.length,
      PredefinedRegExpDefinition.values.length,
    );
    expect(viewModel.rules, isEmpty);
    expect(viewModel.sharedActions, hasLength(3));

    viewModel.configure(NotificationExtractorMode.advanced);
    expect(viewModel.extractors, hasLength(4));
    expect(viewModel.rules, isEmpty);
    expect(viewModel.sharedActions, isEmpty);
  });

  test('reorders uniform rules', () {
    final NotificationDefinitionEditorViewModel viewModel =
        NotificationDefinitionEditorViewModel(definition)
          ..configure(NotificationExtractorMode.advanced)
          ..addRule(
            const NotificationRule(
              id: 'first',
              name: 'First',
              conditions: <NotificationCondition>[],
              actions: <NotificationAction>[],
            ),
          )
          ..addRule(
            const NotificationRule(
              id: 'second',
              name: 'Second',
              conditions: <NotificationCondition>[],
              actions: <NotificationAction>[],
            ),
          );

    viewModel.moveRule('second', 0);

    expect(viewModel.rules.map((NotificationRule rule) => rule.id), <String>[
      'second',
      'first',
    ]);
  });

  test('updates rules and extractors through typed collection commands', () {
    final NotificationDefinitionEditorViewModel viewModel =
        NotificationDefinitionEditorViewModel(definition);
    final RegExpDefinition extractor =
        RegExpDefinition.createPredefinedRegExpDefinition(
          PredefinedRegExpDefinition.amount,
        );
    final RegExpDefinition updatedExtractor = extractor.copyWith(
      name: 'Payment amount',
    );
    const NotificationRule rule = NotificationRule(
      id: 'rule',
      name: 'Payment',
      conditions: <NotificationCondition>[],
      actions: <NotificationAction>[],
    );
    const NotificationRule updatedRule = NotificationRule(
      id: 'rule',
      name: 'Updated payment',
      conditions: <NotificationCondition>[],
      actions: <NotificationAction>[],
    );

    viewModel
      ..addExtractor(extractor)
      ..replaceExtractor(updatedExtractor)
      ..addRule(rule)
      ..replaceRule(updatedRule);

    expect(viewModel.extractors.single.definitionName, 'Payment amount');
    expect(viewModel.rules.single.name, 'Updated payment');

    viewModel
      ..removeExtractor(extractor.id)
      ..removeRule(rule.id);

    expect(viewModel.extractors, isEmpty);
    expect(viewModel.rules, isEmpty);
  });

  test('applies typed child results and decides whether to autosave', () {
    final NotificationDefinitionEditorViewModel viewModel =
        NotificationDefinitionEditorViewModel(definition);
    final RegExpDefinition extractor =
        RegExpDefinition.createCustomRegExpDefinition('Amount', r'\d+');
    const NotificationRule rule = NotificationRule(
      id: 'rule',
      name: 'Payment',
      conditions: <NotificationCondition>[],
      actions: <NotificationAction>[],
    );

    expect(
      viewModel.applyNewExtractorEditorResult(null),
      DefinitionChildChange.unchanged,
    );
    expect(
      viewModel.applyNewExtractorEditorResult(extractor),
      DefinitionChildChange.changed,
    );
    expect(
      viewModel.applyNewRuleEditorResult(rule),
      DefinitionChildChange.changed,
    );

    final DefinitionChildChange extractorChange = viewModel
        .applyExtractorEditorResult(
          originalExtractorId: extractor.id,
          extractor: extractor.copyWith(name: 'Updated amount'),
        );
    final DefinitionChildChange ruleChange = viewModel.applyRuleEditorResult(
      originalRuleId: rule.id,
      delete: true,
    );

    expect(extractorChange, DefinitionChildChange.changed);
    expect(ruleChange, DefinitionChildChange.changed);
    expect(viewModel.extractors.single.definitionName, 'Updated amount');
    expect(viewModel.rules, isEmpty);
    expect(
      viewModel.saveAfterChildDecision(extractorChange),
      DefinitionSaveAfterChildDecision.save,
    );

    viewModel.setTransactionCreationMode(true);
    expect(
      viewModel.saveAfterChildDecision(extractorChange),
      DefinitionSaveAfterChildDecision.skip,
    );
  });

  test('creates definition editor drafts and advanced transaction rules', () {
    final NotificationDefinitionEditorViewModel viewModel =
        NotificationDefinitionEditorViewModel(definition);

    final NotificationRule rule = viewModel.createCustomRule(
      'Custom rule',
      description: 'Handles custom notifications.',
    );
    final RegExpDefinition predefinedExtractor = viewModel
        .createPredefinedExtractor(PredefinedRegExpDefinition.amount);
    final RegExpDefinition customExtractor = viewModel.createCustomExtractor(
      'Reference',
      description: 'Finds a reference value.',
    );

    expect(rule.name, 'Custom rule');
    expect(rule.description, 'Handles custom notifications.');
    expect(rule.conditions, isEmpty);
    expect(rule.actions, isEmpty);
    expect(
      predefinedExtractor.predefinedType,
      PredefinedRegExpDefinition.amount,
    );
    expect(predefinedExtractor.description, isNotEmpty);
    expect(customExtractor.definitionName, 'Reference');
    expect(customExtractor.description, 'Finds a reference value.');
    expect(customExtractor.regExpSource, isEmpty);

    viewModel.configure(NotificationExtractorMode.advanced);
    final NotificationRule transactionRule = viewModel
        .addStandardTransactionRule();

    expect(transactionRule.isPredefined, isFalse);
    expect(
      viewModel.extractors.any(
        (RegExpDefinition extractor) =>
            extractor.predefinedType == PredefinedRegExpDefinition.currency,
      ),
      isTrue,
    );
    expect(viewModel.rules, contains(transactionRule));
  });

  test('exposes immutable collection snapshots and copies setup inputs', () {
    final NotificationDefinitionEditorViewModel viewModel =
        NotificationDefinitionEditorViewModel(definition);
    final List<RegExpDefinition> extractors = <RegExpDefinition>[
      RegExpDefinition.createPredefinedRegExpDefinition(
        PredefinedRegExpDefinition.amount,
      ),
    ];
    final List<NotificationRule> rules = <NotificationRule>[
      const NotificationRule(
        id: 'rule',
        name: 'Payment',
        conditions: <NotificationCondition>[],
        actions: <NotificationAction>[],
      ),
    ];

    viewModel.applySetup(
      mode: NotificationExtractorMode.advanced,
      extractors: extractors,
      rules: rules,
    );
    extractors.clear();
    rules.clear();

    expect(viewModel.extractors, hasLength(1));
    expect(viewModel.rules, hasLength(1));
    expect(
      () => viewModel.extractors.add(
        RegExpDefinition.createPredefinedRegExpDefinition(
          PredefinedRegExpDefinition.currency,
        ),
      ),
      throwsUnsupportedError,
    );
    expect(
      () => viewModel.rules.add(
        const NotificationRule(
          id: 'another-rule',
          name: 'Another payment',
          conditions: <NotificationCondition>[],
          actions: <NotificationAction>[],
        ),
      ),
      throwsUnsupportedError,
    );
  });
}
