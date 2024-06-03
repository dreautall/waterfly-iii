// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_link_v2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageLinkV2 _$PageLinkV2FromJson(Map<String, dynamic> json) => PageLinkV2(
      self: json['self'] as String?,
      first: json['first'] as String?,
      next: json['next'] as String?,
      prev: json['prev'] as String?,
      last: json['last'] as String?,
    );

Map<String, dynamic> _$PageLinkV2ToJson(PageLinkV2 instance) =>
    <String, dynamic>{
      'self': instance.self,
      'first': instance.first,
      'next': instance.next,
      'prev': instance.prev,
      'last': instance.last,
    };
