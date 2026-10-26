import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/currency_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/composed_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/date_time_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/firefly_resource_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/literal_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/normalized_amount_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/value_source.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/actions/transaction_action_value_dialog.dart';
import 'package:waterflyiii/notifications/presentation/shared/transaction_field_value_formatter.dart';
import 'package:waterflyiii/notifications/presentation/shared/firefly_resource_label.dart';

import 'package:waterflyiii/notifications/presentation/rules/widgets/rule_action_editor.dart';

extension RuleActionSummary on RuleActionsSectionState {
  Widget actionSummary(NotificationAction action, {bool isOptional = false}) {
    if (action is! SetTransactionFieldAction) {
      return Text(action.runtimeType.toString());
    }
    final Color accent = Theme.of(context).colorScheme.primary;
    final String field = transactionFieldLabel(
      context,
      action.target,
    ).toLowerCase();
    final ValueSource source = action.valueSource;
    if (source is CurrencyCaptureValueSource) {
      return Text.rich(
        TextSpan(
          text: isOptional
              ? S.of(context).notificationsRuleOptionalFieldPrefix
              : S.of(context).notificationsRuleSetFieldPrefix,
          children: <InlineSpan>[
            const TextSpan(text: '"'),
            TextSpan(
              text: field,
              style: TextStyle(color: accent),
            ),
            const TextSpan(text: '"'),
            TextSpan(text: S.of(context).notificationsRuleFromExtractorPrefix),
            const TextSpan(text: '"'),
            TextSpan(
              text: extractorName(source.capture),
              style: TextStyle(color: accent),
            ),
            const TextSpan(text: '"'),
          ],
        ),
      );
    }
    if (source is DateTimeCaptureValueSource ||
        source is NormalizedAmountCaptureValueSource) {
      final RegExpCaptureValueSource capture = switch (source) {
        DateTimeCaptureValueSource(:final RegExpCaptureValueSource capture) =>
          capture,
        NormalizedAmountCaptureValueSource(
          :final RegExpCaptureValueSource capture,
        ) =>
          capture,
        _ => throw StateError('Expected a normalized capture source.'),
      };
      return Text.rich(
        TextSpan(
          text: S.of(context).notificationsRuleSetFieldPrefix,
          children: <InlineSpan>[
            const TextSpan(text: '"'),
            TextSpan(
              text: field,
              style: TextStyle(color: accent),
            ),
            const TextSpan(text: '"'),
            TextSpan(text: S.of(context).notificationsRuleFromExtractorPrefix),
            const TextSpan(text: '"'),
            TextSpan(
              text: extractorName(capture),
              style: TextStyle(color: accent),
            ),
            const TextSpan(text: '"'),
          ],
        ),
      );
    }
    if (source is RegExpCaptureValueSource) {
      return Text.rich(
        TextSpan(
          text: S.of(context).notificationsRuleSetFieldPrefix,
          children: <InlineSpan>[
            const TextSpan(text: '"'),
            TextSpan(
              text: field,
              style: TextStyle(color: accent),
            ),
            const TextSpan(text: '"'),
            TextSpan(text: S.of(context).notificationsRuleFromExtractorPrefix),
            const TextSpan(text: '"'),
            TextSpan(
              text: extractorName(source),
              style: TextStyle(color: accent),
            ),
            const TextSpan(text: '"'),
          ],
        ),
      );
    }
    final String value = switch (source) {
      LiteralValueSource() => S.of(context).notificationsRuleLiteralValue,
      ComposedValueSource() => sourceText(source),
      FireflyResourceValueSource() =>
        S.of(context).notificationsRuleFireflySuppliedValue,
      _ => sourceText(source),
    };
    final bool usesPlainSourceLabel =
        source is LiteralValueSource || source is FireflyResourceValueSource;
    return Text.rich(
      TextSpan(
        text: S.of(context).notificationsRuleSetFieldPrefix,
        children: <InlineSpan>[
          const TextSpan(text: '"'),
          TextSpan(
            text: field,
            style: TextStyle(color: accent),
          ),
          const TextSpan(text: '"'),
          TextSpan(text: S.of(context).notificationsRuleToPrefix),
          if (usesPlainSourceLabel)
            TextSpan(text: value)
          else ...<InlineSpan>[
            const TextSpan(text: '"'),
            TextSpan(
              text: value,
              style: TextStyle(color: accent),
            ),
            const TextSpan(text: '"'),
          ],
        ],
      ),
    );
  }

  String actionValueText(ValueSource source, TransactionField field) {
    if (source is LiteralValueSource) {
      return formatTransactionFieldValue(context, field, source.value);
    }
    if (source is FireflyResourceValueSource) return source.resourceId;
    return sourceText(source);
  }

  Widget actionStatusWidget(
    ActionCardStatus status,
    ValueSource? source,
    TransactionField? field,
  ) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    if (status.hasError) {
      return Text(
        status.errorMessage!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: colors.error),
      );
    }
    if (source is FireflyResourceValueSource) {
      return FireflyResourceLabel(
        kind: source.resourceKind,
        id: source.resourceId,
        style: TextStyle(color: colors.outline),
      );
    }
    if (source is CurrencyCaptureValueSource) {
      return FireflyResourceLabel(
        kind: FireflyResourceKind.currency,
        id: source.resourceId,
        style: TextStyle(color: colors.outline),
      );
    }
    final String resolvedValue = status.resolvedValue!;
    final String displayValue = source is DateTimeCaptureValueSource
        ? resolvedValueText(resolvedValue, source)
        : field == null
        ? source == null
              ? resolvedValue
              : resolvedValueText(resolvedValue, source)
        : formatTransactionFieldValue(context, field, resolvedValue);
    return Text.rich(
      TextSpan(
        style: TextStyle(color: colors.outline),
        children: <InlineSpan>[
          TextSpan(text: S.of(context).notificationsResolvedValueLabel),
          const TextSpan(text: '"'),
          TextSpan(
            text: displayValue,
            style: TextStyle(color: colors.onSurface),
          ),
          const TextSpan(text: '"'),
          if (status.mappedValue != null) ...<InlineSpan>[
            const TextSpan(text: ' → '),
            TextSpan(
              text: field == null
                  ? status.mappedValue
                  : formatTransactionFieldValue(
                      context,
                      field,
                      status.mappedValue!,
                    ),
              style: TextStyle(color: colors.onSurface),
            ),
          ],
        ],
      ),
    );
  }
}
