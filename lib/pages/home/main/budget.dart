import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/timezonehandler.dart';

class BudgetList extends StatelessWidget {
  const BudgetList({
    super.key,
    required this.budgetInfos,
    required this.snapshot,
  });

  final Map<String, BudgetProperties> budgetInfos;
  final AsyncSnapshot<List<BudgetLimitRead>> snapshot;

  @override
  Widget build(BuildContext context) {
    final TimeZoneHandler tzHandler = context.read<FireflyService>().tzHandler;

    return SizedBox(
      child: Padding(
        padding: const .fromLTRB(12, 0, 12, 12),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final List<Widget> widgets = <Widget>[];
            final int tsNow = tzHandler.sNow().millisecondsSinceEpoch;

            double totalBudgeted = 0;
            double totalSpent = 0;

            for (BudgetLimitRead budget in snapshot.data!) {
              final List<Widget> stackWidgets = <Widget>[];
              late double spent;
              if (budget.attributes.spent?.isNotEmpty ?? false) {
                spent =
                    (double.tryParse(
                              budget.attributes.spent!.first.sum ?? "",
                            ) ??
                            0)
                        .abs();
              } else {
                spent = 0;
              }
              final double available =
                  double.tryParse(budget.attributes.amount ?? "") ?? 0;

              final int tsStart = tzHandler
                  .sTime(budget.attributes.start!)
                  .millisecondsSinceEpoch;
              final int tsEnd = tzHandler
                  .sTime(budget.attributes.end!)
                  .millisecondsSinceEpoch;
              late double passedDays;
              if (tsEnd == tsStart) {
                passedDays = 2; // Hides the bar
              } else {
                passedDays = (tsNow - tsStart) / (tsEnd - tsStart);
                if (passedDays > 1) {
                  passedDays = 2; // Hides the bar
                }
              }

              final BudgetProperties? budgetInfo =
                  budgetInfos[budget.attributes.budgetId];
              if (budgetInfo == null || available == 0) {
                continue;
              }

              totalBudgeted += available;
              totalSpent += spent;

              final CurrencyRead currency = CurrencyRead(
                id: budget.attributes.currencyId ?? "0",
                type: "currencies",
                attributes: CurrencyProperties(
                  code: budget.attributes.currencyCode ?? "",
                  name: budget.attributes.currencyName ?? "",
                  symbol: budget.attributes.currencySymbol ?? "",
                  decimalPlaces: budget.attributes.currencyDecimalPlaces,
                ),
              );
              Color lineColor = Colors.green;
              Color? bgColor;
              double value = spent / available;
              if (spent > available) {
                lineColor = const Color(0xFFFF4F4B);
                bgColor = Colors.green;
                value = value % 1;
              }

              if (widgets.isNotEmpty) {
                widgets.add(const SizedBox(height: 8));
              }
              widgets.add(
                RichText(
                  text: TextSpan(
                    children: <InlineSpan>[
                      TextSpan(
                        text: budgetInfo.name,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      TextSpan(
                        text: budget.attributes.period?.isNotEmpty ?? false
                            ? S
                                  .of(context)
                                  .homeMainBudgetInterval(
                                    tzHandler
                                        .sTime(budget.attributes.start!)
                                        .toLocal(),
                                    tzHandler
                                        .sTime(budget.attributes.end!)
                                        .toLocal(),
                                    budget.attributes.period!,
                                  )
                            : S
                                  .of(context)
                                  .homeMainBudgetIntervalSingle(
                                    tzHandler
                                        .sTime(budget.attributes.start!)
                                        .toLocal(),
                                    tzHandler
                                        .sTime(budget.attributes.end!)
                                        .toLocal(),
                                  ),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              );
              stackWidgets.add(
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: <Widget>[
                    Text(
                      S.of(context).numPercent(spent / available),
                      style: Theme.of(
                        context,
                      ).textTheme.labelLarge!.copyWith(color: lineColor),
                    ),
                    Text(
                      S
                          .of(context)
                          .homeMainBudgetSum(
                            currency.fmt(
                              (available - spent).abs(),
                              decimalDigits: 0,
                            ),
                            (spent > available) ? "over" : "leftfrom",
                            currency.fmt(available, decimalDigits: 0),
                          ),
                      style: Theme.of(
                        context,
                      ).textTheme.labelLarge!.copyWith(color: lineColor),
                    ),
                  ],
                ),
              );
              stackWidgets.add(
                Positioned.fill(
                  top: 20, // Height of Row() with text
                  bottom: 4,
                  child: LinearProgressIndicator(
                    color: lineColor,
                    backgroundColor: bgColor,
                    value: value,
                  ),
                ),
              );
              widgets.add(
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) =>
                      Stack(
                        children: <Widget>[
                          // Row + ProgressIndicator + Bottom Padding
                          const SizedBox(height: 20 + 4 + 4),
                          ...stackWidgets,
                          Positioned(
                            left: constraints.biggest.width * passedDays,
                            top: 16,
                            bottom: 0,
                            width: 3,
                            child: Container(
                              color: (spent / available > passedDays)
                                  ? const Color(0xFFFF4F4B)
                                  : Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                ),
              );
            }

            // Summary line above the budgets with the total budgeted, spent
            // and left amounts (summed in the default currency, like the
            // categories overview).
            if (totalBudgeted > 0) {
              final CurrencyRead defaultCurrency = context
                  .read<FireflyService>()
                  .defaultCurrency;
              final double totalLeft = totalBudgeted - totalSpent;
              widgets.insert(0, const Divider());
              widgets.insert(
                0,
                Table(
                  //border: TableBorder.all(), // :DEBUG:
                  columnWidths: const <int, TableColumnWidth>{
                    0: FlexColumnWidth(),
                    1: FlexColumnWidth(),
                    2: FlexColumnWidth(),
                  },
                  children: <TableRow>[
                    TableRow(
                      children: <Widget>[
                        Text(
                          S.of(context).generalBudget,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        Text(
                          S.of(context).generalSpent,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        Text(
                          S.of(context).generalLeft,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        Text(
                          defaultCurrency.fmt(totalBudgeted),
                          style: const TextStyle(
                            fontFeatures: <FontFeature>[.tabularFigures()],
                          ),
                        ),
                        Text(
                          defaultCurrency.fmt(totalSpent),
                          style: const TextStyle(
                            fontFeatures: <FontFeature>[.tabularFigures()],
                          ),
                        ),
                        Text(
                          defaultCurrency.fmt(totalLeft),
                          style: TextStyle(
                            color: (totalLeft < 0)
                                ? const Color(0xFFFF4F4B)
                                : Colors.green,
                            fontWeight: .bold,
                            fontFeatures: const <FontFeature>[
                              .tabularFigures(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }

            return Column(crossAxisAlignment: .start, children: widgets);
          },
        ),
      ),
    );
  }
}
