// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

/// Is only mandatory when the type is asset.
@JsonEnum()
enum AccountRoleProperty {
  @JsonValue('defaultAsset')
  defaultAsset('defaultAsset'),
  @JsonValue('sharedAsset')
  sharedAsset('sharedAsset'),
  @JsonValue('savingAsset')
  savingAsset('savingAsset'),
  @JsonValue('ccAsset')
  ccAsset('ccAsset'),
  @JsonValue('cashWalletAsset')
  cashWalletAsset('cashWalletAsset'),

  /// The name has been replaced because it contains a keyword. Original name: `null`.
  @JsonValue('null')
  valueNull('null'),

  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const AccountRoleProperty(this.json);

  factory AccountRoleProperty.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;
}
