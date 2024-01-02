import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:logging/logging.dart';
import 'package:timezone/timezone.dart' as tz;

class TimeZoneHandler {
  late tz.Location _serverLoc;
  tz.Location? _deviceLoc;

  final Logger log = Logger("TimeZoneHandler");

  TimeZoneHandler(String serverTZ) {
    try {
      _serverLoc = tz.getLocation(serverTZ);
    } on tz.LocationNotFoundException {
      _serverLoc = tz.getLocation("utc");
    }
    log.info(() => "Server Timezone: $serverTZ ($sLocation)");
    updateDeviceLocation();

    // :TODO: add option
    tz.setLocalLocation(sLocation);
  }

  tz.Location get sLocation => _serverLoc;
  tz.Location get dLocation => _deviceLoc ?? tz.getLocation("utc");

  void updateDeviceLocation() async {
    final String deviceTZ = await FlutterTimezone.getLocalTimezone();
    try {
      _deviceLoc = tz.getLocation(deviceTZ);
    } on tz.LocationNotFoundException {
      _deviceLoc = tz.getLocation("utc");
    }
    log.info(() => "Device Timezone: $deviceTZ ($dLocation)");
  }

  tz.TZDateTime getLocalTimeAsServerTime() {
    final int offsetMs =
        sLocation.currentTimeZone.offset - dLocation.currentTimeZone.offset;
    return tz.TZDateTime.now(dLocation).add(Duration(milliseconds: offsetMs));
  }

  tz.TZDateTime dNow() => tz.TZDateTime.now(dLocation).toLocal();
  tz.TZDateTime sNow() => tz.TZDateTime.now(sLocation).toLocal();

  tz.TZDateTime dTime(DateTime t) => tz.TZDateTime.from(t, dLocation);
  tz.TZDateTime sTime(DateTime t) => tz.TZDateTime.from(t, sLocation);
}
