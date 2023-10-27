import 'package:flutter/material.dart';

// on screen
const Duration animDurationEmphasized = Duration(milliseconds: 500);
const Curve animCurveEmphasized = Curves.easeInOutCubicEmphasized;
const Duration animDurationStandard = Duration(milliseconds: 300);
const Curve animCurveStandard = Cubic(0.2, 0.0, 0, 1.0);

// enter screen
const Duration animDurationEmphasizedDecelerate = Duration(milliseconds: 400);
const Curve animCurveEmphasizedDecelerate = Cubic(0.05, 0.7, 0.1, 1.0);
const Duration animDurationStandardDecelerate = Duration(milliseconds: 250);
const Curve animCurveStandardDecelerate = Cubic(0, 0, 0, 1);

// exit screen
const Duration animDurationEmphasizedAccelerate = Duration(milliseconds: 200);
const Curve animCurveEmphasizedAccelerate = Cubic(0.3, 0.0, 0.8, 0.15);
const Duration animDurationStandardAccelerate = Duration(milliseconds: 200);
const Curve animCurveStandardAccelerate = Cubic(0.3, 0, 1, 1);

class AnimatedHeight extends StatelessWidget {
  const AnimatedHeight({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: animDurationEmphasized,
      curve: animCurveEmphasized,
      alignment: Alignment.topCenter,
      child: SizedBox(width: double.infinity, child: child),
    );
  }
}
