import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/presentation/extractors/pages/notification_extractor_details_page.dart';
import 'package:waterflyiii/notifications/presentation/shared/message_status_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_date_time_formatter.dart';
import 'package:waterflyiii/notifications/presentation/shared/sample_notification_card.dart';

Finder richText(String text) => find.byWidgetPredicate(
  (Widget widget) => widget is RichText && widget.text.toPlainText() == text,
);

Finder textRich(String text) => find.byWidgetPredicate(
  (Widget widget) => widget is Text && widget.textSpan?.toPlainText() == text,
);

Widget extractorPage(
  RegExpDefinition extractor, {
  required bool isAdvancedMode,
  DateTime? sampleReceivedAt,
  String sampleBody = 'Paid 12.50 CAD',
  bool alwaysUse24HourFormat = false,
  Future<bool> Function(RegExpDefinition extractor)? onSave,
}) => MaterialApp(
  localizationsDelegates: S.localizationsDelegates,
  supportedLocales: S.supportedLocales,
  home: MediaQuery(
    data: MediaQueryData(alwaysUse24HourFormat: alwaysUse24HourFormat),
    child: NotificationExtractorDetailsPage(
      extractor: extractor,
      applicationName: 'Example Bank',
      applicationId: 'com.example.bank',
      sampleTitle: 'Card payment',
      sampleBody: sampleBody,
      sampleReceivedAt: sampleReceivedAt ?? DateTime(2026, 9, 6, 14, 58),
      isAdvancedMode: isAdvancedMode,
      canEdit: isAdvancedMode,
      canDelete: isAdvancedMode,
      onSave: onSave,
    ),
  ),
);

void main() {
  testWidgets('saves extractor changes without navigating back', (
    WidgetTester tester,
  ) async {
    RegExpDefinition? savedExtractor;
    await tester.pumpWidget(
      extractorPage(
        RegExpDefinition.createCustomRegExpDefinition('Amount', r'\d+'),
        isAdvancedMode: true,
        onSave: (RegExpDefinition extractor) async {
          savedExtractor = extractor;
          return true;
        },
      ),
    );

    await tester.tap(find.byTooltip('Extractor actions'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Edit details'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find
          .descendant(
            of: find.byType(AlertDialog),
            matching: find.byType(TextField),
          )
          .first,
      'Payment amount',
    );
    await tester.enterText(
      find
          .descendant(
            of: find.byType(AlertDialog),
            matching: find.byType(TextField),
          )
          .last,
      'Finds the amount paid.',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Save'));
    await tester.pumpAndSettle();

    expect(savedExtractor?.definitionName, 'Payment amount');
    expect(savedExtractor?.description, 'Finds the amount paid.');
    expect(find.text('Payment amount'), findsOneWidget);
    expect(
      find.text(
        'Fine-tune the sample for this extractor while keeping the definition sample available to other extractors and rules.',
      ),
      findsOneWidget,
    );
    expect(find.byTooltip('Save'), findsNothing);
    expect(find.byTooltip('Back'), findsOneWidget);
  });

  testWidgets('warns when a custom pattern may be slow', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      extractorPage(
        RegExpDefinition.createCustomRegExpDefinition(
          'Risky pattern',
          r'(a+)+$',
        ),
        isAdvancedMode: true,
        sampleBody: 'aaaa',
      ),
    );

    expect(find.text('Pattern may be slow'), findsOneWidget);
    expect(
      find.text(
        'Nested or repeated broad matching can delay notification processing. '
        'Test this pattern with representative notifications before enabling '
        'automation.',
      ),
      findsOneWidget,
    );
    expect(
      tester
          .widget<MessageStatusCard>(
            find.widgetWithText(MessageStatusCard, 'Pattern may be slow'),
          )
          .status,
      MessageStatus.warning,
    );
    expect(
      tester
          .getTopLeft(
            find.widgetWithText(MessageStatusCard, 'Pattern may be slow'),
          )
          .dy,
      greaterThan(
        tester.getBottomLeft(find.byKey(const Key('extractor-source'))).dy,
      ),
    );
  });

  testWidgets('shows an error when a custom extractor sample is too long', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      extractorPage(
        RegExpDefinition.createCustomRegExpDefinition('Amount', r'\d+'),
        isAdvancedMode: true,
        sampleBody: List<String>.filled(
          RegExpDefinition.maximumCustomInputLength + 1,
          'x',
        ).join(),
      ),
    );

    expect(find.text('Sample is too long'), findsOneWidget);
    expect(
      tester
          .widget<MessageStatusCard>(
            find.widgetWithText(MessageStatusCard, 'Sample is too long').first,
          )
          .status,
      MessageStatus.error,
    );
    expect(
      tester
          .getTopLeft(
            find.widgetWithText(MessageStatusCard, 'Sample is too long').first,
          )
          .dy,
      greaterThan(tester.getBottomLeft(find.byType(SampleNotificationCard)).dy),
    );
  });

  testWidgets('shows a direct typed value for a notification title property', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      extractorPage(
        RegExpDefinition.createPredefinedRegExpDefinition(
          PredefinedRegExpDefinition.notificationTitle,
        ),
        isAdvancedMode: false,
      ),
    );

    expect(
      find.text('Uses the notification title supplied by the source app.'),
      findsOneWidget,
    );
    expect(find.text('Description'), findsOneWidget);
    expect(find.text('Matches'), findsOneWidget);
    expect(find.text('Matches sample'), findsNothing);
    expect(find.byType(MessageStatusCard), findsNothing);
    expect(find.text('1 match'), findsNothing);
    expect(find.text('1 group'), findsNothing);
    expect(
      find.text(
        'Captured values are highlighted in the matching sample field.',
      ),
      findsOneWidget,
    );
    expect(find.text('Notification title'), findsNWidgets(2));
    expect(richText('Group: "Notification title"'), findsNothing);
    expect(find.text('Card payment'), findsNWidgets(2));
    expect(richText('Value: "Card payment"'), findsNothing);
    expect(find.text('Text'), findsOneWidget);
    expect(find.byIcon(Icons.title_outlined), findsOneWidget);
    expect(find.text('Pattern'), findsNothing);
  });

  testWidgets('uses the supplied sample time for date property matches', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      extractorPage(
        RegExpDefinition.createPredefinedRegExpDefinition(
          PredefinedRegExpDefinition.notificationDate,
        ),
        isAdvancedMode: false,
        sampleReceivedAt: DateTime(2026, 1, 2, 15, 4),
      ),
    );

    final DateTime sampleReceivedAt = DateTime(2026, 1, 2, 15, 4);
    final BuildContext context = tester.element(
      find.byType(NotificationExtractorDetailsPage),
    );
    final String formattedDate = formatNotificationDate(
      context,
      sampleReceivedAt,
    );
    final String formattedTime = formatNotificationTime(
      context,
      TimeOfDay.fromDateTime(sampleReceivedAt),
    );
    expect(find.text(formattedDate), findsNWidgets(2));
    expect(find.text(formattedTime), findsOneWidget);
    expect(find.text('1 match'), findsNothing);
    expect(find.text('2 groups'), findsNothing);
    final Text highlightedTimestamp = tester.widget<Text>(
      find.byWidgetPredicate(
        (Widget widget) =>
            widget is Text &&
            widget.data == formattedDate &&
            widget.style?.color ==
                Theme.of(
                  tester.element(find.byType(SampleNotificationCard)),
                ).colorScheme.primary,
      ),
    );
    expect(highlightedTimestamp.style?.fontWeight, FontWeight.w600);
  });

  testWidgets('uses the system 24-hour format for date property matches', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      extractorPage(
        RegExpDefinition.createPredefinedRegExpDefinition(
          PredefinedRegExpDefinition.notificationDate,
        ),
        isAdvancedMode: false,
        sampleReceivedAt: DateTime(2026, 1, 2, 15, 4),
        alwaysUse24HourFormat: true,
      ),
    );

    expect(find.text('15:04'), findsOneWidget);
    expect(find.text('3:04 PM'), findsNothing);
  });

  testWidgets('shows a time for a sample notification received today', (
    WidgetTester tester,
  ) async {
    final DateTime sampleReceivedAt = DateTime.now();
    await tester.pumpWidget(
      extractorPage(
        RegExpDefinition.createPredefinedRegExpDefinition(
          PredefinedRegExpDefinition.notificationTitle,
        ),
        isAdvancedMode: false,
        sampleReceivedAt: sampleReceivedAt,
      ),
    );

    final BuildContext context = tester.element(
      find.byType(NotificationExtractorDetailsPage),
    );
    expect(
      find.text(
        formatNotificationTime(
          context,
          TimeOfDay.fromDateTime(sampleReceivedAt),
        ),
      ),
      findsOneWidget,
    );
    expect(
      find.text(formatNotificationDate(context, sampleReceivedAt)),
      findsNothing,
    );
  });

  testWidgets('keeps a built-in regexp pattern read-only outside advanced mode', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      extractorPage(
        RegExpDefinition.createPredefinedRegExpDefinition(
          PredefinedRegExpDefinition.amount,
        ),
        isAdvancedMode: false,
      ),
    );

    final TextField pattern = tester.widget<TextField>(
      find.byKey(const Key('extractor-source')),
    );
    expect(pattern.readOnly, isTrue);
    expect(
      find.text(
        'This built-in pattern is managed by Basic mode and cannot be edited here.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('allows a custom regexp pattern to be edited in advanced mode', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      extractorPage(
        RegExpDefinition.createCustomRegExpDefinition(
          'Amount',
          r'(?<amount>\d+)',
        ),
        isAdvancedMode: true,
      ),
    );

    final TextField pattern = tester.widget<TextField>(
      find.byKey(const Key('extractor-source')),
    );
    expect(pattern.readOnly, isFalse);
    final IconButton pasteButton = tester.widget<IconButton>(
      find.ancestor(
        of: find.byTooltip('Paste regular expression'),
        matching: find.byType(IconButton),
      ),
    );
    expect(pasteButton.iconSize, 18);
    expect(pattern.decoration!.suffixIcon, isA<IconButton>());
    expect(find.text('Matches'), findsOneWidget);
    expect(
      find.text(
        'Regular expression matches are highlighted in the sample notification.',
      ),
      findsOneWidget,
    );
    final Text sampleBody = tester.widget<Text>(
      find.byWidgetPredicate(
        (Widget widget) =>
            widget is Text &&
            widget.textSpan?.toPlainText() == 'Paid 12.50 CAD',
      ),
    );
    final TextSpan sampleBodySpan = sampleBody.textSpan! as TextSpan;
    expect(
      sampleBodySpan.children!.whereType<TextSpan>().any(
        (TextSpan span) =>
            span.text == '12' &&
            span.style?.color ==
                Theme.of(
                  tester.element(find.byType(SampleNotificationCard)),
                ).colorScheme.primary,
      ),
      isTrue,
    );
    expect(find.byType(ExpansionTile), findsNothing);
    expect(find.byKey(const Key('extractor-match-0')), findsOneWidget);
    await tester.tap(find.byKey(const Key('extractor-match-0')));
    await tester.pumpAndSettle();
    expect(find.text('amount'), findsAtLeastNWidgets(1));
    expect(find.text('12'), findsNWidgets(2));
    expect(find.text('Number'), findsAtLeastNWidgets(1));
  });

  testWidgets(
    'confirms before discarding an invalid custom regular expression',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        extractorPage(
          RegExpDefinition.createCustomRegExpDefinition(
            'Amount',
            r'(?<amount>\d+)',
          ),
          isAdvancedMode: true,
        ),
      );

      await tester.enterText(find.byKey(const Key('extractor-source')), '(');
      await tester.pumpAndSettle();

      expect(find.text('Invalid pattern'), findsOneWidget);
      expect(
        tester
            .widget<MessageStatusCard>(find.byType(MessageStatusCard).first)
            .status,
        MessageStatus.error,
      );
      expect(find.byTooltip('Save'), findsOneWidget);
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();

      expect(find.text('Discard changes?'), findsOneWidget);
      expect(find.text('Your unsaved changes will be lost.'), findsOneWidget);
      expect(find.byType(NotificationExtractorDetailsPage), findsOneWidget);
      expect(find.widgetWithText(TextButton, 'Discard'), findsOneWidget);
      expect(find.widgetWithText(FilledButton, 'Cancel'), findsOneWidget);

      await tester.tap(find.widgetWithText(TextButton, 'Discard'));
      await tester.pumpAndSettle();

      expect(find.byType(NotificationExtractorDetailsPage), findsNothing);
    },
  );

  testWidgets('distinguishes a valid pattern with no sample match', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      extractorPage(
        RegExpDefinition.createCustomRegExpDefinition(
          'Refund amount',
          r'Refund (?<amount>\d+)',
        ),
        isAdvancedMode: true,
      ),
    );

    expect(find.text('No sample match'), findsOneWidget);
    expect(
      tester
          .widget<MessageStatusCard>(find.byType(MessageStatusCard).first)
          .status,
      MessageStatus.warning,
    );
    expect(find.text('Invalid pattern'), findsNothing);
  });

  testWidgets('dismisses the details dialog from its barrier', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      extractorPage(
        RegExpDefinition.createCustomRegExpDefinition('Amount', r'\d+'),
        isAdvancedMode: true,
      ),
    );

    await tester.tap(find.byTooltip('Extractor actions'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Edit details'));
    await tester.pumpAndSettle();

    expect(find.text('Edit extractor details'), findsOneWidget);
    await tester.tapAt(const Offset(8, 300));
    await tester.pumpAndSettle();

    expect(find.text('Edit extractor details'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('clears the extractor name from the details field', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      extractorPage(
        RegExpDefinition.createCustomRegExpDefinition('Amount', r'\d+'),
        isAdvancedMode: true,
      ),
    );

    await tester.tap(find.byTooltip('Extractor actions'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Edit details'));
    await tester.pumpAndSettle();

    final Finder renameField = find
        .descendant(
          of: find.byType(AlertDialog),
          matching: find.byType(TextField),
        )
        .first;
    expect(tester.widget<TextField>(renameField).controller!.text, 'Amount');
    expect(find.byTooltip('Clear text'), findsOneWidget);

    await tester.tap(find.byTooltip('Clear text'));
    await tester.pump();

    expect(tester.widget<TextField>(renameField).controller!.text, isEmpty);
    expect(find.byTooltip('Clear text'), findsNothing);
  });

  testWidgets('expands a whole match without a group name', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      extractorPage(
        RegExpDefinition.createCustomRegExpDefinition('Word', r'CAD'),
        isAdvancedMode: true,
      ),
    );

    await tester.tap(find.byKey(const Key('extractor-match-0')));
    await tester.pumpAndSettle();

    expect(find.text('Match'), findsOneWidget);
    expect(find.text('CAD'), findsAtLeastNWidgets(2));
  });

  testWidgets(
    'separates and elevates expanded content for a multi-group match in light mode',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        extractorPage(
          RegExpDefinition.createCustomRegExpDefinition(
            'Payment',
            r'(?<amount>\d+) (?<currency>[A-Z]{3})',
          ),
          isAdvancedMode: true,
        ),
      );

      await tester.tap(find.byKey(const Key('extractor-match-0')));
      await tester.pumpAndSettle();

      final DecoratedBox belly = tester.widget<DecoratedBox>(
        find.byKey(const Key('extractor-match-belly-0')),
      );
      final BoxDecoration decoration = belly.decoration as BoxDecoration;
      final BuildContext bellyContext = tester.element(
        find.byKey(const Key('extractor-match-belly-0')),
      );
      final Color cardColor =
          Theme.of(bellyContext).cardTheme.color ??
          Theme.of(bellyContext).colorScheme.surfaceContainerLow;
      expect(decoration.color, Theme.of(bellyContext).scaffoldBackgroundColor);
      expect((decoration.border! as Border).top.width, 1);
      expect(
        (decoration.border! as Border).top.color,
        Theme.of(bellyContext).colorScheme.outlineVariant,
      );
      final Card bellyCard = tester.widget<Card>(
        find.ancestor(
          of: find.byKey(const Key('extractor-match-belly-0')),
          matching: find.byType(Card),
        ),
      );
      expect(bellyCard.color, Theme.of(bellyContext).scaffoldBackgroundColor);
      expect(bellyCard.elevation, 1);
      expect(bellyCard.surfaceTintColor, Colors.transparent);
      final List<Card> matchValueCards = tester
          .widgetList<Card>(
            find.descendant(
              of: find.byKey(const Key('extractor-match-belly-0')),
              matching: find.byType(Card),
            ),
          )
          .toList();
      expect(
        matchValueCards.map((Card card) => card.color),
        everyElement(cardColor),
      );
      expect(
        find.descendant(
          of: find.byKey(const Key('extractor-match-belly-0')),
          matching: find.byType(Card),
        ),
        findsNWidgets(2),
      );
      final Icon groupIcon = tester.widget<Icon>(
        find
            .descendant(
              of: find.byKey(const Key('extractor-match-belly-0')),
              matching: find.byIcon(Icons.text_fields_outlined),
            )
            .first,
      );
      expect(groupIcon.size, isNull);
    },
  );
}
