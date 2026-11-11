import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';
import 'package:waterflyiii/notifications/domain/conditions/normalized_number.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/value_source.dart';

class NormalizedAmountCaptureValueSource implements ValueSource {
  const NormalizedAmountCaptureValueSource({required this.capture});

  static const String type = 'normalizedAmountCapture';

  final RegExpCaptureValueSource capture;

  @override
  String? resolve(EvaluationContext context) {
    final String? capturedValue = capture.resolve(context);
    return capturedValue == null ? null : normalize(capturedValue);
  }

  static String? normalize(String value) {
    final String normalized = value.replaceAll(RegExp(r'[^0-9.,]'), '');
    if (normalized.isEmpty) return null;
    return normalizeTransactionAmount(normalized);
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'type': type,
    'capture': capture.toJson(),
  };

  factory NormalizedAmountCaptureValueSource.fromJson(
    Map<String, dynamic> json,
  ) => NormalizedAmountCaptureValueSource(
    capture: RegExpCaptureValueSource.fromJson(
      json['capture'] as Map<String, dynamic>,
    ),
  );
}
