import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/notifications/presentation/shared/message_status_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/reveal_expanded_content.dart';

class RecentNotificationOutcome extends StatefulWidget {
  const RecentNotificationOutcome({
    super.key,
    required this.status,
    required this.icon,
    required this.title,
    required this.message,
    this.titleStyle,
    this.messageStyle,
    this.trailing,
  });

  final MessageStatus status;
  final IconData icon;
  final String title;
  final String message;
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;
  final Widget? trailing;

  @override
  State<RecentNotificationOutcome> createState() =>
      _RecentNotificationOutcomeState();
}

class _RecentNotificationOutcomeState extends State<RecentNotificationOutcome> {
  bool _expanded = false;

  void _toggleExpanded() {
    final bool expanded = !_expanded;
    setState(() => _expanded = expanded);
    if (expanded) unawaited(revealExpandedContent(context));
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final (Color background, Color accent) = switch (widget.status) {
      MessageStatus.success => (
        colors.primaryContainer.withValues(alpha: 0.35),
        colors.primary,
      ),
      MessageStatus.informational => (
        colors.secondaryContainer.withValues(alpha: 0.35),
        colors.secondary,
      ),
      MessageStatus.warning || MessageStatus.review => (
        colors.tertiaryContainer.withValues(alpha: 0.35),
        colors.tertiary,
      ),
      MessageStatus.error => (
        colors.errorContainer.withValues(alpha: 0.35),
        colors.error,
      ),
    };
    final Widget header = Row(
      key: const Key('notification-outcome-header'),
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(color: background, shape: BoxShape.circle),
          child: Icon(widget.icon, color: accent),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.title,
                style:
                    widget.titleStyle ?? Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 4),
              Text(
                widget.message,
                style:
                    widget.messageStyle ??
                    Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: colors.outline),
              ),
            ],
          ),
        ),
        if (widget.trailing != null) ...<Widget>[
          const SizedBox(width: 8),
          AnimatedRotation(
            turns: _expanded ? 0.5 : 0,
            duration: notificationExpansionDuration,
            curve: Curves.easeInOut,
            child: const Icon(Icons.expand_more),
          ),
        ],
      ],
    );
    if (widget.trailing == null) return header;
    return Card(
      key: const Key('notification-outcome-card'),
      margin: EdgeInsets.zero,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: _toggleExpanded,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              header,
              ClipRect(
                child: AnimatedAlign(
                  duration: notificationExpansionDuration,
                  curve: Curves.easeInOut,
                  alignment: Alignment.topCenter,
                  heightFactor: _expanded ? 1 : 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 140),
                    curve: Curves.easeIn,
                    opacity: _expanded ? 1 : 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: widget.trailing,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
