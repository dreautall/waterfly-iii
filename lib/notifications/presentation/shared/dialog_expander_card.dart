import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_card_theme.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_input_decoration.dart';

class DialogExpanderCard extends StatefulWidget {
  const DialogExpanderCard({
    super.key,
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.expanded,
    required this.onTap,
    required this.belly,
    this.trailing,
    this.margin = const EdgeInsets.only(bottom: 8),
    this.bellyPadding = const EdgeInsets.fromLTRB(16, 8, 16, 16),
    this.onExpanded,
  });

  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final bool expanded;
  final VoidCallback onTap;
  final Widget belly;
  final Widget? trailing;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry bellyPadding;
  final VoidCallback? onExpanded;

  @override
  State<DialogExpanderCard> createState() => _DialogExpanderCardState();
}

class _DialogExpanderCardState extends State<DialogExpanderCard> {
  static const Duration _expansionDuration = Duration(milliseconds: 180);
  static const Duration _fadeDuration = Duration(milliseconds: 140);

  late bool _showBelly = widget.expanded;
  late bool _revealBelly = widget.expanded;

  @override
  void didUpdateWidget(covariant DialogExpanderCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.expanded && !oldWidget.expanded) {
      _showBelly = true;
      _revealBelly = false;
      WidgetsBinding.instance.addPostFrameCallback((Duration _) {
        if (mounted && widget.expanded) {
          setState(() => _revealBelly = true);
        }
      });
    } else if (!widget.expanded && oldWidget.expanded) {
      _revealBelly = false;
    }
  }

  void _handleExpansionEnd() {
    if (_revealBelly && widget.expanded) {
      widget.onExpanded?.call();
    } else if (!widget.expanded && _showBelly) {
      setState(() => _showBelly = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color? dynamicSurface = notificationDialogSurfaceColor(context);
    return Card(
      margin: widget.margin,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      color:
          dynamicSurface ??
          (widget.expanded
              ? Theme.of(context).colorScheme.surfaceContainerHigh
              : Theme.of(context).colorScheme.surfaceContainerLow),
      shape: notificationControlShape(context),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: widget.leading,
            title: widget.title,
            subtitle: widget.subtitle,
            trailing:
                widget.trailing ??
                AnimatedRotation(
                  turns: widget.expanded ? 0.5 : 0,
                  duration: _expansionDuration,
                  child: const Icon(Icons.expand_more),
                ),
            onTap: widget.onTap,
          ),
          if (_showBelly)
            ClipRect(
              child: AnimatedAlign(
                duration: _expansionDuration,
                curve: Curves.easeInOut,
                alignment: Alignment.topCenter,
                heightFactor: _revealBelly ? 1 : 0,
                onEnd: _handleExpansionEnd,
                child: AnimatedOpacity(
                  duration: _fadeDuration,
                  curve: Curves.easeIn,
                  opacity: _revealBelly ? 1 : 0,
                  child: NotificationDialogSurfaceScope.deep(
                    child: Padding(
                      padding: widget.bellyPadding,
                      child: widget.belly,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
