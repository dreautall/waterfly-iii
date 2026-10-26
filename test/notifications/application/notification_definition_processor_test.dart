import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/stores/notification_alert_store.dart';
import 'package:waterflyiii/notifications/application/processing/notification_definition_processor.dart';
import 'package:waterflyiii/notifications/application/stores/notification_definition_store.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/data/repositories/notification_definition_repository.dart';
import 'package:waterflyiii/notifications/data/repositories/notification_definition_storage.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/values_greater_than_condition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/literal_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';

class InMemoryStorage implements NotificationDefinitionStorage {
  InMemoryStorage(this.data);

  Map<String, dynamic>? data;

  @override
  Future<Map<String, dynamic>?> read() async => data;

  @override
  Future<void> write(Map<String, dynamic> value) async {
    data = value;
  }

  @override
  Future<NotificationDefinitionInitializationResult> initializeIfAbsent(
    Map<String, dynamic> value,
  ) async {
    final Map<String, dynamic>? existing = data;
    if (existing != null) {
      return NotificationDefinitionInitializationResult(
        data: existing,
        initializedByCaller: false,
      );
    }
    data = value;
    return NotificationDefinitionInitializationResult(
      data: value,
      initializedByCaller: true,
    );
  }
}

class FailingNotificationDefinitionStore
    implements NotificationDefinitionStore {
  @override
  Future<List<NotificationDefinition>> load() =>
      Future<List<NotificationDefinition>>.error(
        const FormatException('Invalid definitions document'),
      );

  @override
  Future<void> save(List<NotificationDefinition> definitions) =>
      Future<void>.value();
}

class InMemoryAlertStore implements NotificationAlertStore {
  final List<NotificationAlert> alerts = <NotificationAlert>[];

  @override
  Future<void> clearForApplication(String applicationId) async {}

  @override
  Future<void> clearAll() async {
    alerts.clear();
  }

  @override
  Future<List<NotificationAlert>> load() async => alerts;

  @override
  Future<void> record(NotificationAlert alert) async {
    alerts.add(alert);
  }

  @override
  Future<void> dismiss(String fingerprint) async {}

  @override
  Future<void> restore(NotificationAlert alert) async {}
}

void main() {
  // Ensures notifications cannot be evaluated by definitions for another app.
  // This prevents one app's parsing configuration from leaking into another.
  test(
    'evaluates only definitions matching the notification application',
    () async {
      final InMemoryStorage storage = InMemoryStorage(null);
      final NotificationDefinitionRepository repository =
          NotificationDefinitionRepository(storage);
      await repository.save(<NotificationDefinition>[
        NotificationDefinition(
          id: 'matching',
          applicationId: 'com.example.bank',
          name: 'Example Bank',
          sampleTitle: 'Card payment',
          sampleBody: 'Paid 12.50 CAD',
          extractors: <RegExpDefinition>[
            RegExpDefinition.createPredefinedRegExpDefinition(
              PredefinedRegExpDefinition.notificationTitle,
            ),
          ],
          rules: <NotificationRule>[
            const NotificationRule(
              id: 'rule',
              name: 'Rule',
              conditions: <NotificationCondition>[],
              actions: <NotificationAction>[],
            ),
          ],
          extractorMode: NotificationExtractorMode.advanced,
        ),
        NotificationDefinition(
          id: 'other',
          applicationId: 'com.other.bank',
          name: 'Other Bank',
          extractors: <RegExpDefinition>[
            RegExpDefinition.createPredefinedRegExpDefinition(
              PredefinedRegExpDefinition.notificationTitle,
            ),
          ],
          rules: <NotificationRule>[],
        ),
      ]);

      final List<ProcessedNotificationDefinition> results =
          await NotificationDefinitionProcessor(repository).process(
            NotificationContext(
              applicationId: 'com.example.bank',
              title: 'Card payment',
              body: 'Paid 12.50 CAD',
              receivedAt: DateTime(2026, 8, 27),
            ),
          );

      expect(
        results.map(
          (ProcessedNotificationDefinition result) => result.definition.id,
        ),
        <String>['matching'],
      );
    },
  );

  test(
    'skips a Basic definition until its adjustable mappings are reviewed',
    () async {
      final RegExpDefinition amount =
          RegExpDefinition.createCustomRegExpDefinition(
            'Amounts',
            r'(?<amount>\d+)',
          );
      final InMemoryStorage storage = InMemoryStorage(null);
      final NotificationDefinitionRepository repository =
          NotificationDefinitionRepository(storage);
      await repository.save(<NotificationDefinition>[
        NotificationDefinition(
          id: 'needs-review',
          applicationId: 'com.example.bank',
          name: 'Example Bank',
          sampleTitle: 'Card payment',
          sampleBody: 'Paid 12 and 15 CAD',
          extractors: <RegExpDefinition>[amount],
          rules: <NotificationRule>[
            NotificationRule(
              id: 'transaction',
              name: 'Transaction details',
              isPredefined: true,
              conditions: const <NotificationCondition>[],
              actions: <NotificationAction>[
                SetTransactionFieldAction(
                  target: TransactionField.amount,
                  valueSource: RegExpCaptureValueSource(
                    extractorId: amount.id,
                    captureName: 'amount',
                  ),
                ),
              ],
            ),
          ],
          extractorMode: NotificationExtractorMode.basic,
        ),
      ]);

      final List<ProcessedNotificationDefinition> results =
          await NotificationDefinitionProcessor(repository).process(
            NotificationContext(
              applicationId: 'com.example.bank',
              title: 'Card payment',
              body: 'Paid 12 and 15 CAD',
              receivedAt: DateTime(2026, 9, 1),
            ),
          );

      expect(results, isEmpty);
    },
  );

  test(
    'skips an Advanced definition with an unmapped currency capture',
    () async {
      final RegExpDefinition currency =
          RegExpDefinition.createCustomRegExpDefinition(
            'Currency',
            r'(?<currency>CAD)',
          );
      final InMemoryStorage storage = InMemoryStorage(null);
      final NotificationDefinitionRepository repository =
          NotificationDefinitionRepository(storage);
      await repository.save(<NotificationDefinition>[
        NotificationDefinition(
          id: 'unmapped-currency',
          applicationId: 'com.example.bank',
          name: 'Example Bank',
          sampleTitle: 'Card payment',
          sampleBody: 'Paid 12 CAD',
          extractors: <RegExpDefinition>[currency],
          rules: <NotificationRule>[
            NotificationRule(
              id: 'transaction',
              name: 'Transaction details',
              conditions: const <NotificationCondition>[],
              actions: <NotificationAction>[
                SetTransactionFieldAction(
                  target: TransactionField.currency,
                  valueSource: RegExpCaptureValueSource(
                    extractorId: currency.id,
                    captureName: 'currency',
                  ),
                ),
              ],
            ),
          ],
          extractorMode: NotificationExtractorMode.advanced,
        ),
      ]);

      final List<ProcessedNotificationDefinition> results =
          await NotificationDefinitionProcessor(repository).process(
            NotificationContext(
              applicationId: 'com.example.bank',
              title: 'Card payment',
              body: 'Paid 12 CAD',
              receivedAt: DateTime(2026, 9, 1),
            ),
          );

      expect(results, isEmpty);
    },
  );

  test(
    'propagates load failure without recording a definition alert',
    () async {
      final InMemoryAlertStore alertStore = InMemoryAlertStore();
      final NotificationContext notification = NotificationContext(
        applicationId: 'com.example.bank',
        title: 'Card payment',
        body: 'Paid 12.50 CAD',
        receivedAt: DateTime(2026, 8, 30),
      );

      final Future<List<ProcessedNotificationDefinition>> processing =
          NotificationDefinitionProcessor(
            FailingNotificationDefinitionStore(),
            alertStore: alertStore,
          ).process(notification);

      await expectLater(processing, throwsA(isA<FormatException>()));
      expect(alertStore.alerts, isEmpty);
    },
  );

  test(
    'does not process or alert for a notification without a title',
    () async {
      final InMemoryStorage storage = InMemoryStorage(null);
      final NotificationDefinitionRepository repository =
          NotificationDefinitionRepository(storage);
      final InMemoryAlertStore alertStore = InMemoryAlertStore();
      await repository.save(<NotificationDefinition>[
        NotificationDefinition(
          id: 'broken-pattern',
          applicationId: 'com.example.bank',
          name: 'Broken pattern',
          sampleTitle: 'Card payment',
          sampleBody: 'Paid 12.50 CAD',
          extractors: <RegExpDefinition>[
            RegExpDefinition.createCustomRegExpDefinition(
              'Broken extractor',
              '[',
              isRequiredForMatch: true,
            ),
          ],
          rules: const <NotificationRule>[
            NotificationRule(
              id: 'rule',
              name: 'Rule',
              conditions: <NotificationCondition>[],
              actions: <NotificationAction>[],
            ),
          ],
          extractorMode: NotificationExtractorMode.advanced,
        ),
      ]);

      final List<ProcessedNotificationDefinition> results =
          await NotificationDefinitionProcessor(
            repository,
            alertStore: alertStore,
          ).process(
            NotificationContext(
              applicationId: 'com.example.bank',
              title: ' ',
              body: 'Paid 12.50 CAD',
              receivedAt: DateTime(2026, 8, 30),
            ),
          );

      expect(results, isEmpty);
      expect(alertStore.alerts, isEmpty);
    },
  );

  test(
    'does not alert when a shared action requirement is unavailable',
    () async {
      final InMemoryStorage storage = InMemoryStorage(null);
      final NotificationDefinitionRepository repository =
          NotificationDefinitionRepository(storage);
      final InMemoryAlertStore alertStore = InMemoryAlertStore();
      final RegExpDefinition amount =
          RegExpDefinition.createCustomRegExpDefinition(
            'Amount',
            r'Paid (?<amount>\d+\.\d{2})',
          );
      await repository.save(<NotificationDefinition>[
        NotificationDefinition(
          id: 'shared-amount',
          applicationId: 'com.example.bank',
          name: 'Shared amount',
          sampleTitle: 'Card payment',
          sampleBody: 'Paid 12.50',
          extractors: <RegExpDefinition>[amount],
          rules: const <NotificationRule>[],
          sharedActions: <NotificationAction>[
            SetTransactionFieldAction(
              target: TransactionField.amount,
              valueSource: RegExpCaptureValueSource(
                extractorId: amount.id,
                captureName: 'amount',
              ),
            ),
          ],
          extractorMode: NotificationExtractorMode.advanced,
        ),
      ]);

      final List<ProcessedNotificationDefinition> results =
          await NotificationDefinitionProcessor(
            repository,
            alertStore: alertStore,
          ).process(
            NotificationContext(
              applicationId: 'com.example.bank',
              title: 'Security notice',
              body: 'Your card settings were updated.',
              receivedAt: DateTime(2026, 9, 29),
            ),
          );

      expect(results, isEmpty);
      expect(alertStore.alerts, isEmpty);
    },
  );

  // Distinguishes a broken required regex from an expected non-match so users
  // can repair the definition instead of losing all notifications from the app.
  test('records an alert for an invalid required extractor', () async {
    final InMemoryStorage storage = InMemoryStorage(null);
    final NotificationDefinitionRepository repository =
        NotificationDefinitionRepository(storage);
    final InMemoryAlertStore alertStore = InMemoryAlertStore();
    await repository.save(<NotificationDefinition>[
      NotificationDefinition(
        id: 'broken-pattern',
        applicationId: 'com.example.bank',
        name: 'Broken pattern',
        sampleTitle: 'Card payment',
        sampleBody: 'Paid 12.50 CAD',
        extractors: <RegExpDefinition>[
          RegExpDefinition.createCustomRegExpDefinition(
            'Broken extractor',
            '[',
            isRequiredForMatch: true,
          ),
        ],
        rules: const <NotificationRule>[
          NotificationRule(
            id: 'rule',
            name: 'Rule',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
        ],
        extractorMode: NotificationExtractorMode.advanced,
      ),
    ]);

    final List<ProcessedNotificationDefinition> results =
        await NotificationDefinitionProcessor(
          repository,
          alertStore: alertStore,
        ).process(
          NotificationContext(
            applicationId: 'com.example.bank',
            title: 'Card payment',
            body: 'Paid 12.50 CAD',
            receivedAt: DateTime(2026, 8, 30),
          ),
        );

    expect(results, isEmpty);
    expect(
      alertStore.alerts.single.kind,
      NotificationAlertKind.definitionInvalid,
    );
    expect(alertStore.alerts.single.definitionId, 'broken-pattern');
    expect(
      alertStore.alerts.single.message,
      'The "Broken extractor" extractor has an invalid pattern.',
    );
  });

  test('records an alert when custom extractor input is too long', () async {
    final InMemoryStorage storage = InMemoryStorage(null);
    final NotificationDefinitionRepository repository =
        NotificationDefinitionRepository(storage);
    final InMemoryAlertStore alertStore = InMemoryAlertStore();
    await repository.save(<NotificationDefinition>[
      NotificationDefinition(
        id: 'long-input',
        applicationId: 'com.example.bank',
        name: 'Long input',
        sampleTitle: 'Card payment',
        sampleBody: 'Paid 12.50 CAD',
        extractors: <RegExpDefinition>[
          RegExpDefinition.createCustomRegExpDefinition(
            'Amount',
            r'(?<amount>\d+)',
            isRequiredForMatch: true,
          ),
        ],
        rules: const <NotificationRule>[
          NotificationRule(
            id: 'rule',
            name: 'Rule',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
        ],
        extractorMode: NotificationExtractorMode.advanced,
      ),
    ]);

    final List<ProcessedNotificationDefinition> results =
        await NotificationDefinitionProcessor(
          repository,
          alertStore: alertStore,
        ).process(
          NotificationContext(
            applicationId: 'com.example.bank',
            title: 'Card payment',
            body: List<String>.filled(
              RegExpDefinition.maximumCustomInputLength + 1,
              'x',
            ).join(),
            receivedAt: DateTime(2026, 9, 26),
          ),
        );

    expect(results, isEmpty);
    expect(
      alertStore.alerts.single.kind,
      NotificationAlertKind.evaluationFailed,
    );
    expect(alertStore.alerts.single.definitionId, 'long-input');
    expect(
      alertStore.alerts.single.message,
      'The notification text is too long to evaluate safely.',
    );
  });

  test('does not alert for an incomplete registration action', () async {
    final InMemoryStorage storage = InMemoryStorage(null);
    final NotificationDefinitionRepository repository =
        NotificationDefinitionRepository(storage);
    final InMemoryAlertStore alertStore = InMemoryAlertStore();
    await repository.save(<NotificationDefinition>[
      NotificationDefinition(
        id: 'missing-capture',
        applicationId: 'com.example.bank',
        name: 'Missing capture',
        extractors: <RegExpDefinition>[
          RegExpDefinition.createPredefinedRegExpDefinition(
            PredefinedRegExpDefinition.notificationTitle,
          ),
        ],
        rules: <NotificationRule>[
          const NotificationRule(
            id: 'set-amount',
            name: 'Set amount',
            conditions: <NotificationCondition>[],
            actions: <SetTransactionFieldAction>[
              SetTransactionFieldAction(
                target: TransactionField.amount,
                valueSource: RegExpCaptureValueSource(
                  extractorId: 'payment',
                  captureName: 'amount',
                ),
              ),
            ],
          ),
        ],
      ),
    ]);

    final List<ProcessedNotificationDefinition> results =
        await NotificationDefinitionProcessor(
          repository,
          alertStore: alertStore,
        ).process(
          NotificationContext(
            applicationId: 'com.example.bank',
            title: 'Card payment',
            body: 'Paid 12.50 CAD',
            receivedAt: DateTime(2026, 8, 30),
          ),
        );

    expect(results, isEmpty);
    expect(alertStore.alerts, isEmpty);

    final List<ProcessedNotificationDefinition> bodylessResults =
        await NotificationDefinitionProcessor(
          repository,
          alertStore: alertStore,
        ).process(
          NotificationContext(
            applicationId: 'com.example.bank',
            title: 'Card payment',
            body: ' ',
            receivedAt: DateTime(2026, 8, 30),
          ),
        );

    expect(bodylessResults, isEmpty);
    expect(alertStore.alerts, isEmpty);
  });

  test(
    'records a rule-scoped alert for a diagnostic condition failure',
    () async {
      final InMemoryStorage storage = InMemoryStorage(null);
      final NotificationDefinitionRepository repository =
          NotificationDefinitionRepository(storage);
      final InMemoryAlertStore alertStore = InMemoryAlertStore();
      await repository.save(<NotificationDefinition>[
        NotificationDefinition(
          id: 'typed-condition',
          applicationId: 'com.example.bank',
          name: 'Example Bank',
          sampleTitle: 'Card payment',
          sampleBody: 'Paid 12.50 CAD',
          extractors: <RegExpDefinition>[
            RegExpDefinition.createPredefinedRegExpDefinition(
              PredefinedRegExpDefinition.notificationTitle,
            ),
          ],
          rules: <NotificationRule>[
            const NotificationRule(
              id: 'compare-date',
              name: 'Compare date',
              conditions: <NotificationCondition>[
                ValuesGreaterThanCondition(
                  left: LiteralValueSource('2026-09-02'),
                  right: LiteralValueSource('2026-09-01T10:30:00'),
                ),
              ],
              actions: <NotificationAction>[],
            ),
          ],
          extractorMode: NotificationExtractorMode.advanced,
        ),
      ]);

      await NotificationDefinitionProcessor(
        repository,
        alertStore: alertStore,
      ).process(
        NotificationContext(
          applicationId: 'com.example.bank',
          title: 'Card payment',
          body: 'Paid 12.50 CAD',
          receivedAt: DateTime(2026, 9, 6),
        ),
      );

      expect(alertStore.alerts, hasLength(1));
      final NotificationAlert alert = alertStore.alerts.single;
      expect(alert.kind, NotificationAlertKind.evaluationFailed);
      expect(alert.definitionId, 'typed-condition');
      expect(alert.ruleId, 'compare-date');
      expect(alert.operation, 'Evaluating notification rule "Compare date"');
      expect(alert.message, contains('Both values must have the same type.'));
    },
  );

  test('does not alert for an ordinary condition non-match', () async {
    final InMemoryStorage storage = InMemoryStorage(null);
    final NotificationDefinitionRepository repository =
        NotificationDefinitionRepository(storage);
    final InMemoryAlertStore alertStore = InMemoryAlertStore();
    await repository.save(const <NotificationDefinition>[
      NotificationDefinition(
        id: 'ordinary-miss',
        applicationId: 'com.example.bank',
        name: 'Example Bank',
        sampleTitle: 'Card payment',
        sampleBody: 'Paid 12.50 CAD',
        extractors: <RegExpDefinition>[],
        rules: <NotificationRule>[
          NotificationRule(
            id: 'amount-threshold',
            name: 'Amount threshold',
            conditions: <NotificationCondition>[
              ValuesGreaterThanCondition(
                left: LiteralValueSource('10'),
                right: LiteralValueSource('20'),
              ),
            ],
            actions: <NotificationAction>[],
          ),
        ],
        extractorMode: NotificationExtractorMode.advanced,
      ),
    ]);

    await NotificationDefinitionProcessor(
      repository,
      alertStore: alertStore,
    ).process(
      NotificationContext(
        applicationId: 'com.example.bank',
        title: 'Card payment',
        body: 'Paid 12.50 CAD',
        receivedAt: DateTime(2026, 9, 6),
      ),
    );

    expect(alertStore.alerts, isEmpty);
  });
}
