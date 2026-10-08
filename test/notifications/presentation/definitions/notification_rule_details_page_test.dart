import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart' hide MaterialApp;
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:material_ui/material_ui.dart' as material_ui;
import 'package:provider/provider.dart';
import 'package:waterflyiii/notifications/application/resources/firefly_resource_label_resolver.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_tags_action.dart';
import 'package:waterflyiii/notifications/domain/conditions/all_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/any_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/not_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/value_contains_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/value_exists_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/values_equal_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/values_greater_than_condition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_sample.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_action_group.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/currency_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/date_time_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/firefly_resource_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/literal_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/notification_property_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';
import 'package:waterflyiii/notifications/presentation/shared/dialog_expander_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/definition_expandable_detail_card.dart';
import 'package:waterflyiii/notifications/presentation/rules/pages/notification_rule_details_page.dart';
import 'package:waterflyiii/notifications/presentation/shared/message_status_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_date_time_formatter.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_menu_theme.dart';

class _LabelGateway implements FireflyResourceLabelGateway {
  @override
  Future<String> loadLabel(FireflyResourceKind kind, String id) async =>
      kind == FireflyResourceKind.currency && id == '10'
      ? 'Canadian dollar'
      : '${kind.name} $id';
}

class MaterialApp extends material_ui.MaterialApp {
  const MaterialApp({super.key, required super.home})
    : super(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
      );
}

void main() {
  Finder richText(String text) => find.byWidgetPredicate(
    (Widget widget) =>
        widget is Text && widget.textSpan?.toPlainText().trimRight() == text,
    description: 'rich text "$text"',
  );

  Finder conditionTitle(String text) => richText(text);

  Future<void> openRuleForTransfer(WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) => ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      NotificationRuleDetailsPage(
                        rule: const NotificationRule(
                          id: 'rule',
                          name: 'Card payment',
                          conditions: <NotificationCondition>[
                            ValueExistsCondition(
                              LiteralValueSource('merchant'),
                            ),
                            AllCondition(<NotificationCondition>[]),
                          ],
                          actions: <NotificationAction>[],
                        ),
                        extractors: const <RegExpDefinition>[],
                        notificationContext: NotificationContext(
                          title: 'Card payment',
                          body: 'Paid 12 CAD',
                          receivedAt: DateTime(2026, 9, 7),
                        ),
                      ),
                ),
              ),
              child: const Text('Open rule'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open rule'));
    await tester.pumpAndSettle();
  }

  testWidgets('keeps a pending copy when back navigation is declined', (
    WidgetTester tester,
  ) async {
    await openRuleForTransfer(tester);
    await tester.tap(find.byTooltip('Condition options').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Copy'));
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.text('Leave while copying a condition?'), findsOneWidget);
    expect(
      find.text("The copy hasn't been pasted. Leaving will cancel it."),
      findsOneWidget,
    );
    await tester.tap(find.text('Stay here'));
    await tester.pumpAndSettle();
    expect(find.text('Card payment'), findsWidgets);
    expect(find.byKey(const Key('condition-copy-snackbar')), findsOneWidget);
    expect(find.byKey(const Key('condition-root-paste')), findsOneWidget);

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.text('Leave while copying a condition?'), findsOneWidget);
    await tester.tap(find.text('Leave page'));
    await tester.pumpAndSettle();
    expect(find.text('Open rule'), findsOneWidget);
    expect(find.byKey(const Key('condition-copy-snackbar')), findsNothing);
  });

  testWidgets('confirms moving away and discarding unsaved changes together', (
    WidgetTester tester,
  ) async {
    await openRuleForTransfer(tester);
    await tester.tap(find.byTooltip('Condition options').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Duplicate'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Condition options').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Move'));
    await tester.pumpAndSettle();
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    expect(find.text('Leave while moving a condition?'), findsOneWidget);
    expect(
      find.text(
        "The condition hasn't been moved. Leaving will cancel the move and discard your unsaved changes.",
      ),
      findsOneWidget,
    );
    expect(find.text('Discard changes?'), findsNothing);
    await tester.tap(find.text('Stay here'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('condition-move-snackbar')), findsOneWidget);

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Leave page'));
    await tester.pumpAndSettle();
    expect(find.text('Open rule'), findsOneWidget);
    expect(find.text('Discard changes?'), findsNothing);
  });

  testWidgets('canceling a pending copy restores the unsaved-changes guard', (
    WidgetTester tester,
  ) async {
    await openRuleForTransfer(tester);
    await tester.tap(find.byTooltip('Condition options').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Duplicate'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Condition options').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Copy'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(
      find.text(
        "The copy hasn't been pasted. Leaving will cancel it and discard your unsaved changes.",
      ),
      findsOneWidget,
    );
    await tester.tap(find.text('Stay here'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();

    expect(find.text('Discard changes?'), findsOneWidget);
    expect(find.text('Leave while copying a condition?'), findsNothing);
  });

  testWidgets('guards a pending copy in conditional action details', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Deposits',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
            conditionalActionGroups: <NotificationActionGroup>[
              NotificationActionGroup(
                id: 'salary',
                name: 'Salary source',
                conditions: <NotificationCondition>[
                  ValueExistsCondition(LiteralValueSource('salary')),
                ],
                actions: <NotificationAction>[],
              ),
            ],
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Deposit received',
            body: 'Salary deposit received',
            receivedAt: DateTime(2026, 9, 24),
          ),
        ),
      ),
    );
    await tester.scrollUntilVisible(
      find.text('Salary source'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Salary source').first);
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Condition options'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Copy'));
    await tester.pumpAndSettle();
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    expect(find.text('Leave while copying a condition?'), findsOneWidget);
    await tester.tap(find.text('Stay here'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('condition-copy-snackbar')), findsOneWidget);
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Leave page'));
    await tester.pumpAndSettle();
    expect(find.text('Salary source'), findsOneWidget);
    expect(find.byKey(const Key('condition-copy-snackbar')), findsNothing);
  });

  testWidgets('shows the mapped currency name in resolved transaction fields', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition extractor =
        RegExpDefinition.createCustomRegExpDefinition(
          'Currency',
          r'(?<currency>CAD)',
        );
    final FireflyResourceLabelResolver labels = FireflyResourceLabelResolver(
      _LabelGateway(),
    );
    await tester.pumpWidget(
      Provider<FireflyResourceLabelResolver>.value(
        value: labels,
        child: MaterialApp(
          home: NotificationRuleDetailsPage(
            rule: NotificationRule(
              id: 'rule',
              name: 'Card payment',
              conditions: const <NotificationCondition>[],
              actions: <NotificationAction>[
                SetTransactionFieldAction(
                  target: TransactionField.currency,
                  valueSource: CurrencyCaptureValueSource(
                    capture: RegExpCaptureValueSource(
                      extractorId: extractor.id,
                      captureName: 'currency',
                    ),
                    resourceId: '10',
                  ),
                ),
              ],
            ),
            extractors: <RegExpDefinition>[extractor],
            notificationContext: NotificationContext(
              title: 'Card payment',
              body: 'Paid 10 CAD',
              receivedAt: DateTime(2026, 9, 7),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Resolved transaction fields'),
      200,
    );
    await tester.pumpAndSettle();

    expect(find.text('Resolved transaction fields'), findsOneWidget);
    expect(find.text('Canadian dollar'), findsWidgets);
    expect(find.text('10'), findsNothing);
  });

  testWidgets('shows a draft rule action without shared actions', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'draft',
            name: 'Draft rule',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[
              SetTransactionFieldAction(
                target: TransactionField.destinationAccount,
                valueSource: LiteralValueSource('Checking'),
              ),
            ],
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12 CAD',
            receivedAt: DateTime(2026, 9, 7),
          ),
        ),
      ),
    );

    await tester.scrollUntilVisible(find.text('Checking'), 200);

    expect(find.text('Checking'), findsOneWidget);
    expect(
      find.text('No transaction fields resolve from this rule.'),
      findsNothing,
    );
  });

  testWidgets('combines shared and draft rule actions in the preview', (
    WidgetTester tester,
  ) async {
    const List<NotificationAction> sharedActions = <NotificationAction>[
      SetTransactionFieldAction(
        target: TransactionField.sourceAccount,
        valueSource: LiteralValueSource('Wallet'),
      ),
    ];
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'draft',
            name: 'Draft rule',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[
              SetTransactionFieldAction(
                target: TransactionField.destinationAccount,
                valueSource: LiteralValueSource('Checking'),
              ),
            ],
          ),
          sharedActions: sharedActions,
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12 CAD',
            receivedAt: DateTime(2026, 9, 7),
          ),
        ),
      ),
    );

    await tester.scrollUntilVisible(find.text('Checking'), 200);

    expect(find.text('Wallet'), findsOneWidget);
    expect(find.text('Checking'), findsOneWidget);
    expect(find.text('Transaction summary'), findsNothing);
    expect(find.text('Accounts'), findsOneWidget);
    expect(find.textContaining('Shared actions'), findsOneWidget);
    expect(find.text('Set by: This rule'), findsOneWidget);
    final Divider previewDivider = tester.widget<Divider>(
      find.byType(Divider).first,
    );
    expect(
      previewDivider.color,
      Theme.of(
        tester.element(find.byType(Divider).first),
      ).colorScheme.outlineVariant,
    );
  });

  testWidgets('shows when a rule field overrides a shared field', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'custom',
            name: 'Custom time',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[
              SetTransactionFieldAction(
                target: TransactionField.time,
                valueSource: LiteralValueSource('09:30'),
              ),
            ],
          ),
          sharedActions: const <NotificationAction>[
            SetTransactionFieldAction(
              target: TransactionField.time,
              valueSource: LiteralValueSource('08:00'),
            ),
          ],
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Deposit received',
            body: 'Deposit received',
            receivedAt: DateTime(2026, 9, 24, 9, 30),
          ),
        ),
      ),
    );

    await tester.scrollUntilVisible(
      find.text('Overrides: Shared actions'),
      200,
      scrollable: find.byType(Scrollable).first,
    );

    expect(find.text('Set by: This rule'), findsOneWidget);
    expect(find.text('Overrides: Shared actions'), findsOneWidget);
  });

  testWidgets('previews a matching conditional action group override', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'deposit',
            name: 'Deposits',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[
              SetTransactionFieldAction(
                target: TransactionField.sourceAccount,
                valueSource: LiteralValueSource('Fallback account'),
              ),
            ],
            conditionalActionGroups: <NotificationActionGroup>[
              NotificationActionGroup(
                id: 'salary',
                name: 'Salary source',
                conditions: <NotificationCondition>[
                  ValueContainsCondition(
                    value: NotificationPropertyValueSource(
                      NotificationProperty.body,
                    ),
                    substring: LiteralValueSource('deposit'),
                  ),
                ],
                actions: <NotificationAction>[
                  SetTransactionFieldAction(
                    target: TransactionField.sourceAccount,
                    valueSource: LiteralValueSource('Employer'),
                  ),
                ],
              ),
            ],
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Deposit received',
            body: 'Salary deposit received',
            receivedAt: DateTime(2026, 9, 24),
          ),
        ),
      ),
    );

    await tester.scrollUntilVisible(
      find.text('Set by: Salary source'),
      200,
      scrollable: find.byType(Scrollable).first,
    );

    expect(find.text('Employer'), findsOneWidget);
    expect(find.text('Fallback account'), findsNothing);
    expect(find.text('Set by: Salary source'), findsOneWidget);
    expect(find.text('Overrides: This rule'), findsOneWidget);
    expect(find.byIcon(Icons.receipt_long_outlined), findsNothing);
  });

  testWidgets('shows fields resolved by a matching conditional action', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'deposit',
            name: 'Deposits',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
            conditionalActionGroups: <NotificationActionGroup>[
              NotificationActionGroup(
                id: 'salary',
                name: 'Salary source',
                conditions: <NotificationCondition>[
                  ValueContainsCondition(
                    value: NotificationPropertyValueSource(
                      NotificationProperty.body,
                    ),
                    substring: LiteralValueSource('salary'),
                  ),
                ],
                actions: <NotificationAction>[
                  SetTransactionFieldAction(
                    target: TransactionField.sourceAccount,
                    valueSource: LiteralValueSource('Employer'),
                  ),
                ],
              ),
            ],
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Deposit received',
            body: 'Salary deposit received',
            receivedAt: DateTime(2026, 9, 24),
          ),
        ),
      ),
    );

    await tester.scrollUntilVisible(
      find.text('Salary source'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Salary source').first);
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text(
        'Shows the transaction fields this conditional action resolves from '
        'the current sample.',
      ),
      200,
      scrollable: find.byType(Scrollable).first,
    );

    expect(find.text('Resolved transaction fields'), findsOneWidget);
    expect(find.text('Employer'), findsOneWidget);
  });

  testWidgets(
    'hides resolved fields when the conditional action does not match',
    (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(
        MaterialApp(
          home: NotificationRuleDetailsPage(
            rule: const NotificationRule(
              id: 'deposit',
              name: 'Deposits',
              conditions: <NotificationCondition>[],
              actions: <NotificationAction>[],
              conditionalActionGroups: <NotificationActionGroup>[
                NotificationActionGroup(
                  id: 'bonus',
                  name: 'Bonus source',
                  conditions: <NotificationCondition>[
                    ValueContainsCondition(
                      value: NotificationPropertyValueSource(
                        NotificationProperty.body,
                      ),
                      substring: LiteralValueSource('bonus'),
                    ),
                  ],
                  actions: <NotificationAction>[
                    SetTransactionFieldAction(
                      target: TransactionField.sourceAccount,
                      valueSource: LiteralValueSource('Employer'),
                    ),
                  ],
                ),
              ],
            ),
            extractors: const <RegExpDefinition>[],
            notificationContext: NotificationContext(
              title: 'Deposit received',
              body: 'Salary deposit received',
              receivedAt: DateTime(2026, 9, 24),
            ),
          ),
        ),
      );

      await tester.scrollUntilVisible(
        find.text('Bonus source'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.text('Bonus source').first);
      await tester.pumpAndSettle();

      expect(find.text('Resolved transaction fields'), findsNothing);
    },
  );

  testWidgets('names and saves an empty new conditional action', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Deposits',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[
              SetTransactionFieldAction(
                target: TransactionField.title,
                valueSource: LiteralValueSource('Deposit'),
              ),
            ],
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Deposit received',
            body: 'Salary deposit received',
            receivedAt: DateTime(2026, 9, 24),
          ),
        ),
      ),
    );

    await tester.scrollUntilVisible(
      find.text('Add conditional action'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Add conditional action'));
    await tester.pumpAndSettle();

    expect(
      find.text('Give this conditional action a clear name.'),
      findsOneWidget,
    );
    expect(
      tester
          .widget<FilledButton>(find.widgetWithText(FilledButton, 'Add'))
          .onPressed,
      isNull,
    );
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.text('No conditional actions'), findsOneWidget);

    await tester.tap(find.text('Add conditional action'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Salary source');
    await tester.pump();
    expect(
      tester
          .widget<FilledButton>(find.widgetWithText(FilledButton, 'Add'))
          .onPressed,
      isNotNull,
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Add'));
    await tester.pumpAndSettle();

    expect(find.text('Salary source'), findsWidgets);
    expect(find.text('Sample notification'), findsOneWidget);
    expect(
      find.text(
        'Fine-tune the sample for this conditional action while keeping the rule sample available to the rest of the rule.',
      ),
      findsOneWidget,
    );
    expect(find.text('Deposit received'), findsOneWidget);
    expect(find.text('Salary deposit received'), findsOneWidget);
    expect(find.text('Needs review'), findsOneWidget);
    expect(find.byIcon(Icons.error_outline), findsWidgets);
    expect(
      find.text(
        'Add at least one condition so this conditional action only runs when it should.',
      ),
      findsOneWidget,
    );
    expect(
      find.text('No conditions defined. This conditional action will not run.'),
      findsOneWidget,
    );
    expect(
      find.text(
        'No actions defined. This conditional action will not change the transaction.',
      ),
      findsOneWidget,
    );
    final TextStyle? conditionsEmptyStyle = tester
        .widget<Text>(
          find
              .text(
                'No conditions defined. This conditional action will not run.',
              )
              .last,
        )
        .style;
    final TextStyle? actionsEmptyStyle = tester
        .widget<Text>(
          find
              .text(
                'No actions defined. This conditional action will not change the transaction.',
              )
              .last,
        )
        .style;
    expect(actionsEmptyStyle, conditionsEmptyStyle);
    expect(
      tester
          .widget<FloatingActionButton>(find.byType(FloatingActionButton))
          .onPressed,
      isNotNull,
    );
    await tester.tap(find.byTooltip('Save'));
    await tester.pumpAndSettle();
    expect(find.text('Salary source'), findsOneWidget);
    expect(find.byTooltip('Save'), findsNothing);
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    await tester.fling(
      find.byType(Scrollable).first,
      const Offset(0, 1000),
      5000,
    );
    await tester.pumpAndSettle();
    expect(find.text('Needs review'), findsWidgets);
    expect(find.byIcon(Icons.warning_amber_outlined), findsNothing);
    expect(
      find.text(
        'Review conditional actions marked Needs review and any suggested field mappings before using this rule.',
      ),
      findsOneWidget,
    );
    expect(find.text('Ready'), findsNothing);
  });

  testWidgets('deletes a conditional action group from its editor', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Deposits',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
            conditionalActionGroups: <NotificationActionGroup>[
              NotificationActionGroup(
                id: 'salary',
                name: 'Salary source',
                conditions: <NotificationCondition>[
                  ValueExistsCondition(LiteralValueSource('salary')),
                ],
                actions: <NotificationAction>[
                  SetTransactionFieldAction(
                    target: TransactionField.sourceAccount,
                    valueSource: LiteralValueSource('Employer'),
                  ),
                ],
              ),
            ],
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Deposit received',
            body: 'Salary deposit received',
            receivedAt: DateTime(2026, 9, 24),
          ),
        ),
      ),
    );

    await tester.scrollUntilVisible(
      find.text('Salary source'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Salary source').first);
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Rule options'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(find.text('Salary source'), findsNothing);
    expect(find.text('No conditional actions'), findsOneWidget);
  });

  testWidgets(
    'conditional action details only show extractors used by the group',
    (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final RegExpDefinition sharedExtractor =
          RegExpDefinition.createCustomRegExpDefinition(
            'Shared time',
            r'(?<time>\d{2}:\d{2})',
          );
      final RegExpDefinition groupExtractor =
          RegExpDefinition.createCustomRegExpDefinition(
            'Merchant',
            r'(?<merchant>Corner Store)',
          );
      NotificationRule? savedRule;
      await tester.pumpWidget(
        MaterialApp(
          home: NotificationRuleDetailsPage(
            rule: NotificationRule(
              id: 'rule',
              name: 'Payments',
              conditions: const <NotificationCondition>[],
              actions: const <NotificationAction>[],
              conditionalActionGroups: <NotificationActionGroup>[
                NotificationActionGroup(
                  id: 'merchant',
                  name: 'Merchant category',
                  conditions: <NotificationCondition>[
                    ValueExistsCondition(
                      RegExpCaptureValueSource(
                        extractorId: groupExtractor.id,
                        captureName: 'merchant',
                      ),
                    ),
                  ],
                  actions: const <NotificationAction>[
                    SetTransactionFieldAction(
                      target: TransactionField.category,
                      valueSource: LiteralValueSource('Groceries'),
                    ),
                  ],
                ),
              ],
            ),
            sharedActions: <NotificationAction>[
              SetTransactionFieldAction(
                target: TransactionField.time,
                valueSource: RegExpCaptureValueSource(
                  extractorId: sharedExtractor.id,
                  captureName: 'time',
                ),
              ),
            ],
            extractors: <RegExpDefinition>[sharedExtractor, groupExtractor],
            notificationContext: NotificationContext(
              title: 'Card payment',
              body: 'Paid Corner Store at 09:30',
              receivedAt: DateTime(2026, 9, 24),
            ),
            onSave: (NotificationRule rule) async {
              savedRule = rule;
              return true;
            },
          ),
        ),
      );

      await tester.tap(find.byTooltip('Enter test mode'));
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.text('Merchant category'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.text('Merchant category'));
      await tester.pumpAndSettle();

      expect(find.text('Sample value issues'), findsNothing);
      expect(find.text('Shared time'), findsNothing);

      await tester.tap(find.byTooltip('Rule options'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Rename'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'Updated category');
      await tester.tap(find.widgetWithText(FilledButton, 'Save'));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Save'));
      await tester.pumpAndSettle();

      expect(find.text('Updated category'), findsOneWidget);
      expect(find.byTooltip('Save'), findsNothing);
      expect(find.byTooltip('Back'), findsOneWidget);

      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();

      expect(
        savedRule?.conditionalActionGroups.single.name,
        'Updated category',
      );
      expect(find.text('Updated category'), findsOneWidget);
      expect(find.byTooltip('Save'), findsNothing);
    },
  );

  testWidgets('toggles shared test mode from conditional action details', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    NotificationRule? savedRule;
    final RegExpDefinition merchant =
        RegExpDefinition.createCustomRegExpDefinition(
          'Merchant',
          r'(?<merchant>Corner Store)',
        );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: NotificationRule(
            id: 'rule',
            name: 'Payments',
            conditions: const <NotificationCondition>[],
            actions: const <NotificationAction>[],
            conditionalActionGroups: <NotificationActionGroup>[
              NotificationActionGroup(
                id: 'merchant',
                name: 'Merchant category',
                conditions: <NotificationCondition>[
                  ValueExistsCondition(
                    RegExpCaptureValueSource(
                      extractorId: merchant.id,
                      captureName: 'merchant',
                    ),
                  ),
                ],
                actions: const <NotificationAction>[
                  SetTransactionFieldAction(
                    target: TransactionField.category,
                    valueSource: LiteralValueSource('Groceries'),
                  ),
                ],
              ),
            ],
          ),
          extractors: <RegExpDefinition>[merchant],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid Corner Store',
            receivedAt: DateTime(2026, 9, 24),
          ),
          onSave: (NotificationRule rule) async {
            savedRule = rule;
            return true;
          },
        ),
      ),
    );

    await tester.scrollUntilVisible(
      find.text('Merchant category'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Merchant category'));
    await tester.pumpAndSettle();

    expect(find.byTooltip('Enter test mode'), findsOneWidget);
    expect(find.text('Test mode'), findsNothing);
    await tester.tap(find.byTooltip('Edit test notification'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byType(TextField).last,
      'Paid Corner Store again',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Apply'));
    await tester.pumpAndSettle();

    expect(find.text('Paid Corner Store again'), findsOneWidget);
    expect(find.byTooltip('Use rule sample'), findsOneWidget);
    await tester.tap(find.byTooltip('Save'));
    await tester.pumpAndSettle();
    expect(
      savedRule?.conditionalActionGroups.single.sampleOverride?.body,
      'Paid Corner Store again',
    );

    await tester.tap(find.byTooltip('Use rule sample'));
    await tester.pumpAndSettle();
    expect(find.text('Paid Corner Store'), findsOneWidget);
    expect(find.byTooltip('Use rule sample'), findsNothing);
    await tester.tap(find.byTooltip('Save'));
    await tester.pumpAndSettle();
    expect(savedRule?.conditionalActionGroups.single.sampleOverride, isNull);

    await tester.tap(find.byTooltip('Enter test mode'));
    await tester.pumpAndSettle();

    expect(find.text('Test mode'), findsOneWidget);
    expect(find.byTooltip('Exit test mode'), findsOneWidget);
    expect(
      find.text(
        'Values and availability below are evaluated against the current sample notification.',
      ),
      findsOneWidget,
    );
    expect(find.text('Sample value issues'), findsNothing);

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Exit test mode'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Merchant category'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Merchant category'));
    await tester.pumpAndSettle();

    expect(find.text('Test mode'), findsNothing);
    expect(find.text('Sample value issues'), findsNothing);

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();

    expect(find.byTooltip('Enter test mode'), findsOneWidget);
    expect(find.text('Test mode'), findsNothing);
  });

  testWidgets('saves rule changes without navigating back', (
    WidgetTester tester,
  ) async {
    NotificationRule? savedRule;
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Payments',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12 CAD',
            receivedAt: DateTime(2026, 9, 24),
          ),
          onSave: (NotificationRule rule) async {
            savedRule = rule;
            return true;
          },
        ),
      ),
    );

    await tester.tap(find.byTooltip('Rule options'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Edit details'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, 'Updated payments');
    await tester.enterText(
      find.byType(TextField).last,
      'Handles card payment notifications.',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Save'));
    await tester.pumpAndSettle();

    expect(savedRule?.name, 'Updated payments');
    expect(savedRule?.description, 'Handles card payment notifications.');
    expect(find.text('Updated payments'), findsOneWidget);
    expect(find.byTooltip('Save'), findsNothing);
    expect(find.byTooltip('Back'), findsOneWidget);
  });

  testWidgets(
    'only enables conditional action reordering for multiple groups',
    (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      NotificationActionGroup group(String id, String name) =>
          NotificationActionGroup(
            id: id,
            name: name,
            conditions: const <NotificationCondition>[
              ValueExistsCondition(LiteralValueSource('value')),
            ],
            actions: const <NotificationAction>[
              SetTransactionFieldAction(
                target: TransactionField.title,
                valueSource: LiteralValueSource('value'),
              ),
            ],
          );

      Future<void> pumpWithGroups(List<NotificationActionGroup> groups) =>
          tester.pumpWidget(
            MaterialApp(
              home: NotificationRuleDetailsPage(
                key: ValueKey<int>(groups.length),
                rule: NotificationRule(
                  id: 'rule',
                  name: 'Deposits',
                  conditions: const <NotificationCondition>[],
                  actions: const <NotificationAction>[],
                  conditionalActionGroups: groups,
                ),
                extractors: const <RegExpDefinition>[],
                notificationContext: NotificationContext(
                  title: 'Deposit received',
                  body: 'Salary deposit received',
                  receivedAt: DateTime(2026, 9, 24),
                ),
              ),
            ),
          );

      await pumpWithGroups(<NotificationActionGroup>[
        group('salary', 'Salary source'),
      ]);
      await tester.scrollUntilVisible(
        find.text('Salary source'),
        200,
        scrollable: find.byType(Scrollable).first,
      );

      expect(find.byIcon(Icons.drag_handle), findsNothing);
      expect(find.byType(ReorderableListView), findsNothing);
      final Text countSummary = tester.widget<Text>(
        find.textContaining('1 condition'),
      );
      expect(
        countSummary.style?.color,
        Theme.of(
          tester.element(find.text('Salary source')),
        ).colorScheme.outline,
      );
      expect(tester.widget<Icon>(find.byIcon(Icons.alt_route)).color, isNull);

      await pumpWithGroups(<NotificationActionGroup>[
        group('salary', 'Salary source'),
        group('refund', 'Refund source'),
      ]);
      await tester.scrollUntilVisible(
        find.text('Refund source'),
        200,
        scrollable: find.byType(Scrollable).first,
      );

      expect(find.byIcon(Icons.drag_handle), findsNWidgets(2));
      expect(find.byType(ReorderableListView), findsOneWidget);
    },
  );

  testWidgets('duplicates a conditional action from its options menu', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Deposits',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
            conditionalActionGroups: <NotificationActionGroup>[
              NotificationActionGroup(
                id: 'salary',
                name: 'Salary source',
                conditions: <NotificationCondition>[
                  ValueExistsCondition(LiteralValueSource('salary')),
                ],
                actions: <NotificationAction>[
                  SetTransactionTagsAction(<String>['salary']),
                ],
              ),
            ],
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Deposit received',
            body: 'Salary deposit received',
            receivedAt: DateTime(2026, 9, 24),
          ),
        ),
      ),
    );

    await tester.scrollUntilVisible(
      find.text('Salary source'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.byTooltip('Conditional action options'));
    await tester.pumpAndSettle();
    expect(find.text('Edit'), findsOneWidget);
    expect(find.text('Rename'), findsOneWidget);
    expect(find.text('Delete'), findsOneWidget);
    final List<NotificationMenuDivider> menuDividers = tester
        .widgetList<NotificationMenuDivider>(
          find.byType(NotificationMenuDivider),
        )
        .toList();
    expect(menuDividers, hasLength(2));
    for (final NotificationMenuDivider divider in menuDividers) {
      expect(divider.indent, 16);
      expect(divider.endIndent, 16);
    }
    expect(find.text('1 condition · 1 action'), findsOneWidget);
    await tester.tap(find.text('Duplicate'));
    await tester.pump();

    expect(find.text('Salary source'), findsNWidgets(2));
    expect(find.byIcon(Icons.drag_handle), findsNWidgets(2));
    expect(find.byTooltip('Save'), findsOneWidget);
  });

  testWidgets(
    'edits, renames, and deletes a conditional action from its menu',
    (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(
        MaterialApp(
          home: NotificationRuleDetailsPage(
            rule: const NotificationRule(
              id: 'rule',
              name: 'Deposits',
              conditions: <NotificationCondition>[],
              actions: <NotificationAction>[],
              conditionalActionGroups: <NotificationActionGroup>[
                NotificationActionGroup(
                  id: 'salary',
                  name: 'Salary source',
                  conditions: <NotificationCondition>[],
                  actions: <NotificationAction>[],
                ),
              ],
            ),
            extractors: const <RegExpDefinition>[],
            notificationContext: NotificationContext(
              title: 'Deposit received',
              body: 'Salary deposit received',
              receivedAt: DateTime(2026, 9, 24),
            ),
          ),
        ),
      );

      await tester.scrollUntilVisible(
        find.text('Salary source'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.byTooltip('Conditional action options'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Rename'));
      await tester.pumpAndSettle();
      expect(find.text('Rename conditional action'), findsOneWidget);
      await tester.enterText(
        find.descendant(
          of: find.byType(AlertDialog),
          matching: find.byType(TextField),
        ),
        'Deposit source',
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Save'));
      await tester.pumpAndSettle();
      expect(find.text('Deposit source'), findsOneWidget);

      await tester.tap(find.byTooltip('Conditional action options'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Edit'));
      await tester.pumpAndSettle();
      expect(find.text('Sample notification'), findsOneWidget);
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('Conditional action options'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();
      expect(find.text('Remove conditional action?'), findsOneWidget);
      await tester.tap(find.widgetWithText(FilledButton, 'Remove'));
      await tester.pumpAndSettle();

      expect(find.text('Deposit source'), findsNothing);
      expect(find.text('No conditional actions'), findsOneWidget);
    },
  );

  testWidgets('hides implementation count summary tags', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12 CAD',
            receivedAt: DateTime(2026, 9, 7),
          ),
          extractorMode: NotificationExtractorMode.basic,
        ),
      ),
    );

    expect(find.text('0 conditions'), findsNothing);
    expect(find.text('No actions'), findsNothing);
  });

  testWidgets('shows setup status in shared actions editor', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'shared-actions',
            name: 'Shared actions',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12 CAD',
            receivedAt: DateTime(2026, 9, 7),
          ),
          isSharedActionsEditor: true,
        ),
      ),
    );

    expect(find.text('Needs setup'), findsOneWidget);
    expect(
      find.text(
        'Add a shared transaction field here, or go back and create a rule, before this application can process notifications.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('hides provenance in the shared actions preview', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'shared-actions',
            name: 'Shared actions',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[
              SetTransactionFieldAction(
                target: TransactionField.sourceAccount,
                valueSource: LiteralValueSource('Checking'),
              ),
            ],
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12 CAD',
            receivedAt: DateTime(2026, 9, 7),
          ),
          isSharedActionsEditor: true,
        ),
      ),
    );

    await tester.scrollUntilVisible(
      find.text('Resolved transaction fields'),
      200,
      scrollable: find.byType(Scrollable).first,
    );

    expect(find.text('Checking'), findsWidgets);
    expect(find.text('Set by: This rule'), findsNothing);
  });

  testWidgets('updates shared setup status as draft actions change', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'shared-actions',
            name: 'Shared actions',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12 CAD',
            receivedAt: DateTime(2026, 9, 7),
          ),
          isSharedActionsEditor: true,
        ),
      ),
    );

    expect(find.text('Needs setup'), findsOneWidget);
    await tester.tap(find.text('Add action'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Amount'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Literal value'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('action-literal-value')),
      '12.50',
    );
    await tester.pump();
    expect(
      tester
          .widget<FilledButton>(find.widgetWithText(FilledButton, 'Save'))
          .onPressed,
      isNotNull,
    );
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
    expect(find.text('No actions defined.'), findsNothing);
    expect(find.text('Needs setup'), findsNothing);
    await tester.tap(find.byTooltip('Action options'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Remove'));
    await tester.pumpAndSettle();
    expect(find.text('Needs setup'), findsOneWidget);
  });

  testWidgets('does not require shared actions when a rule exists', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'shared-actions',
            name: 'Shared actions',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
          rules: const <NotificationRule>[
            NotificationRule(
              id: 'rule',
              name: 'Rule',
              conditions: <NotificationCondition>[],
              actions: <NotificationAction>[],
            ),
          ],
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12 CAD',
            receivedAt: DateTime(2026, 9, 7),
          ),
          isSharedActionsEditor: true,
        ),
      ),
    );
    expect(find.text('Needs setup'), findsNothing);
  });

  testWidgets('shows setup status in basic transaction fields editor', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'transaction-fields',
            name: 'Set transaction fields',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12 CAD',
            receivedAt: DateTime(2026, 9, 7),
          ),
          extractorMode: NotificationExtractorMode.basic,
          isSharedActionsEditor: true,
        ),
      ),
    );

    expect(find.text('Needs setup'), findsOneWidget);
    expect(
      find.text(
        'Add at least one transaction field before this application can process notifications.',
      ),
      findsOneWidget,
    );
  });

  testWidgets(
    'keeps the basic transaction fields sample read-only and hides provenance',
    (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(
        MaterialApp(
          home: NotificationRuleDetailsPage(
            rule: const NotificationRule(
              id: 'transaction-fields',
              name: 'Set transaction fields',
              conditions: <NotificationCondition>[],
              actions: <NotificationAction>[
                SetTransactionFieldAction(
                  target: TransactionField.title,
                  valueSource: LiteralValueSource('Card payment'),
                ),
              ],
            ),
            extractors: const <RegExpDefinition>[],
            notificationContext: NotificationContext(
              title: 'Card payment',
              body: 'Paid 12 CAD',
              receivedAt: DateTime(2026, 9, 7),
            ),
            extractorMode: NotificationExtractorMode.basic,
            isSharedActionsEditor: true,
          ),
        ),
      );

      expect(find.text('Sample notification'), findsOneWidget);
      expect(find.byTooltip('Edit test notification'), findsNothing);
      await tester.scrollUntilVisible(
        find.text('Resolved transaction fields'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('Card payment'), findsWidgets);
      expect(find.text('Set by: This rule'), findsNothing);
    },
  );

  testWidgets('clears basic setup status when a field is added', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'transaction-fields',
            name: 'Set transaction fields',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12 CAD',
            receivedAt: DateTime(2026, 9, 7),
          ),
          extractorMode: NotificationExtractorMode.basic,
          isSharedActionsEditor: true,
        ),
      ),
    );

    expect(find.text('Needs setup'), findsOneWidget);
    await tester.tap(find.text('Add action'));
    await tester.pumpAndSettle();
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

    expect(find.text('Needs setup'), findsNothing);
  });

  testWidgets('shows a floating save button for a changed rule', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12 CAD',
            receivedAt: DateTime(2026, 9, 7),
          ),
        ),
      ),
    );

    expect(find.byTooltip('Save'), findsNothing);
    await tester.tap(find.byTooltip('Rule options'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Edit details'));
    await tester.pumpAndSettle();
    final Finder ruleNameField = find.byWidgetPredicate(
      (Widget widget) =>
          widget is TextField && widget.decoration?.labelText == 'Rule name',
    );
    await tester.enterText(ruleNameField, 'Updated payment');
    expect(
      tester.widget<TextField>(ruleNameField).controller!.text,
      'Updated payment',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();

    expect(find.text('Edit rule details'), findsNothing);
    expect(find.byTooltip('Back'), findsOneWidget);
    expect(find.text('Updated payment'), findsOneWidget);
    expect(find.byTooltip('Save'), findsOneWidget);
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(TextButton, 'Discard'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Cancel'), findsOneWidget);
  });

  testWidgets('offers Test mode for an unconditional rule', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'all',
            name: 'Any notification',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12 CAD',
            receivedAt: DateTime(2026, 9, 7),
          ),
        ),
      ),
    );

    expect(find.byTooltip('Enter test mode'), findsOneWidget);
    expect(
      find.text(
        'Fine-tune the sample for this rule while keeping the definition sample available throughout the definition.',
      ),
      findsOneWidget,
    );
    expect(find.text('Ready'), findsNothing);
    expect(find.byType(MessageStatusCard), findsNothing);
  });

  testWidgets('clears the rule name from the details field', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12 CAD',
            receivedAt: DateTime(2026, 9, 1),
          ),
        ),
      ),
    );

    await tester.tap(find.byTooltip('Rule options'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Edit details'));
    await tester.pumpAndSettle();

    final Finder renameField = find
        .descendant(
          of: find.byType(AlertDialog),
          matching: find.byType(TextField),
        )
        .first;
    expect(
      tester.widget<TextField>(renameField).controller!.text,
      'Card payment',
    );
    expect(find.byTooltip('Clear text'), findsOneWidget);

    await tester.tap(find.byTooltip('Clear text'));
    await tester.pump();

    expect(tester.widget<TextField>(renameField).controller!.text, isEmpty);
    expect(find.byTooltip('Clear text'), findsNothing);
  });

  testWidgets('shows test mode as an informational status card', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12 CAD',
            receivedAt: DateTime(2026, 9, 1),
          ),
        ),
      ),
    );

    final double sampleTopBefore = tester
        .getTopLeft(find.text('Sample notification'))
        .dy;
    await tester.tap(find.byTooltip('Enter test mode'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 90));

    expect(find.byType(MessageStatusCard), findsOneWidget);
    expect(find.byIcon(Icons.info_outline), findsOneWidget);
    expect(find.byType(Chip), findsNothing);
    expect(find.text('Test mode'), findsOneWidget);
    final FadeTransition fade = tester.widget<FadeTransition>(
      find.byKey(const Key('rule-status-fade')),
    );
    expect(fade.opacity.value, greaterThan(0));
    expect(fade.opacity.value, lessThan(1));
    expect(
      tester.getTopLeft(find.text('Sample notification')).dy,
      greaterThan(sampleTopBefore),
    );
    await tester.pumpAndSettle();
  });

  testWidgets('persists the edited rule sample outside test mode', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final RegExpDefinition extractor =
        RegExpDefinition.createCustomRegExpDefinition(
          'Amount',
          r'Paid (?<amount>\d+)',
        );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: const <NotificationCondition>[],
            actions: <NotificationAction>[
              SetTransactionFieldAction(
                target: TransactionField.title,
                valueSource: RegExpCaptureValueSource(
                  extractorId: extractor.id,
                  captureName: 'amount',
                ),
              ),
            ],
          ),
          extractors: <RegExpDefinition>[extractor],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12 CAD',
            receivedAt: DateTime(2026, 9, 7),
          ),
        ),
      ),
    );

    expect(richText('Resolved value: "12"'), findsOneWidget);
    await tester.tap(find.byTooltip('Enter test mode'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Edit test notification'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, 'Paid 25 CAD');
    await tester.tap(find.widgetWithText(FilledButton, 'Apply'));
    await tester.pumpAndSettle();

    expect(find.text('Paid 25 CAD'), findsOneWidget);
    expect(richText('Resolved value: "25"'), findsOneWidget);
    expect(find.byTooltip('Save'), findsOneWidget);

    await tester.tap(find.byTooltip('Exit test mode'));
    await tester.pumpAndSettle();

    expect(find.text('Paid 25 CAD'), findsOneWidget);
    expect(richText('Resolved value: "25"'), findsOneWidget);
  });

  testWidgets('marks clearing a rule sample override as unsaved', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: const <NotificationCondition>[],
            actions: const <NotificationAction>[],
            sampleOverride: NotificationSample(
              title: 'Card payment',
              body: 'Paid 12 CAD',
              receivedAt: DateTime(2026, 9, 7),
            ),
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12 CAD',
            receivedAt: DateTime(2026, 9, 7),
          ),
          definitionSampleContext: NotificationContext(
            title: 'Definition sample',
            body: 'Paid 10 CAD',
            receivedAt: DateTime(2026, 9, 6),
          ),
        ),
      ),
    );

    expect(find.byTooltip('Save'), findsNothing);

    await tester.tap(find.byTooltip('Use definition sample'));
    await tester.pumpAndSettle();

    expect(find.byTooltip('Save'), findsOneWidget);
  });

  testWidgets('keeps configured extractor and shows edited sample value', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition extractor =
        RegExpDefinition.createPredefinedRegExpDefinition(
          PredefinedRegExpDefinition.notificationMessage,
        );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[
              ValueExistsCondition(
                RegExpCaptureValueSource(
                  extractorId: extractor.id,
                  captureName: 'message',
                ),
              ),
            ],
            actions: const <NotificationAction>[],
          ),
          extractors: <RegExpDefinition>[extractor],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Original notification message',
            receivedAt: DateTime(2026, 9, 7),
          ),
        ),
      ),
    );

    expect(find.textContaining('Source:'), findsNothing);
    expect(find.textContaining('Capture:'), findsNothing);
    await tester.tap(find.byTooltip('Enter test mode'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Edit test notification'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byType(TextField).last,
      'Edited notification message',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Apply'));
    await tester.pumpAndSettle();

    expect(
      conditionTitle('Extractor "Notification message" value exists'),
      findsOneWidget,
    );
    expect(
      find.textContaining(
        'Matches · Sample value: Edited notification message',
      ),
      findsOneWidget,
    );
  });

  testWidgets('animates condition cards when test mode changes', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition extractor =
        RegExpDefinition.createPredefinedRegExpDefinition(
          PredefinedRegExpDefinition.notificationMessage,
        );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[
              ValueContainsCondition(
                value: RegExpCaptureValueSource(
                  extractorId: extractor.id,
                  captureName: 'message',
                ),
                substring: const LiteralValueSource('Purchase'),
              ),
            ],
            actions: const <NotificationAction>[],
          ),
          extractors: <RegExpDefinition>[extractor],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Purchase at Corner Store',
            receivedAt: DateTime(2026, 9, 27),
          ),
        ),
      ),
    );

    await tester.tap(find.byTooltip('Enter test mode'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 90));

    final Iterable<double> subtitleOpacities = tester
        .widgetList<FadeTransition>(
          find.byKey(const Key('condition-mode-fade')),
        )
        .map((FadeTransition fade) => fade.opacity.value);
    final Iterable<double> leadingOpacities = tester
        .widgetList<FadeTransition>(
          find.byKey(const Key('condition-leading-fade')),
        )
        .map((FadeTransition fade) => fade.opacity.value);
    expect(
      subtitleOpacities,
      contains(predicate<double>((double value) => value > 0 && value < 1)),
    );
    expect(
      leadingOpacities,
      contains(predicate<double>((double value) => value > 0 && value < 1)),
    );

    await tester.pumpAndSettle();
    final Finder title = conditionTitle(
      'Extractor "Notification message" value contains "Purchase"',
    );
    final Finder subtitle = find.textContaining('Matches · Sample value:');
    expect(subtitle, findsOneWidget);
    expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
    expect(
      tester.getTopLeft(subtitle).dx,
      closeTo(tester.getTopLeft(title).dx, 1),
    );
  });

  testWidgets('resolves positional captures from the edited test sample', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition extractor =
        RegExpDefinition.createCustomRegExpDefinition('Vendor', r'at (.+)\.$');
    final RegExpCaptureValueSource vendor = RegExpCaptureValueSource(
      extractorId: extractor.id,
      captureName: '',
      fallbackCaptureIndex: 1,
      matchIndex: 0,
    );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[
              ValueContainsCondition(
                value: vendor,
                substring: const LiteralValueSource('Walmart'),
              ),
            ],
            actions: const <NotificationAction>[],
          ),
          extractors: <RegExpDefinition>[extractor],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'A purchase was made at VENDOR.',
            receivedAt: DateTime(2026, 9, 7),
          ),
        ),
      ),
    );

    await tester.tap(find.byTooltip('Enter test mode'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Edit test notification'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byType(TextField).last,
      'A purchase was made at Walmart.',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Apply'));
    await tester.pumpAndSettle();

    expect(
      conditionTitle('Extractor "Vendor" value contains "Walmart"'),
      findsOneWidget,
    );
    expect(
      find.textContaining('Matches · Sample value: Walmart'),
      findsOneWidget,
    );
  });

  testWidgets(
    'returns to a clean state after removing a duplicated condition',
    (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      const ValueExistsCondition condition = ValueExistsCondition(
        LiteralValueSource('merchant'),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: NotificationRuleDetailsPage(
            rule: const NotificationRule(
              id: 'rule',
              name: 'Card payment',
              conditions: <NotificationCondition>[condition],
              actions: <NotificationAction>[],
            ),
            extractors: const <RegExpDefinition>[],
            notificationContext: NotificationContext(
              title: 'Card payment',
              body: 'Paid 12 CAD',
              receivedAt: DateTime(2026, 9, 7),
            ),
          ),
        ),
      );

      await tester.tap(find.byTooltip('Condition options'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Duplicate'));
      await tester.pumpAndSettle();

      expect(conditionTitle('"merchant" exists'), findsNWidgets(2));
      expect(find.byTooltip('Save'), findsOneWidget);

      await tester.tap(find.byTooltip('Condition options').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Remove'));
      await tester.pumpAndSettle();

      expect(conditionTitle('"merchant" exists'), findsOneWidget);
      expect(find.byTooltip('Save'), findsNothing);
    },
  );

  testWidgets(
    'returns to a clean state after adding and removing a condition',
    (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final RegExpDefinition extractor =
          RegExpDefinition.createCustomRegExpDefinition(
            'Value',
            r'(?<value>first)',
          );
      await tester.pumpWidget(
        MaterialApp(
          home: NotificationRuleDetailsPage(
            rule: const NotificationRule(
              id: 'rule',
              name: 'Card payment',
              conditions: <NotificationCondition>[],
              actions: <NotificationAction>[],
            ),
            extractors: <RegExpDefinition>[extractor],
            notificationContext: NotificationContext(
              title: 'Card payment',
              body: 'Paid first',
              receivedAt: DateTime(2026, 9, 1),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Add condition'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Value condition'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Value exists'));
      await tester.pumpAndSettle();
      expect(find.text('Value exists'), findsOneWidget);
      await tester.tap(find.text('Value'));
      await tester.pumpAndSettle();

      expect(find.byTooltip('Save'), findsOneWidget);
      expect(conditionTitle('Extractor "Value" value exists'), findsOneWidget);

      await tester.tap(find.byTooltip('Condition options'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Remove'));
      await tester.pumpAndSettle();

      expect(conditionTitle('Extractor "Value" value exists'), findsNothing);
      expect(find.byTooltip('Save'), findsNothing);
    },
  );

  testWidgets('pastes a copied leaf condition into an all group', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    const ValueExistsCondition condition = ValueExistsCondition(
      LiteralValueSource('merchant'),
    );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[
              condition,
              AllCondition(<NotificationCondition>[]),
            ],
            actions: <NotificationAction>[],
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12 CAD',
            receivedAt: DateTime(2026, 9, 7),
          ),
        ),
      ),
    );

    await tester.tap(find.byTooltip('Condition options').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Copy'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('condition-copy-snackbar')), findsOneWidget);
    expect(find.text('Copying condition'), findsOneWidget);
    expect(find.text('Select a destination.'), findsOneWidget);
    await tester.tap(find.byTooltip('Paste').last);
    await tester.pumpAndSettle();

    expect(conditionTitle('"merchant" exists'), findsNWidgets(2));
    expect(find.byTooltip('Paste'), findsNothing);
    expect(find.byKey(const Key('condition-copy-snackbar')), findsNothing);
  });

  testWidgets('cancels a condition copy without changing the rule', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[
              ValueExistsCondition(LiteralValueSource('merchant')),
              AllCondition(<NotificationCondition>[]),
            ],
            actions: <NotificationAction>[],
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12 CAD',
            receivedAt: DateTime(2026, 9, 7),
          ),
        ),
      ),
    );

    await tester.tap(find.byTooltip('Condition options').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Copy'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('condition-copy-snackbar')), findsOneWidget);
    expect(find.byKey(const Key('condition-root-paste')), findsOneWidget);
    expect(find.byTooltip('Paste'), findsOneWidget);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('condition-copy-snackbar')), findsNothing);
    expect(find.byKey(const Key('condition-root-paste')), findsNothing);
    expect(find.byTooltip('Paste'), findsNothing);
    expect(conditionTitle('"merchant" exists'), findsOneWidget);
    expect(find.byTooltip('Save'), findsNothing);
  });

  testWidgets('fades the copy panel without moving it', (
    WidgetTester tester,
  ) async {
    await openRuleForTransfer(tester);
    await tester.tap(find.byTooltip('Condition options').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Copy'));
    await tester.pump();

    final Finder surface = find.byKey(const Key('condition-clipboard-surface'));
    final Finder fade = find
        .ancestor(of: surface, matching: find.byType(FadeTransition))
        .first;
    expect(tester.widget<FadeTransition>(fade).opacity.value, lessThan(1));
    final double top = tester.getTopLeft(surface).dy;
    await tester.pump(const Duration(milliseconds: 200));
    expect(
      tester.widget<FadeTransition>(fade).opacity.value,
      inExclusiveRange(0, 1),
    );
    expect(tester.getTopLeft(surface).dy, top);
    await tester.pumpAndSettle();
    expect(tester.widget<FadeTransition>(fade).opacity.value, 1);
    await tester.binding.setSurfaceSize(const Size(320, 900));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Cancel'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(
      tester.widget<FadeTransition>(fade).opacity.value,
      inExclusiveRange(0, 1),
    );
    expect(tester.getTopLeft(surface).dy, top);
    await tester.pumpAndSettle();
    expect(surface, findsNothing);
  });

  testWidgets('places the save button above the copy panel', (
    WidgetTester tester,
  ) async {
    await openRuleForTransfer(tester);
    await tester.tap(find.byTooltip('Rule options'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Edit details'));
    await tester.pumpAndSettle();
    final Finder ruleNameField = find.byWidgetPredicate(
      (Widget widget) =>
          widget is TextField && widget.decoration?.labelText == 'Rule name',
    );
    await tester.enterText(ruleNameField, 'Updated payment');
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Condition options').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Copy'));
    await tester.pumpAndSettle();

    final Finder saveButton = find.byTooltip('Save');
    final Finder clipboardSurface = find.byKey(
      const Key('condition-clipboard-surface'),
    );
    expect(saveButton, findsOneWidget);
    expect(clipboardSurface, findsOneWidget);
    expect(
      tester.getBottomRight(saveButton).dy,
      lessThan(tester.getTopLeft(clipboardSurface).dy),
    );
  });

  testWidgets('switches copy to move without replaying the panel animation', (
    WidgetTester tester,
  ) async {
    await openRuleForTransfer(tester);
    await tester.tap(find.byTooltip('Condition options').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Copy'));
    await tester.pumpAndSettle();

    final Finder surface = find.byKey(const Key('condition-clipboard-surface'));
    final Finder fade = find
        .ancestor(of: surface, matching: find.byType(FadeTransition))
        .first;
    final Element originalSurface = tester.element(surface);
    final double top = tester.getTopLeft(surface).dy;
    await tester.tap(find.byTooltip('Condition options').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Move'));
    await tester.pump();

    expect(find.byKey(const Key('condition-copy-snackbar')), findsNothing);
    expect(find.byKey(const Key('condition-move-snackbar')), findsOneWidget);
    expect(tester.element(surface), same(originalSurface));
    expect(tester.getTopLeft(surface).dy, top);
    expect(tester.widget<FadeTransition>(fade).opacity.value, 1);
    await tester.pumpAndSettle();
  });

  testWidgets('copies to root but cannot move within root without a group', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[
              ValueExistsCondition(LiteralValueSource('merchant')),
            ],
            actions: <NotificationAction>[],
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12 CAD',
            receivedAt: DateTime(2026, 9, 7),
          ),
        ),
      ),
    );

    await tester.tap(find.byTooltip('Condition options'));
    await tester.pumpAndSettle();
    expect(
      find.ancestor(
        of: find.text('Move'),
        matching: find.byWidgetPredicate(
          (Widget widget) => widget is PopupMenuItem && !widget.enabled,
        ),
      ),
      findsOneWidget,
    );
    await tester.tap(find.text('Copy'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('condition-copy-snackbar')), findsOneWidget);
    final Finder rootPaste = find.byKey(const Key('condition-root-paste'));
    final Finder actionRow = find.ancestor(
      of: rootPaste,
      matching: find.byType(Wrap),
    );
    expect(tester.widget<ElevatedButton>(rootPaste), isNotNull);
    expect(
      find.descendant(of: rootPaste, matching: find.text('Paste here')),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: actionRow,
        matching: find.widgetWithText(ElevatedButton, 'Add condition'),
      ),
      findsOneWidget,
    );
    expect(
      tester.getTopLeft(rootPaste).dy,
      greaterThan(
        tester.getBottomLeft(conditionTitle('"merchant" exists').first).dy,
      ),
    );
    await tester.binding.setSurfaceSize(const Size(320, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpAndSettle();
    expect(
      tester.getTopLeft(rootPaste).dy,
      greaterThan(
        tester
            .getTopLeft(find.widgetWithText(ElevatedButton, 'Add condition'))
            .dy,
      ),
    );
    expect(tester.takeException(), isNull);
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    await tester.pumpAndSettle();
    await tester.tap(rootPaste);
    await tester.pumpAndSettle();
    expect(conditionTitle('"merchant" exists'), findsNWidgets(2));
    expect(find.byKey(const Key('condition-root-paste')), findsNothing);
    expect(find.byKey(const Key('condition-copy-snackbar')), findsNothing);
  });

  testWidgets('moves a condition out of not and removes its wrapper', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    NotificationRule? savedRule;
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[
              AllCondition(<NotificationCondition>[
                NotCondition(
                  ValueExistsCondition(LiteralValueSource('merchant')),
                ),
              ]),
            ],
            actions: <NotificationAction>[],
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12 CAD',
            receivedAt: DateTime(2026, 9, 7),
          ),
          onSave: (NotificationRule rule) async {
            savedRule = rule;
            return true;
          },
        ),
      ),
    );

    await tester.tap(find.text('All conditions match'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Condition does not match'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Condition options').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Move'));
    await tester.pumpAndSettle();
    expect(
      find.descendant(
        of: find.byKey(const Key('condition-root-paste')),
        matching: find.text('Move here'),
      ),
      findsOneWidget,
    );
    await tester.tap(find.byKey(const Key('condition-root-paste')));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Save'));
    await tester.pumpAndSettle();

    expect(savedRule!.conditions, hasLength(2));
    expect((savedRule!.conditions.first as AllCondition).conditions, isEmpty);
    expect(savedRule!.conditions.last, isA<ValueExistsCondition>());
  });

  testWidgets('moves a condition out of a root not to the root', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    NotificationRule? savedRule;
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[
              NotCondition(
                ValueExistsCondition(LiteralValueSource('merchant')),
              ),
            ],
            actions: <NotificationAction>[],
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12 CAD',
            receivedAt: DateTime(2026, 9, 7),
          ),
          onSave: (NotificationRule rule) async {
            savedRule = rule;
            return true;
          },
        ),
      ),
    );

    await tester.tap(find.text('Condition does not match'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Condition options').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Move'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('condition-root-paste')));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Save'));
    await tester.pumpAndSettle();

    expect(savedRule!.conditions, hasLength(1));
    expect(savedRule!.conditions.single, isA<ValueExistsCondition>());
  });

  testWidgets('excludes the current group from move destinations', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    NotificationRule? savedRule;
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[
              AllCondition(<NotificationCondition>[
                ValueExistsCondition(LiteralValueSource('merchant')),
              ]),
              AnyCondition(<NotificationCondition>[]),
            ],
            actions: <NotificationAction>[],
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12 CAD',
            receivedAt: DateTime(2026, 9, 7),
          ),
          onSave: (NotificationRule rule) async {
            savedRule = rule;
            return true;
          },
        ),
      ),
    );

    await tester.tap(find.text('All conditions match'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Any condition matches'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Condition options').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Move'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Move here'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byKey(const Key('condition-root-paste')),
        matching: find.text('Move here'),
      ),
      findsOneWidget,
    );
    await tester.tap(find.byTooltip('Move here'));
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<DefinitionExpandableDetailCard>(
            find.ancestor(
              of: find.text('Any condition matches'),
              matching: find.byType(DefinitionExpandableDetailCard),
            ),
          )
          .expanded,
      isTrue,
    );
    expect(
      tester
          .widget<DefinitionExpandableDetailCard>(
            find.ancestor(
              of: find.text('All conditions match'),
              matching: find.byType(DefinitionExpandableDetailCard),
            ),
          )
          .expanded,
      isTrue,
    );
    await tester.tap(find.byTooltip('Save'));
    await tester.pumpAndSettle();

    expect((savedRule!.conditions.first as AllCondition).conditions, isEmpty);
    expect(
      (savedRule!.conditions.last as AnyCondition).conditions,
      hasLength(1),
    );
  });

  testWidgets('moves a leaf condition into an all group', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    NotificationRule? savedRule;
    const ValueExistsCondition condition = ValueExistsCondition(
      LiteralValueSource('merchant'),
    );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[
              condition,
              AllCondition(<NotificationCondition>[]),
            ],
            actions: <NotificationAction>[],
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12 CAD',
            receivedAt: DateTime(2026, 9, 7),
          ),
          onSave: (NotificationRule rule) async {
            savedRule = rule;
            return true;
          },
        ),
      ),
    );
    final Finder destination = find.ancestor(
      of: find.text('All conditions match'),
      matching: find.byType(DefinitionExpandableDetailCard),
    );
    expect(
      tester.widget<DefinitionExpandableDetailCard>(destination).expanded,
      isFalse,
    );

    await tester.tap(find.byTooltip('Condition options').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Move'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('condition-move-snackbar')), findsOneWidget);
    expect(find.text('Moving condition'), findsOneWidget);
    expect(find.text('Select a destination.'), findsOneWidget);
    expect(find.byKey(const Key('condition-move-source')), findsOneWidget);
    expect(find.byTooltip('Move here'), findsOneWidget);
    expect(find.text('Move here'), findsNothing);
    expect(find.byTooltip('Paste'), findsNothing);
    final SnackBar moveSnackBar = tester.widget<SnackBar>(
      find.byType(SnackBar),
    );
    expect(moveSnackBar.behavior, SnackBarBehavior.fixed);
    expect(moveSnackBar.margin, isNull);
    expect(moveSnackBar.elevation, 0);
    final Material surface = tester.widget<Material>(
      find.byKey(const Key('condition-clipboard-surface')),
    );
    expect(surface.elevation, 8);
    final RoundedRectangleBorder snackBarShape =
        surface.shape! as RoundedRectangleBorder;
    expect(snackBarShape.borderRadius, BorderRadius.circular(16));

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('condition-move-snackbar')), findsNothing);
    expect(find.byTooltip('Move here'), findsNothing);
    expect(conditionTitle('"merchant" exists'), findsOneWidget);

    await tester.tap(find.byTooltip('Condition options').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Move'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Move here'));
    await tester.pumpAndSettle();

    expect(
      tester.widget<DefinitionExpandableDetailCard>(destination).expanded,
      isTrue,
    );
    expect(conditionTitle('"merchant" exists'), findsOneWidget);
    expect(find.byTooltip('Paste'), findsNothing);

    await tester.tap(find.byTooltip('Save'));
    await tester.pumpAndSettle();

    expect(savedRule!.conditions, hasLength(1));
    final AllCondition group = savedRule!.conditions.single as AllCondition;
    expect(group.conditions, hasLength(1));
    expect(group.conditions.single, isA<ValueExistsCondition>());
  });

  testWidgets('opens currency mapping when adding an optional currency field', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final RegExpDefinition currency =
        RegExpDefinition.createPredefinedRegExpDefinition(
          PredefinedRegExpDefinition.currency,
        );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Card payment',
            isPredefined: true,
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[
              SetTransactionFieldAction(
                target: TransactionField.amount,
                valueSource: LiteralValueSource('12.00'),
              ),
            ],
          ),
          extractors: <RegExpDefinition>[currency],
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
    await tester.tap(find.text('Currency'));
    await tester.pumpAndSettle();

    expect(find.text('Extractor capture'), findsOneWidget);
  });

  testWidgets('does not offer Firefly currency selection in Basic mode', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final RegExpDefinition currency =
        RegExpDefinition.createPredefinedRegExpDefinition(
          PredefinedRegExpDefinition.currency,
        );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Card payment',
            isPredefined: true,
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[
              SetTransactionFieldAction(
                target: TransactionField.amount,
                valueSource: LiteralValueSource('12.00'),
              ),
            ],
          ),
          extractors: <RegExpDefinition>[currency],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12 CAD',
            receivedAt: DateTime(2026, 9, 7),
          ),
          extractorMode: NotificationExtractorMode.basic,
        ),
      ),
    );

    await tester.tap(find.text('Add optional field'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Currency'));
    await tester.pumpAndSettle();

    expect(find.text('Extractor capture'), findsOneWidget);
    expect(find.text('Select from Firefly'), findsNothing);
  });

  testWidgets('shows tag action controls beneath the selected tags', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[
              SetTransactionTagsAction(<String>['work', 'travel']),
            ],
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12 CAD',
            receivedAt: DateTime(2026, 9, 7),
          ),
        ),
      ),
    );

    await tester.ensureVisible(find.text('Set transaction tags'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Set transaction tags'));
    await tester.pumpAndSettle();

    expect(find.text('work'), findsNWidgets(2));
    expect(find.text('travel'), findsNWidgets(2));
    expect(find.widgetWithText(ElevatedButton, 'Add tag(s)'), findsOneWidget);
    expect(find.byTooltip('Remove action?'), findsOneWidget);
    expect(find.byIcon(Icons.delete_outline), findsOneWidget);
    expect(
      tester
          .widget<IconButton>(
            find.ancestor(
              of: find.byIcon(Icons.delete_outline),
              matching: find.byType(IconButton),
            ),
          )
          .iconSize,
      18,
    );
  });

  testWidgets('removes a tag through the actions section callback', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[
              SetTransactionTagsAction(<String>['work', 'travel']),
            ],
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12 CAD',
            receivedAt: DateTime(2026, 9, 7),
          ),
        ),
      ),
    );

    tester
        .widget<InputChip>(find.widgetWithText(InputChip, 'work'))
        .onDeleted!();
    await tester.pumpAndSettle();

    expect(find.text('work'), findsNothing);
    expect(find.widgetWithText(InputChip, 'travel'), findsOneWidget);
    expect(find.byTooltip('Save'), findsOneWidget);
  });

  testWidgets(
    'styles the test notification dialog like a sample notification',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: NotificationRuleDetailsPage(
            rule: const NotificationRule(
              id: 'rule',
              name: 'Card payment',
              conditions: <NotificationCondition>[],
              actions: <NotificationAction>[],
            ),
            extractors: const <RegExpDefinition>[],
            notificationContext: NotificationContext(
              applicationId: 'com.example.bank',
              applicationName: 'Example Bank',
              title: 'Card payment',
              body: 'Paid 12 CAD',
              receivedAt: DateTime(2026, 9, 7),
            ),
          ),
        ),
      );

      await tester.tap(find.byTooltip('Enter test mode'));
      await tester.pumpAndSettle();
      expect(
        tester
            .widget<IconButton>(
              find.ancestor(
                of: find.byTooltip('Edit test notification'),
                matching: find.byType(IconButton),
              ),
            )
            .iconSize,
        18,
      );
      await tester.tap(find.byTooltip('Edit test notification'));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.notifications_outlined), findsOneWidget);
      expect(find.text('Example Bank'), findsNothing);
      expect(find.text('Notification source'), findsNothing);
      expect(
        find.text(
          'Enter a notification title, message, and received time to test this '
          'rule. This sample applies to the rule and its conditional actions.',
        ),
        findsOneWidget,
      );
      expect(find.text('Notification title'), findsOneWidget);
      expect(find.text('Notification message'), findsOneWidget);
    },
  );

  testWidgets('adds an exists condition inside an all group', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition extractor =
        RegExpDefinition.createCustomRegExpDefinition(
          'Value',
          r'(?<value>first)',
        );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
          extractors: <RegExpDefinition>[extractor],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid first',
            receivedAt: DateTime(2026, 9, 1),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Add condition'));
    await tester.pumpAndSettle();
    expect(find.text('Add condition'), findsWidgets);
    expect(find.text('Value condition'), findsOneWidget);
    expect(find.text('Condition group'), findsOneWidget);
    await tester.tap(find.text('Condition group'));
    await tester.pumpAndSettle();
    expect(find.text('All conditions match'), findsOneWidget);

    await tester.tap(find.text('All conditions match'));
    await tester.pumpAndSettle();
    expect(find.text('No conditions'), findsOneWidget);

    await tester.tap(find.text('All conditions match'));
    await tester.pumpAndSettle();
    await tester.tap(
      find.widgetWithText(ElevatedButton, 'Add condition').first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Value condition'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Value exists'),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(find.text('Value exists'));
    await tester.pumpAndSettle();
    expect(find.text('Notification details'), findsNothing);
    expect(find.text('Literal value'), findsNothing);
    expect(
      find.widgetWithText(DialogExpanderCard, 'Extractor capture'),
      findsOneWidget,
    );
    await tester.tap(find.text('Value'));
    await tester.pumpAndSettle();

    expect(find.textContaining('1 condition'), findsOneWidget);
    expect(conditionTitle('Extractor "Value" value exists'), findsOneWidget);
    final Text title = tester.widget<Text>(
      conditionTitle('Extractor "Value" value exists'),
    );
    final TextSpan titleSpan = title.textSpan! as TextSpan;
    final TextSpan openingQuoteSpan = titleSpan.children![1] as TextSpan;
    final TextSpan extractorNameSpan = titleSpan.children![2] as TextSpan;
    final TextSpan closingQuoteSpan = titleSpan.children![3] as TextSpan;
    expect(openingQuoteSpan.text, '"');
    expect(extractorNameSpan.text, 'Value');
    expect(closingQuoteSpan.text, '"');
    expect(
      extractorNameSpan.style?.color,
      Theme.of(
        tester.element(conditionTitle('Extractor "Value" value exists')),
      ).colorScheme.primary,
    );
    expect(openingQuoteSpan.style, isNull);
    expect(closingQuoteSpan.style, isNull);
    expect(find.text('Capture: value'), findsOneWidget);
    final Finder deleteConditionButton = find.ancestor(
      of: find.byTooltip('Delete condition'),
      matching: find.byType(IconButton),
    );
    expect(deleteConditionButton, findsOneWidget);
    final IconButton deleteCondition = tester.widget<IconButton>(
      deleteConditionButton,
    );
    expect(deleteCondition.iconSize, 18);
    expect(
      deleteCondition.style?.minimumSize?.resolve(<WidgetState>{}),
      const Size(40, 40),
    );

    final Finder conditionCard = find
        .ancestor(
          of: conditionTitle('Extractor "Value" value exists'),
          matching: find.byType(ElevatedButton),
        )
        .first;
    await tester.ensureVisible(conditionCard);
    await tester.drag(find.byType(ListView), const Offset(0, 72));
    await tester.pumpAndSettle();
    await tester.tap(
      find.descendant(
        of: conditionCard,
        matching: find.byIcon(Icons.more_vert),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();

    expect(find.text('Value exists'), findsOneWidget);
    expect(
      find.widgetWithText(DialogExpanderCard, 'Extractor capture'),
      findsOneWidget,
    );
  });

  testWidgets('replaces a nested leaf condition', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[
              AllCondition(<NotificationCondition>[
                ValueExistsCondition(LiteralValueSource('before')),
              ]),
            ],
            actions: <NotificationAction>[],
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid negated',
            receivedAt: DateTime(2026, 9, 1),
          ),
        ),
      ),
    );

    await tester.tap(find.text('All conditions match'));
    await tester.pumpAndSettle();
    expect(conditionTitle('"before" exists'), findsOneWidget);
    final Text literalTitle = tester.widget<Text>(
      conditionTitle('"before" exists'),
    );
    final TextSpan literalTitleSpan = literalTitle.textSpan! as TextSpan;
    final TextSpan literalOpeningQuote =
        literalTitleSpan.children![0] as TextSpan;
    final TextSpan literalValue = literalTitleSpan.children![1] as TextSpan;
    final TextSpan literalClosingQuote =
        literalTitleSpan.children![2] as TextSpan;
    expect(literalOpeningQuote.text, '"');
    expect(literalValue.text, 'before');
    expect(literalClosingQuote.text, '"');
    expect(literalOpeningQuote.style, isNull);
    expect(literalClosingQuote.style, isNull);
    expect(
      literalValue.style?.color,
      Theme.of(
        tester.element(conditionTitle('"before" exists')),
      ).colorScheme.primary,
    );

    final Finder leafCard = find
        .ancestor(
          of: conditionTitle('"before" exists'),
          matching: find.byType(ElevatedButton),
        )
        .first;
    await tester.tap(
      find.descendant(of: leafCard, matching: find.byIcon(Icons.more_vert)),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();
    expect(find.text('Value exists'), findsOneWidget);
    expect(find.text('Extractor capture'), findsNothing);
  });

  testWidgets('keeps configured expressions and shows sample operands', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition extractor =
        RegExpDefinition.createCustomRegExpDefinition(
          'Amount',
          r'(?<amount>12.50)',
        );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[
              ValuesEqualCondition(
                left: RegExpCaptureValueSource(
                  extractorId: extractor.id,
                  captureName: 'amount',
                ),
                right: const LiteralValueSource('12.50'),
              ),
            ],
            actions: <NotificationAction>[],
          ),
          extractors: <RegExpDefinition>[extractor],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12.50',
            receivedAt: DateTime(2026, 9, 1),
          ),
          initialTestMode: true,
        ),
      ),
    );

    expect(
      conditionTitle('Extractor "Amount" value equals "12.50"'),
      findsOneWidget,
    );
    expect(
      find.textContaining('Matches · Sample value: 12.50'),
      findsOneWidget,
    );
    expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
    expect(find.text('Capture: amount'), findsNothing);
    expect(find.textContaining('Right value:'), findsNothing);
    expect(find.textContaining('Resolved example value'), findsNothing);
  });

  testWidgets('shows unresolved values beside affected conditions', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition extractor =
        RegExpDefinition.createCustomRegExpDefinition(
          'Amount',
          r'(?<amount>\d+)',
        );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[
              ValueExistsCondition(
                RegExpCaptureValueSource(
                  extractorId: extractor.id,
                  captureName: 'amount',
                ),
              ),
            ],
            actions: const <NotificationAction>[],
          ),
          extractors: <RegExpDefinition>[extractor],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'No amount here',
            receivedAt: DateTime(2026, 9, 1),
          ),
        ),
      ),
    );

    final double conditionsTopBefore = tester
        .getTopLeft(find.text('Applies when'))
        .dy;
    await tester.tap(find.byTooltip('Enter test mode'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 90));
    expect(find.textContaining('Could not evaluate'), findsOneWidget);
    expect(find.text('Sample value issues'), findsOneWidget);
    expect(find.text('Amount'), findsOneWidget);
    expect(find.text('No sample match'), findsOneWidget);
    final FadeTransition issuesFade = tester.widget<FadeTransition>(
      find.byKey(const Key('rule-sample-value-issues-fade')),
    );
    expect(issuesFade.opacity.value, greaterThan(0));
    expect(issuesFade.opacity.value, lessThan(1));
    expect(
      tester.getTopLeft(find.text('Applies when')).dy,
      greaterThan(conditionsTopBefore),
    );
    await tester.pumpAndSettle();
  });

  testWidgets('uses a date extractor before choosing a comparison literal', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition dateExtractor =
        RegExpDefinition.createPredefinedRegExpDefinition(
          PredefinedRegExpDefinition.notificationDate,
        );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
          extractors: <RegExpDefinition>[dateExtractor],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12.50 CAD',
            receivedAt: DateTime(2026, 9, 1, 10, 30),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Add condition'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Value condition'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Greater than'),
      200,
      scrollable: find.descendant(
        of: find.byKey(const ValueKey<String>('condition-kinds-0')),
        matching: find.byType(Scrollable),
      ),
    );
    await tester.tap(find.text('Greater than'));
    await tester.pumpAndSettle();
    expect(find.text('Greater than'), findsOneWidget);

    expect(
      find.widgetWithText(DialogExpanderCard, 'Extractor capture'),
      findsOneWidget,
    );
    expect(find.text('Literal value'), findsNothing);
    expect(find.text('Notification date and time'), findsOneWidget);
    final DateTime value = DateTime(2026, 9, 1, 10, 30);
    final String formattedValue = formatNotificationDateTime(
      tester.element(find.text('Notification date and time')),
      value,
    );
    expect(richText('Resolved value: "$formattedValue"'), findsOneWidget);

    await tester.tap(find.text('Notification date and time'));
    await tester.pumpAndSettle();

    expect(find.text('Greater than'), findsOneWidget);
    expect(find.text('Date and time value'), findsOneWidget);
    expect(find.byKey(const Key('condition-literal-value')), findsOneWidget);
    expect(find.text('Choose date and time'), findsOneWidget);
  });

  testWidgets('formats date literals in condition summaries', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition dateExtractor =
        RegExpDefinition.createPredefinedRegExpDefinition(
          PredefinedRegExpDefinition.notificationDate,
        );
    final DateTime notificationDate = DateTime(2026, 9, 1, 10, 30);
    final DateTime literalDate = DateTime(2026, 9, 2);
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[
              ValuesGreaterThanCondition(
                left: RegExpCaptureValueSource(
                  extractorId: dateExtractor.id,
                  captureName: 'date',
                  matchIndex: 0,
                ),
                right: const LiteralValueSource('2026-09-02'),
              ),
            ],
            actions: const <NotificationAction>[],
          ),
          extractors: <RegExpDefinition>[dateExtractor],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12.50 CAD',
            receivedAt: notificationDate,
          ),
        ),
      ),
    );

    final String formattedDate = formatNotificationDate(
      tester.element(find.byType(NotificationRuleDetailsPage)),
      literalDate,
    );
    final Finder conditionTitleFinder = conditionTitle(
      'Extractor "Notification date and time" value is greater than "$formattedDate"',
    );
    expect(conditionTitleFinder, findsOneWidget);

    final Finder conditionCard = find
        .ancestor(
          of: conditionTitleFinder,
          matching: find.byType(ElevatedButton),
        )
        .first;
    await tester.tap(
      find.descendant(
        of: conditionCard,
        matching: find.byIcon(Icons.more_vert),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();

    expect(
      find.descendant(
        of: find.byKey(const ValueKey<String>('condition-edit-right')),
        matching: find.text(formattedDate),
      ),
      findsOneWidget,
    );
  });

  testWidgets('only offers text extractor captures for contains conditions', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition textExtractor =
        RegExpDefinition.createCustomRegExpDefinition(
          'Merchant',
          r'(?<merchant>[A-Z]+)',
        );
    final RegExpDefinition numberExtractor =
        RegExpDefinition.createCustomRegExpDefinition(
          'Amount',
          r'(?<amount>\d+)',
        );
    final RegExpDefinition dateExtractor =
        RegExpDefinition.createPredefinedRegExpDefinition(
          PredefinedRegExpDefinition.notificationDate,
        );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
          extractors: <RegExpDefinition>[
            textExtractor,
            numberExtractor,
            dateExtractor,
          ],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'SHOP 12',
            receivedAt: DateTime(2026, 9, 1, 10, 30),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Add condition'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Value condition'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Contains text'),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(find.text('Contains text'));
    await tester.pumpAndSettle();

    expect(find.text('Merchant'), findsOneWidget);
    expect(find.text('Amount'), findsNothing);
    expect(find.text('Notification date and time'), findsNothing);
  });

  testWidgets('matches equals operands by the left extractor type', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition dateExtractor =
        RegExpDefinition.fromJson(<String, dynamic>{
          'id': 'created-at',
          'name': 'Created at',
          'source': r'Created (?<date>\d{4}-\d{2}-\d{2}T[\d:.]+)',
          'type': RegExpDefinitionType.custom.index,
          'isRequiredForMatch': false,
        });
    final RegExpDefinition alternateDateExtractor =
        RegExpDefinition.fromJson(<String, dynamic>{
          'id': 'processed-at',
          'name': 'Processed at',
          'source': r'Processed (?<date>\d{4}-\d{2}-\d{2}T[\d:.]+)',
          'type': RegExpDefinitionType.custom.index,
          'isRequiredForMatch': false,
        });
    final RegExpDefinition numberExtractor =
        RegExpDefinition.fromJson(<String, dynamic>{
          'id': 'amount',
          'name': 'Amount',
          'source': r'(?<amount>\d+)',
          'type': RegExpDefinitionType.custom.index,
          'isRequiredForMatch': false,
        });
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
          extractors: <RegExpDefinition>[
            dateExtractor,
            alternateDateExtractor,
            numberExtractor,
          ],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body:
                'Created 2026-09-01T10:30:00 Processed 2026-09-02T11:30:00 Amount 12',
            receivedAt: DateTime(2026, 9, 1, 10, 30),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Add condition'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Value condition'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Equals value'),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(find.text('Equals value'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Created at'));
    await tester.pumpAndSettle();

    expect(find.text('Date and time value'), findsOneWidget);
    await tester.tap(
      find.widgetWithText(DialogExpanderCard, 'Extractor capture'),
    );
    await tester.pumpAndSettle();
    expect(find.text('Processed at'), findsOneWidget);
    expect(find.text('Amount'), findsNothing);
    await tester.tap(
      find.widgetWithText(DialogExpanderCard, 'Date and time value'),
    );
    await tester.pumpAndSettle();
    expect(find.text('Choose date and time'), findsOneWidget);
  });

  testWidgets('does not offer the first operand extractor a second time', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition first = RegExpDefinition.fromJson(<String, dynamic>{
      'id': 'first',
      'name': 'First',
      'source': r'(?<value>one)',
      'type': RegExpDefinitionType.custom.index,
      'isRequiredForMatch': false,
    });
    final RegExpDefinition second = RegExpDefinition.fromJson(<String, dynamic>{
      'id': 'second',
      'name': 'Second',
      'source': r'(?<value>two)',
      'type': RegExpDefinitionType.custom.index,
      'isRequiredForMatch': false,
    });
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
          extractors: <RegExpDefinition>[first, second],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'one two',
            receivedAt: DateTime(2026, 9, 1),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Add condition'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Value condition'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Equals value'),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(find.text('Equals value'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('First'));
    await tester.pumpAndSettle();

    await tester.tap(
      find.widgetWithText(DialogExpanderCard, 'Extractor capture'),
    );
    await tester.pumpAndSettle();
    expect(find.text('First'), findsNothing);
    expect(find.text('Second'), findsOneWidget);
  });

  testWidgets('only offers a literal when no second extractor is available', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition extractor =
        RegExpDefinition.fromJson(<String, dynamic>{
          'id': 'only',
          'name': 'Only',
          'source': r'(?<value>one)',
          'type': RegExpDefinitionType.custom.index,
          'isRequiredForMatch': false,
        });
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
          extractors: <RegExpDefinition>[extractor],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'one',
            receivedAt: DateTime(2026, 9, 6),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Add condition'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Value condition'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Equals value'),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(find.text('Equals value'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Only'));
    await tester.pumpAndSettle();

    expect(find.text('Extractor capture'), findsNothing);
    expect(find.text('Literal value'), findsAtLeastNWidgets(2));
    expect(find.byKey(const Key('condition-literal-value')), findsOneWidget);
  });

  testWidgets('omits the current action extractor while editing', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final RegExpDefinition currentExtractor =
        RegExpDefinition.createCustomRegExpDefinition(
          'Current extractor',
          r'(?<value>first)',
        );
    final RegExpDefinition alternateExtractor =
        RegExpDefinition.createCustomRegExpDefinition(
          'Alternate extractor',
          r'(?<value>second)',
        );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: const <NotificationCondition>[],
            actions: <NotificationAction>[
              SetTransactionFieldAction(
                target: TransactionField.title,
                valueSource: RegExpCaptureValueSource(
                  extractorId: currentExtractor.id,
                  captureName: 'value',
                  matchIndex: 0,
                ),
              ),
            ],
          ),
          extractors: <RegExpDefinition>[currentExtractor, alternateExtractor],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'first second',
            receivedAt: DateTime(2026, 9, 6),
          ),
        ),
      ),
    );

    final Finder actionCard = find
        .ancestor(
          of: richText('Set field "title" from extractor "Current extractor"'),
          matching: find.byType(ElevatedButton),
        )
        .first;
    await tester.ensureVisible(actionCard);
    await tester.pumpAndSettle();
    await tester.tap(actionCard);
    await tester.pumpAndSettle();
    await tester.tap(
      find.widgetWithText(DialogExpanderCard, 'Extractor capture'),
    );
    await tester.pumpAndSettle();

    expect(find.text('Current extractor'), findsNothing);
    expect(find.text('Alternate extractor'), findsOneWidget);
  });

  testWidgets('describes literal action sources without repeating values', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[
              SetTransactionFieldAction(
                target: TransactionField.category,
                valueSource: LiteralValueSource('Food'),
              ),
              SetTransactionFieldAction(
                target: TransactionField.title,
                valueSource: FireflyResourceValueSource(
                  resourceKind: FireflyResourceKind.category,
                  resourceId: '42',
                ),
              ),
            ],
          ),
          extractors: <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12 CAD',
            receivedAt: DateTime(2026, 9, 23),
          ),
        ),
      ),
    );

    final Finder literalSummary = richText(
      'Set field "category" to literal value',
    );
    final Finder fireflySummary = richText(
      'Set field "title" to Firefly supplied value',
    );
    expect(literalSummary, findsOneWidget);
    expect(fireflySummary, findsOneWidget);
    final Text literalText = tester.widget<Text>(literalSummary);
    final Text fireflyText = tester.widget<Text>(fireflySummary);
    expect((literalText.textSpan! as TextSpan).children!.last.style, isNull);
    expect((fireflyText.textSpan! as TextSpan).children!.last.style, isNull);
    expect(find.textContaining('Resolved value: "Food"'), findsOneWidget);
  });

  testWidgets('inspects extracted sample values in test mode', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition actionExtractor =
        RegExpDefinition.createCustomRegExpDefinition(
          'Merchant',
          r'at (?<vendor>.+)',
        );
    final RegExpDefinition conditionalActionExtractor =
        RegExpDefinition.createCustomRegExpDefinition(
          'Account',
          r'from (?<account>.+)',
        );
    final RegExpDefinition sharedActionExtractor =
        RegExpDefinition.createCustomRegExpDefinition(
          'Time',
          r'at (?<time>\d{2}:\d{2})',
        );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: const <NotificationCondition>[],
            actions: <NotificationAction>[
              SetTransactionFieldAction(
                target: TransactionField.title,
                valueSource: RegExpCaptureValueSource(
                  extractorId: actionExtractor.id,
                  captureName: 'vendor',
                ),
              ),
            ],
            conditionalActionGroups: <NotificationActionGroup>[
              NotificationActionGroup(
                id: 'account',
                name: 'Account source',
                conditions: const <NotificationCondition>[
                  ValueExistsCondition(LiteralValueSource('deposit')),
                ],
                actions: <NotificationAction>[
                  SetTransactionFieldAction(
                    target: TransactionField.sourceAccount,
                    valueSource: RegExpCaptureValueSource(
                      extractorId: conditionalActionExtractor.id,
                      captureName: 'account',
                    ),
                  ),
                ],
              ),
            ],
          ),
          sharedActions: <NotificationAction>[
            SetTransactionFieldAction(
              target: TransactionField.time,
              valueSource: RegExpCaptureValueSource(
                extractorId: sharedActionExtractor.id,
                captureName: 'time',
              ),
            ),
          ],
          extractors: <RegExpDefinition>[
            actionExtractor,
            conditionalActionExtractor,
            sharedActionExtractor,
          ],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid at Corner Store from Wallet',
            receivedAt: DateTime(2026, 9, 6),
          ),
        ),
      ),
    );

    expect(find.text('Required extractors'), findsNothing);
    expect(find.text('Sample value issues'), findsNothing);

    await tester.tap(find.byTooltip('Enter test mode'));
    await tester.pumpAndSettle();
    expect(find.text('Sample value issues'), findsOneWidget);
    expect(find.text('Merchant'), findsNothing);
    expect(find.text('Account'), findsNothing);
    expect(find.text('Time'), findsOneWidget);
    expect(find.text('Inherited from shared actions'), findsOneWidget);
    expect(find.text('No sample match'), findsOneWidget);
  });

  testWidgets('lists captures shared by every any-condition branch', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition extractor =
        RegExpDefinition.createCustomRegExpDefinition(
          'Vendor',
          r'at (?<vendor>.+)',
        );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: NotificationRule(
            id: 'rule',
            name: 'Grocery',
            conditions: <NotificationCondition>[
              AnyCondition(<NotificationCondition>[
                ValueContainsCondition(
                  value: RegExpCaptureValueSource(
                    extractorId: extractor.id,
                    captureName: 'vendor',
                  ),
                  substring: const LiteralValueSource('Walmart'),
                ),
                ValueContainsCondition(
                  value: RegExpCaptureValueSource(
                    extractorId: extractor.id,
                    captureName: 'vendor',
                  ),
                  substring: const LiteralValueSource('Save On Foods'),
                ),
              ]),
            ],
            actions: const <NotificationAction>[
              SetTransactionFieldAction(
                target: TransactionField.category,
                valueSource: LiteralValueSource('Food'),
              ),
            ],
          ),
          extractors: <RegExpDefinition>[extractor],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid at VENDOR',
            receivedAt: DateTime(2026, 9, 20),
          ),
        ),
      ),
    );

    await tester.tap(find.byTooltip('Enter test mode'));
    await tester.pumpAndSettle();
    expect(find.text('Sample value issues'), findsNothing);
    expect(find.text('Required extractors'), findsNothing);
    expect(find.text('Does not match'), findsWidgets);
    expect(find.text('0 of 2 match'), findsOneWidget);
    expect(find.byIcon(Icons.circle_outlined), findsWidgets);
  });

  testWidgets('opens an extractor from a sample value issue', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition alpha =
        RegExpDefinition.createCustomRegExpDefinition('Alpha', r'(?<value>a)');
    final RegExpDefinition zoo = RegExpDefinition.createCustomRegExpDefinition(
      'Zoo',
      r'(?<value>z)',
    );
    String? openedExtractorId;
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: NotificationRule(
            id: 'rule',
            name: 'Rule',
            conditions: <NotificationCondition>[
              ValueExistsCondition(
                RegExpCaptureValueSource(
                  extractorId: zoo.id,
                  captureName: 'value',
                ),
              ),
              ValueExistsCondition(
                RegExpCaptureValueSource(
                  extractorId: alpha.id,
                  captureName: 'value',
                ),
              ),
            ],
            actions: const <NotificationAction>[
              SetTransactionFieldAction(
                target: TransactionField.category,
                valueSource: LiteralValueSource('Food'),
              ),
            ],
          ),
          extractors: <RegExpDefinition>[zoo, alpha],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'z',
            receivedAt: DateTime(2026, 9, 20),
          ),
          onEditExtractor: (RegExpDefinition extractor) async {
            openedExtractorId = extractor.id;
          },
        ),
      ),
    );

    await tester.tap(find.byTooltip('Enter test mode'));
    await tester.pumpAndSettle();
    expect(find.text('Sample value issues'), findsOneWidget);
    expect(find.text('Alpha'), findsOneWidget);
    expect(find.text('Zoo'), findsNothing);
    await tester.tap(find.text('Alpha'));
    await tester.pumpAndSettle();
    expect(openedExtractorId, alpha.id);
  });

  testWidgets('hides sample value issues when no values are required', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
          extractors: <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12.50 CAD',
            receivedAt: DateTime(2026, 9, 6),
          ),
        ),
      ),
    );

    expect(find.text('Sample value issues'), findsNothing);
    await tester.tap(find.byTooltip('Enter test mode'));
    await tester.pumpAndSettle();
    expect(find.text('Sample value issues'), findsNothing);
  });

  testWidgets('summarizes matched and unresolved group children', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Grocery',
            conditions: <NotificationCondition>[
              AnyCondition(<NotificationCondition>[
                ValueExistsCondition(LiteralValueSource('present')),
                ValueExistsCondition(
                  RegExpCaptureValueSource(
                    extractorId: 'missing-extractor',
                    captureName: 'value',
                  ),
                ),
              ]),
            ],
            actions: <NotificationAction>[],
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid at Corner Store',
            receivedAt: DateTime(2026, 9, 20),
          ),
        ),
      ),
    );

    await tester.tap(find.byTooltip('Enter test mode'));
    await tester.pumpAndSettle();

    expect(find.text('Matches'), findsWidgets);
    expect(
      find.text('1 of 2 match · 1 could not be evaluated'),
      findsOneWidget,
    );
  });

  testWidgets(
    'formats resolved date-time action values for the system locale',
    (WidgetTester tester) async {
      final RegExpDefinition extractor =
          RegExpDefinition.createPredefinedRegExpDefinition(
            PredefinedRegExpDefinition.notificationDate,
          );
      final DateTime receivedAt = DateTime(2026, 9, 6, 9, 22);
      await tester.pumpWidget(
        MaterialApp(
          home: NotificationRuleDetailsPage(
            rule: NotificationRule(
              id: 'rule',
              name: 'Card payment',
              conditions: const <NotificationCondition>[],
              actions: <NotificationAction>[
                SetTransactionFieldAction(
                  target: TransactionField.date,
                  valueSource: DateTimeCaptureValueSource(
                    capture: RegExpCaptureValueSource(
                      extractorId: extractor.id,
                      captureName: 'date',
                      matchIndex: 0,
                    ),
                    field: TransactionField.date,
                    normalizedValue: '2026-09-06',
                    deriveFromCapture: true,
                  ),
                ),
              ],
            ),
            extractors: <RegExpDefinition>[extractor],
            notificationContext: NotificationContext(
              title: 'Card payment',
              body: 'Paid 12.50 CAD',
              receivedAt: receivedAt,
            ),
          ),
        ),
      );

      final BuildContext context = tester.element(
        find.byType(NotificationRuleDetailsPage),
      );
      final String formatted = formatNotificationDateTime(context, receivedAt);
      await tester.scrollUntilVisible(
        find.textContaining('Resolved value: "$formatted"'),
        100,
        scrollable: find.byType(Scrollable).first,
      );
      expect(
        find.textContaining('Resolved value: "$formatted"'),
        findsOneWidget,
      );
      final Finder actionSummary = richText(
        'Set field "date" from extractor "Notification date and time"',
      );
      final Text actionSummaryText = tester.widget<Text>(actionSummary);
      final TextSpan actionSummarySpan =
          actionSummaryText.textSpan! as TextSpan;
      final TextSpan fieldOpeningQuote =
          actionSummarySpan.children![0] as TextSpan;
      final TextSpan fieldValue = actionSummarySpan.children![1] as TextSpan;
      final TextSpan fieldClosingQuote =
          actionSummarySpan.children![2] as TextSpan;
      final TextSpan extractorOpeningQuote =
          actionSummarySpan.children![4] as TextSpan;
      final TextSpan extractorValue =
          actionSummarySpan.children![5] as TextSpan;
      final TextSpan extractorClosingQuote =
          actionSummarySpan.children![6] as TextSpan;
      expect(fieldOpeningQuote.style, isNull);
      expect(fieldClosingQuote.style, isNull);
      expect(extractorOpeningQuote.style, isNull);
      expect(extractorClosingQuote.style, isNull);
      expect(fieldValue.style?.color, Theme.of(context).colorScheme.primary);
      expect(
        extractorValue.style?.color,
        Theme.of(context).colorScheme.primary,
      );

      final Finder actionStatus = find.byWidgetPredicate(
        (Widget widget) =>
            widget is Text &&
            (widget.textSpan?.toPlainText().startsWith(
                  'Resolved value: "$formatted"',
                ) ??
                false),
        description: 'resolved date-time action status',
      );
      final Text actionStatusText = tester.widget<Text>(actionStatus);
      final TextSpan actionStatusSpan = actionStatusText.textSpan! as TextSpan;
      expect((actionStatusSpan.children![1] as TextSpan).style, isNull);
      expect(
        (actionStatusSpan.children![2] as TextSpan).style?.color,
        Theme.of(context).colorScheme.onSurface,
      );
      expect((actionStatusSpan.children![3] as TextSpan).style, isNull);
    },
  );

  testWidgets('uses an extractor before choosing contained text', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition extractor =
        RegExpDefinition.createCustomRegExpDefinition(
          'Message',
          r'(?<message>Payment received)',
        );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
          extractors: <RegExpDefinition>[extractor],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Payment received',
            receivedAt: DateTime(2026, 9, 1),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Add condition'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Value condition'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Contains text'),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(find.text('Contains text'));
    await tester.pumpAndSettle();

    expect(find.text('Literal value'), findsNothing);
    await tester.tap(find.text('Message'));
    await tester.pumpAndSettle();
    expect(find.text('Literal value'), findsAtLeastNWidgets(2));
  });

  testWidgets('creates a not condition with its required child', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition extractor =
        RegExpDefinition.createCustomRegExpDefinition(
          'Value',
          r'(?<value>negated)',
        );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
          extractors: <RegExpDefinition>[extractor],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid negated',
            receivedAt: DateTime(2026, 9, 1),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Add condition'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Condition group'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Condition does not match'));
    await tester.pumpAndSettle();
    expect(find.text('Condition does not match'), findsOneWidget);
    await tester.tap(find.text('Value condition'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Value exists'),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(find.text('Value exists'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Value'));
    await tester.pumpAndSettle();

    expect(find.text('Condition does not match'), findsOneWidget);
    await tester.tap(find.text('Condition does not match'));
    await tester.pumpAndSettle();
    expect(conditionTitle('Extractor "Value" value exists'), findsOneWidget);
    expect(find.byTooltip('Delete condition'), findsNothing);
  });

  testWidgets('edits either side of a binary condition from its overview', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition titleExtractor =
        RegExpDefinition.createPredefinedRegExpDefinition(
          PredefinedRegExpDefinition.notificationTitle,
        );
    final RegExpDefinition messageExtractor =
        RegExpDefinition.fromJson(<String, dynamic>{
          'id': 'message',
          'name': 'Notification message',
          'source': r'(?<message>[\s\S]+)',
          'type': RegExpDefinitionType.custom.index,
          'isRequiredForMatch': false,
        });
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[
              ValuesEqualCondition(
                left: RegExpCaptureValueSource(
                  extractorId: titleExtractor.id,
                  captureName: 'title',
                  matchIndex: 0,
                ),
                right: const LiteralValueSource('Wise'),
              ),
            ],
            actions: <NotificationAction>[],
          ),
          extractors: <RegExpDefinition>[titleExtractor, messageExtractor],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12.50 CAD',
            receivedAt: DateTime(2026, 9, 1),
          ),
        ),
      ),
    );

    final Finder conditionCard = find
        .ancestor(
          of: conditionTitle(
            'Extractor "Notification title" value equals "Wise"',
          ),
          matching: find.byType(ElevatedButton),
        )
        .first;
    await tester.tap(
      find.descendant(
        of: conditionCard,
        matching: find.byIcon(Icons.more_vert),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();

    expect(find.text('equals'), findsOneWidget);
    expect(
      find.byKey(const ValueKey<String>('condition-edit-left')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey<String>('condition-edit-right')),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byKey(const ValueKey<String>('condition-edit-left')),
        matching: find.text('Extractor capture'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byKey(const ValueKey<String>('condition-edit-left')),
        matching: find.byType(AnimatedRotation),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byKey(const ValueKey<String>('condition-edit-right')),
        matching: find.byType(AnimatedRotation),
      ),
      findsOneWidget,
    );
    expect(
      tester
          .widget<FilledButton>(find.widgetWithText(FilledButton, 'Save'))
          .onPressed,
      isNull,
    );
    expect(find.text('Back'), findsNothing);

    await tester.tap(
      find.byKey(const ValueKey<String>('condition-edit-right')),
    );
    await tester.pumpAndSettle();
    expect(find.text('Equals value'), findsOneWidget);
    expect(find.text('Choose the value to compare with.'), findsOneWidget);
    expect(
      tester
          .widget<AnimatedRotation>(
            find.descendant(
              of: find.byKey(const ValueKey<String>('condition-edit-right')),
              matching: find.byType(AnimatedRotation),
            ),
          )
          .turns,
      0.5,
    );
    expect(
      find.descendant(
        of: find.byKey(const ValueKey<String>('condition-edit-right')),
        matching: find.byKey(const Key('condition-literal-value')),
      ),
      findsOneWidget,
    );
    expect(find.widgetWithText(FilledButton, 'Use literal'), findsNothing);
    expect(
      tester
          .widget<FilledButton>(find.widgetWithText(FilledButton, 'Save'))
          .onPressed,
      isNull,
    );
    await tester.enterText(
      find.descendant(
        of: find.byKey(const ValueKey<String>('condition-edit-right')),
        matching: find.byKey(const Key('condition-literal-value')),
      ),
      'Revolut',
    );
    await tester.pump();
    expect(
      tester
          .widget<FilledButton>(find.widgetWithText(FilledButton, 'Save'))
          .onPressed,
      isNotNull,
    );
    await tester.enterText(
      find.descendant(
        of: find.byKey(const ValueKey<String>('condition-edit-right')),
        matching: find.byKey(const Key('condition-literal-value')),
      ),
      'Wise',
    );
    await tester.pump();
    expect(
      tester
          .widget<FilledButton>(find.widgetWithText(FilledButton, 'Save'))
          .onPressed,
      isNull,
    );
    await tester.tap(
      find.descendant(
        of: find.byKey(const ValueKey<String>('condition-edit-right')),
        matching: find.byIcon(Icons.more_vert),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Change type'), findsNothing);
    expect(find.text('Extractor capture'), findsNWidgets(2));
    await tester.tap(find.text('Extractor capture').last);
    await tester.pumpAndSettle();
    expect(
      find.descendant(
        of: find.byKey(const ValueKey<String>('condition-edit-right')),
        matching: find.text('Extractor capture'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byKey(const ValueKey<String>('condition-edit-right')),
        matching: find.text('Wise'),
      ),
      findsNothing,
    );
    expect(find.text('Notification message'), findsOneWidget);
    await tester.tap(find.text('Notification message'));
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<FilledButton>(find.widgetWithText(FilledButton, 'Save'))
          .onPressed,
      isNotNull,
    );
  });

  testWidgets('shows group paste only when a condition is copied', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[
              AllCondition(<NotificationCondition>[]),
            ],
            actions: <NotificationAction>[],
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12.50 CAD',
            receivedAt: DateTime(2026, 9, 1),
          ),
        ),
      ),
    );

    final Finder groupCard = find
        .ancestor(
          of: find.text('All conditions match'),
          matching: find.byType(ElevatedButton),
        )
        .first;
    expect(
      find.descendant(of: groupCard, matching: find.byIcon(Icons.expand_more)),
      findsOneWidget,
    );
    expect(
      find.descendant(of: groupCard, matching: find.byIcon(Icons.more_vert)),
      findsNothing,
    );
    expect(find.byTooltip('Paste'), findsNothing);

    await tester.tap(groupCard);
    await tester.pumpAndSettle();

    expect(find.byTooltip('Delete condition'), findsOneWidget);
  });

  testWidgets('aligns the condition group chevron with nested card actions', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[
              AnyCondition(<NotificationCondition>[
                ValueExistsCondition(LiteralValueSource('merchant')),
              ]),
            ],
            actions: <NotificationAction>[],
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12 CAD',
            receivedAt: DateTime(2026, 9, 1),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Any condition matches'));
    await tester.pumpAndSettle();

    final Finder groupHeader = find
        .ancestor(
          of: find.text('Any condition matches'),
          matching: find.byType(ElevatedButton),
        )
        .first;
    final Finder chevron = find.descendant(
      of: groupHeader,
      matching: find.byIcon(Icons.expand_more),
    );
    final Finder nestedMenu = find.descendant(
      of: find.byTooltip('Condition options'),
      matching: find.byIcon(Icons.more_vert),
    );
    expect(chevron, findsOneWidget);
    expect(nestedMenu, findsOneWidget);
    expect(
      tester.getCenter(chevron).dx,
      closeTo(tester.getCenter(nestedMenu).dx, 1),
    );

    await tester.tap(find.byTooltip('Enter test mode'));
    await tester.pumpAndSettle();
    expect(
      tester.getCenter(chevron).dx,
      closeTo(tester.getCenter(nestedMenu).dx, 1),
    );
  });

  testWidgets('selects a condition value from an expanded extractor', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition extractor =
        RegExpDefinition.createCustomRegExpDefinition(
          'Merchant',
          r'Paid (?<merchant>[A-Z]+)',
        );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
          extractors: <RegExpDefinition>[extractor],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid SHOP',
            receivedAt: DateTime(2026, 9, 1),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Add condition'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Value condition'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Value exists'),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(find.text('Value exists'));
    await tester.pumpAndSettle();
    expect(richText('Resolved value: "SHOP"'), findsOneWidget);
    await tester.tap(find.text('Merchant'));
    await tester.pumpAndSettle();

    expect(conditionTitle('Extractor "Merchant" value exists'), findsOneWidget);
    expect(find.text('Capture: merchant'), findsOneWidget);
  });

  testWidgets('shows match choices for a multi-match extractor', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition extractor =
        RegExpDefinition.createCustomRegExpDefinition(
          'Merchants',
          r'Paid (?<merchant>[A-Z]+)',
        );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
          extractors: <RegExpDefinition>[extractor],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid SHOP and Paid CAFE',
            receivedAt: DateTime(2026, 9, 1),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Add condition'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Value condition'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Value exists'),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(find.text('Value exists'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Merchants'));
    await tester.pumpAndSettle();

    expect(richText('Match 1 - Group "merchant"'), findsOneWidget);
    expect(richText('Match 2 - Group "merchant"'), findsOneWidget);
    expect(richText('Resolved value: "SHOP"'), findsOneWidget);
  });

  testWidgets('keeps deeper capture choices inside the extractor expander', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition extractor =
        RegExpDefinition.createCustomRegExpDefinition(
          'Payment',
          r'(?<merchant>[A-Z]+) (?<amount>\d+)',
        );
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[],
            actions: <NotificationAction>[],
          ),
          extractors: <RegExpDefinition>[extractor],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'SHOP 12',
            receivedAt: DateTime(2026, 9, 1),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Add condition'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Value condition'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Value exists'),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(find.text('Value exists'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Payment'));
    await tester.pumpAndSettle();

    expect(
      find.byKey(const ValueKey<String>('capture-groups')),
      findsOneWidget,
    );
    expect(richText('Group "merchant"'), findsOneWidget);
    expect(richText('Resolved value: "SHOP"'), findsOneWidget);
    expect(richText('Group "amount"'), findsOneWidget);
    expect(richText('Resolved value: "12"'), findsOneWidget);
  });

  testWidgets('removes a nested group condition after confirmation', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[
              AllCondition(<NotificationCondition>[
                ValueExistsCondition(LiteralValueSource('before')),
              ]),
            ],
            actions: <NotificationAction>[],
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12.50 CAD',
            receivedAt: DateTime(2026, 9, 1),
          ),
        ),
      ),
    );

    await tester.tap(find.text('All conditions match'));
    await tester.pumpAndSettle();
    final Finder leafCard = find
        .ancestor(
          of: conditionTitle('"before" exists'),
          matching: find.byType(ElevatedButton),
        )
        .first;
    await tester.tap(
      find.descendant(of: leafCard, matching: find.byIcon(Icons.more_vert)),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Remove'));
    await tester.pumpAndSettle();

    expect(conditionTitle('"before" exists'), findsNothing);
    expect(find.text('No conditions'), findsOneWidget);
  });

  testWidgets('limits condition groups to three levels', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[
              AllCondition(<NotificationCondition>[
                AnyCondition(<NotificationCondition>[
                  AllCondition(<NotificationCondition>[]),
                ]),
              ]),
            ],
            actions: <NotificationAction>[],
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12.50 CAD',
            receivedAt: DateTime(2026, 9, 1),
          ),
        ),
      ),
    );

    final Finder firstAllConditions = find.text('All conditions match').first;
    await tester.ensureVisible(firstAllConditions);
    await tester.tap(firstAllConditions);
    await tester.pumpAndSettle();
    final Finder anyConditions = find.text('Any condition matches');
    await tester.ensureVisible(anyConditions);
    await tester.tap(anyConditions);
    await tester.pumpAndSettle();
    final Finder lastAllConditions = find.text('All conditions match').last;
    await tester.ensureVisible(lastAllConditions);
    await tester.tap(lastAllConditions);
    await tester.pumpAndSettle();
    final Finder nestedAddCondition = find.text('Add condition').first;
    await tester.ensureVisible(nestedAddCondition);
    await tester.drag(find.byType(ListView), const Offset(0, 72));
    await tester.pumpAndSettle();
    await tester.tap(nestedAddCondition);
    await tester.pumpAndSettle();

    final Finder dialog = find.byType(AlertDialog);
    expect(
      find.descendant(of: dialog, matching: find.text('Condition group')),
      findsOneWidget,
    );
    final ListTile groupCategory = tester.widget<ListTile>(
      find.ancestor(
        of: find.text('Condition group'),
        matching: find.byType(ListTile),
      ),
    );
    expect(groupCategory.enabled, isFalse);
    expect(
      find.text(
        'The maximum of 3 nested condition levels has been reached. '
        'Choose an individual condition, or split complex logic across rules '
        'or conditional-action groups.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('disables matching nested condition groups', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationRuleDetailsPage(
          rule: const NotificationRule(
            id: 'rule',
            name: 'Card payment',
            conditions: <NotificationCondition>[
              AllCondition(<NotificationCondition>[]),
            ],
            actions: <NotificationAction>[],
          ),
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: 'Card payment',
            body: 'Paid 12.50 CAD',
            receivedAt: DateTime(2026, 9, 1),
          ),
        ),
      ),
    );

    await tester.tap(find.text('All conditions match'));
    await tester.pumpAndSettle();
    final Finder groupAddCondition = find.text('Add condition').first;
    await tester.ensureVisible(groupAddCondition);
    await tester.tap(groupAddCondition);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Condition group'));
    await tester.pumpAndSettle();

    final Finder allGroupChoice = find
        .ancestor(
          of: find.text('All conditions match').last,
          matching: find.byType(ListTile),
        )
        .first;
    expect(tester.widget<ListTile>(allGroupChoice).enabled, isFalse);
    expect(
      find.text('This group is supplied by its parent condition.'),
      findsOneWidget,
    );
  });
}
