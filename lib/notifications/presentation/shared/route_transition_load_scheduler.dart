import 'package:flutter/widgets.dart';

class RouteTransitionLoadScheduler {
  bool _scheduled = false;
  Animation<double>? _routeAnimation;
  AnimationStatusListener? _routeAnimationListener;

  void schedule(BuildContext context, VoidCallback load) {
    if (_scheduled) return;
    _scheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;
      final Animation<double>? animation = ModalRoute.of(context)?.animation;
      if (animation == null || animation.status == AnimationStatus.completed) {
        load();
        return;
      }
      _routeAnimation = animation;
      _routeAnimationListener = (AnimationStatus status) {
        if (status != AnimationStatus.completed) return;
        _removeRouteAnimationListener();
        if (context.mounted) load();
      };
      animation.addStatusListener(_routeAnimationListener!);
    });
  }

  void dispose() {
    _removeRouteAnimationListener();
  }

  void _removeRouteAnimationListener() {
    final AnimationStatusListener? listener = _routeAnimationListener;
    if (listener != null) _routeAnimation?.removeStatusListener(listener);
    _routeAnimation = null;
    _routeAnimationListener = null;
  }
}
