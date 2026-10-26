import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/currency_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/composed_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/date_time_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/normalized_amount_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';

class NotificationRuleDiagnostics {
  const NotificationRuleDiagnostics({
    required this.rule,
    required this.extractors,
    required this.notificationContext,
  });

  final NotificationRule rule;
  final List<RegExpDefinition> extractors;
  final NotificationContext notificationContext;

  Set<TransactionField> get incompleteFields => rule.allActions
      .whereType<SetTransactionFieldAction>()
      .where((SetTransactionFieldAction action) {
        if (action.target == TransactionField.currency &&
            action.valueSource is! CurrencyCaptureValueSource) {
          return true;
        }

        return _capturesFor(action).any((RegExpCaptureValueSource capture) {
          final RegExpDefinition? extractor = _extractor(capture.extractorId);
          if (extractor == null) return true;
          final List<RegExpMatch> matches = extractor
              .evaluate(notificationContext)
              .matches;
          if (matches.isEmpty) return true;
          if (capture.matchIndex != null) {
            return capture.matchIndex! >= matches.length;
          }
          return matches.length > 1;
        });
      })
      .map((SetTransactionFieldAction action) => action.target)
      .toSet();

  Set<TransactionField> get unreviewedPredefinedFields {
    if (!rule.isPredefined) return const <TransactionField>{};
    return rule.allActions
        .whereType<SetTransactionFieldAction>()
        .where(
          (SetTransactionFieldAction action) =>
              _isAdjustablePredefinedAction(action) &&
              !rule.reviewedPredefinedFields.contains(action.target),
        )
        .map((SetTransactionFieldAction action) => action.target)
        .toSet();
  }

  bool _isAdjustablePredefinedAction(SetTransactionFieldAction action) {
    if (action.target == TransactionField.currency) return true;
    final RegExpCaptureValueSource? capture = _capturesFor(action).firstOrNull;
    if (capture == null) return false;
    final RegExpDefinition? extractor = _extractor(capture.extractorId);
    if (extractor == null) return false;
    final List<RegExpMatch> matches = extractor
        .evaluate(notificationContext)
        .matches;
    return matches.length > 1 ||
        matches.any(
          (RegExpMatch match) =>
              match.groupNames
                  .where(
                    (String name) =>
                        match.namedGroup(name)?.isNotEmpty ?? false,
                  )
                  .length >
              1,
        );
  }

  Iterable<RegExpCaptureValueSource> _capturesFor(
    SetTransactionFieldAction action,
  ) sync* {
    switch (action.valueSource) {
      case final CurrencyCaptureValueSource source:
        yield source.capture;
      case final DateTimeCaptureValueSource source:
        yield source.capture;
      case final NormalizedAmountCaptureValueSource source:
        yield source.capture;
      case final RegExpCaptureValueSource source:
        yield source;
      case final ComposedValueSource source:
        yield* source.parts.whereType<RegExpCaptureValueSource>();
    }
  }

  RegExpDefinition? _extractor(String id) =>
      extractors.cast<RegExpDefinition?>().firstWhere(
        (RegExpDefinition? extractor) => extractor?.id == id,
        orElse: () => null,
      );
}

extension NotificationRuleDiagnosticAccess on NotificationRule {
  NotificationRuleDiagnostics diagnostics({
    required List<RegExpDefinition> extractors,
    required NotificationContext notificationContext,
  }) => NotificationRuleDiagnostics(
    rule: this,
    extractors: extractors,
    notificationContext: notificationContext,
  );
}
