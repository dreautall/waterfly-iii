import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule_diagnostics.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/planning/automatic_transaction_readiness.dart';
import 'package:waterflyiii/notifications/presentation/definitions/widgets/definition_editor_workflows.dart';
import 'package:waterflyiii/notifications/presentation/definitions/widgets/definition_setup_mode_section.dart';
import 'package:waterflyiii/notifications/presentation/definitions/widgets/definition_sample_card.dart';
import 'package:waterflyiii/notifications/presentation/definitions/widgets/definition_rules_section.dart';
import 'package:waterflyiii/notifications/presentation/definitions/widgets/definition_shared_actions_section.dart';
import 'package:waterflyiii/notifications/presentation/definitions/widgets/definition_extractors_section.dart';
import 'package:waterflyiii/notifications/presentation/definitions/widgets/definition_options_section.dart';
import 'package:waterflyiii/notifications/presentation/definitions/widgets/automatic_transaction_readiness_display.dart';
import 'package:waterflyiii/notifications/presentation/definitions/widgets/notification_definition_status_display.dart';
import 'package:waterflyiii/notifications/presentation/definitions/controllers/notification_definition_editor_view_model.dart';
import 'package:waterflyiii/notifications/presentation/shared/message_status_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_menu_theme.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_page_header.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_editor_dialogs.dart';
import 'package:waterflyiii/notifications/presentation/alerts/notification_alert_display.dart';

class NotificationDefinitionDetailsPage extends StatefulWidget {
  const NotificationDefinitionDetailsPage({
    super.key,
    required this.definition,
    required this.onSave,
    this.onDelete,
    this.initialRuleId,
    this.initialDraftRule,
    this.initialRuleNotificationContext,
    this.migrationAlerts = const <NotificationAlert>[],
  });

  final NotificationDefinition definition;
  final Future<bool> Function(NotificationDefinition definition) onSave;
  final Future<bool> Function()? onDelete;
  final String? initialRuleId;
  final NotificationRule? initialDraftRule;
  final NotificationContext? initialRuleNotificationContext;
  final List<NotificationAlert> migrationAlerts;

  @override
  State<NotificationDefinitionDetailsPage> createState() =>
      _NotificationDefinitionDetailsPageState();
}

class _NotificationDefinitionDetailsPageState
    extends State<NotificationDefinitionDetailsPage> {
  static const double _floatingSaveButtonSize = 56;
  static const double _floatingSaveButtonMargin = 16;
  static const double _floatingSaveButtonGap = 12;
  static const double _floatingSaveButtonSpacing =
      _floatingSaveButtonSize +
      _floatingSaveButtonMargin +
      _floatingSaveButtonGap;
  late final TextEditingController _sampleTitleController;
  late final TextEditingController _sampleBodyController;
  late final ScrollController _scrollController;
  late final NotificationDefinitionEditorViewModel _viewModel;
  final GlobalKey _automaticWarningKey = GlobalKey();
  final GlobalKey _saveButtonKey = GlobalKey();

  List<RegExpDefinition> get _extractors => _viewModel.extractors;
  List<NotificationRule> get _rules => _viewModel.rules;
  NotificationExtractorMode get _extractorMode => _viewModel.extractorMode;
  TransactionCreationMode get _transactionCreationMode =>
      _viewModel.transactionCreationMode;
  bool get _isSaving => _viewModel.isSaving;
  AutomaticTransactionReadiness get _automaticReadiness =>
      _currentDefinition().automaticTransactionReadiness;
  NotificationDefinitionEditorWorkflows get _workflows =>
      NotificationDefinitionEditorWorkflows(
        context: context,
        definition: widget.definition,
        viewModel: _viewModel,
        sampleTitleController: _sampleTitleController,
        sampleBodyController: _sampleBodyController,
        save: _save,
        refresh: _refresh,
      );

  @override
  void initState() {
    super.initState();
    _sampleTitleController = TextEditingController(
      text: widget.definition.sampleTitle ?? '',
    );
    _sampleBodyController = TextEditingController(
      text: widget.definition.sampleBody ?? '',
    );
    _scrollController = ScrollController();
    _viewModel = NotificationDefinitionEditorViewModel(widget.definition)
      ..addListener(_refresh);
    final NotificationRule? initialDraftRule = widget.initialDraftRule;
    final String? initialRuleId = widget.initialRuleId;
    if (initialDraftRule != null) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _workflows.editInitialDraftRule(
          initialDraftRule,
          widget.initialRuleNotificationContext,
        ),
      );
    } else if (initialRuleId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final NotificationRule? rule = _rules
            .cast<NotificationRule?>()
            .firstWhere(
              (NotificationRule? candidate) => candidate?.id == initialRuleId,
              orElse: () => null,
            );
        if (rule != null && mounted) await _workflows.editRule(rule);
      });
    } else if (_sampleTitleController.text.isEmpty ||
        _sampleBodyController.text.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _workflows.editSample(),
      );
    }
  }

  @override
  void dispose() {
    _sampleTitleController.dispose();
    _sampleBodyController.dispose();
    _scrollController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);
    final Widget? statusCard = _definitionStatusCard();
    return PopScope(
      canPop: !_isDirty,
      onPopInvokedWithResult: _confirmDiscard,
      child: NotificationMenuTheme(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: NotificationPageHeader(
            scrollController: _scrollController,
            title: Text(widget.definition.name),
            actions: <Widget>[
              PopupMenuButton<DefinitionEditorMenuAction>(
                tooltip: strings.notificationsDefinitionOptions,
                position: PopupMenuPosition.under,
                iconSize: NotificationPageHeader.controlIconSize,
                onSelected: (DefinitionEditorMenuAction action) => _workflows
                    .handleMenuAction(action, delete: widget.onDelete),
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<DefinitionEditorMenuAction>>[
                      if (_extractorMode == NotificationExtractorMode.basic)
                        PopupMenuItem<DefinitionEditorMenuAction>(
                          value: DefinitionEditorMenuAction.convertToAdvanced,
                          child: Row(
                            children: <Widget>[
                              const Icon(Icons.tune),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  strings
                                      .notificationsDefinitionConvertToAdvanced,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (_extractorMode == NotificationExtractorMode.advanced)
                        PopupMenuItem<DefinitionEditorMenuAction>(
                          value: DefinitionEditorMenuAction.convertToBasic,
                          child: Row(
                            children: <Widget>[
                              const Icon(Icons.auto_awesome),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  strings.notificationsDefinitionConvertToBasic,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (widget.onDelete !=
                          null) ...<PopupMenuEntry<DefinitionEditorMenuAction>>[
                        if (_extractorMode !=
                            NotificationExtractorMode.notConfigured)
                          const NotificationMenuDivider(),
                        PopupMenuItem<DefinitionEditorMenuAction>(
                          value: DefinitionEditorMenuAction.delete,
                          child: Row(
                            children: <Widget>[
                              const Icon(Icons.delete_outline),
                              const SizedBox(width: 12),
                              Text(strings.notificationsDefinitionDelete),
                            ],
                          ),
                        ),
                      ],
                    ],
              ),
            ],
          ),
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
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                alignment: Alignment.topCenter,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 140),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  child: statusCard == null
                      ? const SizedBox.shrink(
                          key: Key('definition-status-empty'),
                        )
                      : Padding(
                          key: ValueKey<String>(
                            'definition-status-${_currentDefinition().status.name}-${_transactionCreationMode.name}',
                          ),
                          padding: const EdgeInsets.only(bottom: 24),
                          child: statusCard,
                        ),
                ),
              ),
              Text(
                strings.notificationsDefinitionSampleNotification,
                style: context.notificationSectionTitle,
              ),
              const SizedBox(height: 4),
              Text(
                strings.notificationsDefinitionSampleDescription,
                style: context.notificationSectionDescription,
              ),
              const SizedBox(height: 12),
              DefinitionSampleCard(
                applicationId: widget.definition.applicationId,
                title: _sampleTitleController.text,
                body: _sampleBodyController.text,
                receivedAt: widget.definition.createdAt,
                onEdit: _workflows.editSample,
              ),
              if (_extractorMode ==
                  NotificationExtractorMode.notConfigured) ...<Widget>[
                const SizedBox(height: 24),
                DefinitionSetupModeSection(
                  mode: _extractorMode,
                  hasSample:
                      _sampleTitleController.text.trim().isNotEmpty &&
                      _sampleBodyController.text.trim().isNotEmpty,
                  onModeSelected: _selectExtractorMode,
                ),
              ] else ...<Widget>[
                const SizedBox(height: 24),
                DefinitionExtractorsSection(
                  extractors: _extractors,
                  extractorMode: _extractorMode,
                  notificationContext: _workflows.sampleContext(),
                  onEditExtractor: _workflows.editExtractor,
                  onAddExtractor: _workflows.addExtractor,
                ),
                const SizedBox(height: 24),
                DefinitionSharedActionsSection(
                  actions: _viewModel.sharedActions,
                  isBasicMode:
                      _extractorMode == NotificationExtractorMode.basic,
                  needsSetup: _sharedActionsNeedSetup(),
                  needsReview: _sharedActionsNeedReview(),
                  automaticReadiness: _automaticReadiness,
                  createAutomatically:
                      _transactionCreationMode ==
                      TransactionCreationMode.automatic,
                  onEdit: _workflows.editSharedActions,
                ),
                if (_extractorMode ==
                    NotificationExtractorMode.advanced) ...<Widget>[
                  const SizedBox(height: 24),
                  DefinitionRulesSection(
                    rules: _rules,
                    extractors: _extractors,
                    notificationContext: _workflows.sampleContext(),
                    onEditRule: _workflows.editRule,
                    onAddRule: _workflows.addRule,
                    onMoveRule: _viewModel.moveRule,
                  ),
                ],
                const SizedBox(height: 24),
                DefinitionOptionsSection(
                  createAutomatically:
                      _transactionCreationMode ==
                      TransactionCreationMode.automatic,
                  onCreateAutomaticallyChanged: _setTransactionCreationMode,
                  automaticReadiness: _automaticReadiness,
                  warningKey: _automaticWarningKey,
                  onWarningRevealed: _keepAutomaticWarningVisible,
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  height: _isDirty ? _floatingSaveButtonSpacing : 0,
                ),
              ],
            ],
          ),
          floatingActionButton: _isDirty
              ? FloatingActionButton(
                  key: _saveButtonKey,
                  tooltip: strings.notificationsDefinitionSave,
                  onPressed: _isSaving ? null : _save,
                  child: const Icon(Icons.save_outlined),
                )
              : null,
        ),
      ),
    );
  }

  Widget? _definitionStatusCard() {
    final List<Widget> cards = <Widget>[];
    final NotificationDefinition definition = _currentDefinition();
    final NotificationDefinitionStatus status = definition.status;
    if (widget.migrationAlerts.isNotEmpty ||
        definition.migrationReviewIssues.isNotEmpty) {
      final List<String> messages = widget.migrationAlerts.isNotEmpty
          ? widget.migrationAlerts
                .map((NotificationAlert alert) {
                  final NotificationMigrationIssue? issue =
                      alert.migrationIssue;
                  if (issue != null) return issue.message(context);
                  return alert.kind == NotificationAlertKind.migrationFailed
                      ? S
                            .of(context)
                            .notificationsDefinitionMigrationFailedMessage
                      : S
                            .of(context)
                            .notificationsDefinitionMigrationReviewMessage;
                })
                .toList(growable: false)
          : definition.migrationReviewIssues
                .map(
                  (NotificationMigrationIssue issue) => issue.message(context),
                )
                .toList(growable: false);
      cards.add(
        MessageStatusCard(
          status: MessageStatus.review,
          title: S
              .of(context)
              .notificationsDefinitionMigrationNeedsAttention(
                widget.migrationAlerts.isNotEmpty
                    ? widget.migrationAlerts.length
                    : definition.migrationReviewIssues.length,
              ),
          message: messages.join(' '),
        ),
      );
    }
    if (status != NotificationDefinitionStatus.ready &&
        widget.migrationAlerts.isEmpty &&
        !definition.requiresMigrationReview) {
      cards.add(
        MessageStatusCard(
          status: status.messageStatus,
          title: status.label(context),
          message: _definitionStatusMessage(definition, status),
        ),
      );
    }
    if (cards.isEmpty) return null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        for (final (int index, Widget card) in cards.indexed) ...<Widget>[
          if (index > 0) const SizedBox(height: 12),
          card,
        ],
      ],
    );
  }

  String _definitionStatusMessage(
    NotificationDefinition definition,
    NotificationDefinitionStatus status,
  ) {
    if (status != NotificationDefinitionStatus.needsSetup) {
      if (_transactionCreationMode == TransactionCreationMode.automatic &&
          !definition.automaticTransactionReadiness.isReady) {
        return definition.automaticTransactionReadiness.message(context);
      }
      if (status == NotificationDefinitionStatus.needsReview &&
          definition.hasUnconfiguredConditionalActions) {
        return S
            .of(context)
            .notificationsDefinitionConditionalActionsNeedReviewMessage;
      }
      return status.message(context);
    }
    final List<String> missingRequirements = <String>[
      if ((definition.sampleTitle?.trim().isNotEmpty ?? false) == false ||
          (definition.sampleBody?.trim().isNotEmpty ?? false) == false)
        S.of(context).notificationsDefinitionSetupRequirementSample,
      if (definition.extractors.isEmpty)
        S.of(context).notificationsDefinitionSetupRequirementExtractors,
      if (definition.rules.isEmpty && definition.sharedActions.isEmpty)
        S.of(context).notificationsDefinitionSetupRequirementRulesOrActions,
      if (definition.extractorMode == NotificationExtractorMode.advanced &&
          definition.hasIncompleteActions)
        S.of(context).notificationsDefinitionSetupRequirementActionFields,
    ];
    if (missingRequirements.isEmpty) {
      return status.message(context);
    }
    return S
        .of(context)
        .notificationsDefinitionNeedsSetupSpecificMessage(
          _localizedList(missingRequirements),
        );
  }

  String _localizedList(List<String> values) {
    if (values.length <= 1) return values.single;
    if (values.length == 2) {
      return S.of(context).notificationsListPair(values.first, values.last);
    }
    return S
        .of(context)
        .notificationsListMultiple(
          values.sublist(0, values.length - 1).join(', '),
          values.last,
        );
  }

  bool _sharedActionsNeedSetup() =>
      _viewModel.sharedActions.isEmpty &&
      (_extractorMode == NotificationExtractorMode.basic || _rules.isEmpty);

  bool _sharedActionsNeedReview() {
    if (_transactionCreationMode == TransactionCreationMode.automatic &&
        !_automaticReadiness.isReady) {
      return true;
    }
    if (_extractorMode != NotificationExtractorMode.basic) return false;
    final NotificationRule rule = _viewModel.createSharedActionsRule('');
    final NotificationContext sample = _workflows.sampleContext();
    final NotificationRuleDiagnostics diagnostics = rule.diagnostics(
      extractors: _extractors,
      notificationContext: sample,
    );
    return diagnostics.incompleteFields.isNotEmpty ||
        diagnostics.unreviewedPredefinedFields.isNotEmpty;
  }

  void _selectExtractorMode(NotificationExtractorMode mode) {
    _viewModel.configure(mode);
  }

  void _setTransactionCreationMode(bool automatically) {
    _viewModel.setTransactionCreationMode(automatically);
  }

  void _keepAutomaticWarningVisible() {
    final BuildContext? warningContext = _automaticWarningKey.currentContext;
    if (warningContext == null || !_scrollController.hasClients) return;
    final RenderBox? warningBox =
        warningContext.findRenderObject() as RenderBox?;
    final RenderBox? viewportBox =
        Scrollable.maybeOf(warningContext)?.context.findRenderObject()
            as RenderBox?;
    if (warningBox == null ||
        viewportBox == null ||
        !warningBox.attached ||
        !viewportBox.attached) {
      return;
    }

    final Offset viewportOrigin = viewportBox.localToGlobal(Offset.zero);
    final Rect warningRect =
        warningBox.localToGlobal(Offset.zero) & warningBox.size;
    final EdgeInsets safePadding = MediaQuery.paddingOf(context);
    double safeBottom =
        viewportOrigin.dy + viewportBox.size.height - safePadding.bottom - 16;
    final RenderBox? saveButtonBox =
        _saveButtonKey.currentContext?.findRenderObject() as RenderBox?;
    if (saveButtonBox != null && saveButtonBox.attached) {
      safeBottom =
          saveButtonBox.localToGlobal(Offset.zero).dy - _floatingSaveButtonGap;
    }
    final double delta = warningRect.bottom - safeBottom;
    if (delta <= 0.5) return;

    final ScrollPosition position = _scrollController.position;
    _scrollController.animateTo(
      (position.pixels + delta).clamp(
        position.minScrollExtent,
        position.maxScrollExtent,
      ),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  Future<bool> _save() async {
    final NotificationDefinitionSaveResult result = await _viewModel.save(
      sampleTitle: _sampleTitleController.text,
      sampleBody: _sampleBodyController.text,
      persist: widget.onSave,
    );
    if (!mounted) return false;
    if (result.hasDanglingActions) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            S
                .of(context)
                .notificationsDefinitionFixDanglingActions(
                  result.danglingActionCount,
                ),
          ),
        ),
      );
      return false;
    }
    if (result.failed && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).notificationsDefinitionSaveFailure),
        ),
      );
    }
    return result.succeeded;
  }

  NotificationDefinition _currentDefinition() {
    return _viewModel.currentDefinition(
      sampleTitle: _sampleTitleController.text,
      sampleBody: _sampleBodyController.text,
    );
  }

  bool get _isDirty {
    _currentDefinition();
    return _viewModel.isDirty;
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  Future<void> _confirmDiscard(bool didPop, Object? _) async {
    if (didPop || !_isDirty) {
      return;
    }
    final bool discard = await showDiscardChangesDialog(context);
    if (!mounted || !discard) return;
    Navigator.of(context).pop();
  }
}
