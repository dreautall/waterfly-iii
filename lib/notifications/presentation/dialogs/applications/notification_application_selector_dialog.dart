import 'dart:io';
import 'dart:typed_data';

import 'package:appcheck/appcheck.dart';
import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/application/definitions/notification_application_candidates.dart';
import 'package:waterflyiii/notifications/application/stores/notification_history_store.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/applications/notification_application_candidate_sources.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_card_theme.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_empty_state.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_input_decoration.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';

enum NotificationApplicationSelectionMode { add, recover }

class NotificationApplicationSelectorDialog extends StatefulWidget {
  const NotificationApplicationSelectorDialog({
    super.key,
    this.excludedPackageIds = const <String>{},
    this.historyStore,
    this.mode = NotificationApplicationSelectionMode.add,
  });

  final Set<String> excludedPackageIds;
  final NotificationHistoryStore? historyStore;
  final NotificationApplicationSelectionMode mode;

  @override
  State<NotificationApplicationSelectorDialog> createState() =>
      _NotificationApplicationSelectorDialogState();
}

class _NotificationApplicationSelectorDialogState
    extends State<NotificationApplicationSelectorDialog> {
  final TextEditingController _searchController = TextEditingController();
  late final NotificationApplicationCandidates _candidates =
      NotificationApplicationCandidates(
        manifestPackageSource:
            const MethodChannelNotificationManifestPackageSource(),
        historyPackageSource: widget.historyStore == null
            ? const EmptyNotificationHistoryPackageSource()
            : NotificationHistoryStorePackageSource(widget.historyStore!),
      );
  late final Future<
    ({List<AppInfo> applications, Set<String> eligiblePackageIds})
  >
  _applications;
  String _query = '';
  late bool _showAllInstalledApps;

  @override
  void initState() {
    super.initState();
    _showAllInstalledApps =
        widget.mode == NotificationApplicationSelectionMode.recover;
    _applications = _loadApplications();
    _searchController.addListener(() {
      setState(() {
        _query = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<({List<AppInfo> applications, Set<String> eligiblePackageIds})>
  _loadApplications() async {
    if (!Platform.isAndroid) {
      return (applications: <AppInfo>[], eligiblePackageIds: <String>{});
    }
    final List<AppInfo> applications =
        await AppCheck().getInstalledApps(includeIcon: true) ?? <AppInfo>[];
    final Set<String> eligiblePackageIds = await _candidates.loadPackageIds();
    applications.sort((AppInfo left, AppInfo right) {
      return (left.appName ?? left.packageName).compareTo(
        right.appName ?? right.packageName,
      );
    });
    return (applications: applications, eligiblePackageIds: eligiblePackageIds);
  }

  @override
  Widget build(BuildContext context) {
    final double availableHeight =
        MediaQuery.sizeOf(context).height -
        MediaQuery.viewInsetsOf(context).bottom -
        160;
    return AlertDialog(
      title: Row(
        children: <Widget>[
          const Icon(Icons.apps_outlined),
          const SizedBox(width: 12),
          Text(
            widget.mode == NotificationApplicationSelectionMode.recover
                ? S.of(context).notificationsApplicationsRecoverTitle
                : S.of(context).notificationsDefinitionsAddApplication,
          ),
        ],
      ),
      content: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: availableHeight.clamp(240, 560)),
        child: SizedBox(
          width: 480,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                widget.mode == NotificationApplicationSelectionMode.recover
                    ? S.of(context).notificationsApplicationsRecoverDescription
                    : S.of(context).notificationsApplicationsChooseDescription,
                style: context.notificationSectionDescription,
              ),
              const SizedBox(height: 16),
              _ApplicationScopeSelector(
                showAllInstalledApps: _showAllInstalledApps,
                onChanged: (bool showAllInstalledApps) => setState(
                  () => _showAllInstalledApps = showAllInstalledApps,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _searchController,
                decoration: notificationInputDecoration(
                  context,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  hintText: S.of(context).notificationsApplicationsSearch,
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 16),
              Flexible(
                child:
                    FutureBuilder<
                      ({
                        List<AppInfo> applications,
                        Set<String> eligiblePackageIds,
                      })
                    >(
                      future: _applications,
                      builder:
                          (
                            BuildContext context,
                            AsyncSnapshot<
                              ({
                                List<AppInfo> applications,
                                Set<String> eligiblePackageIds,
                              })
                            >
                            snapshot,
                          ) {
                            return ClipRect(
                              child: AnimatedSize(
                                duration: const Duration(milliseconds: 220),
                                curve: Curves.easeInOut,
                                alignment: Alignment.topCenter,
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 180),
                                  switchInCurve: Curves.easeIn,
                                  switchOutCurve: Curves.easeOut,
                                  layoutBuilder:
                                      (
                                        Widget? currentChild,
                                        List<Widget> previousChildren,
                                      ) => Stack(
                                        alignment: Alignment.topCenter,
                                        children: <Widget>[
                                          ...previousChildren.map(
                                            (Widget child) =>
                                                Positioned.fill(child: child),
                                          ),
                                          ?currentChild,
                                        ],
                                      ),
                                  child: _applicationResults(context, snapshot),
                                ),
                              ),
                            );
                          },
                    ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
      ],
    );
  }

  Widget _applicationResults(
    BuildContext context,
    AsyncSnapshot<
      ({List<AppInfo> applications, Set<String> eligiblePackageIds})
    >
    snapshot,
  ) {
    if (snapshot.connectionState != ConnectionState.done) {
      return const Padding(
        key: ValueKey<String>('applications-loading'),
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (snapshot.hasError) {
      return Center(
        key: const ValueKey<String>('applications-error'),
        child: Text(S.of(context).notificationsApplicationsLoadFailure),
      );
    }
    final ({List<AppInfo> applications, Set<String> eligiblePackageIds})
    result = snapshot.data!;
    final List<AppInfo> scopedApplications = _showAllInstalledApps
        ? result.applications
        : _candidates.filterInstalled<AppInfo>(
            result.applications,
            (AppInfo application) => application.packageName,
            result.eligiblePackageIds,
          );
    final List<AppInfo> availableApplications = scopedApplications
        .where(
          (AppInfo application) =>
              !widget.excludedPackageIds.contains(application.packageName),
        )
        .toList();
    final List<AppInfo> matches = availableApplications
        .where(_matchesQuery)
        .toList();
    return Column(
      key: ValueKey<String>(
        _showAllInstalledApps
            ? 'applications-loaded-all'
            : 'applications-loaded-suggested',
      ),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _ApplicationListHeader(
          title: _showAllInstalledApps
              ? S.of(context).notificationsApplicationsAllTitle
              : S.of(context).notificationsApplicationsSuggestedTitle,
          subtitle: _showAllInstalledApps
              ? null
              : S.of(context).notificationsApplicationsLikelySendersDescription,
        ),
        const SizedBox(height: 8),
        Flexible(
          fit: FlexFit.loose,
          child: matches.isEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: NotificationInlineEmptyState(
                      message: _emptyMessage(
                        context,
                        scopedApplications: scopedApplications,
                        availableApplications: availableApplications,
                      ),
                    ),
                  ),
                )
              : _ApplicationListGroup(
                  applications: matches,
                  onSelected: (AppInfo application) =>
                      Navigator.of(context).pop(application),
                ),
        ),
      ],
    );
  }

  String _emptyMessage(
    BuildContext context, {
    required List<AppInfo> scopedApplications,
    required List<AppInfo> availableApplications,
  }) {
    final S strings = S.of(context);
    if (_query.isNotEmpty) {
      return strings.notificationsApplicationsNoSearchMatches;
    }
    if (availableApplications.isEmpty && scopedApplications.isNotEmpty) {
      return _showAllInstalledApps
          ? strings.notificationsApplicationsAllRegistered
          : strings.notificationsApplicationsSuggestedRegistered;
    }
    return _showAllInstalledApps
        ? strings.notificationsApplicationsNoneInstalled
        : strings.notificationsApplicationsNoneSuggested;
  }

  bool _matchesQuery(AppInfo application) {
    if (_query.isEmpty) {
      return true;
    }
    return (application.appName ?? '').toLowerCase().contains(_query) ||
        application.packageName.toLowerCase().contains(_query);
  }
}

class _ApplicationScopeSelector extends StatelessWidget {
  const _ApplicationScopeSelector({
    required this.showAllInstalledApps,
    required this.onChanged,
  });

  final bool showAllInstalledApps;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return SegmentedButton<bool>(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.selected)) {
            return colors.surfaceContainerHighest;
          }
          return Colors.transparent;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.selected)) {
            return colors.onSurface;
          }
          return colors.onSurfaceVariant;
        }),
        iconColor: WidgetStateProperty.all<Color>(colors.onSurfaceVariant),
        side: WidgetStateProperty.all<BorderSide>(
          BorderSide(color: colors.outlineVariant),
        ),
      ),
      segments: <ButtonSegment<bool>>[
        ButtonSegment<bool>(
          value: false,
          label: Text(S.of(context).notificationsApplicationsSuggestedTitle),
        ),
        ButtonSegment<bool>(
          value: true,
          label: Text(S.of(context).notificationsApplicationsAllTitle),
        ),
      ],
      selected: <bool>{showAllInstalledApps},
      onSelectionChanged: (Set<bool> values) => onChanged(values.single),
    );
  }
}

class _ApplicationListHeader extends StatelessWidget {
  const _ApplicationListHeader({required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(title, style: Theme.of(context).textTheme.titleSmall),
      if (subtitle != null) ...<Widget>[
        const SizedBox(height: 2),
        Text(subtitle!, style: context.notificationSupportingText),
      ],
    ],
  );
}

class _ApplicationListGroup extends StatelessWidget {
  const _ApplicationListGroup({
    required this.applications,
    required this.onSelected,
  });

  final List<AppInfo> applications;
  final ValueChanged<AppInfo> onSelected;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Material(
      color:
          notificationDialogSurfaceColor(context) ?? colors.surfaceContainerLow,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: applications.length,
        separatorBuilder: (BuildContext context, int index) => Divider(
          height: 1,
          thickness: 1,
          indent: 72,
          endIndent: 16,
          color: colors.outlineVariant,
        ),
        itemBuilder: (BuildContext context, int index) {
          final AppInfo application = applications[index];
          return _ApplicationRow(
            application: application,
            onTap: () => onSelected(application),
          );
        },
      ),
    );
  }
}

class _ApplicationRow extends StatelessWidget {
  const _ApplicationRow({required this.application, required this.onTap});

  final AppInfo application;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
        child: Row(
          children: <Widget>[
            _ApplicationIcon(icon: application.icon),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    application.appName ?? application.packageName,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: colors.onSurface),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    application.packageName,
                    style: context.notificationMetadataText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.chevron_right, color: colors.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}

class _ApplicationIcon extends StatelessWidget {
  const _ApplicationIcon({required this.icon});

  final Uint8List? icon;

  @override
  Widget build(BuildContext context) {
    if (icon == null) {
      return const CircleAvatar(child: Icon(Icons.apps_outlined));
    }
    return CircleAvatar(
      child: ClipOval(
        child: Image.memory(
          icon!,
          width: 32,
          height: 32,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => const Icon(Icons.apps_outlined),
        ),
      ),
    );
  }
}
