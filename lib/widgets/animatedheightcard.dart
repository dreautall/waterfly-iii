import 'package:flutter/material.dart';

class AnimatedHeightCard extends StatelessWidget {
  const AnimatedHeightCard({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubicEmphasized,
      alignment: Alignment.topCenter,
      child: SizedBox(width: double.infinity, child: child),
    );
  }
}
