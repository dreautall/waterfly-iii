import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_date_time_formatter.dart';

String formatTransactionFieldValue(
  BuildContext context,
  TransactionField field,
  String value,
) {
  switch (field) {
    case TransactionField.date:
      final DateTime? date = DateTime.tryParse(value.trim());
      return date == null ? value : formatNotificationDate(context, date);
    case TransactionField.time:
      final RegExpMatch? match = RegExp(
        r'^([01]\d|2[0-3]):([0-5]\d)(?::[0-5]\d)?$',
      ).firstMatch(value.trim());
      if (match == null) return value;
      return formatNotificationTime(
        context,
        TimeOfDay(
          hour: int.parse(match.group(1)!),
          minute: int.parse(match.group(2)!),
        ),
      );
    default:
      return value;
  }
}
