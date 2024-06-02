// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurrence_array.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecurrenceArray _$RecurrenceArrayFromJson(Map<String, dynamic> json) =>
    RecurrenceArray(
      data: (json['data'] as List<dynamic>)
          .map((e) => RecurrenceRead.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RecurrenceArrayToJson(RecurrenceArray instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
      'links': instance.links,
    };
