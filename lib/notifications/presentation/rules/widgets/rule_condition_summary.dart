import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/value_contains_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/value_exists_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/values_equal_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/values_greater_than_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/values_greater_than_or_equal_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/values_less_than_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/values_less_than_or_equal_condition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/value_sources/currency_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/date_time_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/literal_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/normalized_amount_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/value_source.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_date_time_formatter.dart';

import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_condition_editor.dart';
import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_condition_clipboard.dart';

extension RuleConditionSummary on RuleConditionsSectionState {
  Widget conditionTitle(NotificationCondition condition) {
    final List<InlineSpan> spans = <InlineSpan>[];
    void addExtractorOperand(
      RegExpCaptureValueSource source, {
      required bool lowercase,
    }) {
      spans.add(
        TextSpan(
          text: lowercase
              ? S.of(context).notificationsRuleExtractorLowercase
              : S.of(context).notificationsRuleExtractor,
        ),
      );
      spans.add(const TextSpan(text: '"'));
      spans.add(
        TextSpan(
          text: extractorName(source),
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      );
      spans.add(const TextSpan(text: '"'));
      spans.add(TextSpan(text: S.of(context).notificationsRuleValueSuffix));
    }

    void addLeftOperand(ValueSource source) {
      if (source is RegExpCaptureValueSource) {
        addExtractorOperand(source, lowercase: false);
        return;
      }
      if (source is LiteralValueSource) {
        spans.add(const TextSpan(text: '"'));
        spans.add(
          TextSpan(
            text: source.value,
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        );
        spans.add(const TextSpan(text: '"'));
        return;
      }
      spans.add(TextSpan(text: sourceText(source)));
    }

    void addRightOperand(ValueSource source, ValueSource? comparisonLeft) {
      if (source is RegExpCaptureValueSource) {
        addExtractorOperand(source, lowercase: true);
        return;
      }
      if (source is LiteralValueSource) {
        spans.add(const TextSpan(text: '"'));
        spans.add(
          TextSpan(
            text: formattedLiteralValue(source.value, comparisonLeft),
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        );
        spans.add(const TextSpan(text: '"'));
        return;
      }
      spans.add(TextSpan(text: sourceText(source)));
    }

    void addOperator(String value) => spans.add(
      TextSpan(
        text: ' $value ',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );

    switch (condition) {
      case ValueExistsCondition(:final ValueSource valueSource):
        addLeftOperand(valueSource);
        addOperator(S.of(context).notificationsConditionExists);
      case ValuesEqualCondition(
        :final ValueSource left,
        :final ValueSource right,
      ):
        addLeftOperand(left);
        addOperator(S.of(context).notificationsConditionEquals);
        addRightOperand(right, left);
      case ValueContainsCondition(
        :final ValueSource value,
        :final ValueSource substring,
      ):
        addLeftOperand(value);
        addOperator(S.of(context).notificationsConditionContains);
        addRightOperand(substring, value);
      case ValuesGreaterThanCondition(
        :final ValueSource left,
        :final ValueSource right,
      ):
        addLeftOperand(left);
        addOperator(S.of(context).notificationsConditionGreaterThan);
        addRightOperand(right, left);
      case ValuesGreaterThanOrEqualCondition(
        :final ValueSource left,
        :final ValueSource right,
      ):
        addLeftOperand(left);
        addOperator(S.of(context).notificationsConditionAtLeast);
        addRightOperand(right, left);
      case ValuesLessThanCondition(
        :final ValueSource left,
        :final ValueSource right,
      ):
        addLeftOperand(left);
        addOperator(S.of(context).notificationsConditionLessThan);
        addRightOperand(right, left);
      case ValuesLessThanOrEqualCondition(
        :final ValueSource left,
        :final ValueSource right,
      ):
        addLeftOperand(left);
        addOperator(S.of(context).notificationsConditionAtMost);
        addRightOperand(right, left);
      default:
        return Text(condition.runtimeType.toString());
    }
    return Text.rich(
      TextSpan(
        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        children: spans,
      ),
    );
  }

  String formattedLiteralValue(String value, ValueSource? comparisonLeft) {
    final String? leftValue = comparisonLeft?.resolve(
      conditionEvaluationContext,
    );
    final String normalizedLeftValue = leftValue?.trim() ?? '';
    if (DateTime.tryParse(normalizedLeftValue) == null) return value;
    final DateTime? date = DateTime.tryParse(value.trim());
    if (date == null) return value;
    final String formattedDate = formatNotificationDate(context, date);
    if (!RegExp(r'^\d{4}-\d{2}-\d{2}T').hasMatch(value.trim())) {
      return formattedDate;
    }
    return formatNotificationDateTime(context, date);
  }

  List<ValueSource> conditionSources(NotificationCondition condition) =>
      switch (condition) {
        ValueExistsCondition(:final ValueSource valueSource) => <ValueSource>[
          valueSource,
        ],
        ValuesEqualCondition(
          :final ValueSource left,
          :final ValueSource right,
        ) =>
          <ValueSource>[left, right],
        ValueContainsCondition(
          :final ValueSource value,
          :final ValueSource substring,
        ) =>
          <ValueSource>[value, substring],
        ValuesGreaterThanCondition(
          :final ValueSource left,
          :final ValueSource right,
        ) =>
          <ValueSource>[left, right],
        ValuesGreaterThanOrEqualCondition(
          :final ValueSource left,
          :final ValueSource right,
        ) =>
          <ValueSource>[left, right],
        ValuesLessThanCondition(
          :final ValueSource left,
          :final ValueSource right,
        ) =>
          <ValueSource>[left, right],
        ValuesLessThanOrEqualCondition(
          :final ValueSource left,
          :final ValueSource right,
        ) =>
          <ValueSource>[left, right],
        _ => const <ValueSource>[],
      };

  Widget? conditionConfigurationSubtitle(NotificationCondition condition) {
    final List<String> captures = conditionSources(
      condition,
    ).map(configurationCaptureText).whereType<String>().toSet().toList();
    if (captures.isEmpty) return null;
    return Text(
      captures.length == 1
          ? S.of(context).notificationsRuleConditionCapture(captures.single)
          : S
                .of(context)
                .notificationsRuleConditionCaptures(captures.join(', ')),
      style: TextStyle(color: Theme.of(context).colorScheme.outline),
    );
  }

  String? configurationCaptureText(ValueSource source) {
    final RegExpCaptureValueSource? capture = switch (source) {
      CurrencyCaptureValueSource(:final RegExpCaptureValueSource capture) =>
        capture,
      DateTimeCaptureValueSource(:final RegExpCaptureValueSource capture) =>
        capture,
      NormalizedAmountCaptureValueSource(
        :final RegExpCaptureValueSource capture,
      ) =>
        capture,
      final RegExpCaptureValueSource capture => capture,
      _ => null,
    };
    if (capture == null || capture.captureName.isEmpty) return null;
    final RegExpDefinition? extractor = extractorFor(capture);
    if (extractor == null ||
        extractor.type == RegExpDefinitionType.predefined) {
      return null;
    }
    return capture.captureName;
  }

  Widget conditionTestSummary(
    NotificationCondition condition, {
    required String status,
    required Color statusColor,
  }) {
    final List<ValueSource> sources = conditionSources(
      condition,
    ).where((ValueSource source) => source is! LiteralValueSource).toList();
    final List<({ValueSource source, String? value})> resolvedSources = sources
        .map(
          (ValueSource source) => (
            source: source,
            value: source.resolve(conditionEvaluationContext),
          ),
        )
        .toList();
    return Text.rich(
      TextSpan(
        style: TextStyle(color: Theme.of(context).colorScheme.outline),
        children: <InlineSpan>[
          TextSpan(
            text: status,
            style: TextStyle(color: statusColor),
          ),
          for (final (int index, ({ValueSource source, String? value}) resolved)
              in resolvedSources.indexed) ...<InlineSpan>[
            const TextSpan(text: ' · '),
            TextSpan(
              text: resolvedSources.length == 1
                  ? S.of(context).notificationsRuleSampleValueLabel
                  : index == 0
                  ? S.of(context).notificationsRuleLeftSampleValueLabel
                  : S.of(context).notificationsRuleRightSampleValueLabel,
            ),
            TextSpan(
              text: switch (resolved.value) {
                final String value => resolvedValueText(value, resolved.source),
                null => S.of(context).notificationsUnresolved,
              },
              style: TextStyle(
                color: resolved.value == null
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String resolvedValueText(String value, ValueSource source) {
    final bool isDateTimeCapture =
        source is DateTimeCaptureValueSource ||
        (source is RegExpCaptureValueSource &&
            extractorFor(source)?.predefinedType ==
                PredefinedRegExpDefinition.notificationDate);
    final DateTime? dateTime = isDateTimeCapture
        ? DateTime.tryParse(value.trim())
        : null;
    if (dateTime == null) return value;
    return formatNotificationDateTime(context, dateTime);
  }
}
