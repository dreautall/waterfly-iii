import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/listeners/notification_listener_health_issue.dart';
import 'package:waterflyiii/notifications/presentation/shared/message_status_card.dart';

class NotificationListenerHealthCard extends StatelessWidget {
  const NotificationListenerHealthCard({
    required this.issue,
    required this.isBusy,
    required this.onRetry,
    required this.onAcknowledge,
    this.onReviewSetup,
    super.key,
  });

  final NotificationListenerHealthIssue issue;
  final bool isBusy;
  final Future<void> Function() onRetry;
  final Future<void> Function() onAcknowledge;
  final VoidCallback? onReviewSetup;

  @override
  Widget build(BuildContext context) {
    final bool isActive = issue.isActive;
    return MessageStatusCard(
      status: isActive ? MessageStatus.error : MessageStatus.success,
      icon: isActive ? Icons.sync_problem_outlined : Icons.task_alt_outlined,
      title: isActive
          ? S.of(context).notificationsHealthActiveTitle
          : S.of(context).notificationsHealthRecoveredTitle,
      message: isActive
          ? S
                .of(context)
                .notificationsHealthActiveDescription(issue.occurrenceCount)
          : S
                .of(context)
                .notificationsHealthRecoveredDescription(issue.occurrenceCount),
      actionsBuilder: (BuildContext context, Color foreground) => Wrap(
        spacing: 12,
        runSpacing: 4,
        children: <Widget>[
          if (isActive)
            _HealthAction(
              foreground: foreground,
              icon: isBusy ? null : Icons.refresh,
              isBusy: isBusy,
              label: S.of(context).notificationsHealthRetry,
              onPressed: isBusy ? null : onRetry,
              primary: true,
            )
          else
            _HealthAction(
              foreground: foreground,
              icon: Icons.done,
              label: S.of(context).notificationsHealthDismiss,
              onPressed: isBusy ? null : onAcknowledge,
              primary: true,
            ),
          if (onReviewSetup != null)
            _HealthAction(
              foreground: foreground,
              icon: Icons.tune,
              label: S.of(context).notificationsHealthReviewSetup,
              onPressed: isBusy ? null : onReviewSetup,
            ),
        ],
      ),
    );
  }
}

class _HealthAction extends StatelessWidget {
  const _HealthAction({
    required this.foreground,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isBusy = false,
    this.primary = false,
  });

  final Color foreground;
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isBusy;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    final Widget iconWidget = isBusy
        ? const SizedBox.square(
            dimension: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : Icon(icon, size: 18);
    final ButtonStyle style = ButtonStyle(
      foregroundColor: WidgetStatePropertyAll<Color>(foreground),
      backgroundColor: primary
          ? WidgetStatePropertyAll<Color>(foreground.withValues(alpha: 0.12))
          : null,
      side: WidgetStatePropertyAll<BorderSide>(
        BorderSide(color: foreground.withValues(alpha: 0.55)),
      ),
      minimumSize: const WidgetStatePropertyAll<Size>(Size.zero),
      padding: const WidgetStatePropertyAll<EdgeInsets>(
        EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
    if (primary) {
      return FilledButton.tonalIcon(
        onPressed: onPressed,
        style: style,
        icon: iconWidget,
        label: Text(label),
      );
    }
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: style,
      icon: iconWidget,
      label: Text(label),
    );
  }
}
