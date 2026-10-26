import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';

enum NotificationSetupExperience { simple, basic, advanced }

class DefinitionSetupModeSection extends StatelessWidget {
  const DefinitionSetupModeSection({
    super.key,
    required this.hasSample,
    required this.onModeSelected,
  });

  final bool hasSample;
  final ValueChanged<NotificationSetupExperience> onModeSelected;

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
        experience: NotificationSetupExperience.simple,
        icon: Icons.receipt_long_outlined,
        title: S.of(context).notificationsDefinitionSimple,
        subtitle: S.of(context).notificationsDefinitionSimpleDescription,
        enabled: hasSample,
        onSelected: onModeSelected,
      ),
      const SizedBox(height: 8),
      _SetupModeOption(
        experience: NotificationSetupExperience.basic,
        icon: Icons.auto_awesome,
        title: S.of(context).notificationsDefinitionBasic,
        subtitle: S.of(context).notificationsDefinitionBasicDescription,
        enabled: hasSample,
        onSelected: onModeSelected,
      ),
      const SizedBox(height: 8),
      _SetupModeOption(
        experience: NotificationSetupExperience.advanced,
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
    required this.experience,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.enabled,
    required this.onSelected,
  });

  final NotificationSetupExperience experience;
  final IconData icon;
  final String title;
  final String subtitle;
  final bool enabled;
  final ValueChanged<NotificationSetupExperience> onSelected;

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
      onTap: enabled ? () => onSelected(experience) : null,
    ),
  );
}
