import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'firefly_iii.models.swagger.dart';

//Put your overriden models here (ObjectLink)
@JsonSerializable(explicitToJson: true)
class ObjectLink {
  ObjectLink({
    this.self,
  });

  factory ObjectLink.fromJson(Map<String, dynamic> json) =>
      _$ObjectLinkFromJson(json);

  @JsonKey(name: 'self')
  final String? self;
  static const fromJsonFactory = _$ObjectLinkFromJson;
  static const toJsonFactory = _$ObjectLinkToJson;
  Map<String, dynamic> toJson() => _$ObjectLinkToJson(this);

  @override
  String toString() => jsonEncode(this);
}

extension $ObjectLinkExtension on ObjectLink {
  ObjectLink copyWith({String? self}) {
    return ObjectLink(self: self ?? this.self);
  }

  ObjectLink copyWithWrapped({Wrapped<String?>? self}) {
    return ObjectLink(self: (self != null ? self.value : this.self));
  }
}

ObjectLink _$ObjectLinkFromJson(Map<String, dynamic> json) => ObjectLink(
      self: json['self'] as String?,
    );

Map<String, dynamic> _$ObjectLinkToJson(ObjectLink instance) =>
    <String, dynamic>{
      'self': instance.self,
    };
