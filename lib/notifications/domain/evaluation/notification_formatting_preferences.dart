import 'package:intl/intl.dart';

class NotificationFormattingPreferences {
  const NotificationFormattingPreferences({
    required this.locale,
    required this.use24HourFormat,
  });

  final String locale;
  final bool use24HourFormat;

  String formatDate(DateTime value) => DateFormat.yMd(locale).format(value);

  String formatTime(DateTime value) =>
      (use24HourFormat ? DateFormat.Hm(locale) : DateFormat.jm(locale)).format(
        value,
      );

  String formatDateTime(DateTime value) =>
      '${formatDate(value)} ${formatTime(value)}';
}
