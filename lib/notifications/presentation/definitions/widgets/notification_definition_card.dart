import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/presentation/alerts/notification_alert_display.dart';
import 'package:waterflyiii/notifications/presentation/definitions/widgets/notification_definition_status_display.dart';
import 'package:waterflyiii/notifications/presentation/shared/message_status_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_app_icon.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_card_theme.dart';

class NotificationDefinitionCard extends StatelessWidget {
  const NotificationDefinitionCard({
    super.key,
    required this.definition,
    this.migrationAlerts = const <NotificationAlert>[],
    this.onTap,
  });

  final NotificationDefinition definition;
  final List<NotificationAlert> migrationAlerts;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final NotificationDefinitionStatus status = definition.status;
    final String applicationName = definition.name.trim();
    final String displayName =
        applicationName.isEmpty || applicationName == definition.applicationId
        ? S.of(context).notificationsDefinitionsUnknownApplication
        : applicationName;
    return Card(
      margin: EdgeInsets.zero,
      color: Theme.of(context).extension<NotificationCardTheme>()?.surfaceColor,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  NotificationAppIcon(applicationId: definition.applicationId),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          displayName,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          definition.applicationId,
                          style: context.notificationMetadataText,
                        ),
                      ],
                    ),
                  ),
                  if (onTap != null) ...<Widget>[
                    const SizedBox(width: 16),
                    const Icon(Icons.chevron_right),
                  ],
                ],
              ),
              if (migrationAlerts.isNotEmpty ||
                  definition.requiresMigrationReview) ...<Widget>[
                const SizedBox(height: 16),
                _DefinitionStatusFooter(
                  status: status,
                  migrationAlerts: migrationAlerts,
                  migrationReviewIssues: definition.migrationReviewIssues,
                  hasUnconfiguredConditionalActions:
                      definition.hasUnconfiguredConditionalActions,
                ),
              ],
              if (status != NotificationDefinitionStatus.ready &&
                  migrationAlerts.isEmpty &&
                  !definition.requiresMigrationReview) ...<Widget>[
                const SizedBox(height: 16),
                _DefinitionStatusFooter(
                  status: status,
                  migrationAlerts: const <NotificationAlert>[],
                  migrationReviewIssues: const <NotificationMigrationIssue>{},
                  hasUnconfiguredConditionalActions:
                      definition.hasUnconfiguredConditionalActions,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _DefinitionStatusFooter extends StatelessWidget {
  const _DefinitionStatusFooter({
    required this.status,
    required this.migrationAlerts,
    required this.migrationReviewIssues,
    required this.hasUnconfiguredConditionalActions,
  });

  final NotificationDefinitionStatus status;
  final List<NotificationAlert> migrationAlerts;
  final Set<NotificationMigrationIssue> migrationReviewIssues;
  final bool hasUnconfiguredConditionalActions;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final bool hasMigrationReview =
        migrationAlerts.isNotEmpty || migrationReviewIssues.isNotEmpty;
    final MessageStatus messageStatus = hasMigrationReview
        ? MessageStatus.review
        : status.messageStatus;
    final (
      Color background,
      Color foreground,
      Color accent,
      IconData icon,
    ) = switch (messageStatus) {
      MessageStatus.success => (
        colors.primaryContainer.withValues(alpha: 0.45),
        colors.onPrimaryContainer,
        colors.primary,
        Icons.check_circle_outline,
      ),
      MessageStatus.informational => (
        colors.secondaryContainer.withValues(alpha: 0.45),
        colors.onSecondaryContainer,
        colors.secondary,
        Icons.info_outline,
      ),
      MessageStatus.warning => (
        colors.tertiaryContainer.withValues(alpha: 0.45),
        colors.onTertiaryContainer,
        colors.tertiary,
        Icons.error_outline,
      ),
      MessageStatus.review => (
        colors.tertiaryContainer.withValues(alpha: 0.45),
        colors.onTertiaryContainer,
        colors.tertiary,
        Icons.error_outline,
      ),
      MessageStatus.error => (
        colors.errorContainer.withValues(alpha: 0.45),
        colors.onErrorContainer,
        colors.error,
        Icons.error_outline,
      ),
    };
    return Semantics(
      container: true,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: background,
          border: Border(left: BorderSide(color: accent, width: 3)),
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(icon, color: foreground, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    hasMigrationReview
                        ? S
                              .of(context)
                              .notificationsDefinitionMigrationNeedsAttention(
                                migrationAlerts.isNotEmpty
                                    ? migrationAlerts.length
                                    : migrationReviewIssues.length,
                              )
                        : status.label(context),
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall?.copyWith(color: foreground),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    hasMigrationReview
                        ? _migrationMessage(context)
                        : status == NotificationDefinitionStatus.needsReview &&
                              hasUnconfiguredConditionalActions
                        ? S
                              .of(context)
                              .notificationsDefinitionConditionalActionsNeedReviewMessage
                        : status.message(context),
                    style: TextStyle(color: foreground),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _migrationMessage(BuildContext context) {
    final List<String> messages = migrationAlerts.isNotEmpty
        ? migrationAlerts
              .take(2)
              .map((NotificationAlert alert) {
                final NotificationMigrationIssue? issue = alert.migrationIssue;
                if (issue != null) return issue.message(context);
                return alert.kind == NotificationAlertKind.migrationFailed
                    ? S
                          .of(context)
                          .notificationsDefinitionMigrationFailedMessage
                    : S
                          .of(context)
                          .notificationsDefinitionMigrationReviewMessage;
              })
              .toList(growable: false)
        : migrationReviewIssues
              .take(2)
              .map((NotificationMigrationIssue issue) => issue.message(context))
              .toList(growable: false);
    return <String>[
      ...messages,
      S.of(context).notificationsDefinitionMigrationOpenSetupHint,
    ].join(' ');
  }
}
