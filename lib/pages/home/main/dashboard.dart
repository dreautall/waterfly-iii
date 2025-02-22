import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

final Logger log = Logger("Pages.Home.Main.Dashboard");

class DashboardDialog extends StatelessWidget {
  const DashboardDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final Logger log = Logger("Pages.Home.Main.Dashboard.Dialog");

    final List<String> cards = <String>[
      "dailysummary",
      "categorysummary",
      "accountsummary",
      "netearnings",
      "budgets",
      "bills"
    ];

    final List<Widget> cardWidgets = <Widget>[
      for (String s in cards)
        DashboardCard(key: ValueKey<String>(s), chartKey: s),
    ];

    Widget proxyDecorator(
        Widget child, int index, Animation<double> animation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          final double animValue = Curves.easeInOut.transform(animation.value);
          final double elevation = lerpDouble(1, 6, animValue)!;
          final double scale = lerpDouble(1, 1.02, animValue)!;
          return Transform.scale(
            scale: scale,
            // Create a Card based on the color and the content of the dragged one
            // and set its elevation to the animated value.
            child: Card(
              elevation: elevation,
              child: cardWidgets[index],
            ),
          );
        },
        child: child,
      );
    }

    return AlertDialog(
      title: Text("Dashboard Settings"),
      content: SizedBox(
        width: double.maxFinite,
        height: cardWidgets.length * 100,
        child: ReorderableListView(
          onReorder: (int oldIndex, int newIndex) {
            debugPrint("oldIndex: $oldIndex, newIndex: $newIndex");
          },
          proxyDecorator: proxyDecorator,
          children: cardWidgets,
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  const DashboardCard({super.key, required this.chartKey});

  final String chartKey;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 80,
        child: Center(
          child: Text(chartKey),
        ),
      ),
    );
  }
}
