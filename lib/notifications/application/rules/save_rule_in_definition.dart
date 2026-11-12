import 'package:waterflyiii/notifications/application/stores/notification_definition_store.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';

enum SaveRuleInDefinitionStatus {
  saved,
  definitionNotFound,
  ruleNotFound,
  failed,
}

class SaveRuleInDefinitionResult {
  const SaveRuleInDefinitionResult(this.status, {this.error, this.stackTrace});

  final SaveRuleInDefinitionStatus status;
  final Object? error;
  final StackTrace? stackTrace;

  bool get succeeded => status == SaveRuleInDefinitionStatus.saved;
}

class SaveRuleInDefinition {
  const SaveRuleInDefinition(this._store);

  final NotificationDefinitionStore _store;

  Future<SaveRuleInDefinitionResult> add({
    required String definitionId,
    required NotificationRule rule,
  }) => _save(
    definitionId,
    (NotificationDefinition definition) => definition.copyWith(
      rules: <NotificationRule>[...definition.rules, rule],
    ),
  );

  Future<SaveRuleInDefinitionResult> update({
    required String definitionId,
    required String originalRuleId,
    required NotificationRule rule,
  }) async {
    final List<NotificationDefinition> definitions;
    try {
      definitions = await _store.load();
    } catch (error, stackTrace) {
      return SaveRuleInDefinitionResult(
        SaveRuleInDefinitionStatus.failed,
        error: error,
        stackTrace: stackTrace,
      );
    }
    final int definitionIndex = definitions.indexWhere(
      (NotificationDefinition definition) => definition.id == definitionId,
    );
    if (definitionIndex < 0) {
      return const SaveRuleInDefinitionResult(
        SaveRuleInDefinitionStatus.definitionNotFound,
      );
    }
    final NotificationDefinition definition = definitions[definitionIndex];
    final int ruleIndex = definition.rules.indexWhere(
      (NotificationRule candidate) => candidate.id == originalRuleId,
    );
    if (ruleIndex < 0) {
      return const SaveRuleInDefinitionResult(
        SaveRuleInDefinitionStatus.ruleNotFound,
      );
    }
    final List<NotificationRule> rules = List<NotificationRule>.from(
      definition.rules,
    );
    rules[ruleIndex] = rule;
    return _persist(
      definitions,
      definitionIndex,
      definition.copyWith(rules: rules),
    );
  }

  Future<SaveRuleInDefinitionResult> delete({
    required String definitionId,
    required String ruleId,
  }) async {
    final List<NotificationDefinition> definitions;
    try {
      definitions = await _store.load();
    } catch (error, stackTrace) {
      return SaveRuleInDefinitionResult(
        SaveRuleInDefinitionStatus.failed,
        error: error,
        stackTrace: stackTrace,
      );
    }
    final int definitionIndex = definitions.indexWhere(
      (NotificationDefinition definition) => definition.id == definitionId,
    );
    if (definitionIndex < 0) {
      return const SaveRuleInDefinitionResult(
        SaveRuleInDefinitionStatus.definitionNotFound,
      );
    }
    final NotificationDefinition definition = definitions[definitionIndex];
    if (!definition.rules.any((NotificationRule rule) => rule.id == ruleId)) {
      return const SaveRuleInDefinitionResult(
        SaveRuleInDefinitionStatus.ruleNotFound,
      );
    }
    return _persist(
      definitions,
      definitionIndex,
      definition.copyWith(
        rules: definition.rules
            .where((NotificationRule rule) => rule.id != ruleId)
            .toList(),
      ),
    );
  }

  Future<SaveRuleInDefinitionResult> _save(
    String definitionId,
    NotificationDefinition Function(NotificationDefinition definition) update,
  ) async {
    final List<NotificationDefinition> definitions;
    try {
      definitions = await _store.load();
    } catch (error, stackTrace) {
      return SaveRuleInDefinitionResult(
        SaveRuleInDefinitionStatus.failed,
        error: error,
        stackTrace: stackTrace,
      );
    }
    final int index = definitions.indexWhere(
      (NotificationDefinition definition) => definition.id == definitionId,
    );
    if (index < 0) {
      return const SaveRuleInDefinitionResult(
        SaveRuleInDefinitionStatus.definitionNotFound,
      );
    }
    return _persist(definitions, index, update(definitions[index]));
  }

  Future<SaveRuleInDefinitionResult> _persist(
    List<NotificationDefinition> definitions,
    int index,
    NotificationDefinition updated,
  ) async {
    definitions[index] = updated;
    try {
      await _store.save(definitions);
      return const SaveRuleInDefinitionResult(SaveRuleInDefinitionStatus.saved);
    } catch (error, stackTrace) {
      return SaveRuleInDefinitionResult(
        SaveRuleInDefinitionStatus.failed,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
