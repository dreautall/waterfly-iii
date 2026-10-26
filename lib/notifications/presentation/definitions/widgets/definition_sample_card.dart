import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/presentation/shared/sample_notification_card.dart';

class DefinitionSampleCard extends StatefulWidget {
  const DefinitionSampleCard({
    super.key,
    required this.applicationId,
    required this.title,
    required this.body,
    required this.receivedAt,
    required this.onEdit,
    this.showLatestSampleAction = false,
    this.onUseLatestSample,
  });

  final String applicationId;
  final String title;
  final String body;
  final DateTime? receivedAt;
  final VoidCallback onEdit;
  final bool showLatestSampleAction;
  final VoidCallback? onUseLatestSample;

  @override
  State<DefinitionSampleCard> createState() => _DefinitionSampleCardState();
}

class _DefinitionSampleCardState extends State<DefinitionSampleCard>
    with SingleTickerProviderStateMixin {
  static const Duration _animationDuration = Duration(milliseconds: 220);
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: _animationDuration,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );
  Animation<double>? _routeAnimation;
  AnimationStatusListener? _routeStatusListener;

  bool get _showAction =>
      widget.title.trim().isEmpty &&
      widget.body.trim().isEmpty &&
      widget.showLatestSampleAction &&
      widget.onUseLatestSample != null;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncAnimation();
  }

  @override
  void didUpdateWidget(DefinitionSampleCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncAnimation();
  }

  void _syncAnimation() {
    if (!_showAction) {
      _clearRouteListener();
      _controller.reverse();
      return;
    }
    final Animation<double>? routeAnimation = ModalRoute.of(context)?.animation;
    if (routeAnimation == null ||
        routeAnimation.status == AnimationStatus.completed) {
      _clearRouteListener();
      _controller.forward();
      return;
    }
    if (identical(_routeAnimation, routeAnimation)) return;
    _clearRouteListener();
    _routeAnimation = routeAnimation;
    _routeStatusListener = (AnimationStatus status) {
      if (status != AnimationStatus.completed) return;
      _clearRouteListener();
      if (mounted && _showAction) {
        _controller.forward();
      }
    };
    routeAnimation.addStatusListener(_routeStatusListener!);
  }

  void _clearRouteListener() {
    final AnimationStatusListener? listener = _routeStatusListener;
    if (listener != null) {
      _routeAnimation?.removeStatusListener(listener);
    }
    _routeAnimation = null;
    _routeStatusListener = null;
  }

  @override
  void dispose() {
    _clearRouteListener();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasSample =
        widget.title.trim().isNotEmpty && widget.body.trim().isNotEmpty;
    return AnimatedBuilder(
      key: const Key('definition-sample-latest-action-animation'),
      animation: _animation,
      builder: (BuildContext context, Widget? card) {
        const double visibleActionHeight = 40;
        final double progress = _animation.value;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            card!,
            ClipRect(
              child: Align(
                heightFactor: progress,
                alignment: Alignment.topCenter,
                child: Transform.translate(
                  offset: Offset(0, -visibleActionHeight * (1 - progress)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: IgnorePointer(
                      ignoring: !_showAction,
                      child: SizedBox(
                        width: double.infinity,
                        height: visibleActionHeight,
                        child: FilledButton.tonalIcon(
                          key: const Key('use-latest-notification-sample'),
                          onPressed: widget.onUseLatestSample,
                          style: FilledButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(8),
                              ),
                            ),
                          ),
                          icon: const Icon(Icons.history_outlined),
                          label: Text(
                            S
                                .of(context)
                                .notificationsDefinitionUseLatestSample,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      child: SampleNotificationCard(
        applicationId: widget.applicationId,
        title: hasSample
            ? widget.title
            : S.of(context).notificationsDefinitionSampleNotification,
        body: hasSample
            ? widget.body
            : S.of(context).notificationsDefinitionSampleRequired,
        receivedAt: hasSample ? widget.receivedAt : null,
        onTap: widget.onEdit,
        trailing: IconButton(
          tooltip: S.of(context).notificationsDefinitionEditSample,
          onPressed: widget.onEdit,
          icon: const Icon(Icons.edit_outlined),
          iconSize: 18,
        ),
      ),
    );
  }
}
