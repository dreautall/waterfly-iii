import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_formatting_preferences.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_evaluation_result.dart';

class EvaluationContext {
  const EvaluationContext({
    required this.notification,
    required this.extractionResults,
    this.extractorNames = const <String, String>{},
    this.dateTimeExtractorIds = const <String>{},
    this.formattingPreferences,
  });

  final NotificationContext notification;
  final Map<String, RegExpEvaluationResult> extractionResults;
  final Map<String, String> extractorNames;
  final Set<String> dateTimeExtractorIds;
  final NotificationFormattingPreferences? formattingPreferences;
}
