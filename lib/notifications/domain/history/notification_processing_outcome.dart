import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_patch.dart';

enum NotificationProcessingOutcomeStatus { noMatch, matched, failed }

enum NotificationTransactionCreationOrigin { automatic, user }

class NotificationHistoryReference {
  const NotificationHistoryReference({required this.id, required this.name});

  final String id;
  final String name;

  factory NotificationHistoryReference.fromJson(Map<String, dynamic> json) =>
      NotificationHistoryReference(
        id: json['id'] as String,
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{'id': id, 'name': name};
}

class NotificationProcessingOutcome {
  const NotificationProcessingOutcome({
    required this.status,
    this.definition,
    this.rule,
    this.conditionalActionGroups = const <NotificationHistoryReference>[],
    this.transactionCreationMode,
    this.hasTransactionIntent = false,
    this.transactionPatch,
    this.transactionId,
    this.transactionCreationOrigin,
    this.failureMessage,
  });

  final NotificationProcessingOutcomeStatus status;
  final NotificationHistoryReference? definition;
  final NotificationHistoryReference? rule;
  final List<NotificationHistoryReference> conditionalActionGroups;
  final TransactionCreationMode? transactionCreationMode;
  final bool hasTransactionIntent;
  final TransactionPatch? transactionPatch;
  final String? transactionId;
  final NotificationTransactionCreationOrigin? transactionCreationOrigin;
  final String? failureMessage;

  NotificationTransactionCreationOrigin?
  get effectiveTransactionCreationOrigin {
    if (transactionCreationOrigin != null) return transactionCreationOrigin;
    if (transactionId == null) return null;
    return switch (transactionCreationMode) {
      TransactionCreationMode.automatic =>
        NotificationTransactionCreationOrigin.automatic,
      TransactionCreationMode.prompt =>
        NotificationTransactionCreationOrigin.user,
      null => null,
    };
  }

  NotificationProcessingOutcome withTransactionId(
    String id, {
    required NotificationTransactionCreationOrigin origin,
  }) => NotificationProcessingOutcome(
    status: status,
    definition: definition,
    rule: rule,
    conditionalActionGroups: conditionalActionGroups,
    transactionCreationMode: transactionCreationMode,
    hasTransactionIntent: hasTransactionIntent,
    transactionPatch: transactionPatch,
    transactionId: id,
    transactionCreationOrigin: origin,
    failureMessage: failureMessage,
  );

  NotificationProcessingOutcome withoutTransactionLink() =>
      NotificationProcessingOutcome(
        status: status,
        definition: definition,
        rule: rule,
        conditionalActionGroups: conditionalActionGroups,
        transactionCreationMode: transactionCreationMode,
        hasTransactionIntent: hasTransactionIntent,
        transactionPatch: transactionPatch,
        failureMessage: failureMessage,
      );

  NotificationProcessingOutcome withFailure(String message) =>
      NotificationProcessingOutcome(
        status: NotificationProcessingOutcomeStatus.failed,
        definition: definition,
        rule: rule,
        conditionalActionGroups: conditionalActionGroups,
        transactionCreationMode: transactionCreationMode,
        hasTransactionIntent: hasTransactionIntent,
        transactionPatch: transactionPatch,
        transactionCreationOrigin: transactionCreationOrigin,
        failureMessage: message,
      );

  NotificationProcessingOutcome withoutSensitiveDetails() =>
      NotificationProcessingOutcome(
        status: status,
        definition: definition,
        rule: rule,
        conditionalActionGroups: conditionalActionGroups,
        transactionCreationMode: transactionCreationMode,
        hasTransactionIntent: hasTransactionIntent,
        transactionId: transactionId,
        transactionCreationOrigin: transactionCreationOrigin,
      );

  factory NotificationProcessingOutcome.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic>? definition =
        json['definition'] as Map<String, dynamic>?;
    final Map<String, dynamic>? rule = json['rule'] as Map<String, dynamic>?;
    final Map<String, dynamic>? patch =
        json['transactionPatch'] as Map<String, dynamic>?;
    return NotificationProcessingOutcome(
      status: NotificationProcessingOutcomeStatus.values.byName(
        json['status'] as String,
      ),
      definition: definition == null
          ? null
          : NotificationHistoryReference.fromJson(definition),
      rule: rule == null ? null : NotificationHistoryReference.fromJson(rule),
      conditionalActionGroups:
          (json['conditionalActionGroups'] as List<dynamic>? ?? <dynamic>[])
              .map(
                (dynamic value) => NotificationHistoryReference.fromJson(
                  value as Map<String, dynamic>,
                ),
              )
              .toList(),
      transactionCreationMode: json['transactionCreationMode'] == null
          ? null
          : TransactionCreationMode.values.byName(
              json['transactionCreationMode'] as String,
            ),
      hasTransactionIntent: json['hasTransactionIntent'] as bool? ?? false,
      transactionPatch: patch == null ? null : TransactionPatch.fromJson(patch),
      transactionId: json['transactionId'] as String?,
      transactionCreationOrigin: json['transactionCreationOrigin'] == null
          ? null
          : NotificationTransactionCreationOrigin.values.byName(
              json['transactionCreationOrigin'] as String,
            ),
      failureMessage: json['failureMessage'] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'status': status.name,
    'definition': definition?.toJson(),
    'rule': rule?.toJson(),
    'conditionalActionGroups': conditionalActionGroups
        .map((NotificationHistoryReference group) => group.toJson())
        .toList(),
    'transactionCreationMode': transactionCreationMode?.name,
    'hasTransactionIntent': hasTransactionIntent,
    'transactionPatch': transactionPatch?.toJson(),
    'transactionId': transactionId,
    'transactionCreationOrigin': transactionCreationOrigin?.name,
    'failureMessage': failureMessage,
  };
}
