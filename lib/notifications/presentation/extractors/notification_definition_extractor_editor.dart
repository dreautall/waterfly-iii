import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/notifications/application/definitions/save_notification_definition.dart';
import 'package:waterflyiii/notifications/application/stores/notification_definition_store.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/presentation/extractors/pages/notification_extractor_details_page.dart';

Future<SaveNotificationDefinitionResult?> editNotificationDefinitionExtractor({
  required BuildContext context,
  required NotificationDefinition definition,
  required RegExpDefinition extractor,
  required NotificationDefinitionStore store,
}) async {
  final bool removable =
      definition.extractorMode == NotificationExtractorMode.advanced;
  final ExtractorDetailsResult? result = await Navigator.of(context)
      .push<ExtractorDetailsResult>(
        MaterialPageRoute<ExtractorDetailsResult>(
          builder: (BuildContext context) => NotificationExtractorDetailsPage(
            extractor: extractor,
            applicationName: definition.name,
            applicationId: definition.applicationId,
            sampleTitle: definition.sampleTitle ?? '',
            sampleBody: definition.sampleBody ?? '',
            sampleReceivedAt: definition.sampleReceivedAt,
            definitionSample: extractor.sampleOverride,
            isAdvancedMode: removable,
            canEdit: removable,
            canDelete: removable,
            onSave: (RegExpDefinition updated) =>
                _saveExtractorChange(
                  definition: definition,
                  extractor: extractor,
                  store: store,
                  updated: updated,
                ).then(
                  (SaveNotificationDefinitionResult result) => result.succeeded,
                ),
          ),
        ),
      );
  if (result == null) return null;
  if (!result.delete) return null;
  return _saveExtractorChange(
    definition: definition,
    extractor: extractor,
    store: store,
    delete: true,
  );
}

Future<SaveNotificationDefinitionResult> _saveExtractorChange({
  required NotificationDefinition definition,
  required RegExpDefinition extractor,
  required NotificationDefinitionStore store,
  RegExpDefinition? updated,
  bool delete = false,
}) async {
  final List<NotificationDefinition> definitions;
  try {
    definitions = await store.load();
  } catch (_) {
    return const SaveNotificationDefinitionResult(
      SaveNotificationDefinitionStatus.failed,
    );
  }
  final NotificationDefinition? currentDefinition = definitions
      .where(
        (NotificationDefinition candidate) => candidate.id == definition.id,
      )
      .firstOrNull;
  if (currentDefinition == null) {
    return const SaveNotificationDefinitionResult(
      SaveNotificationDefinitionStatus.notFound,
    );
  }
  final List<RegExpDefinition> extractors = delete
      ? currentDefinition.extractors
            .where((RegExpDefinition candidate) => candidate.id != extractor.id)
            .toList()
      : currentDefinition.extractors
            .map(
              (RegExpDefinition candidate) => candidate.id == extractor.id
                  ? updated ?? candidate
                  : candidate,
            )
            .toList();
  return SaveNotificationDefinition(
    store,
  ).update(currentDefinition.copyWith(extractors: extractors));
}
