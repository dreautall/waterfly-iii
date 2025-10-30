// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class SUk extends S {
  SUk([String locale = 'uk']) : super(locale);

  @override
  String get accountRoleAssetCashWallet => 'Гаманець';

  @override
  String get accountRoleAssetCC => 'Кредитна карта';

  @override
  String get accountRoleAssetDefault => 'Основний рахунок за замовчуванням';

  @override
  String get accountRoleAssetSavings => 'Накопичувальний рахунок';

  @override
  String get accountRoleAssetShared => 'Спільний рахунок';

  @override
  String get accountsLabelAsset => 'Активні рахунки';

  @override
  String get accountsLabelExpense => 'Рахунки витрат';

  @override
  String get accountsLabelLiabilities => 'Зобов’язання';

  @override
  String get accountsLabelRevenue => 'Джерела доходів';

  @override
  String accountsLiabilitiesInterest(double interest, String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'week',
      'monthly': 'month',
      'quarterly': 'quarter',
      'halfyear': 'half-year',
      'yearly': 'year',
      'other': 'unknown',
    });
    return '$interest% interest per $_temp0';
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
  String get billsChangeLayoutTooltip => 'Змінити вигляд';

  @override
  String get billsChangeSortOrderTooltip => 'Змінити порядок сортування';

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

    return 'Очікується $dateString';
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
  String get billsInactive => 'Неактивний';

  @override
  String get billsIsActive => 'Subscription is active';

  @override
  String get billsLayoutGroupSubtitle =>
      'Subscriptions displayed in their assigned groups.';

  @override
  String get billsLayoutGroupTitle => 'Група';

  @override
  String get billsLayoutListSubtitle =>
      'Subscriptions displayed in a list sorted by certain criteria.';

  @override
  String get billsLayoutListTitle => 'Список';

  @override
  String get billsListEmpty => 'Список наразі порожній.';

  @override
  String get billsNextExpectedMatch => 'Наступний очікуваний збіг';

  @override
  String get billsNotActive => 'Subscription is inactive';

  @override
  String get billsNotExpected => 'Not expected this period';

  @override
  String get billsNoTransactions => 'Трансакцій не знайдено.';

  @override
  String billsPaidOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Сплачено $dateString';
  }

  @override
  String get billsSortAlphabetical => 'За алфавітом';

  @override
  String get billsSortByTimePeriod => 'За період часу';

  @override
  String get billsSortFrequency => 'Періодичність';

  @override
  String get billsSortName => 'Назва';

  @override
  String get billsUngrouped => 'Без групи';

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
      'Ви впевнені, що хочете видалити цю категорію? Операції не будуть видалені, але більше не будуть мати категорій.';

  @override
  String get categoryErrorLoading => 'Помилка при завантаженні категорій.';

  @override
  String get categoryFormLabelIncludeInSum => 'Включати в щомісячну суму';

  @override
  String get categoryFormLabelName => 'Назва категорії';

  @override
  String get categoryMonthNext => 'Наступний місяць';

  @override
  String get categoryMonthPrev => 'Попередній місяць';

  @override
  String get categorySumExcluded => 'виключена';

  @override
  String get categoryTitleAdd => 'Додати категорію';

  @override
  String get categoryTitleDelete => 'Видалити категорію';

  @override
  String get categoryTitleEdit => 'Редагувати категорію';

  @override
  String get catNone => '<немає категорії>';

  @override
  String get catOther => 'Інше';

  @override
  String errorAPIInvalidResponse(String message) {
    return 'Невірна відповідь від API: $message';
  }

  @override
  String get errorAPIUnavailable => 'API недоступне';

  @override
  String get errorFieldRequired => 'Це поле є обов\'язковим.';

  @override
  String get errorInvalidURL => 'Некоректна адреса URL';

  @override
  String errorMinAPIVersion(String requiredVersion) {
    return 'Необхідна мінімальна версія API Firefly v$requiredVersion. Будь ласка, оновіть програму.';
  }

  @override
  String errorStatusCode(int code) {
    return 'Status Code: $code';
  }

  @override
  String get errorUnknown => 'Невідома помилка.';

  @override
  String get formButtonHelp => 'Допомога';

  @override
  String get formButtonLogin => 'Вхід';

  @override
  String get formButtonLogout => 'Вихід';

  @override
  String get formButtonRemove => 'Видалити';

  @override
  String get formButtonResetLogin => 'Reset login';

  @override
  String get formButtonTransactionAdd => 'Додати транзакцію';

  @override
  String get formButtonTryAgain => 'Спробувати ще раз';

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
  String get generalLiabilities => 'Зобов’язання';

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
  String get homeTransactionsEmpty => 'Трансакцій не знайдено.';

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
  String get transactionTitleAdd => 'Додати транзакцію';

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
