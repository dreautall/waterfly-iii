// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'page_link.g.dart';

@JsonSerializable()
class PageLink {
  const PageLink({
    required this.self,
    required this.first,
    required this.next,
    required this.prev,
    required this.last,
  });
  
  factory PageLink.fromJson(Map<String, Object?> json) => _$PageLinkFromJson(json);
  
  final String self;
  final String first;
  final String? next;
  final String? prev;
  final String last;

  Map<String, Object?> toJson() => _$PageLinkToJson(this);
}
