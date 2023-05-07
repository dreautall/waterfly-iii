import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:logging/logging.dart';

import 'package:waterflyiii/app.dart';

void main() async {
  Intl.defaultLocale = await findSystemLocale();
  Logger.root.level = kDebugMode ? Level.ALL : Level.INFO;
  Logger.root.onRecord.listen((LogRecord record) {
    debugPrint("${record.level.name}: ${record.time}: ${record.message}");
    // :TODO: add to file/stack/whatever when debug is enabled
  });
  return runApp(const WaterflyApp());
}
