import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';
import 'package:waterflyiii/notifications/presentation/shared/sample_notification_card.dart';

class RuleSampleSection extends StatelessWidget {
  const RuleSampleSection({
    super.key,
    required this.sample,
    required this.hasOverride,
    required this.description,
    this.onEdit,
    this.onClearOverride,
    this.clearOverrideTooltip,
  });

  final NotificationContext sample;
  final bool hasOverride;
  final String description;
  final VoidCallback? onEdit;
  final VoidCallback? onClearOverride;
  final String? clearOverrideTooltip;

  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          strings.notificationsRuleSampleNotification,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 4),
        Text(description, style: context.notificationSectionDescription),
        const SizedBox(height: 12),
        SampleNotificationCard(
          applicationId: sample.applicationId ?? '',
          title: sample.title,
          body: sample.body,
          receivedAt: sample.receivedAt,
          onTap: onEdit,
          trailing: onEdit == null
              ? null
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (hasOverride && onClearOverride != null)
                      IconButton(
                        tooltip:
                            clearOverrideTooltip ??
                            strings.notificationsUseDefinitionSample,
                        onPressed: onClearOverride,
                        icon: const Icon(Icons.undo_outlined),
                        iconSize: 18,
                      ),
                    IconButton(
                      tooltip: strings.notificationsRuleEditTestNotification,
                      onPressed: onEdit,
                      icon: const Icon(Icons.edit_outlined),
                      iconSize: 18,
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
