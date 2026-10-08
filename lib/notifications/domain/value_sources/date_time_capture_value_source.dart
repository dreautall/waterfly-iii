import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/value_source.dart';

class DateTimeCaptureValueSource implements ValueSource {
  const DateTimeCaptureValueSource({
    required this.capture,
    required this.field,
    required this.normalizedValue,
    this.deriveFromCapture = false,
  });

  static const String type = 'dateTimeCapture';

  final RegExpCaptureValueSource capture;
  final TransactionField field;
  final String normalizedValue;
  final bool deriveFromCapture;

  @override
  String? resolve(EvaluationContext context) {
    final String? capturedValue = capture.resolve(context);
    if (capturedValue == null) return null;
    return deriveFromCapture
        ? normalizeCapturedValue(capturedValue)
        : normalizedValue;
  }

  String? normalizeCapturedValue(String capturedValue) {
    final DateTime? dateTime = DateTime.tryParse(capturedValue.trim());
    if (dateTime == null) return null;
    if (field == TransactionField.date) {
      return dateTime.toIso8601String().substring(0, 10);
    }
    return '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')}:'
        '${dateTime.second.toString().padLeft(2, '0')}';
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'type': type,
    'capture': capture.toJson(),
    'field': field.name,
    'normalizedValue': normalizedValue,
    if (deriveFromCapture) 'deriveFromCapture': true,
  };

  factory DateTimeCaptureValueSource.fromJson(Map<String, dynamic> json) {
    return DateTimeCaptureValueSource(
      capture: RegExpCaptureValueSource.fromJson(
        json['capture'] as Map<String, dynamic>,
      ),
      field: TransactionField.values.byName(json['field'] as String),
      normalizedValue: json['normalizedValue'] as String,
      deriveFromCapture: json['deriveFromCapture'] as bool? ?? false,
    );
  }
}
