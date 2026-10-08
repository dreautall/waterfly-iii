import 'package:material_ui/material_ui.dart';

Future<T?> showNotificationDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
}) {
  final NavigatorState navigator = Navigator.of(
    context,
    rootNavigator: useRootNavigator,
  );
  final CapturedThemes themes = InheritedTheme.capture(
    from: context,
    to: navigator.context,
  );
  final MediaQueryData mediaQuery = MediaQuery.of(context);
  final bool disableAnimations =
      mediaQuery.disableAnimations || mediaQuery.accessibleNavigation;
  final Duration transitionDuration = disableAnimations
      ? Duration.zero
      : const Duration(milliseconds: 200);
  final Duration reverseTransitionDuration = disableAnimations
      ? Duration.zero
      : const Duration(milliseconds: 150);

  return navigator.push<T>(
    PageRouteBuilder<T>(
      settings: routeSettings,
      opaque: false,
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.black54,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: transitionDuration,
      reverseTransitionDuration: reverseTransitionDuration,
      pageBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) => themes.wrap(SafeArea(child: Builder(builder: builder))),
      transitionsBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            if (disableAnimations) return child;
            final Animation<double> curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
              reverseCurve: Curves.easeInCubic,
            );
            return FadeTransition(
              opacity: curvedAnimation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.02),
                  end: Offset.zero,
                ).animate(curvedAnimation),
                child: ScaleTransition(
                  scale: Tween<double>(
                    begin: 0.96,
                    end: 1,
                  ).animate(curvedAnimation),
                  child: child,
                ),
              ),
            );
          },
    ),
  );
}
