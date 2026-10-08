import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_date_time_formatter.dart';
import 'package:waterflyiii/notifications/presentation/shared/sample_notification_card.dart';

void main() {
  testWidgets(
    'places a same-day timestamp beside the title as compact metadata',
    (WidgetTester tester) async {
      final DateTime receivedAt = DateTime.now();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SampleNotificationCard(
              applicationId: 'com.example.bank',
              title: 'RBC Mobile',
              body: 'A purchase of 4.99 CAD was made.',
              receivedAt: receivedAt,
            ),
          ),
        ),
      );

      final BuildContext context = tester.element(
        find.byType(SampleNotificationCard),
      );
      final Finder timestampFinder = find.text(
        formatNotificationTime(context, TimeOfDay.fromDateTime(receivedAt)),
      );
      final Text timestamp = tester.widget<Text>(timestampFinder);
      final ThemeData theme = Theme.of(tester.element(timestampFinder));
      final Card card = tester.widget<Card>(find.byType(Card));
      final RenderBox titleBox = tester.renderObject(find.text('RBC Mobile'));
      final RenderBox timestampBox = tester.renderObject(timestampFinder);

      expect(card.color, theme.colorScheme.surfaceContainerLow);
      expect(timestamp.style?.fontSize, theme.textTheme.labelMedium?.fontSize);
      expect(timestamp.style?.color, theme.colorScheme.outline);
      expect(
        timestampBox.localToGlobal(Offset.zero).dx,
        greaterThan(titleBox.localToGlobal(Offset.zero).dx),
      );
    },
  );
}
