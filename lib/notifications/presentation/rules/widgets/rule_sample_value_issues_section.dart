import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_rule_requirement.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_evaluation_result.dart';
import 'package:waterflyiii/notifications/presentation/rules/controllers/notification_rule_editor_view_model.dart';
import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_editor_section.dart';
import 'package:waterflyiii/notifications/presentation/shared/definition_detail_card.dart';

class AnimatedRuleSampleIssues extends StatelessWidget {
  const AnimatedRuleSampleIssues({
    super.key,
    required this.visible,
    required this.groups,
    required this.notificationContext,
    this.onEditExtractor,
  });

  final bool visible;
  final List<NotificationRuleRequirementGroup> groups;
  final NotificationContext notificationContext;
  final Future<void> Function(RegExpDefinition extractor)? onEditExtractor;

  @override
  Widget build(BuildContext context) {
    final RuleSampleValueIssuesSection section = RuleSampleValueIssuesSection(
      groups: groups,
      notificationContext: notificationContext,
      onEditExtractor: onEditExtractor,
    );
    final bool show = visible && section.hasIssues;
    return AnimatedSize(
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeInOut,
      alignment: Alignment.topCenter,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 180),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        transitionBuilder: (Widget child, Animation<double> animation) =>
            FadeTransition(
              key: const Key('rule-sample-value-issues-fade'),
              opacity: animation,
              child: child,
            ),
        child: show
            ? Padding(
                key: const Key('rule-sample-value-issues'),
                padding: const EdgeInsets.only(top: 24),
                child: section,
              )
            : const SizedBox.shrink(key: Key('rule-sample-value-issues-empty')),
      ),
    );
  }
}

class RuleSampleValueIssuesSection extends StatelessWidget {
  const RuleSampleValueIssuesSection({
    super.key,
    required this.groups,
    required this.notificationContext,
    this.onEditExtractor,
  });

  final List<NotificationRuleRequirementGroup> groups;
  final NotificationContext notificationContext;
  final Future<void> Function(RegExpDefinition extractor)? onEditExtractor;

  List<_SampleValueIssue> get _issues {
    final Map<String, RegExpEvaluationResult> extractionResults =
        <String, RegExpEvaluationResult>{
          for (final NotificationRuleRequirementGroup group in groups)
            if (group.extractor case final RegExpDefinition extractor)
              extractor.id: extractor.evaluate(notificationContext),
        };
    final EvaluationContext context = EvaluationContext(
      notification: notificationContext,
      extractionResults: extractionResults,
    );
    return groups
        .map(
          (NotificationRuleRequirementGroup group) =>
              _SampleValueIssue.from(group, context),
        )
        .where((_SampleValueIssue issue) => issue.unresolved.isNotEmpty)
        .toList()
      ..sort(
        (_SampleValueIssue left, _SampleValueIssue right) =>
            left.name.toLowerCase().compareTo(right.name.toLowerCase()),
      );
  }

  bool get hasIssues => _issues.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final List<_SampleValueIssue> issues = _issues;
    if (issues.isEmpty) return const SizedBox.shrink();
    return RuleEditorSection(
      title: S.of(context).notificationsRuleSampleValueIssuesTitle,
      description: S.of(context).notificationsRuleSampleValueIssuesDescription,
      content: Column(
        children: issues.indexed
            .map(
              ((int, _SampleValueIssue) entry) => Padding(
                padding: EdgeInsets.only(
                  bottom: entry.$1 == issues.length - 1 ? 0 : 8,
                ),
                child: _issueCard(context, entry.$2),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _issueCard(BuildContext context, _SampleValueIssue issue) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final RegExpDefinition? extractor = issue.group.extractor;
    return DefinitionDetailCard(
      leading: Icon(Icons.error_outline, color: colors.tertiary),
      title: Text(
        extractor?.definitionName ??
            S.of(context).notificationsRuleMissingExtractorTitle,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (issue.group.inherited)
            Text(
              S.of(context).notificationsRuleInheritedFromSharedActions,
              style: TextStyle(color: colors.tertiary),
            ),
          Text(
            _issueMessage(context, issue),
            style: TextStyle(color: colors.tertiary),
          ),
        ],
      ),
      trailing: extractor == null || onEditExtractor == null
          ? null
          : const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(Icons.edit_outlined, size: 18),
            ),
      onTap: extractor == null || onEditExtractor == null
          ? null
          : () => onEditExtractor!(extractor),
    );
  }

  String _issueMessage(BuildContext context, _SampleValueIssue issue) {
    final RegExpDefinition? extractor = issue.group.extractor;
    if (extractor == null) {
      return S.of(context).notificationsRuleMissingRequiredExtractor;
    }
    final RegExpEvaluationResult evaluation = extractor.evaluate(
      notificationContext,
    );
    return switch (evaluation.failure) {
      RegExpEvaluationFailure.invalidPattern =>
        S.of(context).notificationsExtractorInvalidPattern,
      RegExpEvaluationFailure.inputTooLong =>
        S.of(context).notificationsExtractorInputTooLong,
      null when !evaluation.hasMatches =>
        S.of(context).notificationsExtractorNoSampleMatch,
      null =>
        S
            .of(context)
            .notificationsRuleMissingCaptureValues(
              issue.unresolved
                  .map(
                    (NotificationRuleRequirement requirement) =>
                        requirement.capture.captureName,
                  )
                  .join(', '),
            ),
    };
  }
}

class _SampleValueIssue {
  const _SampleValueIssue(this.group, this.unresolved);

  factory _SampleValueIssue.from(
    NotificationRuleRequirementGroup group,
    EvaluationContext context,
  ) => _SampleValueIssue(
    group,
    group.requirements
        .where(
          (NotificationRuleRequirement requirement) =>
              !requirement.isAvailable(context),
        )
        .toList(),
  );

  final NotificationRuleRequirementGroup group;
  final List<NotificationRuleRequirement> unresolved;

  String get name => group.extractor?.definitionName ?? '';
}
