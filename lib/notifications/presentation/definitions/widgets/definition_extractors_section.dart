import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_evaluation_result.dart';
import 'package:waterflyiii/notifications/presentation/shared/definition_detail_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/message_status_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';

class DefinitionExtractorsSection extends StatelessWidget {
  const DefinitionExtractorsSection({
    super.key,
    required this.extractors,
    required this.extractorMode,
    required this.notificationContext,
    required this.onEditExtractor,
    required this.onAddExtractor,
  });

  final List<RegExpDefinition> extractors;
  final NotificationExtractorMode extractorMode;
  final NotificationContext notificationContext;
  final void Function(RegExpDefinition extractor, {required bool removable})
  onEditExtractor;
  final VoidCallback onAddExtractor;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        S.of(context).notificationsDefinitionExtractorsHeading,
        style: context.notificationSectionTitle,
      ),
      const SizedBox(height: 4),
      Text(
        S.of(context).notificationsDefinitionExtractorsDescription,
        style: context.notificationSectionDescription,
      ),
      const SizedBox(height: 12),
      if (extractorMode == NotificationExtractorMode.basic)
        ...extractors.map(
          (RegExpDefinition extractor) => _ExtractorCard(
            extractor: extractor,
            notificationContext: notificationContext,
            removable: false,
            onEdit: onEditExtractor,
          ),
        )
      else ...<Widget>[
        if (extractors.isEmpty)
          MessageStatusCard(
            status: MessageStatus.error,
            message: S.of(context).notificationsDefinitionNoExtractors,
          )
        else
          ...extractors.map(
            (RegExpDefinition extractor) => _ExtractorCard(
              extractor: extractor,
              notificationContext: notificationContext,
              removable: true,
              onEdit: onEditExtractor,
            ),
          ),
        SizedBox(height: extractors.isEmpty ? 12 : 0),
        ElevatedButton.icon(
          onPressed: onAddExtractor,
          icon: const Icon(Icons.add),
          label: Text(S.of(context).notificationsDefinitionAddExtractor),
        ),
      ],
    ],
  );
}

class _ExtractorCard extends StatelessWidget {
  const _ExtractorCard({
    required this.extractor,
    required this.notificationContext,
    required this.removable,
    required this.onEdit,
  });

  final RegExpDefinition extractor;
  final NotificationContext notificationContext;
  final bool removable;
  final void Function(RegExpDefinition extractor, {required bool removable})
  onEdit;

  @override
  Widget build(BuildContext context) {
    final RegExpEvaluationResult evaluation = extractor.evaluate(
      notificationContext,
    );
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: DefinitionDetailCard(
        onTap: () => onEdit(extractor, removable: removable),
        leading: Icon(
          evaluation.hasEvaluationFailure
              ? Icons.error_outline
              : !evaluation.hasMatches
              ? Icons.error_outline
              : Icons.check_circle_outline,
          color: evaluation.hasEvaluationFailure
              ? colors.error
              : !evaluation.hasMatches
              ? colors.tertiary
              : colors.primary,
        ),
        title: Text(extractor.definitionName),
        subtitle: _subtitle(context, evaluation),
        trailing: const Padding(
          padding: EdgeInsets.only(right: 8),
          child: Icon(Icons.chevron_right),
        ),
      ),
    );
  }

  Widget? _subtitle(BuildContext context, RegExpEvaluationResult evaluation) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final List<Widget> lines = <Widget>[
      if (evaluation.hasEvaluationFailure || !evaluation.hasMatches)
        Text(
          switch (evaluation.failure) {
            RegExpEvaluationFailure.inputTooLong =>
              S.of(context).notificationsExtractorInputTooLong,
            RegExpEvaluationFailure.invalidPattern =>
              S.of(context).notificationsExtractorInvalidPattern,
            null => S.of(context).notificationsExtractorNoSampleMatch,
          },
          style: TextStyle(
            color: evaluation.hasEvaluationFailure
                ? colors.error
                : colors.tertiary,
          ),
        ),
      if (extractor.description.isNotEmpty)
        Text(
          extractor.description,
          style: context.notificationSupportingText,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
    ];
    if (lines.isEmpty) return null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines,
    );
  }
}
