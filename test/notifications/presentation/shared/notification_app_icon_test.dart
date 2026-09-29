import 'package:appcheck/appcheck.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_app_icon.dart';

void main() {
  testWidgets('caches app metadata across parent rebuilds', (
    WidgetTester tester,
  ) async {
    int loadCount = 0;
    String applicationId = 'com.example.first';
    late StateSetter rebuild;
    Future<AppInfo?> loadApplication(String applicationId) async {
      loadCount++;
      return AppInfo(packageName: applicationId, appName: 'Example');
    }

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            rebuild = setState;
            return NotificationAppIcon(
              applicationId: applicationId,
              appInfoLoader: loadApplication,
            );
          },
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(loadCount, 1);

    rebuild(() {});
    await tester.pump();
    expect(loadCount, 1);

    rebuild(() => applicationId = 'com.example.second');
    await tester.pumpAndSettle();
    expect(loadCount, 2);
  });
}
