import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_app_icon.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_card_theme.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_date_time_formatter.dart';

class SampleNotificationCard extends StatelessWidget {
  const SampleNotificationCard({
    super.key,
    required this.applicationId,
    required this.title,
    required this.body,
    this.receivedAt,
    this.titleContent,
    this.bodyContent,
    this.timestampContent,
    this.trailing,
    this.onTap,
  });

  final String applicationId;
  final String title;
  final String body;
  final DateTime? receivedAt;
  final Widget? titleContent;
  final Widget? bodyContent;
  final Widget? timestampContent;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color:
          Theme.of(context).extension<NotificationCardTheme>()?.surfaceColor ??
          Theme.of(context).colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 16),
        leading: NotificationAppIcon(applicationId: applicationId),
        title: _title(context),
        subtitle:
            bodyContent ??
            Text(
              body,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: context.notificationSupportingText,
            ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }

  Widget _title(BuildContext context) {
    final Widget content =
        titleContent ??
        Text(title, maxLines: 1, overflow: TextOverflow.ellipsis);
    final DateTime? timestamp = receivedAt;
    if (timestamp == null) return content;
    final DateTime now = DateTime.now();
    final bool isToday =
        timestamp.year == now.year &&
        timestamp.month == now.month &&
        timestamp.day == now.day;
    final String timestampLabel = isToday
        ? formatNotificationTime(context, TimeOfDay.fromDateTime(timestamp))
        : formatNotificationDate(context, timestamp);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        Flexible(child: content),
        const SizedBox(width: 8),
        timestampContent ??
            Text(
              timestampLabel,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
      ],
    );
  }
}
