import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_card_theme.dart';

class DefinitionDetailCard extends StatelessWidget {
  const DefinitionDetailCard({
    super.key,
    required this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.compact = false,
    this.isThreeLine = false,
    this.centerAffordances = false,
    this.backgroundColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  });

  final Widget leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool compact;
  final bool isThreeLine;
  final bool centerAffordances;
  final Color? backgroundColor;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color cardColor =
        backgroundColor ??
        theme.extension<NotificationCardTheme>()?.surfaceColor ??
        theme.colorScheme.surfaceContainerLow;
    // Match the space for two text lines without moving a single title above
    // the center of its icon and trailing affordance.
    final RoundedRectangleBorder shape = RoundedRectangleBorder(
      borderRadius: borderRadius,
    );
    final double verticalPadding = theme.listTileTheme.minVerticalPadding ?? 8;
    final double minHeight = subtitle == null && !compact
        ? 2 * verticalPadding +
              _lineHeight(
                context,
                theme.listTileTheme.titleTextStyle ??
                    theme.textTheme.bodyLarge!,
              ) +
              _lineHeight(
                context,
                theme.listTileTheme.subtitleTextStyle ??
                    theme.textTheme.bodyMedium!,
              )
        : 60;
    final ListTile tile = ListTile(
      minTileHeight: minHeight,
      minVerticalPadding: verticalPadding,
      isThreeLine: isThreeLine,
      titleAlignment: centerAffordances
          ? ListTileTitleAlignment.center
          : ListTileTitleAlignment.threeLine,
      contentPadding: const EdgeInsets.only(left: 16),
      leading: IconTheme.merge(
        data: const IconThemeData(size: 20),
        child: leading,
      ),
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      onTap: compact ? onTap : null,
    );
    if (!compact && onTap != null) {
      return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: cardColor,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          shape: shape,
        ),
        child: tile,
      );
    }
    return Card(
      margin: EdgeInsets.zero,
      color: cardColor,
      shape: shape,
      child: compact
          ? InkWell(
              borderRadius: borderRadius,
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: <Widget>[
                    leading,
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[title, ?subtitle],
                      ),
                    ),
                    if (trailing != null) ...<Widget>[
                      const SizedBox(width: 16),
                      trailing!,
                    ],
                  ],
                ),
              ),
            )
          : tile,
    );
  }

  double _lineHeight(BuildContext context, TextStyle style) {
    final TextPainter painter = TextPainter(
      text: TextSpan(text: ' ', style: style),
      textDirection: Directionality.of(context),
      textScaler: MediaQuery.textScalerOf(context),
    )..layout();
    return painter.height;
  }
}
