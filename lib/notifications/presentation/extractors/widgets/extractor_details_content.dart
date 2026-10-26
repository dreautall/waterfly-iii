import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_sample.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_evaluation_result.dart';
import 'package:waterflyiii/notifications/presentation/extractors/widgets/extractor_editor_components.dart';
import 'package:waterflyiii/notifications/presentation/extractors/widgets/extractor_match_results.dart';
import 'package:waterflyiii/notifications/presentation/extractors/widgets/property_extractor_details.dart';
import 'package:waterflyiii/notifications/presentation/shared/message_status_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_input_decoration.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_date_time_formatter.dart';
import 'package:waterflyiii/notifications/presentation/shared/sample_notification_card.dart';

class ExtractorDetailsContent extends StatefulWidget {
  const ExtractorDetailsContent({
    super.key,
    required this.extractor,
    required this.applicationId,
    required this.sample,
    required this.evaluation,
    required this.validationError,
    required this.sourceController,
    required this.isAdvancedMode,
    required this.isDirty,
    required this.canEdit,
    required this.hasSampleOverride,
    required this.onEditSample,
    required this.onClearSampleOverride,
    required this.onPasteSource,
  });

  final RegExpDefinition extractor;
  final String applicationId;
  final NotificationSample sample;
  final RegExpEvaluationResult? evaluation;
  final String? validationError;
  final RegExpTextEditingController sourceController;
  final bool isAdvancedMode;
  final bool isDirty;
  final bool canEdit;
  final bool hasSampleOverride;
  final VoidCallback onEditSample;
  final VoidCallback onClearSampleOverride;
  final VoidCallback onPasteSource;

  @override
  State<ExtractorDetailsContent> createState() =>
      _ExtractorDetailsContentState();
}

class _ExtractorDetailsContentState extends State<ExtractorDetailsContent> {
  RegExpEvaluationResult? get _evaluation => widget.evaluation;
  NotificationSample get _sample => widget.sample;
  String? get _validationError => widget.validationError;
  bool get _isPropertyExtractor => switch (widget.extractor.predefinedType) {
    PredefinedRegExpDefinition.notificationTitle ||
    PredefinedRegExpDefinition.notificationMessage ||
    PredefinedRegExpDefinition.notificationDate => true,
    _ => false,
  };

  @override
  Widget build(BuildContext context) {
    final RegExpEvaluationResult? evaluation = _evaluation;
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.extractor.description.isNotEmpty) ...<Widget>[
          Text(
            widget.extractor.description,
            style: context.notificationSectionDescription,
          ),
        ],
        const SizedBox(height: 12),
        Text(
          S.of(context).notificationsExtractorSampleNotification,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 4),
        Text(
          S.of(context).notificationsExtractorSampleDescription,
          style: context.notificationSectionDescription,
        ),
        const SizedBox(height: 12),
        SampleNotificationCard(
          applicationId: widget.applicationId,
          title: _sample.title,
          body: _sample.body,
          receivedAt: _sample.receivedAt,
          onTap: widget.canEdit ? widget.onEditSample : null,
          trailing: widget.canEdit
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (widget.hasSampleOverride)
                      IconButton(
                        tooltip: S.of(context).notificationsUseDefinitionSample,
                        onPressed: widget.onClearSampleOverride,
                        icon: const Icon(Icons.undo_outlined),
                        iconSize: 18,
                      ),
                    IconButton(
                      tooltip: S.of(context).notificationsDefinitionEditSample,
                      onPressed: widget.onEditSample,
                      icon: const Icon(Icons.edit_outlined),
                    ),
                  ],
                )
              : null,
          titleContent: _highlightedSampleText(_sample.title, isTitle: true),
          bodyContent: _highlightedSampleText(_sample.body, isTitle: false),
          timestampContent: _highlightedSampleTimestamp(),
        ),
        if (evaluation?.failure ==
            RegExpEvaluationFailure.inputTooLong) ...<Widget>[
          const SizedBox(height: 8),
          MessageStatusCard(
            status: MessageStatus.error,
            title: S.of(context).notificationsExtractorInputTooLong,
            message: S
                .of(context)
                .notificationsExtractorInputTooLongMessage(
                  RegExpDefinition.maximumCustomInputLength,
                ),
          ),
        ],
        const SizedBox(height: 24),
        if (_isPropertyExtractor)
          PropertyExtractorDetails(
            type: widget.extractor.predefinedType!,
            sample: _sample,
          )
        else ...<Widget>[
          ..._regularExpressionDetails(colors, evaluation),
          if (widget.isDirty) const SizedBox(height: 56),
        ],
      ],
    );
  }

  Widget _highlightedSampleText(String text, {required bool isTitle}) {
    final RegExpEvaluationResult? evaluation = _evaluation;
    final NotificationExtractorInput input =
        widget.extractor.predefinedType?.input ??
        NotificationExtractorInput.body;
    final bool matchesInput = isTitle
        ? input == NotificationExtractorInput.title
        : input == NotificationExtractorInput.body;
    final TextStyle? style = isTitle
        ? null
        : context.notificationSupportingText;
    if (evaluation == null ||
        evaluation.hasEvaluationFailure ||
        !matchesInput) {
      return Text(
        text,
        maxLines: isTitle ? 1 : 3,
        overflow: TextOverflow.ellipsis,
        style: style,
      );
    }
    final ColorScheme colors = Theme.of(context).colorScheme;
    final List<InlineSpan> spans = <InlineSpan>[];
    int start = 0;
    for (final RegExpMatch match in evaluation.matches) {
      if (match.start > start) {
        spans.add(TextSpan(text: text.substring(start, match.start)));
      }
      spans.add(
        TextSpan(
          text: text.substring(match.start, match.end),
          style: TextStyle(color: colors.primary, fontWeight: FontWeight.w600),
        ),
      );
      start = match.end;
    }
    if (start < text.length) spans.add(TextSpan(text: text.substring(start)));
    return Text.rich(
      TextSpan(style: style, children: spans),
      maxLines: isTitle ? 1 : 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget? _highlightedSampleTimestamp() {
    if (widget.extractor.predefinedType !=
        PredefinedRegExpDefinition.notificationDate) {
      return null;
    }
    final DateTime now = DateTime.now();
    final bool isToday =
        _sample.receivedAt.year == now.year &&
        _sample.receivedAt.month == now.month &&
        _sample.receivedAt.day == now.day;
    final String timestamp = isToday
        ? formatNotificationTime(
            context,
            TimeOfDay.fromDateTime(_sample.receivedAt),
          )
        : formatNotificationDate(context, _sample.receivedAt);
    return Text(
      timestamp,
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  List<Widget> _regularExpressionDetails(
    ColorScheme colors,
    RegExpEvaluationResult? evaluation,
  ) => <Widget>[
    Text(
      S.of(context).notificationsExtractorPattern,
      style: context.notificationSectionTitle,
    ),
    const SizedBox(height: 4),
    Text(
      widget.isAdvancedMode
          ? S.of(context).notificationsExtractorPatternEditableDescription
          : S.of(context).notificationsExtractorPatternReadOnlyDescription,
      style: context.notificationSectionDescription,
    ),
    const SizedBox(height: 12),
    TextField(
      key: const Key('extractor-source'),
      controller: widget.sourceController,
      readOnly: !widget.isAdvancedMode,
      minLines: 1,
      maxLines: null,
      decoration: notificationInputDecoration(
        context,
        labelText: S.of(context).notificationsExtractorRegularExpression,
        contentPadding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
        suffixIcon: widget.isAdvancedMode
            ? IconButton(
                tooltip: S
                    .of(context)
                    .notificationsExtractorPasteRegularExpression,
                onPressed: widget.onPasteSource,
                icon: const Icon(Icons.content_paste_outlined),
                iconSize: 18,
              )
            : null,
      ),
    ),
    if (_validationError != null) ...<Widget>[
      const SizedBox(height: 8),
      Text(_validationError!, style: TextStyle(color: colors.error)),
    ],
    if (evaluation?.failure ==
        RegExpEvaluationFailure.invalidPattern) ...<Widget>[
      const SizedBox(height: 8),
      MessageStatusCard(
        status: MessageStatus.error,
        title: S.of(context).notificationsExtractorInvalidPattern,
        message: S.of(context).notificationsExtractorInvalidPatternMessage,
      ),
    ],
    if (widget.extractor.safetyIssues.isNotEmpty &&
        evaluation?.hasEvaluationFailure != true) ...<Widget>[
      const SizedBox(height: 8),
      MessageStatusCard(
        status: MessageStatus.warning,
        title: S.of(context).notificationsExtractorPerformanceWarning,
        message: S.of(context).notificationsExtractorPerformanceWarningMessage,
      ),
    ],
    if (evaluation != null && !evaluation.hasEvaluationFailure)
      ExtractorMatchResults(evaluation: evaluation),
  ];
}
