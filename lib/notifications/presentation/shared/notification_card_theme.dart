import 'package:material_ui/material_ui.dart';

@immutable
class NotificationCardTheme extends ThemeExtension<NotificationCardTheme> {
  const NotificationCardTheme({
    required this.surfaceColor,
    required this.nestedSurfaceColor,
    required this.deepNestedSurfaceColor,
  });

  final Color surfaceColor;
  final Color nestedSurfaceColor;
  final Color deepNestedSurfaceColor;

  @override
  NotificationCardTheme copyWith({
    Color? surfaceColor,
    Color? nestedSurfaceColor,
    Color? deepNestedSurfaceColor,
  }) => NotificationCardTheme(
    surfaceColor: surfaceColor ?? this.surfaceColor,
    nestedSurfaceColor: nestedSurfaceColor ?? this.nestedSurfaceColor,
    deepNestedSurfaceColor:
        deepNestedSurfaceColor ?? this.deepNestedSurfaceColor,
  );

  @override
  NotificationCardTheme lerp(
    covariant ThemeExtension<NotificationCardTheme>? other,
    double t,
  ) {
    if (other is! NotificationCardTheme) return this;
    return NotificationCardTheme(
      surfaceColor: Color.lerp(surfaceColor, other.surfaceColor, t)!,
      nestedSurfaceColor: Color.lerp(
        nestedSurfaceColor,
        other.nestedSurfaceColor,
        t,
      )!,
      deepNestedSurfaceColor: Color.lerp(
        deepNestedSurfaceColor,
        other.deepNestedSurfaceColor,
        t,
      )!,
    );
  }
}

class NotificationDialogSurfaceScope extends InheritedWidget {
  const NotificationDialogSurfaceScope.deep({required super.child, super.key});

  static bool isDeep(BuildContext context) =>
      context
          .dependOnInheritedWidgetOfExactType<
            NotificationDialogSurfaceScope
          >() !=
      null;

  @override
  bool updateShouldNotify(NotificationDialogSurfaceScope oldWidget) => false;
}

Color? notificationDialogSurfaceColor(BuildContext context) {
  final NotificationCardTheme? theme = Theme.of(
    context,
  ).extension<NotificationCardTheme>();
  if (theme == null) return null;
  return NotificationDialogSurfaceScope.isDeep(context)
      ? theme.deepNestedSurfaceColor
      : theme.nestedSurfaceColor;
}
