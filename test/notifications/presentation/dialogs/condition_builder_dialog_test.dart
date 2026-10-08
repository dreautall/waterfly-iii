import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart' hide MaterialApp;
import 'package:material_ui/material_ui.dart' as material_ui;
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/conditions/condition_builder_dialog.dart';
import 'package:waterflyiii/notifications/presentation/shared/dialog_expander_card.dart';

class MaterialApp extends material_ui.MaterialApp {
  const MaterialApp({super.key, required super.home})
    : super(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
      );
}

void main() {
  testWidgets('uses extractor-style transitions in both directions', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition extractor =
        RegExpDefinition.createCustomRegExpDefinition('Value', r'(?<value>12)');
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) => TextButton(
            onPressed: () => selectNotificationCondition(
              context,
              extractors: <RegExpDefinition>[extractor],
              notificationContext: NotificationContext(
                title: 'Card payment',
                body: 'Paid 12 CAD',
                receivedAt: DateTime(2026, 9, 24),
              ),
            ),
            child: const Text('Open'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    final Finder switcher = find.descendant(
      of: find.byType(AlertDialog),
      matching: find.byType(AnimatedSwitcher),
    );
    expect(switcher, findsOneWidget);
    await tester.tap(find.text('Value condition'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 80));

    double horizontalTranslationOf(Finder child) => tester
        .widget<Transform>(
          find
              .ancestor(
                of: child,
                matching: find.byWidgetPredicate(
                  (Widget widget) =>
                      widget is Transform &&
                      widget.transform.getTranslation().x != 0,
                ),
              )
              .first,
        )
        .transform
        .getTranslation()
        .x;

    expect(
      horizontalTranslationOf(
        find.text(
          'Check whether a value exists, contains text, or compares with '
          'another value.',
        ),
      ),
      isNegative,
    );
    expect(horizontalTranslationOf(find.text('Value exists')), isPositive);
    expect(
      find.descendant(of: switcher, matching: find.byType(FadeTransition)),
      findsNWidgets(2),
    );

    await tester.pumpAndSettle();
    await tester.tap(find.text('Back'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 80));

    expect(
      horizontalTranslationOf(
        find.text(
          'Check whether a value exists, contains text, or compares with '
          'another value.',
        ),
      ),
      isNegative,
    );
    expect(horizontalTranslationOf(find.text('Value exists')), isPositive);
    expect(
      find.descendant(of: switcher, matching: find.byType(FadeTransition)),
      findsNWidgets(2),
    );

    await tester.pumpAndSettle();
    await tester.tap(find.text('Value condition'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Value exists'));
    await tester.pump();

    final DialogExpanderCard captureOption = tester.widget<DialogExpanderCard>(
      find.widgetWithText(DialogExpanderCard, 'Extractor capture'),
    );
    expect(captureOption.expanded, isTrue);
  });

  testWidgets('disables groups at the maximum condition nesting depth', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) => TextButton(
            onPressed: () => selectNotificationCondition(
              context,
              extractors: const <RegExpDefinition>[],
              notificationContext: NotificationContext(
                title: 'Card payment',
                body: 'Paid 12 CAD',
                receivedAt: DateTime(2026, 9, 26),
              ),
              nestingDepth: 3,
            ),
            child: const Text('Open'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(
      find.text(
        'The maximum of 3 nested condition levels has been reached. '
        'Choose an individual condition, or split complex logic across rules '
        'or conditional-action groups.',
      ),
      findsOneWidget,
    );
    expect(
      tester
          .widget<InkWell>(
            find
                .ancestor(
                  of: find.text('Condition group'),
                  matching: find.byType(InkWell),
                )
                .first,
          )
          .onTap,
      isNull,
    );
  });

  testWidgets('counts a not wrapper toward the nesting limit', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) => TextButton(
            onPressed: () => selectNotificationCondition(
              context,
              extractors: const <RegExpDefinition>[],
              notificationContext: NotificationContext(
                title: 'Card payment',
                body: 'Paid 12 CAD',
                receivedAt: DateTime(2026, 9, 26),
              ),
              nestingDepth: 2,
            ),
            child: const Text('Open'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Condition group'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Condition does not match'));
    await tester.pumpAndSettle();

    expect(
      find.textContaining(
        'The maximum of 3 nested condition levels has been reached.',
      ),
      findsOneWidget,
    );
    expect(find.text('Value condition'), findsOneWidget);
  });
}
