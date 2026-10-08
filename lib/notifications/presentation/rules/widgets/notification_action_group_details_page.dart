import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_sample.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_action_group_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_rule_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_action_group.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/presentation/rules/widgets/rename_rule_dialog.dart';
import 'package:waterflyiii/notifications/presentation/rules/controllers/notification_rule_editor_view_model.dart';
import 'package:waterflyiii/notifications/presentation/shared/message_status_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_menu_theme.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_page_header.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_editor_dialogs.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_dialog.dart';
import 'package:waterflyiii/notifications/presentation/shared/transaction_patch_summary.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_date_time_formatter.dart';

import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_editor_shared.dart';
import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_action_editor.dart';
import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_condition_editor.dart';
import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_sample_section.dart';
import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_sample_value_issues_section.dart';
import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_test_mode_status_card.dart';

enum _RuleAction { rename, delete }

class NotificationActionGroupDetailsResult {
  const NotificationActionGroupDetailsResult.deleted();
}

class NotificationActionGroupDetailsPage extends StatefulWidget {
  const NotificationActionGroupDetailsPage({
    super.key,
    required this.group,
    required this.extractors,
    required this.notificationContext,
    required this.extractorMode,
    required this.ruleName,
    required this.isTestMode,
    required this.onToggleTestMode,
    required this.onEditExtractor,
    required this.onSave,
    this.isNew = false,
  });

  final NotificationActionGroup group;
  final List<RegExpDefinition> extractors;
  final NotificationContext notificationContext;
  final NotificationExtractorMode extractorMode;
  final String ruleName;
  final bool isTestMode;
  final VoidCallback? onToggleTestMode;
  final Future<void> Function(RegExpDefinition extractor)? onEditExtractor;
  final Future<bool> Function(NotificationActionGroup group) onSave;
  final bool isNew;

  @override
  State<NotificationActionGroupDetailsPage> createState() =>
      _NotificationActionGroupDetailsPageState();
}

class _NotificationActionGroupDetailsPageState
    extends State<NotificationActionGroupDetailsPage> {
  late final TextEditingController _nameController;
  late final NotificationRuleEditorViewModel _viewModel;
  final ScrollController _scrollController = ScrollController();
  bool _isDiscarding = false;
  bool _isConfirmingLeave = false;
  ConditionClipboardOperation? _clipboardOperation;
  late bool _isNew;

  @override
  void initState() {
    super.initState();
    _isNew = widget.isNew;
    _nameController = TextEditingController(text: widget.group.name)
      ..addListener(_updateName);
    _viewModel = NotificationRuleEditorViewModel(
      rule: NotificationRule(
        id: widget.group.id,
        name: widget.group.name,
        conditions: widget.group.conditions,
        actions: widget.group.actions,
        sampleOverride: widget.group.sampleOverride,
      ),
      notificationContext: widget.notificationContext,
      definitionSampleContext: widget.notificationContext,
      isTestMode: widget.isTestMode,
    )..addListener(_render);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _viewModel.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  bool get _isDirty => _isNew || _viewModel.isDirty;
  bool get _canSave => _currentGroup.name.isNotEmpty;
  bool get _isTestMode => _viewModel.isTestMode;

  NotificationActionGroup get _currentGroup => NotificationActionGroup(
    id: widget.group.id,
    name: _nameController.text.trim(),
    conditions: _viewModel.conditions,
    actions: _viewModel.actions,
    sampleOverride: _viewModel.sampleOverride,
  );

  NotificationContext get _sampleNotificationContext =>
      _viewModel.sampleNotificationContext;

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: (!_isDirty && _clipboardOperation == null) || _isDiscarding,
    onPopInvokedWithResult: _applyChangesOnBack,
    child: NotificationMenuTheme(
      child: ScaffoldMessenger(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: NotificationPageHeader(
            scrollController: _scrollController,
            leading: BackButton(
              onPressed: _onBackRequested,
              style: IconButton.styleFrom(
                iconSize: NotificationPageHeader.controlIconSize,
              ),
            ),
            title: Text(_nameController.text),
            actions: <Widget>[
              if (widget.onToggleTestMode != null)
                IconButton(
                  tooltip: _isTestMode
                      ? S.of(context).notificationsRuleExitTestMode
                      : S.of(context).notificationsRuleEnterTestMode,
                  iconSize: NotificationPageHeader.controlIconSize,
                  onPressed: _toggleTestMode,
                  icon: Icon(
                    _isTestMode ? Icons.science : Icons.science_outlined,
                  ),
                ),
              PopupMenuButton<_RuleAction>(
                tooltip: S.of(context).notificationsRuleOptions,
                position: PopupMenuPosition.under,
                iconSize: NotificationPageHeader.controlIconSize,
                onSelected: _onActionSelected,
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<_RuleAction>>[
                      PopupMenuItem<_RuleAction>(
                        value: _RuleAction.rename,
                        child: Row(
                          children: <Widget>[
                            const Icon(Icons.edit_outlined),
                            const SizedBox(width: 8),
                            Text(S.of(context).notificationsRuleRename),
                          ],
                        ),
                      ),
                      if (!widget.isNew) ...<PopupMenuEntry<_RuleAction>>[
                        const NotificationMenuDivider(),
                        PopupMenuItem<_RuleAction>(
                          value: _RuleAction.delete,
                          child: Row(
                            children: <Widget>[
                              const Icon(Icons.delete_outline),
                              const SizedBox(width: 8),
                              Text(S.of(context).notificationsRuleDelete),
                            ],
                          ),
                        ),
                      ],
                    ],
              ),
            ],
          ),
          floatingActionButton: _isDirty
              ? FloatingActionButton(
                  tooltip: S.of(context).notificationsExtractorSave,
                  onPressed: _canSave ? _apply : null,
                  child: const Icon(Icons.save_outlined),
                )
              : null,
          body: ListView(
            controller: _scrollController,
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              16,
              NotificationPageHeader.bodyTopInset(context),
              16,
              NotificationPageHeader.bodyBottomInset(context, spacing: 24),
            ),
            children: <Widget>[
              AnimatedSize(
                duration: const Duration(milliseconds: 240),
                curve: Curves.easeInOut,
                alignment: Alignment.topCenter,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 180),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  transitionBuilder:
                      (Widget child, Animation<double> animation) =>
                          FadeTransition(opacity: animation, child: child),
                  child: _isTestMode
                      ? const Padding(
                          key: Key('conditional-action-test-status'),
                          padding: EdgeInsets.only(bottom: 24),
                          child: RuleTestModeStatusCard(),
                        )
                      : const SizedBox.shrink(
                          key: Key('conditional-action-test-status-empty'),
                        ),
                ),
              ),
              if (!_currentGroup.isConfigured) ...<Widget>[
                MessageStatusCard(
                  status: MessageStatus.review,
                  title: S.of(context).notificationsRuleNeedsReview,
                  message: _currentGroup.conditions.isEmpty
                      ? S
                            .of(context)
                            .notificationsRuleConditionalGroupNeedsConditionsMessage
                      : S
                            .of(context)
                            .notificationsRuleConditionalGroupNeedsActionsMessage,
                ),
                const SizedBox(height: 24),
              ],
              RuleSampleSection(
                sample: _sampleNotificationContext,
                hasOverride: _viewModel.sampleOverride != null,
                description: S
                    .of(context)
                    .notificationsConditionalActionSampleDescription,
                onEdit: _editSample,
                onClearOverride: _clearSampleOverride,
                clearOverrideTooltip: S.of(context).notificationsUseRuleSample,
              ),
              AnimatedRuleSampleIssues(
                visible: _isTestMode,
                groups: _viewModel.requirementGroups(widget.extractors),
                notificationContext: _sampleNotificationContext,
                onEditExtractor: widget.onEditExtractor,
              ),
              const SizedBox(height: 24),
              RuleConditionsSection(
                conditions: _viewModel.conditions,
                title: S.of(context).notificationsRuleConditionalGroupWhenTitle,
                description: S
                    .of(context)
                    .notificationsRuleConditionalGroupWhenDescription,
                emptyText: S
                    .of(context)
                    .notificationsRuleConditionalGroupNoConditions,
                extractors: widget.extractors,
                notificationContext: widget.notificationContext,
                activeNotificationContext: _sampleNotificationContext,
                testNotificationContext: _sampleNotificationContext,
                isTestMode: _isTestMode,
                ruleName: _nameController.text,
                onReplaceAt: _viewModel.replaceConditionAt,
                onReplaceAll: _viewModel.replaceConditions,
                onRemoveAt: _viewModel.removeConditionAt,
                onMove: _viewModel.moveCondition,
                onDuplicateAt: _viewModel.duplicateConditionAt,
                onClipboardChanged: (ConditionClipboardOperation? operation) =>
                    setState(() => _clipboardOperation = operation),
              ),
              const SizedBox(height: 24),
              RuleActionsSection(
                rule: _viewModel.currentRule,
                actions: _viewModel.actions,
                title: S.of(context).notificationsRuleActionsTitle,
                description: S
                    .of(context)
                    .notificationsRuleConditionalGroupActionsDescription,
                emptyText: S
                    .of(context)
                    .notificationsRuleConditionalGroupNoActions,
                reviewedPredefinedFields: const <TransactionField>{},
                extractors: widget.extractors,
                notificationContext: widget.notificationContext,
                activeNotificationContext: _sampleNotificationContext,
                extractorMode: widget.extractorMode,
                ruleName: widget.ruleName,
                onAdd: _viewModel.addAction,
                onReplaceAt: _viewModel.replaceActionAt,
                onRemoveAt: _viewModel.removeActionAt,
                onRemoveTag: _viewModel.removeTagFromAction,
                onSetPredefinedFieldReviewed: (_, _) {},
              ),
              _ConditionalActionResolvedFields(
                group: _currentGroup,
                extractors: widget.extractors,
                notificationContext: _sampleNotificationContext,
              ),
              if (_isDirty) const SizedBox(height: 56),
            ],
          ),
        ),
      ),
    ),
  );

  void _updateName() => _viewModel.updateName(_nameController.text);

  void _toggleTestMode() {
    _viewModel.toggleTestMode();
    widget.onToggleTestMode?.call();
  }

  Future<void> _editSample() async {
    final NotificationSample? sample = await showSampleNotificationEditor(
      context: context,
      editorContext: SampleNotificationEditorContext.conditionalAction,
      sample: NotificationSample(
        title: _sampleNotificationContext.title,
        body: _sampleNotificationContext.body,
        receivedAt: _sampleNotificationContext.receivedAt,
      ),
    );
    if (sample == null || !mounted) return;
    _viewModel.updateSampleOverride(sample);
  }

  void _clearSampleOverride() {
    _viewModel.clearSampleOverride();
  }

  void _render() {
    if (mounted) setState(() {});
  }

  Future<void> _apply() async {
    if (!_canSave) return;
    final bool saved = await widget.onSave(_currentGroup);
    if (!mounted) return;
    if (!saved) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).notificationsDefinitionSaveFailure),
        ),
        snackBarAnimationStyle: ruleEditorMessageAnimation,
      );
      return;
    }
    _isNew = false;
    _viewModel.acceptChanges();
  }

  Future<void> _onActionSelected(_RuleAction action) async {
    if (action == _RuleAction.delete) {
      Navigator.of(
        context,
      ).pop(const NotificationActionGroupDetailsResult.deleted());
      return;
    }
    final String? name = await showNotificationDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          RenameRuleDialog(name: _nameController.text),
    );
    if (name != null && name.isNotEmpty && mounted) {
      _nameController.text = name;
    }
  }

  void _applyChangesOnBack(bool didPop, Object? _) {
    if (!didPop && (_isDirty || _clipboardOperation != null)) _confirmLeave();
  }

  Future<void> _onBackRequested() async {
    if (!_isDirty && _clipboardOperation == null) {
      Navigator.of(context).pop();
      return;
    }
    await _confirmLeave();
  }

  Future<void> _confirmLeave() async {
    if (_isConfirmingLeave) return;
    _isConfirmingLeave = true;
    final ConditionClipboardOperation? operation = _clipboardOperation;
    final bool leave = operation == null
        ? await showDiscardChangesDialog(context)
        : await showCancelConditionTransferDialog(
            context,
            isMove: operation == ConditionClipboardOperation.move,
            hasUnsavedChanges: _isDirty,
          );
    _isConfirmingLeave = false;
    if (!leave || !mounted) return;
    setState(() => _isDiscarding = true);
    Navigator.of(context).pop();
  }
}

class _ConditionalActionResolvedFields extends StatelessWidget {
  const _ConditionalActionResolvedFields({
    required this.group,
    required this.extractors,
    required this.notificationContext,
  });

  final NotificationActionGroup group;
  final List<RegExpDefinition> extractors;
  final NotificationContext notificationContext;

  @override
  Widget build(BuildContext context) {
    final EvaluationContext evaluationContext = EvaluationContext(
      notification: notificationContext,
      extractionResults: <String, RegExpEvaluationResult>{
        for (final RegExpDefinition extractor in extractors)
          extractor.id: extractor.evaluate(notificationContext),
      },
      dateTimeExtractorIds: <String>{
        for (final RegExpDefinition extractor in extractors)
          if (extractor.predefinedType ==
              PredefinedRegExpDefinition.notificationDate)
            extractor.id,
      },
      formattingPreferences: notificationFormattingPreferencesOf(context),
    );
    final NotificationRuleEvaluationResult evaluation = NotificationRule(
      id: '__conditional_action_preview__',
      name: group.name,
      conditions: const <NotificationCondition>[],
      actions: const <NotificationAction>[],
      conditionalActionGroups: <NotificationActionGroup>[group],
    ).evaluate(evaluationContext);
    final NotificationActionGroupEvaluationResult? groupResult =
        evaluation.conditionalGroups[group.id];
    if (groupResult == null ||
        !groupResult.matches ||
        groupResult.patch.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            S.of(context).notificationsDefinitionResolvedTransaction,
            style: context.notificationSectionTitle,
          ),
          const SizedBox(height: 4),
          Text(
            S
                .of(context)
                .notificationsConditionalActionResolvedTransactionDescription,
            style: context.notificationSectionDescription,
          ),
          const SizedBox(height: 12),
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TransactionPatchSummary(patch: groupResult.patch),
            ),
          ),
        ],
      ),
    );
  }
}
