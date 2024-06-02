// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurrence_repetition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecurrenceRepetition _$RecurrenceRepetitionFromJson(
        Map<String, dynamic> json) =>
    RecurrenceRepetition(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      type: RecurrenceRepetitionType.fromJson(json['type'] as String),
      moment: json['moment'] as String,
      skip: (json['skip'] as num).toInt(),
      weekend: (json['weekend'] as num).toInt(),
      description: json['description'] as String,
      occurrences: (json['occurrences'] as List<dynamic>)
          .map((e) => DateTime.parse(e as String))
          .toList(),
    );

Map<String, dynamic> _$RecurrenceRepetitionToJson(
        RecurrenceRepetition instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'type': _$RecurrenceRepetitionTypeEnumMap[instance.type]!,
      'moment': instance.moment,
      'skip': instance.skip,
      'weekend': instance.weekend,
      'description': instance.description,
      'occurrences':
          instance.occurrences.map((e) => e.toIso8601String()).toList(),
    };

const _$RecurrenceRepetitionTypeEnumMap = {
  RecurrenceRepetitionType.daily: 'daily',
  RecurrenceRepetitionType.weekly: 'weekly',
  RecurrenceRepetitionType.ndom: 'ndom',
  RecurrenceRepetitionType.monthly: 'monthly',
  RecurrenceRepetitionType.yearly: 'yearly',
  RecurrenceRepetitionType.$unknown: r'$unknown',
};
