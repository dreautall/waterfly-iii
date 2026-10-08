import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';

class FireflyResourceReference {
  const FireflyResourceReference({required this.kind, required this.id});

  final FireflyResourceKind kind;
  final String id;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'kind': kind.name,
    'id': id,
  };

  factory FireflyResourceReference.fromJson(Map<String, dynamic> json) =>
      FireflyResourceReference(
        kind: FireflyResourceKind.values.byName(json['kind'] as String),
        id: json['id'] as String,
      );

  @override
  bool operator ==(Object other) =>
      other is FireflyResourceReference && other.kind == kind && other.id == id;

  @override
  int get hashCode => Object.hash(kind, id);
}
