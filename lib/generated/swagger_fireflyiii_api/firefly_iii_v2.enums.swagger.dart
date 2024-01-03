import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

enum ChartV2PeriodProperty {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('1D')
  value_1d('1D'),
  @JsonValue('1W')
  value_1w('1W'),
  @JsonValue('1M')
  value_1m('1M'),
  @JsonValue('3M')
  value_3m('3M'),
  @JsonValue('6M')
  value_6m('6M'),
  @JsonValue('1Y')
  value_1y('1Y');

  final String? value;

  const ChartV2PeriodProperty(this.value);
}

enum PeriodProperty {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('1D')
  value_1d('1D'),
  @JsonValue('1W')
  value_1w('1W'),
  @JsonValue('1M')
  value_1m('1M'),
  @JsonValue('3M')
  value_3m('3M'),
  @JsonValue('6M')
  value_6m('6M'),
  @JsonValue('1Y')
  value_1y('1Y');

  final String? value;

  const PeriodProperty(this.value);
}

enum PreselectedAccountProperty {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('all')
  all('all'),
  @JsonValue('assets')
  assets('assets'),
  @JsonValue('liabilities')
  liabilities('liabilities');

  final String? value;

  const PreselectedAccountProperty(this.value);
}

enum SubscriptionRepeatProperty {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('weekly')
  weekly('weekly'),
  @JsonValue('monthly')
  monthly('monthly'),
  @JsonValue('quarterly')
  quarterly('quarterly'),
  @JsonValue('half-year')
  halfYear('half-year'),
  @JsonValue('yearly')
  yearly('yearly');

  final String? value;

  const SubscriptionRepeatProperty(this.value);
}

enum AccountRoleProperty {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('defaultAsset')
  defaultasset('defaultAsset'),
  @JsonValue('sharedAsset')
  sharedasset('sharedAsset'),
  @JsonValue('savingAsset')
  savingasset('savingAsset'),
  @JsonValue('ccAsset')
  ccasset('ccAsset'),
  @JsonValue('cashWalletAsset')
  cashwalletasset('cashWalletAsset'),
  @JsonValue('null')
  $null('null');

  final String? value;

  const AccountRoleProperty(this.value);
}

enum AccountTypeProperty {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

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
  mortgage('Mortgage');

  final String? value;

  const AccountTypeProperty(this.value);
}

enum CreditCardTypeProperty {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('monthlyFull')
  monthlyfull('monthlyFull'),
  @JsonValue('null')
  $null('null');

  final String? value;

  const CreditCardTypeProperty(this.value);
}

enum InterestPeriodProperty {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('weekly')
  weekly('weekly'),
  @JsonValue('monthly')
  monthly('monthly'),
  @JsonValue('quarterly')
  quarterly('quarterly'),
  @JsonValue('half-year')
  halfYear('half-year'),
  @JsonValue('yearly')
  yearly('yearly'),
  @JsonValue('null')
  $null('null');

  final String? value;

  const InterestPeriodProperty(this.value);
}

enum LiabilityDirectionProperty {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('credit')
  credit('credit'),
  @JsonValue('debit')
  debit('debit'),
  @JsonValue('null')
  $null('null');

  final String? value;

  const LiabilityDirectionProperty(this.value);
}

enum LiabilityTypeProperty {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('loan')
  loan('loan'),
  @JsonValue('debt')
  debt('debt'),
  @JsonValue('mortgage')
  mortgage('mortgage'),
  @JsonValue('null')
  $null('null');

  final String? value;

  const LiabilityTypeProperty(this.value);
}

enum ShortAccountTypeProperty {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('asset')
  asset('asset'),
  @JsonValue('expense')
  expense('expense'),
  @JsonValue('import')
  $import('import'),
  @JsonValue('revenue')
  revenue('revenue'),
  @JsonValue('cash')
  cash('cash'),
  @JsonValue('liability')
  liability('liability'),
  @JsonValue('liabilities')
  liabilities('liabilities'),
  @JsonValue('initial-balance')
  initialBalance('initial-balance'),
  @JsonValue('reconciliation')
  reconciliation('reconciliation');

  final String? value;

  const ShortAccountTypeProperty(this.value);
}

enum TransactionTypeProperty {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('withdrawal')
  withdrawal('withdrawal'),
  @JsonValue('deposit')
  deposit('deposit'),
  @JsonValue('transfer')
  transfer('transfer'),
  @JsonValue('reconciliation')
  reconciliation('reconciliation'),
  @JsonValue('opening balance')
  openingBalance('opening balance');

  final String? value;

  const TransactionTypeProperty(this.value);
}

enum AccountTypeFilter {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('all')
  all('all'),
  @JsonValue('asset')
  asset('asset'),
  @JsonValue('cash')
  cash('cash'),
  @JsonValue('expense')
  expense('expense'),
  @JsonValue('revenue')
  revenue('revenue'),
  @JsonValue('special')
  special('special'),
  @JsonValue('hidden')
  hidden('hidden'),
  @JsonValue('liability')
  liability('liability'),
  @JsonValue('liabilities')
  liabilities('liabilities'),
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
  mortgage('Mortgage');

  final String? value;

  const AccountTypeFilter(this.value);
}

enum TransactionTypeFilter {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('all')
  all('all'),
  @JsonValue('withdrawal')
  withdrawal('withdrawal'),
  @JsonValue('withdrawals')
  withdrawals('withdrawals'),
  @JsonValue('expense')
  expense('expense'),
  @JsonValue('deposit')
  deposit('deposit'),
  @JsonValue('deposits')
  deposits('deposits'),
  @JsonValue('income')
  income('income'),
  @JsonValue('transfer')
  transfer('transfer'),
  @JsonValue('transfers')
  transfers('transfers'),
  @JsonValue('opening_balance')
  openingBalance('opening_balance'),
  @JsonValue('reconciliation')
  reconciliation('reconciliation'),
  @JsonValue('special')
  special('special'),
  @JsonValue('specials')
  specials('specials'),
  @JsonValue('default')
  $default('default');

  final String? value;

  const TransactionTypeFilter(this.value);
}
