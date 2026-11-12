import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/presentation/definitions/pages/notification_definitions_page.dart';
import 'package:waterflyiii/pages/navigation.dart';

void main() {
  testWidgets('groups pushed utility pages after subscriptions', (
    WidgetTester tester,
  ) async {
    late List<NavDestination> destinations;
    late BuildContext navigationContext;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: Builder(
          builder: (BuildContext context) {
            navigationContext = context;
            destinations = buildNavigationDestinations(context);
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(
      destinations.map((NavDestination destination) => destination.label),
      <String>[
        'Dashboard',
        'Accounts',
        'Categories',
        'Subscriptions',
        'Settings',
        'Notification Listener Service',
      ],
    );
    expect(destinations[3].startsNewGroup, isFalse);
    expect(destinations[4].startsNewGroup, isTrue);
    expect(destinations[4].pushedPageBuilder, isNotNull);
    expect(destinations[5].pushedPageBuilder, isNotNull);

    final Widget notificationPage = destinations[5].pushedPageBuilder!(
      navigationContext,
    );
    expect(notificationPage, isA<NotificationDefinitionsPage>());
    expect(
      (notificationPage as NotificationDefinitionsPage).showAppBar,
      isTrue,
    );
  });
}
