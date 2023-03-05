import 'package:flutter/material.dart';

class MaterialIconButton extends StatelessWidget {
  const MaterialIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.iconSize = 24.0,
    this.tooltip,
    this.focusNode,
    this.foregroundColor,
    this.backgroundColor,
  });

  final IconData icon;
  final void Function()? onPressed;
  final double iconSize;
  final String? tooltip;
  final FocusNode? focusNode;
  final Color? foregroundColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return IconButton(
      icon: Icon(icon),
      focusNode: focusNode,
      tooltip: tooltip,
      style: IconButton.styleFrom(
        foregroundColor: foregroundColor ?? colors.onPrimary,
        backgroundColor: backgroundColor ?? colors.primary,
        disabledBackgroundColor: colors.onSurface.withOpacity(0.12),
        hoverColor: colors.onPrimary.withOpacity(0.08),
        focusColor: colors.onPrimary.withOpacity(0.12),
        highlightColor: colors.onPrimary.withOpacity(0.12),
      ),
      iconSize: iconSize,
      onPressed: onPressed,
    );
  }
}
