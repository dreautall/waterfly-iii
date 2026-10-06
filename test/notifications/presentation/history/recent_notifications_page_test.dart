import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/application/stores/notification_alert_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_definition_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_history_store.dart';
import 'package:waterflyiii/notifications/application/history/recent_notification_history.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/history/notification_history_entry.dart';
import 'package:waterflyiii/notifications/domain/history/notification_processing_outcome.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_action_group.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_patch.dart';
import 'package:waterflyiii/notifications/presentation/history/pages/recent_notifications_page.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_date_time_formatter.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_empty_state.dart';

class _EmptyDefinitionStore implements NotificationDefinitionStore {
  @override
  Future<List<NotificationDefinition>> load() async =>
      const <NotificationDefinition>[];

  @override
  Future<void> save(List<NotificationDefinition> definitions) async {}
}

class _EmptyAlertStore implements NotificationAlertStore {
  @override
  Future<void> clearForApplication(String applicationId) async {}

  @override
  Future<void> clearAll() async {}

  @override
  Future<void> dismiss(String fingerprint) async {}

  @override
  Future<List<NotificationAlert>> load() async => const <NotificationAlert>[];

  @override
  Future<void> record(NotificationAlert alert) async {}

  @override
  Future<void> restore(NotificationAlert alert) async {}
}

class _EmptyHistoryStore implements NotificationHistoryStore {
  @override
  Future<void> clearForApplication(String applicationId) async {}

  @override
  Future<void> clearAll() async {}

  @override
  Future<List<NotificationHistoryEntry>> load() async =>
      const <NotificationHistoryEntry>[];

  @override
  Future<bool> linkTransaction(
    String historyEntryId,
    String transactionId,
  ) async => false;

  @override
  Future<void> record(NotificationHistoryEntry entry) async {}
}

class _TestRecentNotificationHistory extends RecentNotificationHistory {
  _TestRecentNotificationHistory(this.result)
    : super(
        _EmptyDefinitionStore(),
        _EmptyAlertStore(),
        historyStore: _EmptyHistoryStore(),
      );

  final Future<List<RecentNotificationHistoryEntry>> result;

  @override
  Future<List<RecentNotificationHistoryEntry>> load() => result;
}

class _SequentialRecentNotificationHistory extends RecentNotificationHistory {
  _SequentialRecentNotificationHistory(this.results)
    : super(
        _EmptyDefinitionStore(),
        _EmptyAlertStore(),
        historyStore: _EmptyHistoryStore(),
      );

  final List<List<RecentNotificationHistoryEntry>> results;
  int loadCount = 0;

  @override
  Future<List<RecentNotificationHistoryEntry>> load() async {
    final int index = loadCount.clamp(0, results.length - 1);
    loadCount++;
    return results[index];
  }
}

class _ControlledRefreshHistory extends RecentNotificationHistory {
  _ControlledRefreshHistory(this.entries)
    : super(
        _EmptyDefinitionStore(),
        _EmptyAlertStore(),
        historyStore: _EmptyHistoryStore(),
      );

  final List<RecentNotificationHistoryEntry> entries;
  final Completer<List<RecentNotificationHistoryEntry>> refresh =
      Completer<List<RecentNotificationHistoryEntry>>();
  int loadCount = 0;

  @override
  Future<List<RecentNotificationHistoryEntry>> load() {
    loadCount += 1;
    return loadCount == 1
        ? Future<List<RecentNotificationHistoryEntry>>.value(entries)
        : refresh.future;
  }
}

Widget _page(
  Future<List<RecentNotificationHistoryEntry>> result, {
  double textScale = 1,
}) => MaterialApp(
  localizationsDelegates: S.localizationsDelegates,
  supportedLocales: S.supportedLocales,
  builder: (BuildContext context, Widget? child) => MediaQuery(
    data: MediaQuery.of(
      context,
    ).copyWith(textScaler: TextScaler.linear(textScale)),
    child: child!,
  ),
  home: RecentNotificationsPage(
    history: _TestRecentNotificationHistory(result),
  ),
);

void main() {
  testWidgets('scrolls the description and entries as one page', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final List<RecentNotificationHistoryEntry> entries =
        List<RecentNotificationHistoryEntry>.generate(
          12,
          (int index) => RecentNotificationHistoryEntry(
            notification: NotificationHistoryEntry(
              id: 'entry-$index',
              applicationId: 'com.example.bank',
              title: 'Entry $index',
              body: 'Notification body $index',
              receivedAt: DateTime(2026, 9, 27, 18, index),
            ),
          ),
        );

    await tester.pumpWidget(
      _page(Future<List<RecentNotificationHistoryEntry>>.value(entries)),
    );
    await tester.pumpAndSettle();

    final Finder scrollView = find.byType(CustomScrollView);
    final Finder description = find
        .descendant(of: scrollView, matching: find.byType(Text))
        .first;
    expect(find.byType(CustomScrollView), findsOneWidget);
    expect(find.byType(ListView), findsNothing);
    final double initialDescriptionTop = tester.getTopLeft(description).dy;

    await tester.drag(scrollView, const Offset(0, -80));
    await tester.pumpAndSettle();

    expect(
      tester.getTopLeft(description).dy,
      lessThan(initialDescriptionTop - 50),
    );
    expect(tester.getTopLeft(find.text('Entry 0')).dy, lessThan(844));
  });

  testWidgets('reveals the last history card after it expands', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    tester.view.padding = const FakeViewPadding(bottom: 24);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPadding);
    final List<RecentNotificationHistoryEntry> entries =
        List<RecentNotificationHistoryEntry>.generate(
          8,
          (int index) => RecentNotificationHistoryEntry(
            notification: NotificationHistoryEntry(
              id: 'entry-$index',
              applicationId: 'com.example.bank',
              title: 'Entry $index',
              body: 'Notification body $index',
              receivedAt: DateTime(2026, 9, 27, 18, index),
            ),
          ),
        );

    await tester.pumpWidget(
      _page(Future<List<RecentNotificationHistoryEntry>>.value(entries)),
    );
    await tester.pumpAndSettle();

    final Finder scrollView = find.byType(CustomScrollView);
    final Finder scrollable = find.descendant(
      of: scrollView,
      matching: find.byType(Scrollable),
    );
    final Finder lastTitle = find.text('Entry 7');
    await tester.scrollUntilVisible(lastTitle, 300, scrollable: scrollable);
    final ScrollPosition position = tester
        .state<ScrollableState>(scrollable)
        .position;
    final double collapsedOffset = position.pixels;

    await tester.tap(lastTitle);
    await tester.pumpAndSettle();

    final Finder lastCard = find.ancestor(
      of: lastTitle,
      matching: find.byType(RecentNotificationCard),
    );
    expect(position.pixels, greaterThan(collapsedOffset));
    expect(
      tester.getBottomRight(lastCard).dy,
      lessThanOrEqualTo(tester.getBottomRight(scrollView).dy - 40),
    );
  });

  testWidgets('expands only one history entry at a time', (
    WidgetTester tester,
  ) async {
    final List<RecentNotificationHistoryEntry> entries =
        <RecentNotificationHistoryEntry>[
          RecentNotificationHistoryEntry(
            notification: NotificationHistoryEntry(
              id: 'first',
              applicationId: 'com.example.bank',
              title: 'First notification',
              body: 'First body',
              receivedAt: DateTime(2026, 9, 27, 18),
            ),
          ),
          RecentNotificationHistoryEntry(
            notification: NotificationHistoryEntry(
              id: 'second',
              applicationId: 'com.example.bank',
              title: 'Second notification',
              body: 'Second body',
              receivedAt: DateTime(2026, 9, 27, 19),
            ),
          ),
        ];

    await tester.pumpWidget(
      _page(Future<List<RecentNotificationHistoryEntry>>.value(entries)),
    );
    await tester.pumpAndSettle();

    Finder expansionIcon(String title) => find.descendant(
      of: find.ancestor(
        of: find.text(title),
        matching: find.byType(RecentNotificationCard),
      ),
      matching: find.byType(AnimatedRotation),
    );

    await tester.tap(find.text('First notification'));
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<AnimatedRotation>(expansionIcon('First notification'))
          .turns,
      0.5,
    );
    expect(
      tester
          .widget<AnimatedRotation>(expansionIcon('Second notification'))
          .turns,
      0,
    );

    await tester.tap(find.text('Second notification'));
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<AnimatedRotation>(expansionIcon('First notification'))
          .turns,
      0,
    );
    expect(
      tester
          .widget<AnimatedRotation>(expansionIcon('Second notification'))
          .turns,
      0.5,
    );

    await tester.tap(find.text('Second notification'));
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<AnimatedRotation>(expansionIcon('Second notification'))
          .turns,
      0,
    );
  });

  for (final String outcome in <String>[
    'matched rule',
    'shared actions',
    'no matching rule',
    'processing failure',
  ]) {
    testWidgets('opens the definition from the $outcome action menu', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final NotificationHistoryEntry notification = NotificationHistoryEntry(
        id: 'payment',
        applicationId: 'com.example.bank',
        title: 'Card payment',
        body: 'Paid 12.50 CAD',
        receivedAt: DateTime(2026, 9, 6),
      );
      const NotificationDefinition definition = NotificationDefinition(
        id: 'bank',
        applicationId: 'com.example.bank',
        name: 'Example Bank',
        extractors: <RegExpDefinition>[],
        rules: <NotificationRule>[],
        extractorMode: NotificationExtractorMode.advanced,
      );
      final RecentNotificationHistoryEntry entry =
          RecentNotificationHistoryEntry(
            notification: notification,
            definition: definition,
            matchingRule: outcome == 'matched rule'
                ? const NotificationRule(
                    id: 'groceries',
                    name: 'Groceries',
                    conditions: <NotificationCondition>[],
                    actions: <NotificationAction>[],
                  )
                : null,
            canCreateTransaction: outcome == 'shared actions',
            processingFailure: outcome == 'processing failure'
                ? NotificationAlert.failure(
                    kind: NotificationAlertKind.actionFailed,
                    operation: 'Applying notification action',
                    message: 'Processing failed.',
                  )
                : null,
          );
      final _SequentialRecentNotificationHistory history =
          _SequentialRecentNotificationHistory(
            <List<RecentNotificationHistoryEntry>>[
              <RecentNotificationHistoryEntry>[entry],
            ],
          );
      final String primaryLabel = switch (outcome) {
        'matched rule' || 'shared actions' => 'Create transaction',
        'processing failure' => 'View alert',
        _ => 'Create rule',
      };
      int primaryCalls = 0;
      int definitionCalls = 0;
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          home: RecentNotificationsPage(
            history: history,
            actions: RecentNotificationActions(
              createRule: (_) async {
                primaryCalls++;
                return false;
              },
              createTransaction: (_) async {
                primaryCalls++;
              },
              openAlert: (_) async {
                primaryCalls++;
              },
              editRule: (_) async => false,
              openDefinition: (RecentNotificationHistoryEntry selected) async {
                expect(selected.definition, same(definition));
                definitionCalls++;
                await Navigator.of(
                  tester.element(find.byType(RecentNotificationsPage)),
                ).push<void>(
                  MaterialPageRoute<void>(
                    builder: (_) =>
                        const Scaffold(body: Text('Definition editor')),
                  ),
                );
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Card payment'));
      await tester.pumpAndSettle();
      expect(find.text(primaryLabel), findsOneWidget);
      await tester.tap(find.byIcon(Icons.arrow_drop_down));
      await tester.pumpAndSettle();
      expect(find.text('Go to definition'), findsOneWidget);
      expect(
        find.text('Edit rule'),
        outcome == 'matched rule' ? findsOneWidget : findsNothing,
      );
      await tester.tap(find.text('Go to definition'));
      await tester.pumpAndSettle();
      expect(find.text('Definition editor'), findsOneWidget);
      expect(definitionCalls, 1);
      expect(primaryCalls, 0);
      Navigator.of(tester.element(find.text('Definition editor'))).pop();
      await tester.pumpAndSettle();
      expect(history.loadCount, 2);
    });
  }

  testWidgets('shows progress while recent notifications are loading', (
    WidgetTester tester,
  ) async {
    final Completer<List<RecentNotificationHistoryEntry>> completer =
        Completer<List<RecentNotificationHistoryEntry>>();
    await tester.pumpWidget(_page(completer.future));

    expect(
      find.text(
        'Review captured notifications and their processing results. Matched rules and actions reflect what was configured when each notification was processed.',
      ),
      findsOneWidget,
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    completer.complete(const <RecentNotificationHistoryEntry>[]);
    await tester.pumpAndSettle();
  });

  testWidgets('shows an error when recent notifications cannot load', (
    WidgetTester tester,
  ) async {
    final Completer<List<RecentNotificationHistoryEntry>> completer =
        Completer<List<RecentNotificationHistoryEntry>>();
    await tester.pumpWidget(_page(completer.future));
    completer.completeError('database');
    await tester.pumpAndSettle();

    expect(
      find.text('Recent notifications could not be loaded.'),
      findsOneWidget,
    );
  });

  testWidgets('shows an empty state when no recent notifications exist', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      _page(
        Future<List<RecentNotificationHistoryEntry>>.value(
          const <RecentNotificationHistoryEntry>[],
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.history_outlined), findsOneWidget);
    expect(find.text('No recent notifications'), findsOneWidget);
    expect(
      find.text('Notifications received by Waterfly will appear here.'),
      findsOneWidget,
    );
    final Finder scrollView = find.byType(CustomScrollView);
    final CustomScrollView widget = tester.widget(scrollView);
    expect(widget.physics, isA<AlwaysScrollableScrollPhysics>());
    final Finder emptyState = find.byType(NotificationEmptyState);
    final double expectedCenter = tester
        .getCenter(find.byType(NotificationEmptyStateViewport))
        .dy;
    final Finder emptyStateText = find.descendant(
      of: emptyState,
      matching: find.byKey(NotificationEmptyState.textContentKey),
    );
    expect(tester.getCenter(emptyStateText).dy, closeTo(expectedCenter, 1));
  });

  testWidgets('renders notification details and a processing failure', (
    WidgetTester tester,
  ) async {
    final NotificationHistoryEntry notification = NotificationHistoryEntry(
      id: 'payment',
      applicationId: 'com.example.bank',
      title: 'Card payment',
      body: 'Paid 12.50 CAD',
      receivedAt: DateTime(2026, 9, 6, 14, 58),
    );
    final NotificationAlert alert = NotificationAlert.failure(
      kind: NotificationAlertKind.actionFailed,
      operation: 'Applying notification action',
      message: 'The amount capture could not be resolved.',
      applicationId: notification.applicationId,
      definitionId: 'bank',
    );
    await tester.pumpWidget(
      _page(
        Future<List<RecentNotificationHistoryEntry>>.value(
          <RecentNotificationHistoryEntry>[
            RecentNotificationHistoryEntry(
              notification: notification,
              processingFailure: alert,
            ),
          ],
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Card payment'), findsOneWidget);
    expect(find.text('Paid 12.50 CAD'), findsOneWidget);
    final BuildContext cardContext = tester.element(
      find.text('Paid 12.50 CAD'),
    );
    expect(
      find.text(
        formatNotificationDateTime(cardContext, notification.receivedAt),
      ),
      findsOneWidget,
    );
    expect(find.text(alert.message), findsOneWidget);
  });

  testWidgets('renders metadata-only history as redacted details', (
    WidgetTester tester,
  ) async {
    final NotificationHistoryEntry notification = NotificationHistoryEntry(
      id: 'metadata-only',
      applicationId: 'com.example.bank',
      title: '',
      body: '',
      receivedAt: DateTime(2026, 9, 6, 14, 58),
    );
    await tester.pumpWidget(
      _page(
        Future<List<RecentNotificationHistoryEntry>>.value(
          <RecentNotificationHistoryEntry>[
            RecentNotificationHistoryEntry(notification: notification),
          ],
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Notification details hidden'), findsOneWidget);
    expect(
      find.text('Only delivery metadata was stored for this notification.'),
      findsOneWidget,
    );
  });

  testWidgets('uses definition as the action when alert navigation is absent', (
    WidgetTester tester,
  ) async {
    final NotificationHistoryEntry notification = NotificationHistoryEntry(
      id: 'payment',
      applicationId: 'com.example.bank',
      title: 'Card payment',
      body: 'Paid 12.50 CAD',
      receivedAt: DateTime(2026, 9, 6),
    );
    bool openedDefinition = false;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: RecentNotificationsPage(
          history: _TestRecentNotificationHistory(
            Future<List<RecentNotificationHistoryEntry>>.value(
              <RecentNotificationHistoryEntry>[
                RecentNotificationHistoryEntry(
                  notification: notification,
                  definition: const NotificationDefinition(
                    id: 'bank',
                    applicationId: 'com.example.bank',
                    name: 'Example Bank',
                    extractors: <RegExpDefinition>[],
                    rules: <NotificationRule>[],
                  ),
                  processingFailure: NotificationAlert.failure(
                    kind: NotificationAlertKind.actionFailed,
                    operation: 'Applying notification action',
                    message: 'Processing failed.',
                  ),
                ),
              ],
            ),
          ),
          onOpenDefinition: (_) async {
            openedDefinition = true;
          },
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Card payment'));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.arrow_drop_down), findsNothing);
    await tester.tap(find.text('Go to definition'));
    await tester.pumpAndSettle();
    expect(openedDefinition, isTrue);
  });

  testWidgets('shows error controls after expanding a failed notification', (
    WidgetTester tester,
  ) async {
    final NotificationHistoryEntry notification = NotificationHistoryEntry(
      id: 'payment',
      applicationId: 'com.example.bank',
      title: 'Card payment',
      body: 'Paid 12.50 CAD',
      receivedAt: DateTime(2026, 9, 6),
    );
    final NotificationAlert alert = NotificationAlert.failure(
      kind: NotificationAlertKind.actionFailed,
      operation: 'Applying notification action',
      message: 'The amount capture could not be resolved.',
    );
    bool openedAlert = false;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: RecentNotificationsPage(
          history: _TestRecentNotificationHistory(
            Future<List<RecentNotificationHistoryEntry>>.value(
              <RecentNotificationHistoryEntry>[
                RecentNotificationHistoryEntry(
                  notification: notification,
                  processingFailure: alert,
                ),
              ],
            ),
          ),
          onOpenAlert: (_) async => openedAlert = true,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Card payment'));
    await tester.pumpAndSettle();
    final Divider divider = tester.widget<Divider>(find.byType(Divider));
    expect(divider.indent, 16);
    expect(divider.endIndent, 16);
    expect(
      divider.color,
      Theme.of(tester.element(find.byType(Divider))).colorScheme.outlineVariant,
    );
    expect(find.text(alert.message), findsOneWidget);
    expect(find.text('View alert'), findsOneWidget);
    await tester.tap(find.text('View alert'));
    await tester.pumpAndSettle();
    expect(openedAlert, isTrue);
  });

  testWidgets('opens alerts for an uncorrelated processing failure', (
    WidgetTester tester,
  ) async {
    final NotificationHistoryEntry notification = NotificationHistoryEntry(
      id: 'payment',
      applicationId: 'com.example.bank',
      title: 'Card payment',
      body: 'Paid an invalid amount',
      receivedAt: DateTime(2026, 9, 6),
      processingOutcome: const NotificationProcessingOutcome(
        status: NotificationProcessingOutcomeStatus.failed,
        failureMessage: 'The amount could not be parsed.',
      ),
    );
    bool openedAlerts = false;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: RecentNotificationsPage(
          history: _TestRecentNotificationHistory(
            Future<List<RecentNotificationHistoryEntry>>.value(
              <RecentNotificationHistoryEntry>[
                RecentNotificationHistoryEntry(
                  notification: notification,
                  processingOutcome: notification.processingOutcome,
                ),
              ],
            ),
          ),
          onOpenAlerts: () async => openedAlerts = true,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Card payment'));
    await tester.pumpAndSettle();

    expect(find.text('View alerts'), findsOneWidget);
    await tester.tap(find.text('View alerts'));
    await tester.pumpAndSettle();
    expect(openedAlerts, isTrue);
  });

  testWidgets('shows matching rule transaction controls after expansion', (
    WidgetTester tester,
  ) async {
    final NotificationHistoryEntry notification = NotificationHistoryEntry(
      id: 'payment',
      applicationId: 'com.example.bank',
      title: 'Card payment',
      body: 'Paid 12.50 CAD',
      receivedAt: DateTime(2026, 9, 6),
    );
    bool createdTransaction = false;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: RecentNotificationsPage(
          history: _TestRecentNotificationHistory(
            Future<List<RecentNotificationHistoryEntry>>.value(
              <RecentNotificationHistoryEntry>[
                RecentNotificationHistoryEntry(
                  notification: notification,
                  matchingRule: const NotificationRule(
                    id: 'groceries',
                    name: 'Groceries',
                    conditions: <NotificationCondition>[],
                    actions: <NotificationAction>[],
                  ),
                  matchingConditionalActionGroups:
                      const <NotificationActionGroup>[
                        NotificationActionGroup(
                          id: 'weekend',
                          name: 'Weekend purchase',
                          conditions: <NotificationCondition>[],
                          actions: <NotificationAction>[],
                        ),
                        NotificationActionGroup(
                          id: 'foreign-currency',
                          name: 'Foreign currency',
                          conditions: <NotificationCondition>[],
                          actions: <NotificationAction>[],
                        ),
                      ],
                ),
              ],
            ),
          ),
          onCreateTransaction: (_) async => createdTransaction = true,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Card payment'));
    await tester.pumpAndSettle();
    expect(find.text('Matched rule'), findsOneWidget);
    expect(find.text('Groceries'), findsOneWidget);
    expect(find.text('Matched actions'), findsOneWidget);
    expect(find.text('Weekend purchase'), findsOneWidget);
    expect(find.text('Foreign currency'), findsOneWidget);
    expect(find.byIcon(Icons.alt_route), findsNWidgets(2));
    expect(find.byKey(const Key('matched-action-0')), findsOneWidget);
    expect(find.byKey(const Key('matched-action-connector-0')), findsOneWidget);
    expect(find.byKey(const Key('matched-action-connector-1')), findsNothing);
    expect(find.text('No conditional actions matched.'), findsNothing);
    await tester.tap(find.text('Create transaction'));
    await tester.pumpAndSettle();
    expect(createdTransaction, isTrue);
  });

  testWidgets('refreshes a history card after creating its transaction', (
    WidgetTester tester,
  ) async {
    const NotificationProcessingOutcome pendingOutcome =
        NotificationProcessingOutcome(
          status: NotificationProcessingOutcomeStatus.matched,
          rule: NotificationHistoryReference(
            id: 'groceries',
            name: 'Groceries',
          ),
          transactionCreationMode: TransactionCreationMode.prompt,
          hasTransactionIntent: true,
          transactionPatch: TransactionPatch(<TransactionField, String>{
            TransactionField.amount: '12.50',
          }),
        );
    final NotificationHistoryEntry pendingNotification =
        NotificationHistoryEntry(
          id: 'payment',
          applicationId: 'com.example.bank',
          title: 'Card payment',
          body: 'Paid 12.50 CAD',
          receivedAt: DateTime(2026, 9, 6),
          processingOutcome: pendingOutcome,
        );
    final NotificationHistoryEntry linkedNotification =
        NotificationHistoryEntry(
          id: pendingNotification.id,
          applicationId: pendingNotification.applicationId,
          title: pendingNotification.title,
          body: pendingNotification.body,
          receivedAt: pendingNotification.receivedAt,
          processingOutcome: pendingOutcome.withTransactionId(
            'transaction-42',
            origin: NotificationTransactionCreationOrigin.user,
          ),
        );
    final _SequentialRecentNotificationHistory history =
        _SequentialRecentNotificationHistory(
          <List<RecentNotificationHistoryEntry>>[
            <RecentNotificationHistoryEntry>[
              RecentNotificationHistoryEntry(
                notification: pendingNotification,
                processingOutcome: pendingOutcome,
              ),
            ],
            <RecentNotificationHistoryEntry>[
              RecentNotificationHistoryEntry(
                notification: linkedNotification,
                processingOutcome: linkedNotification.processingOutcome,
              ),
            ],
          ],
        );

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: RecentNotificationsPage(
          history: history,
          onCreateTransaction: (_) async {},
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Card payment'));
    await tester.pumpAndSettle();
    expect(find.text('Create transaction'), findsOneWidget);

    await tester.tap(find.text('Create transaction'));
    await tester.pumpAndSettle();

    expect(history.loadCount, 2);
    expect(find.text('Transaction created from notification'), findsOneWidget);
    expect(find.text('Transaction created automatically'), findsNothing);
    expect(find.text('View transaction'), findsOneWidget);
    expect(find.text('Create transaction'), findsNothing);
  });

  testWidgets(
    'shows create transaction after a linked transaction is unavailable',
    (WidgetTester tester) async {
      const NotificationProcessingOutcome
      linkedOutcome = NotificationProcessingOutcome(
        status: NotificationProcessingOutcomeStatus.matched,
        rule: NotificationHistoryReference(id: 'groceries', name: 'Groceries'),
        transactionCreationMode: TransactionCreationMode.prompt,
        hasTransactionIntent: true,
        transactionPatch: TransactionPatch(<TransactionField, String>{
          TransactionField.amount: '12.50',
        }),
        transactionId: 'transaction-42',
        transactionCreationOrigin: NotificationTransactionCreationOrigin.user,
      );
      final NotificationHistoryEntry linkedNotification =
          NotificationHistoryEntry(
            id: 'payment',
            applicationId: 'com.example.bank',
            title: 'Card payment',
            body: 'Paid 12.50 CAD',
            receivedAt: DateTime(2026, 9, 6),
            processingOutcome: linkedOutcome,
          );
      final NotificationHistoryEntry unlinkedNotification =
          NotificationHistoryEntry(
            id: linkedNotification.id,
            applicationId: linkedNotification.applicationId,
            title: linkedNotification.title,
            body: linkedNotification.body,
            receivedAt: linkedNotification.receivedAt,
            processingOutcome: linkedOutcome.withoutTransactionLink(),
          );
      final _SequentialRecentNotificationHistory history =
          _SequentialRecentNotificationHistory(
            <List<RecentNotificationHistoryEntry>>[
              <RecentNotificationHistoryEntry>[
                RecentNotificationHistoryEntry(
                  notification: linkedNotification,
                  processingOutcome: linkedOutcome,
                  canCreateTransaction: true,
                ),
              ],
              <RecentNotificationHistoryEntry>[
                RecentNotificationHistoryEntry(
                  notification: unlinkedNotification,
                  processingOutcome: unlinkedNotification.processingOutcome,
                  canCreateTransaction: true,
                ),
              ],
            ],
          );
      String? unlinkedHistoryId;
      String? unlinkedTransactionId;

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          home: RecentNotificationsPage(
            history: history,
            actions: RecentNotificationActions(
              createTransaction: (_) async {},
              transactionExists: (_) async => false,
              unlinkTransaction:
                  (String historyEntryId, String expectedTransactionId) async {
                    unlinkedHistoryId = historyEntryId;
                    unlinkedTransactionId = expectedTransactionId;
                    return true;
                  },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Card payment'));
      await tester.pumpAndSettle();

      expect(unlinkedHistoryId, 'payment');
      expect(unlinkedTransactionId, 'transaction-42');
      expect(history.loadCount, 2);
      expect(find.text('Create transaction'), findsOneWidget);
      expect(find.text('View transaction'), findsNothing);
    },
  );

  testWidgets('keeps a transaction link when validation fails transiently', (
    WidgetTester tester,
  ) async {
    const NotificationProcessingOutcome linkedOutcome =
        NotificationProcessingOutcome(
          status: NotificationProcessingOutcomeStatus.matched,
          rule: NotificationHistoryReference(
            id: 'groceries',
            name: 'Groceries',
          ),
          transactionCreationMode: TransactionCreationMode.prompt,
          hasTransactionIntent: true,
          transactionPatch: TransactionPatch(<TransactionField, String>{
            TransactionField.amount: '12.50',
          }),
          transactionId: 'transaction-42',
          transactionCreationOrigin: NotificationTransactionCreationOrigin.user,
        );
    final NotificationHistoryEntry notification = NotificationHistoryEntry(
      id: 'payment',
      applicationId: 'com.example.bank',
      title: 'Card payment',
      body: 'Paid 12.50 CAD',
      receivedAt: DateTime(2026, 9, 6),
      processingOutcome: linkedOutcome,
    );
    bool unlinkCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: RecentNotificationsPage(
          history: _TestRecentNotificationHistory(
            Future<List<RecentNotificationHistoryEntry>>.value(
              <RecentNotificationHistoryEntry>[
                RecentNotificationHistoryEntry(
                  notification: notification,
                  processingOutcome: linkedOutcome,
                ),
              ],
            ),
          ),
          actions: RecentNotificationActions(
            openTransaction: (_) async {},
            transactionExists: (_) =>
                Future<bool>.error(StateError('Firefly unavailable')),
            unlinkTransaction: (_, _) async {
              unlinkCalled = true;
              return true;
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Card payment'));
    await tester.pumpAndSettle();

    expect(unlinkCalled, isFalse);
    expect(find.text('View transaction'), findsOneWidget);
  });

  testWidgets('pulls to refresh recent notification history', (
    WidgetTester tester,
  ) async {
    final _SequentialRecentNotificationHistory history =
        _SequentialRecentNotificationHistory(
          <List<RecentNotificationHistoryEntry>>[
            const <RecentNotificationHistoryEntry>[],
            const <RecentNotificationHistoryEntry>[],
          ],
        );
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: RecentNotificationsPage(history: history),
      ),
    );
    await tester.pumpAndSettle();

    await tester.drag(find.byType(CustomScrollView), const Offset(0, 300));
    await tester.pumpAndSettle();

    expect(history.loadCount, 2);
  });

  testWidgets('animates history cards while pull refresh is loading', (
    WidgetTester tester,
  ) async {
    final NotificationHistoryEntry notification = NotificationHistoryEntry(
      id: 'payment',
      applicationId: 'com.example.bank',
      title: 'Card payment',
      body: 'Paid 12.50 CAD',
      receivedAt: DateTime(2026, 9, 6),
    );
    final _ControlledRefreshHistory history = _ControlledRefreshHistory(
      <RecentNotificationHistoryEntry>[
        RecentNotificationHistoryEntry(notification: notification),
      ],
    );
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: RecentNotificationsPage(history: history),
      ),
    );
    await tester.pumpAndSettle();

    final RefreshIndicator indicator = tester.widget<RefreshIndicator>(
      find.byType(RefreshIndicator),
    );

    unawaited(indicator.onRefresh());
    await tester.pump(const Duration(milliseconds: 200));

    expect(history.loadCount, 2);
    expect(
      tester
          .widget<AnimatedOpacity>(
            find.byKey(const Key('history-refresh-opacity-payment')),
          )
          .opacity,
      0.58,
    );

    history.refresh.complete(history.entries);
    await tester.pump();

    expect(find.byKey(const Key('history-refresh-payment-1')), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('Card payment'), findsOneWidget);
  });

  testWidgets('offers matched rule editing from the split button menu', (
    WidgetTester tester,
  ) async {
    final NotificationHistoryEntry notification = NotificationHistoryEntry(
      id: 'payment',
      applicationId: 'com.example.bank',
      title: 'Card payment',
      body: 'Paid 12.50 CAD',
      receivedAt: DateTime(2026, 9, 6),
    );
    bool createdTransaction = false;
    bool editedRule = false;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: RecentNotificationsPage(
          history: _TestRecentNotificationHistory(
            Future<List<RecentNotificationHistoryEntry>>.value(
              <RecentNotificationHistoryEntry>[
                RecentNotificationHistoryEntry(
                  notification: notification,
                  matchingRule: const NotificationRule(
                    id: 'groceries',
                    name: 'Groceries',
                    conditions: <NotificationCondition>[],
                    actions: <NotificationAction>[],
                  ),
                ),
              ],
            ),
          ),
          onCreateTransaction: (_) async => createdTransaction = true,
          onEditRule: (_) async => editedRule = true,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Card payment'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Create transaction'));
    await tester.pumpAndSettle();
    expect(createdTransaction, isTrue);
    expect(editedRule, isFalse);

    await tester.tap(find.byIcon(Icons.arrow_drop_down));
    await tester.pumpAndSettle();
    final Rect dropdownIconRect = tester.getRect(
      find.byIcon(Icons.arrow_drop_down),
    );
    final Rect editRuleMenuItemRect = tester.getRect(find.text('Edit rule'));
    expect(
      editRuleMenuItemRect.top,
      greaterThanOrEqualTo(dropdownIconRect.bottom),
    );
    await tester.tap(find.text('Edit rule'));
    await tester.pumpAndSettle();
    expect(editedRule, isTrue);
  });

  testWidgets('removes one entry from the split button menu', (
    WidgetTester tester,
  ) async {
    final NotificationHistoryEntry notification = NotificationHistoryEntry(
      id: 'payment',
      applicationId: 'com.example.bank',
      title: 'Card payment',
      body: 'Paid 12.50 CAD',
      receivedAt: DateTime(2026, 9, 6),
    );
    final _SequentialRecentNotificationHistory history =
        _SequentialRecentNotificationHistory(
          <List<RecentNotificationHistoryEntry>>[
            <RecentNotificationHistoryEntry>[
              RecentNotificationHistoryEntry(notification: notification),
            ],
            <RecentNotificationHistoryEntry>[],
            <RecentNotificationHistoryEntry>[
              RecentNotificationHistoryEntry(notification: notification),
            ],
          ],
        );
    String? removedId;
    String? restoredId;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: RecentNotificationsPage(
          history: history,
          actions: RecentNotificationActions(
            removeFromHistory: (RecentNotificationHistoryEntry entry) async {
              removedId = entry.notification.id;
            },
            restoreToHistory: (RecentNotificationHistoryEntry entry) async {
              restoredId = entry.notification.id;
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Card payment'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.arrow_drop_down));
    await tester.pumpAndSettle();
    final Finder removeAction = find.text('Remove from recent history');
    expect(removeAction, findsOneWidget);
    final Text removeLabel = tester.widget<Text>(removeAction);
    expect(
      removeLabel.style?.color,
      Theme.of(tester.element(removeAction)).colorScheme.error,
    );

    await tester.tap(find.text('Remove from recent history'));
    await tester.pumpAndSettle();
    expect(find.text('Remove notification from history?'), findsOneWidget);
    expect(
      find.textContaining(
        'Any Firefly transaction created from it will not be deleted.',
      ),
      findsOneWidget,
    );

    await tester.tap(find.text('Remove from recent history').last);
    await tester.pumpAndSettle();

    expect(removedId, 'payment');
    expect(history.loadCount, 2);
    expect(find.text('No recent notifications'), findsOneWidget);
    expect(
      find.text('Notification removed from recent history.'),
      findsOneWidget,
    );
    expect(find.text('Undo'), findsOneWidget);

    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();

    expect(restoredId, 'payment');
    expect(history.loadCount, 3);
    expect(find.text('Card payment'), findsOneWidget);
  });

  testWidgets('places received time immediately after the notification title', (
    WidgetTester tester,
  ) async {
    final NotificationHistoryEntry notification = NotificationHistoryEntry(
      id: 'payment',
      applicationId: 'com.example.bank',
      title: 'Card payment',
      body: 'Paid 12.50 CAD',
      receivedAt: DateTime(2026, 9, 6, 14, 30),
    );
    await tester.pumpWidget(
      _page(
        Future<List<RecentNotificationHistoryEntry>>.value(
          <RecentNotificationHistoryEntry>[
            RecentNotificationHistoryEntry(notification: notification),
          ],
        ),
      ),
    );
    await tester.pumpAndSettle();

    final Finder title = find.text('Card payment');
    final Finder body = find.text('Paid 12.50 CAD');
    final String formattedDateTime = formatNotificationDateTime(
      tester.element(title),
      notification.receivedAt,
    );
    final Finder dateTime = find.text(formattedDateTime);

    expect(
      tester.getTopLeft(dateTime).dx,
      closeTo(tester.getTopRight(title).dx + 8, 1),
    );
    expect(
      tester.getTopLeft(body).dy,
      greaterThan(tester.getBottomLeft(title).dy),
    );
    expect(
      tester.getCenter(dateTime).dy,
      closeTo(tester.getCenter(title).dy, 4),
    );
  });

  testWidgets('wraps received time without overflow in constrained layouts', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(320, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final NotificationHistoryEntry notification = NotificationHistoryEntry(
      id: 'payment',
      applicationId: 'com.example.bank',
      title: 'Card payment',
      body: 'Paid 12.50 CAD',
      receivedAt: DateTime(2026, 9, 6, 14, 30),
    );
    await tester.pumpWidget(
      _page(
        Future<List<RecentNotificationHistoryEntry>>.value(
          <RecentNotificationHistoryEntry>[
            RecentNotificationHistoryEntry(notification: notification),
          ],
        ),
        textScale: 2,
      ),
    );
    await tester.pumpAndSettle();

    final Finder title = find.text('Card payment');
    final Finder dateTime = find.text(
      formatNotificationDateTime(
        tester.element(title),
        notification.receivedAt,
      ),
    );

    expect(
      tester.getTopLeft(dateTime).dy,
      greaterThan(tester.getTopLeft(title).dy),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('creates a transaction from an unconditional selected rule', (
    WidgetTester tester,
  ) async {
    final NotificationHistoryEntry notification = NotificationHistoryEntry(
      id: 'payment',
      applicationId: 'com.example.bank',
      title: 'Card payment',
      body: 'Paid 12.50 CAD',
      receivedAt: DateTime(2026, 9, 6),
    );
    bool requestedRule = false;
    bool createdTransaction = false;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: RecentNotificationsPage(
          history: _TestRecentNotificationHistory(
            Future<List<RecentNotificationHistoryEntry>>.value(
              <RecentNotificationHistoryEntry>[
                RecentNotificationHistoryEntry(
                  notification: notification,
                  matchingRule: const NotificationRule(
                    id: 'default',
                    name: 'Transaction details',
                    conditions: <NotificationCondition>[],
                    actions: <NotificationAction>[],
                  ),
                ),
              ],
            ),
          ),
          onCreateRule: (_) async => requestedRule = true,
          onCreateTransaction: (_) async => createdTransaction = true,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Card payment'));
    await tester.pumpAndSettle();
    expect(find.text('Create transaction'), findsOneWidget);
    expect(find.text('Matched actions'), findsNothing);
    expect(find.text('No conditional actions matched.'), findsNothing);
    await tester.tap(find.text('Create transaction'));
    await tester.pumpAndSettle();
    expect(requestedRule, isFalse);
    expect(createdTransaction, isTrue);
  });

  testWidgets('creates a transaction from shared actions without a rule', (
    WidgetTester tester,
  ) async {
    final NotificationHistoryEntry notification = NotificationHistoryEntry(
      id: 'payment',
      applicationId: 'com.example.bank',
      title: 'Card payment',
      body: 'Paid 12.50 CAD',
      receivedAt: DateTime(2026, 9, 6),
    );
    bool requestedRule = false;
    bool createdTransaction = false;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: RecentNotificationsPage(
          history: _TestRecentNotificationHistory(
            Future<List<RecentNotificationHistoryEntry>>.value(
              <RecentNotificationHistoryEntry>[
                RecentNotificationHistoryEntry(
                  notification: notification,
                  canCreateTransaction: true,
                ),
              ],
            ),
          ),
          onCreateRule: (_) async => requestedRule = true,
          onCreateTransaction: (_) async => createdTransaction = true,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Card payment'));
    await tester.pumpAndSettle();
    expect(find.text('Transaction fields matched'), findsOneWidget);
    expect(
      find.text(
        'Shared actions can create a transaction from this notification.',
      ),
      findsOneWidget,
    );
    expect(find.text('Create transaction'), findsOneWidget);
    expect(find.text('Create rule'), findsNothing);
    expect(find.byIcon(Icons.arrow_drop_down), findsNothing);
    await tester.tap(find.text('Create transaction'));
    await tester.pumpAndSettle();
    expect(requestedRule, isFalse);
    expect(createdTransaction, isTrue);
  });

  testWidgets('shows no-rule controls after expansion', (
    WidgetTester tester,
  ) async {
    final NotificationHistoryEntry notification = NotificationHistoryEntry(
      id: 'payment',
      applicationId: 'com.example.bank',
      title: 'Card payment',
      body: 'Paid 12.50 CAD',
      receivedAt: DateTime(2026, 9, 6),
    );
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: RecentNotificationsPage(
          history: _TestRecentNotificationHistory(
            Future<List<RecentNotificationHistoryEntry>>.value(
              <RecentNotificationHistoryEntry>[
                RecentNotificationHistoryEntry(notification: notification),
              ],
            ),
          ),
          onCreateRule: (_) async => true,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Card payment'));
    await tester.pumpAndSettle();
    expect(find.text('No matching rule'), findsOneWidget);
    expect(
      find.text(
        'Create a rule so similar notifications can be processed automatically.',
      ),
      findsOneWidget,
    );
    expect(find.text('Create rule'), findsOneWidget);
    expect(
      tester.widget<AnimatedAlign>(find.byType(AnimatedAlign)).heightFactor,
      1,
    );

    await tester.tap(find.text('No matching rule'));
    await tester.pumpAndSettle();

    expect(
      tester.widget<AnimatedAlign>(find.byType(AnimatedAlign)).heightFactor,
      0,
    );
  });

  testWidgets('offers rule creation only for advanced registrations', (
    WidgetTester tester,
  ) async {
    bool requestedRule = false;
    final NotificationHistoryEntry notification = NotificationHistoryEntry(
      id: 'payment',
      applicationId: 'com.example.bank',
      title: 'Card payment',
      body: 'Paid 12.50 CAD',
      receivedAt: DateTime(2026, 9, 7),
    );
    final NotificationDefinition definition = const NotificationDefinition(
      id: 'bank',
      applicationId: 'com.example.bank',
      name: 'Example Bank',
      extractors: <RegExpDefinition>[],
      rules: <NotificationRule>[],
      extractorMode: NotificationExtractorMode.advanced,
    );
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: RecentNotificationsPage(
          history: _TestRecentNotificationHistory(
            Future<List<RecentNotificationHistoryEntry>>.value(
              <RecentNotificationHistoryEntry>[
                RecentNotificationHistoryEntry(
                  notification: notification,
                  definition: definition,
                ),
              ],
            ),
          ),
          onCreateRule: (_) async {
            requestedRule = true;
            return true;
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Card payment'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Create rule'));
    await tester.pumpAndSettle();

    expect(requestedRule, isTrue);
  });

  testWidgets('reevaluates matching rules after creating a rule', (
    WidgetTester tester,
  ) async {
    final NotificationHistoryEntry notification = NotificationHistoryEntry(
      id: 'payment',
      applicationId: 'com.example.bank',
      title: 'Card payment',
      body: 'Paid 12.50 CAD',
      receivedAt: DateTime(2026, 9, 7),
    );
    final NotificationDefinition definition = const NotificationDefinition(
      id: 'bank',
      applicationId: 'com.example.bank',
      name: 'Example Bank',
      extractors: <RegExpDefinition>[],
      rules: <NotificationRule>[],
      extractorMode: NotificationExtractorMode.advanced,
    );
    const NotificationRule newRule = NotificationRule(
      id: 'card-payment',
      name: 'Card purchases',
      conditions: <NotificationCondition>[],
      actions: <NotificationAction>[],
    );
    final _SequentialRecentNotificationHistory history =
        _SequentialRecentNotificationHistory(
          <List<RecentNotificationHistoryEntry>>[
            <RecentNotificationHistoryEntry>[
              RecentNotificationHistoryEntry(
                notification: notification,
                definition: definition,
              ),
            ],
            <RecentNotificationHistoryEntry>[
              RecentNotificationHistoryEntry(
                notification: notification,
                definition: definition.copyWith(
                  rules: const <NotificationRule>[newRule],
                ),
                matchingRule: newRule,
              ),
            ],
          ],
        );
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: RecentNotificationsPage(
          history: history,
          onCreateRule: (_) async => true,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Card payment'));
    await tester.pumpAndSettle();
    expect(find.text('No matching rule'), findsOneWidget);

    await tester.tap(find.text('Create rule'));
    await tester.pumpAndSettle();

    expect(history.loadCount, 2);
    expect(find.text('Matched rule'), findsOneWidget);
    expect(find.text('Card purchases'), findsOneWidget);
  });

  testWidgets('shows collapsible recorded full transaction details', (
    WidgetTester tester,
  ) async {
    final NotificationHistoryEntry notification = NotificationHistoryEntry(
      id: 'payment',
      applicationId: 'com.example.bank',
      title: 'Card payment',
      body: 'Paid 12.50 CAD',
      receivedAt: DateTime(2026, 9, 26),
      processingOutcome: const NotificationProcessingOutcome(
        status: NotificationProcessingOutcomeStatus.matched,
        definition: NotificationHistoryReference(
          id: 'bank',
          name: 'Example Bank',
        ),
        rule: NotificationHistoryReference(id: 'groceries', name: 'Groceries'),
        hasTransactionIntent: true,
        transactionPatch: TransactionPatch(<TransactionField, String>{
          TransactionField.amount: '12.50',
          TransactionField.currency: 'CAD',
          TransactionField.date: '2026-09-26',
          TransactionField.time: '14:30',
        }),
      ),
    );
    await tester.pumpWidget(
      _page(
        Future<List<RecentNotificationHistoryEntry>>.value(
          <RecentNotificationHistoryEntry>[
            RecentNotificationHistoryEntry(
              notification: notification,
              processingOutcome: notification.processingOutcome,
              canCreateTransaction: true,
              currentCanCreateTransaction: false,
            ),
          ],
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Card payment'));
    await tester.pumpAndSettle();

    expect(find.text('Groceries'), findsOneWidget);
    expect(find.text('Transaction summary').hitTestable(), findsNothing);
    expect(
      find.byKey(const Key('notification-outcome-divider')).hitTestable(),
      findsOneWidget,
    );

    await tester.tap(find.text('Groceries'));
    await tester.pumpAndSettle();

    expect(find.text('Classification').hitTestable(), findsOneWidget);
    final Card outcomeCard = tester.widget<Card>(
      find.byKey(const Key('notification-outcome-card')),
    );
    expect(outcomeCard.margin, EdgeInsets.zero);
    expect(
      outcomeCard.color,
      Theme.of(
        tester.element(find.byKey(const Key('notification-outcome-card'))),
      ).cardColor,
    );
    expect(
      tester
          .widget<Row>(find.byKey(const Key('notification-outcome-header')))
          .crossAxisAlignment,
      CrossAxisAlignment.center,
    );
    expect(
      find.byKey(const Key('notification-outcome-divider')),
      findsOneWidget,
    );
    expect(find.text('12.50'), findsOneWidget);
    expect(find.text('Classification'), findsOneWidget);
    expect(find.text('Currency'), findsOneWidget);
    expect(find.text('CAD'), findsOneWidget);
    final Row dateRow = tester.widget<Row>(
      find.byKey(const Key('transaction-field-date')),
    );
    final Row timeRow = tester.widget<Row>(
      find.byKey(const Key('transaction-field-time')),
    );
    expect(dateRow.crossAxisAlignment, CrossAxisAlignment.center);
    expect(timeRow.crossAxisAlignment, CrossAxisAlignment.center);

    await tester.tap(find.text('CAD'));
    await tester.pumpAndSettle();
    expect(find.text('Classification').hitTestable(), findsNothing);
    expect(find.text('Additional details').hitTestable(), findsNothing);

    await tester.tap(find.text('Groceries'));
    await tester.pumpAndSettle();
    expect(find.text('Classification').hitTestable(), findsOneWidget);
    expect(find.text('Additional details').hitTestable(), findsOneWidget);
    expect(find.text('Test with current definition'), findsNothing);
  });

  testWidgets('opens the transaction created automatically', (
    WidgetTester tester,
  ) async {
    const String transactionId = '1042';
    final NotificationHistoryEntry notification = NotificationHistoryEntry(
      id: 'salary',
      applicationId: 'com.example.bank',
      title: 'Salary deposited',
      body: 'Salary deposit of 3250.00 CAD',
      receivedAt: DateTime(2026, 9, 26),
      processingOutcome: const NotificationProcessingOutcome(
        status: NotificationProcessingOutcomeStatus.matched,
        definition: NotificationHistoryReference(
          id: 'bank',
          name: 'Example Bank',
        ),
        rule: NotificationHistoryReference(
          id: 'salary',
          name: 'Salary deposits',
        ),
        transactionCreationMode: TransactionCreationMode.automatic,
        hasTransactionIntent: true,
        transactionPatch: TransactionPatch(<TransactionField, String>{
          TransactionField.title: 'Salary',
          TransactionField.amount: '3250.00',
        }),
        transactionId: transactionId,
        transactionCreationOrigin:
            NotificationTransactionCreationOrigin.automatic,
      ),
    );
    String? openedTransactionId;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: RecentNotificationsPage(
          history: _TestRecentNotificationHistory(
            Future<List<RecentNotificationHistoryEntry>>.value(
              <RecentNotificationHistoryEntry>[
                RecentNotificationHistoryEntry(
                  notification: notification,
                  processingOutcome: notification.processingOutcome,
                  canCreateTransaction: true,
                ),
              ],
            ),
          ),
          onCreateTransaction: (_) => throw TestFailure(
            'Automatic history must not create another transaction.',
          ),
          onOpenTransaction: (String id) async {
            openedTransactionId = id;
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Salary deposited'));
    await tester.pumpAndSettle();

    expect(find.text('Transaction created automatically'), findsOneWidget);
    expect(find.text('Salary deposits'), findsOneWidget);
    expect(find.text('View transaction'), findsOneWidget);
    expect(find.text('Create transaction'), findsNothing);

    await tester.tap(find.text('View transaction'));
    await tester.pump();

    expect(openedTransactionId, transactionId);
  });

  testWidgets('hides transaction values for metadata-only outcomes', (
    WidgetTester tester,
  ) async {
    final NotificationHistoryEntry notification = NotificationHistoryEntry(
      id: 'payment',
      applicationId: 'com.example.bank',
      title: '',
      body: '',
      receivedAt: DateTime(2026, 9, 26),
      processingOutcome: const NotificationProcessingOutcome(
        status: NotificationProcessingOutcomeStatus.matched,
        definition: NotificationHistoryReference(
          id: 'bank',
          name: 'Example Bank',
        ),
        rule: NotificationHistoryReference(id: 'groceries', name: 'Groceries'),
        hasTransactionIntent: true,
      ),
    );
    await tester.pumpWidget(
      _page(
        Future<List<RecentNotificationHistoryEntry>>.value(
          <RecentNotificationHistoryEntry>[
            RecentNotificationHistoryEntry(
              notification: notification,
              processingOutcome: notification.processingOutcome,
              canCreateTransaction: true,
            ),
          ],
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Notification details hidden'));
    await tester.pumpAndSettle();

    expect(find.text('Transaction details hidden'), findsOneWidget);
    expect(find.textContaining('12.50'), findsNothing);
  });
}
