import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/applications/notification_application_selector_dialog.dart';

void main() {
  testWidgets('animates from loading to application results', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: Scaffold(body: NotificationApplicationSelectorDialog()),
      ),
    );

    expect(
      find.byKey(const ValueKey<String>('applications-loading')),
      findsOneWidget,
    );
    expect(find.byType(AnimatedSize), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1));

    expect(
      find.byKey(const ValueKey<String>('applications-loading')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey<String>('applications-loaded-suggested')),
      findsOneWidget,
    );

    await tester.pumpAndSettle();

    expect(
      find.byKey(const ValueKey<String>('applications-loading')),
      findsNothing,
    );
    expect(
      find.byKey(const ValueKey<String>('applications-loaded-suggested')),
      findsOneWidget,
    );
  });

  testWidgets('animates between suggested and all installed applications', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: Scaffold(body: NotificationApplicationSelectorDialog()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('All installed apps'));
    await tester.pump(const Duration(milliseconds: 1));

    expect(
      find.byKey(const ValueKey<String>('applications-loaded-suggested')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey<String>('applications-loaded-all')),
      findsOneWidget,
    );

    await tester.pumpAndSettle();

    expect(
      find.byKey(const ValueKey<String>('applications-loaded-suggested')),
      findsNothing,
    );
    expect(
      find.byKey(const ValueKey<String>('applications-loaded-all')),
      findsOneWidget,
    );
  });

  testWidgets('shows contextual application empty states', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: Scaffold(body: NotificationApplicationSelectorDialog()),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text(
        'No suggested applications are available. '
        'Try viewing all installed apps.',
      ),
      findsOneWidget,
    );

    await tester.tap(find.text('All installed apps'));
    await tester.pumpAndSettle();
    expect(
      find.text('No installed applications are available.'),
      findsOneWidget,
    );

    await tester.enterText(find.byType(TextField), 'bank');
    await tester.pumpAndSettle();
    expect(find.text('No applications match your search.'), findsOneWidget);
  });

  testWidgets('fits when the keyboard is visible', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(768, 1600));
    tester.view.viewInsets = const FakeViewPadding(bottom: 520);
    addTearDown(() {
      tester.view.resetViewInsets();
      tester.binding.setSurfaceSize(null);
    });

    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: Scaffold(body: NotificationApplicationSelectorDialog()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Add application'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
