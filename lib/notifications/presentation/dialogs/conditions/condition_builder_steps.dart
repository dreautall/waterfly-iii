import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/conditions/condition_nesting.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/value_sources/literal_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/value_source.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/conditions/condition_builder_controller.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/conditions/condition_value_type.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/values/extractor_capture_picker.dart';
import 'package:waterflyiii/notifications/presentation/shared/dialog_expander_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/dialog_selector_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_input_decoration.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_date_time_formatter.dart';

typedef ConditionSourceSelected =
    void Function(ValueSource source, {ConditionValueType? capturedType});

class ConditionCategoryStep extends StatelessWidget {
  const ConditionCategoryStep({
    super.key,
    required this.allowGroupConditions,
    required this.onSelected,
  });

  final bool allowGroupConditions;
  final ValueChanged<ConditionKindCategory> onSelected;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      DialogSelectorCard(
        margin: const EdgeInsets.only(bottom: 8),
        leading: const Icon(Icons.rule_outlined),
        title: Text(S.of(context).notificationsConditionValueCategory),
        subtitle: Text(
          S.of(context).notificationsConditionValueCategoryDescription,
          style: context.notificationSupportingText,
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => onSelected(ConditionKindCategory.value),
      ),
      DialogSelectorCard(
        leading: const Icon(Icons.account_tree_outlined),
        title: Text(S.of(context).notificationsConditionGroupCategory),
        subtitle: Text(
          allowGroupConditions
              ? S.of(context).notificationsConditionGroupCategoryDescription
              : S
                    .of(context)
                    .notificationsConditionMaximumNestingDescription(
                      maximumConditionNestingDepth,
                    ),
          style: context.notificationSupportingText,
        ),
        trailing: allowGroupConditions ? const Icon(Icons.chevron_right) : null,
        onTap: allowGroupConditions
            ? () => onSelected(ConditionKindCategory.group)
            : null,
      ),
    ],
  );
}

class ConditionKindStep extends StatelessWidget {
  const ConditionKindStep({
    super.key,
    required this.kinds,
    required this.isDisabled,
    required this.onSelected,
  });

  final List<ConditionKind> kinds;
  final bool Function(ConditionKind kind) isDisabled;
  final ValueChanged<ConditionKind> onSelected;

  @override
  Widget build(BuildContext context) => ListView(
    shrinkWrap: true,
    physics: const ClampingScrollPhysics(),
    padding: const EdgeInsets.all(4),
    children: kinds.map((ConditionKind kind) {
      final bool disabled = isDisabled(kind);
      return DialogSelectorCard(
        margin: const EdgeInsets.only(bottom: 8),
        leading: Icon(_kindIcon(kind)),
        title: Text(conditionKindLabel(context, kind)),
        subtitle: Text(
          disabled
              ? S.of(context).notificationsConditionMergedGroupDescription
              : _kindDescription(context, kind),
          style: context.notificationSupportingText,
        ),
        trailing: disabled ? null : const Icon(Icons.chevron_right),
        onTap: disabled ? null : () => onSelected(kind),
      );
    }).toList(),
  );
}

class ConditionSourceStep extends StatelessWidget {
  const ConditionSourceStep({
    super.key,
    required this.controller,
    required this.literalController,
    required this.onSourceSelected,
    required this.onModeChanged,
    required this.onPickDateTime,
  });

  final ConditionBuilderController controller;
  final TextEditingController literalController;
  final ConditionSourceSelected onSourceSelected;
  final ValueChanged<ConditionSourceMode?> onModeChanged;
  final VoidCallback onPickDateTime;

  @override
  Widget build(BuildContext context) {
    final ConditionBuilderDraft draft = controller.draft;
    final bool requiresExtractor =
        draft.kind == ConditionKind.exists ||
        (!draft.selectingRight &&
            (draft.kind == ConditionKind.equals ||
                draft.kind == ConditionKind.contains ||
                (draft.kind?.isOrdered ?? false)));
    final bool hasCapture = ExtractorCapturePicker.hasAvailableCapture(
      extractors: controller.extractors,
      notificationContext: controller.notificationContext,
      isCaptureAllowed: (RegExpDefinition extractor, String _, String value) =>
          controller.captureIsAllowed(
            extractor,
            value,
            selectingRight: draft.selectingRight,
          ),
    );
    final List<ConditionSourceMode> modes = <ConditionSourceMode>[
      if (hasCapture) ConditionSourceMode.extractor,
      if (!requiresExtractor) ConditionSourceMode.literal,
    ];
    final ConditionSourceMode? selectedMode =
        draft.sourceMode ?? (modes.length == 1 ? modes.single : null);
    if (draft.sourceMode == null && modes.length == 1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) onModeChanged(modes.single);
      });
    }
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.all(4),
      children: <Widget>[
        if (hasCapture)
          _SourceOption(
            mode: ConditionSourceMode.extractor,
            selectedMode: selectedMode,
            icon: Icons.text_fields_outlined,
            title: S.of(context).notificationsConditionExtractorCapture,
            subtitle: S.of(context).notificationsConditionUseCapture,
            onModeChanged: onModeChanged,
            child: ExtractorCapturePicker(
              extractors: controller.extractors,
              notificationContext: controller.notificationContext,
              emptyMessage: S.of(context).notificationsConditionNoCaptures,
              isCaptureAllowed:
                  (RegExpDefinition extractor, String _, String value) =>
                      controller.captureIsAllowed(
                        extractor,
                        value,
                        selectingRight: draft.selectingRight,
                      ),
              onSelected: (ExtractorCaptureSelection selection) =>
                  onSourceSelected(
                    selection.toValueSource(),
                    capturedType: draft.selectingRight
                        ? null
                        : ConditionValueType.parse(selection.value),
                  ),
            ),
          ),
        if (!requiresExtractor)
          _SourceOption(
            mode: ConditionSourceMode.literal,
            selectedMode: selectedMode,
            icon: Icons.edit_outlined,
            title: _literalTitle(context, _literalType(controller)),
            subtitle: _literalDescription(context, _literalType(controller)),
            onModeChanged: onModeChanged,
            child: _LiteralEditor(
              type: _literalType(controller),
              controller: literalController,
              onPickDateTime: onPickDateTime,
            ),
          ),
      ],
    );
  }
}

class ConditionOverviewStep extends StatelessWidget {
  const ConditionOverviewStep({
    super.key,
    required this.controller,
    required this.literalController,
    required this.onBeginEdit,
    required this.onSourceSelected,
    required this.onModeChanged,
    required this.onCancelEdit,
    required this.onPickDateTime,
  });

  final ConditionBuilderController controller;
  final TextEditingController literalController;
  final void Function(
    ConditionEditedValue value,
    ValueSource source,
    ConditionSourceMode mode,
  )
  onBeginEdit;
  final ConditionSourceSelected onSourceSelected;
  final ValueChanged<ConditionSourceMode?> onModeChanged;
  final VoidCallback onCancelEdit;
  final VoidCallback onPickDateTime;

  @override
  Widget build(BuildContext context) {
    final ConditionBuilderDraft draft = controller.draft;
    return ListView(
      key: const ValueKey<String>('condition-edit-overview'),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.all(4),
      children: <Widget>[
        _valueCard(context, ConditionEditedValue.left, draft.left!),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            _kindVerb(context, draft.kind!),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        _valueCard(context, ConditionEditedValue.right, draft.right!),
      ],
    );
  }

  Widget _valueCard(
    BuildContext context,
    ConditionEditedValue value,
    ValueSource source,
  ) {
    final ConditionBuilderDraft draft = controller.draft;
    final bool expanded = draft.editedValue == value;
    final ConditionSourceMode current = source is LiteralValueSource
        ? ConditionSourceMode.literal
        : ConditionSourceMode.extractor;
    final ConditionSourceMode displayedMode = expanded
        ? draft.sourceMode ?? current
        : current;
    return DialogExpanderCard(
      key: ValueKey<String>('condition-edit-${value.name}'),
      margin: EdgeInsets.zero,
      leading: Icon(
        displayedMode == ConditionSourceMode.literal
            ? Icons.edit_outlined
            : Icons.text_fields_outlined,
      ),
      title: Text(
        displayedMode == ConditionSourceMode.literal
            ? S.of(context).notificationsConditionLiteralValue
            : S.of(context).notificationsConditionExtractorCapture,
      ),
      subtitle: Text(
        displayedMode == current
            ? _sourceSubtitle(context, source)
            : displayedMode == ConditionSourceMode.literal
            ? literalController.text
            : S.of(context).notificationsConditionUseCapture,
        style: context.notificationSupportingText,
      ),
      expanded: expanded,
      onTap: () =>
          expanded ? onCancelEdit() : onBeginEdit(value, source, current),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (value == ConditionEditedValue.right) ...<Widget>[
            PopupMenuButton<ConditionSourceMode>(
              tooltip: S.of(context).notificationsConditionChangeValueType,
              position: PopupMenuPosition.under,
              icon: const Icon(Icons.more_vert),
              onSelected: (ConditionSourceMode mode) =>
                  onBeginEdit(value, source, mode),
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<ConditionSourceMode>>[
                    PopupMenuItem<ConditionSourceMode>(
                      value: current == ConditionSourceMode.literal
                          ? ConditionSourceMode.extractor
                          : ConditionSourceMode.literal,
                      child: Text(
                        current == ConditionSourceMode.literal
                            ? S
                                  .of(context)
                                  .notificationsConditionExtractorCapture
                            : S.of(context).notificationsConditionLiteralValue,
                      ),
                    ),
                  ],
            ),
            const SizedBox(width: 8),
          ],
          AnimatedRotation(
            turns: expanded ? 0.5 : 0,
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeInOut,
            child: const Icon(Icons.expand_more),
          ),
        ],
      ),
      belly: expanded
          ? _editor(controller.draft.sourceMode)
          : const SizedBox.shrink(),
    );
  }

  Widget _editor(ConditionSourceMode? mode) => switch (mode) {
    ConditionSourceMode.literal => _LiteralEditor(
      type: _literalType(controller),
      controller: literalController,
      onPickDateTime: onPickDateTime,
    ),
    ConditionSourceMode.extractor => ExtractorCapturePicker(
      extractors: controller.extractors,
      notificationContext: controller.notificationContext,
      emptyMessage: '',
      isCaptureAllowed: (RegExpDefinition extractor, String _, String value) =>
          controller.captureIsAllowed(
            extractor,
            value,
            selectingRight:
                controller.draft.editedValue == ConditionEditedValue.right,
          ),
      onSelected: (ExtractorCaptureSelection selection) => onSourceSelected(
        selection.toValueSource(),
        capturedType: controller.draft.editedValue == ConditionEditedValue.left
            ? ConditionValueType.parse(selection.value)
            : null,
      ),
    ),
    null => const SizedBox.shrink(),
  };

  String _sourceSubtitle(BuildContext context, ValueSource source) {
    if (source is LiteralValueSource) {
      final ConditionValueType? type = controller.selectedLeftType;
      if (type == ConditionValueType.date ||
          type == ConditionValueType.dateTime) {
        final DateTime? date = DateTime.tryParse(source.value.trim());
        if (date != null) {
          final String formattedDate = formatNotificationDate(context, date);
          if (type == ConditionValueType.date ||
              !RegExp(r'^\d{4}-\d{2}-\d{2}T').hasMatch(source.value.trim())) {
            return formattedDate;
          }
          return formatNotificationDateTime(context, date);
        }
      }
      return source.value;
    }
    if (source is RegExpCaptureValueSource) {
      final RegExpDefinition? extractor = controller.extractors
          .cast<RegExpDefinition?>()
          .firstWhere(
            (RegExpDefinition? item) => item?.id == source.extractorId,
            orElse: () => null,
          );
      return extractor?.definitionName ??
          S.of(context).notificationsConditionDeletedExtractor;
    }
    return source.runtimeType.toString();
  }
}

class _SourceOption extends StatelessWidget {
  const _SourceOption({
    required this.mode,
    required this.selectedMode,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onModeChanged,
    required this.child,
  });

  final ConditionSourceMode mode;
  final ConditionSourceMode? selectedMode;
  final IconData icon;
  final String title;
  final String subtitle;
  final ValueChanged<ConditionSourceMode?> onModeChanged;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bool expanded = selectedMode == mode;
    return DialogExpanderCard(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle, style: context.notificationSupportingText),
      expanded: expanded,
      onTap: () => onModeChanged(expanded ? null : mode),
      belly: child,
    );
  }
}

class _LiteralEditor extends StatelessWidget {
  const _LiteralEditor({
    required this.type,
    required this.controller,
    required this.onPickDateTime,
  });

  final ConditionValueType type;
  final TextEditingController controller;
  final VoidCallback onPickDateTime;

  @override
  Widget build(BuildContext context) {
    if (type == ConditionValueType.dateTime) {
      return ValueListenableBuilder<TextEditingValue>(
        valueListenable: controller,
        builder: (BuildContext context, TextEditingValue value, Widget? _) =>
            OutlinedButton.icon(
              key: const Key('condition-literal-value'),
              onPressed: onPickDateTime,
              icon: const Icon(Icons.schedule_outlined),
              label: Text(
                value.text.isEmpty
                    ? S.of(context).notificationsConditionChooseDateTime
                    : value.text,
              ),
            ),
      );
    }
    return TextField(
      key: const Key('condition-literal-value'),
      controller: controller,
      autofocus: true,
      keyboardType: switch (type) {
        ConditionValueType.number => const TextInputType.numberWithOptions(
          decimal: true,
          signed: true,
        ),
        ConditionValueType.date ||
        ConditionValueType.time => TextInputType.datetime,
        _ => TextInputType.text,
      },
      inputFormatters: type == ConditionValueType.number
          ? <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9,.-]')),
            ]
          : const <TextInputFormatter>[],
      decoration: notificationInputDecoration(
        context,
        labelText: _literalTitle(context, type),
      ),
    );
  }
}

ConditionValueType _literalType(ConditionBuilderController controller) =>
    controller.selectedLeftType ?? ConditionValueType.text;

IconData _kindIcon(ConditionKind kind) => switch (kind) {
  ConditionKind.all => Icons.done_all,
  ConditionKind.any => Icons.call_split,
  ConditionKind.not => Icons.not_interested_outlined,
  ConditionKind.exists => Icons.check_circle_outline,
  ConditionKind.equals => Icons.compare_arrows_outlined,
  ConditionKind.contains => Icons.subject_outlined,
  ConditionKind.greaterThan => Icons.arrow_upward,
  ConditionKind.greaterThanOrEqual => Icons.north_east,
  ConditionKind.lessThan => Icons.arrow_downward,
  ConditionKind.lessThanOrEqual => Icons.south_east,
};

String conditionKindLabel(
  BuildContext context,
  ConditionKind kind,
) => switch (kind) {
  ConditionKind.all => S.of(context).notificationsConditionAll,
  ConditionKind.any => S.of(context).notificationsConditionAny,
  ConditionKind.not => S.of(context).notificationsConditionNot,
  ConditionKind.exists => S.of(context).notificationsConditionExistsLabel,
  ConditionKind.equals => S.of(context).notificationsConditionEqualsLabel,
  ConditionKind.contains => S.of(context).notificationsConditionContainsLabel,
  ConditionKind.greaterThan =>
    S.of(context).notificationsConditionGreaterThanLabel,
  ConditionKind.greaterThanOrEqual =>
    S.of(context).notificationsConditionAtLeastLabel,
  ConditionKind.lessThan => S.of(context).notificationsConditionLessThanLabel,
  ConditionKind.lessThanOrEqual =>
    S.of(context).notificationsConditionAtMostLabel,
};

String _kindDescription(BuildContext context, ConditionKind kind) =>
    switch (kind) {
      ConditionKind.all => S.of(context).notificationsConditionAllDescription,
      ConditionKind.any => S.of(context).notificationsConditionAnyDescription,
      ConditionKind.not => S.of(context).notificationsConditionNotDescription,
      ConditionKind.exists =>
        S.of(context).notificationsConditionExistsDescription,
      ConditionKind.contains => S.of(context).notificationsConditionUseCapture,
      _ => S.of(context).notificationsConditionComparisonDescription,
    };

String _kindVerb(BuildContext context, ConditionKind kind) => switch (kind) {
  ConditionKind.equals => S.of(context).notificationsConditionEquals,
  ConditionKind.contains => S.of(context).notificationsConditionContains,
  ConditionKind.greaterThan => S.of(context).notificationsConditionGreaterThan,
  ConditionKind.greaterThanOrEqual =>
    S.of(context).notificationsConditionAtLeast,
  ConditionKind.lessThan => S.of(context).notificationsConditionLessThan,
  ConditionKind.lessThanOrEqual => S.of(context).notificationsConditionAtMost,
  _ => throw StateError('Condition type does not compare two values.'),
};

String _literalTitle(
  BuildContext context,
  ConditionValueType type,
) => switch (type) {
  ConditionValueType.text => S.of(context).notificationsConditionLiteralValue,
  ConditionValueType.number => S.of(context).notificationsConditionNumberValue,
  ConditionValueType.dateTime =>
    S.of(context).notificationsConditionDateTimeValue,
  ConditionValueType.date => S.of(context).notificationsConditionDateValue,
  ConditionValueType.time => S.of(context).notificationsConditionTimeValue,
};

String _literalDescription(BuildContext context, ConditionValueType type) =>
    switch (type) {
      ConditionValueType.text =>
        S.of(context).notificationsConditionTextDescription,
      ConditionValueType.number =>
        S.of(context).notificationsConditionNumberDescription,
      ConditionValueType.dateTime =>
        S.of(context).notificationsConditionDateTimeDescription,
      ConditionValueType.date =>
        S.of(context).notificationsConditionDateDescription,
      ConditionValueType.time =>
        S.of(context).notificationsConditionTimeDescription,
    };
