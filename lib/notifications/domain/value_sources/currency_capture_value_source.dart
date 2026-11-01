import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/value_source.dart';

enum CurrencyResolutionMode { fixed, dynamic }

class CurrencyCaptureValueSource implements ValueSource {
  const CurrencyCaptureValueSource({
    required this.capture,
    this.resolutionMode = CurrencyResolutionMode.fixed,
    this.resourceId,
    this.expectedValue,
  }) : assert(
         resolutionMode == CurrencyResolutionMode.dynamic || resourceId != null,
       );

  static const String type = 'currencyCapture';

  final RegExpCaptureValueSource capture;
  final CurrencyResolutionMode resolutionMode;
  final String? resourceId;
  final String? expectedValue;

  @override
  String? resolve(EvaluationContext context) {
    final String? capturedValue = capture.resolve(context);
    if (capturedValue == null) return null;
    final String? expected = expectedValue;
    if (expected != null &&
        capturedValue.trim().toUpperCase() != expected.trim().toUpperCase()) {
      return null;
    }
    return resolutionMode == CurrencyResolutionMode.dynamic
        ? capturedValue.trim()
        : resourceId;
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'type': type,
    'capture': capture.toJson(),
    if (resolutionMode != CurrencyResolutionMode.fixed)
      'resolutionMode': resolutionMode.name,
    if (resourceId != null) 'resourceId': resourceId,
    if (expectedValue != null) 'expectedValue': expectedValue,
  };

  factory CurrencyCaptureValueSource.fromJson(Map<String, dynamic> json) {
    return CurrencyCaptureValueSource(
      capture: RegExpCaptureValueSource.fromJson(
        json['capture'] as Map<String, dynamic>,
      ),
      resolutionMode: CurrencyResolutionMode.values.firstWhere(
        (CurrencyResolutionMode mode) => mode.name == json['resolutionMode'],
        orElse: () => CurrencyResolutionMode.fixed,
      ),
      resourceId: json['resourceId'] as String?,
      expectedValue: json['expectedValue'] as String?,
    );
  }
}
