import 'package:timezone/timezone.dart' as tz;
import 'package:waterflyiii/timezonehandler.dart';

class FakeTimeZoneHandler implements TimeZoneHandler {
  @override
  tz.TZDateTime sTime(DateTime t) => tz.TZDateTime.from(t, tz.UTC);

  @override
  tz.TZDateTime newTXTime() => tz.TZDateTime.now(tz.UTC);

  @override
  tz.Location get sLocation => tz.UTC;

  @override
  tz.Location get dLocation => tz.UTC;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
