import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/samples/sample_notification_editor_context.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/samples/rule_test_sample_dialog.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/samples/sample_notification_editor_dialog.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_input_decoration.dart';

void main() {
  for (final Brightness brightness in Brightness.values) {
    testWidgets(
      'test sample source matches fields in ${brightness.name} theme',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(brightness: brightness, useMaterial3: true),
            localizationsDelegates: S.localizationsDelegates,
            supportedLocales: S.supportedLocales,
            home: const Scaffold(
              body: RuleTestSampleDialog(
                applicationId: 'com.example.bank',
                applicationName: 'Example Bank',
                title: 'Payment',
                body: 'Paid 12.50 CAD',
              ),
            ),
          ),
        );

        final BuildContext context = tester.element(
          find.byType(TextField).first,
        );
        final DecoratedBox source = tester.widget<DecoratedBox>(
          find
              .ancestor(
                of: find.text('Notification source'),
                matching: find.byType(DecoratedBox),
              )
              .first,
        );
        expect(source.decoration, notificationControlDecoration(context));
        expect(
          tester
              .widget<TextField>(find.byType(TextField).first)
              .decoration!
              .fillColor,
          Theme.of(context).colorScheme.surfaceContainerLow,
        );
      },
    );
  }

  for (final Brightness brightness in Brightness.values) {
    testWidgets('sample controls match in ${brightness.name} theme', (
      WidgetTester tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(800, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(brightness: brightness, useMaterial3: true),
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          home: Scaffold(
            body: SampleNotificationEditorDialog(
              title: 'Card payment',
              body: 'Paid 12.50 CAD',
              receivedAt: DateTime(2026, 9, 26),
              editorContext: SampleNotificationEditorContext.definition,
            ),
          ),
        ),
      );

      final Finder title = find.byKey(const Key('sample-notification-title'));
      final Finder message = find.byKey(const Key('sample-notification-body'));
      final Finder time = find.ancestor(
        of: find.text('Sample time'),
        matching: find.byType(OutlinedButton),
      );
      final BuildContext context = tester.element(title);
      final ColorScheme colors = Theme.of(context).colorScheme;
      final InputDecoration decoration = tester
          .widget<TextField>(title)
          .decoration!;
      final OutlineInputBorder enabledBorder =
          decoration.enabledBorder! as OutlineInputBorder;
      final OutlineInputBorder focusedBorder =
          decoration.focusedBorder! as OutlineInputBorder;
      final OutlinedButton timeButton = tester.widget<OutlinedButton>(time);

      expect(decoration.fillColor, colors.surfaceContainerLow);
      expect(find.text('Notification source'), findsNothing);
      expect(
        tester.widget<TextField>(message).decoration!.fillColor,
        decoration.fillColor,
      );
      expect(enabledBorder.borderRadius, BorderRadius.circular(8));
      expect(enabledBorder.borderSide.color, colors.outlineVariant);
      expect(focusedBorder.borderSide.color, colors.primary);
      expect(focusedBorder.borderSide.width, 2);
      expect(
        timeButton.style!.backgroundColor!.resolve(<WidgetState>{}),
        decoration.fillColor,
      );
      expect(
        timeButton.style!.side!.resolve(<WidgetState>{})!.color,
        enabledBorder.borderSide.color,
      );
      expect(tester.getTopLeft(title).dx, tester.getTopLeft(message).dx);
      expect(tester.getTopLeft(title).dx, tester.getTopLeft(time).dx);
      expect(tester.getSize(title).width, tester.getSize(time).width);
    });
  }
}
