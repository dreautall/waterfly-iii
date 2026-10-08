import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_formatting_preferences.dart';

NotificationFormattingPreferences notificationFormattingPreferencesOf(
  BuildContext context,
) => NotificationFormattingPreferences(
  locale: Localizations.localeOf(context).toString(),
  use24HourFormat: MediaQuery.alwaysUse24HourFormatOf(context),
);

String formatNotificationDateTime(BuildContext context, DateTime dateTime) {
  return notificationFormattingPreferencesOf(context).formatDateTime(dateTime);
}

String formatNotificationDate(BuildContext context, DateTime dateTime) =>
    notificationFormattingPreferencesOf(context).formatDate(dateTime);

String formatNotificationTime(BuildContext context, TimeOfDay time) =>
    notificationFormattingPreferencesOf(
      context,
    ).formatTime(DateTime(1970, 1, 1, time.hour, time.minute));
