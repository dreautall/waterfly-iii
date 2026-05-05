import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:logging/logging.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class TimeZoneHandler {
  late tz.Location _serverLoc;
  tz.Location? _deviceLoc;

  final Logger log = Logger("TimeZoneHandler");
  final String defaultTZ = "Etc/UTC";

  bool _useServerTime = true;
  bool get useServerTime => _useServerTime;

  TimeZoneHandler(String serverTZ) {
    tz.initializeTimeZones();
    try {
      _serverLoc = tz.getLocation(serverTZ);
    } on tz.LocationNotFoundException {
      log.fine(() => "Server Timezone: falling back to defaultTZ");
      _serverLoc = tz.getLocation(defaultTZ);
    }
    log.info(() => "Server Timezone: $serverTZ ($sLocation)");
    updateDeviceLocation().then(
      (_) => tz.setLocalLocation(useServerTime ? sLocation : dLocation),
    );
  }

  tz.Location get sLocation => _serverLoc;

  tz.Location get dLocation => _deviceLoc ?? tz.getLocation(defaultTZ);

  Future<void> setUseServerTime(bool useServerTime) async {
    _useServerTime = useServerTime;
    log.finest(() => "set useServertime to $useServerTime");
    await updateDeviceLocation().then(
      (_) => tz.setLocalLocation(useServerTime ? sLocation : dLocation),
    );
  }

  Future<void> updateDeviceLocation() async {
    final TimezoneInfo tzInfo = await FlutterTimezone.getLocalTimezone();
    final String deviceTZ = tzInfo.identifier;
    try {
      _deviceLoc = tz.getLocation(deviceTZ);
    } on tz.LocationNotFoundException {
      log.fine(() => "Device Timezone: falling back to defaultTZ");
      _deviceLoc = tz.getLocation(defaultTZ);
    }
    log.info(() => "Device Timezone: $deviceTZ ($dLocation)");
  }

  tz.TZDateTime getLocalTimeAsServerTime(tz.TZDateTime t) {
    final Duration offsetMs =
        sLocation.currentTimeZone.offset - dLocation.currentTimeZone.offset;
    return t.subtract(offsetMs);
  }

  tz.TZDateTime dNow() => tz.TZDateTime.now(dLocation).toLocal();
  tz.TZDateTime sNow() => tz.TZDateTime.now(sLocation).toLocal();

  tz.TZDateTime dTime(DateTime t) => tz.TZDateTime.from(t, dLocation);
  tz.TZDateTime sTime(DateTime t) => tz.TZDateTime.from(t, sLocation);

  tz.TZDateTime newTXTime() => useServerTime
      ? getLocalTimeAsServerTime(tz.TZDateTime.now(dLocation))
      : dNow();

  tz.TZDateTime notificationTXTime(DateTime t) =>
      useServerTime ? getLocalTimeAsServerTime(dTime(t)) : dTime(t);
}
