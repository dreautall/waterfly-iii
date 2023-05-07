import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';

import 'package:waterflyiii/app.dart';

void main() async {
  Intl.defaultLocale = await findSystemLocale();
  return runApp(const WaterflyApp());
}
