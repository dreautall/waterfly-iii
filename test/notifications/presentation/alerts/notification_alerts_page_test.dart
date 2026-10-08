import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/application/stores/notification_alert_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_definition_store.dart';
import 'package:waterflyiii/notifications/application/listeners/notification_listener_health_service.dart';
import 'package:waterflyiii/notifications/application/rules/notification_rule_operations.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/value_exists_condition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/listeners/notification_listener_health_issue.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/literal_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';
import 'package:waterflyiii/notifications/presentation/alerts/pages/notification_alerts_page.dart';
import 'package:waterflyiii/notifications/presentation/definitions/pages/notification_definition_details_page.dart';
import 'package:waterflyiii/notifications/presentation/extractors/pages/notification_extractor_details_page.dart';
import 'package:waterflyiii/notifications/presentation/health/controllers/notification_listener_health_view_model.dart';
import 'package:waterflyiii/notifications/presentation/navigation/notification_navigation_coordinator.dart';
import 'package:waterflyiii/notifications/presentation/rules/pages/notification_rule_details_page.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_empty_state.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_page_header.dart';

import '../../support/in_memory_notification_stores.dart';

class InMemoryDefinitionStore implements NotificationDefinitionStore {
  InMemoryDefinitionStore(this.definitions, {this.loadError});

  List<NotificationDefinition> definitions;
  final Object? loadError;
  int saveCount = 0;

  @override
  Future<List<NotificationDefinition>> load() async {
    if (loadError != null) throw loadError!;
    return definitions;
  }

  @override
  Future<void> save(List<NotificationDefinition> definitions) async {
    saveCount++;
    this.definitions = definitions;
  }
}

class FixedAlertStore implements NotificationAlertStore {
  FixedAlertStore(this.alerts, {this.failedDismissFingerprint});

  final List<NotificationAlert> alerts;
  final String? failedDismissFingerprint;
  String? dismissedFingerprint;
  NotificationAlert? restoredAlert;
  final List<String> dismissedFingerprints = <String>[];

  @override
  Future<void> clearForApplication(String applicationId) async {}

  @override
  Future<void> clearAll() async {}

  @override
  Future<List<NotificationAlert>> load() async => alerts;

  @override
  Future<void> record(NotificationAlert alert) async {}

  @override
  Future<void> dismiss(String fingerprint) async {
    if (fingerprint == failedDismissFingerprint) {
      throw StateError('Dismissal failed.');
    }
    dismissedFingerprint = fingerprint;
    dismissedFingerprints.add(fingerprint);
  }

  @override
  Future<void> restore(NotificationAlert alert) async {
    restoredAlert = alert;
  }
}

void main() {
  testWidgets('coordinator persists an alert rule edit only once', (
    WidgetTester tester,
  ) async {
    final InMemoryDefinitionStore definitions = InMemoryDefinitionStore(
      <NotificationDefinition>[
        const NotificationDefinition(
          id: 'bank',
          applicationId: 'com.example.bank',
          name: 'Example Bank',
          sampleTitle: 'Card payment',
          sampleBody: 'Paid 12 CAD',
          extractors: <RegExpDefinition>[],
          rules: <NotificationRule>[
            NotificationRule(
              id: 'payment-rule',
              name: 'Payment rule',
              conditions: <NotificationCondition>[],
              actions: <NotificationAction>[],
            ),
          ],
        ),
      ],
    );
    final NotificationNavigationCoordinator coordinator =
        NotificationNavigationCoordinator.forAlertEditors(
          definitionStore: definitions,
          ruleOperations: NotificationRuleOperations(definitions),
        );
    final NotificationAlert alert = NotificationAlert.failure(
      kind: NotificationAlertKind.evaluationFailed,
      operation: 'Evaluating notification rule',
      message: 'Evaluation failed.',
      applicationId: 'com.example.bank',
      definitionId: 'bank',
      ruleId: 'payment-rule',
    );
    late BuildContext context;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: Builder(
          builder: (BuildContext value) {
            context = value;
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    final Future<void> navigation = coordinator.openRuleFromAlert(
      context,
      alert,
    );
    await tester.pumpAndSettle();

    final NotificationRuleDetailsPage page = tester.widget(
      find.byType(NotificationRuleDetailsPage),
    );
    expect(page.notificationContext.applicationName, 'Example Bank');
    const NotificationRule updated = NotificationRule(
      id: 'payment-rule',
      name: 'Updated payment rule',
      conditions: <NotificationCondition>[],
      actions: <NotificationAction>[],
    );
    expect(await page.onSave!(updated), isTrue);
    Navigator.of(
      context,
    ).pop(const NotificationRuleDetailsResult.updated(updated));
    await tester.pumpAndSettle();
    await navigation;

    expect(definitions.saveCount, 1);
    expect(definitions.definitions.single.rules.single.name, updated.name);
  });

  testWidgets('pins an active processing issue above the empty state', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(800, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final InMemoryDefinitionStore definitions = InMemoryDefinitionStore(
      <NotificationDefinition>[],
    );
    final InMemoryNotificationListenerHealthStore health =
        InMemoryNotificationListenerHealthStore(
          NotificationListenerHealthIssue(
            firstOccurredAt: DateTime.utc(2026, 10, 1, 8),
            lastOccurredAt: DateTime.utc(2026, 10, 1, 9),
            occurrenceCount: 2,
          ),
        );
    final NotificationListenerHealthViewModel healthViewModel =
        NotificationListenerHealthViewModel(
          store: health,
          service: NotificationListenerHealthService(
            store: health,
            definitionStore: definitions,
          ),
        );

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: NotificationAlertsPage(
          alertStore: FixedAlertStore(<NotificationAlert>[]),
          definitionStore: definitions,
          healthViewModel: healthViewModel,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Notification processing is paused'), findsOneWidget);
    expect(
      find.text(
        'Waterfly could not load your notification setup. 2 notifications may have been skipped.',
      ),
      findsOneWidget,
    );
    expect(
      find.text('No notification alerts need your attention.'),
      findsOneWidget,
    );
    expect(find.byIcon(Icons.notifications_none_outlined), findsOneWidget);
    expect(find.text('All clear'), findsOneWidget);
    expect(find.text('Review setup'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Retry'), findsOneWidget);
    expect(find.widgetWithText(OutlinedButton, 'Review setup'), findsOneWidget);
  });

  testWidgets('scrolls the description and alerts as one page', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final List<NotificationAlert> alerts = List<NotificationAlert>.generate(
      12,
      (int index) => NotificationAlert.failure(
        kind: NotificationAlertKind.evaluationFailed,
        operation: 'Operation $index',
        message: 'Failure $index',
        applicationId: 'com.example.bank.$index',
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: NotificationAlertsPage(previewAlerts: alerts),
      ),
    );
    await tester.pumpAndSettle();

    final Finder scrollView = find.byType(CustomScrollView);
    final Finder description = find
        .descendant(of: scrollView, matching: find.byType(Text))
        .first;
    expect(scrollView, findsOneWidget);
    expect(find.byType(ListView), findsNothing);
    final double initialDescriptionTop = tester.getTopLeft(description).dy;

    await tester.drag(scrollView, const Offset(0, -80));
    await tester.pumpAndSettle();

    expect(
      tester.getTopLeft(description).dy,
      lessThan(initialDescriptionTop - 50),
    );
    expect(tester.getTopLeft(find.text('Operation 0').first).dy, lessThan(844));
  });

  testWidgets('reveals the last alert card after it expands', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    tester.view.padding = const FakeViewPadding(bottom: 24);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPadding);
    final List<NotificationAlert> alerts = List<NotificationAlert>.generate(
      4,
      (int index) => NotificationAlert.failure(
        kind: NotificationAlertKind.evaluationFailed,
        operation: 'Operation $index',
        message: 'Failure $index',
        applicationId: 'com.example.bank.$index',
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: NotificationAlertsPage(previewAlerts: alerts),
      ),
    );
    await tester.pumpAndSettle();

    final Finder scrollView = find.byType(CustomScrollView);
    final Finder scrollable = find.descendant(
      of: scrollView,
      matching: find.byType(Scrollable),
    );
    await tester.drag(scrollView, const Offset(0, -500));
    await tester.pumpAndSettle();
    final Finder lastTitle = find.text('Operation 3').first;
    final ScrollPosition position = tester
        .state<ScrollableState>(scrollable)
        .position;
    final double collapsedOffset = position.pixels;

    await tester.tap(lastTitle);
    await tester.pumpAndSettle();

    final Finder lastCard = find.ancestor(
      of: lastTitle,
      matching: find.byType(Card),
    );
    expect(position.pixels, greaterThan(collapsedOffset));
    expect(
      tester.getBottomRight(lastCard).dy,
      lessThanOrEqualTo(tester.getBottomRight(scrollView).dy - 40),
    );
  });

  testWidgets('keeps the top of an oversized expanded group visible', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final List<NotificationAlert> alerts = List<NotificationAlert>.generate(
      10,
      (int index) => NotificationAlert.failure(
        kind: NotificationAlertKind.migrationNeedsReview,
        operation: 'Migration issue $index',
        message: 'Review migration issue $index.',
        applicationId: 'com.example.large-group',
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: NotificationAlertsPage(previewAlerts: alerts),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Migration issue 0').first);
    await tester.pumpAndSettle();

    final Finder card = find.byType(Card);
    final BuildContext cardContext = tester.element(card);
    final double visibleTop =
        NotificationPageHeader.bodyTopInset(cardContext) + 8;
    expect(tester.getTopLeft(card).dy, closeTo(visibleTop, 1));
    expect(tester.getBottomRight(card).dy, greaterThan(844));
  });

  testWidgets('does not scroll when there are no alerts', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: NotificationAlertsPage(previewAlerts: <NotificationAlert>[]),
      ),
    );
    await tester.pumpAndSettle();

    final Finder scrollView = find.byType(CustomScrollView);
    final CustomScrollView widget = tester.widget(scrollView);
    expect(widget.physics, isA<NeverScrollableScrollPhysics>());
    final Finder emptyState = find.byType(NotificationEmptyState);
    final double expectedCenter = tester
        .getCenter(find.byType(NotificationEmptyStateViewport))
        .dy;
    final Finder emptyStateText = find.descendant(
      of: emptyState,
      matching: find.byKey(NotificationEmptyState.textContentKey),
    );
    expect(tester.getCenter(emptyStateText).dy, closeTo(expectedCenter, 1));
    final ScrollPosition position = tester
        .state<ScrollableState>(
          find.descendant(of: scrollView, matching: find.byType(Scrollable)),
        )
        .position;

    await tester.drag(scrollView, const Offset(0, -80));
    await tester.pumpAndSettle();

    expect(position.pixels, 0);
  });

  // Renders representative alert data without device storage so the alert card
  // layout can be reviewed before real parsing failures are available in-app.
  testWidgets('renders a mocked notification alert card', (
    WidgetTester tester,
  ) async {
    final NotificationAlert alert = NotificationAlert.failure(
      kind: NotificationAlertKind.actionFailed,
      operation: 'Applying notification definition action',
      message: 'The amount capture could not be resolved.',
      applicationId: 'com.example.bank',
      definitionId: 'example-bank',
      ruleName: 'Set amount',
      actionName: 'Set amount',
      notification: NotificationContext(
        applicationId: 'com.example.bank',
        applicationName: 'Example Bank',
        title: 'Card payment',
        body: 'Paid 12.50 CAD',
        receivedAt: DateTime(2026, 9, 6),
      ),
    );
    final NotificationAlert repeatedAlert = alert.recordAnotherOccurrence();

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: NotificationAlertsPage(
          previewAlerts: <NotificationAlert>[repeatedAlert],
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Notification alerts'), findsOneWidget);
    expect(
      find.text(
        'Review notification processing issues that may require attention. Alerts are grouped by application, and repeated occurrences are combined.',
      ),
      findsOneWidget,
    );
    expect(find.text('Applying notification definition action'), findsWidgets);
    expect(
      find.text('The amount capture could not be resolved.'),
      findsOneWidget,
    );
    expect(find.text('Example Bank'), findsOneWidget);
    expect(find.text('com.example.bank'), findsOneWidget);
    expect(find.text('Rule: Set amount'), findsOneWidget);
    expect(find.text('Action: set amount'), findsOneWidget);
    expect(find.textContaining('Action failed · '), findsOneWidget);
    expect(find.textContaining('2 occurrences'), findsOneWidget);
    expect(find.byIcon(Icons.tune_outlined), findsWidgets);
    expect(find.byType(RefreshIndicator), findsOneWidget);
    await tester.tap(
      find.text('Applying notification definition action').first,
    );
    await tester.pumpAndSettle();
    final Divider divider = tester.widget<Divider>(find.byType(Divider));
    expect(divider.indent, 16);
    expect(divider.endIndent, 16);
    expect(
      divider.color,
      Theme.of(tester.element(find.byType(Divider))).colorScheme.outlineVariant,
    );
  });

  testWidgets('groups migration issues by application with friendly guidance', (
    WidgetTester tester,
  ) async {
    final List<NotificationAlert> alerts = <NotificationAlert>[
      NotificationAlert.failure(
        kind: NotificationAlertKind.migrationNeedsReview,
        operation: 'Reviewing imported notification settings',
        message:
            'Automatic creation was changed to prompt mode until the imported currency behavior is reviewed.',
        applicationId: 'com.example.bank',
        definitionId: 'example-bank',
        migrationIssue: NotificationMigrationIssue.automaticCreationPaused,
      ),
      NotificationAlert.failure(
        kind: NotificationAlertKind.migrationNeedsReview,
        operation: 'Reviewing imported notification settings',
        message:
            'The imported automatic configuration is missing an account mapping.',
        applicationId: 'com.example.bank',
        definitionId: 'example-bank',
        migrationIssue: NotificationMigrationIssue.missingAutomaticAccount,
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: NotificationAlertsPage(
          definitionStore:
              InMemoryDefinitionStore(const <NotificationDefinition>[
                NotificationDefinition(
                  id: 'example-bank',
                  applicationId: 'com.example.bank',
                  name: 'Example Bank',
                  extractors: <RegExpDefinition>[],
                  rules: <NotificationRule>[],
                ),
              ]),
          previewAlerts: alerts,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(Card), findsOneWidget);
    expect(find.text('Example Bank'), findsOneWidget);
    expect(find.text('com.example.bank'), findsOneWidget);
    expect(find.textContaining('2 issues'), findsOneWidget);
    expect(find.text('Automatic creation paused'), findsWidgets);
    expect(find.text('Account required for automatic creation'), findsWidgets);
    expect(find.textContaining('FormatException'), findsNothing);

    await tester.tap(find.text('Example Bank'));
    await tester.pumpAndSettle();

    expect(
      find.text(
        'Transactions will use Prompt mode until you review the imported setup.',
      ),
      findsOneWidget,
    );
    expect(
      find.text(
        'Choose an account before enabling automatic transaction creation.',
      ),
      findsOneWidget,
    );
    expect(
      find.widgetWithText(TextButton, 'Dismiss all issues'),
      findsOneWidget,
    );
    expect(find.widgetWithText(FilledButton, 'Open setup'), findsOneWidget);

    await tester.tap(
      find.text(
        'Transactions will use Prompt mode until you review the imported setup.',
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find
          .text(
            'Transactions will use Prompt mode until you review the imported setup.',
          )
          .hitTestable(),
      findsNothing,
    );
  });

  testWidgets('opens a rule by its saved name when alert IDs are stale', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final RegExpDefinition merchantExtractor =
        RegExpDefinition.createCustomRegExpDefinition(
          'Merchant',
          r'Refund (?<merchant>.+)',
        );
    final InMemoryDefinitionStore definitionStore = InMemoryDefinitionStore(
      <NotificationDefinition>[
        NotificationDefinition(
          id: 'example-bank',
          applicationId: 'com.example.bank',
          name: 'Example Bank',
          sampleTitle: 'Card payment',
          sampleBody: 'Paid Corner shop',
          extractorMode: NotificationExtractorMode.advanced,
          extractors: <RegExpDefinition>[merchantExtractor],
          sharedActions: const <NotificationAction>[
            SetTransactionFieldAction(
              target: TransactionField.sourceAccount,
              valueSource: LiteralValueSource('Wallet'),
            ),
          ],
          rules: <NotificationRule>[
            NotificationRule(
              id: 'repair-rule',
              name: 'Repair rule',
              conditions: <NotificationCondition>[
                ValueExistsCondition(
                  RegExpCaptureValueSource(
                    extractorId: merchantExtractor.id,
                    captureName: 'merchant',
                  ),
                ),
              ],
              actions: const <NotificationAction>[
                SetTransactionFieldAction(
                  target: TransactionField.destinationAccount,
                  valueSource: LiteralValueSource('Checking'),
                ),
              ],
            ),
          ],
        ),
      ],
    );
    final NotificationAlert alert = NotificationAlert.failure(
      kind: NotificationAlertKind.evaluationFailed,
      operation: 'Evaluating notification rule "Repair rule"',
      message: 'Both values must have the same type.',
      applicationId: 'com.example.bank',
      definitionId: 'removed-example-bank',
      ruleName: 'Repair rule',
    );

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: NotificationAlertsPage(
          definitionStore: definitionStore,
          previewAlerts: <NotificationAlert>[alert],
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(
      find.text('Evaluating notification rule "Repair rule"').first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Open rule'));
    await tester.pumpAndSettle();

    expect(find.text('Repair rule'), findsOneWidget);
    expect(find.text('Test mode'), findsOneWidget);
    expect(find.byTooltip('Exit test mode'), findsNothing);
    expect(find.text('Needs setup'), findsNothing);

    await tester.scrollUntilVisible(find.text('Checking'), 200);
    expect(find.text('Wallet'), findsOneWidget);
    expect(find.text('Checking'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Sample value issues'),
      -200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Merchant'));
    await tester.pumpAndSettle();
    expect(find.byType(NotificationExtractorDetailsPage), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.text('Notification alerts'), findsOneWidget);
    expect(find.text('Example Bank'), findsOneWidget);
  });

  testWidgets('opens notification setup for a shared action alert', (
    WidgetTester tester,
  ) async {
    final InMemoryDefinitionStore definitionStore = InMemoryDefinitionStore(
      const <NotificationDefinition>[
        NotificationDefinition(
          id: 'example-bank',
          applicationId: 'com.example.bank',
          name: 'Example Bank',
          sampleTitle: 'Card payment',
          sampleBody: 'Paid 12.50 CAD',
          extractors: <RegExpDefinition>[],
          sharedActions: <NotificationAction>[
            SetTransactionFieldAction(
              target: TransactionField.amount,
              valueSource: LiteralValueSource('invalid'),
            ),
          ],
          rules: <NotificationRule>[],
        ),
      ],
    );
    final NotificationAlert alert = NotificationAlert.failure(
      kind: NotificationAlertKind.actionFailed,
      operation: 'Applying Set amount for shared notification actions',
      message: 'The amount capture could not be resolved.',
      applicationId: 'com.example.bank',
      definitionId: 'example-bank',
      actionName: 'Set amount',
    );

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: NotificationAlertsPage(
          definitionStore: definitionStore,
          previewAlerts: <NotificationAlert>[alert],
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(
      find.text('Applying set amount for shared notification actions').first,
    );
    await tester.pumpAndSettle();
    expect(find.widgetWithText(FilledButton, 'Open setup'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Open rule'), findsNothing);

    await tester.tap(find.widgetWithText(FilledButton, 'Open setup'));
    await tester.pumpAndSettle();

    expect(find.byType(NotificationDefinitionDetailsPage), findsOneWidget);
    expect(find.text('Example Bank'), findsOneWidget);
  });

  testWidgets('uses the registered application name in alert details', (
    WidgetTester tester,
  ) async {
    final InMemoryDefinitionStore definitionStore =
        InMemoryDefinitionStore(const <NotificationDefinition>[
          NotificationDefinition(
            id: 'example-bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            extractors: <RegExpDefinition>[],
            rules: <NotificationRule>[],
          ),
        ]);
    final NotificationAlert alert = NotificationAlert.failure(
      kind: NotificationAlertKind.actionFailed,
      operation: 'Applying notification definition action',
      message: 'The amount capture could not be resolved.',
      applicationId: 'com.example.bank',
    );

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: NotificationAlertsPage(
          definitionStore: definitionStore,
          previewAlerts: <NotificationAlert>[alert],
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Example Bank'), findsOneWidget);
    expect(find.text('com.example.bank'), findsOneWidget);
  });

  testWidgets(
    'reports application-name load failures and keeps package-ID fallback',
    (WidgetTester tester) async {
      final NotificationAlert alert = NotificationAlert.failure(
        kind: NotificationAlertKind.actionFailed,
        operation: 'Applying notification definition action',
        message: 'The amount capture could not be resolved.',
        applicationId: 'com.example.bank',
      );

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          home: NotificationAlertsPage(
            definitionStore: InMemoryDefinitionStore(
              <NotificationDefinition>[],
              loadError: StateError('Definitions unavailable'),
            ),
            previewAlerts: <NotificationAlert>[alert],
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      expect(find.text('Unknown application'), findsOneWidget);
      expect(find.text('com.example.bank'), findsOneWidget);
      expect(
        find.text(
          'Application names could not be loaded. Package IDs are shown instead.',
        ),
        findsOneWidget,
      );
    },
  );

  testWidgets('dismisses an alert card', (WidgetTester tester) async {
    final NotificationAlert alert = NotificationAlert.failure(
      kind: NotificationAlertKind.actionFailed,
      operation: 'Applying notification definition action',
      message: 'The amount capture could not be resolved.',
      applicationId: 'com.example.bank',
    );

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: NotificationAlertsPage(previewAlerts: <NotificationAlert>[alert]),
      ),
    );
    await tester.pump();

    await tester.tap(find.widgetWithText(TextButton, 'Dismiss'));
    await tester.pump();
    await tester.pump();

    expect(
      find.text('The amount capture could not be resolved.'),
      findsOneWidget,
    );
    expect(
      find.text('No notification alerts need your attention.'),
      findsNothing,
    );
    expect(find.text('Alert dismissed.'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 110));
    expect(
      find.text('The amount capture could not be resolved.'),
      findsOneWidget,
    );

    tester.widget<SnackBarAction>(find.byType(SnackBarAction)).onPressed();
    await tester.pump();
    await tester.pump();

    expect(
      find.text('The amount capture could not be resolved.'),
      findsOneWidget,
    );
    expect(
      find.text('No notification alerts need your attention.'),
      findsNothing,
    );
    await tester.pumpAndSettle();
  });

  testWidgets('animates a nested issue out and restores it in place', (
    WidgetTester tester,
  ) async {
    final NotificationAlert firstAlert = NotificationAlert.failure(
      kind: NotificationAlertKind.migrationNeedsReview,
      operation: 'Reviewing imported notification settings',
      message: 'Automatic creation needs review.',
      applicationId: 'com.example.bank',
      definitionId: 'example-bank',
      migrationIssue: NotificationMigrationIssue.automaticCreationPaused,
    );
    final NotificationAlert secondAlert = NotificationAlert.failure(
      kind: NotificationAlertKind.migrationNeedsReview,
      operation: 'Reviewing imported notification settings',
      message: 'An account must be selected.',
      applicationId: 'com.example.bank',
      definitionId: 'example-bank',
      migrationIssue: NotificationMigrationIssue.missingAutomaticAccount,
    );

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: NotificationAlertsPage(
          previewAlerts: <NotificationAlert>[firstAlert, secondAlert],
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Automatic creation paused').first);
    await tester.pumpAndSettle();
    final double initialHeight = tester.getSize(find.byType(Card)).height;

    await tester.tap(find.byTooltip('Dismiss issue').first);
    await tester.pump();
    await tester.pump();

    expect(
      find.text(
        'Transactions will use Prompt mode until you review the imported setup.',
      ),
      findsOneWidget,
    );
    expect(
      find.text(
        'Choose an account before enabling automatic transaction creation.',
      ),
      findsOneWidget,
    );

    await tester.pump(const Duration(milliseconds: 100));
    final double midpointHeight = tester.getSize(find.byType(Card)).height;
    expect(midpointHeight, lessThan(initialHeight));
    expect(
      find.text(
        'Transactions will use Prompt mode until you review the imported setup.',
      ),
      findsOneWidget,
    );

    await tester.pump(const Duration(milliseconds: 120));
    expect(
      find.text(
        'Transactions will use Prompt mode until you review the imported setup.',
      ),
      findsNothing,
    );
    expect(
      find.text(
        'Choose an account before enabling automatic transaction creation.',
      ),
      findsOneWidget,
    );
    final double dismissedHeight = tester.getSize(find.byType(Card)).height;
    expect(dismissedHeight, lessThan(midpointHeight));

    tester.widget<SnackBarAction>(find.byType(SnackBarAction)).onPressed();
    await tester.pump();
    await tester.pump();

    expect(
      find.text(
        'Transactions will use Prompt mode until you review the imported setup.',
      ),
      findsOneWidget,
    );
    await tester.pump(const Duration(milliseconds: 100));
    expect(
      tester.getSize(find.byType(Card)).height,
      greaterThan(dismissedHeight),
    );
    await tester.pumpAndSettle();
    expect(tester.getSize(find.byType(Card)).height, closeTo(initialHeight, 1));
  });

  testWidgets('dismisses all visible alerts after confirmation', (
    WidgetTester tester,
  ) async {
    final NotificationAlert firstAlert = NotificationAlert.failure(
      kind: NotificationAlertKind.actionFailed,
      operation: 'Applying notification definition action',
      message: 'The amount capture could not be resolved.',
    );
    final NotificationAlert secondAlert = NotificationAlert.failure(
      kind: NotificationAlertKind.evaluationFailed,
      operation: 'Evaluating notification definition',
      message: 'The notification format was unexpected.',
    );

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: NotificationAlertsPage(
          previewAlerts: <NotificationAlert>[firstAlert, secondAlert],
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Dismiss all'));
    await tester.pumpAndSettle();
    expect(find.text('Dismiss all alerts?'), findsOneWidget);
    final Finder dialogDismissButton = find.descendant(
      of: find.byType(AlertDialog),
      matching: find.widgetWithText(FilledButton, 'Dismiss all'),
    );
    expect(dialogDismissButton, findsOneWidget);

    tester.widget<FilledButton>(dialogDismissButton).onPressed!();
    await tester.pump();
    await tester.pump();

    expect(find.byType(Card), findsNWidgets(2));

    await tester.pump(const Duration(milliseconds: 221));
    expect(find.byType(Card), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 30));

    expect(
      find.text('No notification alerts need your attention.'),
      findsOneWidget,
    );
    expect(find.text('2 alerts dismissed.'), findsOneWidget);
    final SnackBar snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
    expect(snackBar.duration, const Duration(seconds: 6));
    expect(snackBar.persist, isFalse);

    await tester.pump(const Duration(seconds: 6));
    await tester.pumpAndSettle();
    expect(find.text('2 alerts dismissed.'), findsNothing);
  });

  testWidgets('dismisses remaining alerts when one bulk dismissal fails', (
    WidgetTester tester,
  ) async {
    final NotificationAlert firstAlert = NotificationAlert.failure(
      kind: NotificationAlertKind.actionFailed,
      operation: 'Applying notification definition action',
      message: 'The amount capture could not be resolved.',
    );
    final NotificationAlert failedAlert = NotificationAlert.failure(
      kind: NotificationAlertKind.evaluationFailed,
      operation: 'Evaluating notification definition',
      message: 'The notification format was unexpected.',
    );
    final NotificationAlert thirdAlert = NotificationAlert.failure(
      kind: NotificationAlertKind.actionFailed,
      operation: 'Applying another notification action',
      message: 'The payee capture could not be resolved.',
    );
    final FixedAlertStore store = FixedAlertStore(<NotificationAlert>[
      firstAlert,
      failedAlert,
      thirdAlert,
    ], failedDismissFingerprint: failedAlert.fingerprint);

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: NotificationAlertsPage(alertStore: store),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Dismiss all'));
    await tester.pumpAndSettle();
    await tester.tap(
      find.descendant(
        of: find.byType(AlertDialog),
        matching: find.widgetWithText(FilledButton, 'Dismiss all'),
      ),
    );
    await tester.pumpAndSettle();

    expect(store.dismissedFingerprints, <String>[
      firstAlert.fingerprint,
      thirdAlert.fingerprint,
    ]);
    expect(
      find.text('The notification format was unexpected.'),
      findsOneWidget,
    );
    expect(find.text('2 of 3 alerts dismissed.'), findsOneWidget);
  });

  testWidgets('shows stored alerts without mock previews', (
    WidgetTester tester,
  ) async {
    final NotificationAlert storedAlert = NotificationAlert.failure(
      kind: NotificationAlertKind.actionFailed,
      operation: 'Applying notification definition action for "Stored rule"',
      message: 'The stored action could not be applied.',
      applicationId: 'com.example.bank',
      definitionId: 'example-bank',
      ruleId: 'stored-rule',
    );
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: NotificationAlertsPage(
          alertStore: FixedAlertStore(<NotificationAlert>[storedAlert]),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text('Applying notification definition action for "Stored rule"'),
      findsWidgets,
    );
    expect(find.text('Text values cannot be ordered.'), findsNothing);
  });

  testWidgets('persists dismissal of a stored alert', (
    WidgetTester tester,
  ) async {
    final NotificationAlert alert = NotificationAlert.failure(
      kind: NotificationAlertKind.actionFailed,
      operation: 'Applying notification definition action',
      message: 'The stored action could not be applied.',
      applicationId: 'com.example.bank',
    );
    final FixedAlertStore store = FixedAlertStore(<NotificationAlert>[alert]);

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: NotificationAlertsPage(alertStore: store),
      ),
    );
    await tester.pumpAndSettle();

    final Finder alertCard = find.ancestor(
      of: find.text('The stored action could not be applied.'),
      matching: find.byType(Card),
    );
    await tester.tap(alertCard);
    await tester.pumpAndSettle();
    await tester.tap(
      find.descendant(
        of: alertCard,
        matching: find.widgetWithText(TextButton, 'Dismiss'),
      ),
    );
    await tester.pump();

    expect(store.dismissedFingerprint, alert.fingerprint);
    tester.widget<SnackBarAction>(find.byType(SnackBarAction)).onPressed();
    await tester.pump();

    expect(store.restoredAlert?.fingerprint, alert.fingerprint);
  });
}
