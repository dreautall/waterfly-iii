// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'page_link_v2.g.dart';

@JsonSerializable()
class PageLinkV2 {
  const PageLinkV2({
    required this.self,
    required this.first,
    required this.next,
    required this.prev,
    required this.last,
  });

  factory PageLinkV2.fromJson(Map<String, Object?> json) =>
      _$PageLinkV2FromJson(json);

  final String self;
  final String first;
  final String? next;
  final String? prev;
  final String last;

  Map<String, Object?> toJson() => _$PageLinkV2ToJson(this);
}
