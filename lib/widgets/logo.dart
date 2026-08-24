import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_ui/material_ui.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 100});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/logo.svg',
      semanticsLabel: 'App Logo',
      width: size,
      height: size,
    );
  }
}
