enum NotificationHistoryStorageMode {
  disabled,
  metadataOnly,
  full;

  static NotificationHistoryStorageMode fromName(String? name) =>
      NotificationHistoryStorageMode.values.firstWhere(
        (NotificationHistoryStorageMode mode) => mode.name == name,
        orElse: () => NotificationHistoryStorageMode.full,
      );
}

enum NotificationHistoryRetention {
  sevenDays(Duration(days: 7)),
  thirtyDays(Duration(days: 30)),
  ninetyDays(Duration(days: 90)),
  forever(null);

  const NotificationHistoryRetention(this.duration);

  final Duration? duration;

  static NotificationHistoryRetention fromName(String? name) =>
      NotificationHistoryRetention.values.firstWhere(
        (NotificationHistoryRetention retention) => retention.name == name,
        orElse: () => NotificationHistoryRetention.thirtyDays,
      );
}

class NotificationProcessingSettings {
  const NotificationProcessingSettings({
    this.historyStorageMode = NotificationHistoryStorageMode.full,
    this.historyRetention = NotificationHistoryRetention.thirtyDays,
  });

  factory NotificationProcessingSettings.fromJson(Map<String, dynamic> json) =>
      NotificationProcessingSettings(
        historyStorageMode: NotificationHistoryStorageMode.fromName(
          json['historyStorageMode'] as String?,
        ),
        historyRetention: NotificationHistoryRetention.fromName(
          json['historyRetention'] as String?,
        ),
      );

  final NotificationHistoryStorageMode historyStorageMode;
  final NotificationHistoryRetention historyRetention;

  static const NotificationProcessingSettings defaults =
      NotificationProcessingSettings();

  Map<String, dynamic> toJson() => <String, dynamic>{
    'historyStorageMode': historyStorageMode.name,
    'historyRetention': historyRetention.name,
  };

  NotificationProcessingSettings copyWith({
    NotificationHistoryStorageMode? historyStorageMode,
    NotificationHistoryRetention? historyRetention,
  }) => NotificationProcessingSettings(
    historyStorageMode: historyStorageMode ?? this.historyStorageMode,
    historyRetention: historyRetention ?? this.historyRetention,
  );
}

abstract interface class NotificationProcessingSettingsStore {
  Future<NotificationProcessingSettings> load();

  Future<void> save(NotificationProcessingSettings settings);

  Future<void> reset();
}
