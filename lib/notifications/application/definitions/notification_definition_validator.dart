import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/value_sources/currency_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/composed_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/date_time_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/normalized_amount_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';

class NotificationDefinitionValidator {
  const NotificationDefinitionValidator();

  int danglingActionCount(NotificationDefinition definition) {
    final Set<String> extractorIds = definition.extractors
        .map((RegExpDefinition extractor) => extractor.id)
        .toSet();
    return <NotificationAction>[
      ...definition.sharedActions,
      for (final NotificationRule rule in definition.rules) ...rule.allActions,
    ].whereType<SetTransactionFieldAction>().where((
      SetTransactionFieldAction action,
    ) {
      return _capturesFor(action).any(
        (RegExpCaptureValueSource capture) =>
            !extractorIds.contains(capture.extractorId),
      );
    }).length;
  }

  Iterable<RegExpCaptureValueSource> _capturesFor(
    SetTransactionFieldAction action,
  ) sync* {
    switch (action.valueSource) {
      case final RegExpCaptureValueSource source:
        yield source;
      case final CurrencyCaptureValueSource source:
        yield source.capture;
      case final DateTimeCaptureValueSource source:
        yield source.capture;
      case final NormalizedAmountCaptureValueSource source:
        yield source.capture;
      case final ComposedValueSource source:
        yield* source.parts.whereType<RegExpCaptureValueSource>();
    }
  }
}
