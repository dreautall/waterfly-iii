import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

enum DataDestroyObject {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

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
  transfers('transfers');

  final String? value;

  const DataDestroyObject(this.value);
}

enum AccountSearchFieldFilter {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('all')
  all('all'),
  @JsonValue('iban')
  iban('iban'),
  @JsonValue('name')
  name('name'),
  @JsonValue('number')
  number('number'),
  @JsonValue('id')
  id('id');

  final String? value;

  const AccountSearchFieldFilter(this.value);
}

enum ConfigValueFilter {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('configuration.is_demo_site')
  configurationIsDemoSite('configuration.is_demo_site'),
  @JsonValue('configuration.permission_update_check')
  configurationPermissionUpdateCheck('configuration.permission_update_check'),
  @JsonValue('configuration.last_update_check')
  configurationLastUpdateCheck('configuration.last_update_check'),
  @JsonValue('configuration.single_user_mode')
  configurationSingleUserMode('configuration.single_user_mode'),
  @JsonValue('firefly.version')
  fireflyVersion('firefly.version'),
  @JsonValue('firefly.default_location')
  fireflyDefaultLocation('firefly.default_location'),
  @JsonValue('firefly.account_to_transaction')
  fireflyAccountToTransaction('firefly.account_to_transaction'),
  @JsonValue('firefly.allowed_opposing_types')
  fireflyAllowedOpposingTypes('firefly.allowed_opposing_types'),
  @JsonValue('firefly.accountRoles')
  fireflyAccountroles('firefly.accountRoles'),
  @JsonValue('firefly.valid_liabilities')
  fireflyValidLiabilities('firefly.valid_liabilities'),
  @JsonValue('firefly.interest_periods')
  fireflyInterestPeriods('firefly.interest_periods'),
  @JsonValue('firefly.enable_external_map')
  fireflyEnableExternalMap('firefly.enable_external_map'),
  @JsonValue('firefly.expected_source_types')
  fireflyExpectedSourceTypes('firefly.expected_source_types'),
  @JsonValue('app.timezone')
  appTimezone('app.timezone'),
  @JsonValue('firefly.bill_periods')
  fireflyBillPeriods('firefly.bill_periods'),
  @JsonValue('firefly.credit_card_types')
  fireflyCreditCardTypes('firefly.credit_card_types'),
  @JsonValue('firefly.languages')
  fireflyLanguages('firefly.languages'),
  @JsonValue('firefly.valid_view_ranges')
  fireflyValidViewRanges('firefly.valid_view_ranges');

  final String? value;

  const ConfigValueFilter(this.value);
}

enum ConfigValueUpdateFilter {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('configuration.is_demo_site')
  configurationIsDemoSite('configuration.is_demo_site'),
  @JsonValue('configuration.permission_update_check')
  configurationPermissionUpdateCheck('configuration.permission_update_check'),
  @JsonValue('configuration.last_update_check')
  configurationLastUpdateCheck('configuration.last_update_check'),
  @JsonValue('configuration.single_user_mode')
  configurationSingleUserMode('configuration.single_user_mode');

  final String? value;

  const ConfigValueUpdateFilter(this.value);
}

enum ExportFileFilter {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('csv')
  csv('csv');

  final String? value;

  const ExportFileFilter(this.value);
}

enum CurrencyUpdatePrimary {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('true')
  $true('true');

  final String? value;

  const CurrencyUpdatePrimary(this.value);
}

enum UserGroupReadRole {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('ro')
  ro('ro'),
  @JsonValue('mng_trx')
  mngTrx('mng_trx'),
  @JsonValue('mng_meta')
  mngMeta('mng_meta'),
  @JsonValue('read_budgets')
  readBudgets('read_budgets'),
  @JsonValue('read_piggies')
  readPiggies('read_piggies'),
  @JsonValue('read_subscriptions')
  readSubscriptions('read_subscriptions'),
  @JsonValue('read_rules')
  readRules('read_rules'),
  @JsonValue('read_recurring')
  readRecurring('read_recurring'),
  @JsonValue('read_webhooks')
  readWebhooks('read_webhooks'),
  @JsonValue('read_currencies')
  readCurrencies('read_currencies'),
  @JsonValue('mng_budgets')
  mngBudgets('mng_budgets'),
  @JsonValue('mng_piggies')
  mngPiggies('mng_piggies'),
  @JsonValue('mng_subscriptions')
  mngSubscriptions('mng_subscriptions'),
  @JsonValue('mng_rules')
  mngRules('mng_rules'),
  @JsonValue('mng_recurring')
  mngRecurring('mng_recurring'),
  @JsonValue('mng_webhooks')
  mngWebhooks('mng_webhooks'),
  @JsonValue('mng_currencies')
  mngCurrencies('mng_currencies'),
  @JsonValue('view_reports')
  viewReports('view_reports'),
  @JsonValue('view_memberships')
  viewMemberships('view_memberships'),
  @JsonValue('full')
  full('full'),
  @JsonValue('owner')
  owner('owner');

  final String? value;

  const UserGroupReadRole(this.value);
}

enum WebhookDelivery {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('JSON')
  json('JSON');

  final String? value;

  const WebhookDelivery(this.value);
}

enum WebhookResponse {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('TRANSACTIONS')
  transactions('TRANSACTIONS'),
  @JsonValue('ACCOUNTS')
  accounts('ACCOUNTS'),
  @JsonValue('BUDGET')
  budget('BUDGET'),
  @JsonValue('RELEVANT')
  relevant('RELEVANT'),
  @JsonValue('NONE')
  none('NONE');

  final String? value;

  const WebhookResponse(this.value);
}

enum WebhookTrigger {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('ANY')
  any('ANY'),
  @JsonValue('STORE_TRANSACTION')
  storeTransaction('STORE_TRANSACTION'),
  @JsonValue('UPDATE_TRANSACTION')
  updateTransaction('UPDATE_TRANSACTION'),
  @JsonValue('DESTROY_TRANSACTION')
  destroyTransaction('DESTROY_TRANSACTION'),
  @JsonValue('STORE_BUDGET')
  storeBudget('STORE_BUDGET'),
  @JsonValue('UPDATE_BUDGET')
  updateBudget('UPDATE_BUDGET'),
  @JsonValue('DESTROY_BUDGET')
  destroyBudget('DESTROY_BUDGET'),
  @JsonValue('STORE_UPDATE_BUDGET_LIMIT')
  storeUpdateBudgetLimit('STORE_UPDATE_BUDGET_LIMIT');

  final String? value;

  const WebhookTrigger(this.value);
}

enum AttachableType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Account')
  account('Account'),
  @JsonValue('Budget')
  budget('Budget'),
  @JsonValue('Bill')
  bill('Bill'),
  @JsonValue('TransactionJournal')
  transactionjournal('TransactionJournal'),
  @JsonValue('PiggyBank')
  piggybank('PiggyBank'),
  @JsonValue('Tag')
  tag('Tag');

  final String? value;

  const AttachableType(this.value);
}

enum AutoBudgetPeriod {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('daily')
  daily('daily'),
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

  const AutoBudgetPeriod(this.value);
}

enum AutoBudgetType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('reset')
  reset('reset'),
  @JsonValue('rollover')
  rollover('rollover'),
  @JsonValue('none')
  none('none'),
  @JsonValue('null')
  $null('null');

  final String? value;

  const AutoBudgetType(this.value);
}

enum BillRepeatFrequency {
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

  const BillRepeatFrequency(this.value);
}

enum RecurrenceRepetitionType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('daily')
  daily('daily'),
  @JsonValue('weekly')
  weekly('weekly'),
  @JsonValue('ndom')
  ndom('ndom'),
  @JsonValue('monthly')
  monthly('monthly'),
  @JsonValue('yearly')
  yearly('yearly');

  final String? value;

  const RecurrenceRepetitionType(this.value);
}

enum RecurrenceTransactionType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('withdrawal')
  withdrawal('withdrawal'),
  @JsonValue('transfer')
  transfer('transfer'),
  @JsonValue('deposit')
  deposit('deposit');

  final String? value;

  const RecurrenceTransactionType(this.value);
}

enum RuleActionKeyword {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('user_action')
  userAction('user_action'),
  @JsonValue('set_category')
  setCategory('set_category'),
  @JsonValue('clear_category')
  clearCategory('clear_category'),
  @JsonValue('set_budget')
  setBudget('set_budget'),
  @JsonValue('clear_budget')
  clearBudget('clear_budget'),
  @JsonValue('add_tag')
  addTag('add_tag'),
  @JsonValue('remove_tag')
  removeTag('remove_tag'),
  @JsonValue('remove_all_tags')
  removeAllTags('remove_all_tags'),
  @JsonValue('set_description')
  setDescription('set_description'),
  @JsonValue('append_description')
  appendDescription('append_description'),
  @JsonValue('prepend_description')
  prependDescription('prepend_description'),
  @JsonValue('set_source_account')
  setSourceAccount('set_source_account'),
  @JsonValue('set_destination_account')
  setDestinationAccount('set_destination_account'),
  @JsonValue('set_notes')
  setNotes('set_notes'),
  @JsonValue('append_notes')
  appendNotes('append_notes'),
  @JsonValue('prepend_notes')
  prependNotes('prepend_notes'),
  @JsonValue('clear_notes')
  clearNotes('clear_notes'),
  @JsonValue('link_to_bill')
  linkToBill('link_to_bill'),
  @JsonValue('convert_withdrawal')
  convertWithdrawal('convert_withdrawal'),
  @JsonValue('convert_deposit')
  convertDeposit('convert_deposit'),
  @JsonValue('convert_transfer')
  convertTransfer('convert_transfer'),
  @JsonValue('delete_transaction')
  deleteTransaction('delete_transaction');

  final String? value;

  const RuleActionKeyword(this.value);
}

enum RuleTriggerKeyword {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('from_account_starts')
  fromAccountStarts('from_account_starts'),
  @JsonValue('from_account_ends')
  fromAccountEnds('from_account_ends'),
  @JsonValue('from_account_is')
  fromAccountIs('from_account_is'),
  @JsonValue('from_account_contains')
  fromAccountContains('from_account_contains'),
  @JsonValue('to_account_starts')
  toAccountStarts('to_account_starts'),
  @JsonValue('to_account_ends')
  toAccountEnds('to_account_ends'),
  @JsonValue('to_account_is')
  toAccountIs('to_account_is'),
  @JsonValue('to_account_contains')
  toAccountContains('to_account_contains'),
  @JsonValue('amount_less')
  amountLess('amount_less'),
  @JsonValue('amount_exactly')
  amountExactly('amount_exactly'),
  @JsonValue('amount_more')
  amountMore('amount_more'),
  @JsonValue('description_starts')
  descriptionStarts('description_starts'),
  @JsonValue('description_ends')
  descriptionEnds('description_ends'),
  @JsonValue('description_contains')
  descriptionContains('description_contains'),
  @JsonValue('description_is')
  descriptionIs('description_is'),
  @JsonValue('transaction_type')
  transactionType('transaction_type'),
  @JsonValue('category_is')
  categoryIs('category_is'),
  @JsonValue('budget_is')
  budgetIs('budget_is'),
  @JsonValue('tag_is')
  tagIs('tag_is'),
  @JsonValue('currency_is')
  currencyIs('currency_is'),
  @JsonValue('has_attachments')
  hasAttachments('has_attachments'),
  @JsonValue('has_no_category')
  hasNoCategory('has_no_category'),
  @JsonValue('has_any_category')
  hasAnyCategory('has_any_category'),
  @JsonValue('has_no_budget')
  hasNoBudget('has_no_budget'),
  @JsonValue('has_any_budget')
  hasAnyBudget('has_any_budget'),
  @JsonValue('has_no_tag')
  hasNoTag('has_no_tag'),
  @JsonValue('has_any_tag')
  hasAnyTag('has_any_tag'),
  @JsonValue('notes_contains')
  notesContains('notes_contains'),
  @JsonValue('notes_start')
  notesStart('notes_start'),
  @JsonValue('notes_end')
  notesEnd('notes_end'),
  @JsonValue('notes_are')
  notesAre('notes_are'),
  @JsonValue('no_notes')
  noNotes('no_notes'),
  @JsonValue('any_notes')
  anyNotes('any_notes'),
  @JsonValue('source_account_is')
  sourceAccountIs('source_account_is'),
  @JsonValue('destination_account_is')
  destinationAccountIs('destination_account_is'),
  @JsonValue('source_account_starts')
  sourceAccountStarts('source_account_starts');

  final String? value;

  const RuleTriggerKeyword(this.value);
}

enum RuleTriggerType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('store-journal')
  storeJournal('store-journal'),
  @JsonValue('update-journal')
  updateJournal('update-journal');

  final String? value;

  const RuleTriggerType(this.value);
}

enum UserBlockedCodeProperty {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('email_changed')
  emailChanged('email_changed'),
  @JsonValue('null')
  $null('null');

  final String? value;

  const UserBlockedCodeProperty(this.value);
}

enum UserRoleProperty {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('owner')
  owner('owner'),
  @JsonValue('demo')
  demo('demo'),
  @JsonValue('null')
  $null('null');

  final String? value;

  const UserRoleProperty(this.value);
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

enum ChartDatasetPeriodProperty {
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
  @JsonValue('1Y')
  value_1y('1Y'),
  @JsonValue('custom')
  custom('custom');

  final String? value;

  const ChartDatasetPeriodProperty(this.value);
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

enum V1ChartAccountOverviewGetPeriod {
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

  const V1ChartAccountOverviewGetPeriod(this.value);
}

enum V1ChartAccountOverviewGetPreselected {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('empty')
  empty('empty'),
  @JsonValue('all')
  all('all'),
  @JsonValue('assets')
  assets('assets'),
  @JsonValue('liabilities')
  liabilities('liabilities');

  final String? value;

  const V1ChartAccountOverviewGetPreselected(this.value);
}

enum V1ChartBalanceBalanceGetPeriod {
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

  const V1ChartBalanceBalanceGetPeriod(this.value);
}

enum V1ChartBalanceBalanceGetPreselected {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('empty')
  empty('empty'),
  @JsonValue('all')
  all('all'),
  @JsonValue('assets')
  assets('assets'),
  @JsonValue('liabilities')
  liabilities('liabilities');

  final String? value;

  const V1ChartBalanceBalanceGetPreselected(this.value);
}
