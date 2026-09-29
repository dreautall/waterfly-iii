import 'package:material_ui/material_ui.dart';
import 'package:logging/logging.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context_factories.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_sample.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/presentation/definitions/controllers/notification_definition_editor_view_model.dart';
import 'package:waterflyiii/notifications/presentation/definitions/widgets/add_extractor_dialog.dart';
import 'package:waterflyiii/notifications/presentation/definitions/widgets/add_rule_dialog.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_editor_dialogs.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_dialog.dart';
import 'package:waterflyiii/notifications/presentation/extractors/pages/notification_extractor_details_page.dart';
import 'package:waterflyiii/notifications/presentation/rules/pages/notification_rule_details_page.dart';

enum DefinitionEditorMenuAction { convertToAdvanced, convertToBasic, delete }

class NotificationDefinitionEditorWorkflows {
  const NotificationDefinitionEditorWorkflows({
    required this.context,
    required this.definition,
    required this.viewModel,
    required this.sampleTitleController,
    required this.sampleBodyController,
    required this.save,
    required this.refresh,
  });

  final BuildContext context;
  final NotificationDefinition definition;
  final NotificationDefinitionEditorViewModel viewModel;
  final TextEditingController sampleTitleController;
  final TextEditingController sampleBodyController;
  final Future<bool> Function() save;
  final VoidCallback refresh;

  static final Logger _log = Logger('Notifications.DefinitionEditor');

  Future<void> editSample() async {
    final NotificationSample? sample = await showSampleNotificationEditor(
      context: context,
      editorContext: SampleNotificationEditorContext.definition,
      sample: NotificationSample(
        title: sampleTitleController.text,
        body: sampleBodyController.text,
        receivedAt: definition.sampleReceivedAt,
      ),
    );
    if (sample == null || !context.mounted) return;
    final bool changed =
        sample.title != sampleTitleController.text ||
        sample.body != sampleBodyController.text;
    sampleTitleController.text = sample.title;
    sampleBodyController.text = sample.body;
    if (changed) viewModel.clearPredefinedReviews();
    refresh();
  }

  Future<void> addRule() async {
    final RuleCreation? creation = await showNotificationDialog<RuleCreation>(
      context: context,
      builder: (BuildContext context) => const AddRuleDialog(),
    );
    if (creation == null || !context.mounted) return;
    final NotificationRule rule = viewModel.createCustomRule(
      creation.name,
      description: creation.description,
    );
    viewModel.addRule(rule);
    await editRule(rule);
  }

  Future<void> editSharedActions() async {
    final NotificationRuleDetailsResult? result = await Navigator.of(context)
        .push<NotificationRuleDetailsResult>(
          MaterialPageRoute<NotificationRuleDetailsResult>(
            builder: (BuildContext context) => NotificationRuleDetailsPage(
              rule: viewModel.createSharedActionsRule(
                viewModel.extractorMode == NotificationExtractorMode.basic
                    ? S.of(context).notificationsDefinitionSetTransactionFields
                    : S.of(context).notificationsDefinitionSharedActionsTitle,
              ),
              extractors: viewModel.extractors,
              notificationContext: sampleContext(),
              definitionSampleContext: sampleContext(),
              extractorMode: viewModel.extractorMode,
              transactionCreationMode: viewModel.transactionCreationMode,
              isSharedActionsEditor: true,
              rules: viewModel.rules,
              showStatusTag: false,
              onEditExtractor: (RegExpDefinition extractor) => editExtractor(
                extractor,
                removable:
                    viewModel.extractorMode ==
                    NotificationExtractorMode.advanced,
              ),
              onSave: (NotificationRule rule) {
                viewModel.replaceSharedActions(
                  rule.actions,
                  rule.reviewedPredefinedFields,
                );
                return save();
              },
            ),
          ),
        );
    if (result?.rule == null || !context.mounted) return;
    viewModel.replaceSharedActions(
      result!.rule!.actions,
      result.rule!.reviewedPredefinedFields,
    );
    await save();
  }

  Future<DefinitionChildChange> editRule(
    NotificationRule rule, {
    NotificationContext? notificationContext,
  }) async {
    final NotificationRuleDetailsResult?
    result = await Navigator.of(context).push<NotificationRuleDetailsResult>(
      MaterialPageRoute<NotificationRuleDetailsResult>(
        builder: (BuildContext context) => NotificationRuleDetailsPage(
          rule: rule,
          extractors: viewModel.extractors,
          notificationContext: notificationContext ?? _ruleSampleContext(rule),
          definitionSampleContext: sampleContext(),
          extractorMode: viewModel.extractorMode,
          rules: viewModel.rules,
          sharedActions: viewModel.sharedActions,
          transactionCreationMode: viewModel.transactionCreationMode,
          onEditExtractor: (RegExpDefinition extractor) => editExtractor(
            extractor,
            removable:
                viewModel.extractorMode == NotificationExtractorMode.advanced,
          ),
          onSave: (NotificationRule updated) {
            final DefinitionChildChange change = viewModel
                .applyRuleEditorResult(
                  originalRuleId: rule.id,
                  rule: updated,
                  delete: false,
                );
            return _saveAfterChildChange(change);
          },
        ),
      ),
    );
    if (!context.mounted) return DefinitionChildChange.unchanged;
    final DefinitionChildChange change = viewModel.applyRuleEditorResult(
      originalRuleId: rule.id,
      rule: result?.rule,
      delete: result?.delete ?? false,
    );
    await _saveAfterChildChange(change);
    return change;
  }

  Future<void> editInitialDraftRule(
    NotificationRule rule,
    NotificationContext? notificationContext,
  ) async {
    final NotificationRuleDetailsResult? result = await Navigator.of(context)
        .push<NotificationRuleDetailsResult>(
          MaterialPageRoute<NotificationRuleDetailsResult>(
            builder: (BuildContext context) => NotificationRuleDetailsPage(
              rule: rule,
              extractors: viewModel.extractors,
              notificationContext: notificationContext ?? sampleContext(),
              extractorMode: viewModel.extractorMode,
              initialTestMode: true,
              rules: viewModel.rules,
              sharedActions: viewModel.sharedActions,
              transactionCreationMode: viewModel.transactionCreationMode,
              onEditExtractor: (RegExpDefinition extractor) => editExtractor(
                extractor,
                removable:
                    viewModel.extractorMode ==
                    NotificationExtractorMode.advanced,
              ),
              onSave: (NotificationRule updated) {
                if (viewModel.rules.any(
                  (NotificationRule rule) => rule.id == updated.id,
                )) {
                  viewModel.replaceRule(updated);
                } else {
                  viewModel.addRule(updated);
                }
                return save();
              },
            ),
          ),
        );
    if (context.mounted) {
      viewModel.applyNewRuleEditorResult(result?.rule);
    }
  }

  Future<void> handleMenuAction(
    DefinitionEditorMenuAction action, {
    Future<bool> Function()? delete,
  }) async {
    if (action == DefinitionEditorMenuAction.delete) {
      if (delete == null) return;
      try {
        if (await delete() && context.mounted) {
          Navigator.of(context).pop();
        }
      } catch (deleteError, stackTrace) {
        _log.warning(
          'Could not delete the notification definition.',
          deleteError,
          stackTrace,
        );
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(S.of(context).notificationsDefinitionDeleteFailure),
            ),
          );
        }
      }
      return;
    }
    final NotificationExtractorMode targetMode =
        action == DefinitionEditorMenuAction.convertToAdvanced
        ? NotificationExtractorMode.advanced
        : NotificationExtractorMode.basic;
    final bool? convert = await showNotificationDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          targetMode == NotificationExtractorMode.advanced
              ? S.of(context).notificationsDefinitionConvertToAdvancedTitle
              : S.of(context).notificationsDefinitionConvertToBasicTitle,
        ),
        content: Text(
          targetMode == NotificationExtractorMode.advanced
              ? S
                    .of(context)
                    .notificationsDefinitionConvertToAdvancedDescription
              : S.of(context).notificationsDefinitionConvertToBasicDescription,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(S.of(context).notificationsDefinitionConvert),
          ),
        ],
      ),
    );
    if ((convert ?? false) && context.mounted) {
      viewModel.convertSetup(targetMode);
    }
  }

  Future<void> addExtractor() async {
    final ExtractorCreation? creation =
        await showNotificationDialog<ExtractorCreation>(
          context: context,
          builder: (BuildContext context) => AddExtractorDialog(
            unavailablePredefinedTypes: viewModel.extractors
                .map((RegExpDefinition extractor) => extractor.predefinedType)
                .whereType<PredefinedRegExpDefinition>()
                .toSet(),
          ),
        );
    if (creation == null || !context.mounted) return;
    final RegExpDefinition draft = creation.predefinedType != null
        ? viewModel.createPredefinedExtractor(creation.predefinedType!)
        : viewModel.createCustomExtractor(
            creation.customName!,
            description: creation.description,
          );
    await _addExtractorDraft(draft);
  }

  Future<void> _addExtractorDraft(RegExpDefinition draft) async {
    final ExtractorDetailsResult? result = await _openExtractor(
      draft,
      canEdit: true,
      removable: false,
      definitionSample: null,
      onSave: (RegExpDefinition updated) {
        final DefinitionChildChange change =
            viewModel.extractors.any(
              (RegExpDefinition extractor) => extractor.id == updated.id,
            )
            ? viewModel.applyExtractorEditorResult(
                originalExtractorId: updated.id,
                extractor: updated,
                delete: false,
              )
            : viewModel.applyNewExtractorEditorResult(updated);
        return _saveAfterChildChange(change);
      },
    );
    if (!context.mounted) return;
    final RegExpDefinition? extractor = result?.extractor;
    final bool alreadyAdded = viewModel.extractors.any(
      (RegExpDefinition extractor) => extractor.id == draft.id,
    );
    final DefinitionChildChange change = alreadyAdded
        ? DefinitionChildChange.unchanged
        : viewModel.applyNewExtractorEditorResult(extractor ?? draft);
    await _saveAfterChildChange(change);
  }

  Future<void> editExtractor(
    RegExpDefinition extractor, {
    required bool removable,
  }) async {
    final ExtractorDetailsResult? result = await _openExtractor(
      extractor,
      canEdit: removable,
      removable: removable,
      definitionSample: extractor.sampleOverride,
      onSave: (RegExpDefinition updated) {
        final DefinitionChildChange change = viewModel
            .applyExtractorEditorResult(
              originalExtractorId: extractor.id,
              extractor: updated,
              delete: false,
            );
        return _saveAfterChildChange(change);
      },
    );
    if (!context.mounted) return;
    final DefinitionChildChange change = viewModel.applyExtractorEditorResult(
      originalExtractorId: extractor.id,
      extractor: result?.extractor,
      delete: result?.delete ?? false,
    );
    await _saveAfterChildChange(change);
  }

  NotificationContext sampleContext() => definition.toSampleContext(
    title: sampleTitleController.text,
    body: sampleBodyController.text,
  );

  Future<ExtractorDetailsResult?> _openExtractor(
    RegExpDefinition extractor, {
    required bool canEdit,
    required bool removable,
    required NotificationSample? definitionSample,
    required Future<bool> Function(RegExpDefinition extractor) onSave,
  }) => Navigator.of(context).push<ExtractorDetailsResult>(
    MaterialPageRoute<ExtractorDetailsResult>(
      builder: (BuildContext context) => NotificationExtractorDetailsPage(
        extractor: extractor,
        applicationName: definition.name,
        applicationId: definition.applicationId,
        sampleTitle: sampleTitleController.text,
        sampleBody: sampleBodyController.text,
        sampleReceivedAt: definition.sampleReceivedAt,
        definitionSample: definitionSample,
        isAdvancedMode:
            viewModel.extractorMode == NotificationExtractorMode.advanced,
        canEdit: canEdit,
        canDelete: removable,
        onSave: onSave,
      ),
    ),
  );

  Future<bool> _saveAfterChildChange(DefinitionChildChange change) async {
    if (viewModel.saveAfterChildDecision(change) ==
        DefinitionSaveAfterChildDecision.save) {
      return save();
    }
    return true;
  }

  NotificationContext _ruleSampleContext(NotificationRule rule) {
    final NotificationSample? sample = rule.sampleOverride;
    if (sample == null) return sampleContext();
    return sample.toNotificationContext(
      applicationId: definition.applicationId,
      applicationName: definition.name,
    );
  }
}
