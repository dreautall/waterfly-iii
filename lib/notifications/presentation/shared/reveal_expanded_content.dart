import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_page_header.dart';

const Duration notificationExpansionDuration = Duration(milliseconds: 180);
const double _expandedContentTopSpacing = 8;
const double _expandedContentBottomSpacing = 16;

Future<void> revealExpandedContent(
  BuildContext context, {
  Duration expansionDuration = notificationExpansionDuration,
}) async {
  await WidgetsBinding.instance.endOfFrame;
  await Future<void>.delayed(expansionDuration);
  await WidgetsBinding.instance.endOfFrame;
  if (!context.mounted) return;
  final ScrollableState? scrollable = Scrollable.maybeOf(context);
  if (scrollable == null || !scrollable.mounted) return;
  final RenderObject? targetObject = context.findRenderObject();
  final RenderObject? viewportObject = scrollable.context.findRenderObject();
  if (targetObject is! RenderBox || viewportObject is! RenderBox) {
    return;
  }
  final double targetTop = targetObject.localToGlobal(Offset.zero).dy;
  final double targetBottom = targetObject
      .localToGlobal(Offset(0, targetObject.size.height))
      .dy;
  final double visibleTop = math.max(
    viewportObject.localToGlobal(Offset.zero).dy,
    NotificationPageHeader.bodyTopInset(context) + _expandedContentTopSpacing,
  );
  final double bottomClearance =
      MediaQuery.paddingOf(context).bottom + _expandedContentBottomSpacing;
  final double visibleBottom =
      viewportObject.localToGlobal(Offset(0, viewportObject.size.height)).dy -
      bottomClearance;
  final double scrollAmount;
  if (targetTop < visibleTop) {
    scrollAmount = targetTop - visibleTop;
  } else {
    final double obscuredHeight = targetBottom - visibleBottom;
    if (obscuredHeight <= 0) return;
    scrollAmount = obscuredHeight.clamp(0, targetTop - visibleTop);
  }
  if (scrollAmount == 0) return;
  final ScrollPosition position = scrollable.position;
  final double targetOffset = switch (position.axisDirection) {
    AxisDirection.down => position.pixels + scrollAmount,
    AxisDirection.up => position.pixels - scrollAmount,
    AxisDirection.left || AxisDirection.right => position.pixels,
  };
  final double boundedOffset = targetOffset.clamp(
    position.minScrollExtent,
    position.maxScrollExtent,
  );
  if (boundedOffset == position.pixels) return;
  await position.animateTo(
    boundedOffset,
    duration: expansionDuration,
    curve: Curves.easeInOut,
  );
}
