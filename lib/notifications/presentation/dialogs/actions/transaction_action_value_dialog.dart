import 'package:chopper/chopper.dart' show Response;
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/notifications/application/resources/firefly_currency_resolver.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_tags_action.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/currency_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/composed_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/firefly_resource_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/literal_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/value_source.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/actions/transaction_action_controller.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/actions/transaction_action_steps.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/actions/build_text_step.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/actions/transaction_action_tags_step.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/values/extractor_capture_picker.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_dialog.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';
import 'package:waterflyiii/widgets/firefly_transaction_title_autocomplete.dart';

Future<NotificationAction?> selectTransactionAction(
  BuildContext context, {
  required List<RegExpDefinition> extractors,
  required NotificationContext notificationContext,
  Set<TransactionField> unavailableFields = const <TransactionField>{},
  TransactionField? fixedField,
  String? captureExtractorId,
  String? excludedExtractorId,
  bool captureOnly = false,
  bool allowFireflyResource = true,
  ValueSource? initialSource,
  List<String> initialTags = const <String>[],
  TransactionTagLoader? tagLoader,
  TransactionTitleSuggestionLoader? titleSuggestionLoader,
}) => showNotificationDialog<NotificationAction>(
  context: context,
  builder: (BuildContext context) => _ActionValueSourceDialog(
    extractors: extractors,
    notificationContext: notificationContext,
    unavailableFields: unavailableFields,
    fixedField: fixedField,
    captureExtractorId: captureExtractorId,
    excludedExtractorId: excludedExtractorId,
    captureOnly: captureOnly,
    allowFireflyResource: allowFireflyResource,
    initialSource: initialSource,
    initialTags: initialTags,
    tagLoader: tagLoader,
    titleSuggestionLoader: titleSuggestionLoader,
  ),
);

Future<NotificationAction?> selectOptionalPredefinedTransactionAction(
  BuildContext context, {
  required List<RegExpDefinition> extractors,
  required NotificationContext notificationContext,
  required Set<TransactionField> unavailableFields,
  bool allowFireflyResource = true,
  TransactionTitleSuggestionLoader? titleSuggestionLoader,
}) => showNotificationDialog<NotificationAction>(
  context: context,
  builder: (BuildContext context) => _ActionValueSourceDialog(
    extractors: extractors,
    notificationContext: notificationContext,
    unavailableFields: unavailableFields,
    captureOnly: false,
    allowFireflyResource: allowFireflyResource,
    optionalPredefinedFields: const <TransactionField>{
      TransactionField.currency,
      TransactionField.title,
      TransactionField.notes,
    },
    titleSuggestionLoader: titleSuggestionLoader,
  ),
);

Future<SetTransactionTagsAction?> selectTransactionTagsAction(
  BuildContext context, {
  required List<String> selectedTags,
  TransactionTagLoader? tagLoader,
}) async =>
    await selectTransactionAction(
          context,
          extractors: const <RegExpDefinition>[],
          notificationContext: NotificationContext(
            title: '',
            body: '',
            receivedAt: DateTime.now(),
          ),
          fixedField: TransactionField.tag,
          initialTags: selectedTags,
          tagLoader: tagLoader,
        )
        as SetTransactionTagsAction?;

String transactionFieldLabel(BuildContext context, TransactionField field) =>
    actionTransactionFieldLabel(context, field);

String transactionFieldValidationError(
  BuildContext context,
  TransactionFieldValidationError error,
) => switch (error) {
  TransactionFieldValidationError.invalidAmount =>
    S.of(context).notificationsFieldInvalidAmount,
  TransactionFieldValidationError.invalidDate =>
    S.of(context).notificationsFieldInvalidDate,
  TransactionFieldValidationError.invalidTime =>
    S.of(context).notificationsFieldInvalidTime,
};

bool isAmountCaptureValue(String value) =>
    TransactionActionController.isAmountCaptureValue(value);

bool isCurrencyCaptureValue(String value) =>
    TransactionActionController.isCurrencyCaptureValue(value);

class _ActionValueSourceDialog extends StatefulWidget {
  const _ActionValueSourceDialog({
    required this.extractors,
    required this.notificationContext,
    required this.unavailableFields,
    this.fixedField,
    this.captureExtractorId,
    this.excludedExtractorId,
    required this.captureOnly,
    required this.allowFireflyResource,
    this.optionalPredefinedFields,
    this.initialSource,
    this.initialTags = const <String>[],
    this.tagLoader,
    this.titleSuggestionLoader,
  });

  final List<RegExpDefinition> extractors;
  final NotificationContext notificationContext;
  final Set<TransactionField> unavailableFields;
  final TransactionField? fixedField;
  final String? captureExtractorId;
  final String? excludedExtractorId;
  final bool captureOnly;
  final bool allowFireflyResource;
  final Set<TransactionField>? optionalPredefinedFields;
  final ValueSource? initialSource;
  final List<String> initialTags;
  final TransactionTagLoader? tagLoader;
  final TransactionTitleSuggestionLoader? titleSuggestionLoader;

  @override
  State<_ActionValueSourceDialog> createState() =>
      _ActionValueSourceDialogState();
}

class _ActionValueSourceDialogState extends State<_ActionValueSourceDialog> {
  late final TransactionActionController _controller;
  final TextEditingController _literalController = TextEditingController();
  final FocusNode _literalFocusNode = FocusNode();
  final TextEditingController _currencyController = TextEditingController();
  Future<Iterable<FireflyCurrency>>? _currencyMatches;
  String? _literalError;
  late List<ValueSource> _composedParts;
  late List<String> _selectedTags;

  @override
  void initState() {
    super.initState();
    _controller = TransactionActionController(
      fixedField: widget.fixedField,
      captureOnly: widget.captureOnly,
    );
    final ValueSource? source = widget.initialSource;
    _composedParts = source is ComposedValueSource
        ? List<ValueSource>.of(source.parts)
        : source == null
        ? <ValueSource>[]
        : <ValueSource>[source];
    _selectedTags = List<String>.of(widget.initialTags);
    if (source is ComposedValueSource) {
      _controller.selectBuildText();
    } else if (source is LiteralValueSource) {
      _literalController.text = source.value;
      _controller.setSourceMode(TransactionActionSourceMode.literal);
    }
    _controller.addListener(_changed);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_changed)
      ..dispose();
    _literalController.dispose();
    _literalFocusNode.dispose();
    _currencyController.dispose();
    super.dispose();
  }

  void _changed() {
    if (mounted) setState(() {});
  }

  void _selectField(TransactionField field) {
    _literalController.clear();
    _literalError = null;
    _controller.selectField(field);
  }

  Future<List<String>> _loadTags() async {
    final FireflyIii api = context.read<FireflyService>().api;
    final List<String> tags = <String>[];
    late Response<TagArray> response;
    int page = 0;
    do {
      response = await api.v1TagsGet(page: ++page);
      apiThrowErrorIfEmpty(response, mounted ? context : null);
      tags.addAll(response.body!.data.map((TagRead tag) => tag.attributes.tag));
    } while ((response.body!.meta.pagination?.currentPage ?? 1) <
        (response.body!.meta.pagination?.totalPages ?? 1));
    return tags;
  }

  void _selectOptionalField(TransactionField field) {
    if (field == TransactionField.currency) {
      _controller
        ..selectField(field)
        ..setSourceMode(TransactionActionSourceMode.capture);
      return;
    }
    final (
      PredefinedRegExpDefinition type,
      String captureName,
    ) = switch (field) {
      TransactionField.title => (
        PredefinedRegExpDefinition.notificationTitle,
        'title',
      ),
      TransactionField.notes => (
        PredefinedRegExpDefinition.notificationMessage,
        'message',
      ),
      _ => throw ArgumentError.value(field, 'field'),
    };
    final RegExpDefinition extractor = widget.extractors.firstWhere(
      (RegExpDefinition item) => item.predefinedType == type,
    );
    _complete(
      field,
      RegExpCaptureValueSource(
        extractorId: extractor.id,
        captureName: captureName,
      ),
    );
  }

  void _selectCapture(ExtractorCaptureSelection selection) {
    final TransactionField field = _controller.draft.field!;
    final RegExpCaptureValueSource capture = selection.toValueSource();
    if (field != TransactionField.currency &&
        field != TransactionField.date &&
        field != TransactionField.time) {
      _complete(field, capture);
      return;
    }
    if (field == TransactionField.currency) {
      _controller.selectCapture(capture, selection.value);
      final String normalized = selection.value.trim();
      _currencyController.text =
          RegExp(r'^[A-Za-z0-9]{3,}$').hasMatch(normalized) ? normalized : '';
      _currencyMatches = _searchCurrencies();
    } else {
      Navigator.of(
        context,
      ).pop(_controller.buildDerivedDateTimeCapture(capture));
    }
  }

  void _saveLiteral() {
    final TransactionFieldValidationError? error = _controller.validateLiteral(
      _literalController.text,
    );
    if (error != null) {
      setState(
        () => _literalError = transactionFieldValidationError(context, error),
      );
      return;
    }
    Navigator.of(
      context,
    ).pop(_controller.buildLiteral(_literalController.text));
  }

  Future<Iterable<FireflyCurrency>> _searchCurrencies() => context
      .read<FireflyCurrencyResolver>()
      .search(_currencyController.text.trim());

  void _searchCurrency(String _) {
    setState(() => _currencyMatches = _searchCurrencies());
  }

  void _selectCurrency(FireflyCurrency currency) {
    _complete(
      TransactionField.currency,
      CurrencyCaptureValueSource(
        capture: _controller.draft.capture!,
        resourceId: currency.id,
        expectedValue: _controller.draft.extractedValue,
      ),
    );
  }

  Future<void> _pickDate() async {
    final DateTime? value = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );
    if (value != null && mounted) {
      setState(() {
        _literalController.text = value.toIso8601String().substring(0, 10);
      });
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? value = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (value != null && mounted) {
      setState(() {
        _literalController.text =
            '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
      });
    }
  }

  void _complete(TransactionField field, ValueSource source) => Navigator.of(
    context,
  ).pop(SetTransactionFieldAction(target: field, valueSource: source));

  @override
  Widget build(BuildContext context) {
    final TransactionActionDraft draft = _controller.draft;
    final Widget step = _step(draft);
    return AlertDialog(
      title: Row(
        children: <Widget>[
          Icon(actionStepIcon(draft.step, draft.field)),
          const SizedBox(width: 12),
          Expanded(child: Text(_title(draft))),
        ],
      ),
      content: SizedBox(
        width: 440,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _description(draft),
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
                          final double direction = entering == draft.isAdvancing
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
        if (draft.step != TransactionActionStep.field &&
            (widget.fixedField == null ||
                draft.step == TransactionActionStep.currencyMatch ||
                draft.step == TransactionActionStep.buildText ||
                draft.step == TransactionActionStep.tags))
          TextButton(
            onPressed: _controller.back,
            child: Text(S.of(context).notificationsActionBack),
          ),
        if (draft.sourceMode == TransactionActionSourceMode.literal)
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _literalController,
            builder:
                (BuildContext context, TextEditingValue value, Widget? _) =>
                    FilledButton(
                      autofocus: true,
                      onPressed: value.text.trim().isEmpty
                          ? null
                          : _saveLiteral,
                      child: Text(S.of(context).notificationsActionSave),
                    ),
          ),
        if (draft.step == TransactionActionStep.buildText)
          FilledButton(
            key: const Key('build-text-save'),
            onPressed: !ComposedValueSource.canCompose(_composedParts)
                ? null
                : () => _complete(
                    draft.field!,
                    ComposedValueSource(
                      _composedParts
                          .map(
                            (ValueSource part) =>
                                formatBuildTextPart(widget.extractors, part),
                          )
                          .toList(),
                    ),
                  ),
            child: Text(S.of(context).notificationsActionSave),
          ),
        if (draft.step == TransactionActionStep.tags)
          FilledButton(
            key: const Key('action-tags-save'),
            onPressed: _selectedTags.isEmpty
                ? null
                : () => Navigator.of(
                    context,
                  ).pop(SetTransactionTagsAction(_selectedTags)),
            child: Text(S.of(context).notificationsActionSave),
          ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
      ],
    );
  }

  Widget _step(TransactionActionDraft draft) => switch (draft.step) {
    TransactionActionStep.field => ActionFieldStep(
      key: const ValueKey<String>('action-fields'),
      unavailableFields: widget.unavailableFields,
      optionalFields: widget.optionalPredefinedFields,
      onSelected: widget.optionalPredefinedFields == null
          ? _selectField
          : _selectOptionalField,
    ),
    TransactionActionStep.source => ActionSourceStep(
      key: ValueKey<String>('action-source-${draft.field!.name}'),
      field: draft.field!,
      sourceMode: draft.sourceMode,
      extractors: widget.extractors
          .where(
            (RegExpDefinition extractor) =>
                (widget.captureExtractorId == null ||
                    extractor.id == widget.captureExtractorId) &&
                extractor.id != widget.excludedExtractorId,
          )
          .toList(),
      notificationContext: widget.notificationContext,
      captureOnly: widget.captureOnly,
      allowFireflyResource: widget.allowFireflyResource,
      literalController: _literalController,
      literalFocusNode: _literalFocusNode,
      literalError: _literalError,
      titleSuggestionLoader: widget.titleSuggestionLoader,
      onLiteralChanged: (_) => setState(() => _literalError = null),
      onModeChanged: _controller.setSourceMode,
      isCaptureAllowed:
          (RegExpDefinition extractor, String capture, String value) =>
              TransactionActionController.isCaptureCompatible(
                extractor,
                capture,
                value,
                draft.field!,
              ),
      onCaptureSelected: _selectCapture,
      onResourceSelected: (FireflyResourceValueSource source) =>
          _complete(draft.field!, source),
      onPickDate: _pickDate,
      onPickTime: _pickTime,
      onBuildText: _controller.selectBuildText,
    ),
    TransactionActionStep.buildText => BuildTextStep(
      key: const ValueKey<String>('action-build-text-step'),
      parts: _composedParts,
      extractors: widget.extractors,
      notificationContext: widget.notificationContext,
      onChanged: (List<ValueSource> parts) =>
          setState(() => _composedParts = parts),
    ),
    TransactionActionStep.tags => TransactionActionTagsStep(
      key: const ValueKey<String>('action-transaction-tags'),
      selectedTags: _selectedTags,
      loadTags: widget.tagLoader ?? _loadTags,
      onChanged: (List<String> tags) => setState(() => _selectedTags = tags),
    ),
    TransactionActionStep.currencyMatch => ActionCurrencyMatchStep(
      key: const ValueKey<String>('action-currency-match'),
      extractedValue: draft.extractedValue,
      searchController: _currencyController,
      matches: _currencyMatches,
      onSearchChanged: _searchCurrency,
      onSelected: _selectCurrency,
    ),
  };

  String _title(TransactionActionDraft draft) => switch (draft.step) {
    TransactionActionStep.field => S.of(context).notificationsActionSelectField,
    TransactionActionStep.currencyMatch =>
      S.of(context).notificationsActionMatchCurrency,
    TransactionActionStep.buildText =>
      S.of(context).notificationsActionBuildText,
    TransactionActionStep.tags => S.of(context).transactionDialogTagsTitle,
    TransactionActionStep.source =>
      S
          .of(context)
          .notificationsActionSetField(
            transactionFieldLabel(context, draft.field!),
          ),
  };

  String _description(TransactionActionDraft draft) => switch (draft.step) {
    TransactionActionStep.field => S.of(context).notificationsActionChooseField,
    TransactionActionStep.currencyMatch =>
      S.of(context).notificationsActionChooseCurrency,
    TransactionActionStep.buildText =>
      S.of(context).notificationsActionBuildTextDescription,
    TransactionActionStep.tags =>
      S.of(context).notificationsTagsRuleDescription,
    TransactionActionStep.source =>
      S.of(context).notificationsActionChooseSource,
  };
}
