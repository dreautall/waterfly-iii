class NotificationSample {
  const NotificationSample({
    required this.title,
    required this.body,
    required this.receivedAt,
  });

  final String title;
  final String body;
  final DateTime receivedAt;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'title': title,
    'body': body,
    'receivedAt': receivedAt.toIso8601String(),
  };

  factory NotificationSample.fromJson(Map<String, dynamic> json) =>
      NotificationSample(
        title: json['title'] as String? ?? '',
        body: json['body'] as String? ?? '',
        receivedAt:
            DateTime.tryParse(json['receivedAt'] as String? ?? '') ??
            DateTime.fromMillisecondsSinceEpoch(0),
      );
}
