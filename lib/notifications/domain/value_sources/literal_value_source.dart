import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';
import 'package:waterflyiii/notifications/domain/value_sources/value_source.dart';

class LiteralValueSource implements ValueSource {
  const LiteralValueSource(this.value);

  static const String type = 'literal';

  final String value;

  @override
  String resolve(EvaluationContext context) => value;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'type': type,
    'value': value,
  };

  factory LiteralValueSource.fromJson(Map<String, dynamic> json) {
    return LiteralValueSource(json['value'] as String);
  }
}
