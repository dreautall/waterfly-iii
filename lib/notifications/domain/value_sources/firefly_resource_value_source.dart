import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/value_source.dart';

class FireflyResourceValueSource implements ValueSource {
  const FireflyResourceValueSource({
    required this.resourceKind,
    required this.resourceId,
  });

  static const String type = 'fireflyResource';

  final FireflyResourceKind resourceKind;
  final String resourceId;

  @override
  String resolve(EvaluationContext context) => resourceId;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'type': type,
    'resourceKind': resourceKind.name,
    'resourceId': resourceId,
  };

  factory FireflyResourceValueSource.fromJson(Map<String, dynamic> json) {
    return FireflyResourceValueSource(
      resourceKind: FireflyResourceKind.values.byName(
        json['resourceKind'] as String,
      ),
      resourceId: json['resourceId'] as String,
    );
  }
}
