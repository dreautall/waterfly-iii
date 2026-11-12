import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_card_theme.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_input_decoration.dart';

class DialogSelectorCard extends StatelessWidget {
  const DialogSelectorCard({
    super.key,
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.trailing,
    this.margin = EdgeInsets.zero,
    this.backgroundColor,
    this.contentPadding,
  });

  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;
  final EdgeInsetsGeometry margin;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) => Card(
    margin: margin,
    elevation: 0,
    clipBehavior: Clip.antiAlias,
    color:
        backgroundColor ??
        notificationDialogSurfaceColor(context) ??
        Theme.of(context).colorScheme.surfaceContainerLow,
    shape: notificationControlShape(context),
    child: ListTile(
      enabled: onTap != null,
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      contentPadding: contentPadding,
      onTap: onTap,
    ),
  );
}
