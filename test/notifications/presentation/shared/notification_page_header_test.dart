import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_page_header.dart';

void main() {
  testWidgets('positions circular controls like the reference header', (
    WidgetTester tester,
  ) async {
    final ScrollController controller = ScrollController();
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: NotificationPageHeader(
            scrollController: controller,
            title: const Text('Notifications'),
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.science_outlined),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
        ),
      ),
    );

    expect(tester.getSize(find.byType(NotificationPageHeader)).height, 72);

    final Rect back = tester.getRect(find.byType(BackButton));
    final Rect firstAction = tester.getRect(
      find.widgetWithIcon(IconButton, Icons.science_outlined),
    );
    final Rect lastAction = tester.getRect(
      find.widgetWithIcon(IconButton, Icons.delete_outline),
    );

    expect(back, const Rect.fromLTWH(12, 16, 40, 40));
    final BackButton backButton = tester.widget<BackButton>(
      find.byType(BackButton),
    );
    expect(
      backButton.style?.iconSize?.resolve(<WidgetState>{}),
      NotificationPageHeader.controlIconSize,
    );
    expect(firstAction.size, const Size.square(40));
    expect(lastAction.size, const Size.square(40));
    expect(firstAction.right + 12, lastAction.left);
    expect(lastAction.right, 788);
  });

  testWidgets('uses theme-aware control surfaces', (WidgetTester tester) async {
    final ScrollController controller = ScrollController();
    addTearDown(controller.dispose);

    Future<void> pump(Brightness brightness) {
      final ThemeData theme = ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: brightness,
        ),
      );
      return tester.pumpWidget(
        MaterialApp(
          home: Theme(
            data: theme,
            child: Scaffold(
              appBar: NotificationPageHeader(
                scrollController: controller,
                title: const Text('Notifications'),
              ),
            ),
          ),
        ),
      );
    }

    await pump(Brightness.light);
    final DecoratedBox lightControl = tester.widget<DecoratedBox>(
      _circularControl(),
    );
    final Color lightColor = (lightControl.decoration as BoxDecoration).color!;
    expect(
      lightColor,
      Theme.of(tester.element(find.byType(NotificationPageHeader)))
          .colorScheme
          .surfaceContainerHighest
          .withValues(alpha: NotificationPageHeader.controlBackgroundOpacity),
    );

    await pump(Brightness.dark);
    final DecoratedBox darkControl = tester.widget<DecoratedBox>(
      _circularControl(),
    );
    final Color darkColor = (darkControl.decoration as BoxDecoration).color!;
    expect(
      darkColor,
      Theme.of(tester.element(find.byType(NotificationPageHeader)))
          .colorScheme
          .surfaceContainerLowest
          .withValues(alpha: NotificationPageHeader.controlBackgroundOpacity),
    );
  });

  testWidgets('positions toolbar controls below the system status bar', (
    WidgetTester tester,
  ) async {
    final ScrollController controller = ScrollController();
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(padding: EdgeInsets.only(top: 24)),
          child: Scaffold(
            appBar: NotificationPageHeader(
              scrollController: controller,
              title: const Text('Notifications'),
              actions: <Widget>[
                const IconButton(onPressed: _noop, icon: Icon(Icons.more_vert)),
              ],
            ),
          ),
        ),
      ),
    );

    expect(tester.getTopLeft(find.byType(BackButton)).dy, 40);
    expect(
      tester.getTopLeft(find.widgetWithIcon(IconButton, Icons.more_vert)).dy,
      40,
    );
    expect(tester.getCenter(find.text('Notifications')).dy, 60);
  });

  testWidgets('fades a surface gradient in after scrolling', (
    WidgetTester tester,
  ) async {
    final ScrollController controller = ScrollController();
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: NotificationPageHeader(
            scrollController: controller,
            title: const Text('Notifications'),
          ),
          body: ListView(
            controller: controller,
            children: const <Widget>[SizedBox(height: 2000)],
          ),
        ),
      ),
    );

    BoxDecoration gradientDecoration() =>
        tester.widget<DecoratedBox>(_gradient()).decoration as BoxDecoration;

    expect(
      (gradientDecoration().gradient! as LinearGradient).colors.first.a,
      0,
    );

    controller.jumpTo(32);
    await tester.pump();

    final LinearGradient gradient =
        gradientDecoration().gradient! as LinearGradient;
    final Color expectedSurface = Theme.of(
      tester.element(find.byType(NotificationPageHeader)),
    ).colorScheme.surfaceContainerHighest;
    expect(gradient.colors.first.a, closeTo(0.92, 0.001));
    expect(gradient.colors.first.r, closeTo(expectedSurface.r, 0.001));
    expect(gradient.colors.first.g, closeTo(expectedSurface.g, 0.001));
    expect(gradient.colors.first.b, closeTo(expectedSurface.b, 0.001));
    expect(gradient.colors.last.a, 0);

    final Align gradientAlign = tester.widget<Align>(
      find.ancestor(of: _gradient(), matching: find.byType(Align)).first,
    );
    final SizedBox gradientBox = gradientAlign.child! as SizedBox;
    expect(
      gradientBox.height,
      NotificationPageHeader.bodyTopInset(
            tester.element(find.byType(NotificationPageHeader)),
          ) -
          16,
    );
  });

  testWidgets(
    'passes taps through empty header areas to visible body controls',
    (WidgetTester tester) async {
      final ScrollController controller = ScrollController();
      addTearDown(controller.dispose);
      int bodyTapCount = 0;
      int headerTapCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: NotificationPageHeader(
              scrollController: controller,
              title: const Text('Notifications'),
              actions: <Widget>[
                IconButton(
                  onPressed: () => headerTapCount++,
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
            body: Stack(
              children: <Widget>[
                Positioned(
                  left: 300,
                  top: 16,
                  child: TextButton(
                    onPressed: () => bodyTapCount++,
                    child: const Text('Visible body control'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.text('Visible body control'));
      await tester.tap(find.byIcon(Icons.more_vert));

      expect(bodyTapCount, 1);
      expect(headerTapCount, 1);
    },
  );
}

Finder _circularControl() => find.byWidgetPredicate(
  (Widget widget) =>
      widget is DecoratedBox &&
      widget.decoration is BoxDecoration &&
      (widget.decoration as BoxDecoration).shape == BoxShape.circle,
);

Finder _gradient() => find.byWidgetPredicate(
  (Widget widget) =>
      widget is DecoratedBox &&
      widget.decoration is BoxDecoration &&
      (widget.decoration as BoxDecoration).gradient is LinearGradient,
);

void _noop() {}
