import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/settings.dart';

void main() {
  test('loads the server-time preference from the settings bitmask', () async {
    expect(
      await SettingsProvider.loadUseServerTime(
        containsKey: (_) async => true,
        getInt: (_) async => 1 << BoolSettings.useServerTime.index,
      ),
      isTrue,
    );
  });

  test('loads the legacy server-time preference before migration', () async {
    expect(
      await SettingsProvider.loadUseServerTime(
        containsKey: (_) async => false,
        getLegacyBool: (_) async => false,
      ),
      isFalse,
    );
  });

  test('defaults server-time conversion to enabled', () async {
    expect(
      await SettingsProvider.loadUseServerTime(
        containsKey: (_) async => false,
        getLegacyBool: (_) async => null,
      ),
      isTrue,
    );
  });
}
