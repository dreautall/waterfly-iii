import 'package:material_ui/material_ui.dart';

enum MessageStatus { success, informational, warning, review, error }

enum MessageStatusCardVariant { regular, embedded }

class MessageStatusCard extends StatelessWidget {
  const MessageStatusCard({
    super.key,
    required this.status,
    required this.message,
    this.title,
    this.actionLabel,
    this.onAction,
    this.icon,
    this.actionsBuilder,
    this.variant = MessageStatusCardVariant.regular,
  }) : assert(
         (actionLabel == null) == (onAction == null),
         'actionLabel and onAction must be provided together.',
       ),
       assert(
         actionLabel == null || actionsBuilder == null,
         'Use either a single action or an actions builder.',
       );

  final MessageStatus status;
  final String? title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final IconData? icon;
  final Widget Function(BuildContext context, Color foreground)? actionsBuilder;
  final MessageStatusCardVariant variant;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final (
      Color background,
      Color foreground,
      Color accent,
      IconData statusIcon,
    ) = switch (status) {
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
    final Border cardBorder = switch (variant) {
      MessageStatusCardVariant.regular => Border.all(color: accent),
      MessageStatusCardVariant.embedded => Border(
        left: BorderSide(color: accent, width: 3),
      ),
    };
    final String? title = this.title;
    final String? actionLabel = this.actionLabel;
    final Widget? actions = actionsBuilder?.call(context, foreground);
    return Semantics(
      container: true,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: background,
          border: cardBorder,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: actions == null
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: <Widget>[
            Icon(icon ?? statusIcon, color: foreground),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (title != null) ...<Widget>[
                    Text(
                      title,
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall?.copyWith(color: foreground),
                    ),
                    const SizedBox(height: 2),
                  ],
                  Text(message, style: TextStyle(color: foreground)),
                  if (actions != null) ...<Widget>[
                    const SizedBox(height: 8),
                    actions,
                  ],
                ],
              ),
            ),
            if (actionLabel != null) ...<Widget>[
              const SizedBox(width: 12),
              TextButton(
                onPressed: onAction,
                style: TextButton.styleFrom(
                  foregroundColor: foreground,
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(actionLabel),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
