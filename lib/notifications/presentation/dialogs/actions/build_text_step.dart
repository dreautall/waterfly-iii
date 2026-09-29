import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/value_sources/composed_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/literal_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/value_source.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/values/extractor_capture_picker.dart';
import 'package:waterflyiii/notifications/presentation/shared/dialog_expander_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/dialog_selector_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_empty_state.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_card_theme.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_date_time_formatter.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_input_decoration.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';

enum _AddPartStep { type, capture, fixed }

ValueSource formatBuildTextPart(
  List<RegExpDefinition> extractors,
  ValueSource source,
) {
  if (source is! RegExpCaptureValueSource) return source;
  final RegExpDefinition? extractor = extractors
      .cast<RegExpDefinition?>()
      .firstWhere(
        (RegExpDefinition? item) => item?.id == source.extractorId,
        orElse: () => null,
      );
  if (extractor?.predefinedType !=
      PredefinedRegExpDefinition.notificationDate) {
    return source;
  }
  return source.withDateTimeTextFormat();
}

class BuildTextStep extends StatefulWidget {
  const BuildTextStep({
    super.key,
    required this.parts,
    required this.extractors,
    required this.notificationContext,
    required this.onChanged,
  });

  final List<ValueSource> parts;
  final List<RegExpDefinition> extractors;
  final NotificationContext notificationContext;
  final ValueChanged<List<ValueSource>> onChanged;

  @override
  State<BuildTextStep> createState() => _BuildTextStepState();
}

class _BuildTextStepState extends State<BuildTextStep> {
  EvaluationContext get _evaluationContext => EvaluationContext(
    notification: widget.notificationContext,
    extractionResults: <String, RegExpEvaluationResult>{
      for (final RegExpDefinition extractor in widget.extractors)
        extractor.id: extractor.evaluate(widget.notificationContext),
    },
    formattingPreferences: notificationFormattingPreferencesOf(context),
  );

  void _replace(int index, ValueSource source) {
    final List<ValueSource> next = List<ValueSource>.of(widget.parts);
    final ValueSource textSource = formatBuildTextPart(
      widget.extractors,
      source,
    );
    if (index == next.length) {
      next.add(textSource);
    } else {
      next[index] = textSource;
    }
    widget.onChanged(next);
  }

  void _move(int from, int to) {
    final List<ValueSource> next = List<ValueSource>.of(widget.parts);
    final ValueSource part = next.removeAt(from);
    next.insert(to, part);
    widget.onChanged(next);
  }

  void _delete(int index) {
    final List<ValueSource> next = List<ValueSource>.of(widget.parts)
      ..removeAt(index);
    widget.onChanged(next);
  }

  Future<void> _editFixed(int index, [LiteralValueSource? current]) async {
    final ValueSource? result = await showDialog<ValueSource>(
      context: context,
      builder: (BuildContext context) => _AddPartDialog(
        extractors: widget.extractors,
        notificationContext: widget.notificationContext,
        initialFixedValue: current?.value,
        fixedOnly: true,
      ),
    );
    if (result != null) _replace(index, result);
  }

  Future<void> _editCapture(int index) async {
    final RegExpCaptureValueSource? result =
        await showDialog<RegExpCaptureValueSource>(
          context: context,
          builder: (BuildContext context) => _CapturePartDialog(
            extractors: widget.extractors,
            notificationContext: widget.notificationContext,
          ),
        );
    if (result != null) _replace(index, result);
  }

  Future<void> _addPart() async {
    final ValueSource? result = await showDialog<ValueSource>(
      context: context,
      builder: (BuildContext context) => _AddPartDialog(
        extractors: widget.extractors,
        notificationContext: widget.notificationContext,
      ),
    );
    if (result != null && mounted) _replace(widget.parts.length, result);
  }

  String _partTitle(ValueSource source) {
    if (source is RegExpCaptureValueSource) {
      final RegExpDefinition? extractor = widget.extractors
          .cast<RegExpDefinition?>()
          .firstWhere(
            (RegExpDefinition? item) => item?.id == source.extractorId,
            orElse: () => null,
          );
      if (extractor == null) {
        return '${S.of(context).notificationsRuleDeletedExtractor} · ${source.captureName}';
      }
      return _isOnlyObviousCapture(extractor, source)
          ? extractor.definitionName
          : '${extractor.definitionName} · ${source.captureName}';
    }
    final String value = (source as LiteralValueSource).value;
    return switch (value) {
      ' ' => S.of(context).notificationsActionBuildTextSpace,
      '\n' => S.of(context).notificationsActionBuildTextLineBreak,
      '\n\n' => S.of(context).notificationsActionBuildTextBlankLine,
      ' - ' => S.of(context).notificationsActionBuildTextDash,
      ': ' => S.of(context).notificationsActionBuildTextColon,
      _ => value,
    };
  }

  bool _isOnlyObviousCapture(
    RegExpDefinition extractor,
    RegExpCaptureValueSource source,
  ) {
    final RegExpEvaluationResult result = extractor.evaluate(
      widget.notificationContext,
    );
    final int matchIndex = source.matchIndex ?? 0;
    if (matchIndex >= result.matches.length) return false;
    final RegExpMatch match = result.matches[matchIndex];
    final List<String> namedCaptures = match.groupNames
        .where((String name) => match.namedGroup(name)?.isNotEmpty ?? false)
        .toList();
    final int captureCount = namedCaptures.isNotEmpty
        ? namedCaptures.length
        : Iterable<int>.generate(match.groupCount, (int index) => index + 1)
              .where((int index) => match.group(index)?.isNotEmpty ?? false)
              .length;
    if (captureCount != 1) return false;
    if (extractor.predefinedType != null) return true;
    final String extractorName = extractor.definitionName
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]'), '');
    final String captureName = source.captureName.toLowerCase().replaceAll(
      RegExp(r'[^a-z0-9]'),
      '',
    );
    return captureName.isNotEmpty && extractorName.contains(captureName);
  }

  @override
  Widget build(BuildContext context) {
    final List<ValueSource> previewParts = widget.parts
        .map((ValueSource part) => formatBuildTextPart(widget.extractors, part))
        .toList();
    final String? preview = !ComposedValueSource.canCompose(previewParts)
        ? null
        : ComposedValueSource(previewParts).resolve(_evaluationContext);
    final Color? dialogSurface = notificationDialogSurfaceColor(context);
    return AnimatedSwitcher(
      key: const Key('build-text-step'),
      duration: const Duration(milliseconds: 180),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      layoutBuilder: (Widget? current, List<Widget> previous) => Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[...previous, ?current],
      ),
      child: widget.parts.isEmpty
          ? SizedBox(
              key: const ValueKey<String>('build-text-empty'),
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  NotificationInlineEmptyState(
                    key: const Key('build-text-empty-message'),
                    message: S.of(context).notificationsActionBuildTextEmpty,
                  ),
                  const SizedBox(height: 16),
                  FilledButton.tonalIcon(
                    key: const Key('build-text-add-part'),
                    onPressed: _addPart,
                    icon: const Icon(Icons.add),
                    label: Text(
                      S.of(context).notificationsActionBuildTextAddPart,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              key: const ValueKey<String>('build-text-populated'),
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  S.of(context).notificationsActionBuildTextPreview,
                  style: context.notificationSectionTitle,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    key: const Key('build-text-preview-card'),
                    elevation: 0,
                    color:
                        dialogSurface ??
                        Theme.of(context).colorScheme.surfaceContainerLow,
                    margin: EdgeInsets.zero,
                    shape: notificationControlShape(context),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: SelectableText(
                        key: const Key('build-text-preview'),
                        preview ??
                            S
                                .of(context)
                                .notificationsActionBuildTextUnresolved,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  S.of(context).notificationsActionBuildTextParts,
                  style: context.notificationSectionTitle,
                ),
                const SizedBox(height: 8),
                Flexible(
                  fit: FlexFit.loose,
                  child: ListView.builder(
                    key: const Key('build-text-parts-list'),
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: widget.parts.length,
                    itemBuilder: (BuildContext context, int index) =>
                        _partCard(index, widget.parts[index]),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  key: const Key('build-text-add-part'),
                  onPressed: widget.parts.length < ComposedValueSource.maxParts
                      ? _addPart
                      : null,
                  style: dialogSurface == null
                      ? null
                      : ElevatedButton.styleFrom(
                          backgroundColor: dialogSurface,
                          elevation: 0,
                        ),
                  icon: const Icon(Icons.add),
                  label: Text(
                    S.of(context).notificationsActionBuildTextAddPart,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _partCard(int index, ValueSource source) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: DialogSelectorCard(
      key: Key('build-text-part-$index'),
      contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 0, 4, 0),
      leading: Icon(
        source is RegExpCaptureValueSource
            ? Icons.text_fields_outlined
            : Icons.text_snippet_outlined,
      ),
      title: Text(_partTitle(source)),
      subtitle: Text(
        source is RegExpCaptureValueSource
            ? S.of(context).notificationsActionBuildTextCapturePart
            : S.of(context).notificationsActionBuildTextFixedPart,
        style: context.notificationSupportingText,
      ),
      onTap: () {
        if (source is RegExpCaptureValueSource) {
          _editCapture(index);
        } else {
          _editFixed(index, source as LiteralValueSource);
        }
      },
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _partButton(
            key: Key('build-text-up-$index'),
            tooltip: S.of(context).notificationsActionBuildTextMoveUp,
            onPressed: index == 0 ? null : () => _move(index, index - 1),
            icon: Icons.arrow_upward,
          ),
          _partButton(
            key: Key('build-text-down-$index'),
            tooltip: S.of(context).notificationsActionBuildTextMoveDown,
            onPressed: index == widget.parts.length - 1
                ? null
                : () => _move(index, index + 1),
            icon: Icons.arrow_downward,
          ),
          _partButton(
            key: Key('build-text-delete-$index'),
            tooltip: S.of(context).notificationsRuleDelete,
            onPressed: () => _delete(index),
            icon: Icons.delete_outline,
          ),
        ],
      ),
    ),
  );

  Widget _partButton({
    required Key key,
    required String tooltip,
    required VoidCallback? onPressed,
    required IconData icon,
  }) => IconButton(
    key: key,
    tooltip: tooltip,
    onPressed: onPressed,
    icon: Icon(icon),
    iconSize: 18,
    padding: EdgeInsets.zero,
    constraints: const BoxConstraints.tightFor(width: 32, height: 32),
    visualDensity: VisualDensity.compact,
  );
}

class _AddPartDialog extends StatefulWidget {
  const _AddPartDialog({
    required this.extractors,
    required this.notificationContext,
    this.initialFixedValue,
    this.fixedOnly = false,
  });

  final List<RegExpDefinition> extractors;
  final NotificationContext notificationContext;
  final String? initialFixedValue;
  final bool fixedOnly;

  @override
  State<_AddPartDialog> createState() => _AddPartDialogState();
}

class _AddPartDialogState extends State<_AddPartDialog>
    with WidgetsBindingObserver {
  static const List<String> _presetValues = <String>[
    ' ',
    '\n',
    '\n\n',
    ' - ',
    ': ',
  ];

  late final TextEditingController _fixedTextController = TextEditingController(
    text: widget.initialFixedValue ?? '',
  );
  final FocusNode _fixedTextFocusNode = FocusNode();
  final ScrollController _fixedChoicesScrollController = ScrollController();
  late _AddPartStep _step = _initialStep;
  late bool _customFixedExpanded =
      widget.initialFixedValue != null &&
      !_presetValues.contains(widget.initialFixedValue);
  bool _isAdvancing = true;

  _AddPartStep get _initialStep =>
      widget.fixedOnly ? _AddPartStep.fixed : _AddPartStep.type;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (_customFixedExpanded) {
      WidgetsBinding.instance.addPostFrameCallback((Duration _) {
        if (mounted) _focusCustomFixedEditor();
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _fixedTextController.dispose();
    _fixedTextFocusNode.dispose();
    _fixedChoicesScrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    if (_customFixedExpanded && _fixedTextFocusNode.hasFocus) {
      _scrollCustomFixedIntoView();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget step = _currentStep(context);
    return AlertDialog(
      title: Text(_title(context)),
      content: SizedBox(
        width: 440,
        child: ClipRect(
          child: AnimatedSize(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              layoutBuilder: (Widget? current, List<Widget> previous) => Stack(
                alignment: Alignment.topLeft,
                children: <Widget>[
                  ...previous.map(
                    (Widget child) => Positioned.fill(child: child),
                  ),
                  ?current,
                ],
              ),
              transitionBuilder: (Widget child, Animation<double> animation) {
                final bool entering = child.key == step.key;
                final double direction = entering == _isAdvancing ? 1 : -1;
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
      actions: <Widget>[
        if (_canGoBack)
          TextButton(
            key: _step == _AddPartStep.capture
                ? const Key('build-text-add-back')
                : const Key('build-text-fixed-back'),
            onPressed: _back,
            child: Text(S.of(context).notificationsActionBack),
          ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        if (_step == _AddPartStep.fixed && _customFixedExpanded)
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _fixedTextController,
            builder:
                (BuildContext context, TextEditingValue value, Widget? child) =>
                    FilledButton(
                      key: const Key('build-text-fixed-save'),
                      onPressed: value.text.isEmpty
                          ? null
                          : () => Navigator.of(
                              context,
                            ).pop(LiteralValueSource(value.text)),
                      child: Text(S.of(context).notificationsActionSave),
                    ),
          ),
      ],
    );
  }

  bool get _canGoBack => !widget.fixedOnly && _step != _AddPartStep.type;

  String _title(BuildContext context) => switch (_step) {
    _AddPartStep.type => S.of(context).notificationsActionBuildTextAddPart,
    _AddPartStep.capture =>
      S.of(context).notificationsActionBuildTextCapturePart,
    _AddPartStep.fixed => S.of(context).notificationsActionBuildTextFixedPrompt,
  };

  Widget _currentStep(BuildContext context) => switch (_step) {
    _AddPartStep.type => _partTypeChoices(context),
    _AddPartStep.capture => _captureChoices(context),
    _AddPartStep.fixed => _fixedChoices(context),
  };

  void _advance(_AddPartStep step) {
    setState(() {
      _isAdvancing = true;
      _step = step;
      if (step == _AddPartStep.fixed) {
        _customFixedExpanded = false;
      }
    });
  }

  void _back() {
    setState(() {
      _isAdvancing = false;
      _step = switch (_step) {
        _AddPartStep.capture || _AddPartStep.fixed => _AddPartStep.type,
        _AddPartStep.type => _AddPartStep.type,
      };
    });
  }

  void _focusCustomFixedEditor() {
    _fixedTextFocusNode.requestFocus();
    _scrollCustomFixedIntoView();
  }

  void _scrollCustomFixedIntoView() {
    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      if (!mounted ||
          !_customFixedExpanded ||
          !_fixedChoicesScrollController.hasClients) {
        return;
      }
      _fixedChoicesScrollController.animateTo(
        _fixedChoicesScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    });
  }

  Widget _partTypeChoices(BuildContext context) => SingleChildScrollView(
    key: const Key('build-text-add-type-step'),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        DialogSelectorCard(
          key: const Key('build-text-add-capture'),
          margin: const EdgeInsets.only(bottom: 8),
          leading: const Icon(Icons.text_fields_outlined),
          title: Text(S.of(context).notificationsActionBuildTextCapturePart),
          subtitle: Text(
            S.of(context).notificationsActionExtractorCaptureDescription,
            style: context.notificationSupportingText,
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _advance(_AddPartStep.capture),
        ),
        DialogSelectorCard(
          key: const Key('build-text-add-fixed'),
          leading: const Icon(Icons.text_snippet_outlined),
          title: Text(S.of(context).notificationsActionBuildTextFixedPart),
          subtitle: Text(
            S.of(context).notificationsActionLiteralDescription,
            style: context.notificationSupportingText,
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _advance(_AddPartStep.fixed),
        ),
      ],
    ),
  );

  Widget _captureChoices(BuildContext context) => ConstrainedBox(
    key: const Key('build-text-add-capture-step'),
    constraints: BoxConstraints(
      maxHeight: MediaQuery.sizeOf(context).height * 0.55,
    ),
    child: SingleChildScrollView(
      child: ExtractorCapturePicker(
        key: const Key('build-text-capture-picker'),
        extractors: widget.extractors,
        notificationContext: widget.notificationContext,
        isCaptureAllowed: (_, _, _) => true,
        onSelected: (ExtractorCaptureSelection selection) =>
            Navigator.of(context).pop(selection.toValueSource()),
      ),
    ),
  );

  Widget _fixedChoices(BuildContext context) {
    final List<(String, String, String)> presets = <(String, String, String)>[
      (S.of(context).notificationsActionBuildTextSpace, ' ', 'A B'),
      (S.of(context).notificationsActionBuildTextLineBreak, '\n', 'A\nB'),
      (S.of(context).notificationsActionBuildTextBlankLine, '\n\n', 'A\n\nB'),
      (S.of(context).notificationsActionBuildTextDash, ' - ', 'A - B'),
      (S.of(context).notificationsActionBuildTextColon, ': ', 'A: B'),
    ];
    return ConstrainedBox(
      key: const Key('build-text-fixed-options'),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.55,
      ),
      child: SingleChildScrollView(
        key: const Key('build-text-fixed-scroll'),
        controller: _fixedChoicesScrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ...presets.map(
              ((String, String, String) preset) => DialogSelectorCard(
                key: Key(
                  'build-text-fixed-${_presetValues.indexOf(preset.$2)}',
                ),
                margin: const EdgeInsets.only(bottom: 8),
                leading: const Icon(Icons.format_quote_outlined),
                title: Text(preset.$1),
                subtitle: Text(
                  preset.$3,
                  maxLines: 3,
                  style: context.notificationSupportingText,
                ),
                onTap: () =>
                    Navigator.of(context).pop(LiteralValueSource(preset.$2)),
              ),
            ),
            DialogExpanderCard(
              key: const Key('build-text-fixed-custom-option'),
              leading: const Icon(Icons.edit_outlined),
              title: Text(S.of(context).notificationsActionBuildTextCustom),
              subtitle: Text(
                S.of(context).notificationsActionLiteralDescription,
                style: context.notificationSupportingText,
              ),
              expanded: _customFixedExpanded,
              onTap: () =>
                  setState(() => _customFixedExpanded = !_customFixedExpanded),
              onExpanded: _focusCustomFixedEditor,
              belly: _customFixedEditor(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customFixedEditor(BuildContext context) => SizedBox(
    key: const Key('build-text-fixed-custom-editor'),
    width: 400,
    child: TextField(
      key: const Key('build-text-custom-fixed'),
      controller: _fixedTextController,
      focusNode: _fixedTextFocusNode,
      minLines: 1,
      maxLines: 4,
      maxLength: ComposedValueSource.maxResolvedLength,
      decoration: notificationInputDecoration(
        context,
        labelText: S.of(context).notificationsActionBuildTextCustom,
      ),
    ),
  );
}

class _CapturePartDialog extends StatelessWidget {
  const _CapturePartDialog({
    required this.extractors,
    required this.notificationContext,
  });

  final List<RegExpDefinition> extractors;
  final NotificationContext notificationContext;

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(S.of(context).notificationsActionBuildTextCapturePart),
    content: SizedBox(
      width: 440,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.55,
        ),
        child: SingleChildScrollView(
          child: ExtractorCapturePicker(
            key: const Key('build-text-capture-picker'),
            extractors: extractors,
            notificationContext: notificationContext,
            isCaptureAllowed: (_, _, _) => true,
            onSelected: (ExtractorCaptureSelection selection) =>
                Navigator.of(context).pop(selection.toValueSource()),
          ),
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
