import 'dart:async';

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
    this.onTransactionExists,
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
  final NotificationTransactionAvailabilityLoader? onTransactionExists;

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
        transactionExists: onTransactionExists,
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
  bool _isRefreshing = false;
  int _refreshAnimationGeneration = 0;
  String? _expandedEntryId;
  NotificationHistoryTransactionUnlinker? _unlinkTransaction;

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
    final NotificationHistoryTransactionLinkStore? transactionLinkStore =
        scope?.historyStore is NotificationHistoryTransactionLinkStore
        ? scope!.historyStore as NotificationHistoryTransactionLinkStore
        : null;
    _unlinkTransaction =
        actions.unlinkTransaction ?? transactionLinkStore?.unlinkTransaction;
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
      openTransaction: actions.openTransaction == null
          ? null
          : _openTransaction,
      transactionExists: actions.transactionExists,
      unlinkTransaction: _unlinkTransaction,
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
    unawaited(_loadHistory(initial: true));
  }

  void _onViewModelChanged() {
    if (mounted) setState(() {});
  }

  Future<bool> _createRule(RecentNotificationHistoryEntry entry) async {
    final bool created = await widget.resolvedActions.createRule!(entry);
    if (created && mounted) await _refreshHistory();
    return created;
  }

  Future<bool> _editRule(RecentNotificationHistoryEntry entry) async {
    final bool changed = await widget.resolvedActions.editRule!(entry);
    if (changed && mounted) await _refreshHistory();
    return changed;
  }

  Future<void> _createTransaction(RecentNotificationHistoryEntry entry) async {
    await widget.resolvedActions.createTransaction!(entry);
    if (mounted) await _refreshHistory();
  }

  Future<void> _openDefinition(RecentNotificationHistoryEntry entry) async {
    await widget.resolvedActions.openDefinition!(entry);
    if (mounted) await _refreshHistory();
  }

  Future<void> _openTransaction(String transactionId) async {
    await widget.resolvedActions.openTransaction!(transactionId);
    if (mounted) await _refreshHistory();
  }

  Future<void> _refreshHistory() async {
    if (_isRefreshing) return;
    setState(() => _isRefreshing = true);
    try {
      await _loadHistory(initial: false);
    } finally {
      if (mounted) {
        setState(() {
          _isRefreshing = false;
          _refreshAnimationGeneration += 1;
        });
      }
    }
  }

  Future<void> _loadHistory({required bool initial}) async {
    if (initial) {
      await _viewModel.load();
    } else {
      await _viewModel.refresh();
    }
    if (!mounted ||
        _viewModel.error != null ||
        _unlinkTransaction == null ||
        _actions.transactionExists == null) {
      return;
    }
    final bool linksChanged = await _removeUnavailableTransactionLinks();
    if (linksChanged && mounted) await _viewModel.refresh();
  }

  Future<bool> _removeUnavailableTransactionLinks() async {
    const int validationConcurrency = 4;
    bool linksChanged = false;
    final List<RecentNotificationHistoryEntry> linkedEntries = _viewModel
        .entries
        .where(
          (RecentNotificationHistoryEntry entry) =>
              entry.processingOutcome?.transactionId != null,
        )
        .toList();
    for (
      int offset = 0;
      offset < linkedEntries.length;
      offset += validationConcurrency
    ) {
      final int candidateEnd = offset + validationConcurrency;
      final int end = candidateEnd < linkedEntries.length
          ? candidateEnd
          : linkedEntries.length;
      final List<bool> changes = await Future.wait<bool>(
        linkedEntries
            .sublist(offset, end)
            .map(_removeUnavailableTransactionLink),
      );
      linksChanged = linksChanged || changes.any((bool changed) => changed);
    }
    return linksChanged;
  }

  Future<bool> _removeUnavailableTransactionLink(
    RecentNotificationHistoryEntry entry,
  ) async {
    final String transactionId = entry.processingOutcome!.transactionId!;
    try {
      if (await _actions.transactionExists!(transactionId)) return false;
      return await _unlinkTransaction!(entry.notification.id, transactionId);
    } catch (error, stackTrace) {
      _log.fine(
        'Could not validate linked transaction $transactionId.',
        error,
        stackTrace,
      );
      return false;
    }
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
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(overscroll: false),
      child: RefreshIndicator(
        edgeOffset: NotificationPageHeader.bodyTopInset(context),
        displacement: 48,
        onRefresh: _refreshHistory,
        child: CustomScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(
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
        ),
      ),
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
            return _animatedHistoryCard(entry, cardIndex: index ~/ 2);
          },
        ),
      ),
    ];
  }

  Widget _animatedHistoryCard(
    RecentNotificationHistoryEntry entry, {
    required int cardIndex,
  }) {
    Widget card = RecentNotificationCard(
      key: ValueKey<String>(entry.notification.id),
      entry: entry,
      expanded: _expandedEntryId == entry.notification.id,
      onExpansionChanged: (bool expanded) =>
          _setExpandedEntry(entry.notification.id, expanded),
      actions: _actions,
    );
    if (_refreshAnimationGeneration > 0) {
      final int staggerIndex = cardIndex < 6 ? cardIndex : 6;
      final double delay = staggerIndex * 0.08;
      card = TweenAnimationBuilder<double>(
        key: ValueKey<String>(
          'history-refresh-${entry.notification.id}-'
          '$_refreshAnimationGeneration',
        ),
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeOutCubic,
        builder: (BuildContext context, double value, Widget? child) {
          final double progress = ((value - delay) / (1 - delay)).clamp(0, 1);
          return Opacity(
            opacity: progress,
            child: Transform.translate(
              offset: Offset(0, 8 * (1 - progress)),
              child: child,
            ),
          );
        },
        child: card,
      );
    }
    return AnimatedOpacity(
      key: Key('history-refresh-opacity-${entry.notification.id}'),
      opacity: _isRefreshing ? 0.58 : 1,
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeInOut,
      child: card,
    );
  }
}
