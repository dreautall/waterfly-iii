import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/application/settings/notification_processing_settings.dart';
import 'package:waterflyiii/notifications/presentation/shared/definition_detail_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_choice_setting_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';

class NotificationSettingsSection extends StatelessWidget {
  const NotificationSettingsSection({
    super.key,
    required this.title,
    required this.description,
    required this.children,
  });

  final String title;
  final String description;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(title, style: context.notificationSectionTitle),
      const SizedBox(height: 4),
      Text(description, style: context.notificationSectionDescription),
      const SizedBox(height: 12),
      ...children.indexed.map(
        ((int, Widget) entry) => Padding(
          padding: EdgeInsets.only(
            bottom: entry.$1 == children.length - 1 ? 0 : 8,
          ),
          child: entry.$2,
        ),
      ),
    ],
  );
}

class NotificationSettingsActionCard extends StatelessWidget {
  const NotificationSettingsActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.destructive = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final Color? color = destructive ? colors.error : null;
    final bool enabled = onTap != null;
    final Widget card = DefinitionDetailCard(
      onTap: onTap,
      leading: Icon(icon, color: color),
      title: Text(title, style: color == null ? null : TextStyle(color: color)),
      subtitle: Text(subtitle, style: context.notificationSupportingText),
    );
    return Semantics(
      enabled: enabled,
      child: enabled ? card : Opacity(opacity: 0.64, child: card),
    );
  }
}

class NotificationDangerActionGroup extends StatelessWidget {
  const NotificationDangerActionGroup({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colors.errorContainer.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.error.withValues(alpha: 0.28)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: colors.error,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          ...children.indexed.map(
            ((int, Widget) entry) => Padding(
              padding: EdgeInsets.only(
                bottom: entry.$1 == children.length - 1 ? 0 : 8,
              ),
              child: entry.$2,
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationStorageModeCard extends StatelessWidget {
  const NotificationStorageModeCard({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final NotificationHistoryStorageMode value;
  final ValueChanged<NotificationHistoryStorageMode> onChanged;

  @override
  Widget build(BuildContext context) =>
      NotificationChoiceSettingCard<NotificationHistoryStorageMode>(
        leading: const Icon(Icons.history_outlined),
        title: S.of(context).notificationsProcessingHistoryStorageMode,
        subtitle: S
            .of(context)
            .notificationsProcessingHistoryStorageModeDescription,
        dialogTitle: S.of(context).notificationsProcessingHistoryStorageMode,
        value: value,
        options: <NotificationChoiceOption<NotificationHistoryStorageMode>>[
          for (final NotificationHistoryStorageMode mode
              in NotificationHistoryStorageMode.values)
            NotificationChoiceOption<NotificationHistoryStorageMode>(
              value: mode,
              label: _storageModeLabel(context, mode),
            ),
        ],
        onChanged: onChanged,
      );

  String _storageModeLabel(
    BuildContext context,
    NotificationHistoryStorageMode mode,
  ) => switch (mode) {
    NotificationHistoryStorageMode.disabled =>
      S.of(context).notificationsProcessingHistoryStorageDisabled,
    NotificationHistoryStorageMode.metadataOnly =>
      S.of(context).notificationsProcessingHistoryStorageMetadata,
    NotificationHistoryStorageMode.full =>
      S.of(context).notificationsProcessingHistoryStorageFull,
  };
}

class NotificationRetentionCard extends StatelessWidget {
  const NotificationRetentionCard({
    super.key,
    required this.value,
    required this.enabled,
    required this.onChanged,
  });

  final NotificationHistoryRetention value;
  final bool enabled;
  final ValueChanged<NotificationHistoryRetention> onChanged;

  @override
  Widget build(BuildContext context) =>
      NotificationChoiceSettingCard<NotificationHistoryRetention>(
        leading: const Icon(Icons.event_repeat_outlined),
        title: S.of(context).notificationsProcessingHistoryRetention,
        subtitle: S
            .of(context)
            .notificationsProcessingHistoryRetentionDescription,
        dialogTitle: S.of(context).notificationsProcessingHistoryRetention,
        value: value,
        options: <NotificationChoiceOption<NotificationHistoryRetention>>[
          for (final NotificationHistoryRetention retention
              in NotificationHistoryRetention.values)
            NotificationChoiceOption<NotificationHistoryRetention>(
              value: retention,
              label: _retentionLabel(context, retention),
            ),
        ],
        onChanged: onChanged,
        enabled: enabled,
      );

  String _retentionLabel(
    BuildContext context,
    NotificationHistoryRetention retention,
  ) => switch (retention) {
    NotificationHistoryRetention.sevenDays =>
      S.of(context).notificationsProcessingRetentionSevenDays,
    NotificationHistoryRetention.thirtyDays =>
      S.of(context).notificationsProcessingRetentionThirtyDays,
    NotificationHistoryRetention.ninetyDays =>
      S.of(context).notificationsProcessingRetentionNinetyDays,
    NotificationHistoryRetention.forever =>
      S.of(context).notificationsProcessingRetentionForever,
  };
}
