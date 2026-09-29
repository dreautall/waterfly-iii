import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/application/history/recent_notification_history.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';

typedef RecentNotificationEntryAction =
    Future<void> Function(RecentNotificationHistoryEntry entry);
typedef RecentNotificationEntryResultAction =
    Future<bool> Function(RecentNotificationHistoryEntry entry);

class RecentNotificationActions {
  const RecentNotificationActions({
    this.createRule,
    this.createTransaction,
    this.editRule,
    this.openAlert,
    this.openAlerts,
    this.openDefinition,
    this.openTransaction,
    this.removeFromHistory,
    this.restoreToHistory,
  });

  final RecentNotificationEntryResultAction? createRule;
  final RecentNotificationEntryAction? createTransaction;
  final RecentNotificationEntryResultAction? editRule;
  final Future<void> Function(NotificationAlert alert)? openAlert;
  final Future<void> Function()? openAlerts;
  final RecentNotificationEntryAction? openDefinition;
  final Future<void> Function(String transactionId)? openTransaction;
  final RecentNotificationEntryAction? removeFromHistory;
  final RecentNotificationEntryAction? restoreToHistory;
}

enum _HistoryAction { editRule, openDefinition, removeFromHistory }

class RecentNotificationActionsButton extends StatelessWidget {
  const RecentNotificationActionsButton({
    super.key,
    required this.label,
    required this.primaryIcon,
    required this.onPrimaryAction,
    this.onEditRule,
    this.onOpenDefinition,
    this.onRemoveFromHistory,
  });

  final String label;
  final IconData primaryIcon;
  final VoidCallback? onPrimaryAction;
  final VoidCallback? onEditRule;
  final VoidCallback? onOpenDefinition;
  final VoidCallback? onRemoveFromHistory;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final BorderRadius borderRadius = BorderRadius.circular(20);
    final bool enabled = onPrimaryAction != null;
    final Color background = enabled
        ? colors.primary
        : colors.onSurface.withValues(alpha: 0.12);
    final Color foreground = enabled
        ? colors.onPrimary
        : colors.onSurface.withValues(alpha: 0.38);
    if (onEditRule == null &&
        onOpenDefinition == null &&
        onRemoveFromHistory == null) {
      return FilledButton.icon(
        onPressed: onPrimaryAction,
        icon: Icon(primaryIcon),
        label: Text(label),
      );
    }
    return Material(
      color: background,
      borderRadius: borderRadius,
      clipBehavior: Clip.antiAlias,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: onPrimaryAction,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(primaryIcon, color: foreground),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        label,
                        style: Theme.of(
                          context,
                        ).textTheme.labelLarge?.copyWith(color: foreground),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 32,
            child: VerticalDivider(
              width: 1,
              thickness: 1,
              color: foreground.withValues(alpha: 0.24),
            ),
          ),
          PopupMenuButton<_HistoryAction>(
            tooltip: S.of(context).notificationsHistoryActions,
            position: PopupMenuPosition.under,
            color: colors.surfaceContainerHigh,
            icon: Icon(Icons.arrow_drop_down, color: foreground),
            onSelected: (_HistoryAction action) {
              switch (action) {
                case _HistoryAction.editRule:
                  onEditRule!();
                case _HistoryAction.openDefinition:
                  onOpenDefinition!();
                case _HistoryAction.removeFromHistory:
                  onRemoveFromHistory!();
              }
            },
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<_HistoryAction>>[
                  if (onEditRule != null)
                    PopupMenuItem<_HistoryAction>(
                      value: _HistoryAction.editRule,
                      child: Row(
                        children: <Widget>[
                          const Icon(Icons.edit_outlined),
                          const SizedBox(width: 12),
                          Text(S.of(context).notificationsHistoryEditRule),
                        ],
                      ),
                    ),
                  if (onOpenDefinition != null)
                    PopupMenuItem<_HistoryAction>(
                      value: _HistoryAction.openDefinition,
                      child: Row(
                        children: <Widget>[
                          const Icon(Icons.rule_folder_outlined),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              S.of(context).notificationsHistoryGoToDefinition,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (onRemoveFromHistory !=
                      null) ...<PopupMenuEntry<_HistoryAction>>[
                    const PopupMenuDivider(),
                    PopupMenuItem<_HistoryAction>(
                      value: _HistoryAction.removeFromHistory,
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.delete_outline, color: colors.error),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              S
                                  .of(context)
                                  .notificationsHistoryRemoveFromHistory,
                              style: TextStyle(color: colors.error),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
          ),
        ],
      ),
    );
  }
}
