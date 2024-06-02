// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum AccountTypeProperty {
  @JsonValue('Default account')
  defaultAccount('Default account'),
  @JsonValue('Cash account')
  cashAccount('Cash account'),
  @JsonValue('Asset account')
  assetAccount('Asset account'),
  @JsonValue('Expense account')
  expenseAccount('Expense account'),
  @JsonValue('Revenue account')
  revenueAccount('Revenue account'),
  @JsonValue('Initial balance account')
  initialBalanceAccount('Initial balance account'),
  @JsonValue('Beneficiary account')
  beneficiaryAccount('Beneficiary account'),
  @JsonValue('Import account')
  importAccount('Import account'),
  @JsonValue('Reconciliation account')
  reconciliationAccount('Reconciliation account'),
  @JsonValue('Loan')
  loan('Loan'),
  @JsonValue('Debt')
  debt('Debt'),
  @JsonValue('Mortgage')
  mortgage('Mortgage'),
  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const AccountTypeProperty(this.json);

  factory AccountTypeProperty.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;
}
