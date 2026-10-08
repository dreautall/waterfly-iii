import 'package:appcheck/appcheck.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/application/listeners/notification_access_settings_launcher.dart';
import 'package:waterflyiii/notifications/application/stores/notification_alert_store.dart';
import 'package:waterflyiii/notifications/application/definitions/save_notification_definition.dart';
import 'package:waterflyiii/notifications/application/stores/notification_definition_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_history_store.dart';
import 'package:waterflyiii/notifications/application/listeners/notification_listener_status.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/listeners/notification_listener_health_issue.dart';
import 'package:waterflyiii/notifications/notification_feature_scope.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/applications/notification_application_selector_dialog.dart';
import 'package:waterflyiii/notifications/presentation/definitions/widgets/notification_definition_card.dart';
import 'package:waterflyiii/notifications/presentation/definitions/pages/notification_definition_details_page.dart';
import 'package:waterflyiii/notifications/presentation/definitions/controllers/notification_definitions_view_model.dart';
import 'package:waterflyiii/notifications/presentation/navigation/notification_page_menu.dart';
import 'package:waterflyiii/notifications/presentation/health/controllers/notification_listener_health_view_model.dart';
import 'package:waterflyiii/notifications/presentation/health/notification_listener_health_actions.dart';
import 'package:waterflyiii/notifications/presentation/health/widgets/notification_listener_health_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_card_theme.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_dialog.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_empty_state.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_menu_theme.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_page_header.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';
import 'package:waterflyiii/notifications/presentation/shared/message_status_card.dart';

typedef NotificationApplicationSelector =
    Future<AppInfo?> Function(
      BuildContext context,
      Set<String> excludedPackageIds,
      NotificationApplicationSelectionMode mode,
    );

class NotificationDefinitionsPage extends StatefulWidget {
  const NotificationDefinitionsPage({
    super.key,
    this.store,
    this.alertStore,
    this.historyStore,
    this.statusLoader,
    this.accessSettingsLauncher,
    this.healthViewModel,
    this.applicationSelector,
    this.showAppBar = false,
  });

  final NotificationDefinitionStore? store;
  final NotificationAlertStore? alertStore;
  final NotificationHistoryStore? historyStore;
  final NotificationListenerStatusLoader? statusLoader;
  final NotificationAccessSettingsLauncher? accessSettingsLauncher;
  final NotificationListenerHealthViewModel? healthViewModel;
  final NotificationApplicationSelector? applicationSelector;
  final bool showAppBar;

  @override
  State<NotificationDefinitionsPage> createState() =>
      _NotificationDefinitionsPageState();
}

class _NotificationDefinitionsPageState
    extends State<NotificationDefinitionsPage>
    with WidgetsBindingObserver {
  late final NotificationDefinitionsViewModel _viewModel;
  bool _ownsViewModel = false;
  late final NotificationListenerStatusLoader _statusLoader;
  late Future<NotificationListenerStatus> _status;
  bool? _hasNotificationAccess;
  late final NotificationAccessSettingsLauncher _accessSettingsLauncher;
  NotificationListenerHealthViewModel? _healthViewModel;
  NotificationHistoryStore? _historyStore;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _scrollController = ScrollController();
    final NotificationFeatureScope? scope = context
        .read<NotificationFeatureScope?>();
    _historyStore = widget.historyStore ?? scope?.historyStore;
    _healthViewModel = widget.healthViewModel ?? scope?.healthViewModel;
    if (widget.store == null && scope != null) {
      _viewModel = scope.definitionsViewModel;
    } else {
      final NotificationDefinitionStore store = widget.store!;
      _viewModel = NotificationDefinitionsViewModel(
        store,
        SaveNotificationDefinition(
          store,
          alertStore: widget.alertStore,
          historyStore: widget.historyStore,
        ),
        alertStore: widget.alertStore,
      );
      _ownsViewModel = true;
    }
    _viewModel.addListener(_onViewModelChanged);
    _healthViewModel?.addListener(_onViewModelChanged);
    _statusLoader =
        widget.statusLoader ??
        scope?.listenerStatusLoader ??
        const UnavailableNotificationListenerStatusLoader();
    _status = _loadStatus();
    _accessSettingsLauncher =
        widget.accessSettingsLauncher ??
        scope?.accessSettingsLauncher ??
        const UnavailableNotificationAccessSettingsLauncher();
    _load();
    _healthViewModel?.load();
  }

  Future<void> _load() async {
    await _viewModel.load();
  }

  void _onViewModelChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshStatus();
    }
  }

  void _refreshStatus() {
    if (!mounted) return;
    setState(() {
      _status = _loadStatus();
    });
  }

  Future<NotificationListenerStatus> _loadStatus() async {
    final NotificationListenerStatus status = await _statusLoader.load();
    final bool hasNotificationAccess =
        status.servicePermission && status.notificationPermission;
    if (mounted && _hasNotificationAccess != hasNotificationAccess) {
      setState(() {
        _hasNotificationAccess = hasNotificationAccess;
      });
    }
    return status;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _viewModel.removeListener(_onViewModelChanged);
    _healthViewModel?.removeListener(_onViewModelChanged);
    _scrollController.dispose();
    if (_ownsViewModel) {
      _viewModel.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NotificationListenerHealthIssue? healthIssue =
        _healthViewModel?.issue;
    final bool showEmptyState =
        !_viewModel.isLoading &&
        _viewModel.error == null &&
        _viewModel.definitions.isEmpty;
    final double topInset = widget.showAppBar
        ? NotificationPageHeader.bodyTopInset(context)
        : 0;
    final double bottomInset = NotificationPageHeader.bodyBottomInset(
      context,
      spacing: 24,
    );
    final Widget content = SafeArea(
      top: !widget.showAppBar,
      bottom: false,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(overscroll: false),
        child: CustomScrollView(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          slivers: <Widget>[
            SliverPadding(
              padding: EdgeInsets.fromLTRB(16, topInset, 16, 0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  Text(S.of(context).settingsNLDescription),
                  const SizedBox(height: 24),
                  _NotificationServiceStatus(
                    status: _status,
                    onOpenSettings: _openNotificationAccessSettings,
                  ),
                  if (_healthViewModel?.issue != null ||
                      _healthViewModel?.error != null) ...<Widget>[
                    const SizedBox(height: 12),
                    if (healthIssue != null)
                      NotificationListenerHealthCard(
                        issue: healthIssue,
                        isBusy: _healthViewModel!.isBusy,
                        onRetry: _retryNotificationProcessing,
                        onAcknowledge: _acknowledgeNotificationRecovery,
                      )
                    else
                      MessageStatusCard(
                        status: MessageStatus.error,
                        message: S
                            .of(context)
                            .notificationsHealthStatusLoadFailure,
                      ),
                  ],
                  if (_viewModel.migrationAlertsError != null) ...<Widget>[
                    const SizedBox(height: 12),
                    MessageStatusCard(
                      status: MessageStatus.error,
                      message: S
                          .of(context)
                          .notificationsDefinitionsMigrationAlertsLoadFailure,
                    ),
                  ],
                  const SizedBox(height: 24),
                  Text(
                    S
                        .of(context)
                        .notificationsDefinitionsRegisteredApplications,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  if (_viewModel.definitions.isNotEmpty) ...<Widget>[
                    const SizedBox(height: 4),
                    Text(
                      S
                          .of(context)
                          .notificationsDefinitionsRegisteredApplicationsDescription,
                      style: context.notificationSectionDescription,
                    ),
                  ],
                  const SizedBox(height: 16),
                ]),
              ),
            ),
            if (showEmptyState)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, bottomInset),
                  child: _emptyDefinitionState(context),
                ),
              )
            else
              SliverPadding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, bottomInset),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(<Widget>[
                    ..._definitionContent(context),
                    if (_viewModel.definitions.isNotEmpty)
                      ElevatedButton.icon(
                        key: const Key('add-notification-application'),
                        onPressed: _viewModel.isLoading || _viewModel.isMutating
                            ? null
                            : _addApplication,
                        icon: const Icon(Icons.add),
                        label: Text(
                          S.of(context).notificationsDefinitionsAddApplication,
                        ),
                      ),
                  ]),
                ),
              ),
          ],
        ),
      ),
    );
    if (!widget.showAppBar) {
      return NotificationMenuTheme(child: content);
    }
    return NotificationMenuTheme(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: NotificationPageHeader(
          scrollController: _scrollController,
          title: Text(S.of(context).settingsNotificationListener),
          actions: <Widget>[
            if (widget.store == null ||
                context.read<NotificationFeatureScope?>() != null)
              NotificationPageMenu(onPageClosed: _load),
          ],
        ),
        body: content,
      ),
    );
  }

  List<Widget> _definitionContent(BuildContext context) {
    if (_viewModel.isLoading && _viewModel.definitions.isEmpty) {
      return const <Widget>[
        Center(child: CircularProgressIndicator()),
        SizedBox(height: 8),
      ];
    }
    if (_viewModel.error != null) {
      return <Widget>[
        MessageStatusCard(
          status: MessageStatus.error,
          message: S.of(context).notificationsDefinitionsLoadFailure,
        ),
        const SizedBox(height: 8),
      ];
    }
    return <Widget>[
      for (final NotificationDefinition definition
          in _viewModel.definitions) ...<Widget>[
        NotificationDefinitionCard(
          definition: definition,
          migrationAlerts: _viewModel.migrationAlertsFor(definition),
          onTap: _viewModel.isMutating
              ? null
              : () => _openDefinition(definition),
        ),
        const SizedBox(height: 8),
      ],
    ];
  }

  Widget _emptyDefinitionState(BuildContext context) => NotificationEmptyState(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    contentAlignment: const Alignment(0, -0.5),
    icon: Icons.notifications_none_outlined,
    title: S.of(context).notificationsDefinitionsEmptyTitle,
    description: _hasNotificationAccess == false
        ? S.of(context).notificationsDefinitionsEmptyDescriptionAccessNeeded
        : S.of(context).notificationsDefinitionsEmptyDescription,
    action: FilledButton.tonalIcon(
      key: const Key('add-notification-application'),
      onPressed: _viewModel.isMutating ? null : _addApplication,
      icon: const Icon(Icons.add),
      label: Text(S.of(context).notificationsDefinitionsAddApplication),
    ),
  );

  Future<void> _addApplication() async {
    final AppInfo? application = await _selectApplication(
      _viewModel.definitions
          .map((NotificationDefinition definition) => definition.applicationId)
          .toSet(),
      NotificationApplicationSelectionMode.add,
    );
    if (application == null || !mounted) {
      return;
    }
    final SaveNotificationDefinitionResult result = await _viewModel
        .addApplication(
          applicationId: application.packageName,
          applicationName: application.appName ?? application.packageName,
        );
    if (!mounted) {
      return;
    }
    if (!result.succeeded) {
      if (result.status == SaveNotificationDefinitionStatus.duplicate) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).notificationsDefinitionsDuplicate),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).notificationsDefinitionsSaveFailure),
          ),
        );
      }
      return;
    }
    await _editDefinition(result.definition!);
  }

  Future<void> _openDefinition(NotificationDefinition definition) async {
    NotificationDefinition definitionToOpen = definition;
    if (_isUnknownApplication(definition)) {
      final AppInfo? application = await _selectApplication(
        _viewModel.definitions
            .where(
              (NotificationDefinition candidate) =>
                  candidate.id != definition.id,
            )
            .map((NotificationDefinition candidate) => candidate.applicationId)
            .toSet(),
        NotificationApplicationSelectionMode.recover,
      );
      if (application == null || !mounted) return;
      final SaveNotificationDefinitionResult result = await _viewModel.update(
        definition.copyWith(
          applicationId: application.packageName,
          name: application.appName ?? application.packageName,
        ),
      );
      if (!mounted) return;
      if (!result.succeeded) {
        _showSaveFailure(result);
        return;
      }
      definitionToOpen = result.definition!;
    }
    await _editDefinition(definitionToOpen);
  }

  bool _isUnknownApplication(NotificationDefinition definition) {
    final String name = definition.name.trim();
    return name.isEmpty || name == definition.applicationId;
  }

  Future<AppInfo?> _selectApplication(
    Set<String> excludedPackageIds,
    NotificationApplicationSelectionMode mode,
  ) {
    final NotificationApplicationSelector? selector =
        widget.applicationSelector;
    if (selector != null) {
      return selector(context, excludedPackageIds, mode);
    }
    return showNotificationDialog<AppInfo>(
      context: context,
      builder: (BuildContext context) => NotificationApplicationSelectorDialog(
        historyStore: _historyStore,
        excludedPackageIds: excludedPackageIds,
        mode: mode,
      ),
    );
  }

  void _showSaveFailure(SaveNotificationDefinitionResult result) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          result.status == SaveNotificationDefinitionStatus.duplicate
              ? S.of(context).notificationsDefinitionsDuplicate
              : S.of(context).notificationsDefinitionsSaveFailure,
        ),
      ),
    );
  }

  Future<bool> _confirmDeleteDefinition(
    NotificationDefinition definition,
  ) async {
    final bool? isConfirmed = await showNotificationDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Row(
          children: <Widget>[
            const Icon(Icons.delete_outline),
            const SizedBox(width: 12),
            Expanded(
              child: Text(S.of(context).notificationsDefinitionsDeleteTitle),
            ),
          ],
        ),
        content: Text(
          S
              .of(context)
              .notificationsDefinitionsDeleteDescription(definition.name),
        ),
        actions: <Widget>[
          TextButton(
            autofocus: true,
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: Text(S.of(context).notificationsDefinitionDelete),
          ),
        ],
      ),
    );
    if (isConfirmed != true) {
      return false;
    }
    final SaveNotificationDefinitionResult result = await _viewModel.delete(
      definition.id,
    );
    if (result.succeeded) {
      return true;
    }
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).notificationsDefinitionDeleteFailure),
        ),
      );
    }
    return false;
  }

  Future<void> _editDefinition(NotificationDefinition definition) async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => NotificationDefinitionDetailsPage(
          definition: definition,
          migrationAlerts: _viewModel.migrationAlertsFor(definition),
          onSave: (NotificationDefinition updated) async =>
              (await _viewModel.update(updated)).succeeded,
          onDelete: () => _confirmDeleteDefinition(definition),
        ),
      ),
    );
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _openNotificationAccessSettings() async {
    final bool opened = await _accessSettingsLauncher
        .openNotificationAccessSettings();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          opened
              ? S.of(context).notificationsProcessingAccessSettingsOpened
              : S.of(context).notificationsProcessingAccessSettingsOpenFailure,
        ),
      ),
    );
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
}

class _NotificationServiceStatus extends StatelessWidget {
  const _NotificationServiceStatus({
    required this.status,
    required this.onOpenSettings,
  });

  final Future<NotificationListenerStatus> status;
  final Future<void> Function() onOpenSettings;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NotificationListenerStatus>(
      future: status,
      builder:
          (
            BuildContext context,
            AsyncSnapshot<NotificationListenerStatus> snapshot,
          ) {
            final _ServiceStatusVisual visual;
            if (snapshot.connectionState != ConnectionState.done) {
              visual = _ServiceStatusVisual(
                icon: Icons.pending_outlined,
                iconColor: Theme.of(context).colorScheme.onSurfaceVariant,
                iconBackground: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest,
                title: S.of(context).settingsNLServiceCheckingTitle,
                subtitle: S.of(context).settingsNLServiceChecking,
              );
            } else if (snapshot.hasError) {
              visual = _ServiceStatusVisual(
                icon: Icons.error_outline,
                iconColor: Theme.of(context).colorScheme.onErrorContainer,
                iconBackground: Theme.of(context).colorScheme.errorContainer,
                title: S.of(context).settingsNLServiceUnavailableTitle,
                subtitle: S
                    .of(context)
                    .settingsNLServiceCheckingError(snapshot.error.toString()),
                actionLabel: S
                    .of(context)
                    .notificationsProcessingOpenAccessSettings,
                onAction: onOpenSettings,
              );
            } else if (!snapshot.data!.servicePermission ||
                !snapshot.data!.notificationPermission) {
              visual = _ServiceStatusVisual(
                icon: Icons.notifications_off_outlined,
                iconColor: Theme.of(context).colorScheme.onErrorContainer,
                iconBackground: Theme.of(context).colorScheme.errorContainer,
                title: S.of(context).settingsNLAccessNeededTitle,
                subtitle: S.of(context).settingsNLAccessNeededDescription,
                actionLabel: S
                    .of(context)
                    .notificationsProcessingOpenAccessSettings,
                onAction: onOpenSettings,
              );
            } else if (!snapshot.data!.serviceRunning) {
              visual = _ServiceStatusVisual(
                icon: Icons.pause_circle_outline,
                iconColor: Theme.of(context).colorScheme.onTertiaryContainer,
                iconBackground: Theme.of(context).colorScheme.tertiaryContainer,
                title: S.of(context).settingsNLListenerStoppedTitle,
                subtitle: S.of(context).settingsNLListenerStoppedDescription,
                actionLabel: S
                    .of(context)
                    .notificationsProcessingOpenAccessSettings,
                onAction: onOpenSettings,
              );
            } else {
              visual = _ServiceStatusVisual(
                icon: Icons.check_rounded,
                iconColor: Theme.of(context).colorScheme.onPrimaryContainer,
                iconBackground: Theme.of(context).colorScheme.primaryContainer,
                title: S.of(context).settingsNLAccessEnabledTitle,
                subtitle: S.of(context).settingsNLAccessEnabledDescription,
              );
            }
            final Widget cardContent = Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: visual.iconBackground,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(visual.icon, color: visual.iconColor, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          visual.title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          visual.subtitle,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: context.notificationSupportingText,
                        ),
                      ],
                    ),
                  ),
                  if (visual.onAction != null) ...<Widget>[
                    const SizedBox(width: 12),
                    ExcludeSemantics(
                      child: Icon(
                        Icons.open_in_new,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            );
            return Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.antiAlias,
              color:
                  Theme.of(
                    context,
                  ).extension<NotificationCardTheme>()?.surfaceColor ??
                  Theme.of(context).colorScheme.surfaceContainerLow,
              child: visual.onAction == null
                  ? cardContent
                  : Semantics(
                      button: true,
                      label:
                          '${visual.title}. ${visual.subtitle} ${visual.actionLabel}',
                      excludeSemantics: true,
                      child: InkWell(
                        key: const Key(
                          'notification-access-settings-card-action',
                        ),
                        onTap: visual.onAction,
                        child: cardContent,
                      ),
                    ),
            );
          },
    );
  }
}

class _ServiceStatusVisual {
  const _ServiceStatusVisual({
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.title,
    required this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String title;
  final String subtitle;
  final String? actionLabel;
  final Future<void> Function()? onAction;
}
