// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_model_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagModelStore _$TagModelStoreFromJson(Map<String, dynamic> json) =>
    TagModelStore(
      tag: json['tag'] as String,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      description: json['description'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      zoomLevel: (json['zoom_level'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TagModelStoreToJson(TagModelStore instance) =>
    <String, dynamic>{
      'tag': instance.tag,
      'date': instance.date?.toIso8601String(),
      'description': instance.description,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'zoom_level': instance.zoomLevel,
    };
