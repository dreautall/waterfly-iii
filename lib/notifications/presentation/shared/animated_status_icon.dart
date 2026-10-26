import 'package:material_ui/material_ui.dart';

class AnimatedStatusIcon extends StatefulWidget {
  const AnimatedStatusIcon({
    super.key,
    required this.icon,
    required this.color,
  });

  final IconData? icon;
  final Color color;

  @override
  State<AnimatedStatusIcon> createState() => _AnimatedStatusIconState();
}

class _AnimatedStatusIconState extends State<AnimatedStatusIcon>
    with SingleTickerProviderStateMixin {
  static const Duration _duration = Duration(milliseconds: 180);

  late final AnimationController _controller;
  late final Animation<double> _animation;
  IconData? _displayedIcon;

  @override
  void initState() {
    super.initState();
    _displayedIcon = widget.icon;
    _controller = AnimationController(
      vsync: this,
      duration: _duration,
      value: widget.icon == null ? 0 : 1,
    )..addStatusListener(_handleAnimationStatus);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
  }

  @override
  void didUpdateWidget(AnimatedStatusIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.icon == oldWidget.icon) return;
    if (widget.icon case final IconData icon) {
      _displayedIcon = icon;
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void _handleAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.dismissed &&
        widget.icon == null &&
        _displayedIcon != null) {
      setState(() => _displayedIcon = null);
    }
  }

  @override
  void dispose() {
    _controller
      ..removeStatusListener(_handleAnimationStatus)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final IconData? icon = _displayedIcon;
    if (icon == null) return const SizedBox.shrink();
    return AnimatedBuilder(
      animation: _animation,
      child: Padding(
        padding: const EdgeInsets.only(right: 6),
        child: Icon(icon, size: 18, color: widget.color),
      ),
      builder: (BuildContext context, Widget? child) {
        final double progress = _animation.value;
        return ClipRect(
          child: Align(
            alignment: Alignment.centerLeft,
            widthFactor: progress,
            child: Opacity(
              opacity: progress,
              child: Transform.scale(
                scale: 0.8 + 0.2 * progress,
                alignment: Alignment.centerLeft,
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}
