import 'dart:ui' show lerpDouble;

import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_card_theme.dart';

class NotificationPageHeader extends StatelessWidget
    implements PreferredSizeWidget {
  const NotificationPageHeader({
    super.key,
    required this.scrollController,
    required this.title,
    this.leading,
    this.actions = const <Widget>[],
    this.fadeTitleOnScroll = true,
  });

  static const double _titleFadeDistance = 64;
  static const double _gradientFadeDistance = 32;
  static const double _gradientBottomInset = 16;
  static const double _toolbarHeight = kToolbarHeight;
  static const double _controlSize = 48;
  static const double _controlBackgroundSize = 40;
  static const double _horizontalInset = 4;
  static const double _titleHorizontalInset = 72;
  static const double expandedControlIconSize = 24;
  static const double controlIconSize = 20;
  static const double controlBackgroundOpacity = 0.72;

  static double bodyTopInset(BuildContext context) =>
      MediaQuery.paddingOf(context).top + _toolbarHeight;

  static double bodyBottomInset(BuildContext context, {double spacing = 16}) =>
      MediaQuery.paddingOf(context).bottom + spacing;

  final ScrollController scrollController;
  final Widget title;
  final Widget? leading;
  final List<Widget> actions;
  final bool fadeTitleOnScroll;

  @override
  Size get preferredSize => const Size.fromHeight(_toolbarHeight);

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: scrollController,
    builder: (BuildContext context, Widget? _) {
      final ThemeData theme = Theme.of(context);
      final bool isDark = Theme.of(context).brightness == Brightness.dark;
      final double offset = scrollController.hasClients
          ? scrollController.positions.last.pixels
          : 0;
      final double titleOpacity = fadeTitleOnScroll
          ? (1 - offset / _titleFadeDistance).clamp(0, 1)
          : 1;
      final double controlBackgroundOpacity = fadeTitleOnScroll
          ? NotificationPageHeader.controlBackgroundOpacity * (1 - titleOpacity)
          : NotificationPageHeader.controlBackgroundOpacity;
      final double controlTransition = fadeTitleOnScroll ? 1 - titleOpacity : 1;
      final double gradientOpacity = (offset / _gradientFadeDistance).clamp(
        0,
        1,
      );
      final Color gradientSurface = isDark
          ? theme.colorScheme.surfaceContainerLowest
          : theme.colorScheme.surfaceContainerHighest;
      final SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      );
      final double toolbarTop = MediaQuery.paddingOf(context).top;
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: overlayStyle,
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned.fill(
              child: IgnorePointer(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: double.infinity,
                    height: bodyTopInset(context) - _gradientBottomInset,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            gradientSurface.withValues(
                              alpha: 0.92 * gradientOpacity,
                            ),
                            gradientSurface.withValues(
                              alpha: 0.64 * gradientOpacity,
                            ),
                            gradientSurface.withValues(alpha: 0),
                          ],
                          stops: const <double>[0, 0.48, 1],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: _horizontalInset,
              top: toolbarTop + (_toolbarHeight - _controlSize) / 2,
              child: NotificationPageHeaderControl(
                backgroundOpacity: controlBackgroundOpacity,
                transition: controlTransition,
                child: leading ?? const BackButton(),
              ),
            ),
            Positioned(
              left: _titleHorizontalInset,
              right: _horizontalInset + actions.length * _controlSize,
              top: toolbarTop,
              height: _toolbarHeight,
              child: IgnorePointer(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Opacity(
                    opacity: titleOpacity,
                    child: DefaultTextStyle(
                      style:
                          theme.appBarTheme.titleTextStyle ??
                          theme.textTheme.titleLarge!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      child: title,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: _horizontalInset,
              top: toolbarTop + (_toolbarHeight - _controlSize) / 2,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  for (final Widget action in actions)
                    NotificationPageHeaderControl(
                      backgroundOpacity: controlBackgroundOpacity,
                      transition: controlTransition,
                      child: action,
                    ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

class NotificationPageHeaderControl extends StatelessWidget {
  const NotificationPageHeaderControl({
    super.key,
    required this.child,
    this.backgroundOpacity = NotificationPageHeader.controlBackgroundOpacity,
    this.transition = 1,
  });

  final Widget child;
  final double backgroundOpacity;
  final double transition;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;
    final Color background =
        theme.extension<NotificationCardTheme>()?.surfaceColor ??
        (theme.brightness == Brightness.dark
            ? colors.surfaceContainerLowest
            : colors.surfaceContainerHighest);
    return IconTheme.merge(
      data: IconThemeData(
        color: colors.onSurface,
        size: lerpDouble(
          NotificationPageHeader.expandedControlIconSize,
          NotificationPageHeader.controlIconSize,
          transition,
        ),
      ),
      child: SizedBox.square(
        dimension: NotificationPageHeader._controlSize,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Transform.scale(
              scale: lerpDouble(0.8, 1, transition),
              child: SizedBox.square(
                dimension: NotificationPageHeader._controlBackgroundSize,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: background.withValues(alpha: backgroundOpacity),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            Positioned.fill(child: child),
          ],
        ),
      ),
    );
  }
}
