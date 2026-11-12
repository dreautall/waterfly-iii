import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';

class NotificationRuleRequirement {
  const NotificationRuleRequirement(this.capture);

  final RegExpCaptureValueSource capture;

  bool isAvailable(EvaluationContext context) {
    final String? value = capture.resolve(context);
    return value != null && value.isNotEmpty;
  }

  @override
  bool operator ==(Object other) =>
      other is NotificationRuleRequirement &&
      other.capture.extractorId == capture.extractorId &&
      other.capture.captureName == capture.captureName &&
      other.capture.fallbackCaptureIndex == capture.fallbackCaptureIndex &&
      other.capture.matchIndex == capture.matchIndex;

  @override
  int get hashCode => Object.hash(
    capture.extractorId,
    capture.captureName,
    capture.fallbackCaptureIndex,
    capture.matchIndex,
  );
}
