// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurrence_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecurrenceRead _$RecurrenceReadFromJson(Map<String, dynamic> json) =>
    RecurrenceRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          Recurrence.fromJson(json['attributes'] as Map<String, dynamic>),
      links: json['links'],
    );

Map<String, dynamic> _$RecurrenceReadToJson(RecurrenceRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes,
      'links': instance.links,
    };
