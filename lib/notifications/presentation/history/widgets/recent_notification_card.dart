import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/application/history/recent_notification_history.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/history/notification_history_entry.dart';
import 'package:waterflyiii/notifications/domain/history/notification_processing_outcome.dart';
import 'package:waterflyiii/notifications/presentation/history/recent_notification_actions.dart';
import 'package:waterflyiii/notifications/presentation/history/widgets/recent_notification_details.dart';
import 'package:waterflyiii/notifications/presentation/history/widgets/recent_notification_outcome.dart';
import 'package:waterflyiii/notifications/presentation/shared/message_status_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_app_icon.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_date_time_formatter.dart';
import 'package:waterflyiii/notifications/presentation/shared/reveal_expanded_content.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_card_theme.dart';

class RecentNotificationCard extends StatefulWidget {
  const RecentNotificationCard({
    super.key,
    required this.entry,
    required this.expanded,
    required this.onExpansionChanged,
    this.actions,
    this.onCreateRule,
    this.onCreateTransaction,
    this.onEditRule,
    this.onOpenAlert,
    this.onOpenAlerts,
    this.onOpenDefinition,
    this.onOpenTransaction,
  });

  final RecentNotificationHistoryEntry entry;
  final bool expanded;
  final ValueChanged<bool> onExpansionChanged;
  final RecentNotificationActions? actions;

  // Legacy callbacks remain available because this widget was previously
  // exported from recent_notifications_page.dart.
  final Future<void> Function(RecentNotificationHistoryEntry entry)?
  onCreateRule;
  final RecentNotificationEntryAction? onCreateTransaction;
  final Future<void> Function(RecentNotificationHistoryEntry entry)? onEditRule;
  final Future<void> Function(NotificationAlert alert)? onOpenAlert;
  final Future<void> Function()? onOpenAlerts;
  final RecentNotificationEntryAction? onOpenDefinition;
  final Future<void> Function(String transactionId)? onOpenTransaction;

  RecentNotificationActions get resolvedActions =>
      actions ??
      RecentNotificationActions(
        createRule: onCreateRule == null
            ? null
            : (RecentNotificationHistoryEntry entry) async {
                await onCreateRule!(entry);
                return false;
              },
        createTransaction: onCreateTransaction,
        editRule: onEditRule == null
            ? null
            : (RecentNotificationHistoryEntry entry) async {
                await onEditRule!(entry);
                return false;
              },
        openAlert: onOpenAlert,
        openAlerts: onOpenAlerts,
        openDefinition: onOpenDefinition,
        openTransaction: onOpenTransaction,
      );

  @override
  State<RecentNotificationCard> createState() => _RecentNotificationCardState();
}

class _RecentNotificationCardState extends State<RecentNotificationCard> {
  void _toggleExpanded() {
    final bool expanded = !widget.expanded;
    widget.onExpansionChanged(expanded);
    if (expanded) unawaited(revealExpandedContent(context));
  }

  @override
  Widget build(BuildContext context) {
    final RecentNotificationHistoryEntry entry = widget.entry;
    final NotificationHistoryEntry notification = entry.notification;
    final bool isRedacted =
        notification.title.trim().isEmpty && notification.body.trim().isEmpty;
    return Card(
      margin: EdgeInsets.zero,
      color: Theme.of(context).extension<NotificationCardTheme>()?.surfaceColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: _toggleExpanded,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  NotificationAppIcon(
                    applicationId: notification.applicationId,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Wrap(
                          spacing: 8,
                          runSpacing: 2,
                          crossAxisAlignment: WrapCrossAlignment.end,
                          children: <Widget>[
                            Text(
                              isRedacted
                                  ? S
                                        .of(context)
                                        .notificationsHistoryRedactedTitle
                                  : notification.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              formatNotificationDateTime(
                                context,
                                notification.receivedAt,
                              ),
                              maxLines: 1,
                              style: context.notificationMetadataText,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          isRedacted
                              ? S.of(context).notificationsHistoryRedactedBody
                              : notification.body,
                          style: isRedacted
                              ? context.notificationSupportingText
                              : null,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: AnimatedRotation(
                      turns: widget.expanded ? 0.5 : 0,
                      duration: notificationExpansionDuration,
                      curve: Curves.easeInOut,
                      child: const Icon(Icons.expand_more),
                    ),
                  ),
                ],
              ),
            ),
            ClipRect(
              child: AnimatedAlign(
                duration: notificationExpansionDuration,
                curve: Curves.easeInOut,
                alignment: Alignment.topCenter,
                heightFactor: widget.expanded ? 1 : 0,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 140),
                  curve: Curves.easeIn,
                  opacity: widget.expanded ? 1 : 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Divider(
                        height: 1,
                        thickness: 1,
                        indent: 16,
                        endIndent: 16,
                        color: Theme.of(context).colorScheme.outlineVariant,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 15, 16, 16),
                        child: _controls(entry),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _controls(RecentNotificationHistoryEntry entry) {
    final RecentNotificationActions actions = widget.resolvedActions;
    final NotificationAlert? failure = entry.processingFailure;
    if (failure != null) return _failureControls(entry, failure);
    if (entry.processingOutcome?.status ==
        NotificationProcessingOutcomeStatus.failed) {
      return _promptControls(
        RecentNotificationOutcome(
          status: MessageStatus.error,
          icon: Icons.error_outline,
          title: S.of(context).notificationsHistoryProcessingFailureTitle,
          message:
              entry.processingOutcome?.failureMessage ??
              S.of(context).notificationsHistoryRedactedFailureMessage,
        ),
        actions.openAlerts == null
            ? null
            : RecentNotificationActionsButton(
                label: S.of(context).notificationsHistoryViewAlerts,
                primaryIcon: Icons.error_outline,
                onPrimaryAction: actions.openAlerts,
                onOpenDefinition: _definitionAction(entry),
                onRemoveFromHistory: _removeAction(entry),
              ),
      );
    }
    final String? transactionId = entry.processingOutcome?.transactionId;
    if (transactionId != null) {
      return _promptControls(
        RecentNotificationOutcome(
          status: MessageStatus.success,
          icon: Icons.check_circle_outline,
          title: switch (entry
              .processingOutcome
              ?.effectiveTransactionCreationOrigin) {
            NotificationTransactionCreationOrigin.automatic =>
              S.of(context).notificationsHistoryTransactionCreatedTitle,
            NotificationTransactionCreationOrigin.user =>
              S.of(context).notificationsHistoryTransactionCreatedByUserTitle,
            null => S.of(context).notificationsHistoryTransactionCreated,
          },
          message:
              entry.matchingRuleName ??
              S.of(context).notificationsHistorySharedActionsTitle,
          trailing: RecentNotificationDetails(entry: entry),
        ),
        RecentNotificationActionsButton(
          label: S.of(context).notificationsHistoryViewTransaction,
          primaryIcon: Icons.open_in_new,
          onPrimaryAction: actions.openTransaction == null
              ? null
              : () => actions.openTransaction!(transactionId),
          onEditRule: actions.editRule == null || entry.matchingRule == null
              ? null
              : () => actions.editRule!(entry),
          onOpenDefinition: _definitionAction(entry),
          onRemoveFromHistory: _removeAction(entry),
        ),
      );
    }
    if (entry.matchingRuleName != null) {
      return _promptControls(
        RecentNotificationOutcome(
          status: MessageStatus.success,
          icon: Icons.check_circle_outline,
          title: S.of(context).notificationsHistoryMatchingRuleLabel,
          message: entry.matchingRuleName!,
          titleStyle: context.notificationMetadataText,
          messageStyle: Theme.of(context).textTheme.titleSmall,
          trailing: RecentNotificationDetails(entry: entry),
        ),
        RecentNotificationActionsButton(
          label: S.of(context).notificationsHistoryCreateTransaction,
          primaryIcon: Icons.add_card_outlined,
          onPrimaryAction: actions.createTransaction == null
              ? null
              : () => actions.createTransaction!(entry),
          onEditRule: actions.editRule == null
              ? null
              : () => actions.editRule!(entry),
          onOpenDefinition: _definitionAction(entry),
          onRemoveFromHistory: _removeAction(entry),
        ),
      );
    }
    if (entry.canCreateTransaction) {
      return _promptControls(
        RecentNotificationOutcome(
          status: MessageStatus.success,
          icon: Icons.check_circle_outline,
          title: S.of(context).notificationsHistorySharedActionsTitle,
          message: S.of(context).notificationsHistorySharedActionsMessage,
          trailing: RecentNotificationDetails(entry: entry),
        ),
        RecentNotificationActionsButton(
          label: S.of(context).notificationsHistoryCreateTransaction,
          primaryIcon: Icons.add_card_outlined,
          onPrimaryAction: actions.createTransaction == null
              ? null
              : () => actions.createTransaction!(entry),
          onOpenDefinition: _definitionAction(entry),
          onRemoveFromHistory: _removeAction(entry),
        ),
      );
    }
    return _promptControls(
      RecentNotificationOutcome(
        status: MessageStatus.informational,
        icon: Icons.rule_outlined,
        title: S.of(context).notificationsHistoryNoMatchingRuleTitle,
        message: S.of(context).notificationsHistoryNoMatchingRuleMessage,
      ),
      RecentNotificationActionsButton(
        label: S.of(context).notificationsHistoryCreateRule,
        primaryIcon: Icons.rule_outlined,
        onPrimaryAction: actions.createRule == null
            ? null
            : () => actions.createRule!(entry),
        onOpenDefinition: _definitionAction(entry),
        onRemoveFromHistory: _removeAction(entry),
      ),
    );
  }

  Widget _promptControls(RecentNotificationOutcome prompt, Widget? action) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          prompt,
          if (action != null) ...<Widget>[
            if (prompt.trailing != null) ...<Widget>[
              const SizedBox(height: 16),
              Divider(
                key: const Key('notification-outcome-divider'),
                height: 1,
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            ],
            const SizedBox(height: 16),
            SizedBox(width: double.infinity, child: action),
          ],
        ],
      );

  VoidCallback? _definitionAction(RecentNotificationHistoryEntry entry) =>
      widget.resolvedActions.openDefinition == null || entry.definition == null
      ? null
      : () => widget.resolvedActions.openDefinition!(entry);

  VoidCallback? _removeAction(RecentNotificationHistoryEntry entry) =>
      widget.resolvedActions.removeFromHistory == null
      ? null
      : () => widget.resolvedActions.removeFromHistory!(entry);

  Widget _failureControls(
    RecentNotificationHistoryEntry entry,
    NotificationAlert failure,
  ) {
    final VoidCallback? onOpenDefinition = _definitionAction(entry);
    final bool isRedacted =
        entry.notification.title.isEmpty && entry.notification.body.isEmpty;
    return _promptControls(
      RecentNotificationOutcome(
        status: MessageStatus.error,
        icon: Icons.error_outline,
        title: S.of(context).notificationsHistoryProcessingFailureTitle,
        message: isRedacted
            ? S.of(context).notificationsHistoryRedactedFailureMessage
            : failure.message,
      ),
      widget.resolvedActions.openAlert == null && onOpenDefinition == null
          ? null
          : widget.resolvedActions.openAlert == null
          ? FilledButton.icon(
              onPressed: onOpenDefinition,
              icon: const Icon(Icons.rule_folder_outlined),
              label: Text(S.of(context).notificationsHistoryGoToDefinition),
            )
          : RecentNotificationActionsButton(
              label: S.of(context).notificationsHistoryViewAlert,
              primaryIcon: Icons.error_outline,
              onPrimaryAction: () => widget.resolvedActions.openAlert!(failure),
              onOpenDefinition: onOpenDefinition,
              onRemoveFromHistory: _removeAction(entry),
            ),
    );
  }
}
