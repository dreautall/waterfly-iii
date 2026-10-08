import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart' hide MaterialApp;
import 'package:material_ui/material_ui.dart' as material_ui;
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/samples/sample_notification_editor_context.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/samples/sample_notification_editor_dialog.dart';

class MaterialApp extends material_ui.MaterialApp {
  const MaterialApp({super.key, required super.home})
    : super(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
      );
}

Widget sampleDialog({
  String title = '',
  String body = '',
  SampleNotificationEditorContext editorContext =
      SampleNotificationEditorContext.definition,
}) => MaterialApp(
  home: Scaffold(
    body: SampleNotificationEditorDialog(
      title: title,
      body: body,
      receivedAt: DateTime(2026, 9, 23, 13, 47),
      editorContext: editorContext,
    ),
  ),
);

void main() {
  testWidgets('labels an empty sample as an addition', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(sampleDialog());

    expect(find.text('Add sample notification'), findsOneWidget);
    expect(find.text('Change sample notification'), findsNothing);
    expect(find.widgetWithText(FilledButton, 'Continue'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Apply'), findsNothing);
    expect(
      find.text(
        'Enter a representative notification title, message, and received time to preview your extractors and rules.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('labels a complete sample as a change', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      sampleDialog(title: 'Payment received', body: 'You received 10 CAD.'),
    );

    expect(find.text('Add sample notification'), findsNothing);
    expect(find.text('Change sample notification'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Continue'), findsNothing);
    expect(find.widgetWithText(FilledButton, 'Apply'), findsOneWidget);
    expect(find.text('Example Bank'), findsNothing);
    expect(find.text('Notification source'), findsNothing);
  });

  for (final (SampleNotificationEditorContext, String) contextDescription
      in <(SampleNotificationEditorContext, String)>[
        (
          SampleNotificationEditorContext.extractor,
          'Enter a notification title, message, and received time to test this extractor. This sample applies only to this extractor.',
        ),
        (
          SampleNotificationEditorContext.rule,
          'Enter a notification title, message, and received time to test this rule. This sample applies to the rule and its conditional actions.',
        ),
        (
          SampleNotificationEditorContext.conditionalAction,
          'Enter a notification title, message, and received time to test this conditional action. This sample applies only to this conditional action.',
        ),
      ]) {
    testWidgets('describes the ${contextDescription.$1.name} sample context', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        sampleDialog(editorContext: contextDescription.$1),
      );

      expect(find.text(contextDescription.$2), findsOneWidget);
    });
  }
}
