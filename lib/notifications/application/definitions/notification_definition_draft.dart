import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/application/shared/json_equality.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';

class NotificationDefinitionDraft {
  NotificationDefinitionDraft.fromDefinition(this._original)
    : extractors = List<RegExpDefinition>.from(_original.extractors),
      rules = List<NotificationRule>.from(_original.rules),
      sharedActions = List<NotificationAction>.from(_original.sharedActions),
      reviewedSharedActionFields = Set<TransactionField>.from(
        _original.reviewedSharedActionFields,
      ),
      sampleTitle = _original.sampleTitle ?? '',
      sampleBody = _original.sampleBody ?? '',
      extractorMode = _original.extractorMode,
      transactionCreationMode = _original.transactionCreationMode;

  NotificationDefinition _original;
  List<RegExpDefinition> extractors;
  List<NotificationRule> rules;
  List<NotificationAction> sharedActions;
  Set<TransactionField> reviewedSharedActionFields;
  String sampleTitle;
  String sampleBody;
  NotificationExtractorMode extractorMode;
  TransactionCreationMode transactionCreationMode;

  NotificationDefinition build() => _original.copyWith(
    extractors: List<RegExpDefinition>.from(extractors),
    rules: List<NotificationRule>.from(rules),
    sharedActions: List<NotificationAction>.from(sharedActions),
    reviewedSharedActionFields: Set<TransactionField>.from(
      reviewedSharedActionFields,
    ),
    sampleTitle: _emptyToNull(sampleTitle),
    sampleBody: _emptyToNull(sampleBody),
    extractorMode: extractorMode,
    transactionCreationMode: transactionCreationMode,
  );

  bool get isDirty =>
      !jsonStructuresEqual(build().toJson(), _original.toJson());

  bool get hasUnsavedOptions =>
      transactionCreationMode != _original.transactionCreationMode;

  void markSaved(NotificationDefinition definition) {
    _original = definition;
  }

  String? _emptyToNull(String value) {
    final String normalized = value.trim();
    return normalized.isEmpty ? null : normalized;
  }
}
