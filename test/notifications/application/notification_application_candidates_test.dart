import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/definitions/notification_application_candidates.dart';

class InstalledApplication {
  const InstalledApplication(this.packageId);

  final String packageId;
}

class FakeManifestPackageSource implements NotificationManifestPackageSource {
  FakeManifestPackageSource(this.packageIds);

  final Iterable<String> packageIds;

  @override
  Future<Iterable<String>> loadPackageIds() async => packageIds;
}

class ThrowingManifestPackageSource
    implements NotificationManifestPackageSource {
  @override
  Future<Iterable<String>> loadPackageIds() =>
      Future<Iterable<String>>.error(StateError('Manifest unavailable'));
}

class FakeHistoryPackageSource implements NotificationHistoryPackageSource {
  FakeHistoryPackageSource(this.packageIds);

  final Iterable<String> packageIds;

  @override
  Future<Iterable<String>> loadPackageIds() async => packageIds;
}

class ThrowingHistoryPackageSource implements NotificationHistoryPackageSource {
  @override
  Future<Iterable<String>> loadPackageIds() =>
      Future<Iterable<String>>.error(StateError('History unavailable'));
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Ensures only installed apps explicitly allowed by the manifest or observed
  // in notification history become selectable for a new definition.
  test('filters installed applications by eligible notification senders', () {
    final List<InstalledApplication> applications = <InstalledApplication>[
      const InstalledApplication('com.example.bank'),
      const InstalledApplication('com.example.recent'),
      const InstalledApplication('com.example.unrelated'),
    ];

    final List<InstalledApplication> filtered =
        NotificationApplicationCandidates(
          manifestPackageSource: FakeManifestPackageSource(const <String>[]),
          historyPackageSource: FakeHistoryPackageSource(const <String>[]),
        ).filterInstalled<InstalledApplication>(
          applications,
          (InstalledApplication application) => application.packageId,
          <String>{'com.example.bank', 'com.example.recent'},
        );

    expect(
      filtered.map((InstalledApplication application) => application.packageId),
      <String>['com.example.bank', 'com.example.recent'],
    );
  });

  // Retains manifest-declared candidates when the optional legacy history is
  // corrupt or unavailable, so users can still register supported apps.
  test(
    'loads manifest candidates when legacy history cannot be read',
    () async {
      final NotificationApplicationCandidates candidates =
          NotificationApplicationCandidates(
            manifestPackageSource: FakeManifestPackageSource(<String>[
              'com.example.bank',
            ]),
            historyPackageSource: ThrowingHistoryPackageSource(),
          );

      final Set<String> packageIds = await candidates.loadPackageIds();

      expect(packageIds, <String>{'com.example.bank'});
    },
  );

  test(
    'loads history candidates when the manifest source is unavailable',
    () async {
      final NotificationApplicationCandidates candidates =
          NotificationApplicationCandidates(
            manifestPackageSource: ThrowingManifestPackageSource(),
            historyPackageSource: FakeHistoryPackageSource(<String>[
              'com.example.recent',
            ]),
          );

      final Set<String> packageIds = await candidates.loadPackageIds();

      expect(packageIds, <String>{'com.example.recent'});
    },
  );
}
