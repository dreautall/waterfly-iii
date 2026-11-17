import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/definitions/save_notification_definition.dart';
import 'package:waterflyiii/notifications/application/migrations/pending_notification_migration_completion_service.dart';
import 'package:waterflyiii/notifications/application/resources/firefly_currency_resolver.dart';
import 'package:waterflyiii/notifications/application/resources/application_name_resolver.dart';
import 'package:waterflyiii/notifications/application/stores/notification_definition_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_alert_store.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/currency_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';
import 'package:waterflyiii/notifications/presentation/definitions/controllers/notification_definitions_view_model.dart';

class InMemoryDefinitionStore implements AtomicNotificationDefinitionStore {
  InMemoryDefinitionStore(this.definitions, {this.error});

  List<NotificationDefinition> definitions;
  final Object? error;
  List<NotificationDefinition>? savedDefinitions;

  @override
  Future<List<NotificationDefinition>> load() {
    if (error != null) {
      return Future<List<NotificationDefinition>>.error(error!);
    }
    return Future<List<NotificationDefinition>>.value(definitions);
  }

  @override
  Future<void> save(List<NotificationDefinition> definitions) async {
    savedDefinitions = definitions;
    this.definitions = definitions;
  }

  @override
  Future<T> mutate<T>(
    NotificationDefinitionMutation<T> Function(
      List<NotificationDefinition> definitions,
    )
    mutation,
  ) async {
    final List<NotificationDefinition> current =
        List<NotificationDefinition>.of(definitions);
    final NotificationDefinitionMutation<T> result = mutation(current);
    if (result.changed) {
      definitions = current;
      savedDefinitions = current;
    }
    return result.value;
  }
}

class DelayedDefinitionStore implements NotificationDefinitionStore {
  final List<Completer<List<NotificationDefinition>>> _loads =
      <Completer<List<NotificationDefinition>>>[];

  @override
  Future<List<NotificationDefinition>> load() {
    final Completer<List<NotificationDefinition>> load =
        Completer<List<NotificationDefinition>>();
    _loads.add(load);
    return load.future;
  }

  Completer<List<NotificationDefinition>> takePendingLoad() =>
      _loads.removeAt(0);

  @override
  Future<void> save(List<NotificationDefinition> definitions) async {}
}

NotificationDefinitionsViewModel definitionsViewModel(
  InMemoryDefinitionStore store, {
  InMemoryAlertStore? alertStore,
  ApplicationNameResolver? applicationNameResolver,
}) => NotificationDefinitionsViewModel(
  store,
  SaveNotificationDefinition(store, alertStore: alertStore),
  alertStore: alertStore,
  applicationNameResolver: applicationNameResolver,
);

class _ApplicationNameResolver implements ApplicationNameResolver {
  const _ApplicationNameResolver(this.name);

  final String? name;

  @override
  Future<String?> resolve(String applicationId) async => name;
}

class _DelayedApplicationNameResolver implements ApplicationNameResolver {
  final Completer<void> started = Completer<void>();
  final Completer<String?> result = Completer<String?>();

  @override
  Future<String?> resolve(String applicationId) {
    started.complete();
    return result.future;
  }
}

class _CurrencyGateway implements FireflyCurrencyGateway {
  const _CurrencyGateway();

  @override
  Future<List<FireflyCurrency>> search(String query) async =>
      const <FireflyCurrency>[
        FireflyCurrency(
          id: 'cad',
          name: 'Canadian Dollar',
          code: 'CAD',
          symbol: r'$',
        ),
      ];
}

class InMemoryAlertStore implements NotificationAlertStore {
  InMemoryAlertStore([this.alerts = const <NotificationAlert>[]]);

  List<NotificationAlert> alerts;
  String? clearedApplicationId;

  @override
  Future<void> clearForApplication(String applicationId) async {
    clearedApplicationId = applicationId;
  }

  @override
  Future<void> clearAll() async {}

  @override
  Future<void> dismiss(String fingerprint) async {
    alerts = alerts
        .where((NotificationAlert alert) => alert.fingerprint != fingerprint)
        .toList();
  }

  @override
  Future<List<NotificationAlert>> load() async => alerts;

  @override
  Future<void> record(NotificationAlert alert) async {}

  @override
  Future<void> restore(NotificationAlert alert) async {}
}

void main() {
  // Ensures the definition list controller exposes the stored cards after a
  // successful load, without coupling the presentation layer to SQLCipher.
  test('loads notification definitions from its store', () async {
    final NotificationDefinitionsViewModel controller = definitionsViewModel(
      InMemoryDefinitionStore(<NotificationDefinition>[
        const NotificationDefinition(
          id: 'bank',
          applicationId: 'com.example.bank',
          name: 'Example Bank',
          extractors: <RegExpDefinition>[],
          rules: <NotificationRule>[],
        ),
      ]),
    );

    await controller.load();

    expect(controller.error, isNull);
    expect(controller.isLoading, isFalse);
    expect(controller.definitions.single.name, 'Example Bank');
  });

  test(
    'associates outstanding migration alerts with their definition',
    () async {
      const NotificationDefinition definition = NotificationDefinition(
        id: 'bank',
        applicationId: 'com.example.bank',
        name: 'Example Bank',
        extractors: <RegExpDefinition>[],
        rules: <NotificationRule>[],
        requiresMigrationReview: true,
        migrationReviewIssues: <NotificationMigrationIssue>{
          NotificationMigrationIssue.missingAutomaticAccount,
        },
      );
      final NotificationAlert migrationAlert = NotificationAlert.failure(
        kind: NotificationAlertKind.migrationNeedsReview,
        operation: 'Reviewing imported notification settings',
        message: 'Choose an account.',
        applicationId: definition.applicationId,
        definitionId: definition.id,
        migrationIssue: NotificationMigrationIssue.missingAutomaticAccount,
      );
      final NotificationDefinitionsViewModel controller = definitionsViewModel(
        InMemoryDefinitionStore(<NotificationDefinition>[definition]),
        alertStore: InMemoryAlertStore(<NotificationAlert>[
          migrationAlert,
          NotificationAlert.failure(
            kind: NotificationAlertKind.actionFailed,
            operation: 'Applying action',
            message: 'Failed.',
            applicationId: definition.applicationId,
          ),
        ]),
      );

      await controller.load();

      expect(controller.migrationAlertsFor(definition), <NotificationAlert>[
        migrationAlert,
      ]);
    },
  );

  test('refreshes a missing installed application name on load', () async {
    const NotificationDefinition definition = NotificationDefinition(
      id: 'bank',
      applicationId: 'com.example.bank',
      name: 'com.example.bank',
      extractors: <RegExpDefinition>[],
      rules: <NotificationRule>[],
      requiresMigrationReview: true,
      migrationReviewIssues: <NotificationMigrationIssue>{
        NotificationMigrationIssue.missingApplicationName,
      },
    );
    final InMemoryDefinitionStore store = InMemoryDefinitionStore(
      <NotificationDefinition>[definition],
    );
    final InMemoryAlertStore alerts = InMemoryAlertStore(<NotificationAlert>[
      NotificationAlert.failure(
        kind: NotificationAlertKind.migrationNeedsReview,
        operation: 'Reviewing imported notification settings',
        message: 'Choose an application.',
        applicationId: definition.applicationId,
        definitionId: definition.id,
        migrationIssue: NotificationMigrationIssue.missingApplicationName,
      ),
    ]);
    final NotificationDefinitionsViewModel controller = definitionsViewModel(
      store,
      alertStore: alerts,
      applicationNameResolver: const _ApplicationNameResolver('Example Bank'),
    );

    await controller.load();

    expect(controller.definitions.single.name, 'Example Bank');
    expect(controller.definitions.single.requiresMigrationReview, isFalse);
    expect(controller.definitions.single.migrationReviewIssues, isEmpty);
    expect(store.definitions.single.name, 'Example Bank');
    expect(alerts.alerts, isEmpty);
  });

  test(
    'merges a delayed application name into a completed migration',
    () async {
      const NotificationDefinition definition = NotificationDefinition(
        id: 'legacy:com.example.bank',
        applicationId: 'com.example.bank',
        name: 'com.example.bank',
        extractors: <RegExpDefinition>[],
        rules: <NotificationRule>[],
        requiresMigrationReview: true,
        migrationReviewIssues: <NotificationMigrationIssue>{
          NotificationMigrationIssue.missingApplicationName,
          NotificationMigrationIssue.missingSettings,
        },
      );
      final InMemoryDefinitionStore store = InMemoryDefinitionStore(
        <NotificationDefinition>[definition],
      );
      final InMemoryAlertStore alerts = InMemoryAlertStore();
      final _DelayedApplicationNameResolver resolver =
          _DelayedApplicationNameResolver();
      final NotificationDefinitionsViewModel controller = definitionsViewModel(
        store,
        alertStore: alerts,
        applicationNameResolver: resolver,
      );

      final Future<void> load = controller.load();
      await resolver.started.future;
      await PendingNotificationMigrationCompletionService(
        definitionStore: store,
        alertStore: alerts,
        currencyResolver: const FireflyCurrencyResolver(_CurrencyGateway()),
      ).complete(
        NotificationContext(
          applicationId: definition.applicationId,
          title: 'Card payment',
          body: 'Paid 12.50 CAD',
          receivedAt: DateTime(2026, 11, 16, 12, 30),
        ),
      );
      resolver.result.complete('Example Bank');
      await load;

      expect(store.definitions.single.name, 'Example Bank');
      expect(store.definitions.single.sampleBody, 'Paid 12.50 CAD');
      expect(store.definitions.single.migrationReviewIssues, isEmpty);
      expect(store.definitions.single.requiresMigrationReview, isFalse);
      expect(
        store.definitions.single.status,
        NotificationDefinitionStatus.ready,
      );
    },
  );

  test('dismisses stale migration alerts while loading', () async {
    const NotificationDefinition definition = NotificationDefinition(
      id: 'bank',
      applicationId: 'com.example.bank',
      name: 'Example Bank',
      extractors: <RegExpDefinition>[],
      rules: <NotificationRule>[],
    );
    final NotificationAlert staleAlert = NotificationAlert.failure(
      kind: NotificationAlertKind.migrationNeedsReview,
      operation: 'Reviewing imported notification settings',
      message: 'Enter a sample.',
      applicationId: definition.applicationId,
      definitionId: definition.id,
      migrationIssue: NotificationMigrationIssue.sampleMissing,
    );
    final InMemoryAlertStore alerts = InMemoryAlertStore(<NotificationAlert>[
      staleAlert,
    ]);
    final NotificationDefinitionsViewModel controller = definitionsViewModel(
      InMemoryDefinitionStore(<NotificationDefinition>[definition]),
      alertStore: alerts,
    );

    await controller.load();

    expect(controller.migrationAlerts, isEmpty);
    expect(alerts.alerts, isEmpty);
  });

  test('clears a currency migration alert after mapping it', () async {
    const NotificationDefinition definition = NotificationDefinition(
      id: 'bank',
      applicationId: 'com.example.bank',
      name: 'Example Bank',
      extractors: <RegExpDefinition>[],
      rules: <NotificationRule>[],
      sharedActions: <NotificationAction>[
        SetTransactionFieldAction(
          target: TransactionField.currency,
          valueSource: RegExpCaptureValueSource(
            extractorId: 'currency-extractor',
            captureName: 'currency',
          ),
        ),
      ],
    );
    final InMemoryDefinitionStore store = InMemoryDefinitionStore(
      <NotificationDefinition>[definition],
    );
    final InMemoryAlertStore alerts = InMemoryAlertStore(<NotificationAlert>[
      NotificationAlert.failure(
        kind: NotificationAlertKind.migrationNeedsReview,
        operation: 'Reviewing imported notification settings',
        message: 'Choose a currency.',
        applicationId: definition.applicationId,
        definitionId: definition.id,
        migrationIssue: NotificationMigrationIssue.currencyUnresolved,
      ),
    ]);
    final NotificationDefinitionsViewModel controller = definitionsViewModel(
      store,
      alertStore: alerts,
    );
    controller.definitions = store.definitions;

    await controller.update(
      definition.copyWith(
        sharedActions: const <NotificationAction>[
          SetTransactionFieldAction(
            target: TransactionField.currency,
            valueSource: CurrencyCaptureValueSource(
              capture: RegExpCaptureValueSource(
                extractorId: 'currency-extractor',
                captureName: 'currency',
              ),
              resourceId: '1',
            ),
          ),
        ],
      ),
    );

    expect(alerts.alerts, isEmpty);
  });

  test('clears a missing-name migration alert after renaming', () async {
    const NotificationDefinition definition = NotificationDefinition(
      id: 'bank',
      applicationId: 'com.example.bank',
      name: 'com.example.bank',
      extractors: <RegExpDefinition>[],
      rules: <NotificationRule>[],
    );
    final InMemoryDefinitionStore store = InMemoryDefinitionStore(
      <NotificationDefinition>[definition],
    );
    final InMemoryAlertStore alerts = InMemoryAlertStore(<NotificationAlert>[
      NotificationAlert.failure(
        kind: NotificationAlertKind.migrationNeedsReview,
        operation: 'Reviewing imported notification settings',
        message: 'Enter an application name.',
        applicationId: definition.applicationId,
        definitionId: definition.id,
        migrationIssue: NotificationMigrationIssue.missingApplicationName,
      ),
    ]);
    final NotificationDefinitionsViewModel controller = definitionsViewModel(
      store,
      alertStore: alerts,
    );
    controller.definitions = store.definitions;

    await controller.update(
      definition.copyWith(
        applicationId: 'com.installed.bank',
        name: 'Example Bank',
      ),
    );

    expect(alerts.alerts, isEmpty);
  });

  test('clears reviewed migration alerts after an explicit save', () async {
    const NotificationDefinition definition = NotificationDefinition(
      id: 'bank',
      applicationId: 'com.example.bank',
      name: 'Example Bank',
      extractors: <RegExpDefinition>[],
      rules: <NotificationRule>[],
      requiresMigrationReview: true,
      migrationReviewIssues: <NotificationMigrationIssue>{
        NotificationMigrationIssue.sampleMissing,
        NotificationMigrationIssue.missingSettings,
      },
    );
    final NotificationAlert failure = NotificationAlert.failure(
      kind: NotificationAlertKind.migrationFailed,
      operation: 'Migrating notification settings',
      message: 'Migration failed.',
      applicationId: definition.applicationId,
      definitionId: definition.id,
    );
    final InMemoryDefinitionStore store = InMemoryDefinitionStore(
      <NotificationDefinition>[definition],
    );
    final InMemoryAlertStore alerts = InMemoryAlertStore(<NotificationAlert>[
      NotificationAlert.failure(
        kind: NotificationAlertKind.migrationNeedsReview,
        operation: 'Reviewing imported notification settings',
        message: 'Enter a sample.',
        applicationId: definition.applicationId,
        definitionId: definition.id,
        migrationIssue: NotificationMigrationIssue.sampleMissing,
      ),
      NotificationAlert.failure(
        kind: NotificationAlertKind.migrationNeedsReview,
        operation: 'Reviewing imported notification settings',
        message: 'Create a setup.',
        applicationId: definition.applicationId,
        definitionId: definition.id,
        migrationIssue: NotificationMigrationIssue.missingSettings,
      ),
      failure,
    ]);
    final NotificationDefinitionsViewModel controller = definitionsViewModel(
      store,
      alertStore: alerts,
    )..definitions = store.definitions;

    await controller.update(
      definition.copyWith(
        requiresMigrationReview: false,
        migrationReviewIssues: const <NotificationMigrationIssue>{},
      ),
    );

    expect(alerts.alerts, <NotificationAlert>[failure]);
  });

  test(
    'rejects rebinding to an application that is already registered',
    () async {
      const NotificationDefinition unknown = NotificationDefinition(
        id: 'unknown',
        applicationId: 'com.legacy.unknown',
        name: 'com.legacy.unknown',
        extractors: <RegExpDefinition>[],
        rules: <NotificationRule>[],
      );
      final InMemoryDefinitionStore store =
          InMemoryDefinitionStore(<NotificationDefinition>[
            unknown,
            const NotificationDefinition(
              id: 'existing',
              applicationId: 'com.example.bank',
              name: 'Example Bank',
              extractors: <RegExpDefinition>[],
              rules: <NotificationRule>[],
            ),
          ]);
      final NotificationDefinitionsViewModel controller = definitionsViewModel(
        store,
      );
      controller.definitions = store.definitions;

      final SaveNotificationDefinitionResult result = await controller.update(
        unknown.copyWith(
          applicationId: 'com.example.bank',
          name: 'Example Bank',
        ),
      );

      expect(result.status, SaveNotificationDefinitionStatus.duplicate);
      expect(store.savedDefinitions, isNull);
    },
  );

  test('clears an invalid-regex migration alert after correction', () async {
    final RegExpDefinition invalid =
        RegExpDefinition.createCustomRegExpDefinition('Imported matcher', '[');
    final NotificationDefinition definition = NotificationDefinition(
      id: 'bank',
      applicationId: 'com.example.bank',
      name: 'Example Bank',
      sampleTitle: 'Payment',
      sampleBody: 'Paid 12.50',
      extractors: <RegExpDefinition>[invalid],
      rules: const <NotificationRule>[],
      extractorMode: NotificationExtractorMode.advanced,
    );
    final InMemoryDefinitionStore store = InMemoryDefinitionStore(
      <NotificationDefinition>[definition],
    );
    final InMemoryAlertStore alerts = InMemoryAlertStore(<NotificationAlert>[
      NotificationAlert.failure(
        kind: NotificationAlertKind.migrationNeedsReview,
        operation: 'Reviewing imported notification settings',
        message: 'Correct the expression.',
        applicationId: definition.applicationId,
        definitionId: definition.id,
        migrationIssue: NotificationMigrationIssue.invalidRegularExpression,
      ),
    ]);
    final NotificationDefinitionsViewModel controller = definitionsViewModel(
      store,
      alertStore: alerts,
    );
    controller.definitions = store.definitions;

    await controller.update(
      definition.copyWith(
        extractors: <RegExpDefinition>[
          invalid.copyWith(source: r'Paid (?<amount>\d+\.\d{2})'),
        ],
      ),
    );

    expect(alerts.alerts, isEmpty);
  });

  // Ensures an unavailable encrypted store produces a visible page error
  // state instead of leaving the definitions list in a loading state.
  test('captures a definition loading failure', () async {
    final NotificationDefinitionsViewModel controller = definitionsViewModel(
      InMemoryDefinitionStore(
        <NotificationDefinition>[],
        error: StateError('Database unavailable'),
      ),
    );
    controller.definitions = <NotificationDefinition>[
      const NotificationDefinition(
        id: 'stale-definition',
        applicationId: 'com.example.stale',
        name: 'Stale Definition',
        extractors: <RegExpDefinition>[],
        rules: <NotificationRule>[],
      ),
    ];

    await controller.load();

    expect(controller.error, isA<StateError>());
    expect(controller.isLoading, isFalse);
    expect(controller.definitions, isEmpty);
  });

  // Verifies a selected app becomes an encrypted-store definition immediately,
  // while keeping the initial app list screen free of editor navigation.
  test('adds an application as an empty notification definition', () async {
    final InMemoryDefinitionStore store = InMemoryDefinitionStore(
      <NotificationDefinition>[],
    );
    final NotificationDefinitionsViewModel controller = definitionsViewModel(
      store,
    );

    final bool wasAdded = (await controller.addApplication(
      applicationId: 'com.example.bank',
      applicationName: 'Example Bank',
    )).succeeded;

    expect(wasAdded, isTrue);
    expect(store.savedDefinitions, hasLength(1));
    expect(controller.definitions.single.applicationId, 'com.example.bank');
    expect(controller.definitions.single.extractors, isEmpty);
    expect(controller.definitions.single.rules, isEmpty);
  });

  // Prevents duplicate app cards until the editor supports intentional multiple
  // definitions per app, making selection and later editing unambiguous.
  test('does not add a duplicate application definition', () async {
    final InMemoryDefinitionStore store =
        InMemoryDefinitionStore(<NotificationDefinition>[
          const NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            extractors: <RegExpDefinition>[],
            rules: <NotificationRule>[],
          ),
        ]);
    final NotificationDefinitionsViewModel controller = definitionsViewModel(
      store,
    )..definitions = store.definitions;

    final bool wasAdded = (await controller.addApplication(
      applicationId: 'com.example.bank',
      applicationName: 'Example Bank',
    )).succeeded;

    expect(wasAdded, isFalse);
    expect(store.savedDefinitions, isNull);
  });

  // Verifies a confirmed removal persists the remaining definitions before the
  // UI updates, so deleted registrations stop notification processing.
  test('deletes an existing notification definition', () async {
    final InMemoryDefinitionStore store =
        InMemoryDefinitionStore(<NotificationDefinition>[
          const NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            extractors: <RegExpDefinition>[],
            rules: <NotificationRule>[],
          ),
        ]);
    final NotificationDefinitionsViewModel controller = definitionsViewModel(
      store,
    )..definitions = store.definitions;

    final bool wasDeleted = (await controller.delete('bank')).succeeded;

    expect(wasDeleted, isTrue);
    expect(store.savedDefinitions, isEmpty);
    expect(controller.definitions, isEmpty);
  });

  test('clears alerts for a deleted application registration', () async {
    final InMemoryDefinitionStore store =
        InMemoryDefinitionStore(<NotificationDefinition>[
          const NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            extractors: <RegExpDefinition>[],
            rules: <NotificationRule>[],
          ),
        ]);
    final InMemoryAlertStore alertStore = InMemoryAlertStore();
    final NotificationDefinitionsViewModel controller = definitionsViewModel(
      store,
      alertStore: alertStore,
    )..definitions = store.definitions;

    expect((await controller.delete('bank')).succeeded, isTrue);
    expect(alertStore.clearedApplicationId, 'com.example.bank');
  });

  // Avoids unnecessary writes when a stale card requests deletion after the
  // definition list has already changed.
  test('does not save when deleting a missing definition', () async {
    final InMemoryDefinitionStore store = InMemoryDefinitionStore(
      <NotificationDefinition>[],
    );
    final NotificationDefinitionsViewModel controller = definitionsViewModel(
      store,
    );

    expect((await controller.delete('missing')).succeeded, isFalse);
    expect(store.savedDefinitions, isNull);
  });

  // Replaces only the matching stored definition so the editor can persist its
  // draft without changing the list order or unrelated registrations.
  test('replaces an existing notification definition', () async {
    final InMemoryDefinitionStore store =
        InMemoryDefinitionStore(<NotificationDefinition>[
          const NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            extractors: <RegExpDefinition>[],
            rules: <NotificationRule>[],
          ),
        ]);
    final NotificationDefinitionsViewModel controller = definitionsViewModel(
      store,
    )..definitions = store.definitions;

    final bool wasReplaced = (await controller.update(
      const NotificationDefinition(
        id: 'bank',
        applicationId: 'com.example.bank',
        name: 'Example Bank',
        extractors: <RegExpDefinition>[],
        rules: <NotificationRule>[],
        sampleTitle: 'Payment received',
      ),
    )).succeeded;

    expect(wasReplaced, isTrue);
    expect(store.savedDefinitions?.single.sampleTitle, 'Payment received');
    expect(controller.definitions.single.sampleTitle, 'Payment received');
  });

  test(
    'keeps the newest definitions load when requests complete out of order',
    () async {
      final DelayedDefinitionStore store = DelayedDefinitionStore();
      final NotificationDefinitionsViewModel controller =
          NotificationDefinitionsViewModel(
            store,
            SaveNotificationDefinition(store),
          );

      final Future<void> firstLoad = controller.load();
      final Future<void> secondLoad = controller.load();
      final Completer<List<NotificationDefinition>> firstResponse = store
          .takePendingLoad();
      final Completer<List<NotificationDefinition>> secondResponse = store
          .takePendingLoad();
      secondResponse.complete(<NotificationDefinition>[
        const NotificationDefinition(
          id: 'new',
          applicationId: 'com.example.new',
          name: 'New definition',
          extractors: <RegExpDefinition>[],
          rules: <NotificationRule>[],
        ),
      ]);
      await secondLoad;
      firstResponse.complete(<NotificationDefinition>[
        const NotificationDefinition(
          id: 'old',
          applicationId: 'com.example.old',
          name: 'Old definition',
          extractors: <RegExpDefinition>[],
          rules: <NotificationRule>[],
        ),
      ]);
      await firstLoad;

      expect(controller.definitions.single.id, 'new');
      expect(controller.isLoading, isFalse);
    },
  );
}
