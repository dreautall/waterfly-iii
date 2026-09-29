class NotificationListenerHealthIssue {
  const NotificationListenerHealthIssue({
    required this.firstOccurredAt,
    required this.lastOccurredAt,
    required this.occurrenceCount,
    this.recoveredAt,
  });

  final DateTime firstOccurredAt;
  final DateTime lastOccurredAt;
  final int occurrenceCount;
  final DateTime? recoveredAt;

  bool get isActive => recoveredAt == null;

  NotificationListenerHealthIssue recordOccurrence(DateTime occurredAt) =>
      NotificationListenerHealthIssue(
        firstOccurredAt: firstOccurredAt,
        lastOccurredAt: occurredAt,
        occurrenceCount: occurrenceCount + 1,
      );

  NotificationListenerHealthIssue markRecovered(DateTime recoveredAt) =>
      NotificationListenerHealthIssue(
        firstOccurredAt: firstOccurredAt,
        lastOccurredAt: lastOccurredAt,
        occurrenceCount: occurrenceCount,
        recoveredAt: recoveredAt,
      );

  factory NotificationListenerHealthIssue.fromJson(Map<String, dynamic> json) =>
      NotificationListenerHealthIssue(
        firstOccurredAt: DateTime.parse(json['firstOccurredAt'] as String),
        lastOccurredAt: DateTime.parse(json['lastOccurredAt'] as String),
        occurrenceCount: json['occurrenceCount'] as int,
        recoveredAt: json['recoveredAt'] == null
            ? null
            : DateTime.parse(json['recoveredAt'] as String),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'firstOccurredAt': firstOccurredAt.toIso8601String(),
    'lastOccurredAt': lastOccurredAt.toIso8601String(),
    'occurrenceCount': occurrenceCount,
    'recoveredAt': recoveredAt?.toIso8601String(),
  };
}
