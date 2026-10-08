import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/alerts/dismiss_notification_alerts.dart';
import 'package:waterflyiii/notifications/application/rules/resolve_notification_alert_rule.dart';
import 'package:waterflyiii/notifications/application/rules/save_rule_in_definition.dart';
import 'package:waterflyiii/notifications/application/stores/notification_alert_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_definition_store.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/presentation/alerts/controllers/notification_alerts_view_model.dart';

class DelayedAlertStore implements NotificationAlertStore {
  final List<Completer<List<NotificationAlert>>> _loads =
      <Completer<List<NotificationAlert>>>[];

  @override
  Future<List<NotificationAlert>> load() {
    final Completer<List<NotificationAlert>> load =
        Completer<List<NotificationAlert>>();
    _loads.add(load);
    return load.future;
  }

  Completer<List<NotificationAlert>> takePendingLoad() => _loads.removeAt(0);

  @override
  Future<void> clearForApplication(String applicationId) async {}

  @override
  Future<void> clearAll() async {}

  @override
  Future<void> dismiss(String fingerprint) async {}

  @override
  Future<void> record(NotificationAlert alert) async {}

  @override
  Future<void> restore(NotificationAlert alert) async {}
}

class InMemoryAlertStore implements NotificationAlertStore {
  InMemoryAlertStore({
    this.alerts = const <NotificationAlert>[],
    this.loadError,
    this.dismissFailures = const <String>{},
    this.restoreFailures = const <String>{},
  });

  List<NotificationAlert> alerts;
  final Object? loadError;
  final Set<String> dismissFailures;
  final Set<String> restoreFailures;

  @override
  Future<List<NotificationAlert>> load() {
    if (loadError != null) {
      return Future<List<NotificationAlert>>.error(loadError!);
    }
    return Future<List<NotificationAlert>>.value(alerts);
  }

  @override
  Future<void> clearForApplication(String applicationId) async {}

  @override
  Future<void> clearAll() async {
    alerts = <NotificationAlert>[];
  }

  @override
  Future<void> dismiss(String fingerprint) async {
    if (dismissFailures.contains(fingerprint)) {
      throw StateError('Dismiss failed');
    }
  }

  @override
  Future<void> record(NotificationAlert alert) async {}

  @override
  Future<void> restore(NotificationAlert alert) async {
    if (restoreFailures.contains(alert.fingerprint)) {
      throw StateError('Restore failed');
    }
  }
}

class InMemoryDefinitionStore implements NotificationDefinitionStore {
  InMemoryDefinitionStore(this.definitions, {this.loadError, this.saveError});

  List<NotificationDefinition> definitions;
  final Object? loadError;
  final Object? saveError;

  @override
  Future<List<NotificationDefinition>> load() async {
    if (loadError != null) throw loadError!;
    return definitions;
  }

  @override
  Future<void> save(List<NotificationDefinition> definitions) async {
    if (saveError != null) throw saveError!;
    this.definitions = definitions;
  }
}

NotificationAlert alert(String fingerprint) => NotificationAlert(
  fingerprint: fingerprint,
  kind: NotificationAlertKind.actionFailed,
  operation: 'action',
  message: 'Failed',
  createdAt: DateTime(2026, 9, 14),
  updatedAt: DateTime(2026, 9, 14),
  occurrenceCount: 1,
);

const NotificationRule savedRule = NotificationRule(
  id: 'rule-id',
  name: 'Saved rule',
  conditions: <NotificationCondition>[],
  actions: <NotificationAction>[],
);

const NotificationDefinition savedDefinition = NotificationDefinition(
  id: 'definition-id',
  applicationId: 'com.example.bank',
  name: 'Example Bank',
  extractors: <RegExpDefinition>[],
  rules: <NotificationRule>[savedRule],
);

NotificationAlert ruleAlert({
  String definitionId = 'definition-id',
  String ruleId = 'rule-id',
}) => NotificationAlert(
  fingerprint: 'rule-alert',
  kind: NotificationAlertKind.evaluationFailed,
  operation: 'Evaluating rule',
  message: 'Failed',
  createdAt: DateTime(2026, 9, 14),
  updatedAt: DateTime(2026, 9, 14),
  occurrenceCount: 1,
  applicationId: 'com.example.bank',
  definitionId: definitionId,
  ruleId: ruleId,
);

void main() {
  test(
    'keeps the newest alert load when requests complete out of order',
    () async {
      final DelayedAlertStore store = DelayedAlertStore();
      final NotificationAlertsViewModel viewModel = NotificationAlertsViewModel(
        store,
      );

      final Future<void> firstLoad = viewModel.load();
      final Future<void> secondLoad = viewModel.load();
      final Completer<List<NotificationAlert>> firstResponse = store
          .takePendingLoad();
      final Completer<List<NotificationAlert>> secondResponse = store
          .takePendingLoad();
      secondResponse.complete(<NotificationAlert>[alert('new')]);
      await secondLoad;
      firstResponse.complete(<NotificationAlert>[alert('old')]);
      await firstLoad;

      expect(viewModel.alerts.single.fingerprint, 'new');
      expect(viewModel.isLoading, isFalse);
    },
  );

  test('captures alert loading failures without remaining busy', () async {
    final NotificationAlertsViewModel viewModel = NotificationAlertsViewModel(
      InMemoryAlertStore(loadError: StateError('Database unavailable')),
    );

    await viewModel.load();

    expect(viewModel.alerts, isEmpty);
    expect(viewModel.error, isA<StateError>());
    expect(viewModel.isLoading, isFalse);
  });

  test('groups visible alerts by application while preserving order', () async {
    final NotificationAlert first = NotificationAlert.failure(
      kind: NotificationAlertKind.migrationNeedsReview,
      operation: 'Review import',
      message: 'First issue',
      applicationId: 'com.example.bank',
    );
    final NotificationAlert second = NotificationAlert.failure(
      kind: NotificationAlertKind.migrationNeedsReview,
      operation: 'Review import',
      message: 'Second issue',
      applicationId: 'com.example.bank',
    );
    final NotificationAlert unrelated = NotificationAlert.failure(
      kind: NotificationAlertKind.actionFailed,
      operation: 'Apply action',
      message: 'Other issue',
      applicationId: 'com.example.card',
    );
    final NotificationAlertsViewModel viewModel =
        NotificationAlertsViewModel.preview(<NotificationAlert>[
          first,
          second,
          unrelated,
        ]);

    await viewModel.load();

    expect(viewModel.visibleAlertGroups, hasLength(2));
    expect(viewModel.visibleAlertGroups.first.alerts, <NotificationAlert>[
      first,
      second,
    ]);
    expect(viewModel.visibleAlertGroups.last.alerts, <NotificationAlert>[
      unrelated,
    ]);
  });

  test('loads application names and resolves an alert rule', () async {
    final NotificationAlertsViewModel viewModel = NotificationAlertsViewModel(
      InMemoryAlertStore(),
      definitionStore: InMemoryDefinitionStore(<NotificationDefinition>[
        savedDefinition,
      ]),
    );

    await viewModel.load();
    final ResolveNotificationAlertRuleResult result = await viewModel
        .resolveRule(ruleAlert());

    expect(
      viewModel.applicationNamesStatus,
      NotificationApplicationNamesStatus.loaded,
    );
    expect(viewModel.applicationNames, <String, String>{
      'com.example.bank': 'Example Bank',
    });
    expect(result.status, ResolveNotificationAlertRuleStatus.resolved);
    expect(result.definition, savedDefinition);
    expect(result.rule, savedRule);
  });

  test('reports missing alert rules as not found', () async {
    final NotificationAlertsViewModel viewModel = NotificationAlertsViewModel(
      InMemoryAlertStore(),
      definitionStore: InMemoryDefinitionStore(<NotificationDefinition>[
        savedDefinition,
      ]),
    );

    final ResolveNotificationAlertRuleResult result = await viewModel
        .resolveRule(ruleAlert(ruleId: 'missing'));

    expect(result.status, ResolveNotificationAlertRuleStatus.notFound);
  });

  test(
    'exposes application-name loading failures with fallback data',
    () async {
      final StateError loadError = StateError('Definitions unavailable');
      final NotificationAlertsViewModel viewModel = NotificationAlertsViewModel(
        InMemoryAlertStore(),
        definitionStore: InMemoryDefinitionStore(
          <NotificationDefinition>[],
          loadError: loadError,
        ),
      );

      await viewModel.load();

      expect(
        viewModel.applicationNamesStatus,
        NotificationApplicationNamesStatus.failed,
      );
      expect(viewModel.applicationNamesError, same(loadError));
      expect(viewModel.applicationNames, isEmpty);
    },
  );

  test('returns typed update and delete failures', () async {
    final NotificationAlertsViewModel viewModel = NotificationAlertsViewModel(
      InMemoryAlertStore(),
      definitionStore: InMemoryDefinitionStore(<NotificationDefinition>[
        savedDefinition,
      ], saveError: StateError('Write failed')),
    );
    const NotificationRule changedRule = NotificationRule(
      id: 'rule-id',
      name: 'Changed rule',
      conditions: <NotificationCondition>[],
      actions: <NotificationAction>[],
    );

    final SaveRuleInDefinitionResult updateResult = await viewModel.updateRule(
      definition: savedDefinition,
      originalRule: savedRule,
      rule: changedRule,
    );
    final SaveRuleInDefinitionResult deleteResult = await viewModel.deleteRule(
      definition: savedDefinition,
      rule: savedRule,
    );

    expect(updateResult.status, SaveRuleInDefinitionStatus.failed);
    expect(deleteResult.status, SaveRuleInDefinitionStatus.failed);
  });

  test('keeps partial dismiss and restore failures visible', () async {
    final NotificationAlert successful = alert('successful');
    final NotificationAlert failed = alert('failed');
    final NotificationAlertsViewModel viewModel = NotificationAlertsViewModel(
      InMemoryAlertStore(
        alerts: <NotificationAlert>[successful, failed],
        dismissFailures: <String>{failed.fingerprint},
        restoreFailures: <String>{successful.fingerprint},
      ),
    );
    await viewModel.load();

    final DismissNotificationAlertsResult dismissResult = await viewModel
        .dismissAll(<NotificationAlert>[successful, failed]);

    expect(dismissResult.completed, <NotificationAlert>[successful]);
    expect(dismissResult.failures, <NotificationAlert>[failed]);
    expect(viewModel.visibleAlerts, <NotificationAlert>[failed]);

    final DismissNotificationAlertsResult restoreResult = await viewModel
        .restore(<NotificationAlert>[successful]);

    expect(restoreResult.completed, isEmpty);
    expect(restoreResult.failures, <NotificationAlert>[successful]);
    expect(viewModel.visibleAlerts, <NotificationAlert>[failed]);
  });

  test('preview refresh restores locally dismissed alerts', () async {
    final NotificationAlert previewAlert = alert('preview');
    final NotificationAlertsViewModel viewModel =
        NotificationAlertsViewModel.preview(<NotificationAlert>[previewAlert]);
    await viewModel.load();
    await viewModel.dismiss(previewAlert);

    expect(viewModel.visibleAlerts, isEmpty);

    await viewModel.refresh();

    expect(viewModel.visibleAlerts, <NotificationAlert>[previewAlert]);
    expect(viewModel.error, isNull);
  });
}
