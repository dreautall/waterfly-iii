import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/notifications/presentation/shared/definition_detail_card.dart';

class DefinitionExpandableDetailCard extends StatelessWidget {
  const DefinitionExpandableDetailCard({
    super.key,
    required this.expanded,
    required this.onTap,
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.belly,
    this.headerBorderRadius = const BorderRadius.all(Radius.circular(8)),
    this.expandedHeaderBorderRadius = const BorderRadius.only(
      topLeft: Radius.circular(8),
      topRight: Radius.circular(8),
    ),
    this.bellyColor,
    this.bellyBorder,
    this.bellyBorderRadius = const BorderRadius.only(
      bottomLeft: Radius.circular(8),
      bottomRight: Radius.circular(8),
    ),
    this.headerKey,
    this.bellyPadding = EdgeInsets.zero,
    this.bellyKey,
    this.headerOpacity = 1,
  });

  final bool expanded;
  final VoidCallback onTap;
  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final Widget trailing;
  final Widget belly;
  final BorderRadius headerBorderRadius;
  final BorderRadius expandedHeaderBorderRadius;
  final Color? bellyColor;
  final Border? bellyBorder;
  final BorderRadius bellyBorderRadius;
  final Key? headerKey;
  final EdgeInsetsGeometry bellyPadding;
  final Key? bellyKey;
  final double headerOpacity;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Border effectiveBellyBorder = isDark
        ? bellyBorder ?? Border.all(color: colors.outlineVariant)
        : Border(top: BorderSide(color: colors.outlineVariant));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TweenAnimationBuilder<BorderRadius?>(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeInOut,
          tween: BorderRadiusTween(
            end: expanded ? expandedHeaderBorderRadius : headerBorderRadius,
          ),
          builder: (BuildContext context, BorderRadius? radius, Widget? _) =>
              AnimatedOpacity(
                duration: const Duration(milliseconds: 180),
                opacity: headerOpacity,
                child: DefinitionDetailCard(
                  key: headerKey,
                  leading: leading,
                  title: title,
                  subtitle: subtitle,
                  trailing: trailing,
                  onTap: onTap,
                  borderRadius: radius ?? headerBorderRadius,
                ),
              ),
        ),
        ClipRect(
          clipBehavior: expanded ? Clip.none : Clip.hardEdge,
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            heightFactor: expanded ? 1 : 0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 140),
              curve: Curves.easeIn,
              opacity: expanded ? 1 : 0,
              child: Card(
                margin: EdgeInsets.zero,
                color: bellyColor,
                surfaceTintColor: Colors.transparent,
                elevation: isDark ? 0 : 1,
                shape: RoundedRectangleBorder(borderRadius: bellyBorderRadius),
                child: DecoratedBox(
                  key: bellyKey,
                  decoration: BoxDecoration(
                    color: bellyColor,
                    border: effectiveBellyBorder,
                    borderRadius: bellyBorderRadius,
                  ),
                  child: Padding(padding: bellyPadding, child: belly),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
