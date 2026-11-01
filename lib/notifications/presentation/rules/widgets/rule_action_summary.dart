import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/application/resources/firefly_currency_resolver.dart';
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
      if (source.resourceKind == FireflyResourceKind.currency) {
        return FutureBuilder<FireflyCurrency>(
          future: fixedCurrencyResolutions.putIfAbsent(
            source.resourceId,
            () => context.read<FireflyCurrencyResolver>().resolveById(
              source.resourceId,
            ),
          ),
          builder:
              (BuildContext context, AsyncSnapshot<FireflyCurrency> snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return resolvedValueStatusWidget(
                    S.of(context).notificationsCurrencyFixedCardChecking,
                    resolvedValueColor: colors.outline,
                    quoteResolvedValue: false,
                  );
                }
                final FireflyCurrency? currency = snapshot.data;
                if (!snapshot.hasError && currency != null) {
                  return resolvedValueStatusWidget(
                    S
                        .of(context)
                        .notificationsCurrencyDynamicOutcomeSuccess(
                          currency.code,
                          currency.name,
                        ),
                    quoteResolvedValue: false,
                  );
                }
                return resolvedValueStatusWidget(
                  snapshot.error is FireflyCurrencyUnavailableException
                      ? S.of(context).notificationsCurrencyFixedCardUnavailable
                      : S
                            .of(context)
                            .notificationsCurrencyFixedCardLookupFailure,
                  resolvedValueColor: colors.tertiary,
                  quoteResolvedValue: false,
                  maxLines: 2,
                );
              },
        );
      }
      return FireflyResourceLabel(
        kind: source.resourceKind,
        id: source.resourceId,
        style: TextStyle(color: colors.outline),
      );
    }
    if (source is CurrencyCaptureValueSource) {
      if (source.resolutionMode == CurrencyResolutionMode.dynamic) {
        final String captured = status.resolvedValue!;
        return FutureBuilder<FireflyCurrencyResolution>(
          future: dynamicCurrencyResolutions.putIfAbsent(
            captured,
            () => context.read<FireflyCurrencyResolver>().inspect(captured),
          ),
          builder:
              (
                BuildContext context,
                AsyncSnapshot<FireflyCurrencyResolution> snapshot,
              ) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return resolvedValueStatusWidget(
                    captured,
                    outcome: S
                        .of(context)
                        .notificationsCurrencyDynamicOutcomeChecking,
                    outcomeColor: colors.outline,
                  );
                }
                final FireflyCurrencyResolution? resolution = snapshot.data;
                final FireflyCurrency? currency = resolution?.currency;
                final bool resolved = !snapshot.hasError && currency != null;
                return resolvedValueStatusWidget(
                  captured,
                  outcome: snapshot.hasError
                      ? S
                            .of(context)
                            .notificationsCurrencyDynamicOutcomeLookupFailure
                      : resolved
                      ? S
                            .of(context)
                            .notificationsCurrencyDynamicOutcomeSuccess(
                              currency.code,
                              currency.name,
                            )
                      : resolution?.status ==
                            FireflyCurrencyResolutionStatus.ambiguous
                      ? S
                            .of(context)
                            .notificationsCurrencyDynamicOutcomeAmbiguous
                      : S
                            .of(context)
                            .notificationsCurrencyDynamicOutcomeUnavailable,
                  outcomeColor: resolved ? colors.onSurface : colors.tertiary,
                  maxLines: 2,
                );
              },
        );
      }
      return FireflyResourceLabel(
        kind: FireflyResourceKind.currency,
        id: source.resourceId!,
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
    return resolvedValueStatusWidget(
      displayValue,
      outcome: status.mappedValue == null
          ? null
          : field == null
          ? status.mappedValue
          : formatTransactionFieldValue(context, field, status.mappedValue!),
    );
  }

  Widget resolvedValueStatusWidget(
    String resolvedValue, {
    String? outcome,
    Color? outcomeColor,
    Color? resolvedValueColor,
    bool quoteResolvedValue = true,
    int maxLines = 1,
  }) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Text.rich(
      TextSpan(
        style: TextStyle(color: colors.outline),
        children: <InlineSpan>[
          TextSpan(text: S.of(context).notificationsResolvedValueLabel),
          if (quoteResolvedValue) const TextSpan(text: '"'),
          TextSpan(
            text: resolvedValue,
            style: TextStyle(color: resolvedValueColor ?? colors.onSurface),
          ),
          if (quoteResolvedValue) const TextSpan(text: '"'),
          if (outcome != null) ...<InlineSpan>[
            const TextSpan(text: ' → '),
            TextSpan(
              text: outcome,
              style: TextStyle(color: outcomeColor ?? colors.onSurface),
            ),
          ],
        ],
      ),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
