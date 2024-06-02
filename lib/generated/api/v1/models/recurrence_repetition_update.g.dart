// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurrence_repetition_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecurrenceRepetitionUpdate _$RecurrenceRepetitionUpdateFromJson(
        Map<String, dynamic> json) =>
    RecurrenceRepetitionUpdate(
      type: RecurrenceRepetitionType.fromJson(json['type'] as String),
      moment: json['moment'] as String,
      skip: (json['skip'] as num).toInt(),
      weekend: (json['weekend'] as num).toInt(),
    );

Map<String, dynamic> _$RecurrenceRepetitionUpdateToJson(
        RecurrenceRepetitionUpdate instance) =>
    <String, dynamic>{
      'type': _$RecurrenceRepetitionTypeEnumMap[instance.type]!,
      'moment': instance.moment,
      'skip': instance.skip,
      'weekend': instance.weekend,
    };

const _$RecurrenceRepetitionTypeEnumMap = {
  RecurrenceRepetitionType.daily: 'daily',
  RecurrenceRepetitionType.weekly: 'weekly',
  RecurrenceRepetitionType.ndom: 'ndom',
  RecurrenceRepetitionType.monthly: 'monthly',
  RecurrenceRepetitionType.yearly: 'yearly',
  RecurrenceRepetitionType.$unknown: r'$unknown',
};
