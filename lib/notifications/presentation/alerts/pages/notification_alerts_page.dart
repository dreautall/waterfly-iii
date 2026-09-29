import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/application/alerts/dismiss_notification_alerts.dart';
import 'package:waterflyiii/notifications/application/rules/notification_rule_operations.dart';
import 'package:waterflyiii/notifications/application/stores/notification_alert_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_definition_store.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/listeners/notification_listener_health_issue.dart';
import 'package:waterflyiii/notifications/notification_feature_scope.dart';
import 'package:waterflyiii/notifications/presentation/alerts/controllers/notification_alerts_view_model.dart';
import 'package:waterflyiii/notifications/presentation/alerts/widgets/notification_alert_card.dart';
import 'package:waterflyiii/notifications/presentation/health/controllers/notification_listener_health_view_model.dart';
import 'package:waterflyiii/notifications/presentation/health/notification_listener_health_actions.dart';
import 'package:waterflyiii/notifications/presentation/health/widgets/notification_listener_health_card.dart';
import 'package:waterflyiii/notifications/presentation/definitions/pages/notification_definitions_page.dart';
import 'package:waterflyiii/notifications/presentation/navigation/notification_navigation_coordinator.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_dialog.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_empty_state.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_page_header.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';
import 'package:waterflyiii/notifications/presentation/shared/message_status_card.dart';

class NotificationAlertsPage extends StatefulWidget {
  const NotificationAlertsPage({
    super.key,
    this.alertStore,
    this.definitionStore,
    this.previewAlerts,
    this.initialAlertFingerprint,
    this.healthViewModel,
    this.navigationCoordinator,
  });

  final NotificationAlertStore? alertStore;
  final NotificationDefinitionStore? definitionStore;
  final List<NotificationAlert>? previewAlerts;
  final String? initialAlertFingerprint;
  final NotificationListenerHealthViewModel? healthViewModel;
  final NotificationNavigationCoordinator? navigationCoordinator;

  @override
  State<NotificationAlertsPage> createState() => _NotificationAlertsPageState();
}

class _NotificationAlertsPageState extends State<NotificationAlertsPage> {
  static const Duration _dismissUndoDuration = Duration(seconds: 6);

  static const Duration _groupAnimationDuration = Duration(milliseconds: 220);
  static const Duration _groupStagger = Duration(milliseconds: 24);

  late final NotificationAlertsViewModel _viewModel;
  NotificationListenerHealthViewModel? _healthViewModel;
  NotificationDefinitionStore? _definitionStore;
  NotificationNavigationCoordinator? _navigation;
  bool _ownsViewModel = false;
  bool _reportedApplicationNamesFailure = false;
  final Map<String, GlobalKey> _alertKeys = <String, GlobalKey>{};
  final ScrollController _scrollController = ScrollController();
  String? _highlightedGroupKey;
  Timer? _highlightTimer;
  bool _revealedInitialAlert = false;
  final List<NotificationAlertGroup> _displayedGroups =
      <NotificationAlertGroup>[];
  final Set<String> _removingGroupKeys = <String>{};
  final Set<String> _enteringGroupKeys = <String>{};
  final Map<String, Timer> _groupAnimationTimers = <String, Timer>{};
  bool _groupsInitialized = false;
  bool _staggerGroupRemovals = false;
  bool _staggerGroupInsertions = false;

  @override
  void initState() {
    super.initState();
    final NotificationFeatureScope? scope = context
        .read<NotificationFeatureScope?>();
    _definitionStore = widget.definitionStore ?? scope?.definitionStore;
    _healthViewModel = widget.healthViewModel ?? scope?.healthViewModel;
    final NotificationDefinitionStore? definitionStore = _definitionStore;
    final NotificationRuleOperations? ruleOperations = definitionStore == null
        ? null
        : widget.definitionStore == null && scope != null
        ? scope.ruleOperations
        : NotificationRuleOperations(definitionStore);
    if (widget.previewAlerts != null) {
      _viewModel = NotificationAlertsViewModel.preview(
        widget.previewAlerts!,
        definitionStore: definitionStore,
        ruleOperations: ruleOperations,
      );
      _ownsViewModel = true;
    } else if (widget.alertStore != null || widget.definitionStore != null) {
      _viewModel = NotificationAlertsViewModel(
        widget.alertStore ?? scope!.alertStore,
        definitionStore: definitionStore,
        ruleOperations: ruleOperations,
      );
      _ownsViewModel = true;
    } else {
      _viewModel = scope!.alertsViewModel;
    }
    _navigation =
        widget.navigationCoordinator ??
        (definitionStore == null
            ? null
            : NotificationNavigationCoordinator.forAlertEditors(
                definitionStore: definitionStore,
                ruleOperations: ruleOperations!,
                scope: scope,
              ));
    _viewModel.addListener(_onViewModelChanged);
    _healthViewModel?.addListener(_onViewModelChanged);
    _viewModel.load();
    _healthViewModel?.load();
  }

  void _onViewModelChanged() {
    if (mounted) {
      _syncDisplayedGroups();
      setState(() {});
      _revealInitialAlert();
      if (_viewModel.applicationNamesStatus ==
          NotificationApplicationNamesStatus.loading) {
        _reportedApplicationNamesFailure = false;
      } else if (_viewModel.applicationNamesStatus ==
              NotificationApplicationNamesStatus.failed &&
          !_reportedApplicationNamesFailure) {
        _reportedApplicationNamesFailure = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                S.of(context).notificationsAlertsApplicationNamesLoadFailure,
              ),
            ),
          );
        });
      }
    }
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelChanged);
    _healthViewModel?.removeListener(_onViewModelChanged);
    if (_ownsViewModel) _viewModel.dispose();
    _highlightTimer?.cancel();
    for (final Timer timer in _groupAnimationTimers.values) {
      timer.cancel();
    }
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: NotificationPageHeader(
        scrollController: _scrollController,
        title: Text(S.of(context).notificationsAlertsTitle),
        actions: <Widget>[
          IconButton(
            tooltip: S.of(context).notificationsAlertsDismissAll,
            iconSize: NotificationPageHeader.controlIconSize,
            onPressed:
                _viewModel.visibleAlerts.isNotEmpty &&
                    !_viewModel.isDismissingAll
                ? () => _dismissAll(_viewModel.visibleAlerts)
                : null,
            icon: const Icon(Icons.delete_sweep_outlined),
          ),
        ],
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    final NotificationListenerHealthIssue? healthIssue =
        _healthViewModel?.issue;
    final bool showCenteredEmptyState =
        !_viewModel.isLoading &&
        _viewModel.error == null &&
        _displayedGroups.isEmpty &&
        healthIssue == null &&
        _healthViewModel?.error == null;
    return RefreshIndicator(
      onRefresh: _refresh,
      child: CustomScrollView(
        controller: _scrollController,
        physics:
            !_viewModel.isLoading &&
                _viewModel.error == null &&
                _viewModel.visibleAlerts.isEmpty
            ? healthIssue == null
                  ? const NeverScrollableScrollPhysics()
                  : const ClampingScrollPhysics()
            : const AlwaysScrollableScrollPhysics(
                parent: ClampingScrollPhysics(),
              ),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: SizedBox(
              height: NotificationPageHeader.bodyTopInset(context),
            ),
          ),
          if (showCenteredEmptyState)
            SliverPadding(
              padding: EdgeInsets.only(
                bottom: NotificationPageHeader.bodyBottomInset(context),
              ),
              sliver: SliverFillRemaining(
                hasScrollBody: false,
                child: NotificationEmptyStateViewport(
                  header: Text(
                    S.of(context).notificationsAlertsDescription,
                    style: context.notificationSectionDescription,
                  ),
                  emptyState: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: MediaQuery.disableAnimationsOf(context)
                        ? Duration.zero
                        : const Duration(milliseconds: 160),
                    curve: Curves.easeOut,
                    builder:
                        (BuildContext context, double opacity, Widget? child) =>
                            Opacity(opacity: opacity, child: child),
                    child: NotificationEmptyState(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      icon: Icons.notifications_none_outlined,
                      title: S.of(context).notificationsAlertsEmptyTitle,
                      description: S.of(context).notificationsAlertsEmpty,
                    ),
                  ),
                ),
              ),
            )
          else ...<Widget>[
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: Text(
                  S.of(context).notificationsAlertsDescription,
                  style: context.notificationSectionDescription,
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            if (healthIssue != null) ...<Widget>[
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverToBoxAdapter(
                  child: NotificationListenerHealthCard(
                    issue: healthIssue,
                    isBusy: _healthViewModel!.isBusy,
                    onRetry: _retryNotificationProcessing,
                    onAcknowledge: _acknowledgeNotificationRecovery,
                    onReviewSetup: _reviewNotificationSetup,
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
            ] else if (_healthViewModel?.error != null) ...<Widget>[
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverToBoxAdapter(
                  child: MessageStatusCard(
                    status: MessageStatus.error,
                    message: S.of(context).notificationsHealthStatusLoadFailure,
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
            ],
            ..._alertsContent(context),
          ],
        ],
      ),
    );
  }

  List<Widget> _alertsContent(BuildContext context) {
    if (_viewModel.isLoading) {
      return const <Widget>[
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(child: CircularProgressIndicator()),
        ),
      ];
    }

    if (_viewModel.error != null) {
      return <Widget>[
        SliverPadding(
          padding: EdgeInsets.only(
            bottom: NotificationPageHeader.bodyBottomInset(context),
          ),
          sliver: SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Text(S.of(context).notificationsAlertsLoadFailure),
            ),
          ),
        ),
      ];
    }

    final List<NotificationAlertGroup> visibleGroups = _displayedGroups;
    if (visibleGroups.isEmpty) {
      return <Widget>[
        SliverPadding(
          padding: EdgeInsets.only(
            bottom: NotificationPageHeader.bodyBottomInset(context),
          ),
          sliver: SliverFillRemaining(
            hasScrollBody: false,
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 1),
              duration: MediaQuery.disableAnimationsOf(context)
                  ? Duration.zero
                  : const Duration(milliseconds: 160),
              curve: Curves.easeOut,
              builder: (BuildContext context, double opacity, Widget? child) =>
                  Opacity(opacity: opacity, child: child),
              child: NotificationEmptyState(
                icon: Icons.notifications_none_outlined,
                title: S.of(context).notificationsAlertsEmptyTitle,
                description: S.of(context).notificationsAlertsEmpty,
              ),
            ),
          ),
        ),
      ];
    }
    return <Widget>[
      SliverPadding(
        padding: EdgeInsets.fromLTRB(
          16,
          0,
          16,
          NotificationPageHeader.bodyBottomInset(context),
        ),
        sliver: SliverList.builder(
          itemCount: visibleGroups.length,
          itemBuilder: (BuildContext context, int index) {
            final NotificationAlertGroup group = visibleGroups[index];
            final NotificationAlert navigationAlert = group.alerts.firstWhere(
              _canOpenDefinition,
              orElse: () => group.primaryAlert,
            );
            final bool opensRule =
                group.alerts.length == 1 && _canOpenRule(group.alerts.single);
            return KeyedSubtree(
              key: _alertKeys.putIfAbsent(group.key, GlobalKey.new),
              child: _AnimatedAlertGroup(
                visible:
                    !_removingGroupKeys.contains(group.key) &&
                    !_enteringGroupKeys.contains(group.key),
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: index == visibleGroups.length - 1 ? 0 : 8,
                  ),
                  child: NotificationAlertCard(
                    alerts: group.alerts,
                    applicationName:
                        _viewModel.applicationNames[group.applicationId],
                    highlighted: _highlightedGroupKey == group.key,
                    onDismiss: _dismissAlert,
                    onDismissAll: () => _dismissGroup(group.alerts),
                    onOpenRule: opensRule
                        ? () => _navigation!.openRuleFromAlert(
                            context,
                            group.alerts.single,
                          )
                        : null,
                    onOpenDefinition:
                        !opensRule && _canOpenDefinition(navigationAlert)
                        ? () => _openDefinition(context, navigationAlert)
                        : null,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ];
  }

  Future<void> _refresh() async {
    await Future.wait(<Future<void>>[
      _viewModel.refresh(),
      if (_healthViewModel != null) _healthViewModel!.load(),
    ]);
  }

  Future<void> _retryNotificationProcessing() async {
    await runNotificationListenerHealthAction(
      context: context,
      action: _healthViewModel!.retry,
      failureMessage: S.of(context).notificationsHealthRetryFailure,
    );
  }

  Future<void> _acknowledgeNotificationRecovery() async {
    await runNotificationListenerHealthAction(
      context: context,
      action: _healthViewModel!.acknowledge,
      failureMessage: S.of(context).notificationsHealthDismissFailure,
    );
  }

  void _reviewNotificationSetup() {
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (BuildContext context) =>
            const NotificationDefinitionsPage(showAppBar: true),
      ),
    );
  }

  bool _canOpenRule(NotificationAlert alert) =>
      _navigation != null &&
      alert.definitionId != null &&
      (alert.ruleId != null || alert.ruleName != null);

  bool _canOpenDefinition(NotificationAlert alert) =>
      _navigation != null &&
      (alert.definitionId != null || alert.applicationId != null);

  Future<void> _dismissAlert(NotificationAlert alert) => _dismiss(alert);

  void _revealInitialAlert() {
    final String? fingerprint = widget.initialAlertFingerprint;
    if (_revealedInitialAlert || fingerprint == null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final NotificationAlertGroup? group = _viewModel.visibleAlertGroups
          .where(
            (NotificationAlertGroup candidate) =>
                candidate.containsFingerprint(fingerprint),
          )
          .firstOrNull;
      if (group == null) return;
      final BuildContext? target = _alertKeys[group.key]?.currentContext;
      if (!mounted || target == null) return;
      _revealedInitialAlert = true;
      setState(() => _highlightedGroupKey = group.key);
      Scrollable.ensureVisible(
        target,
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeInOut,
        alignment: 0.2,
      );
      _highlightTimer = Timer(const Duration(milliseconds: 2500), () {
        if (mounted) setState(() => _highlightedGroupKey = null);
      });
    });
  }

  Future<void> _dismiss(NotificationAlert alert) async {
    final DismissNotificationAlertsResult result = await _viewModel.dismiss(
      alert,
    );
    if (!result.succeeded) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).notificationsAlertsDismissFailure),
          ),
        );
      }
      return;
    }
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: _dismissUndoDuration,
          persist: false,
          content: Text(S.of(context).notificationsAlertsDismissed),
          action: SnackBarAction(
            label: S.of(context).notificationsAlertsUndo,
            onPressed: () => _restore(alert),
          ),
        ),
      );
    }
  }

  Future<void> _dismissAll(List<NotificationAlert> alerts) async {
    final bool? confirmed = await showNotificationDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(S.of(context).notificationsAlertsDismissAllTitle),
        content: Text(
          S.of(context).notificationsAlertsDismissAllDescription(alerts.length),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(S.of(context).notificationsAlertsDismissAll),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    _staggerGroupRemovals = true;
    try {
      await _dismissAlerts(alerts);
    } finally {
      _staggerGroupRemovals = false;
    }
  }

  Future<void> _dismissGroup(List<NotificationAlert> alerts) =>
      _dismissAlerts(alerts);

  Future<void> _dismissAlerts(List<NotificationAlert> alerts) async {
    final DismissNotificationAlertsResult result = await _viewModel.dismissAll(
      alerts,
    );
    final List<NotificationAlert> dismissedAlerts = result.completed;
    if (!mounted) return;
    if (dismissedAlerts.isEmpty) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: _dismissUndoDuration,
        persist: false,
        content: Text(
          !result.succeeded
              ? S
                    .of(context)
                    .notificationsAlertsPartiallyDismissed(
                      dismissedAlerts.length,
                      alerts.length,
                    )
              : S
                    .of(context)
                    .notificationsAlertsDismissedCount(dismissedAlerts.length),
        ),
        action: SnackBarAction(
          label: S.of(context).notificationsAlertsUndo,
          onPressed: () => _restoreAll(dismissedAlerts),
        ),
      ),
    );
  }

  Future<void> _restoreAll(List<NotificationAlert> alerts) async {
    _staggerGroupInsertions = true;
    late final DismissNotificationAlertsResult result;
    try {
      result = await _viewModel.restore(alerts);
    } finally {
      _staggerGroupInsertions = false;
    }
    final List<NotificationAlert> restoredAlerts = result.completed;
    if (mounted) {
      if (!result.succeeded) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              S
                  .of(context)
                  .notificationsAlertsPartiallyRestored(
                    restoredAlerts.length,
                    alerts.length,
                  ),
            ),
          ),
        );
      }
    }
  }

  Future<void> _restore(NotificationAlert alert) async {
    final DismissNotificationAlertsResult result = await _viewModel.restore(
      <NotificationAlert>[alert],
    );
    if (!result.succeeded) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).notificationsAlertsRestoreFailure),
          ),
        );
      }
      return;
    }
  }

  Future<void> _openDefinition(
    BuildContext context,
    NotificationAlert alert,
  ) async {
    await _navigation!.openDefinitionFromAlert(context, alert);
    if (mounted) {
      await _viewModel.refresh();
    }
  }

  void _syncDisplayedGroups() {
    final List<NotificationAlertGroup> target = _viewModel.visibleAlertGroups;
    if (!_groupsInitialized) {
      if (_viewModel.isLoading) return;
      _displayedGroups
        ..clear()
        ..addAll(target);
      _groupsInitialized = true;
      return;
    }

    final Map<String, NotificationAlertGroup> targetByKey =
        <String, NotificationAlertGroup>{
          for (final NotificationAlertGroup group in target) group.key: group,
        };
    final List<NotificationAlertGroup> removed = _displayedGroups
        .where(
          (NotificationAlertGroup group) =>
              !targetByKey.containsKey(group.key) &&
              !_removingGroupKeys.contains(group.key),
        )
        .toList();
    for (final (int index, NotificationAlertGroup group) in removed.indexed) {
      _startGroupRemoval(
        group.key,
        _staggerGroupRemovals ? _groupStagger * index : Duration.zero,
      );
    }

    for (int index = 0; index < _displayedGroups.length; index++) {
      final NotificationAlertGroup? updated =
          targetByKey[_displayedGroups[index].key];
      if (updated != null) {
        _displayedGroups[index] = updated;
        _cancelGroupRemoval(updated.key);
      }
    }

    final Set<String> displayedKeys = _displayedGroups
        .map((NotificationAlertGroup group) => group.key)
        .toSet();
    int insertedCount = 0;
    for (int index = 0; index < target.length; index++) {
      final NotificationAlertGroup group = target[index];
      if (displayedKeys.contains(group.key)) continue;
      final int insertionIndex = index.clamp(0, _displayedGroups.length);
      _displayedGroups.insert(insertionIndex, group);
      displayedKeys.add(group.key);
      _enteringGroupKeys.add(group.key);
      final Duration delay = _staggerGroupInsertions
          ? _groupStagger * insertedCount++
          : Duration.zero;
      _startGroupInsertion(group.key, delay);
    }
  }

  void _startGroupRemoval(String key, Duration delay) {
    final bool disableAnimations = MediaQuery.disableAnimationsOf(context);
    _groupAnimationTimers.remove(key)?.cancel();
    _groupAnimationTimers[key] = Timer(
      disableAnimations ? Duration.zero : delay,
      () {
        if (!mounted ||
            _viewModel.visibleAlertGroups.any(
              (NotificationAlertGroup group) => group.key == key,
            )) {
          return;
        }
        setState(() => _removingGroupKeys.add(key));
        _groupAnimationTimers[key] = Timer(
          disableAnimations ? Duration.zero : _groupAnimationDuration,
          () {
            if (!mounted ||
                _viewModel.visibleAlertGroups.any(
                  (NotificationAlertGroup group) => group.key == key,
                )) {
              return;
            }
            setState(() {
              _displayedGroups.removeWhere(
                (NotificationAlertGroup group) => group.key == key,
              );
              _removingGroupKeys.remove(key);
              _alertKeys.remove(key);
            });
            _groupAnimationTimers.remove(key);
          },
        );
      },
    );
  }

  void _cancelGroupRemoval(String key) {
    _groupAnimationTimers.remove(key)?.cancel();
    _removingGroupKeys.remove(key);
  }

  void _startGroupInsertion(String key, Duration delay) {
    final bool disableAnimations = MediaQuery.disableAnimationsOf(context);
    _groupAnimationTimers.remove(key)?.cancel();
    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      if (!mounted || !_enteringGroupKeys.contains(key)) return;
      _groupAnimationTimers[key] = Timer(
        disableAnimations ? Duration.zero : delay,
        () {
          if (!mounted) return;
          setState(() => _enteringGroupKeys.remove(key));
          _groupAnimationTimers.remove(key);
        },
      );
    });
  }
}

class _AnimatedAlertGroup extends StatelessWidget {
  const _AnimatedAlertGroup({required this.visible, required this.child});

  final bool visible;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bool disableAnimations = MediaQuery.disableAnimationsOf(context);
    final Duration sizeDuration = disableAnimations
        ? Duration.zero
        : const Duration(milliseconds: 220);
    final Duration fadeDuration = disableAnimations
        ? Duration.zero
        : const Duration(milliseconds: 160);
    return ClipRect(
      child: AnimatedAlign(
        duration: sizeDuration,
        curve: Curves.easeInOut,
        alignment: Alignment.topCenter,
        heightFactor: visible ? 1 : 0,
        child: AnimatedOpacity(
          duration: fadeDuration,
          curve: visible ? Curves.easeOut : Curves.easeIn,
          opacity: visible ? 1 : 0,
          child: AnimatedScale(
            duration: fadeDuration,
            curve: Curves.easeInOut,
            scale: visible ? 1 : 0.98,
            alignment: Alignment.topCenter,
            child: child,
          ),
        ),
      ),
    );
  }
}
