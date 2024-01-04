import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'package:chopper/chopper.dart';

import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/pages/home/transactions.dart';

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

  Future<CategoryArray> _fetchCategories(DateTime now) async {
    final S l10n = S.of(context);
    final FireflyIii api = context.read<FireflyService>().api;
    final CurrencyRead defaultCurrency =
        context.read<FireflyService>().defaultCurrency;

    // :TODO: remove
    now = now.copyWith(month: now.month - 1, day: 31);
    final String startDate =
        DateFormat('yyyy-MM-dd', 'en_US').format(now.copyWith(day: 1));
    final String endDate = DateFormat('yyyy-MM-dd', 'en_US').format(now);

    final Response<InsightGroup> respIncomeCat =
        await api.v1InsightIncomeCategoryGet(
      start: startDate,
      end: endDate,
    );
    if (!respIncomeCat.isSuccessful || respIncomeCat.body == null) {
      if (context.mounted) {
        throw Exception(
          S
              .of(context)
              .errorAPIInvalidResponse(respIncomeCat.error?.toString() ?? ""),
        );
      } else {
        throw Exception(
          "[nocontext] Invalid API response: ${respIncomeCat.error}",
        );
      }
    }
    final Response<InsightTotal> respIncomeNoCat =
        await api.v1InsightIncomeNoCategoryGet(
      start: startDate,
      end: endDate,
    );
    if (!respIncomeNoCat.isSuccessful || respIncomeNoCat.body == null) {
      if (context.mounted) {
        throw Exception(
          S
              .of(context)
              .errorAPIInvalidResponse(respIncomeNoCat.error?.toString() ?? ""),
        );
      } else {
        throw Exception(
          "[nocontext] Invalid API response: ${respIncomeNoCat.error}",
        );
      }
    }
    final Response<InsightGroup> respExpenseCat =
        await api.v1InsightExpenseCategoryGet(
      start: startDate,
      end: endDate,
    );
    if (!respExpenseCat.isSuccessful || respExpenseCat.body == null) {
      if (context.mounted) {
        throw Exception(
          S
              .of(context)
              .errorAPIInvalidResponse(respExpenseCat.error?.toString() ?? ""),
        );
      } else {
        throw Exception(
          "[nocontext] Invalid API response: ${respExpenseCat.error}",
        );
      }
    }
    final Response<InsightTotal> respExpenseNoCat =
        await api.v1InsightExpenseNoCategoryGet(
      start: startDate,
      end: endDate,
    );
    if (!respExpenseNoCat.isSuccessful || respExpenseNoCat.body == null) {
      if (context.mounted) {
        throw Exception(
          S.of(context).errorAPIInvalidResponse(
              respExpenseNoCat.error?.toString() ?? ""),
        );
      } else {
        throw Exception(
          "[nocontext] Invalid API response: ${respExpenseNoCat.error}",
        );
      }
    }

    final Map<String, CategoryRead> categories = <String, CategoryRead>{};
    for (InsightGroupEntry cat in respIncomeCat.body!) {
      if ((cat.id?.isEmpty ?? true) || (cat.name?.isEmpty ?? true)) {
        log.finest(() => "skipping empty category");
        continue;
      }

      if (cat.currencyId != defaultCurrency.id) {
        log.finest(() =>
            "skipping non-default currency category (${cat.currencyCode})");
        continue;
      }
      if (!categories.containsKey(cat.id)) {
        categories[cat.id!] = CategoryRead(
          id: cat.id!,
          type: "categories",
          attributes: CategoryWithSum(
            name: cat.name!,
            spent: <CategorySpent>[],
            earned: <CategoryEarned>[],
          ),
        );
      }
      categories[cat.id!]!.attributes.earned!.add(
            CategoryEarned(
              currencyId: cat.currencyId,
              currencyCode: cat.currencyCode,
              currencyDecimalPlaces: defaultCurrency.attributes.decimalPlaces,
              currencySymbol: defaultCurrency.attributes.symbol,
              sum: cat.difference,
            ),
          );
    }
    for (InsightGroupEntry cat in respExpenseCat.body!) {
      if ((cat.id?.isEmpty ?? true) || (cat.name?.isEmpty ?? true)) {
        log.finest(() => "skipping empty category");
        continue;
      }

      if (cat.currencyId != defaultCurrency.id) {
        log.finest(() =>
            "skipping non-default currency category (${cat.currencyCode})");
        continue;
      }
      if (!categories.containsKey(cat.id)) {
        categories[cat.id!] = CategoryRead(
          id: cat.id!,
          type: "categories",
          attributes: CategoryWithSum(
            name: cat.name!,
            spent: <CategorySpent>[],
            earned: <CategoryEarned>[],
          ),
        );
      }
      categories[cat.id!]!.attributes.spent!.add(
            CategorySpent(
              currencyId: cat.currencyId,
              currencyCode: cat.currencyCode,
              currencyDecimalPlaces: defaultCurrency.attributes.decimalPlaces,
              currencySymbol: defaultCurrency.attributes.symbol,
              sum: cat.difference,
            ),
          );
    }
    for (InsightTotalEntry cat in respIncomeNoCat.body!) {
      if (cat.currencyId != defaultCurrency.id) {
        log.finest(() =>
            "skipping non-default currency category (${cat.currencyCode})");
        continue;
      }
      if (!categories.containsKey("-1")) {
        categories["-1"] = CategoryRead(
          id: "-1",
          type: "no-category",
          attributes: CategoryWithSum(
            name: l10n.catNone,
            spent: <CategorySpent>[],
            earned: <CategoryEarned>[],
          ),
        );
      }
      categories["-1"]!.attributes.earned!.add(
            CategoryEarned(
              currencyId: cat.currencyId,
              currencyCode: cat.currencyCode,
              currencyDecimalPlaces: defaultCurrency.attributes.decimalPlaces,
              currencySymbol: defaultCurrency.attributes.symbol,
              sum: cat.difference,
            ),
          );
    }
    for (InsightTotalEntry cat in respExpenseNoCat.body!) {
      if (cat.currencyId != defaultCurrency.id) {
        log.finest(() =>
            "skipping non-default currency category (${cat.currencyCode})");
        continue;
      }
      if (!categories.containsKey("-1")) {
        categories["-1"] = CategoryRead(
          id: "-1",
          type: "no-category",
          attributes: CategoryWithSum(
            name: l10n.catNone,
            spent: <CategorySpent>[],
            earned: <CategoryEarned>[],
          ),
        );
      }
      categories["-1"]!.attributes.spent!.add(
            CategorySpent(
              currencyId: cat.currencyId,
              currencyCode: cat.currencyCode,
              currencyDecimalPlaces: defaultCurrency.attributes.decimalPlaces,
              currencySymbol: defaultCurrency.attributes.symbol,
              sum: cat.difference,
            ),
          );
    }

    categories.forEach((_, CategoryRead c) {
      CategoryWithSum cs = c.attributes as CategoryWithSum;
      cs.sumEarned = c.attributes.earned!.fold<double>(
          0, (double p, CategoryEarned e) => p += double.parse(e.sum ?? "0"));
      cs.sumSpent = c.attributes.spent!.fold<double>(
          0, (double p, CategorySpent e) => p += double.parse(e.sum ?? "0"));
    });

    return CategoryArray(
      data: categories.values.toList(growable: false),
      meta: const Meta(),
    );
  }

  @override
  Widget build(BuildContext context) {
    log.fine(() => "build");
    final CurrencyRead defaultCurrency =
        context.read<FireflyService>().defaultCurrency;
    final DateTime now = DateTime.now().toLocal().clearTime();

    return FutureBuilder<CategoryArray>(
      future: _fetchCategories(now),
      builder: (BuildContext context, AsyncSnapshot<CategoryArray> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // :TODO: loading
          return const Text("loading");
        }
        if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
          // :TODO: error handling
          log.severe(
            "Error loading categories",
            snapshot.error,
            snapshot.stackTrace,
          );
          return const Text("booo");
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
                      DateFormat.yMMMM().format(now),
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
          CategoryWithSum cs = category.attributes as CategoryWithSum;
          final bool negativeBalance = (cs.sumSpent + cs.sumEarned) < 0;

          childs.add(
            OpenContainer(
              openBuilder: (BuildContext context, Function closedContainer) =>
                  Scaffold(
                appBar: AppBar(
                  title: Text(category.attributes.name),
                ),
                body: HomeTransactions(categoryId: category.id),
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
                onLongPressStart: (LongPressStartDetails details) async {
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
                          bool? ok = await Navigator.push(
                            context,
                            MaterialPageRoute<bool>(
                              builder: (BuildContext context) =>
                                  const Placeholder(),
                            ),
                          );
                        },
                        child: Row(
                          children: <Widget>[
                            const Icon(Icons.copy),
                            const SizedBox(width: 12),
                            Text("Long Press Action 1"),
                          ],
                        ),
                      ),
                      const PopupMenuDivider(),
                      PopupMenuItem<Function>(
                        value: () async {
                          //final FireflyIii api = context.read<FireflyService>().api;
                          bool? ok = await showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) =>
                                const Placeholder(),
                          );
                        },
                        child: Row(
                          children: <Widget>[
                            const Icon(Icons.delete),
                            const SizedBox(width: 12),
                            Text("Long Press Action 2"),
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
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            category.attributes.name,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          ActionChip(
                            label: Text(
                              NumberFormat.percentPattern().format(
                                  negativeBalance
                                      ? cs.sumSpent / totalSpent
                                      : cs.sumEarned / totalEarned),
                            ),
                            labelStyle: Theme.of(context).textTheme.labelLarge,
                            labelPadding: const EdgeInsets.symmetric(
                                horizontal: 2, vertical: -4),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 2, vertical: -4),
                            side: BorderSide(
                              color:
                                  negativeBalance ? Colors.red : Colors.green,
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
                                color:
                                    cs.sumSpent < 0 ? Colors.red : Colors.green,
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
                                    : Colors.green,
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
                                color:
                                    negativeBalance ? Colors.red : Colors.green,
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
              onClosed: (bool? refresh) {
                debugPrint("closed with $refresh");
              },
            ),
          );
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
                      color: totalSpent < 0 ? Colors.red : Colors.green,
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
                      color: totalEarned < 0 ? Colors.red : Colors.green,
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
                          : Colors.green,
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
          onRefresh: () => Future<void>(() {
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
