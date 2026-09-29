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
  });

  static const double _titleFadeDistance = 64;
  static const double _gradientFadeDistance = 32;
  static const double _gradientBottomInset = 16;
  static const double _toolbarHeight = 72;
  static const double _controlSize = 40;
  static const double _horizontalInset = 12;
  static const double _controlSpacing = 12;
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
      final double titleOpacity = (1 - offset / _titleFadeDistance).clamp(0, 1);
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
                child:
                    leading ??
                    BackButton(
                      style: IconButton.styleFrom(iconSize: controlIconSize),
                    ),
              ),
            ),
            Positioned(
              left: _controlSize + _horizontalInset * 2,
              right:
                  _horizontalInset +
                  actions.length * _controlSize +
                  (actions.isEmpty
                      ? 0
                      : (actions.length - 1) * _controlSpacing),
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
                spacing: _controlSpacing,
                children: <Widget>[
                  for (final Widget action in actions)
                    NotificationPageHeaderControl(child: action),
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
  const NotificationPageHeaderControl({super.key, required this.child});

  final Widget child;

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
        size: NotificationPageHeader.controlIconSize,
      ),
      child: SizedBox.square(
        dimension: NotificationPageHeader._controlSize,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: background.withValues(
              alpha: NotificationPageHeader.controlBackgroundOpacity,
            ),
            shape: BoxShape.circle,
          ),
          child: child,
        ),
      ),
    );
  }
}
