import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart' hide MaterialApp;
import 'package:material_ui/material_ui.dart' as material_ui;
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/presentation/definitions/widgets/notification_definition_card.dart';

class MaterialApp extends material_ui.MaterialApp {
  const MaterialApp({super.key, required super.home})
    : super(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
      );
}

void main() {
  // Verifies the read-only list card exposes its definition metadata and the
  // stable fallback icon when the installed app icon is unavailable in tests.
  testWidgets('renders a notification definition as a non-interactive card', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: NotificationDefinitionCard(
            definition: NotificationDefinition(
              id: 'bank-payment',
              applicationId: 'com.example.bank',
              name: 'Example Bank',
              extractors: <RegExpDefinition>[],
              rules: <NotificationRule>[],
            ),
          ),
        ),
      ),
    );

    expect(find.text('Example Bank'), findsOneWidget);
    expect(find.text('com.example.bank'), findsOneWidget);
    expect(find.text('Not configured'), findsOneWidget);
    expect(
      find.text(
        "Choose how Waterfly should read this application's notifications.",
      ),
      findsOneWidget,
    );
    expect(find.text('No extractors'), findsNothing);
    expect(find.text('No rules'), findsNothing);
    expect(find.byIcon(Icons.apps_outlined), findsOneWidget);
    expect(find.byIcon(Icons.info_outline), findsOneWidget);
    expect(find.byIcon(Icons.chevron_right), findsNothing);
    expect(find.byType(IconButton), findsNothing);
    expect(find.byType(PopupMenuButton<Object>), findsNothing);
  });

  testWidgets('invokes its details callback when tapped', (
    WidgetTester tester,
  ) async {
    bool wasOpened = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NotificationDefinitionCard(
            definition: const NotificationDefinition(
              id: 'bank-payment',
              applicationId: 'com.example.bank',
              name: 'Example Bank',
              extractors: <RegExpDefinition>[],
              rules: <NotificationRule>[],
            ),
            onTap: () {
              wasOpened = true;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Example Bank'));

    expect(wasOpened, isTrue);
    expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    expect(find.byType(PopupMenuButton<Object>), findsNothing);
  });

  testWidgets('labels a definition whose name is only its package ID', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: NotificationDefinitionCard(
            definition: NotificationDefinition(
              id: 'unknown-application',
              applicationId: 'com.example.unknown',
              name: 'com.example.unknown',
              extractors: <RegExpDefinition>[],
              rules: <NotificationRule>[],
            ),
          ),
        ),
      ),
    );

    expect(find.text('Unknown application'), findsOneWidget);
    expect(find.text('com.example.unknown'), findsOneWidget);
  });

  testWidgets('does not show status tags for a configured definition', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NotificationDefinitionCard(
            definition: NotificationDefinition(
              id: 'bank-payment',
              applicationId: 'com.example.bank',
              name: 'Example Bank',
              sampleTitle: 'Payment',
              sampleBody: 'Paid 12 CAD',
              extractors: <RegExpDefinition>[
                RegExpDefinition.createCustomRegExpDefinition(
                  'Amount',
                  r'(?<amount>\d+)',
                ),
              ],
              rules: const <NotificationRule>[
                NotificationRule(
                  id: 'transaction',
                  name: 'Transaction details',
                  conditions: <NotificationCondition>[],
                  actions: <NotificationAction>[],
                ),
              ],
              extractorMode: NotificationExtractorMode.basic,
            ),
          ),
        ),
      ),
    );

    expect(find.text('Ready'), findsNothing);
    expect(find.byType(Chip), findsNothing);
    expect(find.byIcon(Icons.chevron_right), findsNothing);
  });

  testWidgets('shows migration guidance for a ready definition', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NotificationDefinitionCard(
            definition: NotificationDefinition(
              id: 'bank-payment',
              applicationId: 'com.example.bank',
              name: 'Example Bank',
              sampleTitle: 'Payment',
              sampleBody: 'Paid 12 CAD',
              extractors: <RegExpDefinition>[
                RegExpDefinition.createCustomRegExpDefinition(
                  'Amount',
                  r'(?<amount>\d+)',
                ),
              ],
              rules: const <NotificationRule>[
                NotificationRule(
                  id: 'transaction',
                  name: 'Transaction details',
                  conditions: <NotificationCondition>[],
                  actions: <NotificationAction>[],
                ),
              ],
              extractorMode: NotificationExtractorMode.basic,
            ),
            migrationAlerts: <NotificationAlert>[
              NotificationAlert.failure(
                kind: NotificationAlertKind.migrationNeedsReview,
                operation: 'Reviewing imported notification settings',
                message: 'Automatic creation was changed.',
                applicationId: 'com.example.bank',
                definitionId: 'bank-payment',
                migrationIssue:
                    NotificationMigrationIssue.automaticCreationPaused,
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Imported setup needs attention'), findsOneWidget);
    expect(
      find.textContaining(
        'Transactions will use Prompt mode until you review the imported setup.',
      ),
      findsOneWidget,
    );
    expect(
      find.textContaining('Open this setup to resolve the migration issues.'),
      findsOneWidget,
    );
    expect(find.byIcon(Icons.error_outline), findsOneWidget);
  });

  testWidgets('keeps registration status separate from migration alerts', (
    WidgetTester tester,
  ) async {
    final NotificationDefinition definition = NotificationDefinition(
      id: 'bank-payment',
      applicationId: 'com.example.bank',
      name: 'Example Bank',
      sampleTitle: 'Payment',
      sampleBody: 'Paid 12 CAD',
      extractors: <RegExpDefinition>[
        RegExpDefinition.createCustomRegExpDefinition(
          'Amount',
          r'(?<amount>\d+)',
        ),
      ],
      rules: const <NotificationRule>[
        NotificationRule(
          id: 'transaction',
          name: 'Transaction details',
          conditions: <NotificationCondition>[],
          actions: <NotificationAction>[],
        ),
      ],
      extractorMode: NotificationExtractorMode.basic,
      requiresMigrationReview: true,
      migrationReviewIssues: const <NotificationMigrationIssue>{
        NotificationMigrationIssue.automaticCreationPaused,
      },
    );
    final NotificationAlert alert = NotificationAlert.failure(
      kind: NotificationAlertKind.migrationNeedsReview,
      operation: 'Reviewing imported notification settings',
      message: 'Automatic creation was changed.',
      applicationId: definition.applicationId,
      definitionId: definition.id,
      migrationIssue: NotificationMigrationIssue.automaticCreationPaused,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NotificationDefinitionCard(
            definition: definition,
            migrationAlerts: <NotificationAlert>[alert],
          ),
        ),
      ),
    );

    expect(find.text('Imported setup needs attention'), findsOneWidget);
    expect(find.text('Needs review'), findsNothing);
    expect(
      find.textContaining(
        'Transactions will use Prompt mode until you review the imported setup.',
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

    expect(find.text('Imported setup needs attention'), findsOneWidget);
    expect(find.text('Needs review'), findsNothing);
    expect(
      find.textContaining(
        'Transactions will use Prompt mode until you review the imported setup.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('keeps a recovery husk migration status after alert dismissal', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: NotificationDefinitionCard(
            definition: NotificationDefinition(
              id: 'missing-settings',
              applicationId: 'com.example.missing',
              name: 'com.example.missing',
              extractors: <RegExpDefinition>[],
              rules: <NotificationRule>[],
              requiresMigrationReview: true,
              migrationReviewIssues: <NotificationMigrationIssue>{
                NotificationMigrationIssue.missingSettings,
              },
            ),
          ),
        ),
      ),
    );

    expect(find.text('Imported setup needs attention'), findsOneWidget);
    expect(
      find.textContaining(
        'No saved configuration was found for this application.',
      ),
      findsOneWidget,
    );
    expect(find.text('Not configured'), findsNothing);
  });

  testWidgets('summarizes multiple migration issues in the status section', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NotificationDefinitionCard(
            definition: const NotificationDefinition(
              id: 'bank-payment',
              applicationId: 'com.example.bank',
              name: 'Example Bank',
              extractors: <RegExpDefinition>[],
              rules: <NotificationRule>[],
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
                message: 'Account mapping is missing.',
                migrationIssue:
                    NotificationMigrationIssue.missingAutomaticAccount,
              ),
            ],
          ),
        ),
      ),
    );

    expect(
      find.text('Imported setup needs attention · 2 issues'),
      findsOneWidget,
    );
    expect(
      find.textContaining(
        'Choose an account before enabling automatic transaction creation.',
      ),
      findsOneWidget,
    );
    expect(find.text('Not configured'), findsNothing);
  });

  testWidgets('shows application metadata above its review status card', (
    WidgetTester tester,
  ) async {
    final RegExpDefinition amount =
        RegExpDefinition.createCustomRegExpDefinition(
          'Amount',
          r'(?<amount>\d+)',
        );
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NotificationDefinitionCard(
            definition: NotificationDefinition(
              id: 'bank-payment',
              applicationId: 'com.example.bank',
              name: 'Example Bank',
              sampleTitle: 'Payment',
              sampleBody: 'Paid 12 and 15 CAD',
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
          ),
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
    expect(find.byType(Chip), findsNothing);
    expect(find.byIcon(Icons.error_outline), findsOneWidget);
    expect(find.byIcon(Icons.warning_amber_outlined), findsNothing);
    expect(find.byIcon(Icons.chevron_right), findsNothing);
    expect(find.byType(PopupMenuButton<Object>), findsNothing);

    final Finder metadataRow = find
        .ancestor(of: find.text('Example Bank'), matching: find.byType(Row))
        .first;
    expect(
      find.descendant(
        of: metadataRow,
        matching: find.byIcon(Icons.apps_outlined),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: metadataRow,
        matching: find.byIcon(Icons.chevron_right),
      ),
      findsNothing,
    );
    expect(
      tester.getBottomLeft(metadataRow).dy,
      lessThan(tester.getTopLeft(find.text('Needs review')).dy),
    );
  });
}
