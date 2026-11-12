import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_patch.dart';
import 'package:waterflyiii/notifications/presentation/shared/transaction_patch_summary.dart';

Widget _summary(TransactionPatch patch) => MaterialApp(
  localizationsDelegates: S.localizationsDelegates,
  supportedLocales: S.supportedLocales,
  home: Scaffold(body: TransactionPatchSummary(patch: patch)),
);

void main() {
  testWidgets('hides the summary header without a title or amount', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      _summary(
        const TransactionPatch(
          <TransactionField, String>{TransactionField.category: '42'},
          displayValues: <TransactionField, String>{
            TransactionField.category: 'Groceries',
          },
        ),
      ),
    );

    expect(find.text('Transaction summary'), findsNothing);
    expect(find.text('Amount'), findsNothing);
    expect(find.text('Classification'), findsOneWidget);
    expect(find.text('Groceries'), findsOneWidget);
  });

  testWidgets('labels an amount-only summary and appends resolved currency', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      _summary(
        const TransactionPatch(
          <TransactionField, String>{
            TransactionField.amount: '12.50',
            TransactionField.currency: '1',
          },
          displayValues: <TransactionField, String>{
            TransactionField.currency: 'Canadian dollar',
          },
          currencyCodes: <TransactionField, String>{
            TransactionField.currency: 'CAD',
          },
        ),
      ),
    );

    expect(find.text('Transaction summary'), findsNothing);
    expect(find.text('Amount'), findsOneWidget);
    expect(find.text('12.50 CAD'), findsOneWidget);
    expect(find.text('Canadian dollar'), findsOneWidget);
  });

  testWidgets('shows an amount without guessing an unresolved currency', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      _summary(
        const TransactionPatch(<TransactionField, String>{
          TransactionField.amount: '12.50',
        }),
      ),
    );

    expect(find.text('Amount'), findsOneWidget);
    expect(find.text('12.50'), findsOneWidget);
    expect(find.text('12.50 CAD'), findsNothing);
  });

  testWidgets('shows title and amount as separate icon-led summary rows', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      _summary(
        const TransactionPatch(<TransactionField, String>{
          TransactionField.title: 'Card purchase',
          TransactionField.amount: '12.50',
        }),
      ),
    );

    expect(find.text('Transaction summary'), findsNothing);
    expect(find.text('Title'), findsOneWidget);
    expect(find.text('Card purchase'), findsOneWidget);
    expect(find.text('Amount'), findsOneWidget);
    expect(find.text('12.50'), findsOneWidget);
    expect(find.byIcon(Icons.receipt_long), findsOneWidget);
    expect(find.byIcon(Icons.monetization_on), findsOneWidget);
    expect(
      tester.getTopLeft(find.text('Card purchase')).dy,
      closeTo(tester.getTopLeft(find.text('Title')).dy, 4),
    );
    expect(
      tester.getTopLeft(find.text('Amount')).dy,
      greaterThan(tester.getBottomLeft(find.text('Card purchase')).dy),
    );
    expect(
      tester.getCenter(find.text('Amount')).dy,
      tester.getCenter(find.text('12.50')).dy,
    );
    expect(
      tester.getCenter(find.byIcon(Icons.monetization_on)).dy,
      tester.getCenter(find.text('12.50')).dy,
    );
  });

  testWidgets('keeps a four-digit amount visible in a narrow preview', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: Scaffold(
          body: SizedBox(
            width: 280,
            child: TransactionPatchSummary(
              patch: TransactionPatch(
                <TransactionField, String>{
                  TransactionField.title: 'A longer card purchase title',
                  TransactionField.amount: '1234.56',
                  TransactionField.currency: '1',
                },
                currencyCodes: <TransactionField, String>{
                  TransactionField.currency: 'EUR',
                },
              ),
            ),
          ),
        ),
      ),
    );

    final Finder title = find.text('A longer card purchase title');
    final Finder amountLabel = find.text('Amount');
    final Finder amount = find.text('1234.56 EUR');
    expect(title, findsOneWidget);
    expect(amountLabel, findsOneWidget);
    expect(amount, findsOneWidget);
    expect(
      tester.getTopLeft(amountLabel).dy,
      greaterThan(tester.getBottomLeft(title).dy),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('centers title and amount labels when provenance is shown', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: Scaffold(
          body: TransactionPatchSummary(
            patch: TransactionPatch(<TransactionField, String>{
              TransactionField.title: 'Card purchase',
              TransactionField.amount: '12.50',
            }),
            fieldProvenance: <TransactionField, TransactionFieldProvenance>{
              TransactionField.title: TransactionFieldProvenance(
                source: 'Set by: Shared actions',
              ),
              TransactionField.amount: TransactionFieldProvenance(
                source: 'Set by: Shared actions',
              ),
            },
          ),
        ),
      ),
    );

    expect(
      tester.getCenter(find.text('Title')).dy,
      tester
          .getCenter(find.byKey(const Key('transaction-summary-title-value')))
          .dy,
    );
    expect(
      tester.getCenter(find.byIcon(Icons.receipt_long)).dy,
      tester
          .getCenter(find.byKey(const Key('transaction-summary-title-value')))
          .dy,
    );
    expect(
      tester.getCenter(find.text('Amount')).dy,
      tester
          .getCenter(find.byKey(const Key('transaction-summary-amount-value')))
          .dy,
    );
    expect(
      tester.getCenter(find.byIcon(Icons.monetization_on)).dy,
      tester
          .getCenter(find.byKey(const Key('transaction-summary-amount-value')))
          .dy,
    );
  });
}
