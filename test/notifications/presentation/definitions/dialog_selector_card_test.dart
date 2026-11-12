import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/notifications/presentation/shared/dialog_selector_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_card_theme.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_input_decoration.dart';

void main() {
  testWidgets('invokes a selectable card and applies its visual slots', (
    WidgetTester tester,
  ) async {
    bool wasSelected = false;
    const Color backgroundColor = Color(0xffeef2e8);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DialogSelectorCard(
            leading: const Icon(Icons.tune_outlined),
            title: const Text('Custom'),
            subtitle: const Text('Write your own regular expression.'),
            trailing: const Icon(Icons.chevron_right),
            margin: const EdgeInsets.only(bottom: 8),
            backgroundColor: backgroundColor,
            onTap: () => wasSelected = true,
          ),
        ),
      ),
    );

    final Card card = tester.widget<Card>(find.byType(Card));
    expect(card.color, backgroundColor);
    expect(card.margin, const EdgeInsets.only(bottom: 8));
    expect(find.byIcon(Icons.tune_outlined), findsOneWidget);
    expect(find.byIcon(Icons.chevron_right), findsOneWidget);

    await tester.tap(find.text('Custom'));

    expect(wasSelected, isTrue);
  });

  testWidgets('renders an unavailable selector as disabled and non-tappable', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: DialogSelectorCard(
            leading: Icon(Icons.block_outlined),
            title: Text('Amount'),
            subtitle: Text('Already set by this rule.'),
            onTap: null,
          ),
        ),
      ),
    );

    final ListTile tile = tester.widget<ListTile>(find.byType(ListTile));
    expect(tile.enabled, isFalse);

    await tester.tap(find.text('Amount'));
    await tester.pump();

    expect(find.text('Already set by this rule.'), findsOneWidget);
  });

  testWidgets('uses the nested dynamic surface', (WidgetTester tester) async {
    const Color pageSurface = Color(0xff223344);
    const Color nestedSurface = Color(0xff334455);
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: const <ThemeExtension<dynamic>>[
            NotificationCardTheme(
              surfaceColor: pageSurface,
              nestedSurfaceColor: nestedSurface,
              deepNestedSurfaceColor: Color(0xff445566),
            ),
          ],
        ),
        home: const Scaffold(
          body: DialogSelectorCard(
            leading: Icon(Icons.tune_outlined),
            title: Text('Custom'),
            subtitle: Text('Choose a source'),
            onTap: _noop,
          ),
        ),
      ),
    );

    expect(tester.widget<Card>(find.byType(Card)).color, nestedSurface);
  });

  for (final Brightness brightness in Brightness.values) {
    testWidgets('matches control surfaces in ${brightness.name} theme', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(brightness: brightness, useMaterial3: true),
          home: const Scaffold(
            body: DialogSelectorCard(
              leading: Icon(Icons.tune_outlined),
              title: Text('Custom'),
              subtitle: Text('Choose a source'),
              onTap: _noop,
            ),
          ),
        ),
      );

      final Card card = tester.widget<Card>(find.byType(Card));
      final BuildContext context = tester.element(find.byType(Card));
      final RoundedRectangleBorder shape =
          card.shape! as RoundedRectangleBorder;
      expect(card.elevation, 0);
      expect(card.clipBehavior, Clip.antiAlias);
      expect(card.color, Theme.of(context).colorScheme.surfaceContainerLow);
      expect(shape, notificationControlShape(context));
    });
  }
}

void _noop() {}
