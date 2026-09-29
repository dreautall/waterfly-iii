import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_sample.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/presentation/extractors/widgets/extractor_editor_components.dart';
import 'package:waterflyiii/notifications/presentation/extractors/controllers/notification_extractor_editor_view_model.dart';
import 'package:waterflyiii/notifications/presentation/extractors/widgets/extractor_details_content.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_menu_theme.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_page_header.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_editor_dialogs.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_dialog.dart';

class ExtractorDetailsResult {
  const ExtractorDetailsResult._({this.extractor, this.delete = false});

  const ExtractorDetailsResult.updated(RegExpDefinition extractor)
    : this._(extractor: extractor);

  const ExtractorDetailsResult.deleted() : this._(delete: true);

  final RegExpDefinition? extractor;
  final bool delete;
}

class NotificationExtractorDetailsPage extends StatefulWidget {
  const NotificationExtractorDetailsPage({
    super.key,
    required this.extractor,
    required this.applicationName,
    required this.applicationId,
    required this.sampleTitle,
    required this.sampleBody,
    required this.sampleReceivedAt,
    this.definitionSample,
    required this.isAdvancedMode,
    required this.canEdit,
    required this.canDelete,
    this.onSave,
  });

  final RegExpDefinition extractor;
  final String applicationName;
  final String applicationId;
  final String sampleTitle;
  final String sampleBody;
  final DateTime sampleReceivedAt;
  final NotificationSample? definitionSample;
  final bool isAdvancedMode;
  final bool canEdit;
  final bool canDelete;
  final Future<bool> Function(RegExpDefinition extractor)? onSave;

  @override
  State<NotificationExtractorDetailsPage> createState() =>
      _NotificationExtractorDetailsPageState();
}

class _NotificationExtractorDetailsPageState
    extends State<NotificationExtractorDetailsPage> {
  late final TextEditingController _nameController;
  late final RegExpTextEditingController _sourceController;
  late final NotificationExtractorEditorViewModel _viewModel;
  final ScrollController _scrollController = ScrollController();
  bool _isDiscarding = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.extractor.definitionName,
    );
    _sourceController = RegExpTextEditingController(
      text: widget.extractor.regExpSource,
    );
    _viewModel = NotificationExtractorEditorViewModel(
      extractor: widget.extractor,
      notificationContext: _notificationContext,
      isAdvancedMode: widget.isAdvancedMode,
      sampleOverride: widget.extractor.sampleOverride,
      definitionSample: widget.definitionSample,
    )..addListener(_refresh);
    _nameController.addListener(_onDraftChanged);
    _sourceController.addListener(_onDraftChanged);
    _evaluate();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _sourceController.dispose();
    _viewModel.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isDirty || _isDiscarding,
      onPopInvokedWithResult: _applyChangesOnBack,
      child: NotificationMenuTheme(
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
              if (widget.canEdit)
                PopupMenuButton<_ExtractorAction>(
                  tooltip: S.of(context).notificationsExtractorActions,
                  position: PopupMenuPosition.under,
                  iconSize: NotificationPageHeader.controlIconSize,
                  clipBehavior: Clip.antiAlias,
                  onSelected: _onActionSelected,
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<_ExtractorAction>>[
                        PopupMenuItem<_ExtractorAction>(
                          value: _ExtractorAction.rename,
                          child: Row(
                            children: <Widget>[
                              const Icon(Icons.edit_outlined),
                              const SizedBox(width: 8),
                              Text(S.of(context).notificationsEditDetails),
                            ],
                          ),
                        ),
                        if (widget.canDelete) const NotificationMenuDivider(),
                        if (widget.canDelete)
                          PopupMenuItem<_ExtractorAction>(
                            value: _ExtractorAction.delete,
                            child: Row(
                              children: <Widget>[
                                const Icon(Icons.delete_outline),
                                const SizedBox(width: 8),
                                Text(
                                  S.of(context).notificationsExtractorDelete,
                                ),
                              ],
                            ),
                          ),
                      ],
                ),
            ],
          ),
          floatingActionButton: _isDirty
              ? FloatingActionButton(
                  tooltip: S.of(context).notificationsExtractorSave,
                  onPressed: _apply,
                  child: const Icon(Icons.save_outlined),
                )
              : null,
          body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: ListView(
              controller: _scrollController,
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(
                16,
                NotificationPageHeader.bodyTopInset(context),
                16,
                NotificationPageHeader.bodyBottomInset(context, spacing: 24),
              ),
              children: <Widget>[
                ExtractorDetailsContent(
                  extractor: _viewModel.currentExtractor,
                  applicationId: widget.applicationId,
                  sample: _viewModel.sample,
                  evaluation: _viewModel.evaluation,
                  validationError: _viewModel.validationError,
                  sourceController: _sourceController,
                  isAdvancedMode: widget.isAdvancedMode,
                  isDirty: _isDirty,
                  canEdit: widget.canEdit,
                  hasSampleOverride: _viewModel.sampleOverride != null,
                  onEditSample: _editSample,
                  onClearSampleOverride: _viewModel.clearSampleOverride,
                  onPasteSource: _pasteSource,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  NotificationContext get _notificationContext => NotificationContext(
    applicationId: widget.applicationId,
    applicationName: widget.applicationName,
    title: widget.sampleTitle,
    body: widget.sampleBody,
    receivedAt: widget.sampleReceivedAt,
  );

  void _evaluate() => _viewModel.evaluate();

  void _onDraftChanged() => _viewModel.update(
    name: _nameController.text,
    source: _sourceController.text,
  );

  Future<void> _pasteSource() async {
    final ClipboardData? clipboard = await Clipboard.getData(
      Clipboard.kTextPlain,
    );
    if (clipboard?.text != null) {
      _sourceController.text = clipboard!.text!;
    }
  }

  Future<void> _apply() async {
    final RegExpDefinition? extractor = _viewModel.save();
    if (extractor == null) return;
    final bool saved = await widget.onSave?.call(extractor) ?? true;
    if (!mounted) return;
    if (!saved) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).notificationsDefinitionSaveFailure),
        ),
      );
      return;
    }
    _viewModel.acceptChanges();
  }

  Future<void> _editSample() async {
    final NotificationSample? sample = await showSampleNotificationEditor(
      context: context,
      editorContext: SampleNotificationEditorContext.extractor,
      sample: _viewModel.sample,
    );
    if (sample == null || !mounted) return;
    _viewModel.updateSample(sample);
  }

  bool get _isDirty => _viewModel.isDirty;

  void _applyChangesOnBack(bool didPop, Object? _) {
    if (!didPop && _isDirty) _confirmDiscard();
  }

  Future<void> _onBackRequested() async {
    if (!_isDirty) {
      Navigator.of(context).pop();
      return;
    }
    await _confirmDiscard();
  }

  Future<void> _confirmDiscard() async {
    final bool discard = await showDiscardChangesDialog(context);
    if (!discard || !mounted) return;
    setState(() => _isDiscarding = true);
    Navigator.of(context).pop();
  }

  Future<void> _onActionSelected(_ExtractorAction action) async {
    if (action == _ExtractorAction.delete) {
      final bool? confirmed = await showNotificationDialog<bool>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(S.of(context).notificationsExtractorDeleteTitle),
          content: Text(
            S
                .of(context)
                .notificationsExtractorDeleteDescription(
                  widget.extractor.definitionName,
                ),
          ),
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
              child: Text(S.of(context).notificationsExtractorDelete),
            ),
          ],
        ),
      );
      if (confirmed != true || !mounted) {
        return;
      }
      Navigator.of(context).pop(const ExtractorDetailsResult.deleted());
      return;
    }
    final ExtractorDetailsUpdate? details =
        await showNotificationDialog<ExtractorDetailsUpdate>(
          context: context,
          builder: (BuildContext context) => EditExtractorDetailsDialog(
            name: _nameController.text,
            description: _viewModel.currentExtractor.description,
          ),
        );
    if (details != null && mounted) {
      _nameController.text = details.name;
      _viewModel.update(
        name: details.name,
        description: details.description,
        source: _sourceController.text,
      );
    }
  }

  void _refresh() {
    if (mounted) setState(() {});
  }
}

enum _ExtractorAction { rename, delete }
