import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/presentation/definitions/widgets/definition_options_section.dart';

Widget _app({
  required bool showAdvanced,
  required void Function(
    MissingNotificationDataPolicy policy,
    bool allowMetadataOnly,
  )
  onChanged,
}) => MaterialApp(
  localizationsDelegates: S.localizationsDelegates,
  supportedLocales: S.supportedLocales,
  home: Scaffold(
    body: MissingNotificationDataOptionCard(
      policy: MissingNotificationDataPolicy.requiresAttention,
      allowMetadataOnly: false,
      showAdvanced: showAdvanced,
      onChanged: onChanged,
    ),
  ),
);

void main() {
  testWidgets('changes the missing-data policy from the bottom sheet', (
    WidgetTester tester,
  ) async {
    MissingNotificationDataPolicy? savedPolicy;
    bool? savedMetadataOnly;
    await tester.pumpWidget(
      _app(
        showAdvanced: true,
        onChanged:
            (MissingNotificationDataPolicy policy, bool allowMetadataOnly) {
              savedPolicy = policy;
              savedMetadataOnly = allowMetadataOnly;
            },
      ),
    );

    await tester.tap(find.text('Missing notification data'));
    await tester.pumpAndSettle();
    expect(
      find.text('When a notification is missing a title or body'),
      findsOneWidget,
    );
    await tester.tap(find.text('Ignore notification'));
    await tester.tap(find.text('Allow metadata-only notifications'));
    await tester.ensureVisible(find.text('Save'));
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(savedPolicy, MissingNotificationDataPolicy.ignore);
    expect(savedMetadataOnly, isTrue);
  });

  testWidgets('hides metadata-only processing outside Advanced mode', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_app(showAdvanced: false, onChanged: (_, _) {}));

    await tester.tap(find.text('Missing notification data'));
    await tester.pumpAndSettle();

    expect(find.text('Advanced'), findsNothing);
    expect(find.text('Allow metadata-only notifications'), findsNothing);
  });
}
