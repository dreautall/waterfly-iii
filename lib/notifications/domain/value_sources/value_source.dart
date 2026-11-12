import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';
import 'package:waterflyiii/notifications/domain/value_sources/currency_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/composed_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/date_time_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/firefly_resource_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/literal_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/normalized_amount_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/notification_property_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';

abstract interface class ValueSource {
  String? resolve(EvaluationContext context);

  Map<String, dynamic> toJson();

  static ValueSource fromJson(Map<String, dynamic> json) {
    switch (json['type'] as String) {
      case LiteralValueSource.type:
        return LiteralValueSource.fromJson(json);
      case NotificationPropertyValueSource.type:
        return NotificationPropertyValueSource.fromJson(json);
      case RegExpCaptureValueSource.type:
        return RegExpCaptureValueSource.fromJson(json);
      case FireflyResourceValueSource.type:
        return FireflyResourceValueSource.fromJson(json);
      case CurrencyCaptureValueSource.type:
        return CurrencyCaptureValueSource.fromJson(json);
      case DateTimeCaptureValueSource.type:
        return DateTimeCaptureValueSource.fromJson(json);
      case NormalizedAmountCaptureValueSource.type:
        return NormalizedAmountCaptureValueSource.fromJson(json);
      case ComposedValueSource.type:
        return ComposedValueSource.fromJson(json);
      default:
        throw FormatException('Unknown value source type: ${json['type']}');
    }
  }
}
