import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:version/version.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/settings.dart';

final Logger log = Logger("Pages.Home.Main.Dashboard");

class DashboardDialog extends StatefulWidget {
  const DashboardDialog({super.key});

  @override
  State<DashboardDialog> createState() => _DashboardDialogState();
}

class _DashboardDialogState extends State<DashboardDialog> {
  late List<DashboardCards> cards;

  final Logger log = Logger("Pages.Home.Main.Dashboard.Dialog");

  @override
  void initState() {
    super.initState();

    cards = List<DashboardCards>.from(
        context.read<SettingsProvider>().dashboardOrder);

    // Remove dupes, that would throw errors later!
    cards = cards.toSet().toList();

    // Remove bills if the server is too old
    if (context.read<FireflyService>().apiVersion! < Version(2, 0, 12)) {
      cards.remove(DashboardCards.bills);
    }

    // :TODO: currently there is a bug in the APIv2 call, disabled this for now..
    if (context.read<FireflyService>().apiVersion! < Version(99, 0, 7)) {
      cards.remove(DashboardCards.networth);
    }
  }

  @override
  Widget build(BuildContext context) {
    log.finest("build()");

    final List<Widget> cardWidgets = <Widget>[
      for (int i = 0; i < cards.length; i += 1)
        DashboardCard(
          key: ValueKey<DashboardCards>(cards[i]),
          card: cards[i],
          index: i,
        ),
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
      title: Text(S.of(context).homeMainDialogSettingsTitle),
      clipBehavior: Clip.hardEdge,
      actions: <Widget>[
        OutlinedButton(
          child: Text(S.of(context).generalReset),
          onPressed: () {
            context
                .read<SettingsProvider>()
                .setDashboardOrder(DashboardCards.values);
            final List<DashboardCards> hidden = List<DashboardCards>.from(
                context.read<SettingsProvider>().dashboardHidden);
            for (DashboardCards e in hidden) {
              context.read<SettingsProvider>().dashboardShowCard(e);
            }
            Navigator.of(context).pop(true);
          },
        ),
        FilledButton(
          child: Text(MaterialLocalizations.of(context).saveButtonLabel),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
      content: SizedBox(
        width: double.maxFinite,
        height: cardWidgets.length * 96,
        child: ReorderableListView(
          onReorder: (int oldIndex, int newIndex) async {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final DashboardCards item = cards.removeAt(oldIndex);
              cards.insert(newIndex, item);
            });
            await context.read<SettingsProvider>().setDashboardOrder(cards);
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
  const DashboardCard({super.key, required this.card, required this.index});

  final DashboardCards card;
  final int index;

  @override
  Widget build(BuildContext context) {
    log.finest("build()");

    late String chartTitle;
    chartTitle = switch (card) {
      DashboardCards.dailyavg => S.of(context).homeMainChartDailyAvg,
      DashboardCards.categories => S.of(context).homeMainChartCategoriesTitle,
      DashboardCards.accounts => S.of(context).homeMainChartAccountsTitle,
      DashboardCards.netearnings => S.of(context).homeMainChartNetEarningsTitle,
      DashboardCards.networth => S.of(context).homeMainChartNetWorthTitle,
      DashboardCards.budgets => S.of(context).homeMainBudgetTitle,
      DashboardCards.bills => S.of(context).homeMainBillsTitle,
    };

    final bool hidden =
        context.watch<SettingsProvider>().dashboardHidden.contains(card);

    return Card(
      child: SizedBox(
        child: ListTile(
          minTileHeight: 88,
          leading: IconButton(
            icon: const Icon(Icons.visibility),
            selectedIcon: Icon(Icons.visibility_off_outlined),
            isSelected: hidden,
            onPressed: () async => hidden
                ? context.read<SettingsProvider>().dashboardShowCard(card)
                : context.read<SettingsProvider>().dashboardHideCard(card),
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
