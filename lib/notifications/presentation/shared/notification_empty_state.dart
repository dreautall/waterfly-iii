import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';

class NotificationEmptyState extends StatelessWidget {
  static const Key textContentKey = Key('notification-empty-state-text');
  static const double _iconExtent = 64;
  static const double _iconSpacing = 16;

  const NotificationEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.action,
    this.padding = const EdgeInsets.fromLTRB(24, 32, 24, 24),
    this.contentAlignment = Alignment.center,
  });

  final IconData icon;
  final String title;
  final String description;
  final Widget? action;
  final EdgeInsetsGeometry padding;
  final AlignmentGeometry contentAlignment;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Padding(
      padding: padding,
      child: Align(
        alignment: contentAlignment,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: _iconExtent,
              height: _iconExtent,
              decoration: BoxDecoration(
                color: colors.secondaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: colors.onSecondaryContainer, size: 30),
            ),
            const SizedBox(height: _iconSpacing),
            Column(
              key: textContentKey,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: context.notificationSectionDescription,
                ),
              ],
            ),
            if (action != null) ...<Widget>[
              const SizedBox(height: 20),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

class NotificationEmptyStateViewport extends StatelessWidget {
  const NotificationEmptyStateViewport({
    super.key,
    required this.header,
    required this.emptyState,
  });

  final Widget header;
  final Widget emptyState;

  @override
  Widget build(BuildContext context) => Stack(
    fit: StackFit.expand,
    children: <Widget>[
      Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: header,
        ),
      ),
      Center(
        child: Transform.translate(
          offset: const Offset(
            0,
            -(NotificationEmptyState._iconExtent +
                    NotificationEmptyState._iconSpacing) /
                2,
          ),
          child: emptyState,
        ),
      ),
    ],
  );
}

class NotificationInlineEmptyState extends StatelessWidget {
  const NotificationInlineEmptyState({
    super.key,
    required this.message,
    this.status = NotificationInlineEmptyStateStatus.neutral,
  });

  final String message;
  final NotificationInlineEmptyStateStatus status;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextStyle emptyTextStyle =
        context.notificationEmptyText ?? DefaultTextStyle.of(context).style;
    return Text(
      message,
      style: switch (status) {
        NotificationInlineEmptyStateStatus.neutral => emptyTextStyle,
        NotificationInlineEmptyStateStatus.warning => emptyTextStyle.copyWith(
          color: colors.tertiary,
        ),
        NotificationInlineEmptyStateStatus.error => emptyTextStyle.copyWith(
          color: colors.error,
        ),
      },
    );
  }
}

enum NotificationInlineEmptyStateStatus { neutral, warning, error }
