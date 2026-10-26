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
import 'package:waterflyiii/notifications/presentation/shared/notification_date_time_formatter.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_empty_state.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_dialog.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_menu_theme.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_page_header.dart';
import 'package:waterflyiii/notifications/presentation/shared/route_transition_load_scheduler.dart';
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

class _RecentNotificationsPageState extends State<RecentNotificationsPage>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  static const Duration _emptyHistoryRefreshInterval = Duration(seconds: 3);
  static const Duration _removeUndoDuration = Duration(seconds: 6);
  static const Duration _entryTransitionDuration = Duration(milliseconds: 450);
  static const Duration _historyFadeDuration = Duration(milliseconds: 320);
  static const double _scrollToTopThreshold = 300;

  static final Logger _log = Logger('Notifications.RecentNotifications');
  late final RecentNotificationsViewModel _viewModel;
  late final RecentNotificationActions _actions;
  final ScrollController _scrollController = ScrollController();
  late final AnimationController _historyFadeController = AnimationController(
    vsync: this,
    duration: _historyFadeDuration,
  );
  late final Animation<double> _historyFadeAnimation = CurvedAnimation(
    parent: _historyFadeController,
    curve: Curves.easeInOut,
  );
  bool _ownsViewModel = false;
  bool _isInitialLoadPending = true;
  bool _isRefreshing = false;
  bool _isAppResumed = true;
  bool _showRefreshLoading = false;
  bool _showScrollToTop = false;
  int _historyFadeGeneration = 0;
  final RouteTransitionLoadScheduler _initialLoadScheduler =
      RouteTransitionLoadScheduler();
  final Map<String, GlobalKey> _entryCellKeys = <String, GlobalKey>{};
  final Set<String> _removingEntryIds = <String>{};
  final Set<String> _restoringEntryIds = <String>{};
  String? _expandedEntryId;
  NotificationHistoryTransactionUnlinker? _unlinkTransaction;
  Timer? _emptyHistoryRefreshTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initialLoadScheduler.schedule(
      context,
      () => unawaited(_loadInitialHistory()),
    );
  }

  Future<void> _loadInitialHistory() async {
    try {
      await _loadHistory(initial: true);
    } finally {
      if (mounted) {
        setState(() => _isInitialLoadPending = false);
        _fadeInLoadedHistory();
        _syncEmptyHistoryRefreshTimer();
      }
    }
  }

  void _onViewModelChanged() {
    if (!mounted) return;
    final Set<String> retainedEntryIds = <String>{
      ..._viewModel.entries.map(
        (RecentNotificationHistoryEntry entry) => entry.notification.id,
      ),
      ..._removingEntryIds,
      ..._restoringEntryIds,
    };
    _entryCellKeys.removeWhere(
      (String entryId, _) => !retainedEntryIds.contains(entryId),
    );
    _syncEmptyHistoryRefreshTimer();
    setState(() {});
  }

  void _syncEmptyHistoryRefreshTimer() {
    final bool shouldRefreshEmptyHistory =
        !_isInitialLoadPending &&
        !_viewModel.isLoading &&
        _viewModel.error == null &&
        _viewModel.entries.isEmpty;
    if (!shouldRefreshEmptyHistory) {
      _emptyHistoryRefreshTimer?.cancel();
      _emptyHistoryRefreshTimer = null;
      return;
    }
    _emptyHistoryRefreshTimer ??= Timer.periodic(
      _emptyHistoryRefreshInterval,
      (_) => _refreshEmptyHistory(),
    );
  }

  void _refreshEmptyHistory() {
    if (!mounted ||
        ModalRoute.of(context)?.isCurrent != true ||
        !_isAppResumed ||
        _isRefreshing) {
      return;
    }
    unawaited(_refreshHistory());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _isAppResumed = state == AppLifecycleState.resumed;
    if (state == AppLifecycleState.resumed &&
        _viewModel.entries.isEmpty &&
        _viewModel.error == null) {
      _refreshEmptyHistory();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _prefetchIfNeeded());
  }

  void _onScroll() {
    final bool showScrollToTop =
        _scrollController.hasClients &&
        _scrollController.position.pixels > _scrollToTopThreshold;
    if (showScrollToTop != _showScrollToTop && mounted) {
      setState(() => _showScrollToTop = showScrollToTop);
    }
    _prefetchIfNeeded();
  }

  Future<void> _scrollToTop() async {
    if (!_scrollController.hasClients) return;
    await _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );
  }

  void _prefetchIfNeeded() {
    if (!mounted ||
        !_scrollController.hasClients ||
        _viewModel.loadMoreError != null ||
        _scrollController.position.extentAfter > 800) {
      return;
    }
    unawaited(_loadMoreHistory());
  }

  Future<void> _loadMoreHistory() async {
    if (_viewModel.isLoadingMore || !_viewModel.hasMore) return;
    await _viewModel.loadMore();
    if (!mounted || _viewModel.loadMoreError != null) return;
    await _removeUnavailableTransactionLinks(
      _viewModel.mostRecentlyLoadedEntries,
    );
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

  Future<void> _refreshHistory({bool showLoading = false}) async {
    if (_isRefreshing) return;
    _isRefreshing = true;
    final bool fadeInLoadedHistory = showLoading || _viewModel.entries.isEmpty;
    if (showLoading && mounted) {
      _historyFadeController.value = 0;
      setState(() => _showRefreshLoading = true);
    }
    try {
      await _loadHistory(initial: false);
    } finally {
      _isRefreshing = false;
      if (_showRefreshLoading && mounted) {
        setState(() => _showRefreshLoading = false);
      }
      if (mounted && fadeInLoadedHistory) _fadeInLoadedHistory();
    }
  }

  void _fadeInLoadedHistory() {
    if (_viewModel.error != null || _viewModel.entries.isEmpty) return;
    final int generation = ++_historyFadeGeneration;
    _historyFadeController.value = 0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted ||
          generation != _historyFadeGeneration ||
          _isInitialLoadPending ||
          _viewModel.isLoading ||
          _showRefreshLoading ||
          _viewModel.error != null ||
          _viewModel.entries.isEmpty) {
        return;
      }
      _historyFadeController.forward();
    });
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
    await _removeUnavailableTransactionLinks(
      _viewModel.mostRecentlyLoadedEntries,
    );
  }

  Future<bool> _removeUnavailableTransactionLinks(
    Iterable<RecentNotificationHistoryEntry> entries,
  ) async {
    const int validationConcurrency = 4;
    bool linksChanged = false;
    final List<RecentNotificationHistoryEntry> linkedEntries = entries
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
      final bool unlinked = await _unlinkTransaction!(
        entry.notification.id,
        transactionId,
      );
      if (unlinked && mounted) {
        _viewModel.removeTransactionLink(entry.notification.id, transactionId);
      }
      return unlinked;
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
    final String entryId = entry.notification.id;
    setState(() => _removingEntryIds.add(entryId));
    await Future<void>.delayed(_entryTransitionDuration);
    try {
      await remove(entry);
      if (!mounted) return;
      if (_expandedEntryId == entryId) {
        _expandedEntryId = null;
      }
      await _viewModel.refresh();
      if (!mounted) return;
      _removingEntryIds.remove(entryId);
      _entryCellKeys.remove(entryId);
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
      setState(() => _removingEntryIds.remove(entryId));
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
    final String entryId = entry.notification.id;
    if (mounted) setState(() => _restoringEntryIds.add(entryId));
    try {
      await restore(entry);
      if (!mounted) return;
      await _viewModel.refresh();
      if (!mounted) return;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        setState(() => _restoringEntryIds.remove(entryId));
      });
    } catch (error, stackTrace) {
      _log.warning(
        'Could not restore recent notification history entry.',
        error,
        stackTrace,
      );
      if (!mounted) return;
      setState(() => _restoringEntryIds.remove(entryId));
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
    WidgetsBinding.instance.removeObserver(this);
    _emptyHistoryRefreshTimer?.cancel();
    _initialLoadScheduler.dispose();
    _viewModel.removeListener(_onViewModelChanged);
    _scrollController.removeListener(_onScroll);
    if (_ownsViewModel) _viewModel.dispose();
    _historyFadeController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationMenuTheme(
      child: Scaffold(
        appBar: NotificationPageHeader(
          scrollController: _scrollController,
          title: Text(S.of(context).notificationsHistoryTitle),
          fadeTitleOnScroll: false,
        ),
        body: _body(context),
        floatingActionButton: AnimatedScale(
          scale: _showScrollToTop ? 1 : 0,
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          child: IgnorePointer(
            ignoring: !_showScrollToTop,
            child: FloatingActionButton(
              key: const Key('history-scroll-to-top'),
              heroTag: null,
              tooltip: S.of(context).notificationsHistoryScrollToTop,
              onPressed: _scrollToTop,
              child: const Icon(Icons.keyboard_arrow_up),
            ),
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    final bool showCenteredEmptyState =
        !_isInitialLoadPending &&
        !_viewModel.isLoading &&
        _viewModel.error == null &&
        _viewModel.entries.isEmpty;
    if (showCenteredEmptyState) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: NotificationPageHeader.bodyBottomInset(context),
        ),
        child: NotificationEmptyStateViewport(
          header: Text(
            S.of(context).notificationsHistoryDescription,
            style: context.notificationSectionDescription,
          ),
          emptyState: NotificationEmptyState(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            icon: Icons.history_outlined,
            title: S.of(context).notificationsHistoryEmptyTitle,
            description: S.of(context).notificationsHistoryEmptyDescription,
          ),
        ),
      );
    }
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(overscroll: false),
      child: RefreshIndicator(
        displacement: 48,
        onRefresh: () => _refreshHistory(showLoading: true),
        child: CustomScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(
            parent: ClampingScrollPhysics(),
          ),
          slivers: <Widget>[
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
        ),
      ),
    );
  }

  List<Widget> _historyContent(BuildContext context) {
    if (_isInitialLoadPending || _viewModel.isLoading || _showRefreshLoading) {
      return _historyLoadingSkeleton(context);
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
    if (entries.isEmpty && _viewModel.loadMoreError != null) {
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
            child: Center(child: _loadMoreFailure(context)),
          ),
        ),
      ];
    }
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
    final List<_NotificationDayGroup> groups = _groupEntriesByDay(entries);
    final List<Widget> slivers = <Widget>[];
    for (final _NotificationDayGroup group in groups) {
      final Map<Key, int> entryIndices = <Key, int>{
        for (int index = 0; index < group.entries.length; index++)
          _entryCellKey(group.entries[index].notification.id): index,
      };
      slivers.add(
        SliverMainAxisGroup(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: _NotificationDayHeaderDelegate(
                child: _dayHeader(context, group),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
              sliver: SliverList.builder(
                itemCount: group.entries.length,
                findChildIndexCallback: (Key key) => entryIndices[key],
                itemBuilder: (BuildContext context, int index) {
                  final RecentNotificationHistoryEntry entry =
                      group.entries[index];
                  return _animatedHistoryCard(
                    entry,
                    bottomSpacing: index == group.entries.length - 1 ? 0 : 8,
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
    slivers.add(_loadMoreFooter(context));
    return <Widget>[
      SliverFadeTransition(
        key: const Key('history-content-fade'),
        opacity: _historyFadeAnimation,
        sliver: SliverMainAxisGroup(slivers: slivers),
      ),
    ];
  }

  List<_NotificationDayGroup> _groupEntriesByDay(
    List<RecentNotificationHistoryEntry> entries,
  ) {
    final List<_NotificationDayGroup> groups = <_NotificationDayGroup>[];
    for (final RecentNotificationHistoryEntry entry in entries) {
      final DateTime receivedAt = entry.notification.receivedAt.toLocal();
      final DateTime day = DateTime(
        receivedAt.year,
        receivedAt.month,
        receivedAt.day,
      );
      if (groups.isEmpty || groups.last.day != day) {
        groups.add(
          _NotificationDayGroup(
            day: day,
            entries: <RecentNotificationHistoryEntry>[entry],
          ),
        );
      } else {
        groups.last.entries.add(entry);
      }
    }
    return groups;
  }

  Widget _dayHeader(BuildContext context, _NotificationDayGroup group) {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final int difference = today.difference(group.day).inDays;
    final String label = switch (difference) {
      0 => S.of(context).notificationsHistoryToday,
      1 => S.of(context).notificationsHistoryYesterday,
      _ => formatNotificationDate(context, group.day),
    };
    return SizedBox.expand(
      key: ValueKey<String>(
        'history-day-${group.day.year}-${group.day.month}-${group.day.day}',
      ),
      child: ColoredBox(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
          child: Text(
            '$label · ${S.of(context).notificationsHistoryRecordedAlertCount(group.entries.length)}',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _loadMoreFooter(BuildContext context) {
    final double bottomInset = NotificationPageHeader.bodyBottomInset(context);
    if (_viewModel.loadMoreError != null) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, bottomInset),
          child: _loadMoreFailure(context),
        ),
      );
    }
    if (_viewModel.isLoadingMore) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.only(top: 8, bottom: bottomInset),
          child: const Center(
            child: SizedBox.square(
              dimension: 24,
              child: CircularProgressIndicator(strokeWidth: 2.5),
            ),
          ),
        ),
      );
    }
    return SliverToBoxAdapter(child: SizedBox(height: bottomInset));
  }

  Widget _loadMoreFailure(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text(S.of(context).notificationsHistoryLoadMoreFailure),
      const SizedBox(height: 8),
      OutlinedButton.icon(
        onPressed: _loadMoreHistory,
        icon: const Icon(Icons.refresh),
        label: Text(S.of(context).notificationsHistoryLoadMoreRetry),
      ),
    ],
  );

  Widget _animatedHistoryCard(
    RecentNotificationHistoryEntry entry, {
    required double bottomSpacing,
  }) {
    final String entryId = entry.notification.id;
    final bool isRemoving = _removingEntryIds.contains(entryId);
    final bool isRestoring = _restoringEntryIds.contains(entryId);
    Widget card = RecentNotificationCard(
      key: ValueKey<String>(entryId),
      entry: entry,
      expanded: _expandedEntryId == entryId,
      onExpansionChanged: (bool expanded) =>
          _setExpandedEntry(entryId, expanded),
      actions: _actions,
    );
    card = Padding(
      padding: EdgeInsets.only(bottom: bottomSpacing),
      child: card,
    );
    final bool isHidden = isRemoving || isRestoring;
    final Widget layoutTransition = AnimatedSwitcher(
      key: Key('history-entry-layout-$entryId'),
      duration: _entryTransitionDuration,
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInOutCubic,
      transitionBuilder: (Widget child, Animation<double> animation) =>
          SizeTransition(
            sizeFactor: animation,
            alignment: Alignment.topCenter,
            child: child,
          ),
      child: isHidden
          ? SizedBox(
              key: Key('history-entry-hidden-$entryId'),
              width: double.infinity,
            )
          : KeyedSubtree(
              key: Key('history-entry-visible-$entryId'),
              child: card,
            ),
    );
    return IgnorePointer(
      key: _entryCellKey(entryId),
      ignoring: isRemoving,
      child: AnimatedOpacity(
        key: Key('history-refresh-opacity-$entryId'),
        opacity: isHidden ? 0 : 1,
        duration: _entryTransitionDuration,
        curve: Curves.easeInOutCubic,
        child: layoutTransition,
      ),
    );
  }

  List<Widget> _historyLoadingSkeleton(BuildContext context) {
    return <Widget>[
      SliverToBoxAdapter(
        child: _HistoryLoadingSkeleton(
          bottomInset: NotificationPageHeader.bodyBottomInset(context),
        ),
      ),
    ];
  }

  GlobalKey _entryCellKey(String entryId) => _entryCellKeys.putIfAbsent(
    entryId,
    () => GlobalKey(debugLabel: 'history-entry-cell-$entryId'),
  );
}

class _HistoryLoadingSkeleton extends StatefulWidget {
  const _HistoryLoadingSkeleton({required this.bottomInset});

  final double bottomInset;

  @override
  State<_HistoryLoadingSkeleton> createState() =>
      _HistoryLoadingSkeletonState();
}

class _HistoryLoadingSkeletonState extends State<_HistoryLoadingSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    key: const Key('history-loading-skeleton'),
    child: AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? _) {
        final Color placeholderColor = Theme.of(context)
            .colorScheme
            .onSurfaceVariant
            .withValues(alpha: 0.08 + (0.08 * _animation.value));
        Widget placeholder({
          required double width,
          required double height,
          BorderRadius? borderRadius,
        }) => SizedBox(
          width: width,
          height: height,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: placeholderColor,
              borderRadius: borderRadius ?? BorderRadius.circular(height / 2),
            ),
          ),
        );

        return Column(
          children: <Widget>[
            SizedBox(
              height: _NotificationDayHeaderDelegate.height,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: placeholder(width: 150, height: 12),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 4, 16, widget.bottomInset),
              child: Column(
                children: <Widget>[
                  for (int index = 0; index < 3; index++) ...<Widget>[
                    Card(
                      key: ValueKey<String>('history-loading-card-$index'),
                      margin: EdgeInsets.zero,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: <Widget>[
                            placeholder(
                              width: 48,
                              height: 48,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  FractionallySizedBox(
                                    widthFactor: index == 1 ? 0.48 : 0.62,
                                    alignment: Alignment.centerLeft,
                                    child: placeholder(
                                      width: double.infinity,
                                      height: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  FractionallySizedBox(
                                    widthFactor: index == 2 ? 0.72 : 0.9,
                                    alignment: Alignment.centerLeft,
                                    child: placeholder(
                                      width: double.infinity,
                                      height: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 24),
                          ],
                        ),
                      ),
                    ),
                    if (index < 2) const SizedBox(height: 8),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    ),
  );
}

class _NotificationDayGroup {
  const _NotificationDayGroup({required this.day, required this.entries});

  final DateTime day;
  final List<RecentNotificationHistoryEntry> entries;
}

class _NotificationDayHeaderDelegate extends SliverPersistentHeaderDelegate {
  const _NotificationDayHeaderDelegate({required this.child});

  static const double height = 42;

  final Widget child;

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) => child;

  @override
  bool shouldRebuild(_NotificationDayHeaderDelegate oldDelegate) =>
      oldDelegate.child != child;
}
