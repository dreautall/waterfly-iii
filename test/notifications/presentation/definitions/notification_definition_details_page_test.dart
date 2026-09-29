import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart' hide MaterialApp;
import 'package:material_ui/material_ui.dart' as material_ui;
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/value_exists_condition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_action_group.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/literal_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';
import 'package:waterflyiii/notifications/presentation/definitions/pages/notification_definition_details_page.dart';
import 'package:waterflyiii/notifications/presentation/definitions/widgets/definition_extractors_section.dart';
import 'package:waterflyiii/notifications/presentation/definitions/widgets/definition_rules_section.dart';
import 'package:waterflyiii/notifications/presentation/definitions/widgets/notification_definition_card.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/actions/transaction_action_steps.dart';
import 'package:waterflyiii/notifications/presentation/extractors/pages/notification_extractor_details_page.dart';
import 'package:waterflyiii/notifications/presentation/rules/pages/notification_rule_details_page.dart';
import 'package:waterflyiii/notifications/presentation/shared/definition_detail_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/dialog_selector_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/message_status_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_card_theme.dart';
import 'package:waterflyiii/notifications/presentation/shared/sample_notification_card.dart';

class MaterialApp extends material_ui.MaterialApp {
  const MaterialApp({super.key, required super.home})
    : super(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
      );
}

Finder richText(String text) => find.byWidgetPredicate(
  (Widget widget) => widget is Text && widget.textSpan?.toPlainText() == text,
);

void main() {
  testWidgets(
    'detail card surfaces are overridden only by their theme extension',
    (WidgetTester tester) async {
      Future<void> pumpCard({Color? surfaceColor}) async {
        await tester.pumpWidget(
          material_ui.MaterialApp(
            theme: ThemeData(
              useMaterial3: true,
              extensions: <ThemeExtension<dynamic>>[
                if (surfaceColor != null)
                  NotificationCardTheme(
                    surfaceColor: surfaceColor,
                    nestedSurfaceColor: surfaceColor,
                    deepNestedSurfaceColor: surfaceColor,
                  ),
              ],
            ),
            home: Scaffold(
              body: Column(
                children: <Widget>[
                  DefinitionDetailCard(
                    leading: const Icon(Icons.check),
                    title: const Text('Tappable'),
                    onTap: () {},
                  ),
                  const DefinitionDetailCard(
                    leading: Icon(Icons.check),
                    title: Text('Static'),
                  ),
                  const SampleNotificationCard(
                    applicationId: 'com.example.bank',
                    title: 'Sample',
                    body: 'Payment received',
                  ),
                ],
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
      }

      Color? buttonColor() => tester
          .widget<ElevatedButton>(
            find.widgetWithText(ElevatedButton, 'Tappable'),
          )
          .style
          ?.backgroundColor
          ?.resolve(<WidgetState>{});
      Color? cardColor(String title) => tester
          .widget<Card>(
            find.ancestor(of: find.text(title), matching: find.byType(Card)),
          )
          .color;

      await pumpCard();
      final Color defaultColor = Theme.of(
        tester.element(find.text('Tappable')),
      ).colorScheme.surfaceContainerLow;
      expect(buttonColor(), defaultColor);
      expect(cardColor('Static'), defaultColor);
      expect(cardColor('Sample'), defaultColor);

      await pumpCard(surfaceColor: Colors.purple);
      expect(buttonColor(), Colors.purple);
      expect(cardColor('Static'), Colors.purple);
      expect(cardColor('Sample'), Colors.purple);
    },
  );

  testWidgets('detail cards use the same height for one and two text lines', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(780, 1600);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    for (final double textScale in <double>[0.85, 1, 1.3, 2]) {
      await tester.pumpWidget(
        material_ui.MaterialApp(
          theme: ThemeData(brightness: Brightness.dark, useMaterial3: true),
          home: Scaffold(
            body: MediaQuery(
              data: MediaQueryData(textScaler: TextScaler.linear(textScale)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  DefinitionDetailCard(
                    leading: const Icon(Icons.check),
                    title: const Text('One line'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  DefinitionDetailCard(
                    leading: const Icon(Icons.check),
                    title: const Text('Two lines'),
                    subtitle: const Text('A subtitle'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  const DefinitionDetailCard(
                    leading: Icon(Icons.check),
                    title: Text('Static one'),
                  ),
                  const DefinitionDetailCard(
                    leading: Icon(Icons.check),
                    title: Text('Static two'),
                    subtitle: Text('A subtitle'),
                  ),
                  DefinitionDetailCard(
                    leading: const Icon(Icons.check),
                    title: const Text('Three lines'),
                    subtitle: const Text('First line\nSecond line'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      Finder cardFor(String name) => find.ancestor(
        of: find.text(name),
        matching: find.byType(ElevatedButton),
      );
      expect(
        tester.getSize(cardFor('One line')).height,
        tester.getSize(cardFor('Two lines')).height,
        reason: 'text scale $textScale',
      );
      final double iconCenter = tester
          .getCenter(
            find.descendant(
              of: cardFor('One line'),
              matching: find.byIcon(Icons.check),
            ),
          )
          .dy;
      final double titleCenter = tester.getCenter(find.text('One line')).dy;
      expect(
        titleCenter,
        closeTo(iconCenter, 1),
        reason: 'single-line title alignment at text scale $textScale',
      );
      expect(
        titleCenter,
        closeTo(
          tester
              .getCenter(
                find.descendant(
                  of: cardFor('One line'),
                  matching: find.byIcon(Icons.chevron_right),
                ),
              )
              .dy,
          1,
        ),
        reason: 'single-line trailing alignment at text scale $textScale',
      );
      Finder staticCardFor(String name) =>
          find.ancestor(of: find.text(name), matching: find.byType(Card));
      expect(
        tester.getSize(staticCardFor('Static one')).height,
        tester.getSize(staticCardFor('Static two')).height,
        reason: 'non-interactive card at text scale $textScale',
      );
      expect(
        tester.getSize(cardFor('Three lines')).height,
        greaterThan(tester.getSize(cardFor('Two lines')).height),
        reason: 'longer text must remain visible at text scale $textScale',
      );
    }
  });

  testWidgets('extractor cards have consistent height without a description', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(780, 1600);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MediaQuery(
            data: const MediaQueryData(textScaler: TextScaler.linear(1.3)),
            child: DefinitionExtractorsSection(
              extractors: <RegExpDefinition>[
                RegExpDefinition.createCustomRegExpDefinition(
                  'Described',
                  r'Paid \d+',
                  description: 'Amount.',
                ),
                RegExpDefinition.createCustomRegExpDefinition(
                  'Undescribed',
                  r'Paid \d+',
                ),
              ],
              extractorMode: NotificationExtractorMode.advanced,
              notificationContext: NotificationContext(
                title: 'Payment',
                body: 'Paid 12 CAD',
                receivedAt: DateTime(2026, 9, 26),
              ),
              onEditExtractor: (_, {required bool removable}) {},
              onAddExtractor: () {},
            ),
          ),
        ),
      ),
    );

    Finder cardFor(String name) => find.ancestor(
      of: find.text(name),
      matching: find.byType(ElevatedButton),
    );
    final double describedHeight = tester.getSize(cardFor('Described')).height;
    final double undescribedHeight = tester
        .getSize(cardFor('Undescribed'))
        .height;
    expect(describedHeight, greaterThanOrEqualTo(48));
    expect(undescribedHeight, closeTo(describedHeight, 1));
    expect(
      tester.getCenter(find.text('Undescribed')).dy,
      closeTo(
        tester
            .getCenter(
              find.descendant(
                of: cardFor('Undescribed'),
                matching: find.byIcon(Icons.check_circle_outline),
              ),
            )
            .dy,
        1,
      ),
    );
  });

  testWidgets('extractor cards distinguish no match from invalid pattern', (
    WidgetTester tester,
  ) async {
    Future<void> showExtractor(String source) => tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DefinitionExtractorsSection(
            extractors: <RegExpDefinition>[
              RegExpDefinition.createCustomRegExpDefinition('Amount', source),
            ],
            extractorMode: NotificationExtractorMode.advanced,
            notificationContext: NotificationContext(
              title: 'Payment',
              body: 'Paid 12 CAD',
              receivedAt: DateTime(2026, 9, 26),
            ),
            onEditExtractor: (_, {required bool removable}) {},
            onAddExtractor: () {},
          ),
        ),
      ),
    );

    await showExtractor(r'Refund \d+');
    ColorScheme colors = Theme.of(
      tester.element(find.text('No sample match')),
    ).colorScheme;
    expect(
      tester.widget<Icon>(find.byIcon(Icons.error_outline)).color,
      colors.tertiary,
    );
    expect(
      tester.widget<Text>(find.text('No sample match')).style?.color,
      colors.tertiary,
    );

    await showExtractor('(');
    colors = Theme.of(tester.element(find.text('Invalid pattern'))).colorScheme;
    expect(
      tester.widget<Icon>(find.byIcon(Icons.error_outline)).color,
      colors.error,
    );
    expect(
      tester.widget<Text>(find.text('Invalid pattern')).style?.color,
      colors.error,
    );

    await showExtractor(r'Paid \d+');
    expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
    expect(find.text('No sample match'), findsNothing);
    expect(find.text('Invalid pattern'), findsNothing);
  });

  testWidgets('rule drag proxy excludes the list spacing decoration', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DefinitionRulesSection(
            rules: const <NotificationRule>[
              NotificationRule(
                id: 'first',
                name: 'First rule',
                conditions: <NotificationCondition>[],
                actions: <NotificationAction>[],
              ),
              NotificationRule(
                id: 'second',
                name: 'Second rule',
                conditions: <NotificationCondition>[
                  ValueExistsCondition(LiteralValueSource('value')),
                ],
                actions: <NotificationAction>[],
              ),
            ],
            extractors: const <RegExpDefinition>[],
            notificationContext: NotificationContext(
              title: 'Deposit received',
              body: 'Salary deposit received',
              receivedAt: DateTime(2026, 9, 24),
            ),
            onEditRule: (_) {},
            onAddRule: () {},
            onMoveRule: (_, _) {},
          ),
        ),
      ),
    );

    final ReorderableListView list = tester.widget<ReorderableListView>(
      find.byType(ReorderableListView),
    );
    const Widget child = SizedBox(key: ValueKey<String>('proxy-child'));

    expect(
      list.proxyDecorator!(child, 0, const AlwaysStoppedAnimation<double>(1)),
      same(child),
    );
    expect(find.text('1 condition · No actions'), findsOneWidget);
  });

  testWidgets('incomplete conditional action does not invalidate rule card', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DefinitionRulesSection(
            rules: const <NotificationRule>[
              NotificationRule(
                id: 'rule',
                name: 'Deposits',
                description: 'Creates a deposit transaction.',
                conditions: <NotificationCondition>[],
                actions: <NotificationAction>[
                  SetTransactionFieldAction(
                    target: TransactionField.title,
                    valueSource: LiteralValueSource('Deposit'),
                  ),
                ],
                conditionalActionGroups: <NotificationActionGroup>[
                  NotificationActionGroup(
                    id: 'conditional-action',
                    name: 'Optional details',
                    conditions: <NotificationCondition>[],
                    actions: <NotificationAction>[],
                  ),
                ],
              ),
            ],
            extractors: const <RegExpDefinition>[],
            notificationContext: NotificationContext(
              title: 'Deposit received',
              body: 'Salary deposit received',
              receivedAt: DateTime(2026, 9, 24),
            ),
            onEditRule: (_) {},
            onAddRule: () {},
            onMoveRule: (_, _) {},
          ),
        ),
      ),
    );

    expect(find.text('Deposits'), findsOneWidget);
    expect(find.text('Needs setup'), findsNothing);
    expect(find.text('Needs review'), findsOneWidget);
    expect(
      find.descendant(
        of: find.ancestor(
          of: find.text('Deposits'),
          matching: find.byType(DefinitionDetailCard),
        ),
        matching: find.byIcon(Icons.error_outline),
      ),
      findsOneWidget,
    );
    expect(find.byIcon(Icons.warning_amber_outlined), findsNothing);
    expect(find.text('Creates a deposit transaction.'), findsOneWidget);
    expect(find.textContaining('1 action'), findsNothing);
  });

  testWidgets('unconfigured conditional action warns on the definition and rule', (
    WidgetTester tester,
  ) async {
    final NotificationDefinition definition = NotificationDefinition(
      id: 'bank',
      applicationId: 'com.example.bank',
      name: 'Example Bank',
      sampleTitle: 'Payment',
      sampleBody: 'Paid 12 CAD',
      extractors: <RegExpDefinition>[
        RegExpDefinition.createCustomRegExpDefinition('Amount', r'\d+'),
      ],
      rules: const <NotificationRule>[
        NotificationRule(
          id: 'rule',
          name: 'Deposits',
          conditions: <NotificationCondition>[],
          actions: <NotificationAction>[],
          conditionalActionGroups: <NotificationActionGroup>[
            NotificationActionGroup(
              id: 'optional',
              name: 'Optional details',
              conditions: <NotificationCondition>[],
              actions: <NotificationAction>[],
            ),
          ],
        ),
      ],
      extractorMode: NotificationExtractorMode.advanced,
    );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationDefinitionDetailsPage(
          definition: definition,
          onSave: (_) async => true,
        ),
      ),
    );
    expect(find.text('Needs review'), findsOneWidget);
    expect(
      find.text(
        'Review conditional actions marked Needs review and any suggested field mappings before using this application.',
      ),
      findsOneWidget,
    );
    await tester.scrollUntilVisible(
      find.text('Deposits'),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    expect(
      find.descendant(
        of: find.ancestor(
          of: find.text('Deposits'),
          matching: find.byType(DefinitionDetailCard),
        ),
        matching: find.text('Needs review'),
      ),
      findsOneWidget,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NotificationDefinitionCard(definition: definition),
        ),
      ),
    );
    expect(find.text('Needs review'), findsOneWidget);
    expect(
      find.text(
        'Review conditional actions marked Needs review and any suggested field mappings before using this application.',
      ),
      findsOneWidget,
    );
  });

  testWidgets(
    'rule summary includes conditional actions without a description',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DefinitionRulesSection(
              rules: const <NotificationRule>[
                NotificationRule(
                  id: 'rule',
                  name: 'Deposits',
                  conditions: <NotificationCondition>[
                    ValueExistsCondition(LiteralValueSource('deposit')),
                  ],
                  actions: <NotificationAction>[],
                  conditionalActionGroups: <NotificationActionGroup>[
                    NotificationActionGroup(
                      id: 'first',
                      name: 'Optional details',
                      conditions: <NotificationCondition>[
                        ValueExistsCondition(LiteralValueSource('salary')),
                      ],
                      actions: <NotificationAction>[
                        SetTransactionFieldAction(
                          target: TransactionField.title,
                          valueSource: LiteralValueSource('Deposit'),
                        ),
                      ],
                    ),
                    NotificationActionGroup(
                      id: 'second',
                      name: 'More details',
                      conditions: <NotificationCondition>[
                        ValueExistsCondition(LiteralValueSource('bonus')),
                      ],
                      actions: <NotificationAction>[
                        SetTransactionFieldAction(
                          target: TransactionField.title,
                          valueSource: LiteralValueSource('Bonus'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
              extractors: const <RegExpDefinition>[],
              notificationContext: NotificationContext(
                title: 'Deposit received',
                body: 'Salary deposit received',
                receivedAt: DateTime(2026, 9, 24),
              ),
              onEditRule: (_) {},
              onAddRule: () {},
              onMoveRule: (_, _) {},
            ),
          ),
        ),
      );

      expect(
        find.text(
          '1 condition · No always-run actions · 2 conditional actions',
        ),
        findsOneWidget,
      );
      expect(find.text('Needs review'), findsNothing);
    },
  );

  testWidgets('scrolls content behind the transparent notification header', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(padding: EdgeInsets.only(bottom: 34)),
          child: NotificationDefinitionDetailsPage(
            definition: const NotificationDefinition(
              id: 'bank',
              applicationId: 'com.example.bank',
              name: 'Example Bank',
              sampleTitle: 'Card payment',
              sampleBody: 'Paid 12 CAD',
              extractors: <RegExpDefinition>[],
              rules: <NotificationRule>[],
            ),
            onSave: (_) async => true,
          ),
        ),
      ),
    );

    final Scaffold scaffold = tester.widget<Scaffold>(
      find.byType(Scaffold).first,
    );
    expect(scaffold.extendBodyBehindAppBar, isTrue);

    final ListView list = tester.widget<ListView>(find.byType(ListView).first);
    final EdgeInsets padding = list.padding! as EdgeInsets;
    expect(padding.top, greaterThan(kToolbarHeight));
    expect(padding.bottom, 58);
    expect(tester.getTopLeft(find.byType(ListView).first).dy, 0);
    expect(tester.getBottomRight(find.byType(ListView).first).dy, 1000);
  });

  testWidgets('disables setup choices until a sample notification is defined', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationDefinitionDetailsPage(
          definition: const NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            extractors: <RegExpDefinition>[],
            rules: <NotificationRule>[],
          ),
          onSave: (NotificationDefinition definition) async => true,
        ),
      ),
    );
    await tester.pumpAndSettle();

    final FilledButton continueButton = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Continue'),
    );
    expect(continueButton.onPressed, isNull);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(
      find.text('Add a sample notification before choosing a setup option.'),
      findsOneWidget,
    );
    expect(find.byTooltip('Edit sample notification'), findsOneWidget);

    await tester.tap(find.byType(SampleNotificationCard));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('sample-notification-body')), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    final ListTile basicOption = tester.widget<ListTile>(
      find.widgetWithText(ListTile, 'Basic'),
    );
    final ListTile advancedOption = tester.widget<ListTile>(
      find.widgetWithText(ListTile, 'Advanced'),
    );
    expect(basicOption.enabled, isFalse);
    expect(advancedOption.enabled, isFalse);

    await tester.tap(find.text('Basic'));
    await tester.pumpAndSettle();

    expect(find.text('Set up notification processing'), findsOneWidget);
    expect(find.text('Extractors'), findsNothing);
  });

  testWidgets('shows setup choices before extractors and rules', (
    WidgetTester tester,
  ) async {
    const NotificationRule rule = NotificationRule(
      id: 'existing-rule',
      name: 'Existing rule',
      conditions: <NotificationCondition>[],
      actions: <NotificationAction>[],
    );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationDefinitionDetailsPage(
          definition: const NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            sampleTitle: 'Card payment',
            sampleBody: 'Paid 12 CAD',
            extractors: <RegExpDefinition>[],
            rules: <NotificationRule>[rule],
          ),
          onSave: (NotificationDefinition definition) async => true,
        ),
      ),
    );

    expect(find.text('Set up notification processing'), findsOneWidget);
    expect(
      find.text(
        "Choose how Waterfly reads this app's notifications and turns them into transactions.",
      ),
      findsOneWidget,
    );
    expect(
      find.text(
        'Use built-in extractors and standard transaction mappings. Review uncertain values before creating a transaction.',
      ),
      findsOneWidget,
    );
    expect(
      find.text(
        'Create your own extractors and rules for full control over how notifications become transactions.',
      ),
      findsOneWidget,
    );
    expect(find.text('Extractors'), findsNothing);
    expect(find.text('Rules'), findsNothing);
    expect(find.text('Existing rule'), findsNothing);

    await tester.tap(find.text('Advanced'));
    await tester.pumpAndSettle();

    expect(find.text('Extractors'), findsOneWidget);
    expect(find.text('Amount'), findsOneWidget);
    expect(find.text('4 extractors'), findsNothing);
    expect(
      find.text('Finds a transaction amount in the notification message.'),
      findsOneWidget,
    );
  });

  testWidgets('shows extractor descriptions instead of match counts', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition extractor =
        RegExpDefinition.createCustomRegExpDefinition(
          'Amounts',
          r'(?<amount>\d+)',
          description: 'Finds every amount in the message.',
        );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationDefinitionDetailsPage(
          definition: NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            sampleTitle: 'Card payment',
            sampleBody: 'Paid 12 and 15 CAD',
            extractors: <RegExpDefinition>[extractor],
            rules: const <NotificationRule>[],
            extractorMode: NotificationExtractorMode.advanced,
          ),
          onSave: (NotificationDefinition definition) async => true,
        ),
      ),
    );

    expect(find.text('Finds every amount in the message.'), findsOneWidget);
    expect(find.text('2 matches · 2 groups'), findsNothing);
  });

  testWidgets('does not summarize extractor match and group counts', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition extractor =
        RegExpDefinition.createCustomRegExpDefinition(
          'Currencies',
          r'(?<prefix>[A-Z])?(?<amount>\d)',
        );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationDefinitionDetailsPage(
          definition: NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            sampleTitle: 'Card payment',
            sampleBody: 'A1 2 3',
            extractors: <RegExpDefinition>[extractor],
            rules: const <NotificationRule>[],
            extractorMode: NotificationExtractorMode.advanced,
          ),
          onSave: (NotificationDefinition definition) async => true,
        ),
      ),
    );

    expect(find.text('3 matches · 4 groups'), findsNothing);
  });

  testWidgets('does not summarize predefined extractor groups', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition extractor =
        RegExpDefinition.createPredefinedRegExpDefinition(
          PredefinedRegExpDefinition.notificationDate,
        );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationDefinitionDetailsPage(
          definition: NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            sampleTitle: 'Card payment',
            sampleBody: 'Paid 12 CAD',
            extractors: <RegExpDefinition>[extractor],
            rules: const <NotificationRule>[],
            extractorMode: NotificationExtractorMode.advanced,
          ),
          onSave: (NotificationDefinition definition) async => true,
        ),
      ),
    );

    expect(find.text('1 match · 2 groups'), findsNothing);
  });

  testWidgets('shows the definition delete action in the details header', (
    WidgetTester tester,
  ) async {
    bool wasDeleted = false;
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationDefinitionDetailsPage(
          definition: const NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            extractors: <RegExpDefinition>[],
            rules: <NotificationRule>[],
          ),
          onSave: (NotificationDefinition definition) async => true,
          onDelete: () async {
            wasDeleted = true;
            return true;
          },
        ),
      ),
    );

    await tester.tap(find.byTooltip('Definition options'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(wasDeleted, isTrue);
  });

  testWidgets('shows an error when definition deletion fails', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationDefinitionDetailsPage(
          definition: const NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            extractors: <RegExpDefinition>[],
            rules: <NotificationRule>[],
          ),
          onSave: (NotificationDefinition definition) async => true,
          onDelete: () async => throw StateError('delete failed'),
        ),
      ),
    );

    await tester.tap(find.byTooltip('Definition options'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(
      find.text('The application registration could not be deleted.'),
      findsOneWidget,
    );
  });

  testWidgets('saves a basic definition with standard transaction details', (
    WidgetTester tester,
  ) async {
    NotificationDefinition? savedDefinition;
    const NotificationRule existingRule = NotificationRule(
      id: 'existing-rule',
      name: 'Existing rule',
      conditions: <NotificationCondition>[],
      actions: <NotificationAction>[],
    );
    await tester.pumpAndSettle();
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationDefinitionDetailsPage(
          definition: const NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            extractors: <RegExpDefinition>[],
            rules: <NotificationRule>[existingRule],
          ),
          onSave: (NotificationDefinition definition) async {
            savedDefinition = definition;
            return true;
          },
        ),
      ),
    );
    await tester.pump();
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('sample-notification-title')),
      'Card payment',
    );
    await tester.enterText(
      find.byKey(const Key('sample-notification-body')),
      'Paid 12.50 CAD',
    );
    await tester.pump();
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Basic'));
    await tester.tap(find.text('Basic'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Save definition'));
    await tester.pumpAndSettle();

    expect(savedDefinition?.sampleTitle, 'Card payment');
    expect(savedDefinition?.sampleBody, 'Paid 12.50 CAD');
    expect(savedDefinition?.extractorMode, NotificationExtractorMode.basic);
    expect(savedDefinition?.extractors, hasLength(5));
    expect(
      savedDefinition?.extractors
          .firstWhere(
            (RegExpDefinition extractor) =>
                extractor.predefinedType == PredefinedRegExpDefinition.amount,
          )
          .regExpSource,
      predefinedRegExp,
    );
    expect(savedDefinition?.rules, isEmpty);
    expect(savedDefinition!.sharedActions, hasLength(3));
    expect(
      savedDefinition!.sharedActions.whereType<SetTransactionFieldAction>().map(
        (SetTransactionFieldAction action) => action.target,
      ),
      <TransactionField>[
        TransactionField.amount,
        TransactionField.date,
        TransactionField.time,
      ],
    );
    expect(
      savedDefinition!.transactionCreationMode,
      TransactionCreationMode.prompt,
    );
    expect(find.text('Add rule'), findsNothing);
  });

  // Ensures an extractor can be edited in its dedicated view without changing
  // its ID, which preserves references from rules added in a later workflow.
  testWidgets('updates an advanced extractor through its details page', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition extractor =
        RegExpDefinition.createCustomRegExpDefinition(
          'Payment',
          r'Paid (?<amount>\d+)',
        );
    NotificationDefinition? savedDefinition;
    int saveCount = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationDefinitionDetailsPage(
          definition: NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            sampleTitle: 'Card payment',
            sampleBody: 'Paid 12 CAD',
            extractors: <RegExpDefinition>[extractor],
            rules: const <NotificationRule>[],
            extractorMode: NotificationExtractorMode.advanced,
          ),
          onSave: (NotificationDefinition definition) async {
            saveCount += 1;
            savedDefinition = definition;
            return true;
          },
        ),
      ),
    );

    await tester.tap(find.text('Payment'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('extractor-source')),
      r'CAD (?<amount>\d+)',
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Save'));
    await tester.pumpAndSettle();

    expect(saveCount, 1);
    expect(savedDefinition?.extractors.single.id, extractor.id);
    expect(
      savedDefinition?.extractors.single.regExpSource,
      r'CAD (?<amount>\d+)',
    );
  });

  testWidgets('saves the definition after applying an extractor draft', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition extractor =
        RegExpDefinition.createCustomRegExpDefinition('Payment', r'Paid \d+');
    NotificationDefinition? savedDefinition;
    int saveCount = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationDefinitionDetailsPage(
          definition: NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            sampleTitle: 'Card payment',
            sampleBody: 'Paid 12 CAD',
            extractors: <RegExpDefinition>[extractor],
            rules: const <NotificationRule>[],
            extractorMode: NotificationExtractorMode.advanced,
          ),
          onSave: (NotificationDefinition definition) async {
            saveCount += 1;
            savedDefinition = definition;
            return true;
          },
        ),
      ),
    );

    await tester.tap(find.text('Payment'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('extractor-source')),
      r'CAD \d+',
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Save'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('extractor-source')),
      r'USD \d+',
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Save'));
    await tester.pumpAndSettle();

    expect(find.byTooltip('Save definition'), findsNothing);
    expect(saveCount, 2);
    expect(savedDefinition?.extractors.single.regExpSource, r'USD \d+');
  });

  testWidgets('adds a custom extractor even when its pattern is left empty', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    NotificationDefinition? savedDefinition;
    int saveCount = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationDefinitionDetailsPage(
          definition: const NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            sampleTitle: 'Card payment',
            sampleBody: 'Paid 12 CAD',
            extractors: <RegExpDefinition>[],
            rules: <NotificationRule>[],
            extractorMode: NotificationExtractorMode.advanced,
          ),
          onSave: (NotificationDefinition definition) async {
            saveCount += 1;
            savedDefinition = definition;
            return true;
          },
        ),
      ),
    );

    await tester.tap(find.text('Add extractor'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Regular expression'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, 'Payment');
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, 'Add'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();

    expect(saveCount, 1);
    expect(savedDefinition?.extractors, hasLength(1));
    expect(savedDefinition?.extractors.single.definitionName, 'Payment');
    expect(savedDefinition?.extractors.single.regExpSource, isEmpty);
    expect(find.text('Payment'), findsOneWidget);
    expect(find.byTooltip('Save definition'), findsNothing);
  });

  testWidgets('opens a newly added predefined extractor in its details page', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    NotificationDefinition? savedDefinition;
    int saveCount = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationDefinitionDetailsPage(
          definition: const NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            sampleTitle: 'Card payment',
            sampleBody: 'Paid 12 CAD',
            extractors: <RegExpDefinition>[],
            rules: <NotificationRule>[],
            extractorMode: NotificationExtractorMode.advanced,
          ),
          onSave: (NotificationDefinition definition) async {
            saveCount += 1;
            savedDefinition = definition;
            return true;
          },
        ),
      ),
    );

    await tester.tap(find.text('Add extractor'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Predefined'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Amount'));
    await tester.pumpAndSettle();

    expect(find.byType(NotificationExtractorDetailsPage), findsOneWidget);
    expect(find.text('Amount'), findsWidgets);

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();

    expect(saveCount, 1);
    expect(savedDefinition?.extractors, hasLength(1));
    expect(
      savedDefinition?.extractors.single.predefinedType,
      PredefinedRegExpDefinition.amount,
    );
  });

  testWidgets('discards an invalid extractor draft on exit', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final RegExpDefinition extractor =
        RegExpDefinition.createCustomRegExpDefinition('Payment', r'Paid \d+');
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationDefinitionDetailsPage(
          definition: NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            sampleTitle: 'Card payment',
            sampleBody: 'Paid 12 CAD',
            extractors: <RegExpDefinition>[extractor],
            rules: const <NotificationRule>[],
            extractorMode: NotificationExtractorMode.advanced,
          ),
          onSave: (NotificationDefinition definition) async => true,
        ),
      ),
    );

    await tester.tap(find.text('Payment'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('extractor-source')), '(');
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Discard'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('extractor-source')), findsNothing);
    expect(find.text('Payment'), findsOneWidget);
    expect(find.byTooltip('Save definition'), findsNothing);
  });

  testWidgets('shows missing extractor errors on action cards', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    const NotificationRule rule = NotificationRule(
      id: 'rule',
      name: 'Payment rule',
      conditions: <NotificationCondition>[],
      actions: <NotificationAction>[
        SetTransactionFieldAction(
          target: TransactionField.amount,
          valueSource: RegExpCaptureValueSource(
            extractorId: 'deleted-extractor',
            captureName: 'amount',
          ),
        ),
      ],
    );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationDefinitionDetailsPage(
          definition: const NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            sampleTitle: 'Card payment',
            sampleBody: 'Paid 12 CAD',
            extractors: <RegExpDefinition>[],
            rules: <NotificationRule>[rule],
            extractorMode: NotificationExtractorMode.advanced,
          ),
          onSave: (NotificationDefinition definition) async => true,
        ),
      ),
    );

    await tester.tap(find.text('Payment rule'));
    await tester.pumpAndSettle();

    expect(
      find.text('The extractor used by "amount" was deleted.'),
      findsOneWidget,
    );
    expect(find.byIcon(Icons.cancel_outlined), findsOneWidget);
    expect(
      tester.widget<Icon>(find.byIcon(Icons.cancel_outlined)).color,
      Theme.of(
        tester.element(find.byIcon(Icons.cancel_outlined)),
      ).colorScheme.error,
    );
  });

  testWidgets(
    'blocks definition saving when an action references a deleted extractor',
    (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      int saveCount = 0;
      const NotificationRule rule = NotificationRule(
        id: 'rule',
        name: 'Payment rule',
        conditions: <NotificationCondition>[],
        actions: <NotificationAction>[
          SetTransactionFieldAction(
            target: TransactionField.amount,
            valueSource: RegExpCaptureValueSource(
              extractorId: 'deleted-extractor',
              captureName: 'amount',
            ),
          ),
        ],
      );
      await tester.pumpWidget(
        MaterialApp(
          home: NotificationDefinitionDetailsPage(
            definition: const NotificationDefinition(
              id: 'bank',
              applicationId: 'com.example.bank',
              name: 'Example Bank',
              sampleTitle: 'Card payment',
              sampleBody: 'Paid 12 CAD',
              extractors: <RegExpDefinition>[],
              rules: <NotificationRule>[rule],
              extractorMode: NotificationExtractorMode.advanced,
            ),
            onSave: (NotificationDefinition definition) async {
              saveCount += 1;
              return true;
            },
          ),
        ),
      );

      await tester.tap(find.text('Add rule'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, 'Another rule');
      await tester.pump();
      await tester.tap(find.text('Add'));
      await tester.pumpAndSettle();
      await tester.pageBack();
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Save definition'));
      await tester.pumpAndSettle();

      expect(saveCount, 0);
      expect(
        find.text(
          'Fix the action that references a deleted extractor before saving.',
        ),
        findsOneWidget,
      );
    },
  );

  testWidgets('adds a rule to the definition draft', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    NotificationDefinition? savedDefinition;
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationDefinitionDetailsPage(
          definition: const NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            sampleTitle: 'Card payment',
            sampleBody: 'Paid 12 CAD',
            extractors: <RegExpDefinition>[],
            rules: <NotificationRule>[],
            extractorMode: NotificationExtractorMode.advanced,
          ),
          onSave: (NotificationDefinition definition) async {
            savedDefinition = definition;
            return true;
          },
        ),
      ),
    );

    await tester.tap(find.text('Add rule'));
    await tester.pumpAndSettle();
    expect(find.text('Predefined'), findsNothing);
    expect(find.text('Custom'), findsNothing);
    await tester.enterText(find.byType(TextField).first, 'New rule');
    await tester.enterText(
      find.byType(TextField).last,
      'Handles a specific notification.',
    );
    await tester.pump();
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();
    expect(find.text('Applies when'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('New rule'), findsOneWidget);
    await tester.tap(find.byTooltip('Save definition'));
    await tester.pumpAndSettle();

    expect(savedDefinition?.rules, hasLength(1));
    expect(savedDefinition?.rules.single.name, 'New rule');
    expect(
      savedDefinition?.rules.single.description,
      'Handles a specific notification.',
    );
  });

  testWidgets('cancels rule naming without creating a rule', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final List<RegExpDefinition> extractors = <RegExpDefinition>[
      RegExpDefinition.createPredefinedRegExpDefinition(
        PredefinedRegExpDefinition.notificationTitle,
      ),
      RegExpDefinition.createPredefinedRegExpDefinition(
        PredefinedRegExpDefinition.notificationMessage,
      ),
      RegExpDefinition.createPredefinedRegExpDefinition(
        PredefinedRegExpDefinition.notificationDate,
      ),
      RegExpDefinition.createPredefinedRegExpDefinition(
        PredefinedRegExpDefinition.amount,
      ),
    ];
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationDefinitionDetailsPage(
          definition: NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            sampleTitle: 'Card payment',
            sampleBody: 'Paid 12 CAD',
            extractors: extractors,
            rules: const <NotificationRule>[],
            extractorMode: NotificationExtractorMode.advanced,
          ),
          onSave: (NotificationDefinition definition) async => true,
        ),
      ),
    );

    await tester.scrollUntilVisible(
      find.text('Add rule'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add rule'));
    await tester.pumpAndSettle();
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('Predefined'), findsNothing);
    expect(find.text('Custom'), findsNothing);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.text('No rules defined.'), findsOneWidget);
    final Text noRulesText = tester.widget<Text>(
      find.text('No rules defined.'),
    );
    expect(
      noRulesText.style?.color,
      Theme.of(
        tester.element(find.text('No rules defined.')),
      ).colorScheme.onSurfaceVariant,
    );
    expect(
      extractors.any(
        (RegExpDefinition extractor) =>
            extractor.predefinedType == PredefinedRegExpDefinition.currency,
      ),
      isFalse,
    );
  });

  testWidgets('shows basic mappings and unlocks them in advanced setup', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    NotificationDefinition? savedDefinition;
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationDefinitionDetailsPage(
          definition: const NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            sampleTitle: 'Card payment',
            sampleBody: 'Paid 12 CAD',
            extractors: <RegExpDefinition>[],
            rules: <NotificationRule>[
              NotificationRule(
                id: 'all',
                name: 'Any notification',
                conditions: <NotificationCondition>[],
                actions: <NotificationAction>[],
                isPredefined: true,
              ),
            ],
            extractorMode: NotificationExtractorMode.basic,
          ),
          onSave: (NotificationDefinition definition) async {
            savedDefinition = definition;
            return true;
          },
        ),
      ),
    );

    expect(find.text('Actions'), findsOneWidget);
    await tester.tap(find.text('Set transaction fields'));
    await tester.pumpAndSettle();
    expect(find.text('Set transaction fields'), findsOneWidget);
    expect(find.text('Actions'), findsOneWidget);
    expect(find.text('Shared actions'), findsNothing);
    expect(find.text('When'), findsNothing);
    expect(find.byTooltip('Rule options'), findsNothing);
    expect(find.text('Add action'), findsNothing);

    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Definition options'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Convert to advanced'));
    await tester.pumpAndSettle();
    expect(find.text('Convert to advanced?'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Convert'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Save definition'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Shared transaction fields'),
      200,
    );
    await tester.tap(find.text('Shared transaction fields'));
    await tester.pumpAndSettle();

    expect(find.byTooltip('Rule options'), findsNothing);
    expect(find.text('Add action'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Save definition'));
    await tester.pumpAndSettle();
    expect(savedDefinition?.extractorMode, NotificationExtractorMode.advanced);
    expect(savedDefinition?.sharedActions, isEmpty);
  });

  testWidgets('shows a status card for an incomplete basic mapping', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition amount =
        RegExpDefinition.createCustomRegExpDefinition(
          'Amount',
          r'(?<amount>\d+)',
        );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationDefinitionDetailsPage(
          definition: NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            sampleTitle: 'Card payment',
            sampleBody: 'Paid CAD',
            extractors: <RegExpDefinition>[amount],
            rules: <NotificationRule>[
              NotificationRule(
                id: 'transaction',
                name: 'Transaction details',
                isPredefined: true,
                conditions: const <NotificationCondition>[],
                actions: <NotificationAction>[
                  SetTransactionFieldAction(
                    target: TransactionField.amount,
                    valueSource: RegExpCaptureValueSource(
                      extractorId: amount.id,
                      captureName: 'amount',
                    ),
                  ),
                ],
              ),
            ],
            extractorMode: NotificationExtractorMode.basic,
          ),
          onSave: (NotificationDefinition definition) async => true,
        ),
      ),
    );

    expect(find.text('Needs review'), findsOneWidget);
    expect(
      find.text(
        'Review the suggested transaction field mappings before using this application.',
      ),
      findsOneWidget,
    );
    expect(find.byIcon(Icons.error_outline), findsAtLeastNWidgets(2));
  });

  testWidgets('needs setup message only lists missing rules or shared actions', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationDefinitionDetailsPage(
          definition: NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            sampleTitle: 'Card payment',
            sampleBody: 'Paid 12 CAD',
            extractors: <RegExpDefinition>[
              RegExpDefinition.createPredefinedRegExpDefinition(
                PredefinedRegExpDefinition.amount,
              ),
            ],
            rules: const <NotificationRule>[],
            extractorMode: NotificationExtractorMode.advanced,
          ),
          onSave: (NotificationDefinition definition) async => true,
        ),
      ),
    );

    expect(find.text('Needs setup'), findsOneWidget);
    expect(
      find.text(
        'Finish setting up at least one rule or shared action before this application can process notifications.',
      ),
      findsOneWidget,
    );
    await tester.scrollUntilVisible(
      find.text('Shared transaction fields'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    expect(find.text('No shared fields configured'), findsOneWidget);
    final Finder sharedActionsCard = find.ancestor(
      of: find.text('Shared transaction fields'),
      matching: find.byType(DefinitionDetailCard),
    );
    expect(
      tester.getTopLeft(find.text('No shared fields configured')).dx,
      closeTo(
        tester.getTopLeft(find.text('Shared transaction fields')).dx,
        0.5,
      ),
    );
    final double cardCenter = tester.getRect(sharedActionsCard).center.dy;
    for (final IconData icon in <IconData>[
      Icons.error_outline,
      Icons.chevron_right,
    ]) {
      expect(
        tester
            .getRect(
              find.descendant(
                of: sharedActionsCard,
                matching: find.byIcon(icon),
              ),
            )
            .center
            .dy,
        closeTo(cardCenter, 0.5),
      );
    }
    expect(find.text('No actions'), findsNothing);
    expect(find.textContaining('sample notification'), findsNothing);
    expect(find.textContaining('at least one extractor'), findsNothing);
  });

  testWidgets('highlights empty transaction fields in basic setup', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationDefinitionDetailsPage(
          definition: NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            sampleTitle: 'Card payment',
            sampleBody: 'Paid 12 CAD',
            extractors: <RegExpDefinition>[
              RegExpDefinition.createPredefinedRegExpDefinition(
                PredefinedRegExpDefinition.amount,
              ),
            ],
            rules: const <NotificationRule>[],
            extractorMode: NotificationExtractorMode.basic,
          ),
          onSave: (NotificationDefinition definition) async => true,
        ),
      ),
    );

    expect(find.text('Needs setup'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Set transaction fields'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    expect(find.text('No transaction fields configured'), findsOneWidget);
    expect(find.text('No actions'), findsNothing);
  });

  testWidgets('needs setup message lists every missing setup requirement', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationDefinitionDetailsPage(
          definition: const NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            sampleTitle: 'Card payment',
            sampleBody: '',
            extractors: <RegExpDefinition>[],
            rules: <NotificationRule>[],
            extractorMode: NotificationExtractorMode.advanced,
          ),
          onSave: (NotificationDefinition definition) async => true,
        ),
      ),
    );

    expect(find.text('Needs setup'), findsOneWidget);
    expect(
      find.text(
        'Finish setting up a sample notification, at least one extractor, and at least one rule or shared action before this application can process notifications.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('opens unconditional rule details without special setup', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final List<RegExpDefinition> extractors = <PredefinedRegExpDefinition>[
      PredefinedRegExpDefinition.notificationTitle,
      PredefinedRegExpDefinition.notificationMessage,
      PredefinedRegExpDefinition.notificationDate,
      PredefinedRegExpDefinition.amount,
    ].map(RegExpDefinition.createPredefinedRegExpDefinition).toList();
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationDefinitionDetailsPage(
          definition: NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            sampleTitle: 'Card payment',
            sampleBody: 'Paid 12 CAD',
            extractors: extractors,
            rules: <NotificationRule>[
              const NotificationRule(
                id: 'all',
                name: 'Any notification',
                conditions: <NotificationCondition>[],
                actions: <NotificationAction>[],
              ),
            ],
            extractorMode: NotificationExtractorMode.advanced,
          ),
          onSave: (NotificationDefinition definition) async => true,
        ),
      ),
    );

    await tester.scrollUntilVisible(
      find.text('Any notification'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Any notification'));
    await tester.pumpAndSettle();

    expect(find.byType(NotificationRuleDetailsPage), findsOneWidget);
    expect(find.byTooltip('Enter test mode'), findsOneWidget);
  });

  testWidgets('warns when an unconditional rule shadows later rules', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationDefinitionDetailsPage(
          definition: const NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            sampleTitle: 'Deposit',
            sampleBody: 'Deposit received',
            extractors: <RegExpDefinition>[],
            rules: <NotificationRule>[
              NotificationRule(
                id: 'all',
                name: 'Any notification',
                conditions: <NotificationCondition>[],
                actions: <NotificationAction>[],
              ),
              NotificationRule(
                id: 'deposit',
                name: 'Deposits',
                conditions: <NotificationCondition>[
                  ValueExistsCondition(LiteralValueSource('deposit')),
                ],
                actions: <NotificationAction>[],
              ),
            ],
            extractorMode: NotificationExtractorMode.advanced,
          ),
          onSave: (NotificationDefinition definition) async => true,
        ),
      ),
    );

    await tester.scrollUntilVisible(
      find.text('Always applies · Rules below cannot be reached'),
      200,
      scrollable: find.byType(Scrollable).first,
    );

    expect(
      find.text('Always applies · Rules below cannot be reached'),
      findsOneWidget,
    );
  });

  testWidgets('groups repeated predefined captures as adjustable mappings', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final RegExpDefinition amount =
        RegExpDefinition.createPredefinedRegExpDefinition(
          PredefinedRegExpDefinition.amount,
        );
    final List<NotificationAction> sharedActions = <NotificationAction>[
      const SetTransactionFieldAction(
        target: TransactionField.title,
        valueSource: LiteralValueSource('Card payment'),
      ),
      SetTransactionFieldAction(
        target: TransactionField.amount,
        valueSource: RegExpCaptureValueSource(
          extractorId: amount.id,
          captureName: 'amount',
        ),
      ),
    ];
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationDefinitionDetailsPage(
          definition: NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            sampleTitle: 'Card payment',
            sampleBody: 'Paid 12 CAD and 20 CAD',
            extractors: <RegExpDefinition>[amount],
            rules: const <NotificationRule>[
              NotificationRule(
                id: 'all',
                name: 'Any notification',
                conditions: <NotificationCondition>[],
                actions: <NotificationAction>[],
              ),
            ],
            sharedActions: sharedActions,
            extractorMode: NotificationExtractorMode.basic,
          ),
          onSave: (NotificationDefinition definition) async => true,
        ),
      ),
    );

    Finder sharedActionsCard() => find.ancestor(
      of: find.text('Set transaction fields'),
      matching: find.byType(DefinitionDetailCard),
    );

    expect(
      find.descendant(
        of: sharedActionsCard(),
        matching: find.text('Needs review'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: sharedActionsCard(),
        matching: find.byIcon(Icons.error_outline),
      ),
      findsOneWidget,
    );
    await tester.tap(find.text('Set transaction fields'));
    await tester.pumpAndSettle();

    expect(find.text('Fixed mappings'), findsNothing);
    expect(find.text('Adjustable mappings'), findsOneWidget);
    expect(
      find.text(
        'Review editable mappings and add optional fields before marking the rule complete.',
      ),
      findsOneWidget,
    );
    final DefinitionDetailCard titleMapping = tester
        .widgetList<DefinitionDetailCard>(find.byType(DefinitionDetailCard))
        .singleWhere(
          (DefinitionDetailCard card) =>
              card.title is Text &&
              ((card.title as Text).textSpan?.toPlainText().contains(
                    '"title"',
                  ) ??
                  false),
        );
    expect(titleMapping.onTap, isNull);
    expect(find.byTooltip('Remove optional mapping'), findsOneWidget);
    expect(find.text('Needs review'), findsWidgets);
    await tester.tap(find.byTooltip('Mark mapping as done'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Mark mapping as needing review'), findsOneWidget);
  });

  testWidgets('clears the shared-actions warning after mappings are reviewed', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final RegExpDefinition amount =
        RegExpDefinition.createCustomRegExpDefinition(
          'Amount and currency',
          r'(?<amount>\d+) (?<currency>[A-Z]{3})',
        );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationDefinitionDetailsPage(
          definition: NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            sampleTitle: 'Card payment',
            sampleBody: 'Paid 12 CAD',
            extractors: <RegExpDefinition>[amount],
            rules: const <NotificationRule>[
              NotificationRule(
                id: 'all',
                name: 'Any notification',
                conditions: <NotificationCondition>[],
                actions: <NotificationAction>[],
              ),
            ],
            sharedActions: <NotificationAction>[
              SetTransactionFieldAction(
                target: TransactionField.amount,
                valueSource: RegExpCaptureValueSource(
                  extractorId: amount.id,
                  captureName: 'amount',
                ),
              ),
            ],
            extractorMode: NotificationExtractorMode.basic,
          ),
          onSave: (NotificationDefinition definition) async => true,
        ),
      ),
    );

    Finder sharedActionsCard() => find.ancestor(
      of: find.text('Set transaction fields'),
      matching: find.byType(DefinitionDetailCard),
    );

    expect(
      find.descendant(
        of: sharedActionsCard(),
        matching: find.text('Needs review'),
      ),
      findsOneWidget,
    );
    await tester.tap(find.text('Set transaction fields'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Mark mapping as done'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Save'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();

    expect(
      find.descendant(
        of: sharedActionsCard(),
        matching: find.text('Needs review'),
      ),
      findsNothing,
    );
    expect(
      find.descendant(of: sharedActionsCard(), matching: find.text('1 action')),
      findsOneWidget,
    );
  });

  testWidgets('shows unresolved migrated currency in transaction fields', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final RegExpDefinition currency =
        RegExpDefinition.createPredefinedRegExpDefinition(
          PredefinedRegExpDefinition.currency,
        );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationDefinitionDetailsPage(
          definition: NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            sampleTitle: 'Card payment',
            sampleBody: 'Paid USD 12.50',
            extractors: <RegExpDefinition>[currency],
            rules: const <NotificationRule>[],
            sharedActions: <NotificationAction>[
              SetTransactionFieldAction(
                target: TransactionField.currency,
                valueSource: RegExpCaptureValueSource(
                  extractorId: currency.id,
                  captureName: 'preCurrency',
                  matchIndex: 0,
                ),
              ),
            ],
            extractorMode: NotificationExtractorMode.basic,
          ),
          onSave: (NotificationDefinition definition) async => true,
        ),
      ),
    );

    expect(find.text('Set transaction fields'), findsOneWidget);
    await tester.ensureVisible(find.text('Set transaction fields'));
    await tester.tap(find.text('Set transaction fields'));
    await tester.pumpAndSettle();

    expect(find.text('Choose a matching Firefly currency.'), findsOneWidget);
    expect(find.byIcon(Icons.cancel_outlined), findsNothing);
    final Icon reviewIcon = tester.widget<Icon>(
      find.byIcon(Icons.error_outline).last,
    );
    expect(
      reviewIcon.color,
      Theme.of(
        tester.element(find.byIcon(Icons.error_outline).last),
      ).colorScheme.tertiary,
    );
    expect(find.byTooltip('Edit currency mapping'), findsOneWidget);
  });

  testWidgets('shows migration guidance for an otherwise ready definition', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition title =
        RegExpDefinition.createPredefinedRegExpDefinition(
          PredefinedRegExpDefinition.notificationTitle,
        );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationDefinitionDetailsPage(
          definition: NotificationDefinition(
            id: 'automatic-bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            sampleTitle: 'Payment',
            sampleBody: 'Paid 12.50 CAD',
            extractors: <RegExpDefinition>[title],
            rules: const <NotificationRule>[],
            sharedActions: const <NotificationAction>[
              SetTransactionFieldAction(
                target: TransactionField.title,
                valueSource: LiteralValueSource('Payment'),
              ),
            ],
            reviewedSharedActionFields: const <TransactionField>{
              TransactionField.title,
            },
            extractorMode: NotificationExtractorMode.basic,
          ),
          migrationAlerts: <NotificationAlert>[
            NotificationAlert.failure(
              kind: NotificationAlertKind.migrationNeedsReview,
              operation: 'Reviewing imported notification settings',
              message: 'Automatic creation was changed.',
              migrationIssue:
                  NotificationMigrationIssue.automaticCreationPaused,
            ),
            NotificationAlert.failure(
              kind: NotificationAlertKind.migrationNeedsReview,
              operation: 'Reviewing imported notification settings',
              message: 'An account is required.',
              migrationIssue:
                  NotificationMigrationIssue.missingAutomaticAccount,
            ),
          ],
          onSave: (NotificationDefinition definition) async => true,
        ),
      ),
    );

    expect(
      find.textContaining('Imported setup needs attention'),
      findsOneWidget,
    );
    expect(
      find.textContaining(
        'Transactions will use Prompt mode until you review the imported setup.',
      ),
      findsOneWidget,
    );
    expect(
      find.textContaining(
        'Choose an account before enabling automatic transaction creation.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('adds optional title mappings and disables configured choices', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final List<RegExpDefinition> extractors = <RegExpDefinition>[
      RegExpDefinition.createPredefinedRegExpDefinition(
        PredefinedRegExpDefinition.notificationTitle,
      ),
      RegExpDefinition.createPredefinedRegExpDefinition(
        PredefinedRegExpDefinition.notificationMessage,
      ),
      RegExpDefinition.createPredefinedRegExpDefinition(
        PredefinedRegExpDefinition.notificationDate,
      ),
      RegExpDefinition.createPredefinedRegExpDefinition(
        PredefinedRegExpDefinition.amount,
      ),
      RegExpDefinition.createPredefinedRegExpDefinition(
        PredefinedRegExpDefinition.currency,
      ),
    ];
    final NotificationRule rule = NotificationRule(
      id: 'standard',
      name: 'Transaction details',
      isPredefined: true,
      conditions: const <NotificationCondition>[],
      actions: <NotificationAction>[
        SetTransactionFieldAction(
          target: TransactionField.amount,
          valueSource: RegExpCaptureValueSource(
            extractorId: extractors[3].id,
            captureName: 'amount',
          ),
        ),
      ],
    );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: rule,
          extractors: extractors,
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12 CAD',
            receivedAt: DateTime(2026, 9, 7),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Add optional field'));
    await tester.pumpAndSettle();
    expect(find.text('Cancel'), findsOneWidget);
    expect(find.text('Currency'), findsOneWidget);
    expect(find.text('Title'), findsOneWidget);
    expect(find.text('Notes'), findsOneWidget);

    await tester.tap(find.text('Title'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Set field "title"'), findsOneWidget);

    await tester.tap(find.text('Add optional field'));
    await tester.pumpAndSettle();
    expect(find.text('Already added.'), findsOneWidget);
  });

  testWidgets('sets automatic transaction creation from Options', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(400, 600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    NotificationDefinition? savedDefinition;
    const NotificationRule rule = NotificationRule(
      id: 'standard',
      name: 'Transaction details',
      isPredefined: true,
      conditions: <NotificationCondition>[],
      actions: <NotificationAction>[],
    );
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NotificationDefinitionDetailsPage(
            definition: const NotificationDefinition(
              id: 'bank',
              applicationId: 'com.example.bank',
              name: 'Example Bank',
              sampleTitle: 'Card payment',
              sampleBody: 'Paid 12 CAD',
              extractors: <RegExpDefinition>[],
              rules: <NotificationRule>[rule],
              extractorMode: NotificationExtractorMode.basic,
            ),
            onSave: (NotificationDefinition definition) async {
              savedDefinition = definition;
              return true;
            },
          ),
          bottomNavigationBar: NavigationBar(
            destinations: const <NavigationDestination>[
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.settings_outlined),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );

    await tester.scrollUntilVisible(
      find.text('Create transaction automatically'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    final Finder automaticOption = find.ancestor(
      of: find.text('Create transaction automatically'),
      matching: find.byType(DefinitionDetailCard),
    );
    await tester.ensureVisible(automaticOption);
    await tester.pumpAndSettle();
    final ScrollPosition position = tester
        .state<ScrollableState>(find.byType(Scrollable).first)
        .position;
    final double offsetBeforeToggle = position.pixels;
    await tester.tap(automaticOption);
    await tester.pump();
    expect(position.pixels, closeTo(offsetBeforeToggle, 0.5));
    await tester.pumpAndSettle();
    expect(find.text('Automatic creation is incomplete'), findsOneWidget);
    final Finder automaticWarning = find.ancestor(
      of: find.text('Automatic creation is incomplete'),
      matching: find.byType(MessageStatusCard),
    );
    final Rect warningRect = tester.getRect(automaticWarning);
    final Rect saveButtonRect = tester.getRect(
      find.byType(FloatingActionButton),
    );
    expect(warningRect.bottom, lessThanOrEqualTo(saveButtonRect.top - 12));
    await tester.ensureVisible(automaticOption);
    await tester.pumpAndSettle();
    await tester.tap(automaticOption);
    await tester.pumpAndSettle();
    expect(find.text('Automatic creation is incomplete'), findsNothing);

    await tester.ensureVisible(automaticOption);
    await tester.pumpAndSettle();
    await tester.tap(automaticOption);
    await tester.pumpAndSettle();
    expect(automaticWarning, findsOneWidget);
    await tester.tap(find.byTooltip('Save definition'));
    await tester.pumpAndSettle();

    expect(
      savedDefinition!.transactionCreationMode,
      TransactionCreationMode.automatic,
    );
  });

  testWidgets(
    'shows incomplete automatic shared-path warnings through the editor',
    (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(
        MaterialApp(
          home: NotificationDefinitionDetailsPage(
            definition: const NotificationDefinition(
              id: 'bank',
              applicationId: 'com.example.bank',
              name: 'Example Bank',
              sampleTitle: 'Card payment',
              sampleBody: 'Paid 12 CAD',
              extractors: <RegExpDefinition>[],
              rules: <NotificationRule>[
                NotificationRule(
                  id: 'standard',
                  name: 'Transaction details',
                  isPredefined: true,
                  conditions: <NotificationCondition>[],
                  actions: <NotificationAction>[],
                ),
              ],
              extractorMode: NotificationExtractorMode.basic,
            ),
            onSave: (NotificationDefinition definition) async => true,
          ),
        ),
      );

      await tester.ensureVisible(find.byType(Checkbox));
      await tester.tap(find.byType(Checkbox));
      await tester.binding.setSurfaceSize(const Size(800, 500));
      await tester.pumpAndSettle();

      final Finder warning = find.text('Automatic creation is incomplete');
      await tester.scrollUntilVisible(
        warning,
        200,
        scrollable: find.byType(Scrollable).first,
      );
      expect(warning, findsOneWidget);
      expect(
        find.textContaining(
          'Automatic processing is disabled until shared actions provide',
        ),
        findsWidgets,
      );

      await tester.ensureVisible(find.text('Set transaction fields'));
      await tester.tap(find.text('Set transaction fields'));
      await tester.pumpAndSettle();

      expect(find.text('Automatic creation is incomplete'), findsOneWidget);
      expect(
        find.textContaining(
          'title, positive amount, source or destination account',
        ),
        findsOneWidget,
      );
    },
  );

  testWidgets('requires review again when a Basic sample changes', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    NotificationDefinition? savedDefinition;
    final RegExpDefinition amount =
        RegExpDefinition.createCustomRegExpDefinition(
          'Amount',
          r'(?<amount>\d+)',
        );
    final NotificationRule rule = NotificationRule(
      id: 'standard',
      name: 'Transaction details',
      isPredefined: true,
      reviewedPredefinedFields: <TransactionField>{TransactionField.amount},
      conditions: const <NotificationCondition>[],
      actions: <NotificationAction>[
        SetTransactionFieldAction(
          target: TransactionField.amount,
          valueSource: RegExpCaptureValueSource(
            extractorId: amount.id,
            captureName: 'amount',
          ),
        ),
      ],
    );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationDefinitionDetailsPage(
          definition: NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            sampleTitle: 'Card payment',
            sampleBody: 'Paid 12 CAD',
            extractors: <RegExpDefinition>[amount],
            rules: <NotificationRule>[rule],
            extractorMode: NotificationExtractorMode.basic,
          ),
          onSave: (NotificationDefinition definition) async {
            savedDefinition = definition;
            return true;
          },
        ),
      ),
    );

    expect(find.text('Needs review'), findsNothing);
    await tester.scrollUntilVisible(
      find.byTooltip('Edit sample notification'),
      100,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.byTooltip('Edit sample notification'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('sample-notification-body')),
      'Paid 25 CAD and 35 CAD',
    );
    await tester.tap(find.text('Apply'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Save definition'));
    await tester.pumpAndSettle();
    expect(savedDefinition?.rules.single.reviewedPredefinedFields, isEmpty);
  });

  testWidgets('updates a rule through its details page', (
    WidgetTester tester,
  ) async {
    NotificationDefinition? savedDefinition;
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    const NotificationRule rule = NotificationRule(
      id: 'rule',
      name: 'Payment rule',
      conditions: <NotificationCondition>[],
      actions: <NotificationAction>[],
    );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationDefinitionDetailsPage(
          definition: const NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            sampleTitle: 'Card payment',
            sampleBody: 'Paid 12 CAD',
            extractors: <RegExpDefinition>[],
            rules: <NotificationRule>[rule],
            extractorMode: NotificationExtractorMode.advanced,
          ),
          onSave: (NotificationDefinition definition) async {
            savedDefinition = definition;
            return true;
          },
        ),
      ),
    );

    await tester.tap(find.text('Payment rule'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Rule options'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Edit details'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byWidgetPredicate(
        (Widget widget) =>
            widget is TextField && widget.decoration?.labelText == 'Rule name',
      ),
      'Updated rule',
    );
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Save'));
    await tester.pumpAndSettle();

    expect(savedDefinition?.rules.single.id, rule.id);
    expect(savedDefinition?.rules.single.name, 'Updated rule');
  });

  testWidgets('does not autosave a rule when definition options are unsaved', (
    WidgetTester tester,
  ) async {
    int saveCount = 0;
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationDefinitionDetailsPage(
          definition: const NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            sampleTitle: 'Card payment',
            sampleBody: 'Paid 12 CAD',
            extractors: <RegExpDefinition>[],
            rules: <NotificationRule>[
              NotificationRule(
                id: 'rule',
                name: 'Payment rule',
                conditions: <NotificationCondition>[],
                actions: <NotificationAction>[],
              ),
            ],
            extractorMode: NotificationExtractorMode.advanced,
          ),
          onSave: (NotificationDefinition definition) async {
            saveCount += 1;
            return true;
          },
        ),
      ),
    );

    await tester.scrollUntilVisible(find.byType(Checkbox), 400);
    await tester.ensureVisible(find.byType(Checkbox));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Payment rule'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Rule options'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Edit details'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byWidgetPredicate(
        (Widget widget) =>
            widget is TextField && widget.decoration?.labelText == 'Rule name',
      ),
      'Updated rule',
    );
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Save'));
    await tester.pumpAndSettle();

    expect(saveCount, 0);
    expect(find.text('Updated rule'), findsOneWidget);
    expect(find.byTooltip('Save'), findsNothing);
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Save definition'), findsOneWidget);
  });

  testWidgets('adds a validated amount action through the field picker', (
    WidgetTester tester,
  ) async {
    NotificationDefinition? savedDefinition;
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    const NotificationRule rule = NotificationRule(
      id: 'rule',
      name: 'Payment rule',
      conditions: <NotificationCondition>[],
      actions: <NotificationAction>[],
    );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationDefinitionDetailsPage(
          definition: const NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            sampleTitle: 'Card payment',
            sampleBody: 'Paid 12 CAD',
            extractors: <RegExpDefinition>[],
            rules: <NotificationRule>[rule],
            extractorMode: NotificationExtractorMode.advanced,
          ),
          onSave: (NotificationDefinition definition) async {
            savedDefinition = definition;
            return true;
          },
        ),
      ),
    );

    await tester.tap(find.text('Payment rule'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add action'));
    await tester.pumpAndSettle();
    expect(find.text('Add action'), findsWidgets);
    expect(find.text('Set transaction field'), findsNothing);
    final ListView fieldList = tester.widget<ListView>(
      find.descendant(
        of: find.byType(ActionFieldStep),
        matching: find.byType(ListView),
      ),
    );
    final SliverChildListDelegate fieldDelegate =
        fieldList.childrenDelegate as SliverChildListDelegate;
    final List<String?> fieldLabels = fieldDelegate.children
        .cast<DialogSelectorCard>()
        .map((DialogSelectorCard card) => (card.title as Text).data)
        .toList();
    expect(fieldLabels, <String>[
      'Amount',
      'Category',
      'Currency',
      'Date',
      'Destination account',
      'Notes',
      'Piggy bank',
      'Source account',
      'Subscription',
      'Tags',
      'Time',
      'Title',
    ]);
    expect(find.text('Amount'), findsOneWidget);
    await tester.tap(find.text('Amount'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Literal value'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('action-literal-value')),
      '12.50',
    );
    await tester.pump();
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Save'));
    await tester.pumpAndSettle();

    final SetTransactionFieldAction action =
        savedDefinition!.rules.single.actions.single
            as SetTransactionFieldAction;
    expect(action.target.name, 'amount');
    expect((action.valueSource as LiteralValueSource).value, '12.50');
  });

  testWidgets('does not offer a title capture for an amount action', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final RegExpDefinition title =
        RegExpDefinition.createPredefinedRegExpDefinition(
          PredefinedRegExpDefinition.notificationTitle,
        );
    final RegExpDefinition amount =
        RegExpDefinition.createPredefinedRegExpDefinition(
          PredefinedRegExpDefinition.amount,
        );
    const NotificationRule rule = NotificationRule(
      id: 'rule',
      name: 'Payment rule',
      conditions: <NotificationCondition>[],
      actions: <NotificationAction>[],
    );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationDefinitionDetailsPage(
          definition: NotificationDefinition(
            id: 'bank',
            applicationId: 'com.example.bank',
            name: 'Example Bank',
            sampleTitle: 'Card payment',
            sampleBody: 'Paid 12 CAD',
            extractors: <RegExpDefinition>[title, amount],
            rules: const <NotificationRule>[rule],
            extractorMode: NotificationExtractorMode.advanced,
          ),
          onSave: (NotificationDefinition definition) async => true,
        ),
      ),
    );

    await tester.tap(find.text('Payment rule'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add action'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Amount'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Extractor capture'));
    await tester.pumpAndSettle();

    expect(find.text('Notification title: title'), findsNothing);
    expect(find.text('Amount'), findsOneWidget);
    expect(richText('Resolved value: "12"'), findsOneWidget);
  });

  testWidgets(
    'offers an ISO date from a custom capture regardless of its name',
    (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final RegExpDefinition customDate =
          RegExpDefinition.createCustomRegExpDefinition(
            'Payment details',
            r'Paid on (\d{4}-\d{2}-\d{2})',
          );
      const NotificationRule rule = NotificationRule(
        id: 'rule',
        name: 'Payment rule',
        conditions: <NotificationCondition>[],
        actions: <NotificationAction>[],
      );
      await tester.pumpWidget(
        MaterialApp(
          home: NotificationDefinitionDetailsPage(
            definition: NotificationDefinition(
              id: 'bank',
              applicationId: 'com.example.bank',
              name: 'Example Bank',
              sampleTitle: 'Card payment',
              sampleBody: 'Paid on 2026-08-31',
              extractors: <RegExpDefinition>[customDate],
              rules: const <NotificationRule>[rule],
              extractorMode: NotificationExtractorMode.advanced,
            ),
            onSave: (NotificationDefinition definition) async => true,
          ),
        ),
      );

      await tester.tap(find.text('Payment rule'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Add action'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Date'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Extractor capture'));
      await tester.pumpAndSettle();

      expect(find.text('Payment details'), findsOneWidget);
      expect(richText('Resolved value: "2026-08-31"'), findsOneWidget);
      await tester.tap(find.text('Payment details'));
      await tester.pumpAndSettle();
      expect(find.text('Normalize extracted date'), findsNothing);
      expect(
        richText('Set field "date" from extractor "Payment details"'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'offers the notification date and time extractor for a time action',
    (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final RegExpDefinition notificationDate =
          RegExpDefinition.createPredefinedRegExpDefinition(
            PredefinedRegExpDefinition.notificationDate,
          );
      const NotificationRule rule = NotificationRule(
        id: 'rule',
        name: 'Payment rule',
        conditions: <NotificationCondition>[],
        actions: <NotificationAction>[],
      );
      await tester.pumpWidget(
        MaterialApp(
          home: NotificationDefinitionDetailsPage(
            definition: NotificationDefinition(
              id: 'bank',
              applicationId: 'com.example.bank',
              name: 'Example Bank',
              sampleTitle: 'Card payment',
              sampleBody: 'Paid 12 CAD',
              extractors: <RegExpDefinition>[notificationDate],
              rules: const <NotificationRule>[rule],
              extractorMode: NotificationExtractorMode.advanced,
            ),
            onSave: (NotificationDefinition definition) async => true,
          ),
        ),
      );

      await tester.tap(find.text('Payment rule'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Add action'));
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.text('Time'),
        200,
        scrollable: find.descendant(
          of: find.byKey(const ValueKey<String>('fields')),
          matching: find.byType(Scrollable),
        ),
      );
      await tester.tap(find.text('Time'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Extractor capture'));
      await tester.pumpAndSettle();

      expect(find.text('Notification date and time'), findsOneWidget);
      expect(find.textContaining('Resolved value: '), findsOneWidget);
      await tester.tap(find.text('Notification date and time'));
      await tester.pumpAndSettle();
      expect(find.text('Normalize extracted time'), findsNothing);
      expect(
        richText(
          'Set field "time" from extractor "Notification date and time"',
        ),
        findsOneWidget,
      );
    },
  );
}
