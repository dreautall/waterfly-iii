import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/presentation/shared/definition_detail_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';
import 'package:waterflyiii/notifications/domain/planning/automatic_transaction_readiness.dart';
import 'package:waterflyiii/notifications/presentation/definitions/widgets/automatic_transaction_readiness_display.dart';
import 'package:waterflyiii/notifications/presentation/shared/message_status_card.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';

class DefinitionOptionsSection extends StatelessWidget {
  const DefinitionOptionsSection({
    super.key,
    required this.createAutomatically,
    required this.onCreateAutomaticallyChanged,
    required this.automaticReadiness,
    required this.missingNotificationDataPolicy,
    required this.allowMetadataOnlyNotifications,
    required this.onMissingNotificationDataChanged,
    required this.isAdvancedMode,
    this.warningKey,
    this.onWarningRevealed,
  });

  final bool createAutomatically;
  final ValueChanged<bool> onCreateAutomaticallyChanged;
  final AutomaticTransactionReadiness automaticReadiness;
  final MissingNotificationDataPolicy missingNotificationDataPolicy;
  final bool allowMetadataOnlyNotifications;
  final bool isAdvancedMode;
  final void Function(
    MissingNotificationDataPolicy policy,
    bool allowMetadataOnly,
  )
  onMissingNotificationDataChanged;
  final Key? warningKey;
  final VoidCallback? onWarningRevealed;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        S.of(context).notificationsDefinitionOptionsHeading,
        style: context.notificationSectionTitle,
      ),
      const SizedBox(height: 4),
      Text(
        S.of(context).notificationsDefinitionOptionsDescription,
        style: context.notificationSectionDescription,
      ),
      const SizedBox(height: 12),
      MissingNotificationDataOptionCard(
        policy: missingNotificationDataPolicy,
        allowMetadataOnly: allowMetadataOnlyNotifications,
        onChanged: onMissingNotificationDataChanged,
        showAdvanced: isAdvancedMode,
      ),
      const SizedBox(height: 12),
      AutomaticTransactionOptionCard(
        createAutomatically: createAutomatically,
        onCreateAutomaticallyChanged: onCreateAutomaticallyChanged,
        automaticReadiness: automaticReadiness,
        warningKey: warningKey,
        onWarningRevealed: onWarningRevealed,
      ),
    ],
  );
}

class MissingNotificationDataOptionCard extends StatelessWidget {
  const MissingNotificationDataOptionCard({
    super.key,
    required this.policy,
    required this.allowMetadataOnly,
    required this.onChanged,
    required this.showAdvanced,
  });

  final MissingNotificationDataPolicy policy;
  final bool allowMetadataOnly;
  final bool showAdvanced;
  final void Function(
    MissingNotificationDataPolicy policy,
    bool allowMetadataOnly,
  )
  onChanged;

  @override
  Widget build(BuildContext context) => DefinitionDetailCard(
    leading: const Icon(Icons.article_outlined),
    title: Text(S.of(context).notificationsDefinitionMissingData),
    subtitle: Text(
      S.of(context).notificationsDefinitionMissingDataDescription,
      style: context.notificationSupportingText,
    ),
    trailing: Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            policy == MissingNotificationDataPolicy.requiresAttention
                ? S.of(context).notificationsDefinitionMissingDataAttention
                : S.of(context).notificationsDefinitionMissingDataIgnore,
          ),
          const SizedBox(width: 4),
          const Icon(Icons.chevron_right),
        ],
      ),
    ),
    onTap: () => _select(context),
  );

  Future<void> _select(BuildContext context) async {
    MissingNotificationDataPolicy selectedPolicy = policy;
    bool selectedMetadataOnly = allowMetadataOnly;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      constraints: BoxConstraints(
        maxHeight:
            MediaQuery.sizeOf(context).height -
            MediaQuery.viewPaddingOf(context).top,
      ),
      builder: (BuildContext sheetContext) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) =>
            SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                16,
                8,
                16,
                24 + MediaQuery.viewPaddingOf(context).bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    S.of(context).notificationsDefinitionMissingDataDialogTitle,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    S
                        .of(context)
                        .notificationsDefinitionMissingDataDialogDescription,
                    style: context.notificationSupportingText,
                  ),
                  const SizedBox(height: 16),
                  _policyOption(
                    context,
                    value: MissingNotificationDataPolicy.requiresAttention,
                    selected: selectedPolicy,
                    onSelected: (MissingNotificationDataPolicy value) =>
                        setState(() => selectedPolicy = value),
                    title: S
                        .of(context)
                        .notificationsDefinitionMissingDataAttention,
                    description: S
                        .of(context)
                        .notificationsDefinitionMissingDataAttentionDescription,
                  ),
                  const SizedBox(height: 8),
                  _policyOption(
                    context,
                    value: MissingNotificationDataPolicy.ignore,
                    selected: selectedPolicy,
                    onSelected: (MissingNotificationDataPolicy value) =>
                        setState(() => selectedPolicy = value),
                    title: S
                        .of(context)
                        .notificationsDefinitionMissingDataIgnore,
                    description: S
                        .of(context)
                        .notificationsDefinitionMissingDataIgnoreDescription,
                  ),
                  if (showAdvanced) ...<Widget>[
                    const SizedBox(height: 16),
                    Row(
                      children: <Widget>[
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            S.of(context).notificationsDefinitionAdvanced,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Material(
                      color: Theme.of(context).colorScheme.surfaceContainerLow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.data_object_outlined),
                        title: Text(
                          S
                              .of(context)
                              .notificationsDefinitionAllowMetadataOnly,
                        ),
                        subtitle: Text(
                          S
                              .of(context)
                              .notificationsDefinitionAllowMetadataOnlyDescription,
                          style: context.notificationSupportingText,
                        ),
                        trailing: Switch(
                          value: selectedMetadataOnly,
                          onChanged: (bool value) =>
                              setState(() => selectedMetadataOnly = value),
                        ),
                        onTap: () => setState(
                          () => selectedMetadataOnly = !selectedMetadataOnly,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            MaterialLocalizations.of(context).cancelButtonLabel,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            onChanged(selectedPolicy, selectedMetadataOnly);
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            MaterialLocalizations.of(context).saveButtonLabel,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
      ),
    );
  }

  Widget _policyOption(
    BuildContext context, {
    required MissingNotificationDataPolicy value,
    required MissingNotificationDataPolicy selected,
    required ValueChanged<MissingNotificationDataPolicy> onSelected,
    required String title,
    required String description,
  }) {
    final bool isSelected = value == selected;
    return Card(
      margin: EdgeInsets.zero,
      color: isSelected
          ? Theme.of(context).colorScheme.primary.withAlpha(20)
          : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: isSelected
            ? BorderSide(color: Theme.of(context).colorScheme.primary)
            : BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        minLeadingWidth: 0,
        leading: RadioGroup<MissingNotificationDataPolicy>(
          groupValue: selected,
          onChanged: (MissingNotificationDataPolicy? value) {
            if (value != null) onSelected(value);
          },
          child: Radio<MissingNotificationDataPolicy>(value: value),
        ),
        title: Text(title),
        subtitle: Text(description, style: context.notificationSupportingText),
        onTap: () => onSelected(value),
      ),
    );
  }
}

class AutomaticTransactionOptionCard extends StatefulWidget {
  const AutomaticTransactionOptionCard({
    super.key,
    required this.createAutomatically,
    required this.onCreateAutomaticallyChanged,
    required this.automaticReadiness,
    this.warningKey,
    this.onWarningRevealed,
  });

  final bool createAutomatically;
  final ValueChanged<bool> onCreateAutomaticallyChanged;
  final AutomaticTransactionReadiness automaticReadiness;
  final Key? warningKey;
  final VoidCallback? onWarningRevealed;

  @override
  State<AutomaticTransactionOptionCard> createState() =>
      _AutomaticTransactionOptionCardState();
}

class _AutomaticTransactionOptionCardState
    extends State<AutomaticTransactionOptionCard> {
  static const Duration _warningDuration = animDurationStandard;
  static const Duration _fadeDuration = animDurationStandard;

  bool get _shouldShowWarning =>
      widget.createAutomatically && !widget.automaticReadiness.isReady;

  late bool _showWarning = _shouldShowWarning;
  late bool _revealWarning = _shouldShowWarning;

  @override
  void didUpdateWidget(covariant AutomaticTransactionOptionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    final bool previouslyShowedWarning =
        oldWidget.createAutomatically && !oldWidget.automaticReadiness.isReady;
    if (_shouldShowWarning && !previouslyShowedWarning) {
      _showWarning = true;
      _revealWarning = false;
      WidgetsBinding.instance.addPostFrameCallback((Duration _) {
        if (mounted && _shouldShowWarning) {
          setState(() => _revealWarning = true);
        }
      });
    } else if (!_shouldShowWarning && previouslyShowedWarning) {
      _revealWarning = false;
    }
  }

  void _handleWarningAnimationEnd() {
    if (_revealWarning && _shouldShowWarning) {
      widget.onWarningRevealed?.call();
    } else if (!_revealWarning && _showWarning) {
      setState(() => _showWarning = false);
    }
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      DefinitionDetailCard(
        leading: const Icon(Icons.bolt_outlined),
        title: Text(S.of(context).notificationsDefinitionCreateAutomatically),
        subtitle: Text(
          widget.createAutomatically
              ? S.of(context).notificationsDefinitionCreateAutomaticallyEnabled
              : S
                    .of(context)
                    .notificationsDefinitionCreateAutomaticallyDisabled,
          style: context.notificationSupportingText,
        ),
        trailing: Checkbox(
          value: widget.createAutomatically,
          onChanged: (bool? value) {
            if (value != null) {
              widget.onCreateAutomaticallyChanged(value);
            }
          },
        ),
        onTap: () =>
            widget.onCreateAutomaticallyChanged(!widget.createAutomatically),
      ),
      if (_showWarning)
        ClipRect(
          child: AnimatedAlign(
            duration: _warningDuration,
            curve: animCurveStandard,
            alignment: Alignment.topCenter,
            heightFactor: _revealWarning ? 1 : 0,
            onEnd: _handleWarningAnimationEnd,
            child: AnimatedOpacity(
              duration: _fadeDuration,
              curve: animCurveStandardAccelerate,
              opacity: _revealWarning ? 1 : 0,
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: MessageStatusCard(
                  key: widget.warningKey,
                  status: MessageStatus.review,
                  title: S
                      .of(context)
                      .notificationsDefinitionAutomaticIncompleteTitle,
                  message: widget.automaticReadiness.message(context),
                ),
              ),
            ),
          ),
        ),
    ],
  );
}
