import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:waterflyiii/animations.dart';

PagedChildBuilderDelegate<T> customPagedChildBuilderDelegate<T>({
  required ItemWidgetBuilder<T> itemBuilder,
  WidgetBuilder? firstPageErrorIndicatorBuilder,
  WidgetBuilder? newPageErrorIndicatorBuilder,
  WidgetBuilder? noItemsFoundIndicatorBuilder,
  WidgetBuilder? noMoreItemsIndicatorBuilder,
  int invisibleItemsThreshold = 10,
}) {
  return PagedChildBuilderDelegate<T>(
    itemBuilder: itemBuilder,
    firstPageErrorIndicatorBuilder: firstPageErrorIndicatorBuilder,
    newPageErrorIndicatorBuilder: newPageErrorIndicatorBuilder,
    noItemsFoundIndicatorBuilder: noItemsFoundIndicatorBuilder,
    noMoreItemsIndicatorBuilder: noMoreItemsIndicatorBuilder,
    invisibleItemsThreshold: invisibleItemsThreshold,

    animateTransitions: true,
    transitionDuration: animDurationStandard,
    firstPageProgressIndicatorBuilder:
        (_) => const Padding(
          padding: EdgeInsets.all(32),
          child: Center(child: CircularProgressIndicator.adaptive()),
        ),
    newPageProgressIndicatorBuilder:
        (_) => const Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          child: Center(child: CircularProgressIndicator.adaptive()),
        ),
  );
}
