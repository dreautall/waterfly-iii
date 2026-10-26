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

  testWidgets('keeps the transaction summary label when a title resolves', (
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

    expect(find.text('Transaction summary'), findsOneWidget);
    expect(find.text('Card purchase'), findsOneWidget);
    expect(find.text('12.50'), findsOneWidget);
  });
}
