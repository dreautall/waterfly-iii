import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_definition_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_formatting_preferences.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_definition_evaluator.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_rule_requirement.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/planning/automatic_transaction_readiness.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule_diagnostics.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';

enum NotificationExtractorMode { notConfigured, basic, advanced }

enum NotificationDefinitionStatus {
  notConfigured,
  needsSetup,
  needsReview,
  ready,
}

class NotificationDefinition {
  const NotificationDefinition({
    required this.id,
    required this.applicationId,
    required this.name,
    required this.extractors,
    required this.rules,
    this.sharedActions = const <NotificationAction>[],
    this.reviewedSharedActionFields = const <TransactionField>{},
    this.sampleTitle,
    this.sampleBody,
    this.createdAt,
    this.extractorMode = NotificationExtractorMode.notConfigured,
    this.transactionCreationMode = TransactionCreationMode.prompt,
    this.requiresMigrationReview = false,
    this.migrationReviewIssues = const <NotificationMigrationIssue>{},
  });

  final String id;
  final String applicationId;
  final String name;
  final List<RegExpDefinition> extractors;
  final List<NotificationRule> rules;
  final List<NotificationAction> sharedActions;
  final Set<TransactionField> reviewedSharedActionFields;
  final String? sampleTitle;
  final String? sampleBody;
  final DateTime? createdAt;
  final NotificationExtractorMode extractorMode;
  final TransactionCreationMode transactionCreationMode;
  final bool requiresMigrationReview;
  final Set<NotificationMigrationIssue> migrationReviewIssues;

  DateTime get sampleReceivedAt =>
      createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);

  NotificationDefinition copyWith({
    String? id,
    String? applicationId,
    String? name,
    List<RegExpDefinition>? extractors,
    List<NotificationRule>? rules,
    List<NotificationAction>? sharedActions,
    Set<TransactionField>? reviewedSharedActionFields,
    String? sampleTitle,
    String? sampleBody,
    DateTime? createdAt,
    NotificationExtractorMode? extractorMode,
    TransactionCreationMode? transactionCreationMode,
    bool? requiresMigrationReview,
    Set<NotificationMigrationIssue>? migrationReviewIssues,
  }) => NotificationDefinition(
    id: id ?? this.id,
    applicationId: applicationId ?? this.applicationId,
    name: name ?? this.name,
    extractors: extractors ?? this.extractors,
    rules: rules ?? this.rules,
    sharedActions: sharedActions ?? this.sharedActions,
    reviewedSharedActionFields:
        reviewedSharedActionFields ?? this.reviewedSharedActionFields,
    sampleTitle: sampleTitle ?? this.sampleTitle,
    sampleBody: sampleBody ?? this.sampleBody,
    createdAt: createdAt ?? this.createdAt,
    extractorMode: extractorMode ?? this.extractorMode,
    transactionCreationMode:
        transactionCreationMode ?? this.transactionCreationMode,
    requiresMigrationReview:
        requiresMigrationReview ?? this.requiresMigrationReview,
    migrationReviewIssues: migrationReviewIssues ?? this.migrationReviewIssues,
  );

  bool get hasUnreviewedPredefinedMappings {
    final NotificationContext sample = NotificationContext(
      applicationId: applicationId,
      applicationName: name,
      title: sampleTitle ?? '',
      body: sampleBody ?? '',
      receivedAt: sampleReceivedAt,
    );
    return <NotificationRule>[
      NotificationRule(
        id: 'shared-actions',
        name: 'Shared actions',
        conditions: const <NotificationCondition>[],
        actions: sharedActions,
        isPredefined: extractorMode == NotificationExtractorMode.basic,
        reviewedPredefinedFields: reviewedSharedActionFields,
      ),
      ...rules,
    ].any(
      (NotificationRule rule) => rule
          .diagnostics(extractors: extractors, notificationContext: sample)
          .unreviewedPredefinedFields
          .isNotEmpty,
    );
  }

  bool get hasIncompleteActions {
    final NotificationContext sample = NotificationContext(
      applicationId: applicationId,
      applicationName: name,
      title: sampleTitle ?? '',
      body: sampleBody ?? '',
      receivedAt: sampleReceivedAt,
    );
    return <NotificationRule>[
      NotificationRule(
        id: 'shared-actions',
        name: 'Shared actions',
        conditions: const <NotificationCondition>[],
        actions: sharedActions,
      ),
      ...rules,
    ].any(
      (NotificationRule rule) => rule
          .diagnostics(extractors: extractors, notificationContext: sample)
          .incompleteFields
          .isNotEmpty,
    );
  }

  bool get hasUnconfiguredConditionalActions => rules.any(
    (NotificationRule rule) => rule.hasUnconfiguredConditionalActions,
  );

  AutomaticTransactionReadiness get automaticTransactionReadiness =>
      AutomaticTransactionReadiness.evaluate(
        sharedActions: sharedActions,
        extractors: extractors,
        notificationContext: NotificationContext(
          applicationId: applicationId,
          applicationName: name,
          title: sampleTitle ?? '',
          body: sampleBody ?? '',
          receivedAt: createdAt ?? DateTime.now(),
        ),
      );

  NotificationDefinitionStatus get status {
    if (extractorMode == NotificationExtractorMode.notConfigured) {
      return NotificationDefinitionStatus.notConfigured;
    }
    final bool hasRequiredSetup =
        (sampleTitle?.trim().isNotEmpty ?? false) &&
        (sampleBody?.trim().isNotEmpty ?? false) &&
        extractors.isNotEmpty &&
        (rules.isNotEmpty || sharedActions.isNotEmpty);
    if (!hasRequiredSetup) return NotificationDefinitionStatus.needsSetup;
    if (transactionCreationMode == TransactionCreationMode.automatic &&
        !automaticTransactionReadiness.isReady) {
      return NotificationDefinitionStatus.needsReview;
    }
    if (extractorMode == NotificationExtractorMode.advanced &&
        hasIncompleteActions) {
      return NotificationDefinitionStatus.needsSetup;
    }
    if (requiresMigrationReview) {
      return NotificationDefinitionStatus.needsReview;
    }
    if (hasUnconfiguredConditionalActions) {
      return NotificationDefinitionStatus.needsReview;
    }
    if (extractorMode == NotificationExtractorMode.basic &&
        (hasIncompleteActions || hasUnreviewedPredefinedMappings)) {
      return NotificationDefinitionStatus.needsReview;
    }
    return NotificationDefinitionStatus.ready;
  }

  NotificationDefinitionEvaluationResult? evaluate(
    NotificationContext notification, {
    NotificationFormattingPreferences? formattingPreferences,
  }) {
    if (notification.applicationId != applicationId) {
      return null;
    }

    final NotificationDefinitionEvaluationResult result =
        NotificationDefinitionEvaluator(
          extractors: extractors,
          rules: rules,
          sharedActions: sharedActions,
          transactionCreationMode: transactionCreationMode,
          formattingPreferences: formattingPreferences,
        ).evaluate(notification);
    if (!result.sharedRequirementsMet) {
      final bool requirementEvaluationFailed = result.unmetSharedRequirements
          .any((NotificationRuleRequirement requirement) {
            final RegExpEvaluationResult? extraction =
                result.extractionResults[requirement.capture.extractorId];
            return extraction == null ||
                extraction.hasEvaluationFailure ||
                !extraction.isPatternValid;
          });
      if (!requirementEvaluationFailed) return null;
    }
    final bool requiredExtractorMissing = extractors.any(
      (RegExpDefinition extractor) =>
          extractor.isRequiredForMatch &&
          result.extractionResults[extractor.id]?.hasMatches != true &&
          result.extractionResults[extractor.id]?.hasEvaluationFailure !=
              true &&
          (result.extractionResults[extractor.id]?.isPatternValid ?? false),
    );
    return requiredExtractorMissing ? null : result;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'applicationId': applicationId,
    'name': name,
    'extractors': extractors
        .map((RegExpDefinition extractor) => extractor.toJson())
        .toList(),
    'rules': rules.map((NotificationRule rule) => rule.toJson()).toList(),
    'sharedActions': sharedActions
        .map((NotificationAction action) => action.toJson())
        .toList(),
    if (reviewedSharedActionFields.isNotEmpty)
      'reviewedSharedActionFields': reviewedSharedActionFields
          .map((TransactionField field) => field.name)
          .toList(),
    'sampleTitle': sampleTitle,
    'sampleBody': sampleBody,
    'createdAt': createdAt?.toIso8601String(),
    'extractorMode': extractorMode.name,
    'transactionCreationMode': transactionCreationMode.name,
    if (requiresMigrationReview) 'requiresMigrationReview': true,
    if (migrationReviewIssues.isNotEmpty)
      'migrationReviewIssues': migrationReviewIssues
          .map((NotificationMigrationIssue issue) => issue.name)
          .toList(),
  };

  factory NotificationDefinition.fromJson(Map<String, dynamic> json) {
    final List<RegExpDefinition> extractors =
        (json['extractors'] as List<dynamic>)
            .map(
              (dynamic extractor) =>
                  RegExpDefinition.fromJson(extractor as Map<String, dynamic>),
            )
            .toList();
    final List<NotificationRule> rules = (json['rules'] as List<dynamic>)
        .map(
          (dynamic rule) =>
              NotificationRule.fromJson(rule as Map<String, dynamic>),
        )
        .toList();
    final TransactionCreationMode transactionCreationMode =
        TransactionCreationMode.values
            .where(
              (TransactionCreationMode mode) =>
                  mode.name == json['transactionCreationMode'],
            )
            .firstOrNull ??
        TransactionCreationMode.prompt;
    return NotificationDefinition(
      id: json['id'] as String,
      applicationId: json['applicationId'] as String,
      name: json['name'] as String,
      sampleTitle: json['sampleTitle'] as String?,
      sampleBody: json['sampleBody'] as String?,
      createdAt:
          DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.now(),
      extractorMode: _extractorModeFromJson(
        json['extractorMode'] as String?,
        hasExtractors: extractors.isNotEmpty,
      ),
      extractors: extractors,
      rules: rules,
      sharedActions: (json['sharedActions'] as List<dynamic>? ?? <dynamic>[])
          .map(
            (dynamic action) =>
                NotificationAction.fromJson(action as Map<String, dynamic>),
          )
          .toList(),
      reviewedSharedActionFields:
          (json['reviewedSharedActionFields'] as List<dynamic>? ?? <dynamic>[])
              .map(
                (dynamic field) =>
                    TransactionField.values.byName(field as String),
              )
              .toSet(),
      transactionCreationMode: transactionCreationMode,
      requiresMigrationReview: json['requiresMigrationReview'] == true,
      migrationReviewIssues:
          (json['migrationReviewIssues'] as List<dynamic>? ?? <dynamic>[])
              .map(
                (dynamic issue) =>
                    NotificationMigrationIssue.values.byName(issue as String),
              )
              .toSet(),
    );
  }

  static NotificationExtractorMode _extractorModeFromJson(
    String? value, {
    required bool hasExtractors,
  }) {
    for (final NotificationExtractorMode mode
        in NotificationExtractorMode.values) {
      if (mode.name == value) {
        return mode;
      }
    }
    // Definitions saved before extractor modes existed must keep their
    // configured extractors instead of presenting a destructive setup choice.
    return hasExtractors
        ? NotificationExtractorMode.advanced
        : NotificationExtractorMode.notConfigured;
  }
}
