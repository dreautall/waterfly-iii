import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart' hide MaterialApp;
import 'package:material_ui/material_ui.dart' as material_ui;
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/application/resources/firefly_currency_resolver.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_tags_action.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/composed_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/literal_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/value_source.dart';
import 'package:waterflyiii/notifications/presentation/shared/dialog_expander_card.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/actions/transaction_action_value_dialog.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_card_theme.dart';

class MaterialApp extends material_ui.MaterialApp {
  const MaterialApp({super.key, required super.home, super.theme})
    : super(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
      );
}

void main() {
  NotificationContext notificationContext() => NotificationContext(
    title: 'Card payment',
    body: 'Paid 12 CAD',
    receivedAt: DateTime(2026, 9, 7),
  );

  testWidgets('uses S for transaction field labels', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) =>
                Text(transactionFieldLabel(context, TransactionField.amount)),
          ),
        ),
      ),
    );

    expect(
      find.text(
        S.of(tester.element(find.byType(Scaffold))).notificationsFieldAmount,
      ),
      findsOneWidget,
    );
  });

  test('matches ISO currency codes case-insensitively', () {
    const List<FireflyCurrency> currencies = <FireflyCurrency>[
      FireflyCurrency(
        id: '1',
        name: 'Canadian dollar',
        code: 'CAD',
        symbol: r'$',
      ),
      FireflyCurrency(id: '2', name: 'US dollar', code: 'USD', symbol: r'$'),
    ];

    expect(
      filterCurrenciesByCode(
        currencies,
        'cad',
      ).map((FireflyCurrency currency) => currency.code),
      <String>['CAD'],
    );
  });

  test('accepts currency codes and symbols, but not amounts', () {
    expect(isCurrencyCaptureValue('CAD'), isTrue);
    expect(isCurrencyCaptureValue(r'$'), isTrue);
    expect(isCurrencyCaptureValue('9.00'), isFalse);
  });

  test('accepts numeric amount captures regardless of their group name', () {
    expect(isAmountCaptureValue('9.00'), isTrue);
    expect(isAmountCaptureValue('9,00'), isTrue);
    expect(isAmountCaptureValue('not an amount'), isFalse);
  });

  testWidgets('expands extractor choices when editing a currency mapping', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition extractor =
        RegExpDefinition.createPredefinedRegExpDefinition(
          PredefinedRegExpDefinition.currency,
        );
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) => ElevatedButton(
              onPressed: () => selectTransactionAction(
                context,
                extractors: <RegExpDefinition>[extractor],
                notificationContext: NotificationContext(
                  title: 'Card payment',
                  body: 'Paid 12 CAD',
                  receivedAt: DateTime(2026, 9, 7),
                ),
                fixedField: TransactionField.currency,
                captureExtractorId: extractor.id,
                captureOnly: true,
              ),
              child: const Text('Edit currency'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Edit currency'));
    await tester.pumpAndSettle();

    final DialogExpanderCard captureOption = tester.widget(
      find.widgetWithText(DialogExpanderCard, 'Extractor capture'),
    );
    expect(captureOption.expanded, isTrue);
  });

  testWidgets('focuses a literal value only after its expander opens', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) => ElevatedButton(
              onPressed: () => selectTransactionAction(
                context,
                extractors: const <RegExpDefinition>[],
                notificationContext: notificationContext(),
                fixedField: TransactionField.title,
              ),
              child: const Text('Edit title'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Edit title'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Literal value'));
    await tester.pump();

    final Finder literal = find.byKey(const Key('action-literal-value'));
    Finder editable = find.descendant(
      of: literal,
      matching: find.byType(EditableText),
    );
    expect(tester.widget<EditableText>(editable).focusNode.hasFocus, isFalse);

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    editable = find.descendant(
      of: literal,
      matching: find.byType(EditableText),
    );
    expect(tester.widget<EditableText>(editable).focusNode.hasFocus, isFalse);

    await tester.pump(const Duration(milliseconds: 100));
    editable = find.descendant(
      of: literal,
      matching: find.byType(EditableText),
    );
    expect(tester.widget<EditableText>(editable).focusNode.hasFocus, isTrue);
  });

  testWidgets('prefills an existing literal title action', (
    WidgetTester tester,
  ) async {
    NotificationAction? selectedAction;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) => ElevatedButton(
              onPressed: () async {
                selectedAction = await selectTransactionAction(
                  context,
                  extractors: const <RegExpDefinition>[],
                  notificationContext: notificationContext(),
                  fixedField: TransactionField.title,
                  initialSource: const LiteralValueSource('Existing title'),
                  titleSuggestionLoader: (_) async => const <String>[],
                );
              },
              child: const Text('Edit title'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Edit title'));
    await tester.pumpAndSettle();

    final Finder literal = find.byKey(const Key('action-literal-value'));
    expect(literal, findsOneWidget);
    expect(
      tester.widget<TextFormField>(literal).controller!.text,
      'Existing title',
    );

    tester
        .widget<FilledButton>(find.widgetWithText(FilledButton, 'Save'))
        .onPressed!();
    await tester.pumpAndSettle();

    final SetTransactionFieldAction action =
        selectedAction! as SetTransactionFieldAction;
    expect((action.valueSource as LiteralValueSource).value, 'Existing title');
  });

  testWidgets('shows Firefly title suggestions in a floating dropdown', (
    WidgetTester tester,
  ) async {
    final List<String> queries = <String>[];
    NotificationAction? selectedAction;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) => ElevatedButton(
              onPressed: () async {
                selectedAction = await selectTransactionAction(
                  context,
                  extractors: const <RegExpDefinition>[],
                  notificationContext: notificationContext(),
                  fixedField: TransactionField.title,
                  titleSuggestionLoader: (String query) async {
                    queries.add(query);
                    return <String>['Coffee shop', 'Coffee beans'];
                  },
                );
              },
              child: const Text('Edit title'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Edit title'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Literal value'));
    await tester.pumpAndSettle();

    final Finder literal = find.byKey(const Key('action-literal-value'));
    final double dialogHeightBeforeSuggestions = tester
        .getSize(find.byType(AlertDialog))
        .height;
    await tester.enterText(literal, 'C');
    await tester.pump();

    expect(queries, <String>['', 'C']);
    expect(find.text('Coffee shop'), findsOneWidget);
    expect(find.text('Coffee beans'), findsOneWidget);
    final Finder literalExpander = find
        .ancestor(of: literal, matching: find.byType(DialogExpanderCard))
        .first;
    expect(
      tester.getTopLeft(find.text('Coffee shop')).dy,
      greaterThanOrEqualTo(tester.getBottomLeft(literal).dy),
    );
    expect(
      tester.getBottomLeft(find.text('Coffee beans')).dy,
      greaterThan(tester.getBottomLeft(literalExpander).dy),
    );
    expect(
      tester.getSize(find.byType(AlertDialog)).height,
      dialogHeightBeforeSuggestions,
    );

    await tester.tap(find.text('Coffee shop'));
    await tester.pump();
    expect(
      tester.widget<TextFormField>(literal).controller!.text,
      'Coffee shop',
    );
    expect(find.text('Coffee beans'), findsNothing);

    tester
        .widget<FilledButton>(find.widgetWithText(FilledButton, 'Save'))
        .onPressed!();
    await tester.pumpAndSettle();

    final SetTransactionFieldAction action =
        selectedAction! as SetTransactionFieldAction;
    expect(action.target, TransactionField.title);
    expect((action.valueSource as LiteralValueSource).value, 'Coffee shop');
  });

  testWidgets('ignores results from a superseded title query', (
    WidgetTester tester,
  ) async {
    final Completer<List<String>> first = Completer<List<String>>();
    final Completer<List<String>> second = Completer<List<String>>();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) => ElevatedButton(
              onPressed: () => selectTransactionAction(
                context,
                extractors: const <RegExpDefinition>[],
                notificationContext: notificationContext(),
                fixedField: TransactionField.title,
                titleSuggestionLoader: (String query) =>
                    query == 'C' ? first.future : second.future,
              ),
              child: const Text('Edit title'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Edit title'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Literal value'));
    await tester.pumpAndSettle();

    final Finder literal = find.byKey(const Key('action-literal-value'));
    await tester.enterText(literal, 'C');
    await tester.pump();
    await tester.enterText(literal, 'Co');
    await tester.pump();

    first.complete(<String>['Cancelled result']);
    await tester.pump();
    expect(find.text('Cancelled result'), findsNothing);

    second.complete(<String>['Current result']);
    await tester.pump();
    expect(find.text('Current result'), findsOneWidget);
  });

  testWidgets(
    'keeps arbitrary literal title editing available on query failure',
    (WidgetTester tester) async {
      NotificationAction? selectedAction;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) => ElevatedButton(
                onPressed: () async {
                  selectedAction = await selectTransactionAction(
                    context,
                    extractors: const <RegExpDefinition>[],
                    notificationContext: notificationContext(),
                    fixedField: TransactionField.title,
                    titleSuggestionLoader: (String query) =>
                        Future<List<String>>.error(
                          StateError('Firefly unavailable'),
                        ),
                  );
                },
                child: const Text('Edit title'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Edit title'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Literal value'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const Key('action-literal-value')),
        'Coffee',
      );
      await tester.pump();

      expect(
        tester
            .widget<FilledButton>(find.widgetWithText(FilledButton, 'Save'))
            .onPressed,
        isNotNull,
      );
      tester
          .widget<FilledButton>(find.widgetWithText(FilledButton, 'Save'))
          .onPressed!();
      await tester.pumpAndSettle();

      final SetTransactionFieldAction action =
          selectedAction! as SetTransactionFieldAction;
      expect((action.valueSource as LiteralValueSource).value, 'Coffee');
    },
  );

  testWidgets('shows every compatible match for a scoped currency extractor', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition extractor =
        RegExpDefinition.createPredefinedRegExpDefinition(
          PredefinedRegExpDefinition.currency,
        );
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) => ElevatedButton(
              onPressed: () => selectTransactionAction(
                context,
                extractors: <RegExpDefinition>[extractor],
                notificationContext: NotificationContext(
                  title: 'Card payment',
                  body: 'Paid 12 CAD and 9 USD',
                  receivedAt: DateTime(2026, 9, 7),
                ),
                fixedField: TransactionField.currency,
                captureExtractorId: extractor.id,
                captureOnly: true,
              ),
              child: const Text('Edit currency'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Edit currency'));
    await tester.pumpAndSettle();
    expect(find.text('2 matches'), findsOneWidget);

    await tester.tap(find.text('2 matches'));
    await tester.pumpAndSettle();
    expect(find.text('Match 1 - Group "postCurrency"'), findsOneWidget);
    final Text matchTitle = tester.widget<Text>(
      find.text('Match 1 - Group "postCurrency"'),
    );
    final TextSpan titleSpan = matchTitle.textSpan! as TextSpan;
    final TextSpan groupNameSpan = titleSpan.children![1] as TextSpan;
    expect(
      groupNameSpan.style?.color,
      Theme.of(
        tester.element(find.text('Match 1 - Group "postCurrency"')),
      ).colorScheme.primary,
    );
    expect(find.text('Resolved value: "CAD"'), findsOneWidget);
    expect(find.text('Match 2 - Group "postCurrency"'), findsOneWidget);
    expect(find.text('Resolved value: "USD"'), findsOneWidget);
  });

  testWidgets('omits an action\'s current extractor when editing its value', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition selectedExtractor =
        RegExpDefinition.createCustomRegExpDefinition(
          'Selected title',
          r'(?<title>Paid 12 CAD)',
        );
    final RegExpDefinition replacementExtractor =
        RegExpDefinition.createCustomRegExpDefinition(
          'Replacement title',
          r'(?<title>Paid 12 CAD)',
        );
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) => ElevatedButton(
              onPressed: () => selectTransactionAction(
                context,
                extractors: <RegExpDefinition>[
                  selectedExtractor,
                  replacementExtractor,
                ],
                notificationContext: NotificationContext(
                  title: 'Card payment',
                  body: 'Paid 12 CAD',
                  receivedAt: DateTime(2026, 9, 7),
                ),
                fixedField: TransactionField.title,
                excludedExtractorId: selectedExtractor.id,
              ),
              child: const Text('Edit title'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Edit title'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Extractor capture'));
    await tester.pumpAndSettle();

    expect(find.text('Selected title'), findsNothing);
    expect(find.text('Replacement title'), findsOneWidget);
  });

  testWidgets('uses the zero capture group form', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Scaffold()));
    expect(
      S
          .of(tester.element(find.byType(Scaffold)))
          .notificationsCaptureGroupCount(0),
      'No captured groups',
    );
  });

  testWidgets('navigates forward to tags and back to field selection', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) => ElevatedButton(
              onPressed: () => selectTransactionAction(
                context,
                extractors: const <RegExpDefinition>[],
                notificationContext: notificationContext(),
                tagLoader: () async => <String>['Groceries'],
              ),
              child: const Text('Add action'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Add action'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Tags'),
      100,
      scrollable: find.descendant(
        of: find.byKey(const ValueKey<String>('fields')),
        matching: find.byType(Scrollable),
      ),
    );
    await tester.tap(find.text('Tags'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('action-tags-step')), findsOneWidget);

    await tester.tap(find.text('Back'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('action-tags-step')), findsNothing);
    expect(find.byKey(const ValueKey<String>('action-fields')), findsOneWidget);
  });

  testWidgets('adds a custom tag and only enables save when nonempty', (
    WidgetTester tester,
  ) async {
    NotificationAction? result;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) => ElevatedButton(
              onPressed: () async {
                result = await selectTransactionAction(
                  context,
                  extractors: const <RegExpDefinition>[],
                  notificationContext: notificationContext(),
                  fixedField: TransactionField.tag,
                  tagLoader: () async => <String>['Groceries'],
                );
              },
              child: const Text('Edit tags'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Edit tags'));
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<FilledButton>(find.byKey(const Key('action-tags-save')))
          .onPressed,
      isNull,
    );

    await tester.enterText(
      find.byKey(const Key('action-tags-search')),
      'Weekend',
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('action-tags-add')));
    await tester.pump();
    expect(find.text('Weekend'), findsWidgets);
    expect(
      tester
          .widget<TextField>(find.byKey(const Key('action-tags-search')))
          .controller
          ?.text,
      isEmpty,
    );
    expect(find.byKey(const Key('action-tags-selected')), findsNothing);
    final Finder weekendTag = find.byKey(
      const ValueKey<String>('action-tag-Weekend'),
    );
    await tester.ensureVisible(weekendTag);
    await tester.pumpAndSettle();
    await tester.tap(weekendTag);
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<FilledButton>(find.byKey(const Key('action-tags-save')))
          .onPressed,
      isNull,
    );
    expect(weekendTag, findsOneWidget);
    await tester.tap(weekendTag);
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<FilledButton>(find.byKey(const Key('action-tags-save')))
          .onPressed,
      isNotNull,
    );

    await tester.tap(find.byKey(const Key('action-tags-save')));
    await tester.pumpAndSettle();
    expect(result, isA<SetTransactionTagsAction>());
    expect((result! as SetTransactionTagsAction).tags, <String>['Weekend']);
  });

  testWidgets('loads existing tags case-insensitively and selects another', (
    WidgetTester tester,
  ) async {
    SetTransactionTagsAction? result;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) => ElevatedButton(
              onPressed: () async {
                result = await selectTransactionTagsAction(
                  context,
                  selectedTags: <String>['groceries'],
                  tagLoader: () async => <String>['Groceries', 'Travel'],
                );
              },
              child: const Text('Edit existing tags'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Edit existing tags'));
    await tester.pumpAndSettle();
    final CheckboxListTile groceries = tester.widget(
      find.byKey(const ValueKey<String>('action-tag-Groceries')),
    );
    expect(groceries.value, isTrue);
    await tester.tap(find.byKey(const ValueKey<String>('action-tag-Travel')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('action-tags-save')));
    await tester.pumpAndSettle();

    expect(result?.tags, <String>['groceries', 'Travel']);
  });

  testWidgets('keeps the tag step open and shows load errors', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) => ElevatedButton(
              onPressed: () => selectTransactionAction(
                context,
                extractors: const <RegExpDefinition>[],
                notificationContext: notificationContext(),
                fixedField: TransactionField.tag,
                tagLoader: () => Future<List<String>>.error('offline'),
              ),
              child: const Text('Edit tags'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Edit tags'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('action-tags-load-error')), findsOneWidget);
    expect(find.text('Tags could not be loaded.'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
  });

  testWidgets('animates every Add Part branch forward and back', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(768, 1600));
    addTearDown(() {
      tester.binding.setSurfaceSize(null);
      tester.view.resetViewInsets();
    });
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) => ElevatedButton(
              onPressed: () => selectTransactionAction(
                context,
                extractors: const <RegExpDefinition>[],
                notificationContext: notificationContext(),
                fixedField: TransactionField.notes,
              ),
              child: const Text('Build notes'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Build notes'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('action-build-text')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('build-text-add-part')));
    await tester.pumpAndSettle();

    Future<void> expectTransition(
      Finder trigger,
      Key outgoing,
      Key incoming,
    ) async {
      await tester.tap(trigger);
      await tester.pump();
      expect(find.byKey(outgoing), findsOneWidget);
      expect(find.byKey(incoming), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byKey(outgoing), findsNothing);
      expect(find.byKey(incoming), findsOneWidget);
    }

    await expectTransition(
      find.byKey(const Key('build-text-add-capture')),
      const Key('build-text-add-type-step'),
      const Key('build-text-add-capture-step'),
    );
    await expectTransition(
      find.byKey(const Key('build-text-add-back')),
      const Key('build-text-add-capture-step'),
      const Key('build-text-add-type-step'),
    );
    await expectTransition(
      find.byKey(const Key('build-text-add-fixed')),
      const Key('build-text-add-type-step'),
      const Key('build-text-fixed-options'),
    );

    final Finder customFixed = find.byKey(
      const Key('build-text-fixed-custom-option'),
    );
    final Finder customFixedHeader = find.descendant(
      of: customFixed,
      matching: find.byType(ListTile),
    );
    await tester.ensureVisible(customFixed);
    await tester.pumpAndSettle();
    await tester.tap(customFixedHeader);
    await tester.pump();
    expect(find.byKey(const Key('build-text-fixed-options')), findsOneWidget);
    expect(
      find.byKey(const Key('build-text-fixed-custom-editor')),
      findsOneWidget,
    );
    TextField customEditor = tester.widget<TextField>(
      find.byKey(const Key('build-text-custom-fixed')),
    );
    expect(customEditor.focusNode!.hasFocus, isFalse);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    customEditor = tester.widget<TextField>(
      find.byKey(const Key('build-text-custom-fixed')),
    );
    expect(customEditor.focusNode!.hasFocus, isFalse);
    await tester.pump(const Duration(milliseconds: 100));
    customEditor = tester.widget<TextField>(
      find.byKey(const Key('build-text-custom-fixed')),
    );
    expect(customEditor.focusNode!.hasFocus, isTrue);
    tester.view.viewInsets = const FakeViewPadding(bottom: 520);
    await tester.pumpAndSettle();
    final SingleChildScrollView fixedChoices = tester.widget(
      find.byKey(const Key('build-text-fixed-scroll')),
    );
    expect(fixedChoices.controller!.offset, greaterThan(0));
    expect(
      tester.getBottomRight(customFixed).dy,
      lessThanOrEqualTo(
        tester.getTopLeft(find.byKey(const Key('build-text-fixed-back'))).dy,
      ),
    );
    tester.view.resetViewInsets();
    await tester.pumpAndSettle();
    await tester.ensureVisible(customFixedHeader);
    await tester.pumpAndSettle();
    await tester.tap(customFixedHeader);
    await tester.pumpAndSettle();
    expect(
      find.byKey(const Key('build-text-fixed-custom-editor')),
      findsNothing,
    );
    await expectTransition(
      find.byKey(const Key('build-text-fixed-back')),
      const Key('build-text-fixed-options'),
      const Key('build-text-add-type-step'),
    );
  });

  testWidgets(
    'builds, previews, reorders, edits, and deletes fixed text parts',
    (WidgetTester tester) async {
      const Color nestedSurface = Color(0xff334455);
      await tester.binding.setSurfaceSize(const Size(600, 900));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: const <ThemeExtension<dynamic>>[
              NotificationCardTheme(
                surfaceColor: Color(0xff223344),
                nestedSurfaceColor: nestedSurface,
                deepNestedSurfaceColor: Color(0xff445566),
              ),
            ],
          ),
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) => ElevatedButton(
                onPressed: () => selectTransactionAction(
                  context,
                  extractors: const <RegExpDefinition>[],
                  notificationContext: NotificationContext(
                    title: 'Card payment',
                    body: 'Paid 12 CAD',
                    receivedAt: DateTime(2026, 9, 7),
                  ),
                  fixedField: TransactionField.notes,
                ),
                child: const Text('Edit notes'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Edit notes'));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('action-build-text')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('build-text-step')), findsOneWidget);
      expect(find.byKey(const Key('build-text-preview-card')), findsNothing);
      expect(find.text('Preview'), findsNothing);
      expect(find.text('Parts'), findsNothing);
      expect(find.byKey(const Key('build-text-empty-message')), findsOneWidget);
      final FilledButton addPartButton = tester.widget(
        find.byKey(const Key('build-text-add-part')),
      );
      expect(addPartButton.onPressed, isNotNull);
      expect(
        find.text('Add a part to start building the text.'),
        findsOneWidget,
      );
      expect(
        tester
            .widget<FilledButton>(find.byKey(const Key('build-text-save')))
            .onPressed,
        isNull,
      );

      Future<void> addFixed(String value) async {
        final Finder addPart = find.byKey(const Key('build-text-add-part'));
        await tester.ensureVisible(addPart);
        await tester.tap(addPart);
        await tester.pumpAndSettle();
        await tester.tap(find.text('Fixed text').last);
        await tester.pumpAndSettle();
        expect(
          find.byKey(const Key('build-text-fixed-options')),
          findsOneWidget,
        );
        expect(find.byKey(const Key('build-text-fixed-back')), findsOneWidget);
        expect(find.byKey(const Key('build-text-custom-fixed')), findsNothing);
        await tester.tap(find.byKey(const Key('build-text-fixed-back')));
        await tester.pumpAndSettle();
        expect(
          find.byKey(const Key('build-text-add-type-step')),
          findsOneWidget,
        );
        await tester.tap(find.text('Fixed text').last);
        await tester.pumpAndSettle();
        final Finder customFixed = find.byKey(
          const Key('build-text-fixed-custom-option'),
        );
        await tester.ensureVisible(customFixed);
        await tester.pumpAndSettle();
        await tester.tap(customFixed);
        await tester.pumpAndSettle();
        expect(
          find.byKey(const Key('build-text-fixed-options')),
          findsOneWidget,
        );
        expect(
          find.byKey(const Key('build-text-fixed-custom-editor')),
          findsOneWidget,
        );
        await tester.enterText(
          find.byKey(const Key('build-text-custom-fixed')),
          value,
        );
        await tester.pump();
        await tester.tap(find.byKey(const Key('build-text-fixed-save')));
        await tester.pumpAndSettle();
      }

      await addFixed('Hello');
      expect(find.byKey(const Key('build-text-preview-card')), findsOneWidget);
      expect(find.text('Preview'), findsOneWidget);
      expect(find.text('Parts'), findsOneWidget);
      expect(
        tester.getSize(find.byKey(const Key('build-text-preview-card'))).width,
        tester.getSize(find.byKey(const Key('build-text-step'))).width,
      );
      final ElevatedButton populatedAddPartButton = tester.widget(
        find.byKey(const Key('build-text-add-part')),
      );
      expect(
        populatedAddPartButton.style?.backgroundColor?.resolve(
          const <WidgetState>{},
        ),
        nestedSurface,
      );
      expect(
        populatedAddPartButton.style?.elevation?.resolve(const <WidgetState>{}),
        0,
      );
      await addFixed(' world');
      expect(find.text('Hello world'), findsOneWidget);

      await tester.ensureVisible(find.byKey(const Key('build-text-up-1')));
      await tester.tap(find.byKey(const Key('build-text-up-1')));
      await tester.pumpAndSettle();
      expect(find.text(' worldHello'), findsOneWidget);

      await tester.ensureVisible(find.byKey(const Key('build-text-part-0')));
      await tester.tap(find.byKey(const Key('build-text-part-0')));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const Key('build-text-custom-fixed')),
        'Hi ',
      );
      await tester.pump();
      await tester.tap(find.byKey(const Key('build-text-fixed-save')));
      await tester.pumpAndSettle();
      expect(find.text('Hi Hello'), findsOneWidget);

      await tester.ensureVisible(find.byKey(const Key('build-text-delete-1')));
      await tester.tap(find.byKey(const Key('build-text-delete-1')));
      await tester.pumpAndSettle();
      expect(find.text('Hi '), findsWidgets);
      await tester.ensureVisible(find.byKey(const Key('build-text-delete-0')));
      await tester.tap(find.byKey(const Key('build-text-delete-0')));
      await tester.pump();
      expect(find.byKey(const Key('build-text-empty-message')), findsOneWidget);
      expect(find.text('Preview'), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.text('Preview'), findsNothing);
      expect(find.text('Parts'), findsNothing);
      expect(find.byKey(const Key('build-text-empty-message')), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('opens an existing built text action with its parts', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) => ElevatedButton(
              onPressed: () => selectTransactionAction(
                context,
                extractors: const <RegExpDefinition>[],
                notificationContext: NotificationContext(
                  title: 'Card payment',
                  body: 'Paid 12 CAD',
                  receivedAt: DateTime(2026, 9, 7),
                ),
                fixedField: TransactionField.title,
                initialSource: ComposedValueSource(const <LiteralValueSource>[
                  LiteralValueSource('Existing'),
                  LiteralValueSource(' title'),
                ]),
              ),
              child: const Text('Edit built title'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Edit built title'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('build-text-step')), findsOneWidget);
    expect(find.byKey(const Key('build-text-part-0')), findsOneWidget);
    expect(find.byKey(const Key('build-text-part-1')), findsOneWidget);
    expect(find.text('Existing title'), findsOneWidget);
  });

  testWidgets('adds extractor captures through the shared capture picker', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition extractor =
        RegExpDefinition.createCustomRegExpDefinition(
          'Merchant',
          r'(?<merchant>Market)',
        );
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) => ElevatedButton(
              onPressed: () => selectTransactionAction(
                context,
                extractors: <RegExpDefinition>[extractor],
                notificationContext: NotificationContext(
                  title: 'Card payment',
                  body: 'Paid at Market',
                  receivedAt: DateTime(2026, 9, 7),
                ),
                fixedField: TransactionField.notes,
              ),
              child: const Text('Build notes'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Build notes'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('action-build-text')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('build-text-add-part')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Extractor capture').last);
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('build-text-capture-picker')), findsOneWidget);
    expect(find.byKey(const Key('build-text-add-back')), findsOneWidget);
    await tester.tap(find.byKey(const Key('build-text-add-back')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('build-text-add-type-step')), findsOneWidget);
    expect(find.byKey(const Key('build-text-capture-picker')), findsNothing);
    await tester.tap(find.text('Extractor capture').last);
    await tester.pumpAndSettle();
    expect(find.text('Merchant'), findsOneWidget);
    await tester.tap(find.text('Merchant'));
    await tester.pumpAndSettle();
    expect(find.text('Merchant · merchant'), findsNothing);
    expect(find.text('Merchant'), findsOneWidget);
  });

  testWidgets('formats a date-time capture in built text', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition extractor =
        RegExpDefinition.createPredefinedRegExpDefinition(
          PredefinedRegExpDefinition.notificationDate,
        );
    await tester.pumpWidget(
      material_ui.MaterialApp(
        locale: const Locale('en', 'US'),
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        builder: (BuildContext context, Widget? child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        ),
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) => ElevatedButton(
              onPressed: () => selectTransactionAction(
                context,
                extractors: <RegExpDefinition>[extractor],
                notificationContext: NotificationContext(
                  title: 'Card payment',
                  body: 'Paid at Market',
                  receivedAt: DateTime(1969, 12, 31, 16, 0, 22),
                ),
                fixedField: TransactionField.notes,
                initialSource: ComposedValueSource(<ValueSource>[
                  const LiteralValueSource('Test - '),
                  RegExpCaptureValueSource(
                    extractorId: extractor.id,
                    captureName: 'date',
                  ),
                ]),
              ),
              child: const Text('Build notes'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Build notes'));
    await tester.pumpAndSettle();

    expect(find.text('Test - 12/31/1969 16:00'), findsOneWidget);
  });
}
