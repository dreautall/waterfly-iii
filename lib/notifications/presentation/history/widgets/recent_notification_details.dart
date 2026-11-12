import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/application/history/recent_notification_history.dart';
import 'package:waterflyiii/notifications/domain/history/notification_processing_outcome.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';
import 'package:waterflyiii/notifications/presentation/shared/transaction_patch_summary.dart';

class RecentNotificationDetails extends StatelessWidget {
  const RecentNotificationDetails({super.key, required this.entry});

  final RecentNotificationHistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    final NotificationProcessingOutcome? outcome = entry.processingOutcome;
    if (outcome == null) {
      return entry.matchingConditionalActionGroupNames.isEmpty
          ? const SizedBox.shrink()
          : _MatchedActionsList(
              groupNames: entry.matchingConditionalActionGroupNames,
            );
    }
    final bool hasGroups = entry.matchingConditionalActionGroupNames.isNotEmpty;
    final bool detailsHidden =
        outcome.hasTransactionIntent && outcome.transactionPatch == null;
    final bool hasPatch =
        outcome.transactionPatch != null && !outcome.transactionPatch!.isEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (hasGroups)
          _MatchedActionsList(
            groupNames: entry.matchingConditionalActionGroupNames,
          ),
        if (hasGroups && (detailsHidden || hasPatch))
          const SizedBox(height: 12),
        if (detailsHidden)
          Row(
            children: <Widget>[
              const Icon(Icons.visibility_off_outlined, size: 18),
              const SizedBox(width: 8),
              Text(S.of(context).notificationsHistoryTransactionDetailsHidden),
            ],
          ),
        if (hasPatch) TransactionPatchSummary(patch: outcome.transactionPatch!),
      ],
    );
  }
}

class _MatchedActionsList extends StatelessWidget {
  const _MatchedActionsList({required this.groupNames});

  final List<String> groupNames;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          S.of(context).notificationsHistoryMatchingConditionalActionsLabel,
          style: context.notificationMetadataText,
        ),
        const SizedBox(height: 8),
        for (final (int index, String groupName) in groupNames.indexed)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                key: Key('matched-action-$index'),
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: colors.primaryContainer.withValues(alpha: 0.35),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.alt_route,
                      size: 18,
                      color: colors.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      groupName,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
              if (index != groupNames.length - 1)
                Container(
                  key: Key('matched-action-connector-$index'),
                  width: 1,
                  height: 8,
                  margin: const EdgeInsets.only(left: 15.5),
                  color: colors.outlineVariant,
                ),
            ],
          ),
      ],
    );
  }
}
