import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/application/stores/notification_alert_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_definition_store.dart';
import 'package:waterflyiii/notifications/application/rules/notification_rule_operations.dart';
import 'package:waterflyiii/notifications/notification_feature_scope.dart';
import 'package:waterflyiii/notifications/presentation/alerts/controllers/notification_alerts_view_model.dart';
import 'package:waterflyiii/notifications/presentation/health/controllers/notification_listener_health_view_model.dart';
import 'package:waterflyiii/notifications/presentation/navigation/notification_navigation_coordinator.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_menu_theme.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_page_header.dart';

class NotificationPageMenu extends StatefulWidget {
  const NotificationPageMenu({
    super.key,
    this.alertStore,
    this.definitionStore,
    this.onPageClosed,
  });

  final NotificationAlertStore? alertStore;
  final NotificationDefinitionStore? definitionStore;
  final Future<void> Function()? onPageClosed;

  @override
  State<NotificationPageMenu> createState() => _NotificationPageMenuState();
}

class _NotificationPageMenuState extends State<NotificationPageMenu> {
  late final NotificationAlertStore _store;
  late final NotificationAlertsViewModel _alertsViewModel;
  late final NotificationFeatureScope? _scope;
  late final NotificationNavigationCoordinator _navigation;
  NotificationListenerHealthViewModel? _healthViewModel;
  bool _ownsAlertsViewModel = false;

  NotificationDefinitionStore get _definitionStore =>
      widget.definitionStore ?? _scope!.definitionStore;

  @override
  void initState() {
    super.initState();
    _scope = context.read<NotificationFeatureScope?>();
    _store = widget.alertStore ?? _scope!.alertStore;
    if (widget.alertStore == null) {
      _alertsViewModel = _scope!.alertsViewModel;
    } else {
      _alertsViewModel = NotificationAlertsViewModel(widget.alertStore!);
      _ownsAlertsViewModel = true;
    }
    final NotificationRuleOperations ruleOperations =
        widget.definitionStore == null
        ? _scope!.ruleOperations
        : NotificationRuleOperations(widget.definitionStore!);
    _navigation = NotificationNavigationCoordinator(
      alertStore: _store,
      definitionStore: _definitionStore,
      ruleOperations: ruleOperations,
      scope: _scope,
    );
    _healthViewModel = _scope?.healthViewModel;
    _alertsViewModel.addListener(_onAlertsChanged);
    _healthViewModel?.addListener(_onAlertsChanged);
    _alertsViewModel.load();
  }

  void _onAlertsChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _alertsViewModel.removeListener(_onAlertsChanged);
    _healthViewModel?.removeListener(_onAlertsChanged);
    if (_ownsAlertsViewModel) _alertsViewModel.dispose();
    super.dispose();
  }

  Future<void> _openPage(_NotificationPageMenuAction action) async {
    switch (action) {
      case _NotificationPageMenuAction.alerts:
        await _navigation.openAlerts(context);
      case _NotificationPageMenuAction.history:
        await _navigation.openHistory(context);
      case _NotificationPageMenuAction.settings:
        await _navigation.openSettings(context);
    }
    if (mounted) {
      await _alertsViewModel.refresh();
      await _healthViewModel?.load();
      await widget.onPageClosed?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final int alertCount = _alertsViewModel.visibleAlerts.length;
    final bool hasActiveHealthIssue =
        _healthViewModel?.issue?.isActive ?? false;
    return NotificationMenuTheme(
      child: PopupMenuButton<_NotificationPageMenuAction>(
        tooltip: S.of(context).notificationsMenuOptions,
        position: PopupMenuPosition.under,
        iconSize: NotificationPageHeader.controlIconSize,
        icon: Badge(
          isLabelVisible: hasActiveHealthIssue || alertCount > 0,
          label: Text(hasActiveHealthIssue ? '!' : '$alertCount'),
          child: const Icon(Icons.more_vert),
        ),
        onSelected: _openPage,
        itemBuilder: (BuildContext context) =>
            <PopupMenuEntry<_NotificationPageMenuAction>>[
              PopupMenuItem<_NotificationPageMenuAction>(
                value: _NotificationPageMenuAction.alerts,
                child: Row(
                  children: <Widget>[
                    Badge(
                      isLabelVisible: alertCount > 0,
                      label: Text('$alertCount'),
                      child: const Icon(Icons.error_outline),
                    ),
                    const SizedBox(width: 12),
                    Text(S.of(context).notificationsMenuAlerts),
                  ],
                ),
              ),
              PopupMenuItem<_NotificationPageMenuAction>(
                value: _NotificationPageMenuAction.history,
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.history),
                    const SizedBox(width: 12),
                    Flexible(
                      child: Text(S.of(context).notificationsHistoryTitle),
                    ),
                  ],
                ),
              ),
              if (_scope != null)
                PopupMenuItem<_NotificationPageMenuAction>(
                  value: _NotificationPageMenuAction.settings,
                  child: Row(
                    children: <Widget>[
                      const Icon(Icons.settings_outlined),
                      const SizedBox(width: 12),
                      Flexible(
                        child: Text(
                          S.of(context).notificationsProcessingSettingsTitle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
      ),
    );
  }
}

enum _NotificationPageMenuAction { alerts, history, settings }
