import 'package:dynamic_color/dynamic_color.dart';
import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/settings.dart' show SettingsProvider;
import 'package:waterflyiii/themes/transactioncolors.dart';

final ColorScheme cSchemeDark =
    .fromSeed(seedColor: Colors.blue, brightness: Brightness.dark).copyWith(
      surfaceContainerHighest: Colors.blueGrey.shade900,
      onSurfaceVariant: Colors.white,
    );

ThemeData darkTheme(SettingsProvider settings, ColorScheme? dynamicColor) =>
    ThemeData(
      brightness: .dark,
      colorScheme: settings.dynamicColors
          ? dynamicColor?.harmonized() ?? cSchemeDark
          : cSchemeDark,
      useMaterial3: true,
      extensions: <ThemeExtension<dynamic>>[
        TransactionColors(
          positiveColor: Colors.green,
          negativeColor: Colors.red.shade300,
          transferColor: Colors.blue,
          neutralColor: Colors.grey,
        ),
      ],
    );
