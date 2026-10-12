import 'package:dynamic_color/dynamic_color.dart';
import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/settings.dart' show SettingsProvider;
import 'package:waterflyiii/themes/transactioncolors.dart';

final ColorScheme cSchemeLight = .fromSeed(seedColor: Colors.blue);

ThemeData lightTheme(
  SettingsProvider settings,
  ColorScheme? dynamicColor,
) => ThemeData(
  brightness: .light,
  colorScheme: settings.dynamicColors
      ? dynamicColor?.harmonized() ?? cSchemeLight
      : cSchemeLight,
  useMaterial3: true,
  // See https://github.com/flutter/flutter/issues/131042#issuecomment-1690737834
  appBarTheme: const AppBarTheme(shape: RoundedRectangleBorder()),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
    },
  ),
  extensions: const <ThemeExtension<dynamic>>[
    TransactionColors(
      positiveColor: Colors.green,
      negativeColor: Colors.red,
      transferColor: Colors.blue,
      neutralColor: Colors.grey,
    ),
  ],
);
