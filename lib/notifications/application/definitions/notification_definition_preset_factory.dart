import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/notification_id.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/date_time_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';

class NotificationDefinitionPresetFactory {
  const NotificationDefinitionPresetFactory();

  RegExpDefinition createPredefinedExtractor(PredefinedRegExpDefinition type) =>
      RegExpDefinition.createPredefinedRegExpDefinition(
        type,
        description: type.defaultDescription,
      );

  List<RegExpDefinition> basicExtractors() =>
      PredefinedRegExpDefinition.values.map(createPredefinedExtractor).toList();

  List<RegExpDefinition> advancedDefaultExtractors() => <RegExpDefinition>[
    createPredefinedExtractor(PredefinedRegExpDefinition.notificationTitle),
    createPredefinedExtractor(PredefinedRegExpDefinition.notificationMessage),
    createPredefinedExtractor(PredefinedRegExpDefinition.notificationDate),
    createPredefinedExtractor(PredefinedRegExpDefinition.amount),
  ];

  NotificationRule standardTransactionRule(List<RegExpDefinition> extractors) {
    RegExpDefinition extractorFor(PredefinedRegExpDefinition type) =>
        extractors.firstWhere(
          (RegExpDefinition extractor) => extractor.predefinedType == type,
        );
    RegExpCaptureValueSource capture(
      PredefinedRegExpDefinition type,
      String captureName,
    ) => RegExpCaptureValueSource(
      extractorId: extractorFor(type).id,
      captureName: captureName,
    );
    return NotificationRule(
      id: newNotificationId(),
      name: 'Transaction details',
      description:
          'Maps the notification amount, date, and time to transaction fields.',
      conditions: const <NotificationCondition>[],
      isPredefined: true,
      actions: <NotificationAction>[
        SetTransactionFieldAction(
          target: TransactionField.amount,
          valueSource: capture(PredefinedRegExpDefinition.amount, 'amount'),
        ),
        SetTransactionFieldAction(
          target: TransactionField.date,
          valueSource: DateTimeCaptureValueSource(
            capture: capture(
              PredefinedRegExpDefinition.notificationDate,
              'date',
            ),
            field: TransactionField.date,
            normalizedValue: '',
            deriveFromCapture: true,
          ),
        ),
        SetTransactionFieldAction(
          target: TransactionField.time,
          valueSource: DateTimeCaptureValueSource(
            capture: capture(
              PredefinedRegExpDefinition.notificationDate,
              'date',
            ),
            field: TransactionField.time,
            normalizedValue: '',
            deriveFromCapture: true,
          ),
        ),
      ],
    );
  }
}
