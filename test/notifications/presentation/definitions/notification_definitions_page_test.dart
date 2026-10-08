import 'package:appcheck/appcheck.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/application/listeners/notification_access_settings_launcher.dart';
import 'package:waterflyiii/notifications/application/listeners/notification_listener_status.dart';
import 'package:waterflyiii/notifications/application/listeners/notification_listener_health_service.dart';
import 'package:waterflyiii/notifications/application/stores/notification_alert_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_definition_store.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/listeners/notification_listener_health_issue.dart';
import 'package:waterflyiii/notifications/presentation/health/controllers/notification_listener_health_view_model.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/presentation/definitions/pages/notification_definitions_page.dart';
import 'package:waterflyiii/notifications/presentation/definitions/widgets/notification_definition_card.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/applications/notification_application_selector_dialog.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_card_theme.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_empty_state.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_page_header.dart';

import '../../support/in_memory_notification_stores.dart';

class PageDefinitionStore implements NotificationDefinitionStore {
  PageDefinitionStore({
    this.error,
    this.definitions = const <NotificationDefinition>[],
  });

  final Object? error;
  List<NotificationDefinition> definitions;

  @override
  Future<List<NotificationDefinition>> load() {
    if (error != null) {
      return Future<List<NotificationDefinition>>.error(error!);
    }
    return Future<List<NotificationDefinition>>.value(definitions);
  }

  @override
  Future<void> save(List<NotificationDefinition> definitions) async {
    this.definitions = List<NotificationDefinition>.of(definitions);
  }
}

class FakeNotificationListenerStatusLoader
    implements NotificationListenerStatusLoader {
  FakeNotificationListenerStatusLoader([
    this.status = const NotificationListenerStatus(true, true, true),
  ]);

  NotificationListenerStatus status;
  bool wasLoaded = false;
  int loadCount = 0;

  @override
  Future<NotificationListenerStatus> load() async {
    wasLoaded = true;
    loadCount++;
    return status;
  }
}

class FakeNotificationAccessSettingsLauncher
    implements NotificationAccessSettingsLauncher {
  int openCount = 0;

  @override
  Future<bool> openNotificationAccessSettings() async {
    openCount++;
    return true;
  }
}

Widget notificationPage(
  NotificationDefinitionStore store, {
  NotificationListenerStatusLoader? statusLoader,
  NotificationAccessSettingsLauncher? accessSettingsLauncher,
  NotificationListenerHealthViewModel? healthViewModel,
  NotificationAlertStore? alertStore,
  NotificationApplicationSelector? applicationSelector,
  ThemeData? theme,
}) {
  return MaterialApp(
    theme: theme,
    localizationsDelegates: S.localizationsDelegates,
    supportedLocales: S.supportedLocales,
    home: NotificationDefinitionsPage(
      store: store,
      alertStore: alertStore,
      statusLoader: statusLoader,
      accessSettingsLauncher: accessSettingsLauncher,
      healthViewModel: healthViewModel,
      applicationSelector: applicationSelector,
      showAppBar: true,
    ),
  );
}

void main() {
  testWidgets('does not expose pull to refresh', (WidgetTester tester) async {
    await tester.pumpWidget(notificationPage(PageDefinitionStore()));
    await tester.pumpAndSettle();

    expect(find.byType(RefreshIndicator), findsNothing);
    final CustomScrollView scrollView = tester.widget<CustomScrollView>(
      find.byType(CustomScrollView),
    );
    expect(scrollView.physics, isA<ClampingScrollPhysics>());
    expect(scrollView.physics, isNot(isA<AlwaysScrollableScrollPhysics>()));
  });

  testWidgets('uses dynamic surfaces for access status and add button', (
    WidgetTester tester,
  ) async {
    const Color dynamicSurface = Color(0xff334455);
    await tester.binding.setSurfaceSize(const Size(800, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      notificationPage(
        PageDefinitionStore(),
        theme: ThemeData(
          extensions: const <ThemeExtension<dynamic>>[
            NotificationCardTheme(
              surfaceColor: dynamicSurface,
              nestedSurfaceColor: Color(0xff445566),
              deepNestedSurfaceColor: Color(0xff556677),
            ),
          ],
        ),
      ),
    );
    await tester.pumpAndSettle();

    final Finder addButton = find.byKey(
      const Key('add-notification-application'),
    );
    final ThemeData scopedTheme = Theme.of(tester.element(addButton));
    expect(
      scopedTheme.elevatedButtonTheme.style?.backgroundColor?.resolve(
        const <WidgetState>{},
      ),
      dynamicSurface,
    );
    expect(tester.widget<Card>(find.byType(Card).first).color, dynamicSurface);
    final BoxDecoration dynamicHeaderDecoration =
        tester
                .widget<DecoratedBox>(
                  find.descendant(
                    of: find.byType(NotificationPageHeaderControl).first,
                    matching: find.byType(DecoratedBox),
                  ),
                )
                .decoration
            as BoxDecoration;
    expect(
      dynamicHeaderDecoration.color,
      dynamicSurface.withValues(
        alpha: NotificationPageHeader.controlBackgroundOpacity,
      ),
    );
  });

  testWidgets('preserves static surfaces for access status and add button', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final ThemeData theme = ThemeData();

    await tester.pumpWidget(
      notificationPage(PageDefinitionStore(), theme: theme),
    );
    await tester.pumpAndSettle();

    final Finder addButton = find.byKey(
      const Key('add-notification-application'),
    );
    final ThemeData scopedTheme = Theme.of(tester.element(addButton));
    expect(
      scopedTheme.elevatedButtonTheme.style?.backgroundColor,
      theme.elevatedButtonTheme.style?.backgroundColor,
    );
    expect(
      tester.widget<Card>(find.byType(Card).first).color,
      scopedTheme.colorScheme.surfaceContainerLow,
    );
    final BoxDecoration staticHeaderDecoration =
        tester
                .widget<DecoratedBox>(
                  find.descendant(
                    of: find.byType(NotificationPageHeaderControl).first,
                    matching: find.byType(DecoratedBox),
                  ),
                )
                .decoration
            as BoxDecoration;
    expect(
      staticHeaderDecoration.color,
      scopedTheme.colorScheme.surfaceContainerHighest.withValues(
        alpha: NotificationPageHeader.controlBackgroundOpacity,
      ),
    );
  });

  testWidgets('retries and acknowledges a listener health incident', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final PageDefinitionStore definitions = PageDefinitionStore();
    final InMemoryNotificationListenerHealthStore health =
        InMemoryNotificationListenerHealthStore(
          NotificationListenerHealthIssue(
            firstOccurredAt: DateTime.utc(2026, 10, 1, 8),
            lastOccurredAt: DateTime.utc(2026, 10, 1, 8),
            occurrenceCount: 1,
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
      notificationPage(definitions, healthViewModel: healthViewModel),
    );
    await tester.pumpAndSettle();

    expect(find.text('Notification processing is paused'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);

    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    expect(find.text('Notification processing recovered'), findsOneWidget);

    await tester.tap(find.text('Dismiss'));
    await tester.pumpAndSettle();
    expect(find.text('Notification processing recovered'), findsNothing);
  });

  // Shows the intentional empty state once encrypted definitions have loaded.
  testWidgets('renders the empty notification registration state', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(notificationPage(PageDefinitionStore()));
    await tester.pumpAndSettle();

    expect(find.text('No registered applications'), findsOneWidget);
    expect(
      find.text(
        "Manage which apps' notifications Waterfly processes. Open an app to configure its extractors, rules, and actions.",
      ),
      findsNothing,
    );
    expect(
      find.text(
        'Add and configure an application now. Waterfly will begin processing its notifications after notification access is enabled.',
      ),
      findsOneWidget,
    );
    expect(find.byIcon(Icons.notifications_none_outlined), findsOneWidget);
    expect(
      find.byKey(const Key('add-notification-application')),
      findsOneWidget,
    );
    expect(
      find.widgetWithText(FilledButton, 'Add application'),
      findsOneWidget,
    );
    expect(
      find.ancestor(
        of: find.byKey(const Key('add-notification-application')),
        matching: find.byType(NotificationPageHeaderControl),
      ),
      findsNothing,
    );
    final Finder emptyState = find.byType(NotificationEmptyState);
    final Finder emptyStateContent = find
        .descendant(of: emptyState, matching: find.byType(Column))
        .first;
    final Rect emptyStateBounds = tester.getRect(emptyState);
    final double contentCenter = tester.getCenter(emptyStateContent).dy;
    expect(contentCenter, greaterThan(emptyStateBounds.top));
    expect(contentCenter, lessThan(emptyStateBounds.center.dy));
    final ScrollPosition position = tester
        .state<ScrollableState>(
          find.descendant(
            of: find.byType(CustomScrollView),
            matching: find.byType(Scrollable),
          ),
        )
        .position;
    expect(position.maxScrollExtent, 0);
  });

  testWidgets('recovers an unknown application through the app picker', (
    WidgetTester tester,
  ) async {
    final PageDefinitionStore store = PageDefinitionStore(
      definitions: const <NotificationDefinition>[
        NotificationDefinition(
          id: 'legacy-bank',
          applicationId: 'com.legacy.unknown',
          name: 'com.legacy.unknown',
          sampleTitle: 'Payment',
          sampleBody: 'Paid 12.50',
          extractors: <RegExpDefinition>[],
          rules: <NotificationRule>[],
        ),
      ],
    );
    NotificationApplicationSelectionMode? selectionMode;
    Set<String>? excludedPackageIds;
    await tester.pumpWidget(
      notificationPage(
        store,
        applicationSelector:
            (
              BuildContext context,
              Set<String> excluded,
              NotificationApplicationSelectionMode mode,
            ) async {
              selectionMode = mode;
              excludedPackageIds = excluded;
              return AppInfo(
                packageName: 'com.example.bank',
                appName: 'Example Bank',
              );
            },
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(NotificationDefinitionCard));
    await tester.pumpAndSettle();

    expect(selectionMode, NotificationApplicationSelectionMode.recover);
    expect(excludedPackageIds, isNot(contains('com.legacy.unknown')));
    expect(store.definitions.single.applicationId, 'com.example.bank');
    expect(store.definitions.single.name, 'Example Bank');
    expect(find.text('Example Bank'), findsOneWidget);
  });

  testWidgets('explains why application recovery is required', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: Scaffold(
          body: NotificationApplicationSelectorDialog(
            mode: NotificationApplicationSelectionMode.recover,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Choose application'), findsOneWidget);
    expect(
      find.text(
        'Waterfly could not identify the application associated with these imported settings. Choose the installed application that should use this configuration.',
      ),
      findsOneWidget,
    );
  });

  // Makes an unreadable definition store actionable instead of showing stale
  // content or a permanent progress indicator.
  testWidgets('renders the notification definition loading error', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      notificationPage(PageDefinitionStore(error: StateError('Unavailable'))),
    );
    await tester.pump();

    expect(
      find.text('Notification definitions could not be loaded.'),
      findsOneWidget,
    );
  });

  testWidgets('loads listener status through the injected status loader', (
    WidgetTester tester,
  ) async {
    final FakeNotificationListenerStatusLoader statusLoader =
        FakeNotificationListenerStatusLoader();

    await tester.pumpWidget(
      notificationPage(PageDefinitionStore(), statusLoader: statusLoader),
    );
    await tester.pump();

    expect(statusLoader.wasLoaded, isTrue);
  });

  testWidgets('renders compact enabled listener status', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      notificationPage(
        PageDefinitionStore(),
        statusLoader: FakeNotificationListenerStatusLoader(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Notification access enabled'), findsOneWidget);
    expect(
      find.text('Waterfly can listen for supported notifications.'),
      findsOneWidget,
    );
    expect(find.text('Service Status'), findsNothing);
    expect(find.text('Service is running.'), findsNothing);
    expect(
      find.text(
        'Add an application to choose which notifications Waterfly should turn into transactions.',
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('notification-access-settings-card-action')),
      findsNothing,
    );
  });

  testWidgets('refreshes notification access after the app resumes', (
    WidgetTester tester,
  ) async {
    final FakeNotificationListenerStatusLoader statusLoader =
        FakeNotificationListenerStatusLoader();
    await tester.pumpWidget(
      notificationPage(PageDefinitionStore(), statusLoader: statusLoader),
    );
    await tester.pumpAndSettle();
    expect(find.text('Notification access enabled'), findsOneWidget);

    statusLoader.status = const NotificationListenerStatus(false, false, false);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pumpAndSettle();

    expect(statusLoader.loadCount, 2);
    expect(find.text('Notification access needed'), findsOneWidget);
    expect(find.text('Notification access enabled'), findsNothing);
  });

  testWidgets(
    'offers notification access settings when permission is missing',
    (WidgetTester tester) async {
      final FakeNotificationAccessSettingsLauncher launcher =
          FakeNotificationAccessSettingsLauncher();

      await tester.pumpWidget(
        notificationPage(
          PageDefinitionStore(),
          statusLoader: FakeNotificationListenerStatusLoader(
            const NotificationListenerStatus(false, false, false),
          ),
          accessSettingsLauncher: launcher,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Notification access needed'), findsOneWidget);
      expect(find.text('Open notification access settings'), findsNothing);
      expect(find.byIcon(Icons.open_in_new), findsOneWidget);
      final Finder accessCardAction = find.byKey(
        const Key('notification-access-settings-card-action'),
      );
      expect(accessCardAction, findsOneWidget);

      await tester.tap(accessCardAction);
      await tester.pumpAndSettle();

      expect(launcher.openCount, 1);
      expect(find.text('Notification access settings opened.'), findsOneWidget);
    },
  );

  testWidgets('displays registered applications in alphabetical order', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      notificationPage(
        PageDefinitionStore(
          definitions: const <NotificationDefinition>[
            NotificationDefinition(
              id: 'zebra',
              applicationId: 'com.example.zebra',
              name: 'Zebra Pay',
              extractors: <RegExpDefinition>[],
              rules: <NotificationRule>[],
            ),
            NotificationDefinition(
              id: 'apple',
              applicationId: 'com.example.apple',
              name: 'apple Wallet',
              extractors: <RegExpDefinition>[],
              rules: <NotificationRule>[],
            ),
            NotificationDefinition(
              id: 'bank',
              applicationId: 'com.example.bank',
              name: 'Bank Account',
              extractors: <RegExpDefinition>[],
              rules: <NotificationRule>[],
            ),
          ],
        ),
      ),
    );
    await tester.pump();

    final List<NotificationDefinitionCard> cards = tester
        .widgetList<SliverList>(find.byType(SliverList))
        .map((SliverList list) => list.delegate as SliverChildListDelegate)
        .expand((SliverChildListDelegate delegate) => delegate.children)
        .whereType<NotificationDefinitionCard>()
        .toList();

    expect(
      cards.map((NotificationDefinitionCard card) => card.definition.name),
      <String>['apple Wallet', 'Bank Account', 'Zebra Pay'],
    );
    expect(
      find.text(
        "Manage which apps' notifications Waterfly processes. Open an app to configure its extractors, rules, and actions.",
      ),
      findsOneWidget,
    );
  });

  testWidgets('shows migration guidance loaded with registered applications', (
    WidgetTester tester,
  ) async {
    const NotificationDefinition definition = NotificationDefinition(
      id: 'bank',
      applicationId: 'com.example.bank',
      name: 'Example Bank',
      extractors: <RegExpDefinition>[],
      rules: <NotificationRule>[],
    );
    final InMemoryNotificationAlertStore alerts =
        InMemoryNotificationAlertStore(<NotificationAlert>[
          NotificationAlert.failure(
            kind: NotificationAlertKind.migrationNeedsReview,
            operation: 'Reviewing imported notification settings',
            message: 'The account mapping is missing.',
            applicationId: definition.applicationId,
            definitionId: definition.id,
            migrationIssue: NotificationMigrationIssue.missingAutomaticAccount,
          ),
        ]);

    await tester.pumpWidget(
      notificationPage(
        PageDefinitionStore(
          definitions: const <NotificationDefinition>[definition],
        ),
        alertStore: alerts,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Imported setup needs attention'), findsOneWidget);
    expect(
      find.textContaining(
        'Choose an account before enabling automatic transaction creation.',
      ),
      findsOneWidget,
    );

    await tester.tap(find.text('Example Bank'));
    await tester.pumpAndSettle();

    expect(find.text('Imported setup needs attention'), findsOneWidget);
    expect(
      find.text(
        'Choose an account before enabling automatic transaction creation.',
      ),
      findsOneWidget,
    );
  });
}
