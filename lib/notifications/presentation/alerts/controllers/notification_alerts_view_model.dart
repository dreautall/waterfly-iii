import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:waterflyiii/notifications/application/alerts/dismiss_notification_alerts.dart';
import 'package:waterflyiii/notifications/application/rules/notification_rule_operations.dart';
import 'package:waterflyiii/notifications/application/rules/resolve_notification_alert_rule.dart';
import 'package:waterflyiii/notifications/application/rules/save_rule_in_definition.dart';
import 'package:waterflyiii/notifications/application/stores/notification_alert_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_definition_store.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';

enum NotificationApplicationNamesStatus { unavailable, loading, loaded, failed }

class NotificationAlertGroup {
  const NotificationAlertGroup({required this.key, required this.alerts})
    : assert(alerts.length > 0);

  final String key;
  final List<NotificationAlert> alerts;

  String? get applicationId => alerts
      .map((NotificationAlert alert) => alert.applicationId)
      .whereType<String>()
      .firstOrNull;

  NotificationAlert get primaryAlert => alerts.reduce(
    (NotificationAlert current, NotificationAlert candidate) =>
        _alertPriority(candidate.kind) > _alertPriority(current.kind)
        ? candidate
        : current,
  );

  DateTime get updatedAt => alerts
      .map((NotificationAlert alert) => alert.updatedAt)
      .reduce(
        (DateTime current, DateTime candidate) =>
            candidate.isAfter(current) ? candidate : current,
      );

  bool containsFingerprint(String fingerprint) =>
      alerts.any((NotificationAlert alert) => alert.fingerprint == fingerprint);

  static int _alertPriority(NotificationAlertKind kind) => switch (kind) {
    NotificationAlertKind.migrationFailed => 5,
    NotificationAlertKind.definitionInvalid => 4,
    NotificationAlertKind.evaluationFailed => 3,
    NotificationAlertKind.actionFailed => 2,
    NotificationAlertKind.migrationNeedsReview => 1,
  };
}

class NotificationAlertsViewModel extends ChangeNotifier {
  NotificationAlertsViewModel(
    NotificationAlertStore store, {
    NotificationDefinitionStore? definitionStore,
    NotificationRuleOperations? ruleOperations,
  }) : _store = store,
       _definitionStore = definitionStore,
       _ruleOperations =
           ruleOperations ??
           (definitionStore == null
               ? null
               : NotificationRuleOperations(definitionStore)),
       _previewAlerts = null,
       _dismissAlerts = DismissNotificationAlerts(store);

  NotificationAlertsViewModel.preview(
    List<NotificationAlert> alerts, {
    NotificationDefinitionStore? definitionStore,
    NotificationRuleOperations? ruleOperations,
  }) : _store = null,
       _definitionStore = definitionStore,
       _ruleOperations =
           ruleOperations ??
           (definitionStore == null
               ? null
               : NotificationRuleOperations(definitionStore)),
       _previewAlerts = alerts,
       _dismissAlerts = null;

  static final Logger _log = Logger('Notifications.Alerts');

  final NotificationAlertStore? _store;
  final NotificationDefinitionStore? _definitionStore;
  final NotificationRuleOperations? _ruleOperations;
  final List<NotificationAlert>? _previewAlerts;
  final DismissNotificationAlerts? _dismissAlerts;
  List<NotificationAlert> alerts = <NotificationAlert>[];
  Map<String, String> applicationNames = <String, String>{};
  NotificationApplicationNamesStatus applicationNamesStatus =
      NotificationApplicationNamesStatus.unavailable;
  Object? applicationNamesError;
  final Set<String> dismissedFingerprints = <String>{};
  Object? error;
  bool isLoading = false;
  bool isDismissingAll = false;
  int _loadGeneration = 0;

  bool get canOpenRules => _ruleOperations != null;

  List<NotificationAlert> get visibleAlerts => alerts
      .where(
        (NotificationAlert alert) =>
            !dismissedFingerprints.contains(alert.fingerprint),
      )
      .toList();

  List<NotificationAlertGroup> get visibleAlertGroups {
    final Map<String, List<NotificationAlert>> grouped =
        <String, List<NotificationAlert>>{};
    for (final NotificationAlert alert in visibleAlerts) {
      final String key = alert.applicationId?.trim().isNotEmpty ?? false
          ? 'application:${alert.applicationId}'
          : alert.definitionId?.trim().isNotEmpty ?? false
          ? 'definition:${alert.definitionId}'
          : 'alert:${alert.fingerprint}';
      grouped.putIfAbsent(key, () => <NotificationAlert>[]).add(alert);
    }
    return grouped.entries
        .map(
          (MapEntry<String, List<NotificationAlert>> entry) =>
              NotificationAlertGroup(
                key: entry.key,
                alerts: List<NotificationAlert>.unmodifiable(entry.value),
              ),
        )
        .toList(growable: false);
  }

  Future<void> load() async {
    final int loadGeneration = ++_loadGeneration;
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      final List<NotificationAlert> loadedAlerts =
          _previewAlerts ?? await _store!.load();
      if (loadGeneration != _loadGeneration) return;
      alerts = loadedAlerts;
    } catch (loadError) {
      if (loadGeneration != _loadGeneration) return;
      error = loadError;
      alerts = <NotificationAlert>[];
    } finally {
      if (loadGeneration == _loadGeneration) {
        isLoading = false;
        notifyListeners();
      }
    }
    if (loadGeneration == _loadGeneration) {
      await _loadApplicationNames();
    }
  }

  Future<ResolveNotificationAlertRuleResult> resolveRule(
    NotificationAlert alert,
  ) =>
      _ruleOperations?.resolveAlertRule(alert) ??
      Future<ResolveNotificationAlertRuleResult>.value(
        const ResolveNotificationAlertRuleResult.notFound(),
      );

  Future<SaveRuleInDefinitionResult> updateRule({
    required NotificationDefinition definition,
    required NotificationRule originalRule,
    required NotificationRule rule,
  }) =>
      _ruleOperations?.update(
        definitionId: definition.id,
        originalRuleId: originalRule.id,
        rule: rule,
      ) ??
      Future<SaveRuleInDefinitionResult>.value(
        const SaveRuleInDefinitionResult(SaveRuleInDefinitionStatus.failed),
      );

  Future<SaveRuleInDefinitionResult> deleteRule({
    required NotificationDefinition definition,
    required NotificationRule rule,
  }) =>
      _ruleOperations?.delete(definitionId: definition.id, ruleId: rule.id) ??
      Future<SaveRuleInDefinitionResult>.value(
        const SaveRuleInDefinitionResult(SaveRuleInDefinitionStatus.failed),
      );

  Future<void> _loadApplicationNames() async {
    final NotificationDefinitionStore? definitionStore = _definitionStore;
    if (definitionStore == null) {
      applicationNamesStatus = NotificationApplicationNamesStatus.unavailable;
      applicationNames = <String, String>{};
      applicationNamesError = null;
      notifyListeners();
      return;
    }
    applicationNamesStatus = NotificationApplicationNamesStatus.loading;
    applicationNamesError = null;
    notifyListeners();
    try {
      final List<NotificationDefinition> definitions = await definitionStore
          .load();
      applicationNames = <String, String>{
        for (final NotificationDefinition definition in definitions)
          definition.applicationId: definition.name,
      };
      applicationNamesStatus = NotificationApplicationNamesStatus.loaded;
    } catch (loadError, stackTrace) {
      applicationNames = <String, String>{};
      applicationNamesError = loadError;
      applicationNamesStatus = NotificationApplicationNamesStatus.failed;
      _log.warning(
        'Could not load application names for notification alerts.',
        loadError,
        stackTrace,
      );
    } finally {
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    dismissedFingerprints.clear();
    await load();
  }

  Future<DismissNotificationAlertsResult> dismissAll(
    List<NotificationAlert> alerts,
  ) async {
    isDismissingAll = true;
    notifyListeners();
    try {
      final DismissNotificationAlertsResult result = await _dismiss(alerts);
      dismissedFingerprints.addAll(
        result.completed.map((NotificationAlert alert) => alert.fingerprint),
      );
      return result;
    } finally {
      isDismissingAll = false;
      notifyListeners();
    }
  }

  Future<DismissNotificationAlertsResult> dismiss(
    NotificationAlert alert,
  ) async {
    final DismissNotificationAlertsResult result = await _dismiss(
      <NotificationAlert>[alert],
    );
    dismissedFingerprints.addAll(
      result.completed.map((NotificationAlert item) => item.fingerprint),
    );
    notifyListeners();
    return result;
  }

  Future<DismissNotificationAlertsResult> restore(
    List<NotificationAlert> alerts,
  ) async {
    final DismissNotificationAlertsResult result = _previewAlerts != null
        ? DismissNotificationAlertsResult(
            completed: alerts,
            failures: const <NotificationAlert>[],
          )
        : await _dismissAlerts!.restore(alerts);
    dismissedFingerprints.removeAll(
      result.completed.map((NotificationAlert alert) => alert.fingerprint),
    );
    notifyListeners();
    return result;
  }

  Future<DismissNotificationAlertsResult> _dismiss(
    List<NotificationAlert> alerts,
  ) => _previewAlerts != null
      ? Future<DismissNotificationAlertsResult>.value(
          DismissNotificationAlertsResult(
            completed: alerts,
            failures: const <NotificationAlert>[],
          ),
        )
      : _dismissAlerts!.dismiss(alerts);
}
