// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageLink _$PageLinkFromJson(Map<String, dynamic> json) => PageLink(
      self: json['self'] as String?,
      first: json['first'] as String?,
      next: json['next'] as String?,
      prev: json['prev'] as String?,
      last: json['last'] as String?,
    );

Map<String, dynamic> _$PageLinkToJson(PageLink instance) => <String, dynamic>{
      'self': instance.self,
      'first': instance.first,
      'next': instance.next,
      'prev': instance.prev,
      'last': instance.last,
    };
