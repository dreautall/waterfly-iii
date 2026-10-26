import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_menu_theme.dart';

void main() {
  testWidgets('uses floating Material snackbars', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationMenuTheme(
          child: Builder(
            builder: (BuildContext context) => Text(
              Theme.of(context).snackBarTheme.behavior.toString(),
              textDirection: TextDirection.ltr,
            ),
          ),
        ),
      ),
    );

    expect(find.text(SnackBarBehavior.floating.toString()), findsOneWidget);
  });
}
