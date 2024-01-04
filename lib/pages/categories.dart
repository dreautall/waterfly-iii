import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:collection/collection.dart';
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

  Future<CategoryArray> _fetchCategories() async {
    final FireflyIii api = context.read<FireflyService>().api;
    final CurrencyRead defaultCurrency =
        context.read<FireflyService>().defaultCurrency;

    /*final*/ DateTime now = DateTime.now().toLocal().clearTime();
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
          attributes: Category(
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
          attributes: Category(
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
          attributes: Category(
            name: "(no category)", // :TODO: l10n
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
          attributes: Category(
            name: "(no category)", // :TODO: l10n
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

    return FutureBuilder<CategoryArray>(
      future: _fetchCategories(),
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
                const Expanded(child: SizedBox.shrink()),
                Expanded(
                  child: Text(
                    "Spent", // :TODO: l10n
                    textAlign: TextAlign.end,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Earned", // :TODO: l10n
                    textAlign: TextAlign.end,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Sum", // :TODO: l10n
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
        );

        snapshot.data!.data.sort(
          (CategoryRead a, CategoryRead b) {
            double spentA = a.attributes.spent!.fold<double>(
              0,
              (double p, CategorySpent e) => p += double.parse(e.sum ?? "0"),
            );
            double earnedA = a.attributes.earned!.fold<double>(
              0,
              (double p, CategoryEarned e) => p += double.parse(e.sum ?? "0"),
            );
            double spentB = b.attributes.spent!.fold<double>(
              0,
              (double p, CategorySpent e) => p += double.parse(e.sum ?? "0"),
            );
            double earnedB = b.attributes.earned!.fold<double>(
              0,
              (double p, CategoryEarned e) => p += double.parse(e.sum ?? "0"),
            );
            final double sumA = spentA + earnedA;
            final double sumB = spentB + earnedB;
            if (sumA == sumB) {
              if (spentA == spentB) {
                return earnedA.compareTo(earnedB);
              } else {
                return spentA.compareTo(spentB);
              }
            } else {
              return sumA.compareTo(sumB);
            }
          },
        );

        for (CategoryRead category in snapshot.data!.data) {
          double spent = category.attributes.spent!.fold<double>(
            0,
            (double p, CategorySpent e) => p += double.parse(e.sum ?? "0"),
          );
          double earned = category.attributes.earned!.fold<double>(
            0,
            (double p, CategoryEarned e) => p += double.parse(e.sum ?? "0"),
          );
          childs.add(
            OpenContainer(
              openBuilder: (BuildContext context, Function closedContainer) =>
                  Placeholder(),
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
                      Text(
                        category.attributes
                            .name, // :TODO: add percentage indicator.
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          const Expanded(child: SizedBox.shrink()),
                          Expanded(
                            child: Text(
                              defaultCurrency.fmt(spent),
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: spent < 0 ? Colors.red : Colors.green,
                                fontWeight: FontWeight.bold,
                                fontFeatures: const <FontFeature>[
                                  FontFeature.tabularFigures()
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              defaultCurrency.fmt(earned),
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: earned < 0 ? Colors.red : Colors.green,
                                fontWeight: FontWeight.bold,
                                fontFeatures: const <FontFeature>[
                                  FontFeature.tabularFigures()
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              defaultCurrency.fmt(spent + earned),
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: (spent + earned) < 0
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
                    ],
                  ),
                ),
              ),
              onClosed: (bool? refresh) {
                debugPrint("closed with $refresh");
              },
            ),
          );
          childs.add(const Divider());
        }
        childs.removeLast();
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
