import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/notifications/presentation/shared/message_status_card.dart';

void main() {
  testWidgets('renders every semantic state with a distinct icon', (
    WidgetTester tester,
  ) async {
    const Map<MessageStatus, IconData> icons = <MessageStatus, IconData>{
      MessageStatus.success: Icons.check_circle_outline,
      MessageStatus.informational: Icons.info_outline,
      MessageStatus.warning: Icons.error_outline,
      MessageStatus.review: Icons.error_outline,
      MessageStatus.error: Icons.error_outline,
    };

    for (final MapEntry<MessageStatus, IconData> entry in icons.entries) {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MessageStatusCard(
              status: entry.key,
              title: 'Status',
              message: 'Status details',
            ),
          ),
        ),
      );

      expect(find.byIcon(entry.value), findsOneWidget);
      expect(find.text('Status'), findsOneWidget);
      expect(find.text('Status details'), findsOneWidget);
    }
  });

  testWidgets('runs its optional action', (WidgetTester tester) async {
    bool acted = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MessageStatusCard(
            status: MessageStatus.error,
            message: 'Processing failed.',
            actionLabel: 'Review',
            onAction: () => acted = true,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Review'));

    expect(acted, isTrue);
  });
}
