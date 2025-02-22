import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:version/version.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';

final Logger log = Logger("Pages.Home.Main.Dashboard");

class DashboardDialog extends StatefulWidget {
  const DashboardDialog({super.key});

  @override
  State<DashboardDialog> createState() => _DashboardDialogState();
}

class _DashboardDialogState extends State<DashboardDialog> {
  late List<String> cards;

  @override
  void initState() {
    super.initState();

    cards = <String>[
      "dailyavg",
      "categories",
      "accounts",
      "netearnings",
      "budgets",
    ];

    if (context.read<FireflyService>().apiVersion! >= Version(2, 0, 12)) {
      cards.add("bills");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Logger log = Logger("Pages.Home.Main.Dashboard.Dialog");

    final List<Widget> cardWidgets = <Widget>[
      for (int i = 0; i < cards.length; i += 1)
        DashboardCard(key: Key('$i'), chartKey: cards[i], index: i),
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
        height: cardWidgets.length * 100, // :TODO: proper height
        child: ReorderableListView(
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final String item = cards.removeAt(oldIndex);
              cards.insert(newIndex, item);
            });
          },
          padding: const EdgeInsets.all(8),
          proxyDecorator: proxyDecorator,
          children: cardWidgets,
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  const DashboardCard({super.key, required this.chartKey, required this.index});

  final String chartKey;
  final int index;

  @override
  Widget build(BuildContext context) {
    late String chartTitle;
    switch (chartKey) {
      case "dailyavg":
        chartTitle = S.of(context).homeMainChartDailyAvg;
        break;
      case "categories":
        chartTitle = S.of(context).homeMainChartCategoriesTitle;
        break;
      case "accounts":
        chartTitle = S.of(context).homeMainChartAccountsTitle;
        break;
      case "netearnings":
        chartTitle = S.of(context).homeMainChartNetEarningsTitle;
        break;
      case "budgets":
        chartTitle = S.of(context).homeMainBudgetTitle;
        break;
      case "bills":
        chartTitle = S.of(context).homeMainBillsTitle;
        break;
    }

    return Card(
      child: SizedBox(
        child: ListTile(
          leading: IconButton(
            icon: const Icon(Icons.visibility),
            selectedIcon: Icon(Icons.visibility_off),
            onPressed: () => debugPrint("hi"),
          ),
          trailing: ReorderableDragStartListener(
            index: index,
            child: const Icon(Icons.drag_indicator_outlined),
          ),
          title: Text(chartTitle),
        ),
      ),
    );
  }
}
