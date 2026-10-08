import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/conditions/all_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/any_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/condition_nesting.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/value_sources/literal_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/value_source.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/conditions/condition_builder_controller.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/conditions/condition_value_type.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_dialog.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/conditions/condition_builder_steps.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_menu_theme.dart';

Future<NotificationCondition?> selectNotificationCondition(
  BuildContext context, {
  required List<RegExpDefinition> extractors,
  required NotificationContext notificationContext,
  NotificationCondition? existingCondition,
  bool allowGroupConditions = true,
  int nestingDepth = 0,
  NotificationCondition? parentGroup,
}) => showNotificationDialog<NotificationCondition>(
  context: context,
  builder: (BuildContext context) => _ConditionBuilderDialog(
    extractors: extractors,
    notificationContext: notificationContext,
    existingCondition: existingCondition,
    allowGroupConditions: allowGroupConditions,
    nestingDepth: nestingDepth,
    parentGroup: parentGroup,
  ),
);

class _ConditionBuilderDialog extends StatefulWidget {
  const _ConditionBuilderDialog({
    required this.extractors,
    required this.notificationContext,
    this.existingCondition,
    required this.allowGroupConditions,
    required this.nestingDepth,
    this.parentGroup,
  });

  final List<RegExpDefinition> extractors;
  final NotificationContext notificationContext;
  final NotificationCondition? existingCondition;
  final bool allowGroupConditions;
  final int nestingDepth;
  final NotificationCondition? parentGroup;

  @override
  State<_ConditionBuilderDialog> createState() =>
      _ConditionBuilderDialogState();
}

class _ConditionBuilderDialogState extends State<_ConditionBuilderDialog> {
  late final ConditionBuilderController _controller;
  final TextEditingController _literalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = ConditionBuilderController(
      extractors: widget.extractors,
      notificationContext: widget.notificationContext,
      existingCondition: widget.existingCondition,
    )..addListener(_changed);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_changed)
      ..dispose();
    _literalController.dispose();
    super.dispose();
  }

  void _changed() {
    if (mounted) setState(() {});
  }

  void _selectKind(ConditionKind kind) {
    final NotificationCondition? result = _controller.selectKind(kind);
    if (result != null) Navigator.of(context).pop(result);
  }

  void _selectSource(ValueSource source, {ConditionValueType? capturedType}) {
    final NotificationCondition? result = _controller.selectSource(
      source,
      capturedType: capturedType,
    );
    _literalController.clear();
    if (result != null) Navigator.of(context).pop(result);
  }

  void _beginEdit(
    ConditionEditedValue value,
    ValueSource source,
    ConditionSourceMode mode,
  ) {
    _literalController.text = source is LiteralValueSource ? source.value : '';
    _controller.beginEdit(value, mode);
  }

  void _saveLiteral() {
    if (_controller.draft.editedValue != null) {
      Navigator.of(
        context,
      ).pop(_controller.saveEditedLiteral(_literalController.text));
      return;
    }
    _selectSource(LiteralValueSource(_literalController.text.trim()));
  }

  Future<void> _pickDateTime() async {
    final DateTime initial =
        DateTime.tryParse(_literalController.text) ?? DateTime.now();
    final DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: initial,
    );
    if (date == null || !mounted) return;
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
    );
    if (time == null || !mounted) return;
    _literalController.text = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    ).toIso8601String();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final ConditionBuilderDraft draft = _controller.draft;
    final Widget step = _step(draft);
    return NotificationMenuTheme(
      child: AlertDialog(
        title: Row(
          children: <Widget>[
            Icon(
              draft.step == ConditionBuilderStep.category ||
                      draft.step == ConditionBuilderStep.kind
                  ? Icons.account_tree_outlined
                  : Icons.tune_outlined,
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(_title(context, draft))),
          ],
        ),
        content: SizedBox(
          width: 440,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _description(context, draft),
                style: context.notificationSectionDescription,
              ),
              const SizedBox(height: 16),
              Flexible(
                fit: FlexFit.loose,
                child: ClipRect(
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeInOut,
                    alignment: Alignment.topCenter,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 220),
                      layoutBuilder: (Widget? current, List<Widget> previous) =>
                          Stack(
                            alignment: Alignment.topLeft,
                            children: <Widget>[
                              ...previous.map(
                                (Widget child) => Positioned.fill(child: child),
                              ),
                              ?current,
                            ],
                          ),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                            final bool entering = child.key == step.key;
                            final double direction = entering == draft.forward
                                ? 1
                                : -1;
                            return AnimatedBuilder(
                              animation: animation,
                              child: child,
                              builder: (BuildContext context, Widget? child) =>
                                  LayoutBuilder(
                                    builder:
                                        (
                                          BuildContext context,
                                          BoxConstraints constraints,
                                        ) => IgnorePointer(
                                          ignoring: animation.value != 1,
                                          child: Transform.translate(
                                            transformHitTests: false,
                                            offset: Offset(
                                              direction *
                                                  (1 - animation.value) *
                                                  constraints.maxWidth,
                                              0,
                                            ),
                                            child: FadeTransition(
                                              opacity: animation,
                                              child: child,
                                            ),
                                          ),
                                        ),
                                  ),
                            );
                          },
                      child: step,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          if (!_controller.isEditing &&
              (draft.step == ConditionBuilderStep.kind ||
                  draft.step == ConditionBuilderStep.source ||
                  (draft.step == ConditionBuilderStep.category &&
                      draft.notDepth > 0)))
            TextButton(
              onPressed: _controller.back,
              child: Text(S.of(context).notificationsActionBack),
            ),
          if (_showSave(draft))
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: _literalController,
              builder:
                  (BuildContext context, TextEditingValue value, Widget? _) =>
                      FilledButton(
                        onPressed: _canSaveLiteral(value.text)
                            ? _saveLiteral
                            : null,
                        child: Text(S.of(context).notificationsActionSave),
                      ),
            )
          else if (draft.step == ConditionBuilderStep.overview)
            FilledButton(
              onPressed:
                  _controller.hasChangedOperands && draft.editedValue == null
                  ? () => Navigator.of(
                      context,
                    ).pop(_controller.buildBinaryCondition())
                  : null,
              child: Text(S.of(context).notificationsActionSave),
            ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
        ],
      ),
    );
  }

  Widget _step(ConditionBuilderDraft draft) => switch (draft.step) {
    ConditionBuilderStep.category => ConditionCategoryStep(
      key: ValueKey<String>('condition-categories-${draft.notDepth}'),
      allowGroupConditions:
          widget.allowGroupConditions &&
          widget.nestingDepth + draft.notDepth < maximumConditionNestingDepth,
      onSelected: _controller.selectCategory,
    ),
    ConditionBuilderStep.kind => ConditionKindStep(
      key: ValueKey<String>('condition-kinds-${draft.notDepth}'),
      kinds: ConditionKind.values
          .where(
            (ConditionKind kind) =>
                (draft.notDepth == 0 || kind != ConditionKind.not) &&
                switch (draft.category!) {
                  ConditionKindCategory.value =>
                    kind != ConditionKind.all &&
                        kind != ConditionKind.any &&
                        kind != ConditionKind.not,
                  ConditionKindCategory.group =>
                    kind == ConditionKind.all ||
                        kind == ConditionKind.any ||
                        kind == ConditionKind.not,
                },
          )
          .toList(),
      isDisabled: (ConditionKind kind) =>
          (kind == ConditionKind.all && widget.parentGroup is AllCondition) ||
          (kind == ConditionKind.any && widget.parentGroup is AnyCondition),
      onSelected: _selectKind,
    ),
    ConditionBuilderStep.source => ConditionSourceStep(
      key: ValueKey<String>(
        'condition-source-${draft.selectingRight ? 'right' : 'left'}',
      ),
      controller: _controller,
      literalController: _literalController,
      onSourceSelected: _selectSource,
      onModeChanged: _controller.setSourceMode,
      onPickDateTime: _pickDateTime,
    ),
    ConditionBuilderStep.overview => ConditionOverviewStep(
      key: ValueKey<String>(
        'condition-overview-${draft.editedValue?.name ?? 'review'}',
      ),
      controller: _controller,
      literalController: _literalController,
      onBeginEdit: _beginEdit,
      onSourceSelected: _selectSource,
      onModeChanged: _controller.setSourceMode,
      onCancelEdit: _controller.cancelEdit,
      onPickDateTime: _pickDateTime,
    ),
  };

  bool _showSave(ConditionBuilderDraft draft) =>
      draft.sourceMode == ConditionSourceMode.literal &&
      (draft.step == ConditionBuilderStep.source || draft.editedValue != null);

  bool _canSaveLiteral(String value) {
    final ConditionValueType type =
        _controller.selectedLeftType ?? ConditionValueType.text;
    return type.isValid(value) &&
        (_controller.draft.editedValue == null ||
            _controller.pendingLiteralDiffers(value));
  }

  String _title(BuildContext context, ConditionBuilderDraft draft) =>
      switch (draft.step) {
        ConditionBuilderStep.category =>
          draft.notDepth == 0
              ? S.of(context).notificationsRuleAddCondition
              : conditionKindLabel(context, ConditionKind.not),
        ConditionBuilderStep.kind =>
          draft.category == ConditionKindCategory.value
              ? S.of(context).notificationsConditionValueCategory
              : S.of(context).notificationsConditionGroupCategory,
        ConditionBuilderStep.source => conditionKindLabel(context, draft.kind!),
        ConditionBuilderStep.overview =>
          draft.editedValue == null
              ? S.of(context).notificationsConditionEdit
              : conditionKindLabel(context, draft.kind!),
      };

  String _description(BuildContext context, ConditionBuilderDraft draft) =>
      switch (draft.step) {
        ConditionBuilderStep.category =>
          draft.notDepth == 0
              ? S.of(context).notificationsConditionChooseCategory
              : S.of(context).notificationsConditionSelectNegated,
        ConditionBuilderStep.kind =>
          draft.category == ConditionKindCategory.value
              ? S.of(context).notificationsConditionChooseValueKind
              : S.of(context).notificationsConditionChooseGroupKind,
        ConditionBuilderStep.source =>
          draft.selectingRight
              ? S.of(context).notificationsConditionCompareDescription
              : S.of(context).notificationsConditionValueDescription,
        ConditionBuilderStep.overview =>
          draft.editedValue == null
              ? S.of(context).notificationsConditionReview
              : draft.editedValue == ConditionEditedValue.right
              ? S.of(context).notificationsConditionCompareDescription
              : S.of(context).notificationsConditionValueDescription,
      };
}
