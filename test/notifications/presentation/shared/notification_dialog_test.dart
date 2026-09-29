import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_dialog.dart';

void main() {
  testWidgets('animates dialogs with a contained fade scale and rise', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) => TextButton(
            onPressed: () => showNotificationDialog<void>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Animated dialog'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),
            child: const Text('Open'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 1));

    final Finder dialog = find.byType(AlertDialog);
    expect(dialog, findsOneWidget);
    expect(
      find.ancestor(of: dialog, matching: find.byType(FadeTransition)),
      findsWidgets,
    );
    expect(
      find.ancestor(of: dialog, matching: find.byType(ScaleTransition)),
      findsOneWidget,
    );
    expect(
      find.ancestor(of: dialog, matching: find.byType(SlideTransition)),
      findsOneWidget,
    );

    final ScaleTransition scale = tester.widget<ScaleTransition>(
      find.ancestor(of: dialog, matching: find.byType(ScaleTransition)),
    );
    expect(scale.scale.value, greaterThan(0.96));
    expect(scale.scale.value, lessThan(1));

    await tester.pump(const Duration(milliseconds: 99));
    expect(scale.scale.value, greaterThan(0.96));
    expect(scale.scale.value, lessThan(1));

    await tester.pumpAndSettle();
    expect(scale.scale.value, 1);

    await tester.tap(find.text('Close'));
    await tester.pumpAndSettle();
    expect(dialog, findsNothing);
  });

  testWidgets('disables custom dialog motion for reduced motion', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(disableAnimations: true),
        child: MaterialApp(
          home: Builder(
            builder: (BuildContext context) => TextButton(
              onPressed: () => showNotificationDialog<void>(
                context: context,
                builder: (BuildContext context) =>
                    const AlertDialog(title: Text('Reduced motion')),
              ),
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pump();

    expect(find.text('Reduced motion'), findsOneWidget);
    expect(
      find.ancestor(
        of: find.byType(AlertDialog),
        matching: find.byType(ScaleTransition),
      ),
      findsNothing,
    );
  });
}
