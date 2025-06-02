import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:logging/logging.dart';

import 'package:timezone/data/latest.dart' as tz;

import 'package:waterflyiii/app.dart';

void main() async {
  Logger.root.level = kDebugMode ? Level.ALL : Level.INFO;
  Logger.root.onRecord.listen((LogRecord record) {
    developer.log(
      record.message,
      time: record.time,
      sequenceNumber: record.sequenceNumber,
      level: record.level.value,
      name: record.loggerName,
      zone: record.zone,
      error: record.error,
      stackTrace: record.stackTrace,
    );
  });
  tz.initializeTimeZones();
  Intl.defaultLocale = await findSystemLocale();
  await initializeDateFormatting();
  // Observe locale changes (either system-wide or for waterfly only)
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(const WaterflyApp());
}
