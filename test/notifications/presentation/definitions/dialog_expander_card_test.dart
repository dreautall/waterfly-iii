import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/notifications/presentation/shared/dialog_expander_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/dialog_selector_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_card_theme.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_input_decoration.dart';

void main() {
  testWidgets('reveals and hides its belly when its header is tapped', (
    WidgetTester tester,
  ) async {
    bool expanded = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) =>
                DialogExpanderCard(
                  leading: const Icon(Icons.edit_outlined),
                  title: const Text('Literal value'),
                  subtitle: const Text('Enter a fixed value.'),
                  expanded: expanded,
                  belly: const Text('Value editor'),
                  onTap: () => setState(() => expanded = !expanded),
                ),
          ),
        ),
      ),
    );

    expect(find.text('Value editor'), findsNothing);
    expect(find.byIcon(Icons.expand_more), findsOneWidget);
    final double collapsedHeaderTop = tester
        .getTopLeft(find.text('Literal value'))
        .dy;

    await tester.tap(find.text('Literal value'));
    await tester.pump();

    expect(
      tester.getTopLeft(find.text('Literal value')).dy,
      closeTo(collapsedHeaderTop, 0.1),
    );
    AnimatedAlign reveal = tester.widget<AnimatedAlign>(
      find.descendant(
        of: find.byType(DialogExpanderCard),
        matching: find.byType(AnimatedAlign),
      ),
    );
    AnimatedOpacity fade = tester.widget<AnimatedOpacity>(
      find.descendant(
        of: find.byType(DialogExpanderCard),
        matching: find.byType(AnimatedOpacity),
      ),
    );
    expect(reveal.heightFactor, 0);
    expect(fade.opacity, 0);

    await tester.pump(const Duration(milliseconds: 70));

    reveal = tester.widget<AnimatedAlign>(
      find.descendant(
        of: find.byType(DialogExpanderCard),
        matching: find.byType(AnimatedAlign),
      ),
    );
    fade = tester.widget<AnimatedOpacity>(
      find.descendant(
        of: find.byType(DialogExpanderCard),
        matching: find.byType(AnimatedOpacity),
      ),
    );
    expect(reveal.heightFactor, 1);
    expect(fade.opacity, 1);
    final RenderBox belly = tester.renderObject(find.text('Value editor'));
    expect(belly.paintBounds.height, greaterThan(0));
    expect(
      tester
          .getSize(
            find.descendant(
              of: find.byType(DialogExpanderCard),
              matching: find.byType(ClipRect),
            ),
          )
          .height,
      lessThan(belly.size.height + 24),
    );

    await tester.pumpAndSettle();

    expect(find.text('Value editor'), findsOneWidget);

    await tester.tap(find.text('Literal value'));
    await tester.pump();

    expect(
      tester.getTopLeft(find.text('Literal value')).dy,
      closeTo(collapsedHeaderTop, 0.1),
    );

    await tester.pumpAndSettle();

    expect(find.text('Value editor'), findsNothing);
  });

  testWidgets('uses a custom trailing control instead of its expand chevron', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: DialogExpanderCard(
            leading: Icon(Icons.data_object_outlined),
            title: Text('Extractor capture'),
            subtitle: Text('Use a named captured value.'),
            expanded: false,
            belly: SizedBox.shrink(),
            trailing: Icon(Icons.more_vert),
            onTap: _noop,
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.more_vert), findsOneWidget);
    expect(find.byIcon(Icons.expand_more), findsNothing);
  });

  testWidgets('keeps its dynamic surface and deepens nested cards', (
    WidgetTester tester,
  ) async {
    const Color parentSurface = Color(0xff223344);
    const Color deepSurface = Color(0xff334455);
    bool expanded = false;
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: const <ThemeExtension<dynamic>>[
            NotificationCardTheme(
              surfaceColor: Color(0xff112233),
              nestedSurfaceColor: parentSurface,
              deepNestedSurfaceColor: deepSurface,
            ),
          ],
        ),
        home: Scaffold(
          body: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) =>
                DialogExpanderCard(
                  leading: const Icon(Icons.edit_outlined),
                  title: const Text('Extractor capture'),
                  subtitle: const Text('Choose a captured value'),
                  expanded: expanded,
                  onTap: () => setState(() => expanded = !expanded),
                  belly: const DialogSelectorCard(
                    leading: Icon(Icons.text_fields_outlined),
                    title: Text('Amount'),
                    subtitle: Text('Resolved value: 42.17'),
                    onTap: _noop,
                  ),
                ),
          ),
        ),
      ),
    );

    expect(tester.widget<Card>(find.byType(Card)).color, parentSurface);

    await tester.tap(find.text('Extractor capture'));
    await tester.pumpAndSettle();

    final List<Card> cards = tester
        .widgetList<Card>(find.byType(Card))
        .toList();
    expect(cards.first.color, parentSurface);
    expect(cards.last.color, deepSurface);
  });

  for (final Brightness brightness in Brightness.values) {
    testWidgets('distinguishes expanded controls in ${brightness.name} theme', (
      WidgetTester tester,
    ) async {
      bool expanded = false;
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(brightness: brightness, useMaterial3: true),
          home: Scaffold(
            body: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) =>
                  DialogExpanderCard(
                    leading: const Icon(Icons.edit_outlined),
                    title: const Text('Literal'),
                    subtitle: const Text('Fixed value'),
                    expanded: expanded,
                    belly: const Text('Value editor'),
                    onTap: () => setState(() => expanded = !expanded),
                  ),
            ),
          ),
        ),
      );

      Card card = tester.widget<Card>(find.byType(Card));
      final BuildContext context = tester.element(find.byType(Card));
      expect(card.elevation, 0);
      expect(card.clipBehavior, Clip.antiAlias);
      expect(card.color, Theme.of(context).colorScheme.surfaceContainerLow);
      expect(card.shape, notificationControlShape(context));

      await tester.tap(find.text('Literal'));
      await tester.pumpAndSettle();

      card = tester.widget<Card>(find.byType(Card));
      expect(card.color, Theme.of(context).colorScheme.surfaceContainerHigh);
      expect(card.shape, notificationControlShape(context));
      expect(find.text('Value editor'), findsOneWidget);
    });
  }
}

void _noop() {}
