import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart' show TestWidgetsFlutterBinding;
import 'package:test/test.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

import 'package:waterflyiii/timezonehandler.dart';

const String deviceLocation = "Europe/Berlin";
const String serverLocation = "America/Detroit";
const int tzOffset = 6;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
    const MethodChannel('flutter_timezone'),
    (MethodCall methodCall) async {
      return deviceLocation;
    },
  );

  group("class setup", () {
    late TimeZoneHandler tzh;

    setUpAll(() => tz_data.initializeTimeZones());

    setUp(() async {
      tzh = TimeZoneHandler(serverLocation);
      await tzh.updateDeviceLocation();
    });

    test("init", () {
      expect(tzh.useServerTime, true);
      expect(tzh.sLocation, tz.getLocation(serverLocation));
      expect(tzh.dLocation, tz.getLocation(deviceLocation));
    });
    test("invalid location", () {
      final TimeZoneHandler tzhInvalid = TimeZoneHandler("Mars/Jezero Crater");
      expect(tzhInvalid.sLocation, tz.getLocation("UTC"));
    });
    test("updateDeviceLocation", () async {
      await tzh.updateDeviceLocation();
      expect(tzh.dLocation, tz.getLocation(deviceLocation));
    });
    test("setUseServerTime", () async {
      await tzh.updateDeviceLocation();
      expect(tzh.useServerTime, true);
      expect(tzh.sLocation, tz.getLocation(serverLocation));
      expect(tzh.dLocation, tz.getLocation(deviceLocation));
      expect(tz.local, tz.getLocation(serverLocation));

      await tzh.setUseServerTime(false);
      expect(tzh.useServerTime, false);
      expect(tzh.sLocation, tz.getLocation(serverLocation));
      expect(tzh.dLocation, tz.getLocation(deviceLocation));
      expect(tz.local, tz.getLocation(deviceLocation));

      await tzh.setUseServerTime(true);
      expect(tzh.useServerTime, true);
      expect(tzh.sLocation, tz.getLocation(serverLocation));
      expect(tzh.dLocation, tz.getLocation(deviceLocation));
      expect(tz.local, tz.getLocation(serverLocation));
    });
    test("getLocalTimeAsServerTime", () async {
      await tzh.updateDeviceLocation();

      // getLocalTimeAsServerTime ignores all provided timezones to
      // tz.TZDateTime. It simply offsets the provided tz.TZDateTime by the
      // diff of tzh.sLocation (America/Detroit) & tzh.dLocation (Europe/Berlin)
      // so the result is always dtLocal + 6

      final tz.TZDateTime dtLocal1 = tz.TZDateTime(
          tz.getLocation("Europe/Paris"), 2017, 9, 7, 17, 30, 15, 20, 25);
      final tz.TZDateTime dtLocal2 = tz.TZDateTime(
          tz.getLocation("Asia/Tokyo"), 2017, 9, 7, 17, 30, 15, 20, 25);

      expect(
        tzh.getLocalTimeAsServerTime(dtLocal1),
        tz.TZDateTime(tz.getLocation("Europe/Paris"), 2017, 9, 7, 17 + tzOffset,
            30, 15, 20, 25),
      );
      expect(
        tzh.getLocalTimeAsServerTime(dtLocal2),
        tz.TZDateTime(tz.getLocation("Asia/Tokyo"), 2017, 9, 7, 17 + tzOffset,
            30, 15, 20, 25),
      );
    });
    test("dTime()", () {
      final DateTime now = DateTime.now();
      final tz.TZDateTime dNow = tzh.dTime(now);
      expect(dNow.location, tz.getLocation(deviceLocation));
      expect(dNow, now);
    });
    test("sTime()", () {
      final DateTime now = DateTime.now();
      final tz.TZDateTime sNow = tzh.sTime(now);
      expect(sNow.location, tz.getLocation(serverLocation));
      expect(sNow, now);
    });
  });
  group("_useServerTime = true", () {
    late TimeZoneHandler tzh;

    setUpAll(() => tz_data.initializeTimeZones());

    setUp(() async {
      tzh = TimeZoneHandler(serverLocation);
      await tzh.updateDeviceLocation();
    });

    test("dNow()", () {
      expect(tzh.dLocation, tz.getLocation(deviceLocation));
      final tz.TZDateTime dNow = tzh.dNow();
      expect(dNow.location, tz.getLocation(serverLocation));
    });
    test("sNow()", () {
      expect(tzh.sLocation, tz.getLocation(serverLocation));
      final tz.TZDateTime sNow = tzh.sNow();
      expect(sNow.location, tz.getLocation(serverLocation));
    });
    test("newTXTime()", () {
      final tz.TZDateTime txtTime = tzh.newTXTime();
      expect(txtTime.location, tz.getLocation(deviceLocation));
    });
    test("notificationTXTime()", () {
      final DateTime dt = DateTime(2017, 9, 7, 17, 30, 15, 20, 25);
      final tz.TZDateTime notTime = tzh.notificationTXTime(dt);
      expect(notTime.location, tz.getLocation(deviceLocation));
      expect(notTime, tzh.dTime(dt.add(const Duration(hours: tzOffset))));
    });
  });
  group("_useServerTime = false", () {
    late TimeZoneHandler tzh;

    setUpAll(() => tz_data.initializeTimeZones());

    setUp(() async {
      tzh = TimeZoneHandler(serverLocation);
      await tzh.updateDeviceLocation();
      await tzh.setUseServerTime(false);
    });

    test("dNow()", () {
      expect(tzh.dLocation, tz.getLocation(deviceLocation));
      final tz.TZDateTime dNow = tzh.dNow();
      expect(dNow.location, tz.getLocation(deviceLocation));
    });
    test("sNow()", () {
      expect(tzh.sLocation, tz.getLocation(serverLocation));
      final tz.TZDateTime sNow = tzh.sNow();
      expect(sNow.location, tz.getLocation(deviceLocation));
    });
    test("newTXTime()", () {
      final tz.TZDateTime txtTime = tzh.newTXTime();
      expect(txtTime.location, tz.getLocation(deviceLocation));
    });
    test("notificationTXTime()", () {
      final DateTime dt = DateTime(2017, 9, 7, 17, 30, 15, 20, 25);
      final tz.TZDateTime notTime = tzh.notificationTXTime(dt);
      expect(notTime.location, tz.getLocation(deviceLocation));
      expect(notTime, tzh.dTime(dt));
    });
  });
}
