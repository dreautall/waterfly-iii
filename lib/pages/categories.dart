import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/pages/categories/addedit.dart';
import 'package:waterflyiii/pages/home/transactions.dart';
import 'package:waterflyiii/pages/navigation.dart';
import 'package:waterflyiii/stock.dart';

final Logger log = Logger("Pages.Categories");

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({
    super.key,
  });

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage>
    with SingleTickerProviderStateMixin {
  final Logger log = Logger("Pages.Categories.Page");
  late DateTime selectedMonth;
  late DateTime now;
  late CatStock stock;

  @override
  void initState() {
    super.initState();

    now = context
        .read<FireflyService>()
        .tzHandler
        .sNow()
        .setTimeOfDay(const TimeOfDay(hour: 12, minute: 0));
    selectedMonth = now.copyWith(day: 15);

    stock = CatStock(context.read<FireflyService>().api,
        context.read<FireflyService>().defaultCurrency);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NavPageElements>().appBarActions = <Widget>[
        IconButton(
          icon: const Icon(Icons.plus_one),
          tooltip: S.of(context).categoryTitleAdd,
          onPressed: () async {
            bool? ok = await showDialog(
              context: context,
              builder: (BuildContext context) =>
                  const CategoryAddEditDialog(category: null),
            );
            if (!(ok ?? false)) {
              return;
            }

            // Refresh page
            stock.reset();
            setState(() {});
          },
        ),
        IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: S.of(context).categoryMonthPrev,
          onPressed: () {
            log.finest(() => "getting prev month");
            setState(() {
              selectedMonth =
                  selectedMonth.copyWith(month: selectedMonth.month - 1);
            });
          },
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward),
          tooltip: S.of(context).categoryMonthNext,
          onPressed: () {
            log.finest(() => "getting next month");
            setState(() {
              selectedMonth =
                  selectedMonth.copyWith(month: selectedMonth.month + 1);
            });
          },
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    log.fine(() => "build");
    final CurrencyRead defaultCurrency =
        context.read<FireflyService>().defaultCurrency;

    late DateTime stockDate;
    if (selectedMonth.year == now.year && selectedMonth.month == now.month) {
      stockDate = selectedMonth.copyWith(day: now.day);
    } else {
      stockDate =
          selectedMonth.copyWith(day: 0, month: selectedMonth.month + 1);
    }

    return FutureBuilder<CategoryArray>(
      future: stock.get(stockDate),
      builder: (BuildContext context, AsyncSnapshot<CategoryArray> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
          log.severe(
            "Error loading categories",
            snapshot.error,
            snapshot.stackTrace,
          );
          return Center(
            child: Text(
              S.of(context).categoryErrorLoading,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(color: Theme.of(context).colorScheme.error),
            ),
          );
        }
        final List<Widget> childs = <Widget>[];
        childs.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      DateFormat.yMMMM().format(selectedMonth),
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    S.of(context).generalSpent,
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                Expanded(
                  child: Text(
                    S.of(context).generalEarned,
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                Expanded(
                  child: Text(
                    S.of(context).generalSum,
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ],
            ),
          ),
        );
        childs.add(const Divider());

        // Sort low-to-high by:
        // 1. Total sum
        // 2. Spent sum
        // 3. Earned sum
        snapshot.data!.data.sort(
          (CategoryRead a, CategoryRead b) {
            CategoryWithSum cA = a.attributes as CategoryWithSum;
            CategoryWithSum cB = b.attributes as CategoryWithSum;
            final double sumA = cA.sumSpent + cA.sumEarned;
            final double sumB = cB.sumSpent + cB.sumEarned;
            if (sumA == sumB) {
              if (cA.sumSpent == cB.sumSpent) {
                return cA.sumEarned.compareTo(cB.sumEarned);
              } else {
                return cA.sumSpent.compareTo(cB.sumSpent);
              }
            } else {
              return sumA.compareTo(sumB);
            }
          },
        );

        final double totalEarned = snapshot.data!.data.fold<double>(
            0,
            (double p, CategoryRead e) =>
                p += (e.attributes as CategoryWithSum).sumEarned);
        final double totalSpent = snapshot.data!.data.fold<double>(
            0,
            (double p, CategoryRead e) =>
                p += (e.attributes as CategoryWithSum).sumSpent);

        for (CategoryRead category in snapshot.data!.data) {
          childs.add(CategoryLine(
            category: category,
            setState: setState,
            stock: stock,
            totalSpent: totalSpent,
            totalEarned: totalEarned,
          ));
        }
        childs.add(const Divider());
        childs.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Text(
                    S.of(context).generalSum,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Expanded(
                  child: Text(
                    defaultCurrency.fmt(totalSpent),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: totalSpent < 0
                          ? Colors.red
                          : totalSpent > 0
                              ? Colors.green
                              : Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontFeatures: const <FontFeature>[
                        FontFeature.tabularFigures()
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    defaultCurrency.fmt(totalEarned),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: totalEarned < 0
                          ? Colors.red
                          : totalEarned > 0
                              ? Colors.green
                              : Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontFeatures: const <FontFeature>[
                        FontFeature.tabularFigures()
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    defaultCurrency.fmt(totalSpent + totalEarned),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: (totalSpent + totalEarned) < 0
                          ? Colors.red
                          : (totalSpent + totalEarned) > 0
                              ? Colors.green
                              : Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontFeatures: const <FontFeature>[
                        FontFeature.tabularFigures()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
        return RefreshIndicator(
          onRefresh: () => Future<void>(() async {
            await stock.reset();
            setState(() {});
          }),
          child: ListView(
            children: childs,
          ),
        );
      },
    );
  }
}

class CategoryLine extends StatelessWidget {
  const CategoryLine({
    super.key,
    required this.category,
    required this.setState,
    required this.totalSpent,
    required this.totalEarned,
    required this.stock,
  });

  final CategoryRead category;
  final void Function(void Function()) setState;
  final double totalSpent;
  final double totalEarned;
  final CatStock stock;

  @override
  Widget build(BuildContext context) {
    final CurrencyRead defaultCurrency =
        context.read<FireflyService>().defaultCurrency;

    CategoryWithSum cs = category.attributes as CategoryWithSum;
    final double totalBalance = cs.sumSpent + cs.sumEarned;

    return OpenContainer(
      openBuilder: (BuildContext context, Function closedContainer) => Scaffold(
        appBar: AppBar(
          title: Text(category.attributes.name == "L10NNONE"
              ? S.of(context).catNone
              : category.attributes.name),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              tooltip: S.of(context).categoryTitleEdit,
              onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) =>
                    CategoryAddEditDialog(category: category),
              ),
            ),
          ],
        ),
        body: HomeTransactions(category: category),
      ),
      openColor: Theme.of(context).cardColor,
      closedColor: Theme.of(context).cardColor,
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
      ),
      closedElevation: 0,
      closedBuilder: (BuildContext context, Function openContainer) =>
          GestureDetector(
        onLongPressStart: category.attributes.name == "L10NNONE"
            ? null
            : (LongPressStartDetails details) async {
                final Size screenSize = MediaQuery.of(context).size;
                final Offset offset = details.globalPosition;
                HapticFeedback.vibrate();
                final Function? func = await showMenu<Function>(
                  context: context,
                  position: RelativeRect.fromLTRB(
                    offset.dx,
                    offset.dy,
                    screenSize.width - offset.dx,
                    screenSize.height - offset.dy,
                  ),
                  items: <PopupMenuEntry<Function>>[
                    PopupMenuItem<Function>(
                      value: () async {
                        bool? ok = await showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              CategoryAddEditDialog(category: category),
                        );
                        if (!(ok ?? false)) {
                          return;
                        }

                        // Refresh page
                        stock.reset();
                        setState(() {});
                      },
                      child: Row(
                        children: <Widget>[
                          const Icon(Icons.edit),
                          const SizedBox(width: 12),
                          Text(S.of(context).categoryTitleEdit),
                        ],
                      ),
                    ),
                  ],
                  clipBehavior: Clip.hardEdge,
                );
                if (func == null) {
                  return;
                }
                func();
              },
        child: InkWell(
          customBorder: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
          ),
          onTap: () => openContainer(),
          child: Semantics(
            enabled: true,
            child: Ink(
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
              ),
              child: SafeArea(
                top: false,
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            category.attributes.name == "L10NNONE"
                                ? S.of(context).catNone
                                : category.attributes.name,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          ActionChip(
                            label: Text(
                              NumberFormat.percentPattern().format(
                                  totalBalance < 0
                                      ? cs.sumSpent / totalSpent
                                      : cs.sumEarned / totalEarned),
                            ),
                            labelStyle: Theme.of(context).textTheme.labelLarge,
                            labelPadding: const EdgeInsets.symmetric(
                                horizontal: 2, vertical: -4),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 2, vertical: -4),
                            side: BorderSide(
                              color: totalBalance < 0
                                  ? Colors.red
                                  : totalBalance > 0
                                      ? Colors.green
                                      : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          const Expanded(child: SizedBox.shrink()),
                          Expanded(
                            child: Text(
                              defaultCurrency.fmt(cs.sumSpent),
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: cs.sumSpent < 0
                                    ? Colors.red
                                    : cs.sumSpent > 0
                                        ? Colors.green
                                        : Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontFeatures: const <FontFeature>[
                                  FontFeature.tabularFigures()
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              defaultCurrency.fmt(cs.sumEarned),
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: cs.sumEarned < 0
                                    ? Colors.red
                                    : cs.sumEarned > 0
                                        ? Colors.green
                                        : Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontFeatures: const <FontFeature>[
                                  FontFeature.tabularFigures()
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              defaultCurrency.fmt(cs.sumSpent + cs.sumEarned),
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: totalBalance < 0
                                    ? Colors.red
                                    : totalBalance > 0
                                        ? Colors.green
                                        : Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontFeatures: const <FontFeature>[
                                  FontFeature.tabularFigures()
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      onClosed: (bool? refresh) {
        debugPrint("closed with $refresh");
      },
    );
  }
}
