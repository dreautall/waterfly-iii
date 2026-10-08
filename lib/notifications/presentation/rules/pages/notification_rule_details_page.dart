import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_sample.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/planning/automatic_transaction_readiness.dart';
import 'package:waterflyiii/notifications/domain/notification_id.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_action_group.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule_diagnostics.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/presentation/rules/widgets/rename_rule_dialog.dart';
import 'package:waterflyiii/notifications/presentation/rules/controllers/notification_rule_editor_view_model.dart';
import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_sample_value_issues_section.dart';
import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_sample_section.dart';
import 'package:waterflyiii/notifications/presentation/shared/message_status_card.dart';
import 'package:waterflyiii/notifications/presentation/definitions/widgets/automatic_transaction_readiness_display.dart';
import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_test_mode_status_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_menu_theme.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_page_header.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_editor_dialogs.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_dialog.dart';
import 'package:waterflyiii/notifications/presentation/definitions/widgets/rule_effective_transaction_preview.dart';
import 'package:waterflyiii/notifications/presentation/definitions/widgets/add_rule_dialog.dart';
import 'package:waterflyiii/notifications/presentation/rules/widgets/notification_action_group_details_page.dart';
import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_action_editor.dart';
import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_condition_editor.dart';
import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_conditional_action_groups.dart';
import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_editor_shared.dart';

class NotificationRuleDetailsResult {
  const NotificationRuleDetailsResult._({this.rule, this.delete = false});
  const NotificationRuleDetailsResult.updated(NotificationRule rule)
    : this._(rule: rule);
  const NotificationRuleDetailsResult.deleted() : this._(delete: true);

  final NotificationRule? rule;
  final bool delete;
}

class NotificationRuleDetailsPage extends StatefulWidget {
  const NotificationRuleDetailsPage({
    super.key,
    required this.rule,
    required this.extractors,
    required this.notificationContext,
    this.extractorMode = NotificationExtractorMode.advanced,
    this.initialTestMode = false,
    this.isTestModeLocked = false,
    this.definitionSampleContext,
    this.showStatusTag = true,
    this.isSharedActionsEditor = false,
    this.rules = const <NotificationRule>[],
    this.sharedActions = const <NotificationAction>[],
    this.transactionCreationMode = TransactionCreationMode.prompt,
    this.onEditExtractor,
    this.onSave,
  });

  final NotificationRule rule;
  final List<RegExpDefinition> extractors;
  final NotificationContext notificationContext;
  final NotificationExtractorMode extractorMode;
  final bool initialTestMode;
  final bool isTestModeLocked;
  final NotificationContext? definitionSampleContext;
  final bool showStatusTag;
  final bool isSharedActionsEditor;
  final List<NotificationRule> rules;
  final List<NotificationAction> sharedActions;
  final TransactionCreationMode transactionCreationMode;
  final Future<void> Function(RegExpDefinition extractor)? onEditExtractor;
  final Future<bool> Function(NotificationRule rule)? onSave;

  @override
  State<NotificationRuleDetailsPage> createState() =>
      _NotificationRuleDetailsPageState();
}

class _NotificationRuleDetailsPageState
    extends State<NotificationRuleDetailsPage> {
  late final TextEditingController _nameController;
  late final NotificationRuleEditorViewModel _viewModel;
  final ScrollController _scrollController = ScrollController();
  bool _isDiscarding = false;
  bool _isConfirmingLeave = false;
  ConditionClipboardOperation? _clipboardOperation;

  List<NotificationCondition> get _conditions => _viewModel.conditions;
  List<NotificationAction> get _actions => _viewModel.actions;
  List<NotificationActionGroup> get _conditionalActionGroups =>
      _viewModel.conditionalActionGroups;
  Set<TransactionField> get _reviewedPredefinedFields =>
      _viewModel.reviewedPredefinedFields;
  NotificationSample? get _sampleOverride => _viewModel.sampleOverride;
  NotificationContext get _testNotificationContext =>
      _viewModel.testNotificationContext;
  bool get _isTestMode => _viewModel.isTestMode;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.rule.name);
    _nameController.addListener(_refresh);
    _viewModel = NotificationRuleEditorViewModel(
      rule: widget.rule,
      notificationContext: widget.notificationContext,
      isTestMode: widget.initialTestMode,
      definitionSampleContext: widget.definitionSampleContext,
    )..addListener(_render);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _viewModel.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);
    final Widget? statusCard = _ruleStatusCard();
    return PopScope(
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
                if (!widget.isSharedActionsEditor &&
                    !widget.rule.isPredefined &&
                    !widget.isTestModeLocked)
                  IconButton(
                    tooltip: _isTestMode
                        ? strings.notificationsRuleExitTestMode
                        : strings.notificationsRuleEnterTestMode,
                    iconSize: NotificationPageHeader.controlIconSize,
                    onPressed: _toggleTestMode,
                    icon: Icon(
                      _isTestMode ? Icons.science : Icons.science_outlined,
                    ),
                  ),
                if (!widget.isSharedActionsEditor && !widget.rule.isPredefined)
                  PopupMenuButton<_RuleAction>(
                    tooltip: strings.notificationsRuleOptions,
                    position: PopupMenuPosition.under,
                    iconSize: NotificationPageHeader.controlIconSize,
                    clipBehavior: Clip.antiAlias,
                    onSelected: _onActionSelected,
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<_RuleAction>>[
                          PopupMenuItem<_RuleAction>(
                            value: _RuleAction.rename,
                            child: Row(
                              children: <Widget>[
                                const Icon(Icons.edit_outlined),
                                const SizedBox(width: 8),
                                Text(strings.notificationsEditDetails),
                              ],
                            ),
                          ),
                          const NotificationMenuDivider(),
                          PopupMenuItem<_RuleAction>(
                            value: _RuleAction.delete,
                            child: Row(
                              children: <Widget>[
                                const Icon(Icons.delete_outline),
                                const SizedBox(width: 8),
                                Text(strings.notificationsRuleDelete),
                              ],
                            ),
                          ),
                        ],
                  ),
              ],
            ),
            floatingActionButton: _isDirty
                ? FloatingActionButton(
                    tooltip: strings.notificationsExtractorSave,
                    onPressed: _apply,
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
                            FadeTransition(
                              key: const Key('rule-status-fade'),
                              opacity: animation,
                              child: child,
                            ),
                    child: statusCard == null
                        ? const SizedBox.shrink(key: Key('rule-status-empty'))
                        : Padding(
                            key: ValueKey<String>(
                              _isTestMode
                                  ? 'rule-status-test'
                                  : 'rule-status-configuration',
                            ),
                            padding: const EdgeInsets.only(bottom: 12),
                            child: statusCard,
                          ),
                  ),
                ),
                if (_currentRule().description.isNotEmpty) ...<Widget>[
                  Text(
                    _currentRule().description,
                    style: context.notificationSectionDescription,
                  ),
                ],
                const SizedBox(height: 12),
                RuleSampleSection(
                  sample: _sampleNotificationContext,
                  hasOverride: _sampleOverride != null,
                  description: strings.notificationsRuleSampleDescription,
                  onEdit: _isBasicSharedActionsEditor ? null : _editSample,
                  onClearOverride: _isBasicSharedActionsEditor
                      ? null
                      : _clearSampleOverride,
                ),
                AnimatedRuleSampleIssues(
                  visible: _isTestMode,
                  groups: _viewModel.requirementGroups(
                    widget.extractors,
                    inheritedActions: widget.sharedActions,
                  ),
                  notificationContext: _testNotificationContext,
                  onEditExtractor: widget.onEditExtractor,
                ),
                const SizedBox(height: 24),
                if (!widget.isSharedActionsEditor &&
                    !widget.rule.isPredefined) ...<Widget>[
                  RuleConditionsSection(
                    conditions: _conditions,
                    title: S.of(context).notificationsRuleAppliesWhenTitle,
                    description: S
                        .of(context)
                        .notificationsRuleAppliesWhenDescription,
                    emptyText: S.of(context).notificationsRuleAlwaysMatches,
                    extractors: widget.extractors,
                    notificationContext: widget.notificationContext,
                    activeNotificationContext: _activeNotificationContext,
                    testNotificationContext: _testNotificationContext,
                    isTestMode: _isTestMode,
                    ruleName: _nameController.text,
                    onReplaceAt: _viewModel.replaceConditionAt,
                    onReplaceAll: _viewModel.replaceConditions,
                    onRemoveAt: _viewModel.removeConditionAt,
                    onMove: _viewModel.moveCondition,
                    onDuplicateAt: _viewModel.duplicateConditionAt,
                    onClipboardChanged:
                        (ConditionClipboardOperation? operation) =>
                            setState(() => _clipboardOperation = operation),
                  ),
                  const SizedBox(height: 24),
                ],
                RuleActionsSection(
                  rule: _currentRule(),
                  actions: _actions,
                  title: widget.isSharedActionsEditor
                      ? S.of(context).notificationsRuleActionsTitle
                      : S.of(context).notificationsRuleAlwaysActionsTitle,
                  description: widget.isSharedActionsEditor
                      ? widget.extractorMode == NotificationExtractorMode.basic
                            ? S
                                  .of(context)
                                  .notificationsDefinitionBasicActionsDescription
                            : S
                                  .of(context)
                                  .notificationsDefinitionSharedActionsDescription
                      : S.of(context).notificationsRuleAlwaysActionsDescription,
                  reviewedPredefinedFields: _reviewedPredefinedFields,
                  extractors: widget.extractors,
                  notificationContext: widget.notificationContext,
                  activeNotificationContext: _activeNotificationContext,
                  extractorMode: widget.extractorMode,
                  ruleName: _nameController.text,
                  onAdd: _viewModel.addAction,
                  onReplaceAt: _viewModel.replaceActionAt,
                  onRemoveAt: _viewModel.removeActionAt,
                  onRemoveTag: _viewModel.removeTagFromAction,
                  onSetPredefinedFieldReviewed:
                      _viewModel.setPredefinedFieldReviewed,
                ),
                if (!widget.isSharedActionsEditor &&
                    !widget.rule.isPredefined) ...<Widget>[
                  const SizedBox(height: 24),
                  RuleConditionalActionGroupsSection(
                    groups: _conditionalActionGroups,
                    onAdd: _addConditionalActionGroup,
                    onEdit: _editConditionalActionGroup,
                    onReplace: _viewModel.replaceConditionalActionGroup,
                    onDuplicate: _viewModel.duplicateConditionalActionGroup,
                    onRemove: _viewModel.removeConditionalActionGroup,
                    onMove: _viewModel.moveConditionalActionGroup,
                  ),
                ],
                const SizedBox(height: 24),
                EffectiveTransactionPreviewCard(
                  rule: _currentRule(),
                  rules: widget.rules,
                  sharedActions: widget.sharedActions,
                  extractors: widget.extractors,
                  notificationContext: _activeNotificationContext,
                  transactionCreationMode: widget.transactionCreationMode,
                  showProvenance: !widget.isSharedActionsEditor,
                ),
                if (_isDirty) const SizedBox(height: 56),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget? _ruleStatusCard() {
    if (widget.isSharedActionsEditor) {
      final NotificationRule rule = _currentRule();
      final AutomaticTransactionReadiness automaticReadiness =
          AutomaticTransactionReadiness.evaluate(
            sharedActions: rule.actions,
            extractors: widget.extractors,
            notificationContext: _testNotificationContext,
          );
      final bool automaticIncomplete =
          widget.transactionCreationMode == TransactionCreationMode.automatic &&
          !automaticReadiness.isReady;
      final bool needsSetup =
          rule.actions.isEmpty &&
          (widget.extractorMode == NotificationExtractorMode.basic ||
              widget.rules.isEmpty);
      final NotificationRuleDiagnostics diagnostics = rule.diagnostics(
        extractors: widget.extractors,
        notificationContext: _testNotificationContext,
      );
      final bool reviewRequired =
          widget.extractorMode == NotificationExtractorMode.basic &&
          (diagnostics.incompleteFields.isNotEmpty ||
              diagnostics.unreviewedPredefinedFields.isNotEmpty);
      if (!needsSetup && !reviewRequired && !automaticIncomplete) return null;
      return MessageStatusCard(
        status: automaticIncomplete
            ? MessageStatus.review
            : needsSetup
            ? MessageStatus.error
            : MessageStatus.review,
        title: automaticIncomplete
            ? S.of(context).notificationsDefinitionAutomaticIncompleteTitle
            : needsSetup
            ? S.of(context).notificationsRuleNeedsSetup
            : S.of(context).notificationsRuleNeedsReview,
        message: automaticIncomplete
            ? automaticReadiness.message(context)
            : needsSetup
            ? widget.extractorMode == NotificationExtractorMode.basic
                  ? S
                        .of(context)
                        .notificationsDefinitionBasicActionsNeedSetupMessage
                  : S
                        .of(context)
                        .notificationsDefinitionSharedActionsNeedSetupMessage
            : S.of(context).notificationsDefinitionNeedsReviewMessage,
      );
    }
    if (_isTestMode) {
      return const RuleTestModeStatusCard();
    }
    if (!widget.showStatusTag) return null;
    final NotificationRule rule = _currentRule();
    final NotificationRuleDiagnostics diagnostics = rule.diagnostics(
      extractors: widget.extractors,
      notificationContext: _testNotificationContext,
    );
    final bool incomplete = diagnostics.incompleteFields.isNotEmpty;
    final bool reviewRequired =
        rule.hasUnconfiguredConditionalActions ||
        (widget.extractorMode == NotificationExtractorMode.basic &&
            (incomplete || diagnostics.unreviewedPredefinedFields.isNotEmpty));
    if (!reviewRequired && !incomplete) return null;
    final bool needsSetup =
        incomplete && widget.extractorMode != NotificationExtractorMode.basic;
    return MessageStatusCard(
      status: needsSetup ? MessageStatus.error : MessageStatus.review,
      title: needsSetup
          ? S.of(context).notificationsRuleNeedsSetup
          : S.of(context).notificationsRuleNeedsReview,
      message: needsSetup
          ? S.of(context).notificationsRuleNeedsSetupMessage
          : rule.hasUnconfiguredConditionalActions
          ? S.of(context).notificationsConditionalActionsNeedReviewMessage
          : S.of(context).notificationsRuleNeedsReviewMessage,
    );
  }

  NotificationContext get _activeNotificationContext =>
      _sampleNotificationContext;

  bool get _isBasicSharedActionsEditor =>
      widget.extractorMode == NotificationExtractorMode.basic &&
      widget.isSharedActionsEditor;

  NotificationContext get _sampleNotificationContext =>
      _viewModel.sampleNotificationContext;

  NotificationRule _currentRule() => _viewModel.currentRule;

  bool get _isDirty => _viewModel.isDirty;

  void _toggleTestMode() {
    if (!widget.isTestModeLocked) _viewModel.toggleTestMode();
  }

  void _refresh() {
    _viewModel.updateName(_nameController.text);
  }

  void _render() {
    if (mounted) setState(() {});
  }

  Future<void> _apply() async {
    await _persistChanges(showFailureMessage: true);
  }

  Future<bool> _persistChanges({required bool showFailureMessage}) async {
    final NotificationRule rule = _currentRule();
    final bool saved = await widget.onSave?.call(rule) ?? true;
    if (!mounted) return saved;
    if (!saved) {
      if (showFailureMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).notificationsDefinitionSaveFailure),
          ),
          snackBarAnimationStyle: ruleEditorMessageAnimation,
        );
      }
      return false;
    }
    _viewModel.acceptChanges();
    return true;
  }

  Future<void> _delete() async {
    final bool? confirmed = await showNotificationDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(S.of(context).notificationsRuleDeleteTitle),
        content: Text(S.of(context).notificationsRuleDeleteDescription),
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
            child: Text(S.of(context).notificationsRuleDelete),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    Navigator.of(context).pop(const NotificationRuleDetailsResult.deleted());
  }

  Future<void> _onActionSelected(_RuleAction action) async {
    if (action == _RuleAction.delete) {
      await _delete();
      return;
    }
    await showNotificationDialog<void>(
      context: context,
      builder: (BuildContext context) => EditRuleDetailsDialog(
        name: _nameController.text,
        description: _currentRule().description,
        onSave: (RuleDetailsUpdate details) {
          if (!mounted) return;
          setState(() {
            _nameController.text = details.name;
            _viewModel.updateName(details.name);
            _viewModel.updateDescription(details.description);
          });
        },
      ),
    );
  }

  Future<void> _editSample() async {
    final NotificationSample? sample = await showSampleNotificationEditor(
      context: context,
      editorContext: SampleNotificationEditorContext.rule,
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

  Future<void> _addConditionalActionGroup() async {
    final RuleCreation? creation = await showNotificationDialog<RuleCreation>(
      context: context,
      builder: (BuildContext context) => AddRuleDialog(
        title: S.of(context).notificationsRuleAddConditionalActions,
        description: S
            .of(context)
            .notificationsRuleNameConditionalActionDescription,
        nameLabel: S.of(context).notificationsRuleConditionalActionName,
        includeDescription: false,
      ),
    );
    if (creation == null || !mounted) return;
    final NotificationActionGroup group = NotificationActionGroup(
      id: newNotificationId(),
      name: creation.name,
      conditions: const <NotificationCondition>[],
      actions: const <NotificationAction>[],
    );
    await _openActionGroup(group);
  }

  Future<void> _editConditionalActionGroup(
    NotificationActionGroup group,
  ) async {
    final NotificationActionGroupDetailsResult? result =
        await Navigator.of(context).push<NotificationActionGroupDetailsResult>(
          MaterialPageRoute<NotificationActionGroupDetailsResult>(
            builder: (BuildContext context) =>
                NotificationActionGroupDetailsPage(
                  group: group,
                  extractors: widget.extractors,
                  notificationContext: _activeNotificationContext,
                  extractorMode: widget.extractorMode,
                  ruleName: _nameController.text,
                  isTestMode: _isTestMode,
                  onToggleTestMode: widget.isTestModeLocked
                      ? null
                      : _toggleTestMode,
                  onEditExtractor: widget.onEditExtractor,
                  onSave: (NotificationActionGroup updated) async {
                    _viewModel.replaceConditionalActionGroup(updated);
                    final bool saved = await _persistChanges(
                      showFailureMessage: false,
                    );
                    if (!saved && mounted) {
                      _viewModel.replaceConditionalActionGroup(group);
                    }
                    return saved;
                  },
                ),
          ),
        );
    if (result == null || !mounted) return;
    _viewModel.removeConditionalActionGroup(group.id);
  }

  Future<void> _openActionGroup(NotificationActionGroup group) async {
    await Navigator.of(context).push<NotificationActionGroupDetailsResult>(
      MaterialPageRoute<NotificationActionGroupDetailsResult>(
        builder: (BuildContext context) => NotificationActionGroupDetailsPage(
          group: group,
          extractors: widget.extractors,
          notificationContext: _activeNotificationContext,
          extractorMode: widget.extractorMode,
          ruleName: _nameController.text,
          isTestMode: _isTestMode,
          onToggleTestMode: widget.isTestModeLocked ? null : _toggleTestMode,
          onEditExtractor: widget.onEditExtractor,
          isNew: true,
          onSave: (NotificationActionGroup updated) async {
            final bool alreadyAdded = _conditionalActionGroups.any(
              (NotificationActionGroup candidate) => candidate.id == updated.id,
            );
            final NotificationActionGroup? previous = alreadyAdded
                ? _conditionalActionGroups.firstWhere(
                    (NotificationActionGroup candidate) =>
                        candidate.id == updated.id,
                  )
                : null;
            if (alreadyAdded) {
              _viewModel.replaceConditionalActionGroup(updated);
            } else {
              _viewModel.addConditionalActionGroup(updated);
            }
            final bool saved = await _persistChanges(showFailureMessage: false);
            if (!saved && mounted) {
              if (previous == null) {
                _viewModel.removeConditionalActionGroup(updated.id);
              } else {
                _viewModel.replaceConditionalActionGroup(previous);
              }
            }
            return saved;
          },
        ),
      ),
    );
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

enum _RuleAction { rename, delete }
