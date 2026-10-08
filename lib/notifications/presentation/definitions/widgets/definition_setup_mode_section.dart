import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';

class DefinitionSetupModeSection extends StatelessWidget {
  const DefinitionSetupModeSection({
    super.key,
    required this.mode,
    required this.hasSample,
    required this.onModeSelected,
  });

  final NotificationExtractorMode mode;
  final bool hasSample;
  final ValueChanged<NotificationExtractorMode> onModeSelected;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        S.of(context).notificationsDefinitionSetupHeading,
        style: context.notificationSectionTitle,
      ),
      const SizedBox(height: 4),
      Text(
        S.of(context).notificationsDefinitionSetupDescription,
        style: context.notificationSectionDescription,
      ),
      const SizedBox(height: 12),
      if (!hasSample) ...<Widget>[
        Text(
          S.of(context).notificationsDefinitionSetupSampleRequired,
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
        const SizedBox(height: 12),
      ],
      _SetupModeOption(
        mode: NotificationExtractorMode.basic,
        icon: Icons.auto_awesome,
        title: S.of(context).notificationsDefinitionBasic,
        subtitle: S.of(context).notificationsDefinitionBasicDescription,
        enabled: hasSample,
        onSelected: onModeSelected,
      ),
      const SizedBox(height: 8),
      _SetupModeOption(
        mode: NotificationExtractorMode.advanced,
        icon: Icons.tune,
        title: S.of(context).notificationsDefinitionAdvanced,
        subtitle: S.of(context).notificationsDefinitionAdvancedDescription,
        enabled: hasSample,
        onSelected: onModeSelected,
      ),
    ],
  );
}

class _SetupModeOption extends StatelessWidget {
  const _SetupModeOption({
    required this.mode,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.enabled,
    required this.onSelected,
  });

  final NotificationExtractorMode mode;
  final IconData icon;
  final String title;
  final String subtitle;
  final bool enabled;
  final ValueChanged<NotificationExtractorMode> onSelected;

  @override
  Widget build(BuildContext context) => Card(
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: ListTile(
      contentPadding: const EdgeInsets.only(left: 16),
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle, style: context.notificationSupportingText),
      trailing: const SizedBox(
        width: 48,
        child: Center(child: Icon(Icons.chevron_right)),
      ),
      enabled: enabled,
      onTap: enabled ? () => onSelected(mode) : null,
    ),
  );
}
