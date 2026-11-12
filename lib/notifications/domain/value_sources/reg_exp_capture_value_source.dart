import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_formatting_preferences.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/value_sources/value_source.dart';

enum CaptureTextFormat { localizedDateTime }

class RegExpCaptureValueSource implements ValueSource {
  const RegExpCaptureValueSource({
    required this.extractorId,
    required this.captureName,
    this.fallbackCaptureIndex,
    this.matchIndex,
    this.textFormat,
  });

  static const String type = 'regExpCapture';

  final String extractorId;
  final String captureName;
  final int? fallbackCaptureIndex;
  final int? matchIndex;
  final CaptureTextFormat? textFormat;

  @override
  String? resolve(EvaluationContext context) {
    final String? capturedValue = _resolveCapture(context);
    if (capturedValue == null ||
        textFormat != CaptureTextFormat.localizedDateTime) {
      return capturedValue;
    }
    final NotificationFormattingPreferences? preferences =
        context.formattingPreferences;
    if (preferences == null) return capturedValue;
    final DateTime? dateTime = DateTime.tryParse(capturedValue.trim());
    if (dateTime == null) return null;
    return preferences.formatDateTime(dateTime);
  }

  String? _resolveCapture(EvaluationContext context) {
    final RegExpEvaluationResult? result =
        context.extractionResults[extractorId];
    final int? selectedMatch = matchIndex;
    if (selectedMatch != null && result != null) {
      if (selectedMatch < result.matches.length) {
        final RegExpMatch match = result.matches[selectedMatch];
        final String? namedCapture = match.groupNames.contains(captureName)
            ? match.namedGroup(captureName)
            : null;
        if (namedCapture != null) return namedCapture;
        final int? fallbackIndex = fallbackCaptureIndex;
        if (fallbackIndex != null && fallbackIndex <= match.groupCount) {
          return match.group(fallbackIndex);
        }
      }
      final List<String>? indexedCaptures = result.namedCaptures[captureName];
      if (indexedCaptures != null && selectedMatch < indexedCaptures.length) {
        return indexedCaptures[selectedMatch];
      }
      return null;
    }
    final List<String>? captures = result?.namedCaptures[captureName];
    if (captures != null && captures.isNotEmpty) {
      return captures.first;
    }
    final int? fallbackIndex = fallbackCaptureIndex;
    final List<String>? fallbackCaptures = fallbackIndex == null
        ? null
        : context
              .extractionResults[extractorId]
              ?.positionalCaptures[fallbackIndex];
    return fallbackCaptures == null || fallbackCaptures.isEmpty
        ? null
        : fallbackCaptures.first;
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'type': type,
    'extractorId': extractorId,
    'captureName': captureName,
    'fallbackCaptureIndex': fallbackCaptureIndex,
    'matchIndex': matchIndex,
    if (textFormat != null) 'textFormat': textFormat!.name,
  };

  RegExpCaptureValueSource withDateTimeTextFormat() => RegExpCaptureValueSource(
    extractorId: extractorId,
    captureName: captureName,
    fallbackCaptureIndex: fallbackCaptureIndex,
    matchIndex: matchIndex,
    textFormat: CaptureTextFormat.localizedDateTime,
  );

  factory RegExpCaptureValueSource.fromJson(Map<String, dynamic> json) {
    return RegExpCaptureValueSource(
      extractorId: json['extractorId'] as String,
      captureName: json['captureName'] as String,
      fallbackCaptureIndex: json['fallbackCaptureIndex'] as int?,
      matchIndex: json['matchIndex'] as int?,
      textFormat: switch (json['textFormat']) {
        final String value => CaptureTextFormat.values.byName(value),
        _ => null,
      },
    );
  }
}
