import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/presentation/alerts/notification_alert_display.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_app_icon.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_date_time_formatter.dart';
import 'package:waterflyiii/notifications/presentation/shared/reveal_expanded_content.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_card_theme.dart';

class NotificationAlertCard extends StatefulWidget {
  const NotificationAlertCard({
    super.key,
    required this.alerts,
    required this.onDismiss,
    required this.onDismissAll,
    this.applicationName,
    this.onOpenRule,
    this.onOpenDefinition,
    this.highlighted = false,
  }) : assert(alerts.length > 0);

  final List<NotificationAlert> alerts;
  final ValueChanged<NotificationAlert> onDismiss;
  final VoidCallback onDismissAll;
  final String? applicationName;
  final VoidCallback? onOpenRule;
  final VoidCallback? onOpenDefinition;
  final bool highlighted;

  @override
  State<NotificationAlertCard> createState() => _NotificationAlertCardState();
}

class _NotificationAlertCardState extends State<NotificationAlertCard> {
  static const Duration _issueAnimationDuration = Duration(milliseconds: 200);

  bool _expanded = false;
  late final List<NotificationAlert> _displayedAlerts =
      List<NotificationAlert>.of(widget.alerts);
  final Set<String> _removingFingerprints = <String>{};
  final Set<String> _enteringFingerprints = <String>{};
  final Map<String, Timer> _issueAnimationTimers = <String, Timer>{};

  @override
  void didUpdateWidget(covariant NotificationAlertCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncDisplayedAlerts();
  }

  @override
  void dispose() {
    for (final Timer timer in _issueAnimationTimers.values) {
      timer.cancel();
    }
    super.dispose();
  }

  NotificationAlert get _primaryAlert => widget.alerts.reduce(
    (NotificationAlert current, NotificationAlert candidate) =>
        _alertPriority(candidate.kind) > _alertPriority(current.kind)
        ? candidate
        : current,
  );

  DateTime get _updatedAt => widget.alerts
      .map((NotificationAlert alert) => alert.updatedAt)
      .reduce(
        (DateTime current, DateTime candidate) =>
            candidate.isAfter(current) ? candidate : current,
      );

  String? get _applicationId => widget.alerts
      .map((NotificationAlert alert) => alert.applicationId)
      .whereType<String>()
      .firstOrNull;

  void _toggleExpanded() {
    final bool expanded = !_expanded;
    setState(() => _expanded = expanded);
    if (expanded) unawaited(revealExpandedContent(context));
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return TweenAnimationBuilder<Color?>(
      duration: const Duration(milliseconds: 1500),
      curve: Curves.easeOut,
      tween: ColorTween(
        end: widget.highlighted ? colors.primary : Colors.transparent,
      ),
      builder: (BuildContext context, Color? color, Widget? child) =>
          DecoratedBox(
            position: DecorationPosition.foreground,
            decoration: BoxDecoration(
              border: Border.all(color: color ?? Colors.transparent, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: child,
          ),
      child: Card(
        margin: EdgeInsets.zero,
        color: Theme.of(
          context,
        ).extension<NotificationCardTheme>()?.surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: _toggleExpanded,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _leading,
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            _applicationLabel(context),
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (_applicationId != null) ...<Widget>[
                            const SizedBox(height: 2),
                            Text(
                              _applicationId!,
                              style: context.notificationMetadataText,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                          const SizedBox(height: 6),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 140),
                            switchInCurve: Curves.easeIn,
                            switchOutCurve: Curves.easeOut,
                            layoutBuilder:
                                (Widget? current, List<Widget> previous) =>
                                    Stack(
                                      alignment: Alignment.centerLeft,
                                      children: <Widget>[...previous, ?current],
                                    ),
                            child: Text(
                              key: ValueKey<int>(widget.alerts.length),
                              '${S.of(context).notificationsAlertsIssueCount(widget.alerts.length)}'
                              ' · ${formatNotificationDateTime(context, _updatedAt)}',
                              style: context.notificationMetadataText,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _collapsedIssuesTransition(context),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, right: 8),
                      child: AnimatedRotation(
                        turns: _expanded ? 0.5 : 0,
                        duration: notificationExpansionDuration,
                        curve: Curves.easeInOut,
                        child: const Icon(Icons.expand_more),
                      ),
                    ),
                  ],
                ),
              ),
              ClipRect(
                child: AnimatedAlign(
                  duration: notificationExpansionDuration,
                  curve: Curves.easeInOut,
                  alignment: Alignment.topCenter,
                  heightFactor: _expanded ? 1 : 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 140),
                    curve: Curves.easeIn,
                    opacity: _expanded ? 1 : 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Divider(
                          height: 1,
                          thickness: 1,
                          indent: 16,
                          endIndent: 16,
                          color: colors.outlineVariant,
                        ),
                        for (final NotificationAlert alert in _displayedAlerts)
                          _AnimatedAlertIssue(
                            key: ValueKey<String>(alert.fingerprint),
                            visible:
                                !_removingFingerprints.contains(
                                  alert.fingerprint,
                                ) &&
                                !_enteringFingerprints.contains(
                                  alert.fingerprint,
                                ),
                            child: _issueDetails(context, alert),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                child: _actions(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _leading {
    final String? applicationId = _applicationId;
    if (applicationId != null) {
      return NotificationAppIcon(applicationId: applicationId);
    }
    return _AlertIcon(kind: _primaryAlert.kind);
  }

  Widget _collapsedIssuesTransition(BuildContext context) {
    final String key = widget.alerts
        .map((NotificationAlert alert) => alert.fingerprint)
        .join('|');
    return AnimatedSize(
      duration: _issueAnimationDuration,
      curve: Curves.easeInOut,
      alignment: Alignment.topCenter,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 140),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        layoutBuilder: (Widget? current, List<Widget> previous) => Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[...previous, ?current],
        ),
        child: Column(
          key: ValueKey<String>(key),
          children: _collapsedIssues(context),
        ),
      ),
    );
  }

  List<Widget> _collapsedIssues(BuildContext context) {
    final List<NotificationAlert> visible = widget.alerts.take(2).toList();
    return <Widget>[
      for (final NotificationAlert alert in visible)
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                _iconForKind(alert.kind),
                size: 16,
                color: _colorsForKind(context, alert.kind).$2,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _issueTitle(context, alert),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      if (widget.alerts.length > visible.length)
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text(
            S
                .of(context)
                .notificationsAlertsMoreIssues(
                  widget.alerts.length - visible.length,
                ),
            style: context.notificationMetadataText,
          ),
        ),
    ];
  }

  void _syncDisplayedAlerts() {
    final Map<String, NotificationAlert> targetByFingerprint =
        <String, NotificationAlert>{
          for (final NotificationAlert alert in widget.alerts)
            alert.fingerprint: alert,
        };
    final List<NotificationAlert> removed = _displayedAlerts
        .where(
          (NotificationAlert alert) =>
              !targetByFingerprint.containsKey(alert.fingerprint) &&
              !_removingFingerprints.contains(alert.fingerprint),
        )
        .toList();
    for (final NotificationAlert alert in removed) {
      final String fingerprint = alert.fingerprint;
      final bool disableAnimations = MediaQuery.disableAnimationsOf(context);
      _removingFingerprints.add(fingerprint);
      _issueAnimationTimers.remove(fingerprint)?.cancel();
      _issueAnimationTimers[fingerprint] = Timer(
        disableAnimations ? Duration.zero : _issueAnimationDuration,
        () {
          if (!mounted ||
              widget.alerts.any(
                (NotificationAlert candidate) =>
                    candidate.fingerprint == fingerprint,
              )) {
            return;
          }
          setState(() {
            _displayedAlerts.removeWhere(
              (NotificationAlert candidate) =>
                  candidate.fingerprint == fingerprint,
            );
            _removingFingerprints.remove(fingerprint);
          });
          _issueAnimationTimers.remove(fingerprint);
        },
      );
    }

    for (int index = 0; index < _displayedAlerts.length; index++) {
      final NotificationAlert? updated =
          targetByFingerprint[_displayedAlerts[index].fingerprint];
      if (updated != null) {
        _displayedAlerts[index] = updated;
        _issueAnimationTimers.remove(updated.fingerprint)?.cancel();
        _removingFingerprints.remove(updated.fingerprint);
      }
    }

    final Set<String> displayedFingerprints = _displayedAlerts
        .map((NotificationAlert alert) => alert.fingerprint)
        .toSet();
    for (int index = 0; index < widget.alerts.length; index++) {
      final NotificationAlert alert = widget.alerts[index];
      if (displayedFingerprints.contains(alert.fingerprint)) continue;
      _displayedAlerts.insert(index.clamp(0, _displayedAlerts.length), alert);
      _enteringFingerprints.add(alert.fingerprint);
      displayedFingerprints.add(alert.fingerprint);
      WidgetsBinding.instance.addPostFrameCallback((Duration _) {
        if (!mounted || !_enteringFingerprints.contains(alert.fingerprint)) {
          return;
        }
        setState(() => _enteringFingerprints.remove(alert.fingerprint));
      });
    }
  }

  Widget _issueDetails(BuildContext context, NotificationAlert alert) {
    final (Color background, Color foreground) = _colorsForKind(
      context,
      alert.kind,
    );
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 8, 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: background,
              shape: BoxShape.circle,
            ),
            child: Icon(_iconForKind(alert.kind), color: foreground, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _issueTitle(context, alert),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 4),
                Text(_issueMessage(context, alert)),
                const SizedBox(height: 8),
                Text(
                  _issueMetadata(context, alert),
                  style: context.notificationMetadataText,
                ),
                if (alert.ruleName != null)
                  _detailRow(
                    context,
                    icon: Icons.rule_outlined,
                    detail: S
                        .of(context)
                        .notificationsAlertsRuleDetail(alert.ruleName!),
                  ),
                if (alert.actionName != null)
                  _detailRow(
                    context,
                    icon: Icons.tune_outlined,
                    detail: S
                        .of(context)
                        .notificationsAlertsActionDetail(
                          _sentenceCase(alert.actionName!),
                        ),
                  ),
              ],
            ),
          ),
          if (widget.alerts.length > 1)
            IconButton(
              tooltip: S.of(context).notificationsAlertsDismissIssue,
              onPressed: () => widget.onDismiss(alert),
              icon: const Icon(Icons.close),
            ),
        ],
      ),
    );
  }

  Widget _actions(BuildContext context) => Wrap(
    alignment: WrapAlignment.end,
    spacing: 8,
    runSpacing: 8,
    children: <Widget>[
      TextButton(
        onPressed: widget.alerts.length == 1
            ? () => widget.onDismiss(widget.alerts.single)
            : widget.onDismissAll,
        child: Text(
          widget.alerts.length == 1
              ? S.of(context).notificationsAlertsDismiss
              : S.of(context).notificationsAlertsDismissGroup,
        ),
      ),
      if (widget.onOpenRule != null) ...<Widget>[
        FilledButton.icon(
          onPressed: widget.onOpenRule,
          icon: const Icon(Icons.rule_outlined),
          label: Text(S.of(context).notificationsAlertsOpenRule),
        ),
      ] else if (widget.onOpenDefinition != null) ...<Widget>[
        FilledButton.icon(
          onPressed: widget.onOpenDefinition,
          icon: const Icon(Icons.rule_folder_outlined),
          label: Text(S.of(context).notificationsAlertsOpenSetup),
        ),
      ],
    ],
  );

  String _applicationLabel(BuildContext context) {
    final String? notificationName = widget.alerts
        .map(
          (NotificationAlert alert) =>
              alert.notification?.applicationName?.trim(),
        )
        .whereType<String>()
        .where((String name) => name.isNotEmpty)
        .firstOrNull;
    final String? registeredName = widget.applicationName?.trim();
    final String? resolvedName = (registeredName?.isNotEmpty ?? false)
        ? registeredName
        : notificationName;
    if (resolvedName != null &&
        resolvedName.isNotEmpty &&
        resolvedName != _applicationId) {
      return resolvedName;
    }
    return _applicationId == null
        ? _operationLabel(_primaryAlert.operation)
        : S.of(context).notificationsDefinitionsUnknownApplication;
  }

  String _issueTitle(BuildContext context, NotificationAlert alert) =>
      alert.migrationIssue?.title(context) ?? _operationLabel(alert.operation);

  String _issueMessage(BuildContext context, NotificationAlert alert) =>
      alert.migrationIssue?.message(context) ?? alert.message;

  String _issueMetadata(BuildContext context, NotificationAlert alert) {
    final String kind = alert.kind.displayLabel(context);
    final String date = formatNotificationDateTime(context, alert.updatedAt);
    if (alert.occurrenceCount <= 1) return '$kind · $date';
    return '$kind · $date · '
        '${S.of(context).notificationsAlertsOccurrenceCount(alert.occurrenceCount)}';
  }

  String _operationLabel(String operation) {
    const String prefix = 'Applying ';
    if (!operation.startsWith(prefix)) return operation;
    return '$prefix${_sentenceCase(operation.substring(prefix.length))}';
  }

  String _sentenceCase(String value) =>
      value.isEmpty ? value : '${value[0].toLowerCase()}${value.substring(1)}';

  Widget _detailRow(
    BuildContext context, {
    required IconData icon,
    required String detail,
  }) => Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Row(
      children: <Widget>[
        Icon(icon, size: 16, color: context.notificationSupportingColor),
        const SizedBox(width: 8),
        Expanded(child: Text(detail, style: context.notificationMetadataText)),
      ],
    ),
  );
}

class _AnimatedAlertIssue extends StatelessWidget {
  const _AnimatedAlertIssue({
    super.key,
    required this.visible,
    required this.child,
  });

  final bool visible;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bool disableAnimations = MediaQuery.disableAnimationsOf(context);
    return ClipRect(
      child: AnimatedAlign(
        duration: disableAnimations
            ? Duration.zero
            : const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        alignment: Alignment.topCenter,
        heightFactor: visible ? 1 : 0,
        child: AnimatedOpacity(
          duration: disableAnimations
              ? Duration.zero
              : const Duration(milliseconds: 140),
          curve: visible ? Curves.easeOut : Curves.easeIn,
          opacity: visible ? 1 : 0,
          child: child,
        ),
      ),
    );
  }
}

class _AlertIcon extends StatelessWidget {
  const _AlertIcon({required this.kind});

  final NotificationAlertKind kind;

  @override
  Widget build(BuildContext context) {
    final (Color background, Color foreground) = _colorsForKind(context, kind);
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(color: background, shape: BoxShape.circle),
      child: Icon(_iconForKind(kind), color: foreground, size: 20),
    );
  }
}

(Color, Color) _colorsForKind(
  BuildContext context,
  NotificationAlertKind kind,
) {
  final ColorScheme colors = Theme.of(context).colorScheme;
  return switch (kind) {
    NotificationAlertKind.migrationNeedsReview => (
      colors.tertiaryContainer,
      colors.onTertiaryContainer,
    ),
    _ => (colors.errorContainer, colors.onErrorContainer),
  };
}

IconData _iconForKind(NotificationAlertKind kind) => switch (kind) {
  NotificationAlertKind.migrationFailed => Icons.sync_problem_outlined,
  NotificationAlertKind.migrationNeedsReview => Icons.rate_review_outlined,
  NotificationAlertKind.definitionInvalid => Icons.rule_folder_outlined,
  NotificationAlertKind.evaluationFailed => Icons.rule_outlined,
  NotificationAlertKind.actionFailed => Icons.tune_outlined,
};

int _alertPriority(NotificationAlertKind kind) => switch (kind) {
  NotificationAlertKind.migrationFailed => 5,
  NotificationAlertKind.definitionInvalid => 4,
  NotificationAlertKind.evaluationFailed => 3,
  NotificationAlertKind.actionFailed => 2,
  NotificationAlertKind.migrationNeedsReview => 1,
};
