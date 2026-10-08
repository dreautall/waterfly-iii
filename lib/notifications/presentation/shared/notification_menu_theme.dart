import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_card_theme.dart';

class NotificationMenuDivider extends PopupMenuDivider {
  const NotificationMenuDivider({super.key}) : super(indent: 16, endIndent: 16);
}

class NotificationMenuTheme extends StatelessWidget {
  const NotificationMenuTheme({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color? surfaceColor = theme
        .extension<NotificationCardTheme>()
        ?.surfaceColor;
    final Widget menuTheme = PopupMenuTheme(
      data: const PopupMenuThemeData(
        elevation: 3,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        menuPadding: EdgeInsets.symmetric(vertical: 8),
      ),
      child: child,
    );
    if (surfaceColor == null) {
      return menuTheme;
    }

    final ButtonStyle elevatedButtonStyle =
        (theme.elevatedButtonTheme.style ?? const ButtonStyle()).copyWith(
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) => states.contains(WidgetState.disabled)
                ? surfaceColor.withValues(alpha: 0.38)
                : surfaceColor,
          ),
        );
    return Theme(
      data: theme.copyWith(
        cardTheme: theme.cardTheme.copyWith(color: surfaceColor),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: elevatedButtonStyle,
        ),
      ),
      child: menuTheme,
    );
  }
}
