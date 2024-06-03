// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum DataDestroyObject {
  @JsonValue('not_assets_liabilities')
  notAssetsLiabilities('not_assets_liabilities'),
  @JsonValue('budgets')
  budgets('budgets'),
  @JsonValue('bills')
  bills('bills'),
  @JsonValue('piggy_banks')
  piggyBanks('piggy_banks'),
  @JsonValue('rules')
  rules('rules'),
  @JsonValue('recurring')
  recurring('recurring'),
  @JsonValue('categories')
  categories('categories'),
  @JsonValue('tags')
  tags('tags'),
  @JsonValue('object_groups')
  objectGroups('object_groups'),
  @JsonValue('accounts')
  accounts('accounts'),
  @JsonValue('asset_accounts')
  assetAccounts('asset_accounts'),
  @JsonValue('expense_accounts')
  expenseAccounts('expense_accounts'),
  @JsonValue('revenue_accounts')
  revenueAccounts('revenue_accounts'),
  @JsonValue('liabilities')
  liabilities('liabilities'),
  @JsonValue('transactions')
  transactions('transactions'),
  @JsonValue('withdrawals')
  withdrawals('withdrawals'),
  @JsonValue('deposits')
  deposits('deposits'),
  @JsonValue('transfers')
  transfers('transfers'),

  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const DataDestroyObject(this.json);

  factory DataDestroyObject.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;
}
