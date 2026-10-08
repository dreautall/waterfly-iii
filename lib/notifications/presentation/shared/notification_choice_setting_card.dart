import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/notifications/presentation/shared/definition_detail_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_dialog.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';

class NotificationChoiceOption<T> {
  const NotificationChoiceOption({required this.value, required this.label});

  final T value;
  final String label;
}

class NotificationChoiceSettingCard<T> extends StatelessWidget {
  const NotificationChoiceSettingCard({
    super.key,
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.dialogTitle,
    required this.value,
    required this.options,
    required this.onChanged,
    this.enabled = true,
  });

  final Widget leading;
  final String title;
  final String subtitle;
  final String dialogTitle;
  final T value;
  final List<NotificationChoiceOption<T>> options;
  final ValueChanged<T> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final String currentLabel = options
        .firstWhere(
          (NotificationChoiceOption<T> option) => option.value == value,
          orElse: () => options.first,
        )
        .label;
    final Widget card = DefinitionDetailCard(
      onTap: enabled ? () => _choose(context) : null,
      leading: leading,
      title: Text(title),
      subtitle: Text(subtitle, style: context.notificationSupportingText),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              currentLabel,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: enabled ? colors.onSurfaceVariant : colors.outline,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.chevron_right,
              color: enabled ? colors.onSurfaceVariant : colors.outline,
            ),
          ],
        ),
      ),
    );
    return enabled ? card : Opacity(opacity: 0.64, child: card);
  }

  Future<void> _choose(BuildContext context) async {
    final T? selected = await showNotificationDialog<T>(
      context: context,
      builder: (BuildContext context) => _NotificationChoiceDialog<T>(
        title: dialogTitle,
        value: value,
        options: options,
      ),
    );
    if (selected != null && selected != value) {
      onChanged(selected);
    }
  }
}

class _NotificationChoiceDialog<T> extends StatelessWidget {
  const _NotificationChoiceDialog({
    required this.title,
    required this.value,
    required this.options,
  });

  final String title;
  final T value;
  final List<NotificationChoiceOption<T>> options;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return AlertDialog(
      title: Text(title),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            for (final (int index, NotificationChoiceOption<T> option)
                in options.indexed) ...<Widget>[
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  option.label,
                  style: option.value == value
                      ? Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.w600,
                        )
                      : null,
                ),
                trailing: option.value == value
                    ? Icon(Icons.check, color: colors.primary)
                    : null,
                onTap: () => Navigator.of(context).pop(option.value),
              ),
              if (index != options.length - 1)
                Divider(
                  height: 1,
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                  color: colors.outlineVariant,
                ),
            ],
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
      ],
    );
  }
}
