import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';
import 'package:waterflyiii/notifications/domain/value_sources/literal_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/value_source.dart';

class ComposedValueSource implements ValueSource {
  ComposedValueSource(Iterable<ValueSource> parts)
    : parts = List<ValueSource>.unmodifiable(parts) {
    _validate(this.parts);
  }

  static const String type = 'composed';
  static const int maxParts = 20;
  static const int maxResolvedLength = 10000;

  final List<ValueSource> parts;

  static bool canCompose(Iterable<ValueSource> parts) {
    try {
      ComposedValueSource(parts);
      return true;
    } on FormatException {
      return false;
    }
  }

  @override
  String? resolve(EvaluationContext context) {
    final StringBuffer result = StringBuffer();
    for (final ValueSource part in parts) {
      final ValueSource resolvedPart =
          part is RegExpCaptureValueSource &&
              part.textFormat == null &&
              context.dateTimeExtractorIds.contains(part.extractorId)
          ? part.withDateTimeTextFormat()
          : part;
      final String? value = resolvedPart.resolve(context);
      if (value == null) return null;
      result.write(value);
      if (result.length > maxResolvedLength) return null;
    }
    return result.toString();
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'type': type,
    'parts': parts.map((ValueSource part) => part.toJson()).toList(),
  };

  factory ComposedValueSource.fromJson(Map<String, dynamic> json) {
    final Object? rawParts = json['parts'];
    if (rawParts is! List) {
      throw const FormatException(
        'Composed value source parts must be a list.',
      );
    }
    try {
      return ComposedValueSource(
        rawParts.map(
          (Object? part) => ValueSource.fromJson(
            Map<String, dynamic>.from(part! as Map<Object?, Object?>),
          ),
        ),
      );
    } on FormatException {
      rethrow;
    } catch (error) {
      throw FormatException('Invalid composed value source: $error');
    }
  }

  static void _validate(List<ValueSource> parts) {
    if (parts.isEmpty) {
      throw const FormatException(
        'Composed value sources require at least one part.',
      );
    }
    if (parts.length > maxParts) {
      throw const FormatException(
        'Composed value sources support at most $maxParts parts.',
      );
    }
    if (parts.any((ValueSource part) => part is ComposedValueSource)) {
      throw const FormatException('Nested composed value sources are invalid.');
    }
    final int literalLength = parts.whereType<LiteralValueSource>().fold<int>(
      0,
      (int total, LiteralValueSource part) {
        return total + part.value.length;
      },
    );
    if (literalLength > maxResolvedLength) {
      throw const FormatException(
        'Composed value source fixed text is too long.',
      );
    }
  }
}
