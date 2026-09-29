import 'package:logging/logging.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/application/history/recent_notification_history.dart';
import 'package:waterflyiii/notifications/application/stores/notification_history_store.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/notification_feature_scope.dart';
import 'package:waterflyiii/notifications/presentation/history/controllers/recent_notifications_view_model.dart';
import 'package:waterflyiii/notifications/presentation/history/recent_notification_actions.dart';
import 'package:waterflyiii/notifications/presentation/history/widgets/recent_notification_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/message_status_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_empty_state.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_dialog.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_menu_theme.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_page_header.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';

export 'package:waterflyiii/notifications/presentation/history/recent_notification_actions.dart';
export 'package:waterflyiii/notifications/presentation/history/widgets/recent_notification_card.dart';

class RecentNotificationsPage extends StatefulWidget {
  const RecentNotificationsPage({
    super.key,
    this.history,
    this.actions,
    this.onCreateRule,
    this.onCreateTransaction,
    this.onEditRule,
    this.onOpenAlert,
    this.onOpenAlerts,
    this.onOpenDefinition,
    this.onOpenTransaction,
  });

  final RecentNotificationHistory? history;
  final RecentNotificationActions? actions;

  // Legacy callbacks remain available while callers migrate to [actions].
  final RecentNotificationEntryResultAction? onCreateRule;
  final RecentNotificationEntryAction? onCreateTransaction;
  final RecentNotificationEntryResultAction? onEditRule;
  final Future<void> Function(NotificationAlert alert)? onOpenAlert;
  final Future<void> Function()? onOpenAlerts;
  final RecentNotificationEntryAction? onOpenDefinition;
  final Future<void> Function(String transactionId)? onOpenTransaction;

  RecentNotificationActions get resolvedActions =>
      actions ??
      RecentNotificationActions(
        createRule: onCreateRule,
        createTransaction: onCreateTransaction,
        editRule: onEditRule,
        openAlert: onOpenAlert,
        openAlerts: onOpenAlerts,
        openDefinition: onOpenDefinition,
        openTransaction: onOpenTransaction,
      );

  @override
  State<RecentNotificationsPage> createState() =>
      _RecentNotificationsPageState();
}

class _RecentNotificationsPageState extends State<RecentNotificationsPage> {
  static const Duration _removeUndoDuration = Duration(seconds: 6);

  static final Logger _log = Logger('Notifications.RecentNotifications');
  late final RecentNotificationsViewModel _viewModel;
  late final RecentNotificationActions _actions;
  final ScrollController _scrollController = ScrollController();
  bool _ownsViewModel = false;
  String? _expandedEntryId;

  @override
  void initState() {
    super.initState();
    final NotificationFeatureScope? scope = context
        .read<NotificationFeatureScope?>();
    final RecentNotificationActions actions = widget.resolvedActions;
    final NotificationHistoryEntryRemovalStore? removalStore =
        scope?.historyStore is NotificationHistoryEntryRemovalStore
        ? scope!.historyStore as NotificationHistoryEntryRemovalStore
        : null;
    final RecentNotificationEntryAction? removeFromHistory =
        actions.removeFromHistory ??
        (removalStore == null
            ? null
            : (RecentNotificationHistoryEntry entry) =>
                  removalStore.remove(entry.notification.id));
    final RecentNotificationEntryAction? restoreToHistory =
        actions.restoreToHistory ??
        (removalStore == null
            ? null
            : (RecentNotificationHistoryEntry entry) =>
                  removalStore.restore(entry.notification));
    _actions = RecentNotificationActions(
      createRule: actions.createRule == null ? null : _createRule,
      createTransaction: actions.createTransaction == null
          ? null
          : _createTransaction,
      editRule: actions.editRule == null ? null : _editRule,
      openAlert: actions.openAlert,
      openAlerts: actions.openAlerts,
      openDefinition: actions.openDefinition == null ? null : _openDefinition,
      openTransaction: actions.openTransaction,
      removeFromHistory: removeFromHistory == null
          ? null
          : (RecentNotificationHistoryEntry entry) =>
                _removeFromHistory(entry, removeFromHistory, restoreToHistory),
      restoreToHistory: restoreToHistory,
    );
    if (widget.history != null) {
      _viewModel = RecentNotificationsViewModel(widget.history!);
      _ownsViewModel = true;
    } else {
      _viewModel = scope!.recentNotificationsViewModel;
    }
    _viewModel.addListener(_onViewModelChanged);
    _viewModel.load();
  }

  void _onViewModelChanged() {
    if (mounted) setState(() {});
  }

  Future<bool> _createRule(RecentNotificationHistoryEntry entry) async {
    final bool created = await widget.resolvedActions.createRule!(entry);
    if (created && mounted) await _viewModel.refresh();
    return created;
  }

  Future<bool> _editRule(RecentNotificationHistoryEntry entry) async {
    final bool changed = await widget.resolvedActions.editRule!(entry);
    if (changed && mounted) await _viewModel.refresh();
    return changed;
  }

  Future<void> _createTransaction(RecentNotificationHistoryEntry entry) async {
    await widget.resolvedActions.createTransaction!(entry);
    if (mounted) await _viewModel.refresh();
  }

  Future<void> _openDefinition(RecentNotificationHistoryEntry entry) async {
    await widget.resolvedActions.openDefinition!(entry);
    if (mounted) await _viewModel.refresh();
  }

  Future<void> _removeFromHistory(
    RecentNotificationHistoryEntry entry,
    RecentNotificationEntryAction remove,
    RecentNotificationEntryAction? restore,
  ) async {
    final bool confirmed =
        await showNotificationDialog<bool>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(S.of(context).notificationsHistoryRemoveTitle),
            content: Text(S.of(context).notificationsHistoryRemoveConfirm),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  MaterialLocalizations.of(context).cancelButtonLabel,
                ),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(
                  S.of(context).notificationsHistoryRemoveFromHistory,
                ),
              ),
            ],
          ),
        ) ??
        false;
    if (!confirmed) return;
    try {
      await remove(entry);
      if (!mounted) return;
      if (_expandedEntryId == entry.notification.id) {
        _expandedEntryId = null;
      }
      await _viewModel.refresh();
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            duration: _removeUndoDuration,
            persist: false,
            content: Text(S.of(context).notificationsHistoryRemoved),
            action: restore == null
                ? null
                : SnackBarAction(
                    label: S.of(context).notificationsHistoryUndo,
                    onPressed: () => _restoreToHistory(entry, restore),
                  ),
          ),
        );
    } catch (error, stackTrace) {
      _log.warning(
        'Could not remove recent notification history entry.',
        error,
        stackTrace,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(S.of(context).notificationsHistoryRemoveFailure),
          ),
        );
    }
  }

  Future<void> _restoreToHistory(
    RecentNotificationHistoryEntry entry,
    RecentNotificationEntryAction restore,
  ) async {
    try {
      await restore(entry);
      if (mounted) await _viewModel.refresh();
    } catch (error, stackTrace) {
      _log.warning(
        'Could not restore recent notification history entry.',
        error,
        stackTrace,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).notificationsHistoryRestoreFailure),
        ),
      );
    }
  }

  void _setExpandedEntry(String entryId, bool expanded) {
    setState(() {
      _expandedEntryId = expanded ? entryId : null;
    });
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelChanged);
    if (_ownsViewModel) _viewModel.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationMenuTheme(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: NotificationPageHeader(
          scrollController: _scrollController,
          title: Text(S.of(context).notificationsHistoryTitle),
        ),
        body: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    final bool showCenteredEmptyState =
        !_viewModel.isLoading &&
        _viewModel.error == null &&
        _viewModel.entries.isEmpty;
    return CustomScrollView(
      controller: _scrollController,
      physics: showCenteredEmptyState
          ? const NeverScrollableScrollPhysics()
          : const ClampingScrollPhysics(),
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: SizedBox(height: NotificationPageHeader.bodyTopInset(context)),
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
                  S.of(context).notificationsHistoryDescription,
                  style: context.notificationSectionDescription,
                ),
                emptyState: NotificationEmptyState(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  icon: Icons.history_outlined,
                  title: S.of(context).notificationsHistoryEmptyTitle,
                  description: S
                      .of(context)
                      .notificationsHistoryEmptyDescription,
                ),
              ),
            ),
          )
        else ...<Widget>[
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Text(
                S.of(context).notificationsHistoryDescription,
                style: context.notificationSectionDescription,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          ..._historyContent(context),
        ],
      ],
    );
  }

  List<Widget> _historyContent(BuildContext context) {
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
          padding: EdgeInsets.fromLTRB(
            16,
            0,
            16,
            NotificationPageHeader.bodyBottomInset(context),
          ),
          sliver: SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.topCenter,
              child: MessageStatusCard(
                status: MessageStatus.error,
                message: S.of(context).notificationsHistoryLoadFailure,
              ),
            ),
          ),
        ),
      ];
    }
    final List<RecentNotificationHistoryEntry> entries = _viewModel.entries;
    if (entries.isEmpty) {
      return <Widget>[
        SliverPadding(
          padding: EdgeInsets.only(
            bottom: NotificationPageHeader.bodyBottomInset(context),
          ),
          sliver: SliverFillRemaining(
            hasScrollBody: false,
            child: NotificationEmptyState(
              icon: Icons.history_outlined,
              title: S.of(context).notificationsHistoryEmptyTitle,
              description: S.of(context).notificationsHistoryEmptyDescription,
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
          itemCount: entries.length * 2 - 1,
          itemBuilder: (BuildContext context, int index) {
            if (index.isOdd) return const SizedBox(height: 8);
            final RecentNotificationHistoryEntry entry = entries[index ~/ 2];
            return RecentNotificationCard(
              key: ValueKey<String>(entry.notification.id),
              entry: entry,
              expanded: _expandedEntryId == entry.notification.id,
              onExpansionChanged: (bool expanded) =>
                  _setExpandedEntry(entry.notification.id, expanded),
              actions: _actions,
            );
          },
        ),
      ),
    ];
  }
}
