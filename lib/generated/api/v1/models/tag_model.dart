// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'tag_model.g.dart';

@JsonSerializable()
class TagModel {
  const TagModel({
    required this.tag,
    this.createdAt,
    this.updatedAt,
    this.date,
    this.description,
    this.latitude,
    this.longitude,
    this.zoomLevel,
  });

  factory TagModel.fromJson(Map<String, Object?> json) =>
      _$TagModelFromJson(json);

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  /// The tag
  final String tag;

  /// The date to which the tag is applicable.
  final DateTime? date;
  final String? description;

  /// Latitude of the tag's location, if applicable. Can be used to draw a map.
  final double? latitude;

  /// Latitude of the tag's location, if applicable. Can be used to draw a map.
  final double? longitude;

  /// Zoom level for the map, if drawn. This to set the box right. Unfortunately this is a proprietary value because each map provider has different zoom levels.
  @JsonKey(name: 'zoom_level')
  final int? zoomLevel;

  Map<String, Object?> toJson() => _$TagModelToJson(this);
}
