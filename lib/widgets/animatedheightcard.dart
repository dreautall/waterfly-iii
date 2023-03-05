import 'package:flutter/material.dart';

Widget animatedHeightCard(Widget child) {
  return AnimatedSize(
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOutCubicEmphasized,
    alignment: Alignment.topCenter,
    child: SizedBox(width: double.infinity, child: child),
  );
}
