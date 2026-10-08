import 'package:flutter/foundation.dart';
import 'package:waterflyiii/notifications/application/definitions/notification_definition_draft.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/application/definitions/notification_definition_preset_factory.dart';
import 'package:waterflyiii/notifications/application/definitions/notification_definition_validator.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/notification_id.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';

class NotificationDefinitionEditorViewModel extends ChangeNotifier {
  NotificationDefinitionEditorViewModel(
    NotificationDefinition definition, {
    NotificationDefinitionPresetFactory presetFactory =
        const NotificationDefinitionPresetFactory(),
    NotificationDefinitionValidator validator =
        const NotificationDefinitionValidator(),
  }) : _draft = NotificationDefinitionDraft.fromDefinition(definition),
       _presetFactory = presetFactory,
       _validator = validator;

  final NotificationDefinitionDraft _draft;
  final NotificationDefinitionPresetFactory _presetFactory;
  final NotificationDefinitionValidator _validator;
  bool isSaving = false;

  List<RegExpDefinition> get extractors =>
      List<RegExpDefinition>.unmodifiable(_draft.extractors);
  set extractors(List<RegExpDefinition> value) {
    _draft.extractors = List<RegExpDefinition>.from(value);
  }

  List<NotificationRule> get rules =>
      List<NotificationRule>.unmodifiable(_draft.rules);
  set rules(List<NotificationRule> value) {
    _draft.rules = List<NotificationRule>.from(value);
  }

  List<NotificationAction> get sharedActions =>
      List<NotificationAction>.unmodifiable(_draft.sharedActions);
  Set<TransactionField> get reviewedSharedActionFields =>
      Set<TransactionField>.unmodifiable(_draft.reviewedSharedActionFields);

  NotificationExtractorMode get extractorMode => _draft.extractorMode;
  set extractorMode(NotificationExtractorMode value) {
    _draft.extractorMode = value;
  }

  TransactionCreationMode get transactionCreationMode =>
      _draft.transactionCreationMode;

  bool get isDirty => _draft.isDirty;
  bool get hasUnsavedOptions => _draft.hasUnsavedOptions;

  void configure(NotificationExtractorMode mode) {
    final List<RegExpDefinition> configuredExtractors =
        mode == NotificationExtractorMode.basic
        ? _presetFactory.basicExtractors()
        : _presetFactory.advancedDefaultExtractors();
    final NotificationRule transactionRule = _presetFactory
        .standardTransactionRule(configuredExtractors);
    applySetup(
      mode: mode,
      extractors: configuredExtractors,
      sharedActions: mode == NotificationExtractorMode.basic
          ? transactionRule.actions
          : const <NotificationAction>[],
      rules: const <NotificationRule>[],
    );
  }

  NotificationRule createStandardTransactionRule() =>
      _presetFactory.standardTransactionRule(_draft.extractors);

  NotificationRule createSharedActionsRule(String name) => NotificationRule(
    id: 'shared-actions',
    name: name,
    conditions: const <NotificationCondition>[],
    actions: _draft.sharedActions,
    isPredefined: _draft.extractorMode == NotificationExtractorMode.basic,
    reviewedPredefinedFields: _draft.reviewedSharedActionFields,
  );

  NotificationRule addStandardTransactionRule() {
    if (_draft.extractorMode == NotificationExtractorMode.advanced &&
        !_draft.extractors.any(
          (RegExpDefinition extractor) =>
              extractor.predefinedType == PredefinedRegExpDefinition.currency,
        )) {
      _draft.extractors = <RegExpDefinition>[
        ..._draft.extractors,
        createPredefinedExtractor(PredefinedRegExpDefinition.currency),
      ];
    }
    final NotificationRule standardRule = createStandardTransactionRule();
    final NotificationRule rule = standardRule.copyWith(
      isPredefined: false,
      reviewedPredefinedFields: const <TransactionField>{},
    );
    _draft.rules = <NotificationRule>[..._draft.rules, rule];
    notifyListeners();
    return rule;
  }

  NotificationRule createCustomRule(String name, {String description = ''}) =>
      NotificationRule(
        id: newNotificationId(),
        name: name,
        description: description,
        conditions: const <NotificationCondition>[],
        actions: const <NotificationAction>[],
      );

  RegExpDefinition createPredefinedExtractor(PredefinedRegExpDefinition type) =>
      _presetFactory.createPredefinedExtractor(type);

  RegExpDefinition createCustomExtractor(
    String name, {
    String description = '',
  }) => RegExpDefinition.createCustomRegExpDefinition(
    name,
    '',
    description: description,
  );

  void applySetup({
    required NotificationExtractorMode mode,
    required List<RegExpDefinition> extractors,
    List<NotificationAction> sharedActions = const <NotificationAction>[],
    required List<NotificationRule> rules,
  }) {
    _draft.extractorMode = mode;
    _draft.extractors = List<RegExpDefinition>.from(extractors);
    _draft.sharedActions = List<NotificationAction>.from(sharedActions);
    _draft.reviewedSharedActionFields = <TransactionField>{};
    _draft.rules = List<NotificationRule>.from(rules);
    notifyListeners();
  }

  void convertToAdvanced() {
    _draft.extractorMode = NotificationExtractorMode.advanced;
    _draft.rules = _draft.rules
        .where((NotificationRule rule) => !_isEmptyPredefinedRule(rule))
        .map(
          (NotificationRule rule) => rule.isPredefined
              ? rule.copyWith(
                  isPredefined: false,
                  reviewedPredefinedFields: const <TransactionField>{},
                )
              : rule,
        )
        .toList();
    notifyListeners();
  }

  bool _isEmptyPredefinedRule(NotificationRule rule) =>
      rule.isPredefined &&
      rule.conditions.isEmpty &&
      rule.actions.isEmpty &&
      rule.conditionalActionGroups.isEmpty;

  void convertSetup(NotificationExtractorMode targetMode) {
    switch (targetMode) {
      case NotificationExtractorMode.advanced:
        convertToAdvanced();
      case NotificationExtractorMode.basic:
        configure(NotificationExtractorMode.basic);
      case NotificationExtractorMode.notConfigured:
        throw ArgumentError.value(
          targetMode,
          'targetMode',
          'A configured extractor mode is required.',
        );
    }
  }

  void clearPredefinedReviews() {
    _draft.reviewedSharedActionFields = <TransactionField>{};
    _draft.rules = _draft.rules
        .map(
          (NotificationRule rule) => rule.isPredefined
              ? rule.copyWith(
                  reviewedPredefinedFields: const <TransactionField>{},
                )
              : rule,
        )
        .toList();
    notifyListeners();
  }

  void setTransactionCreationMode(bool automatically) {
    _draft.transactionCreationMode = automatically
        ? TransactionCreationMode.automatic
        : TransactionCreationMode.prompt;
    notifyListeners();
  }

  void addRule(NotificationRule rule) {
    _draft.rules = <NotificationRule>[..._draft.rules, rule];
    notifyListeners();
  }

  void replaceRule(NotificationRule rule) {
    _draft.rules = _draft.rules
        .map(
          (NotificationRule current) => current.id == rule.id ? rule : current,
        )
        .toList();
    notifyListeners();
  }

  void removeRule(String ruleId) {
    _draft.rules = _draft.rules
        .where((NotificationRule rule) => rule.id != ruleId)
        .toList();
    notifyListeners();
  }

  void moveRule(String ruleId, int targetIndex) {
    final List<NotificationRule> reordered = List<NotificationRule>.from(
      _draft.rules,
    );
    final int currentIndex = reordered.indexWhere(
      (NotificationRule rule) => rule.id == ruleId,
    );
    if (currentIndex < 0) return;
    final NotificationRule rule = reordered.removeAt(currentIndex);
    reordered.insert(targetIndex.clamp(0, reordered.length), rule);
    _draft.rules = reordered;
    notifyListeners();
  }

  void replaceSharedActions(
    List<NotificationAction> actions,
    Set<TransactionField> reviewedFields,
  ) {
    _draft.sharedActions = List<NotificationAction>.from(actions);
    _draft.reviewedSharedActionFields = Set<TransactionField>.from(
      reviewedFields,
    );
    notifyListeners();
  }

  void addExtractor(RegExpDefinition extractor) {
    _draft.extractors = <RegExpDefinition>[..._draft.extractors, extractor];
    notifyListeners();
  }

  void replaceExtractor(RegExpDefinition extractor) {
    _draft.extractors = _draft.extractors
        .map(
          (RegExpDefinition current) =>
              current.id == extractor.id ? extractor : current,
        )
        .toList();
    notifyListeners();
  }

  void removeExtractor(String extractorId) {
    _draft.extractors = _draft.extractors
        .where((RegExpDefinition extractor) => extractor.id != extractorId)
        .toList();
    notifyListeners();
  }

  DefinitionChildChange applyRuleEditorResult({
    required String originalRuleId,
    NotificationRule? rule,
    bool delete = false,
  }) {
    if (delete && rule != null) {
      throw ArgumentError('A child result cannot update and delete a rule.');
    }
    if (delete) {
      final int previousCount = _draft.rules.length;
      removeRule(originalRuleId);
      return _draft.rules.length == previousCount
          ? DefinitionChildChange.unchanged
          : DefinitionChildChange.changed;
    }
    if (rule == null) return DefinitionChildChange.unchanged;
    replaceRule(rule);
    return DefinitionChildChange.changed;
  }

  DefinitionChildChange applyNewRuleEditorResult(NotificationRule? rule) {
    if (rule == null) return DefinitionChildChange.unchanged;
    addRule(rule);
    return DefinitionChildChange.changed;
  }

  DefinitionChildChange applyExtractorEditorResult({
    required String originalExtractorId,
    RegExpDefinition? extractor,
    bool delete = false,
  }) {
    if (delete && extractor != null) {
      throw ArgumentError(
        'A child result cannot update and delete an extractor.',
      );
    }
    if (delete) {
      final int previousCount = _draft.extractors.length;
      removeExtractor(originalExtractorId);
      return _draft.extractors.length == previousCount
          ? DefinitionChildChange.unchanged
          : DefinitionChildChange.changed;
    }
    if (extractor == null) return DefinitionChildChange.unchanged;
    replaceExtractor(extractor);
    return DefinitionChildChange.changed;
  }

  DefinitionChildChange applyNewExtractorEditorResult(
    RegExpDefinition? extractor,
  ) {
    if (extractor == null) return DefinitionChildChange.unchanged;
    addExtractor(extractor);
    return DefinitionChildChange.changed;
  }

  DefinitionSaveAfterChildDecision saveAfterChildDecision(
    DefinitionChildChange change,
  ) {
    if (change == DefinitionChildChange.unchanged ||
        hasUnsavedOptions ||
        isSaving) {
      return DefinitionSaveAfterChildDecision.skip;
    }
    return DefinitionSaveAfterChildDecision.save;
  }

  NotificationDefinition currentDefinition({
    required String sampleTitle,
    required String sampleBody,
  }) {
    _draft.sampleTitle = sampleTitle;
    _draft.sampleBody = sampleBody;
    return _draft.build();
  }

  Future<NotificationDefinitionSaveResult> save({
    required String sampleTitle,
    required String sampleBody,
    required Future<bool> Function(NotificationDefinition definition) persist,
  }) async {
    final NotificationDefinition definition = currentDefinition(
      sampleTitle: sampleTitle,
      sampleBody: sampleBody,
    );
    final int danglingActionCount = _validator.danglingActionCount(definition);
    if (danglingActionCount > 0) {
      return NotificationDefinitionSaveResult.danglingActions(
        danglingActionCount,
      );
    }
    isSaving = true;
    notifyListeners();
    try {
      final NotificationDefinition reviewedDefinition = definition.copyWith(
        requiresMigrationReview: false,
        migrationReviewIssues: const <NotificationMigrationIssue>{},
      );
      if (!await persist(reviewedDefinition)) {
        return const NotificationDefinitionSaveResult.notSaved();
      }
      _draft.markSaved(reviewedDefinition);
      return const NotificationDefinitionSaveResult.saved();
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }
}

class NotificationDefinitionSaveResult {
  const NotificationDefinitionSaveResult._(
    this._status, {
    this.danglingActionCount = 0,
  });
  const NotificationDefinitionSaveResult.saved()
    : this._(_NotificationDefinitionSaveStatus.saved);
  const NotificationDefinitionSaveResult.notSaved()
    : this._(_NotificationDefinitionSaveStatus.notSaved);
  const NotificationDefinitionSaveResult.danglingActions(int count)
    : this._(
        _NotificationDefinitionSaveStatus.danglingActions,
        danglingActionCount: count,
      );

  final _NotificationDefinitionSaveStatus _status;
  final int danglingActionCount;

  bool get succeeded => _status == _NotificationDefinitionSaveStatus.saved;
  bool get failed => _status == _NotificationDefinitionSaveStatus.notSaved;
  bool get hasDanglingActions =>
      _status == _NotificationDefinitionSaveStatus.danglingActions;
}

enum _NotificationDefinitionSaveStatus { saved, notSaved, danglingActions }

enum DefinitionChildChange { unchanged, changed }

enum DefinitionSaveAfterChildDecision { skip, save }
