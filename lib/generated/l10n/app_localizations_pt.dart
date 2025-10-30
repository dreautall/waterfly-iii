// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class SPt extends S {
  SPt([String locale = 'pt']) : super(locale);

  @override
  String get accountRoleAssetCashWallet => 'Carteira de dinheiro';

  @override
  String get accountRoleAssetCC => 'Cartão de crédito';

  @override
  String get accountRoleAssetDefault => 'Conta de ativos padrão';

  @override
  String get accountRoleAssetSavings => 'Conta poupança';

  @override
  String get accountRoleAssetShared => 'Conta de ativos compartilhados';

  @override
  String get accountsLabelAsset => 'Contas de ativos';

  @override
  String get accountsLabelExpense => 'Contas de despesas';

  @override
  String get accountsLabelLiabilities => 'Passivos';

  @override
  String get accountsLabelRevenue => 'Conta de receitas';

  @override
  String accountsLiabilitiesInterest(double interest, String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'semana',
      'monthly': 'mês',
      'quarterly': 'trimestre',
      'halfyear': 'semestre',
      'yearly': 'ano',
      'other': 'desconhecido',
    });
    return '$interest% de interesse por $_temp0';
  }

  @override
  String billsAmountAndFrequency(
    String minValue,
    String maxvalue,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'weekly',
      'monthly': 'monthly',
      'quarterly': 'quarterly',
      'halfyear': 'half-yearly',
      'yearly': 'yearly',
      'other': 'unknown',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', skips over $skip',
      zero: '',
    );
    return 'Subscription matches transactions between $minValue and $maxvalue. Repeats $_temp0$_temp1.';
  }

  @override
  String get billsChangeLayoutTooltip => 'Alterar layout';

  @override
  String get billsChangeSortOrderTooltip => 'Alterar ordem de classificação';

  @override
  String get billsErrorLoading => 'Error loading subscriptions.';

  @override
  String billsExactAmountAndFrequency(
    String value,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'weekly',
      'monthly': 'monthly',
      'quarterly': 'quarterly',
      'halfyear': 'half-yearly',
      'yearly': 'yearly',
      'other': 'unknown',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', skips over $skip',
      zero: '',
    );
    return 'Subscription matches transactions of $value. Repeats $_temp0$_temp1.';
  }

  @override
  String billsExpectedOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Expected $dateString';
  }

  @override
  String billsFrequency(String frequency) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Weekly',
      'monthly': 'Monthly',
      'quarterly': 'Quarterly',
      'halfyear': 'Half-yearly',
      'yearly': 'Yearly',
      'other': 'Unknown',
    });
    return '$_temp0';
  }

  @override
  String billsFrequencySkip(String frequency, num skip) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Weekly',
      'monthly': 'Monthly',
      'quarterly': 'Quarterly',
      'halfyear': 'Half-yearly',
      'yearly': 'Yearly',
      'other': 'Unknown',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', skips over $skip',
      zero: '',
    );
    return '$_temp0$_temp1';
  }

  @override
  String get billsInactive => 'Inactive';

  @override
  String get billsIsActive => 'Subscription is active';

  @override
  String get billsLayoutGroupSubtitle =>
      'Subscriptions displayed in their assigned groups.';

  @override
  String get billsLayoutGroupTitle => 'Group';

  @override
  String get billsLayoutListSubtitle =>
      'Subscriptions displayed in a list sorted by certain criteria.';

  @override
  String get billsLayoutListTitle => 'List';

  @override
  String get billsListEmpty => 'The list is currently empty.';

  @override
  String get billsNextExpectedMatch => 'Next expected match';

  @override
  String get billsNotActive => 'Subscription is inactive';

  @override
  String get billsNotExpected => 'Not expected this period';

  @override
  String get billsNoTransactions => 'No transactions found.';

  @override
  String billsPaidOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Paid $dateString';
  }

  @override
  String get billsSortAlphabetical => 'Alphabetical';

  @override
  String get billsSortByTimePeriod => 'By time period';

  @override
  String get billsSortFrequency => 'Frequency';

  @override
  String get billsSortName => 'Name';

  @override
  String get billsUngrouped => 'Ungrouped';

  @override
  String get billsSettingsShowOnlyActive => 'Show only active';

  @override
  String get billsSettingsShowOnlyActiveDesc =>
      'Shows only active subscriptions.';

  @override
  String get billsSettingsShowOnlyExpected => 'Show only expected';

  @override
  String get billsSettingsShowOnlyExpectedDesc =>
      'Shows only those subscriptions that are expected (or paid) this month.';

  @override
  String get categoryDeleteConfirm =>
      'Are you sure you want to delete this category? The transactions will not be deleted, but will not have a category anymore.';

  @override
  String get categoryErrorLoading => 'Error loading categories.';

  @override
  String get categoryFormLabelIncludeInSum => 'Include in monthly sum';

  @override
  String get categoryFormLabelName => 'Category Name';

  @override
  String get categoryMonthNext => 'Next Month';

  @override
  String get categoryMonthPrev => 'Previous Month';

  @override
  String get categorySumExcluded => 'excluded';

  @override
  String get categoryTitleAdd => 'Add Category';

  @override
  String get categoryTitleDelete => 'Delete Category';

  @override
  String get categoryTitleEdit => 'Edit Category';

  @override
  String get catNone => '<no category>';

  @override
  String get catOther => 'Other';

  @override
  String errorAPIInvalidResponse(String message) {
    return 'Invalid Response from API: $message';
  }

  @override
  String get errorAPIUnavailable => 'API unavailable';

  @override
  String get errorFieldRequired => 'This field is required.';

  @override
  String get errorInvalidURL => 'Invalid URL';

  @override
  String errorMinAPIVersion(String requiredVersion) {
    return 'Minimum Firefly API Version v$requiredVersion required. Please upgrade.';
  }

  @override
  String errorStatusCode(int code) {
    return 'Status Code: $code';
  }

  @override
  String get errorUnknown => 'Unknown error.';

  @override
  String get formButtonHelp => 'Help';

  @override
  String get formButtonLogin => 'Login';

  @override
  String get formButtonLogout => 'Logout';

  @override
  String get formButtonRemove => 'Remove';

  @override
  String get formButtonResetLogin => 'Reset login';

  @override
  String get formButtonTransactionAdd => 'Add Transaction';

  @override
  String get formButtonTryAgain => 'Try again';

  @override
  String get generalAccount => 'Account';

  @override
  String get generalAssets => 'Assets';

  @override
  String get generalBalance => 'Balance';

  @override
  String generalBalanceOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Balance on $dateString';
  }

  @override
  String get generalBill => 'Subscription';

  @override
  String get generalBudget => 'Budget';

  @override
  String get generalCategory => 'Category';

  @override
  String get generalCurrency => 'Currency';

  @override
  String get generalDateRangeCurrentMonth => 'Current Month';

  @override
  String get generalDateRangeLast30Days => 'Last 30 days';

  @override
  String get generalDateRangeCurrentYear => 'Current Year';

  @override
  String get generalDateRangeLastYear => 'Last year';

  @override
  String get generalDateRangeAll => 'All';

  @override
  String get generalDefault => 'default';

  @override
  String get generalDestinationAccount => 'Destination Account';

  @override
  String get generalDismiss => 'Dismiss';

  @override
  String get generalEarned => 'Earned';

  @override
  String get generalError => 'Error';

  @override
  String get generalExpenses => 'Expenses';

  @override
  String get generalIncome => 'Income';

  @override
  String get generalLiabilities => 'Passivos';

  @override
  String get generalMultiple => 'multiple';

  @override
  String get generalNever => 'never';

  @override
  String get generalReconcile => 'Reconciled';

  @override
  String get generalReset => 'Reset';

  @override
  String get generalSourceAccount => 'Source Account';

  @override
  String get generalSpent => 'Spent';

  @override
  String get generalSum => 'Sum';

  @override
  String get generalTarget => 'Target';

  @override
  String get generalUnknown => 'Unknown';

  @override
  String homeMainBillsInterval(String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'weekly',
      'monthly': 'monthly',
      'quarterly': 'quarterly',
      'halfyear': 'half-year',
      'yearly': 'yearly',
      'other': 'unknown',
    });
    return ' ($_temp0)';
  }

  @override
  String get homeMainBillsTitle => 'Subscriptions for the next week';

  @override
  String homeMainBudgetInterval(DateTime from, DateTime to, String period) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return ' ($fromString to $toString, $period)';
  }

  @override
  String homeMainBudgetIntervalSingle(DateTime from, DateTime to) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return ' ($fromString to $toString)';
  }

  @override
  String homeMainBudgetSum(String current, String status, String available) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'over': 'over',
      'other': 'left from',
    });
    return '$current $_temp0 $available';
  }

  @override
  String get homeMainBudgetTitle => 'Budgets for current month';

  @override
  String get homeMainChartAccountsTitle => 'Account Summary';

  @override
  String get homeMainChartCategoriesTitle =>
      'Category Summary for current month';

  @override
  String get homeMainChartDailyAvg => '7 days average';

  @override
  String get homeMainChartDailyTitle => 'Daily Summary';

  @override
  String get homeMainChartNetEarningsTitle => 'Net Earnings';

  @override
  String get homeMainChartNetWorthTitle => 'Net Worth';

  @override
  String get homeMainChartTagsTitle => 'Tag Summary for current month';

  @override
  String get homePiggyAdjustDialogTitle => 'Save/Spend Money';

  @override
  String homePiggyDateStart(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Start date: $dateString';
  }

  @override
  String homePiggyDateTarget(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Target date: $dateString';
  }

  @override
  String get homeMainDialogSettingsTitle => 'Customize Dashboard';

  @override
  String homePiggyLinked(String account) {
    return 'Linked to $account';
  }

  @override
  String get homePiggyNoAccounts => 'No piggy banks set up.';

  @override
  String get homePiggyNoAccountsSubtitle => 'Create some in the webinterface!';

  @override
  String homePiggyRemaining(String amount) {
    return 'Left to save: $amount';
  }

  @override
  String homePiggySaved(String amount) {
    return 'Saved so far: $amount';
  }

  @override
  String get homePiggySavedMultiple => 'Saved so far:';

  @override
  String homePiggyTarget(String amount) {
    return 'Target amount: $amount';
  }

  @override
  String get homePiggyAccountStatus => 'Account Status';

  @override
  String get homePiggyAvailableAmounts => 'Available Amounts';

  @override
  String homePiggyAvailable(String amount) {
    return 'Available: $amount';
  }

  @override
  String homePiggyInPiggyBanks(String amount) {
    return 'In piggy banks: $amount';
  }

  @override
  String get homeTabLabelBalance => 'Balance Sheet';

  @override
  String get homeTabLabelMain => 'Main';

  @override
  String get homeTabLabelPiggybanks => 'Piggy Banks';

  @override
  String get homeTabLabelTransactions => 'Transactions';

  @override
  String get homeTransactionsActionFilter => 'Filter List';

  @override
  String get homeTransactionsDialogFilterAccountsAll => '<All Accounts>';

  @override
  String get homeTransactionsDialogFilterBillsAll => '<All Subscriptions>';

  @override
  String get homeTransactionsDialogFilterBillUnset => '<No Subscription set>';

  @override
  String get homeTransactionsDialogFilterBudgetsAll => '<All Budgets>';

  @override
  String get homeTransactionsDialogFilterBudgetUnset => '<No Budget set>';

  @override
  String get homeTransactionsDialogFilterCategoriesAll => '<All Categories>';

  @override
  String get homeTransactionsDialogFilterCategoryUnset => '<No Category set>';

  @override
  String get homeTransactionsDialogFilterCurrenciesAll => '<All Currencies>';

  @override
  String get homeTransactionsDialogFilterDateRange => 'Date Range';

  @override
  String get homeTransactionsDialogFilterFutureTransactions =>
      'Show future transactions';

  @override
  String get homeTransactionsDialogFilterSearch => 'Search Term';

  @override
  String get homeTransactionsDialogFilterTitle => 'Select filters';

  @override
  String get homeTransactionsEmpty => 'No transactions found.';

  @override
  String homeTransactionsMultipleCategories(int num) {
    return '$num categories';
  }

  @override
  String get homeTransactionsSettingsShowTags =>
      'Show tags in transaction list';

  @override
  String get liabilityDirectionCredit => 'I am owed this debt';

  @override
  String get liabilityDirectionDebit => 'I owe this debt';

  @override
  String get liabilityTypeDebt => 'Debt';

  @override
  String get liabilityTypeLoan => 'Loan';

  @override
  String get liabilityTypeMortgage => 'Mortgage';

  @override
  String get loginAbout =>
      'To use Waterfly III productively you need your own server with a Firefly III instance or the Firefly III add-on for Home Assistant.\n\nPlease enter the full URL as well as a personal access token (Settings -> Profile -> OAuth -> Personal Access Token) below.';

  @override
  String get loginFormLabelAPIKey => 'Valid API Key';

  @override
  String get loginFormLabelHost => 'Host URL';

  @override
  String get loginWelcome => 'Welcome to Waterfly III';

  @override
  String get logoutConfirmation => 'Are you sure you want to log out?';

  @override
  String get navigationAccounts => 'Accounts';

  @override
  String get navigationBills => 'Subscriptions';

  @override
  String get navigationCategories => 'Categories';

  @override
  String get navigationMain => 'Main Dashboard';

  @override
  String get generalSettings => 'Settings';

  @override
  String get no => 'No';

  @override
  String numPercent(double num) {
    final intl.NumberFormat numNumberFormat = intl
        .NumberFormat.decimalPercentPattern(
      locale: localeName,
      decimalDigits: 0,
    );
    final String numString = numNumberFormat.format(num);

    return '$numString';
  }

  @override
  String numPercentOf(double perc, String of) {
    final intl.NumberFormat percNumberFormat = intl
        .NumberFormat.decimalPercentPattern(
      locale: localeName,
      decimalDigits: 0,
    );
    final String percString = percNumberFormat.format(perc);

    return '$percString of $of';
  }

  @override
  String get settingsDialogDebugInfo =>
      'You can enable & send debug logs here. These have a bad impact on performance, so please don\'t enable them unless you\'re advised to do so. Disabling logging will delete the stored log.';

  @override
  String get settingsDialogDebugMailCreate => 'Create Mail';

  @override
  String get settingsDialogDebugMailDisclaimer =>
      'WARNING: A mail draft will open with the log file attached (in text format). The logs might contain sensitive information, such as the host name of your Firefly instance (though I try to avoid logging of any secrets, such as the api key). Please read through the log carefully and censor out any information you don\'t want to share and/or is not relevant to the problem you want to report.\n\nPlease do not send in logs without prior agreement via mail/GitHub to do so. I will delete any logs sent without context for privacy reasons. Never upload the log uncensored to GitHub or elsewhere.';

  @override
  String get settingsDialogDebugSendButton => 'Send Logs via Mail';

  @override
  String get settingsDialogDebugTitle => 'Debug Logs';

  @override
  String get settingsDialogLanguageTitle => 'Select Language';

  @override
  String get settingsDialogThemeTitle => 'Select Theme';

  @override
  String get settingsFAQ => 'FAQ';

  @override
  String get settingsFAQHelp => 'Opens in Browser. Only available in English.';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLockscreen => 'Lockscreen';

  @override
  String get settingsLockscreenHelp => 'Require authenticiation on app startup';

  @override
  String get settingsLockscreenInitial =>
      'Please authenticate to enable the lock screen.';

  @override
  String get settingsNLAppAccount => 'Default Account';

  @override
  String get settingsNLAppAccountDynamic => '<Dynamic>';

  @override
  String get settingsNLAppAdd => 'Add App';

  @override
  String get settingsNLAppAddHelp =>
      'Click to add an app to listen to. Only eligible apps will show up in the list.';

  @override
  String get settingsNLAppAddInfo =>
      'Make some transactions where you receive phone notifications to add apps to this list. If the app still doesn\'t show up, please report it to app@vogt.pw.';

  @override
  String get settingsNLAutoAdd => 'Create transaction without interaction';

  @override
  String get settingsNLDescription =>
      'This service allows you to fetch transaction details from incoming push notifications. Additionally, you can select a default account which the transaction should be assigned to - if no value is set, it tries to extract an account from the notification.';

  @override
  String get settingsNLEmptyNote => 'Keep note field empty';

  @override
  String get settingsNLPermissionGrant => 'Tap to grant permission.';

  @override
  String get settingsNLPermissionNotGranted => 'Permission not granted.';

  @override
  String get settingsNLPermissionRemove => 'Remove permission?';

  @override
  String get settingsNLPermissionRemoveHelp =>
      'To disable this service, click on the app and remove the permissions in the next screen.';

  @override
  String get settingsNLPrefillTXTitle =>
      'Prefill transaction title with notification title';

  @override
  String get settingsNLServiceChecking => 'Checking status…';

  @override
  String settingsNLServiceCheckingError(String error) {
    return 'Error checking status: $error';
  }

  @override
  String get settingsNLServiceRunning => 'Service is running.';

  @override
  String get settingsNLServiceStatus => 'Service Status';

  @override
  String get settingsNLServiceStopped => 'Service is stopped.';

  @override
  String get settingsNotificationListener => 'Notification Listener Service';

  @override
  String get settingsTheme => 'App Theme';

  @override
  String get settingsThemeDynamicColors => 'Dynamic Colors';

  @override
  String settingsThemeValue(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'dark': 'Dark Mode',
      'light': 'Light Mode',
      'other': 'System Default',
    });
    return '$_temp0';
  }

  @override
  String get settingsUseServerTimezone => 'Use server timezone';

  @override
  String get settingsUseServerTimezoneHelp =>
      'Show all times in the server timezone. This mimics the behavior of the webinterface.';

  @override
  String get settingsVersion => 'App Version';

  @override
  String get settingsVersionChecking => 'checking…';

  @override
  String get transactionAttachments => 'Attachments';

  @override
  String get transactionDeleteConfirm =>
      'Are you sure you want to delete this transaction?';

  @override
  String get transactionDialogAttachmentsDelete => 'Delete Attachment';

  @override
  String get transactionDialogAttachmentsDeleteConfirm =>
      'Are you sure you want to delete this attachment?';

  @override
  String get transactionDialogAttachmentsErrorDownload =>
      'Could not download file.';

  @override
  String transactionDialogAttachmentsErrorOpen(String error) {
    return 'Could not open file: $error';
  }

  @override
  String transactionDialogAttachmentsErrorUpload(String error) {
    return 'Could not upload file: $error';
  }

  @override
  String get transactionDialogAttachmentsTitle => 'Attachments';

  @override
  String get transactionDialogBillNoBill => 'No subscription';

  @override
  String get transactionDialogBillTitle => 'Link to Subscription';

  @override
  String get transactionDialogCurrencyTitle => 'Select currency';

  @override
  String get transactionDialogPiggyNoPiggy => 'No Piggy Bank';

  @override
  String get transactionDialogPiggyTitle => 'Link to Piggy Bank';

  @override
  String get transactionDialogTagsAdd => 'Add Tag';

  @override
  String get transactionDialogTagsHint => 'Search/Add Tag';

  @override
  String get transactionDialogTagsTitle => 'Select tags';

  @override
  String get transactionDuplicate => 'Duplicate';

  @override
  String get transactionErrorInvalidAccount => 'Invalid Account';

  @override
  String get transactionErrorInvalidBudget => 'Invalid Budget';

  @override
  String get transactionErrorNoAccounts => 'Please fill in the accounts first.';

  @override
  String get transactionErrorNoAssetAccount =>
      'Please select an asset account.';

  @override
  String get transactionErrorTitle => 'Please provide a title.';

  @override
  String get transactionFormLabelAccountDestination => 'Destination account';

  @override
  String get transactionFormLabelAccountForeign => 'Foreign account';

  @override
  String get transactionFormLabelAccountOwn => 'Own account';

  @override
  String get transactionFormLabelAccountSource => 'Source account';

  @override
  String get transactionFormLabelNotes => 'Notes';

  @override
  String get transactionFormLabelTags => 'Tags';

  @override
  String get transactionFormLabelTitle => 'Transaction Title';

  @override
  String get transactionSplitAdd => 'Add split transaction';

  @override
  String get transactionSplitChangeCurrency => 'Change Split Currency';

  @override
  String get transactionSplitChangeDestinationAccount =>
      'Change Split Destination Account';

  @override
  String get transactionSplitChangeSourceAccount =>
      'Change Split Source Account';

  @override
  String get transactionSplitChangeTarget => 'Change Split Target Account';

  @override
  String get transactionSplitDelete => 'Delete split';

  @override
  String get transactionTitleAdd => 'Add Transaction';

  @override
  String get transactionTitleDelete => 'Delete Transaction';

  @override
  String get transactionTitleEdit => 'Edit Transaction';

  @override
  String get transactionTypeDeposit => 'Deposit';

  @override
  String get transactionTypeTransfer => 'Transfer';

  @override
  String get transactionTypeWithdrawal => 'Withdrawal';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class SPtBr extends SPt {
  SPtBr() : super('pt_BR');

  @override
  String get accountRoleAssetCashWallet => 'Carteira de Dinheiro';

  @override
  String get accountRoleAssetCC => 'Cartão de crédito';

  @override
  String get accountRoleAssetDefault => 'Conta de ativos padrão';

  @override
  String get accountRoleAssetSavings => 'Conta poupança';

  @override
  String get accountRoleAssetShared => 'Contas de ativos compartilhadas';

  @override
  String get accountsLabelAsset => 'Contas de Ativos';

  @override
  String get accountsLabelExpense => 'Contas de Despesas';

  @override
  String get accountsLabelLiabilities => 'Passivos';

  @override
  String get accountsLabelRevenue => 'Contas de Receita';

  @override
  String accountsLiabilitiesInterest(double interest, String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'semanais',
      'monthly': 'ao mês',
      'quarterly': 'por trimestre',
      'halfyear': 'por semestre',
      'yearly': 'ao ano',
      'other': 'desconhecido',
    });
    return '$interest% de juros $_temp0';
  }

  @override
  String billsAmountAndFrequency(
    String minValue,
    String maxvalue,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'semanalmente',
      'monthly': 'mensalmente',
      'quarterly': 'trimestralmente',
      'halfyear': 'semestralmente',
      'yearly': 'anualmente',
      'other': 'desconhecido',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', pula $skip',
      zero: '',
    );
    return 'A assinatura corresponde a transações entre $minValue e $maxvalue. Repete $_temp0$_temp1.';
  }

  @override
  String get billsChangeLayoutTooltip => 'Alterar layout';

  @override
  String get billsChangeSortOrderTooltip => 'Alterar ordem de classificação';

  @override
  String get billsErrorLoading => 'Erro ao carregar assinaturas.';

  @override
  String billsExactAmountAndFrequency(
    String value,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'semanalmente',
      'monthly': 'mensalmente',
      'quarterly': 'trimestralmente',
      'halfyear': 'semestralmente',
      'yearly': 'anualmente',
      'other': 'desconhecido',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', pula $skip',
      zero: '',
    );
    return 'A assinatura corresponde a transações de $value. Repete $_temp0$_temp1.';
  }

  @override
  String billsExpectedOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Vencimento em$dateString';
  }

  @override
  String billsFrequency(String frequency) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Semanal',
      'monthly': 'Mensal',
      'quarterly': 'Trimestral',
      'halfyear': 'Semestral',
      'yearly': 'Anual',
      'other': 'Desconhecida',
    });
    return '$_temp0';
  }

  @override
  String billsFrequencySkip(String frequency, num skip) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Semanal',
      'monthly': 'Mensal',
      'quarterly': 'Trimestral',
      'halfyear': 'Semestral',
      'yearly': 'Anual',
      'other': 'Desconhecida',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', pula $skip',
      zero: '',
    );
    return '$_temp0$_temp1';
  }

  @override
  String get billsInactive => 'Inativo';

  @override
  String get billsIsActive => 'A assinatura está ativa';

  @override
  String get billsLayoutGroupSubtitle =>
      'Assinaturas exibidas em seus grupos designados.';

  @override
  String get billsLayoutGroupTitle => 'Grupo';

  @override
  String get billsLayoutListSubtitle =>
      'Assinaturas exibidas em uma lista organizada por certos critérios.';

  @override
  String get billsLayoutListTitle => 'Lista';

  @override
  String get billsListEmpty => 'A lista está vazia atualmente.';

  @override
  String get billsNextExpectedMatch => 'Próxima combinação parecida';

  @override
  String get billsNotActive => 'A assinatura está inativa';

  @override
  String get billsNotExpected => 'Período não esperado';

  @override
  String get billsNoTransactions => 'Nenhuma transação encontrada.';

  @override
  String billsPaidOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Pago em $dateString';
  }

  @override
  String get billsSortAlphabetical => 'Em Ordem Alfabética';

  @override
  String get billsSortByTimePeriod => 'Por período de tempo';

  @override
  String get billsSortFrequency => 'Frequência';

  @override
  String get billsSortName => 'Nome';

  @override
  String get billsUngrouped => 'Sem Grupo';

  @override
  String get billsSettingsShowOnlyActive => 'Mostrar apenas ativas';

  @override
  String get billsSettingsShowOnlyActiveDesc =>
      'Mostra apenas as subscrições ativas.';

  @override
  String get billsSettingsShowOnlyExpected => 'Mostrar apenas as esperadas';

  @override
  String get billsSettingsShowOnlyExpectedDesc =>
      'Mostra apenas as subscrições que são esperadas (ou pagas) este mês.';

  @override
  String get categoryDeleteConfirm =>
      'Tem certeza de que deseja excluir esta categoria? As transações não serão excluídas, mas não terão mais uma categoria.';

  @override
  String get categoryErrorLoading => 'Erro ao carregar categorias.';

  @override
  String get categoryFormLabelIncludeInSum => 'Incluir na soma mensal';

  @override
  String get categoryFormLabelName => 'Nome da Categoria';

  @override
  String get categoryMonthNext => 'Próximo mês';

  @override
  String get categoryMonthPrev => 'Mês Anterior';

  @override
  String get categorySumExcluded => 'excluído';

  @override
  String get categoryTitleAdd => 'Adicionar Categoria';

  @override
  String get categoryTitleDelete => 'Excluir Categoria';

  @override
  String get categoryTitleEdit => 'Editar Categoria';

  @override
  String get catNone => '<no category>';

  @override
  String get catOther => 'Outros';

  @override
  String errorAPIInvalidResponse(String message) {
    return 'Resposta inválida da API: $message';
  }

  @override
  String get errorAPIUnavailable => 'API indisponível';

  @override
  String get errorFieldRequired => 'Este campo é obrigatório.';

  @override
  String get errorInvalidURL => 'URL inválida';

  @override
  String errorMinAPIVersion(String requiredVersion) {
    return 'Versão mínima do Firefly API necessária: $requiredVersion. Por favor, atualize.';
  }

  @override
  String errorStatusCode(int code) {
    return 'Código de Status: $code';
  }

  @override
  String get errorUnknown => 'Erro desconhecido.';

  @override
  String get formButtonHelp => 'Ajuda';

  @override
  String get formButtonLogin => 'Entrar';

  @override
  String get formButtonLogout => 'Sair';

  @override
  String get formButtonRemove => 'Remover';

  @override
  String get formButtonResetLogin => 'Redefinir acesso';

  @override
  String get formButtonTransactionAdd => 'Adicionar Transação';

  @override
  String get formButtonTryAgain => 'Tentar novamente';

  @override
  String get generalAccount => 'Conta';

  @override
  String get generalAssets => 'Ativos';

  @override
  String get generalBalance => 'Saldo';

  @override
  String generalBalanceOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Saldo em $dateString';
  }

  @override
  String get generalBill => 'Subscrição';

  @override
  String get generalBudget => 'Orçamento';

  @override
  String get generalCategory => 'Categoria';

  @override
  String get generalCurrency => 'Moeda';

  @override
  String get generalDateRangeCurrentMonth => 'Mês Atual';

  @override
  String get generalDateRangeLast30Days => 'Últimos 30 dias';

  @override
  String get generalDateRangeCurrentYear => 'Ano Atual';

  @override
  String get generalDateRangeLastYear => 'Ano passado';

  @override
  String get generalDateRangeAll => 'Todos';

  @override
  String get generalDefault => 'padrão';

  @override
  String get generalDestinationAccount => 'Conta de Destino';

  @override
  String get generalDismiss => 'Dispensar';

  @override
  String get generalEarned => 'Ganhos';

  @override
  String get generalError => 'Erro';

  @override
  String get generalExpenses => 'Despesas';

  @override
  String get generalIncome => 'Receitas';

  @override
  String get generalLiabilities => 'Passivos';

  @override
  String get generalMultiple => 'vários(as)';

  @override
  String get generalNever => 'nunca';

  @override
  String get generalReconcile => 'Reconciliado';

  @override
  String get generalReset => 'Redefinir';

  @override
  String get generalSourceAccount => 'Conta de Origem';

  @override
  String get generalSpent => 'Gastos';

  @override
  String get generalSum => 'Soma';

  @override
  String get generalTarget => 'Objetivo';

  @override
  String get generalUnknown => 'Desconhecido(a)';

  @override
  String homeMainBillsInterval(String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'semanal',
      'monthly': 'mensal',
      'quarterly': 'trimestral',
      'halfyear': 'semestral',
      'yearly': 'anual',
      'other': 'desconhecido',
    });
    return ' ($_temp0)';
  }

  @override
  String get homeMainBillsTitle => 'Subscrições para a próxima semana';

  @override
  String homeMainBudgetInterval(DateTime from, DateTime to, String period) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return ' ($fromString a $toString, $period)';
  }

  @override
  String homeMainBudgetIntervalSingle(DateTime from, DateTime to) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return ' ($fromString a $toString)';
  }

  @override
  String homeMainBudgetSum(String current, String status, String available) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'over': 'acima de',
      'other': 'restantes de',
    });
    return '$current $_temp0 $available';
  }

  @override
  String get homeMainBudgetTitle => 'Orçamentos para o mês atual';

  @override
  String get homeMainChartAccountsTitle => 'Resumo da Conta';

  @override
  String get homeMainChartCategoriesTitle =>
      'Resumo da categoria para o mês atual';

  @override
  String get homeMainChartDailyAvg => 'Média de 7 dias';

  @override
  String get homeMainChartDailyTitle => 'Resumo Diário';

  @override
  String get homeMainChartNetEarningsTitle => 'Lucro Líquido';

  @override
  String get homeMainChartNetWorthTitle => 'Património Líquido';

  @override
  String get homeMainChartTagsTitle => 'Resumo de Etiquetas para o mês atual';

  @override
  String get homePiggyAdjustDialogTitle => 'Guardar/Gastar Dinheiro';

  @override
  String homePiggyDateStart(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Data de início: $dateString';
  }

  @override
  String homePiggyDateTarget(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Data de término: $dateString';
  }

  @override
  String get homeMainDialogSettingsTitle => 'Personalizar Painel';

  @override
  String homePiggyLinked(String account) {
    return 'Vinculado a $account';
  }

  @override
  String get homePiggyNoAccounts => 'Nenhum cofrinho configurado.';

  @override
  String get homePiggyNoAccountsSubtitle => 'Crie alguns na interface web!';

  @override
  String homePiggyRemaining(String amount) {
    return 'Restante para poupar: $amount';
  }

  @override
  String homePiggySaved(String amount) {
    return 'Poupado até agora: $amount';
  }

  @override
  String get homePiggySavedMultiple => 'Guardado até agora:';

  @override
  String homePiggyTarget(String amount) {
    return 'Valor almejado: $amount';
  }

  @override
  String get homePiggyAccountStatus => 'Estado da Conta';

  @override
  String get homePiggyAvailableAmounts => 'Valores Disponíveis';

  @override
  String homePiggyAvailable(String amount) {
    return 'Disponível: $amount';
  }

  @override
  String homePiggyInPiggyBanks(String amount) {
    return 'Em mealheiros: $amount';
  }

  @override
  String get homeTabLabelBalance => 'Balanço Financeiro';

  @override
  String get homeTabLabelMain => 'Geral';

  @override
  String get homeTabLabelPiggybanks => 'Cofrinhos';

  @override
  String get homeTabLabelTransactions => 'Transações';

  @override
  String get homeTransactionsActionFilter => 'Filtros';

  @override
  String get homeTransactionsDialogFilterAccountsAll => '<Todas as Contas>';

  @override
  String get homeTransactionsDialogFilterBillsAll => '<Todas as Subscrições>';

  @override
  String get homeTransactionsDialogFilterBillUnset =>
      '<Nenhuma Subscrição definida>';

  @override
  String get homeTransactionsDialogFilterBudgetsAll => '<Todos os Orçamentos>';

  @override
  String get homeTransactionsDialogFilterBudgetUnset =>
      '<Nenhum Orçamento definido>';

  @override
  String get homeTransactionsDialogFilterCategoriesAll =>
      '<Todas as Categorias>';

  @override
  String get homeTransactionsDialogFilterCategoryUnset =>
      '<Nenhuma Categoria definida>';

  @override
  String get homeTransactionsDialogFilterCurrenciesAll => '<All Currencies>';

  @override
  String get homeTransactionsDialogFilterDateRange => 'Intervalo de Datas';

  @override
  String get homeTransactionsDialogFilterFutureTransactions =>
      'Mostrar transações futuras';

  @override
  String get homeTransactionsDialogFilterSearch => 'Palavras-chave';

  @override
  String get homeTransactionsDialogFilterTitle => 'Filtrar';

  @override
  String get homeTransactionsEmpty => 'Nenhuma transação encontrada.';

  @override
  String homeTransactionsMultipleCategories(int num) {
    return '$num categorias';
  }

  @override
  String get homeTransactionsSettingsShowTags =>
      'Mostrar etiquetas na lista de transações';

  @override
  String get liabilityDirectionCredit => 'É devido a mim';

  @override
  String get liabilityDirectionDebit => 'Devo isso';

  @override
  String get liabilityTypeDebt => 'Dívida';

  @override
  String get liabilityTypeLoan => 'Empréstimo';

  @override
  String get liabilityTypeMortgage => 'Hipoteca';

  @override
  String get loginAbout =>
      'Para usar o Waterfly III de maneira produtiva, você precisa de seu próprio servidor com uma instância do Firefly III ou o add-on Firefly III para o Home Assistant.\n\nPor favor, insira a URL completa, bem como um token de acesso pessoal (Opções -> Perfil -> OAuth -> Tokens de acesso pessoal) abaixo.';

  @override
  String get loginFormLabelAPIKey => 'Chave de API válida';

  @override
  String get loginFormLabelHost => 'URL do servidor';

  @override
  String get loginWelcome => 'Bem vindo ao Waterfly III';

  @override
  String get logoutConfirmation => 'Tem certeza que deseja sair?';

  @override
  String get navigationAccounts => 'Contas';

  @override
  String get navigationBills => 'Assinaturas';

  @override
  String get navigationCategories => 'Categorias';

  @override
  String get navigationMain => 'Painel Principal';

  @override
  String get generalSettings => 'Configurações';

  @override
  String get no => 'Não';

  @override
  String numPercent(double num) {
    final intl.NumberFormat numNumberFormat = intl
        .NumberFormat.decimalPercentPattern(
      locale: localeName,
      decimalDigits: 0,
    );
    final String numString = numNumberFormat.format(num);

    return '$numString';
  }

  @override
  String numPercentOf(double perc, String of) {
    final intl.NumberFormat percNumberFormat = intl
        .NumberFormat.decimalPercentPattern(
      locale: localeName,
      decimalDigits: 0,
    );
    final String percString = percNumberFormat.format(perc);

    return '$percString de $of';
  }

  @override
  String get settingsDialogDebugInfo =>
      'Você pode habilitar e enviar logs de depuração aqui. Eles têm um impacto negativo no desempenho, então, por favor, não os habilite a menos que seja conselhado a fazê-lo. Ao desativá-los, os logs armazenados serão apagados.';

  @override
  String get settingsDialogDebugMailCreate => 'Criar e-mail';

  @override
  String get settingsDialogDebugMailDisclaimer =>
      'AVISO: Um rascunho de e-mail será aberto com o arquivo de log anexo (em formato texto). Os logs podem conter informações confidenciais, tais como o host da sua instância do Firefly (embora eu tente evitar o log de segredos, como a chave de api). Por favor, leia o log com cuidado e censure quaisquer informações que você não deseje compartilhar e/ou não seja relevante ao problema que você deseja relatar.\n\nPor favor, não envie logs sem antes combinar via e-mail/GitHub. Eu irei apagar quaisquer logs que me forem enviados sem contexto, por motivos de privacidade. Nunca envie o log não censurado ao GitHub ou qualquer outro lugar.';

  @override
  String get settingsDialogDebugSendButton => 'Enviar Logs por E-mail';

  @override
  String get settingsDialogDebugTitle => 'Logs de Depuração';

  @override
  String get settingsDialogLanguageTitle => 'Selecionar Idioma';

  @override
  String get settingsDialogThemeTitle => 'Selecionar Tema';

  @override
  String get settingsFAQ => 'Perguntas Frequentes';

  @override
  String get settingsFAQHelp =>
      'Abre no navegador. Disponível apenas em inglês.';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLockscreen => 'Tela de bloqueio';

  @override
  String get settingsLockscreenHelp => 'Exigir autenticação ao abrir o app';

  @override
  String get settingsLockscreenInitial =>
      'Por favor, autentique-se para ativar a tela de bloqueio.';

  @override
  String get settingsNLAppAccount => 'Conta Padrão';

  @override
  String get settingsNLAppAccountDynamic => '<Dinâmica>';

  @override
  String get settingsNLAppAdd => 'Adicionar Aplicativo';

  @override
  String get settingsNLAppAddHelp =>
      'Clique para adicionar um aplicativo para monitorar. Apenas aplicativos onde isso for possível irão aparecer na lista.';

  @override
  String get settingsNLAppAddInfo =>
      'Faça algumas transações que gerem notificações no seu celular para popular essa lista. Se o app ainda não aparecer, por favor, reporte-o para app@vogt.pw.';

  @override
  String get settingsNLAutoAdd => 'Criar transação sem interação';

  @override
  String get settingsNLDescription =>
      'Esse serviço permite que você obtenha transações a partir de notificações push recebidas. Além disso, você pode selecionar uma conta padrão para a qual a transação deve ser atribuída - se nenhum valor for definido, ele tentará inferir a conta a partir da notificação.';

  @override
  String get settingsNLEmptyNote => 'Manter campo de nota vazio';

  @override
  String get settingsNLPermissionGrant => 'Toque para permitir.';

  @override
  String get settingsNLPermissionNotGranted => 'Permissão não concedida.';

  @override
  String get settingsNLPermissionRemove => 'Remover permissão?';

  @override
  String get settingsNLPermissionRemoveHelp =>
      'Para desabilitar este serviço, clique no app e remova a permissão na tela seguinte.';

  @override
  String get settingsNLPrefillTXTitle =>
      'Preencher título da transação com o título da notificação';

  @override
  String get settingsNLServiceChecking => 'Verificando status…';

  @override
  String settingsNLServiceCheckingError(String error) {
    return 'Erro ao verificar status: $error';
  }

  @override
  String get settingsNLServiceRunning => 'Serviço em execução.';

  @override
  String get settingsNLServiceStatus => 'Status do Serviço';

  @override
  String get settingsNLServiceStopped => 'Serviço desativado.';

  @override
  String get settingsNotificationListener => 'Monitorar Notificações';

  @override
  String get settingsTheme => 'Tema do aplicativo';

  @override
  String get settingsThemeDynamicColors => 'Cores Dinâmicas';

  @override
  String settingsThemeValue(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'dark': 'Modo escuro',
      'light': 'Modo claro',
      'other': 'Padrão do Sistema',
    });
    return '$_temp0';
  }

  @override
  String get settingsUseServerTimezone => 'Usar fuso horário do servidor';

  @override
  String get settingsUseServerTimezoneHelp =>
      'Mostrar todos os horários no fuso horário do servidor. Isso imita o comportamento da interface web.';

  @override
  String get settingsVersion => 'Versão do Aplicativo';

  @override
  String get settingsVersionChecking => 'verificando…';

  @override
  String get transactionAttachments => 'Anexos';

  @override
  String get transactionDeleteConfirm =>
      'Tem certeza de que deseja apagar esta transação?';

  @override
  String get transactionDialogAttachmentsDelete => 'Apagar Anexo';

  @override
  String get transactionDialogAttachmentsDeleteConfirm =>
      'Tem certeza de que deseja excluir esse anexo?';

  @override
  String get transactionDialogAttachmentsErrorDownload =>
      'Não foi possível baixar o arquivo.';

  @override
  String transactionDialogAttachmentsErrorOpen(String error) {
    return 'Não foi possível abrir o arquivo: $error';
  }

  @override
  String transactionDialogAttachmentsErrorUpload(String error) {
    return 'Não foi possível enviar o arquivo: $error';
  }

  @override
  String get transactionDialogAttachmentsTitle => 'Anexos';

  @override
  String get transactionDialogBillNoBill => 'Sem assinatura';

  @override
  String get transactionDialogBillTitle => 'Vincular à Assinatura';

  @override
  String get transactionDialogCurrencyTitle => 'Selecione a moeda';

  @override
  String get transactionDialogPiggyNoPiggy => 'Nenhum Cofrinho';

  @override
  String get transactionDialogPiggyTitle => 'Vincular a Cofrinho';

  @override
  String get transactionDialogTagsAdd => 'Adicionar Tag';

  @override
  String get transactionDialogTagsHint => 'Buscar/Adicionar Tag';

  @override
  String get transactionDialogTagsTitle => 'Selecionar tags';

  @override
  String get transactionDuplicate => 'Duplicar';

  @override
  String get transactionErrorInvalidAccount => 'Conta inválida';

  @override
  String get transactionErrorInvalidBudget => 'Orçamento Inválido';

  @override
  String get transactionErrorNoAccounts =>
      'Por favor, preencha as contas primeiro.';

  @override
  String get transactionErrorNoAssetAccount =>
      'Por favor, selecione uma conta de ativo.';

  @override
  String get transactionErrorTitle => 'Por favor, especifique um título.';

  @override
  String get transactionFormLabelAccountDestination => 'Conta de destino';

  @override
  String get transactionFormLabelAccountForeign => 'Conta externa';

  @override
  String get transactionFormLabelAccountOwn => 'Conta própria';

  @override
  String get transactionFormLabelAccountSource => 'Conta de origem';

  @override
  String get transactionFormLabelNotes => 'Notas';

  @override
  String get transactionFormLabelTags => 'Etiquetas';

  @override
  String get transactionFormLabelTitle => 'Título da Transação';

  @override
  String get transactionSplitAdd => 'Adicionar divisão';

  @override
  String get transactionSplitChangeCurrency => 'Alterar Moeda da Divisão';

  @override
  String get transactionSplitChangeDestinationAccount =>
      'Alterar Conta de Destino da Divisão';

  @override
  String get transactionSplitChangeSourceAccount =>
      'Alterar Conta de Origem da Divisão';

  @override
  String get transactionSplitChangeTarget => 'Alterar Conta Alvo da Divisão';

  @override
  String get transactionSplitDelete => 'Excluir divisão';

  @override
  String get transactionTitleAdd => 'Adicionar Transação';

  @override
  String get transactionTitleDelete => 'Excluir Transação';

  @override
  String get transactionTitleEdit => 'Editar Transação';

  @override
  String get transactionTypeDeposit => 'Depósito';

  @override
  String get transactionTypeTransfer => 'Transferência';

  @override
  String get transactionTypeWithdrawal => 'Retirada';
}
