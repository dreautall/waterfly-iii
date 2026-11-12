import 'package:waterflyiii/notifications/application/stores/notification_alert_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_definition_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_history_store.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/history/notification_history_entry.dart';
import 'package:waterflyiii/notifications/domain/history/notification_processing_outcome.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_action_group.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_definition_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_formatting_preferences.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_rule_evaluation_result.dart';

abstract interface class RecentNotificationHistoryLoader {
  Future<List<RecentNotificationHistoryEntry>> load();
}

abstract interface class PagedRecentNotificationHistoryLoader {
  Future<RecentNotificationHistoryPage> loadPage({
    NotificationHistoryCursor? before,
    required int limit,
  });
}

class RecentNotificationHistoryPage {
  const RecentNotificationHistoryPage({
    required this.entries,
    required this.hasMore,
    this.nextCursor,
  });

  final List<RecentNotificationHistoryEntry> entries;
  final bool hasMore;
  final NotificationHistoryCursor? nextCursor;
}

class RecentNotificationHistoryEntry {
  const RecentNotificationHistoryEntry({
    required this.notification,
    this.definition,
    this.processingFailure,
    this.matchingRule,
    this.matchingConditionalActionGroups = const <NotificationActionGroup>[],
    this.canCreateTransaction = false,
    this.processingOutcome,
    this.currentMatchingRule,
    this.currentCanCreateTransaction,
  });

  final NotificationHistoryEntry notification;
  final NotificationDefinition? definition;
  final NotificationAlert? processingFailure;
  final NotificationRule? matchingRule;
  final List<NotificationActionGroup> matchingConditionalActionGroups;
  final bool canCreateTransaction;
  final NotificationProcessingOutcome? processingOutcome;
  final NotificationRule? currentMatchingRule;
  final bool? currentCanCreateTransaction;

  String? get matchingRuleName =>
      processingOutcome?.rule?.name ?? matchingRule?.name;

  List<String> get matchingConditionalActionGroupNames =>
      processingOutcome?.conditionalActionGroups
          .map((NotificationHistoryReference group) => group.name)
          .toList() ??
      matchingConditionalActionGroups
          .map((NotificationActionGroup group) => group.name)
          .toList();
}

class RecentNotificationHistory
    implements
        RecentNotificationHistoryLoader,
        PagedRecentNotificationHistoryLoader {
  RecentNotificationHistory(
    this._definitionStore,
    this._alertStore, {
    required NotificationHistoryStore historyStore,
    NotificationFormattingPreferences? formattingPreferences,
  }) : _historyStore = historyStore,
       _formattingPreferences = formattingPreferences;

  final NotificationDefinitionStore _definitionStore;
  final NotificationAlertStore _alertStore;
  final NotificationHistoryStore _historyStore;
  final NotificationFormattingPreferences? _formattingPreferences;

  @override
  Future<List<RecentNotificationHistoryEntry>> load() async {
    final List<Object> data = await Future.wait<Object>(<Future<Object>>[
      _historyStore.load(),
      _definitionStore.load(),
      _alertStore.load(),
    ]);
    return _buildEntries(
      data[0] as List<NotificationHistoryEntry>,
      data[1] as List<NotificationDefinition>,
      data[2] as List<NotificationAlert>,
    );
  }

  @override
  Future<RecentNotificationHistoryPage> loadPage({
    NotificationHistoryCursor? before,
    required int limit,
  }) async {
    final NotificationHistoryPage rawPage;
    if (_historyStore case final NotificationHistoryPageStore pageStore) {
      rawPage = await pageStore.loadPage(before: before, limit: limit);
    } else {
      final List<NotificationHistoryEntry> entries = before == null
          ? await _historyStore.load()
          : const <NotificationHistoryEntry>[];
      rawPage = NotificationHistoryPage(entries: entries, hasMore: false);
    }
    final List<Object> supportingData = await Future.wait<Object>(
      <Future<Object>>[_definitionStore.load(), _alertStore.load()],
    );
    return RecentNotificationHistoryPage(
      entries: _buildEntries(
        rawPage.entries,
        supportingData[0] as List<NotificationDefinition>,
        supportingData[1] as List<NotificationAlert>,
      ),
      hasMore: rawPage.hasMore,
      nextCursor: rawPage.nextCursor,
    );
  }

  List<RecentNotificationHistoryEntry> _buildEntries(
    List<NotificationHistoryEntry> notifications,
    List<NotificationDefinition> definitions,
    List<NotificationAlert> alerts,
  ) {
    final List<NotificationHistoryEntry> eligibleNotifications = notifications
        .where((NotificationHistoryEntry notification) {
          final bool hasContents =
              notification.title.trim().isNotEmpty &&
              notification.body.trim().isNotEmpty;
          final bool isMetadataOnly =
              notification.title.trim().isEmpty &&
              notification.body.trim().isEmpty;
          return (hasContents || isMetadataOnly) &&
              (notification.processingOutcome?.definition != null ||
                  definitions.any(
                    (NotificationDefinition definition) =>
                        definition.applicationId == notification.applicationId,
                  ));
        })
        .toList();
    final List<NotificationHistoryEntry> uniqueNotifications =
        <NotificationHistoryEntry>[];
    for (final NotificationHistoryEntry notification in eligibleNotifications) {
      final bool isMetadataOnly =
          notification.title.trim().isEmpty && notification.body.trim().isEmpty;
      final int repeatedDeliveryIndex = uniqueNotifications.indexWhere(
        (NotificationHistoryEntry existing) =>
            !isMetadataOnly &&
            existing.applicationId == notification.applicationId &&
            existing.title == notification.title &&
            existing.body == notification.body &&
            existing.receivedAt.difference(notification.receivedAt).abs() <=
                const Duration(seconds: 1),
      );
      if (repeatedDeliveryIndex == -1) {
        uniqueNotifications.add(notification);
      } else if (notification.receivedAt.isAfter(
        uniqueNotifications[repeatedDeliveryIndex].receivedAt,
      )) {
        uniqueNotifications[repeatedDeliveryIndex] = notification;
      }
    }
    return uniqueNotifications.map((NotificationHistoryEntry notification) {
      final NotificationHistoryReference? recordedDefinition =
          notification.processingOutcome?.definition;
      final NotificationDefinition? definition = definitions
          .cast<NotificationDefinition?>()
          .firstWhere(
            (NotificationDefinition? definition) => recordedDefinition == null
                ? definition?.applicationId == notification.applicationId
                : definition?.id == recordedDefinition.id,
            orElse: () => null,
          );
      final bool hasContents =
          notification.title.trim().isNotEmpty &&
          notification.body.trim().isNotEmpty;
      final _RecentNotificationMatch? match =
          notification.processingOutcome == null
          ? definition == null || !hasContents
                ? null
                : _matchingOutcome(definition, notification)
          : _recordedOutcome(notification.processingOutcome!, definition);
      final _RecentNotificationMatch? currentMatch =
          notification.processingOutcome != null &&
              definition != null &&
              hasContents
          ? _matchingOutcome(definition, notification)
          : null;
      return RecentNotificationHistoryEntry(
        notification: notification,
        definition: definition,
        processingFailure: _findProcessingFailure(
          notification,
          definitions,
          alerts,
        ),
        matchingRule: match?.rule,
        matchingConditionalActionGroups:
            match?.conditionalActionGroups ?? const <NotificationActionGroup>[],
        canCreateTransaction: match?.canCreateTransaction ?? false,
        processingOutcome: notification.processingOutcome,
        currentMatchingRule: currentMatch?.rule,
        currentCanCreateTransaction: currentMatch?.canCreateTransaction,
      );
    }).toList();
  }

  _RecentNotificationMatch _recordedOutcome(
    NotificationProcessingOutcome outcome,
    NotificationDefinition? definition,
  ) {
    final NotificationRule? rule = definition?.rules
        .cast<NotificationRule?>()
        .firstWhere(
          (NotificationRule? candidate) => candidate?.id == outcome.rule?.id,
          orElse: () => null,
        );
    final Set<String> groupIds = outcome.conditionalActionGroups
        .map((NotificationHistoryReference group) => group.id)
        .toSet();
    return _RecentNotificationMatch(
      rule: rule,
      canCreateTransaction: outcome.transactionPatch != null,
      conditionalActionGroups:
          rule?.conditionalActionGroups
              .where(
                (NotificationActionGroup group) => groupIds.contains(group.id),
              )
              .toList() ??
          const <NotificationActionGroup>[],
    );
  }

  _RecentNotificationMatch? _matchingOutcome(
    NotificationDefinition definition,
    NotificationHistoryEntry notification,
  ) {
    final NotificationDefinitionEvaluationResult? result = definition.evaluate(
      NotificationContext(
        applicationId: notification.applicationId,
        applicationName: definition.name,
        deliveryId: notification.id,
        title: notification.title,
        body: notification.body,
        receivedAt: notification.receivedAt,
      ),
      formattingPreferences: _formattingPreferences,
    );
    final String? ruleId = result?.selectedRuleId;
    if (ruleId == null) {
      return _RecentNotificationMatch(
        canCreateTransaction: result?.effectiveTransactionIntent != null,
      );
    }
    final NotificationRule? rule = definition.rules
        .cast<NotificationRule?>()
        .firstWhere(
          (NotificationRule? rule) => rule?.id == ruleId,
          orElse: () => null,
        );
    if (rule == null) return null;
    final NotificationRuleEvaluationResult? ruleResult =
        result?.ruleResults[ruleId];
    return _RecentNotificationMatch(
      rule: rule,
      canCreateTransaction: result?.effectiveTransactionIntent != null,
      conditionalActionGroups: <NotificationActionGroup>[
        for (final NotificationActionGroup group
            in rule.conditionalActionGroups)
          if (ruleResult?.conditionalGroups[group.id]?.matches ?? false) group,
      ],
    );
  }

  NotificationAlert? _findProcessingFailure(
    NotificationHistoryEntry notification,
    List<NotificationDefinition> definitions,
    List<NotificationAlert> alerts,
  ) {
    final bool hasRegistration = definitions.any(
      (NotificationDefinition definition) =>
          definition.applicationId == notification.applicationId,
    );
    if (!hasRegistration) {
      return null;
    }

    for (final NotificationAlert alert in alerts) {
      if (alert.definitionId == null ||
          alert.notification?.deliveryId != notification.id) {
        continue;
      }
      return alert;
    }
    return null;
  }
}

class _RecentNotificationMatch {
  const _RecentNotificationMatch({
    this.rule,
    required this.canCreateTransaction,
    this.conditionalActionGroups = const <NotificationActionGroup>[],
  });

  final NotificationRule? rule;
  final bool canCreateTransaction;
  final List<NotificationActionGroup> conditionalActionGroups;
}
