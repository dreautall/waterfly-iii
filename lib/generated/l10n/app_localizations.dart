import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ca.dart';
import 'app_localizations_cs.dart';
import 'app_localizations_da.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hu.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ro.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_sl.dart';
import 'app_localizations_sv.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_uk.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S)!;
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ca'),
    Locale('cs'),
    Locale('da'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fa'),
    Locale('fr'),
    Locale('hu'),
    Locale('id'),
    Locale('it'),
    Locale('ko'),
    Locale('nl'),
    Locale('pl'),
    Locale('pt', 'BR'),
    Locale('pt'),
    Locale('ro'),
    Locale('ru'),
    Locale('sl'),
    Locale('sv'),
    Locale('tr'),
    Locale('uk'),
    Locale('zh', 'TW'),
    Locale('zh'),
  ];

  /// Firefly Translation String: account_role_cashWalletAsset
  ///
  /// In en, this message translates to:
  /// **'Cash Wallet'**
  String get accountRoleAssetCashWallet;

  /// Firefly Translation String: account_role_ccAsset
  ///
  /// In en, this message translates to:
  /// **'Credit card'**
  String get accountRoleAssetCC;

  /// Firefly Translation String: account_role_defaultAsset
  ///
  /// In en, this message translates to:
  /// **'Default asset account'**
  String get accountRoleAssetDefault;

  /// Firefly Translation String: account_role_savingAsset
  ///
  /// In en, this message translates to:
  /// **'Savings account'**
  String get accountRoleAssetSavings;

  /// Firefly Translation String: account_role_sharedAsset
  ///
  /// In en, this message translates to:
  /// **'Shared asset account'**
  String get accountRoleAssetShared;

  /// Firefly Translation String: asset_accounts
  ///
  /// In en, this message translates to:
  /// **'Asset Accounts'**
  String get accountsLabelAsset;

  /// Firefly Translation String: expense_accounts
  ///
  /// In en, this message translates to:
  /// **'Expense Accounts'**
  String get accountsLabelExpense;

  /// Firefly Translation String: liabilities_accounts
  ///
  /// In en, this message translates to:
  /// **'Liabilities'**
  String get accountsLabelLiabilities;

  /// Firefly Translation String: revenue_accounts
  ///
  /// In en, this message translates to:
  /// **'Revenue Accounts'**
  String get accountsLabelRevenue;

  /// Interest in a certain period
  ///
  /// In en, this message translates to:
  /// **'{interest}% interest per {period, select, weekly{week} monthly{month} quarterly{quarter} halfyear{half-year} yearly{year} other{unknown}}'**
  String accountsLiabilitiesInterest(double interest, String period);

  /// Subscription match for min and max amounts, and frequency
  ///
  /// In en, this message translates to:
  /// **'Subscription matches transactions between {minValue} and {maxvalue}. Repeats {frequency, select, weekly{weekly} monthly{monthly} quarterly{quarterly} halfyear{half-yearly} yearly{yearly} other{unknown}}{skip, plural, =0{} other{, skips over {skip}}}.'**
  String billsAmountAndFrequency(
    String minValue,
    String maxvalue,
    String frequency,
    num skip,
  );

  /// Text for layout change button tooltip
  ///
  /// In en, this message translates to:
  /// **'Change layout'**
  String get billsChangeLayoutTooltip;

  /// Text for sort order change button tooltip
  ///
  /// In en, this message translates to:
  /// **'Change sort order'**
  String get billsChangeSortOrderTooltip;

  /// Generic error message when subscriptions can't be loaded (shouldn't occur)
  ///
  /// In en, this message translates to:
  /// **'Error loading subscriptions.'**
  String get billsErrorLoading;

  /// Subscription match for exact amount and frequency
  ///
  /// In en, this message translates to:
  /// **'Subscription matches transactions of {value}. Repeats {frequency, select, weekly{weekly} monthly{monthly} quarterly{quarterly} halfyear{half-yearly} yearly{yearly} other{unknown}}{skip, plural, =0{} other{, skips over {skip}}}.'**
  String billsExactAmountAndFrequency(String value, String frequency, num skip);

  /// Describes what date the subscription is expected
  ///
  /// In en, this message translates to:
  /// **'Expected {date}'**
  String billsExpectedOn(DateTime date);

  /// Subscription frequency
  ///
  /// In en, this message translates to:
  /// **'{frequency, select, weekly{Weekly} monthly{Monthly} quarterly{Quarterly} halfyear{Half-yearly} yearly{Yearly} other{Unknown}}'**
  String billsFrequency(String frequency);

  /// Subscription frequency
  ///
  /// In en, this message translates to:
  /// **'{frequency, select, weekly{Weekly} monthly{Monthly} quarterly{Quarterly} halfyear{Half-yearly} yearly{Yearly} other{Unknown}}{skip, plural, =0{} other{, skips over {skip}}}'**
  String billsFrequencySkip(String frequency, num skip);

  /// Text: when the subscription is inactive
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get billsInactive;

  /// Text: the subscription is active
  ///
  /// In en, this message translates to:
  /// **'Subscription is active'**
  String get billsIsActive;

  /// Subtitle text for group layout option
  ///
  /// In en, this message translates to:
  /// **'Subscriptions displayed in their assigned groups.'**
  String get billsLayoutGroupSubtitle;

  /// Title text for group layout option
  ///
  /// In en, this message translates to:
  /// **'Group'**
  String get billsLayoutGroupTitle;

  /// Subtitle text for list layout option
  ///
  /// In en, this message translates to:
  /// **'Subscriptions displayed in a list sorted by certain criteria.'**
  String get billsLayoutListSubtitle;

  /// Title text for list layout option
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get billsLayoutListTitle;

  /// Describes that the list is empty
  ///
  /// In en, this message translates to:
  /// **'The list is currently empty.'**
  String get billsListEmpty;

  /// Text: next expected match for subscription
  ///
  /// In en, this message translates to:
  /// **'Next expected match'**
  String get billsNextExpectedMatch;

  /// Text: the subscription is inactive
  ///
  /// In en, this message translates to:
  /// **'Subscription is inactive'**
  String get billsNotActive;

  /// Describes that the subscription is not expected this period
  ///
  /// In en, this message translates to:
  /// **'Not expected this period'**
  String get billsNotExpected;

  /// Describes that there are no transactions connected to the subscription
  ///
  /// In en, this message translates to:
  /// **'No transactions found.'**
  String get billsNoTransactions;

  /// Describes what date the subscription was paid
  ///
  /// In en, this message translates to:
  /// **'Paid {date}'**
  String billsPaidOn(DateTime date);

  /// Text for alphabetical sort types
  ///
  /// In en, this message translates to:
  /// **'Alphabetical'**
  String get billsSortAlphabetical;

  /// Text for frequency sort type
  ///
  /// In en, this message translates to:
  /// **'By time period'**
  String get billsSortByTimePeriod;

  /// Text for sort by frequency
  ///
  /// In en, this message translates to:
  /// **'Frequency'**
  String get billsSortFrequency;

  /// Text for sort by name
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get billsSortName;

  /// Title for ungrouped subscriptions
  ///
  /// In en, this message translates to:
  /// **'Ungrouped'**
  String get billsUngrouped;

  /// Text for show only active subscriptions settings item
  ///
  /// In en, this message translates to:
  /// **'Show only active'**
  String get billsSettingsShowOnlyActive;

  /// Text for show only active subscriptions settings item description
  ///
  /// In en, this message translates to:
  /// **'Shows only active subscriptions.'**
  String get billsSettingsShowOnlyActiveDesc;

  /// Text for show only expected subscriptions settings item
  ///
  /// In en, this message translates to:
  /// **'Show only expected'**
  String get billsSettingsShowOnlyExpected;

  /// Text for show only expected subscriptions settings item description
  ///
  /// In en, this message translates to:
  /// **'Shows only those subscriptions that are expected (or paid) this month.'**
  String get billsSettingsShowOnlyExpectedDesc;

  /// Confirmation text to delete category
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this category? The transactions will not be deleted, but will not have a category anymore.'**
  String get categoryDeleteConfirm;

  /// Generic error message when categories can't be loaded (shouldn't occur)
  ///
  /// In en, this message translates to:
  /// **'Error loading categories.'**
  String get categoryErrorLoading;

  /// Category Add/Edit Form: Label for toggle field to include value in monthly sum
  ///
  /// In en, this message translates to:
  /// **'Include in monthly sum'**
  String get categoryFormLabelIncludeInSum;

  /// Category Add/Edit Form: Label for name field
  ///
  /// In en, this message translates to:
  /// **'Category Name'**
  String get categoryFormLabelName;

  /// Button title to view overview for next month
  ///
  /// In en, this message translates to:
  /// **'Next Month'**
  String get categoryMonthNext;

  /// Button title to view overview for previous month
  ///
  /// In en, this message translates to:
  /// **'Previous Month'**
  String get categoryMonthPrev;

  /// Label that the category is excluded from the monthly sum. The label will be shown in the place where usually the monthly percentage share is shown. Should be a single word if possible.
  ///
  /// In en, this message translates to:
  /// **'excluded'**
  String get categorySumExcluded;

  /// Title for Dialog: Add Category
  ///
  /// In en, this message translates to:
  /// **'Add Category'**
  String get categoryTitleAdd;

  /// Title for Dialog: Delete Category
  ///
  /// In en, this message translates to:
  /// **'Delete Category'**
  String get categoryTitleDelete;

  /// Title for Dialog: Edit Category
  ///
  /// In en, this message translates to:
  /// **'Edit Category'**
  String get categoryTitleEdit;

  /// Placeholder when no category has been set.
  ///
  /// In en, this message translates to:
  /// **'<no category>'**
  String get catNone;

  /// Category description for summary category 'Other'
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get catOther;

  /// Invalid API response error
  ///
  /// In en, this message translates to:
  /// **'Invalid Response from API: {message}'**
  String errorAPIInvalidResponse(String message);

  /// Error thrown when API is unavailable.
  ///
  /// In en, this message translates to:
  /// **'API unavailable'**
  String get errorAPIUnavailable;

  /// Error: Required field was left empty.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get errorFieldRequired;

  /// Error: URL is invalid
  ///
  /// In en, this message translates to:
  /// **'Invalid URL'**
  String get errorInvalidURL;

  /// Error: Required API version not met.
  ///
  /// In en, this message translates to:
  /// **'Minimum Firefly API Version v{requiredVersion} required. Please upgrade.'**
  String errorMinAPIVersion(String requiredVersion);

  /// HTTP status code information on error
  ///
  /// In en, this message translates to:
  /// **'Status Code: {code}'**
  String errorStatusCode(int code);

  /// Error without further information occurred.
  ///
  /// In en, this message translates to:
  /// **'Unknown error.'**
  String get errorUnknown;

  /// Button Label: Help
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get formButtonHelp;

  /// Button Label: Login
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get formButtonLogin;

  /// Button Label: Logout
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get formButtonLogout;

  /// Button Label: Remove
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get formButtonRemove;

  /// Button Label: Reset login form (when error is shown)
  ///
  /// In en, this message translates to:
  /// **'Reset login'**
  String get formButtonResetLogin;

  /// Button Label: Add Transaction
  ///
  /// In en, this message translates to:
  /// **'Add Transaction'**
  String get formButtonTransactionAdd;

  /// Button Label: Try that thing again (login etc)
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get formButtonTryAgain;

  /// Asset/Debt (Bank) Account
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get generalAccount;

  /// (Monetary) Assets
  ///
  /// In en, this message translates to:
  /// **'Assets'**
  String get generalAssets;

  /// (Account) Balance
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get generalBalance;

  /// No description provided for @generalBalanceOn.
  ///
  /// In en, this message translates to:
  /// **'Balance on {date}'**
  String generalBalanceOn(DateTime date);

  /// Subscription (caution: was named Bill until Firefly version 6.2.0)
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get generalBill;

  /// (Monetary) Budget
  ///
  /// In en, this message translates to:
  /// **'Budget'**
  String get generalBudget;

  /// Category (of transaction etc.).
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get generalCategory;

  /// (Money) Currency
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get generalCurrency;

  /// Date Range: Current Month
  ///
  /// In en, this message translates to:
  /// **'Current Month'**
  String get generalDateRangeCurrentMonth;

  /// Date Range: Last 30 days
  ///
  /// In en, this message translates to:
  /// **'Last 30 days'**
  String get generalDateRangeLast30Days;

  /// Date Range: Current Year
  ///
  /// In en, this message translates to:
  /// **'Current Year'**
  String get generalDateRangeCurrentYear;

  /// Date Range: Last year
  ///
  /// In en, this message translates to:
  /// **'Last year'**
  String get generalDateRangeLastYear;

  /// Date Range: All
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get generalDateRangeAll;

  /// Indicates that something is the default choice
  ///
  /// In en, this message translates to:
  /// **'default'**
  String get generalDefault;

  /// Destination Account (for transaction)
  ///
  /// In en, this message translates to:
  /// **'Destination Account'**
  String get generalDestinationAccount;

  /// Dismiss window/dialog without action
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get generalDismiss;

  /// (Amount) Earned
  ///
  /// In en, this message translates to:
  /// **'Earned'**
  String get generalEarned;

  /// Error (title in dialogs etc.)
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get generalError;

  /// (Account) Expenses
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get generalExpenses;

  /// (Account) Info
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get generalIncome;

  /// Label for the remaining (not yet spent) amount of a budget.
  ///
  /// In en, this message translates to:
  /// **'Left'**
  String get generalLeft;

  /// Firefly Translation String: liabilities
  ///
  /// In en, this message translates to:
  /// **'Liabilities'**
  String get generalLiabilities;

  /// Multiples of a single thing (e.g. source accounts) are existing
  ///
  /// In en, this message translates to:
  /// **'multiple'**
  String get generalMultiple;

  /// Has never happened, no update etc.
  ///
  /// In en, this message translates to:
  /// **'never'**
  String get generalNever;

  /// Booking has been confirmed/reconciled
  ///
  /// In en, this message translates to:
  /// **'Reconciled'**
  String get generalReconcile;

  /// Reset something (i.e. set filters)
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get generalReset;

  /// Source Account (of transaction)
  ///
  /// In en, this message translates to:
  /// **'Source Account'**
  String get generalSourceAccount;

  /// (Amount) Spent
  ///
  /// In en, this message translates to:
  /// **'Spent'**
  String get generalSpent;

  /// (Mathematical) Sum
  ///
  /// In en, this message translates to:
  /// **'Sum'**
  String get generalSum;

  /// Target value (i.e. a sum to save)
  ///
  /// In en, this message translates to:
  /// **'Target'**
  String get generalTarget;

  /// Something is unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get generalUnknown;

  /// Tooltip label for privacy mode button
  ///
  /// In en, this message translates to:
  /// **'Show/Hide all amounts (Privacy Mode)'**
  String get homeMainActionPrivacyMode;

  /// subscription interval type
  ///
  /// In en, this message translates to:
  /// **' ({period, select, weekly{weekly} monthly{monthly} quarterly{quarterly} halfyear{half-year} yearly{yearly} other{unknown}})'**
  String homeMainBillsInterval(String period);

  /// Title: Subscriptions for the next week
  ///
  /// In en, this message translates to:
  /// **'Subscriptions for the next week'**
  String get homeMainBillsTitle;

  /// Budget interval ranging from 'from' to 'to', over an interval of 'period'. 'period' is localized by Firefly.
  ///
  /// In en, this message translates to:
  /// **' ({from} to {to}, {period})'**
  String homeMainBudgetInterval(DateTime from, DateTime to, String period);

  /// Budget interval ranging from 'from' to 'to', without a specified period.
  ///
  /// In en, this message translates to:
  /// **' ({from} to {to})'**
  String homeMainBudgetIntervalSingle(DateTime from, DateTime to);

  /// Budget has 'current' money over/left from ('status') of total budget 'available' money.
  ///
  /// In en, this message translates to:
  /// **'{current} {status, select, over{over} other{left from}} {available}'**
  String homeMainBudgetSum(String current, String status, String available);

  /// Title: Budgets for current month
  ///
  /// In en, this message translates to:
  /// **'Budgets for current month'**
  String get homeMainBudgetTitle;

  /// Chart Label: Account Summary
  ///
  /// In en, this message translates to:
  /// **'Account Summary'**
  String get homeMainChartAccountsTitle;

  /// Chart Label: Category Summary
  ///
  /// In en, this message translates to:
  /// **'Category Summary for current month'**
  String get homeMainChartCategoriesTitle;

  /// Text for last week average spent
  ///
  /// In en, this message translates to:
  /// **'7 days average'**
  String get homeMainChartDailyAvg;

  /// Chart Label: Daily Summary
  ///
  /// In en, this message translates to:
  /// **'Daily Summary'**
  String get homeMainChartDailyTitle;

  /// Chart Label: Net Earnings
  ///
  /// In en, this message translates to:
  /// **'Net Earnings'**
  String get homeMainChartNetEarningsTitle;

  /// Chart Label: Net Worth
  ///
  /// In en, this message translates to:
  /// **'Net Worth'**
  String get homeMainChartNetWorthTitle;

  /// Chart Label: Tags Summary
  ///
  /// In en, this message translates to:
  /// **'Tag Summary for current month'**
  String get homeMainChartTagsTitle;

  /// Title of the dialog where money can be added/removed to a piggy bank.
  ///
  /// In en, this message translates to:
  /// **'Save/Spend Money'**
  String get homePiggyAdjustDialogTitle;

  /// Start of the piggy bank
  ///
  /// In en, this message translates to:
  /// **'Start date: {date}'**
  String homePiggyDateStart(DateTime date);

  /// Set target date of the piggy bank (when saving should be finished)
  ///
  /// In en, this message translates to:
  /// **'Target date: {date}'**
  String homePiggyDateTarget(DateTime date);

  /// Dialog title for dashboard settings (card order & visibility)
  ///
  /// In en, this message translates to:
  /// **'Customize Dashboard'**
  String get homeMainDialogSettingsTitle;

  /// Piggy bank is linked to asset account {account}.
  ///
  /// In en, this message translates to:
  /// **'Linked to {account}'**
  String homePiggyLinked(String account);

  /// Information that no piggy banks are existing
  ///
  /// In en, this message translates to:
  /// **'No piggy banks set up.'**
  String get homePiggyNoAccounts;

  /// Subtitle if no piggy banks are existing, hinting to use the webinterface to create some.
  ///
  /// In en, this message translates to:
  /// **'Create some in the webinterface!'**
  String get homePiggyNoAccountsSubtitle;

  /// How much money is left to save
  ///
  /// In en, this message translates to:
  /// **'Left to save: {amount}'**
  String homePiggyRemaining(String amount);

  /// How much money already was saved
  ///
  /// In en, this message translates to:
  /// **'Saved so far: {amount}'**
  String homePiggySaved(String amount);

  /// How much should be saved per month to reach the target
  ///
  /// In en, this message translates to:
  /// **'Save per month: {amount}'**
  String homePiggySavePerMonth(String amount);

  /// Title for a list of multiple accounts with the amount of money saved so far
  ///
  /// In en, this message translates to:
  /// **'Saved so far:'**
  String get homePiggySavedMultiple;

  /// How much money should be saved
  ///
  /// In en, this message translates to:
  /// **'Target amount: {amount}'**
  String homePiggyTarget(String amount);

  /// Title for the account status section showing balances and piggy bank totals
  ///
  /// In en, this message translates to:
  /// **'Account Status'**
  String get homePiggyAccountStatus;

  /// Title for the available amounts section showing money not in piggy banks
  ///
  /// In en, this message translates to:
  /// **'Available Amounts'**
  String get homePiggyAvailableAmounts;

  /// Available balance after subtracting piggy bank amounts
  ///
  /// In en, this message translates to:
  /// **'Available: {amount}'**
  String homePiggyAvailable(String amount);

  /// Amount currently in piggy banks for this account
  ///
  /// In en, this message translates to:
  /// **'In piggy banks: {amount}'**
  String homePiggyInPiggyBanks(String amount);

  /// Total balance of an account in the Piggy bank
  ///
  /// In en, this message translates to:
  /// **'Total: {amount}'**
  String homePiggyTotal(String amount);

  /// Tab Label: Balance Sheet page
  ///
  /// In en, this message translates to:
  /// **'Balance Sheet'**
  String get homeTabLabelBalance;

  /// Tab Label: Start page ("main")
  ///
  /// In en, this message translates to:
  /// **'Main'**
  String get homeTabLabelMain;

  /// Tab Label: Piggy Banks page
  ///
  /// In en, this message translates to:
  /// **'Piggy Banks'**
  String get homeTabLabelPiggybanks;

  /// Tab Label: Transactions page
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get homeTabLabelTransactions;

  /// Action Button Label: Filter list.
  ///
  /// In en, this message translates to:
  /// **'Filter List'**
  String get homeTransactionsActionFilter;

  /// Don't filter for a specific account (default entry)
  ///
  /// In en, this message translates to:
  /// **'<All Accounts>'**
  String get homeTransactionsDialogFilterAccountsAll;

  /// Don't filter for a specific subscription (default entry)
  ///
  /// In en, this message translates to:
  /// **'<All Subscriptions>'**
  String get homeTransactionsDialogFilterBillsAll;

  /// Filter for unset subscription
  ///
  /// In en, this message translates to:
  /// **'<No Subscription set>'**
  String get homeTransactionsDialogFilterBillUnset;

  /// Don't filter for a specific budget (default entry)
  ///
  /// In en, this message translates to:
  /// **'<All Budgets>'**
  String get homeTransactionsDialogFilterBudgetsAll;

  /// Filter for unset budgets
  ///
  /// In en, this message translates to:
  /// **'<No Budget set>'**
  String get homeTransactionsDialogFilterBudgetUnset;

  /// Don't filter for a specific category (default entry)
  ///
  /// In en, this message translates to:
  /// **'<All Categories>'**
  String get homeTransactionsDialogFilterCategoriesAll;

  /// Filter for unset categories
  ///
  /// In en, this message translates to:
  /// **'<No Category set>'**
  String get homeTransactionsDialogFilterCategoryUnset;

  /// Don't filter for a specific currency (default entry)
  ///
  /// In en, this message translates to:
  /// **'<All Currencies>'**
  String get homeTransactionsDialogFilterCurrenciesAll;

  /// Label for the date range dropdown (all, last year, last month, last 30 days etc)
  ///
  /// In en, this message translates to:
  /// **'Date Range'**
  String get homeTransactionsDialogFilterDateRange;

  /// Setting to show future transactions
  ///
  /// In en, this message translates to:
  /// **'Show future transactions'**
  String get homeTransactionsDialogFilterFutureTransactions;

  /// Search term for filter
  ///
  /// In en, this message translates to:
  /// **'Search Term'**
  String get homeTransactionsDialogFilterSearch;

  /// Title of Filter Dialog
  ///
  /// In en, this message translates to:
  /// **'Select filters'**
  String get homeTransactionsDialogFilterTitle;

  /// Message when no transactions are found.
  ///
  /// In en, this message translates to:
  /// **'No transactions found.'**
  String get homeTransactionsEmpty;

  /// $num categories for the transaction.
  ///
  /// In en, this message translates to:
  /// **'{num} categories'**
  String homeTransactionsMultipleCategories(int num);

  /// Setting label to show tags in transactioon list.
  ///
  /// In en, this message translates to:
  /// **'Show tags in transaction list'**
  String get homeTransactionsSettingsShowTags;

  /// Firefly Translation String: liability_direction_credit
  ///
  /// In en, this message translates to:
  /// **'I am owed this debt'**
  String get liabilityDirectionCredit;

  /// Firefly Translation String: liability_direction_debit
  ///
  /// In en, this message translates to:
  /// **'I owe this debt'**
  String get liabilityDirectionDebit;

  /// Firefly Translation String: account_type_debt
  ///
  /// In en, this message translates to:
  /// **'Debt'**
  String get liabilityTypeDebt;

  /// Firefly Translation String: account_type_loan
  ///
  /// In en, this message translates to:
  /// **'Loan'**
  String get liabilityTypeLoan;

  /// Firefly Translation String: account_type_mortgage
  ///
  /// In en, this message translates to:
  /// **'Mortgage'**
  String get liabilityTypeMortgage;

  /// Login screen welcome description
  ///
  /// In en, this message translates to:
  /// **'To use Waterfly III productively you need your own server with a Firefly III instance or the Firefly III add-on for Home Assistant.\n\nPlease enter the full URL as well as a personal access token (Settings -> Profile -> OAuth -> Personal Access Token) below.'**
  String get loginAbout;

  /// Login Form: Label for button to hide Custom Headers field - should be similar length than show custom headers button
  ///
  /// In en, this message translates to:
  /// **'Hide Headers'**
  String get loginFormButtonHideHeaders;

  /// Login Form: Label for button to show Custom Headers field - should be similar length than hide custom headers button
  ///
  /// In en, this message translates to:
  /// **'Custom Headers'**
  String get loginFormButtonShowHeaders;

  /// Login Form: Label for API Key field
  ///
  /// In en, this message translates to:
  /// **'Valid API Key'**
  String get loginFormLabelAPIKey;

  /// Login Form: Label for Custom Headers field
  ///
  /// In en, this message translates to:
  /// **'Custom Headers (optional)'**
  String get loginFormLabelHeaders;

  /// Login Form: Helper text for Custom Headers field
  ///
  /// In en, this message translates to:
  /// **'One per line, format: HeaderName: value'**
  String get loginFormLabelHeadersHelp;

  /// Login Form: Label for Host field
  ///
  /// In en, this message translates to:
  /// **'Host URL'**
  String get loginFormLabelHost;

  /// Login screen welcome banner
  ///
  /// In en, this message translates to:
  /// **'Welcome to Waterfly III'**
  String get loginWelcome;

  /// Get user confirmation if he really wants to log out
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logoutConfirmation;

  /// Navigation Label: Accounts Page
  ///
  /// In en, this message translates to:
  /// **'Accounts'**
  String get navigationAccounts;

  /// Navigation Label: Subscriptions
  ///
  /// In en, this message translates to:
  /// **'Subscriptions'**
  String get navigationBills;

  /// Navigation Label: Categories
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get navigationCategories;

  /// Navigation Label: Dashboard
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get navigationMain;

  /// Label: Settings
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get generalSettings;

  /// The word no
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// Number formatted as percentage
  ///
  /// In en, this message translates to:
  /// **'{num}'**
  String numPercent(double num);

  /// Number formatted as percentage, with total amount provided
  ///
  /// In en, this message translates to:
  /// **'{perc} of {of}'**
  String numPercentOf(double perc, String of);

  /// Information about debug logs and their impact.
  ///
  /// In en, this message translates to:
  /// **'You can enable & send debug logs here. These have a bad impact on performance, so please don\'t enable them unless you\'re advised to do so. Disabling logging will delete the stored log.'**
  String get settingsDialogDebugInfo;

  /// Button to confirm mail creation after privacy disclaimer is shown.
  ///
  /// In en, this message translates to:
  /// **'Create Mail'**
  String get settingsDialogDebugMailCreate;

  /// Privacy disclaimer shown before sending logs
  ///
  /// In en, this message translates to:
  /// **'WARNING: A mail draft will open with the log file attached (in text format). The logs might contain sensitive information, such as the host name of your Firefly instance (though I try to avoid logging of any secrets, such as the api key). Please read through the log carefully and censor out any information you don\'t want to share and/or is not relevant to the problem you want to report.\n\nPlease do not send in logs without prior agreement via mail/GitHub to do so. I will delete any logs sent without context for privacy reasons. Never upload the log uncensored to GitHub or elsewhere.'**
  String get settingsDialogDebugMailDisclaimer;

  /// Button to send logs via E-Mail
  ///
  /// In en, this message translates to:
  /// **'Send Logs via Mail'**
  String get settingsDialogDebugSendButton;

  /// Dialog title: Debug Logs
  ///
  /// In en, this message translates to:
  /// **'Debug Logs'**
  String get settingsDialogDebugTitle;

  /// Dialog title: Select Language
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get settingsDialogLanguageTitle;

  /// Dialog title: Select theme
  ///
  /// In en, this message translates to:
  /// **'Select Theme'**
  String get settingsDialogThemeTitle;

  /// FAQ title
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get settingsFAQ;

  /// FAQ help text that explains that it opens up in a browser and is only available in English
  ///
  /// In en, this message translates to:
  /// **'Opens in Browser. Only available in English.'**
  String get settingsFAQHelp;

  /// Currently selected language
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// Setting if a lockscreen is shown (authentication is required on startup)
  ///
  /// In en, this message translates to:
  /// **'Lockscreen'**
  String get settingsLockscreen;

  /// Description for lockscreen setting
  ///
  /// In en, this message translates to:
  /// **'Require authentication on app startup'**
  String get settingsLockscreenHelp;

  /// Prompt to authenticate once to set up the lockscreen
  ///
  /// In en, this message translates to:
  /// **'Please authenticate to enable the lock screen.'**
  String get settingsLockscreenInitial;

  /// Description text for the notification listener service.
  ///
  /// In en, this message translates to:
  /// **'Turn supported push notifications into transactions. Add apps, configure how Waterfly reads their notifications, and review created transactions before enabling automation.'**
  String get settingsNLDescription;

  /// A requested permission was not granted.
  ///
  /// In en, this message translates to:
  /// **'Permission not granted.'**
  String get settingsNLPermissionNotGranted;

  /// Checking the status of the background service
  ///
  /// In en, this message translates to:
  /// **'Checking status…'**
  String get settingsNLServiceChecking;

  /// Title shown while checking notification listener readiness.
  ///
  /// In en, this message translates to:
  /// **'Checking notification access'**
  String get settingsNLServiceCheckingTitle;

  /// An error occurred while checking the service status
  ///
  /// In en, this message translates to:
  /// **'Error checking status: {error}'**
  String settingsNLServiceCheckingError(String error);

  /// Title shown when notification listener readiness cannot be checked.
  ///
  /// In en, this message translates to:
  /// **'Status unavailable'**
  String get settingsNLServiceUnavailableTitle;

  /// Title shown when notification listener access has not been granted.
  ///
  /// In en, this message translates to:
  /// **'Notification access needed'**
  String get settingsNLAccessNeededTitle;

  /// Description shown when notification listener access has not been granted.
  ///
  /// In en, this message translates to:
  /// **'Grant notification access so Waterfly can read supported notifications.'**
  String get settingsNLAccessNeededDescription;

  /// Title shown when notification listener access is enabled and running.
  ///
  /// In en, this message translates to:
  /// **'Notification access enabled'**
  String get settingsNLAccessEnabledTitle;

  /// Description shown when notification listener access is enabled and running.
  ///
  /// In en, this message translates to:
  /// **'Waterfly can listen for supported notifications.'**
  String get settingsNLAccessEnabledDescription;

  /// Title shown when notification access is granted but the listener service is stopped.
  ///
  /// In en, this message translates to:
  /// **'Listener service stopped'**
  String get settingsNLListenerStoppedTitle;

  /// Description shown when notification access is granted but the listener service is stopped.
  ///
  /// In en, this message translates to:
  /// **'Open Android notification access settings and re-enable Waterfly.'**
  String get settingsNLListenerStoppedDescription;

  /// A background service is running normally.
  ///
  /// In en, this message translates to:
  /// **'Service is running.'**
  String get settingsNLServiceRunning;

  /// Status of a background service.
  ///
  /// In en, this message translates to:
  /// **'Service Status'**
  String get settingsNLServiceStatus;

  /// A background service is stopped.
  ///
  /// In en, this message translates to:
  /// **'Service is stopped.'**
  String get settingsNLServiceStopped;

  /// Setting for the notification listener service.
  ///
  /// In en, this message translates to:
  /// **'Notification Listener Service'**
  String get settingsNotificationListener;

  /// Settings for the server connection
  ///
  /// In en, this message translates to:
  /// **'Server Connection'**
  String get settingsServerConnection;

  /// Server connection settings have been updated
  ///
  /// In en, this message translates to:
  /// **'Connection settings updated.'**
  String get settingsServerConnectionUpdated;

  /// Setting to (automatically) tag transactions
  ///
  /// In en, this message translates to:
  /// **'Tag Transactions'**
  String get settingsTag;

  /// Help text to automatically tag (all!) transactions
  ///
  /// In en, this message translates to:
  /// **'Automatically add a tag for all new transactions.'**
  String get settingsTagAllHelp;

  /// List of selected tags (for auto-tag feature). If no tags are selected, a help text will be shown instead.
  ///
  /// In en, this message translates to:
  /// **'Selected {count, plural, =1{tag: {tags}} other{tags: {tags}}}'**
  String settingsTagList(int count, String tags);

  /// Help text to automatically tag transactions from the notification listener
  ///
  /// In en, this message translates to:
  /// **'Automatically add a tag for transactions created from the listener.'**
  String get settingsTagNLHelp;

  /// App theme (dark or light)
  ///
  /// In en, this message translates to:
  /// **'App Theme'**
  String get settingsTheme;

  /// Material You Dynamic Colors feature
  ///
  /// In en, this message translates to:
  /// **'Dynamic Colors'**
  String get settingsThemeDynamicColors;

  /// Currently selected theme (either dark, light or system)
  ///
  /// In en, this message translates to:
  /// **'{theme, select, dark{Dark Mode} light{Light Mode} other{System Default}}'**
  String settingsThemeValue(String theme);

  /// Setting label to use server timezone.
  ///
  /// In en, this message translates to:
  /// **'Use server timezone'**
  String get settingsUseServerTimezone;

  /// Help text for the server timezone setting. Basically, if enabled, all times shown in the app match the time shown in the webinterface (which is always in the 'home' timezone). Please try to keep the translation short (max 3 lines).
  ///
  /// In en, this message translates to:
  /// **'Show all times in the server timezone. This mimics the behavior of the webinterface.'**
  String get settingsUseServerTimezoneHelp;

  /// Current App Version
  ///
  /// In en, this message translates to:
  /// **'App Version'**
  String get settingsVersion;

  /// Shown while checking for app version
  ///
  /// In en, this message translates to:
  /// **'checking…'**
  String get settingsVersionChecking;

  /// Placeholder when no tag has been set.
  ///
  /// In en, this message translates to:
  /// **'<no tag>'**
  String get tagNone;

  /// Button Label: Attachments
  ///
  /// In en, this message translates to:
  /// **'Attachments'**
  String get transactionAttachments;

  /// Confirmation text to delete transaction
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this transaction?'**
  String get transactionDeleteConfirm;

  /// Button Label: Delete Attachment
  ///
  /// In en, this message translates to:
  /// **'Delete Attachment'**
  String get transactionDialogAttachmentsDelete;

  /// Confirmation text to delete attachment
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this attachment?'**
  String get transactionDialogAttachmentsDeleteConfirm;

  /// Snackbar Text: File download failed.
  ///
  /// In en, this message translates to:
  /// **'Could not download file.'**
  String get transactionDialogAttachmentsErrorDownload;

  /// Snackbar Text: File could not be opened, with reason.
  ///
  /// In en, this message translates to:
  /// **'Could not open file: {error}'**
  String transactionDialogAttachmentsErrorOpen(String error);

  /// Snackbar Text: File could not be uploaded, with reason.
  ///
  /// In en, this message translates to:
  /// **'Could not upload file: {error}'**
  String transactionDialogAttachmentsErrorUpload(String error);

  /// Dialog Title: Attachments Dialog
  ///
  /// In en, this message translates to:
  /// **'Attachments'**
  String get transactionDialogAttachmentsTitle;

  /// Button Label: no subscription to be used
  ///
  /// In en, this message translates to:
  /// **'No subscription'**
  String get transactionDialogBillNoBill;

  /// Dialog Title: Link Subscription to transaction
  ///
  /// In en, this message translates to:
  /// **'Link to Subscription'**
  String get transactionDialogBillTitle;

  /// Dialog Title: Currency Selection
  ///
  /// In en, this message translates to:
  /// **'Select currency'**
  String get transactionDialogCurrencyTitle;

  /// Button Label: no piggy bank to be used
  ///
  /// In en, this message translates to:
  /// **'No Piggy Bank'**
  String get transactionDialogPiggyNoPiggy;

  /// Dialog Title: Link transaction to piggy bank
  ///
  /// In en, this message translates to:
  /// **'Link to Piggy Bank'**
  String get transactionDialogPiggyTitle;

  /// Button Label: Add Tag
  ///
  /// In en, this message translates to:
  /// **'Add Tag'**
  String get transactionDialogTagsAdd;

  /// Hint Text for search tag field
  ///
  /// In en, this message translates to:
  /// **'Search/Add Tag'**
  String get transactionDialogTagsHint;

  /// Dialog Title: Select Tags
  ///
  /// In en, this message translates to:
  /// **'Select tags'**
  String get transactionDialogTagsTitle;

  /// Menu Label: Duplicate item
  ///
  /// In en, this message translates to:
  /// **'Duplicate'**
  String get transactionDuplicate;

  /// Transaction Save Error: Invalid account
  ///
  /// In en, this message translates to:
  /// **'Invalid Account'**
  String get transactionErrorInvalidAccount;

  /// Transaction Save Error: Invalid budget
  ///
  /// In en, this message translates to:
  /// **'Invalid Budget'**
  String get transactionErrorInvalidBudget;

  /// Transaction Save Error: No accounts have been entered
  ///
  /// In en, this message translates to:
  /// **'Please fill in the accounts first.'**
  String get transactionErrorNoAccounts;

  /// Transaction Save Error: No account is an asset (own) account
  ///
  /// In en, this message translates to:
  /// **'Please select an asset account.'**
  String get transactionErrorNoAssetAccount;

  /// Transaction Save Error: No title provided
  ///
  /// In en, this message translates to:
  /// **'Please provide a title.'**
  String get transactionErrorTitle;

  /// Transaction Form: Label for destination account for transfer transaction
  ///
  /// In en, this message translates to:
  /// **'Destination account'**
  String get transactionFormLabelAccountDestination;

  /// Transaction Form: Label for foreign (other) account
  ///
  /// In en, this message translates to:
  /// **'Foreign account'**
  String get transactionFormLabelAccountForeign;

  /// Transaction Form: Label for own account
  ///
  /// In en, this message translates to:
  /// **'Own account'**
  String get transactionFormLabelAccountOwn;

  /// Transaction Form: Label for source account for transfer transaction
  ///
  /// In en, this message translates to:
  /// **'Source account'**
  String get transactionFormLabelAccountSource;

  /// Transaction Form: Label for notes field
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get transactionFormLabelNotes;

  /// Transaction Form: Label for tags field
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get transactionFormLabelTags;

  /// Transaction Form: Label for title field
  ///
  /// In en, this message translates to:
  /// **'Transaction Title'**
  String get transactionFormLabelTitle;

  /// Button Label: Add a split
  ///
  /// In en, this message translates to:
  /// **'Add split transaction'**
  String get transactionSplitAdd;

  /// Hint Text: Change currency for a single split
  ///
  /// In en, this message translates to:
  /// **'Change Split Currency'**
  String get transactionSplitChangeCurrency;

  /// Hint Text: Change destination account for a single split
  ///
  /// In en, this message translates to:
  /// **'Change Split Destination Account'**
  String get transactionSplitChangeDestinationAccount;

  /// Hint Text: Change source account for a single split
  ///
  /// In en, this message translates to:
  /// **'Change Split Source Account'**
  String get transactionSplitChangeSourceAccount;

  /// Hint Text: Change target account for single split
  ///
  /// In en, this message translates to:
  /// **'Change Split Target Account'**
  String get transactionSplitChangeTarget;

  /// Hint Text: Delete single split
  ///
  /// In en, this message translates to:
  /// **'Delete split'**
  String get transactionSplitDelete;

  /// Title: Add a new transaction
  ///
  /// In en, this message translates to:
  /// **'Add Transaction'**
  String get transactionTitleAdd;

  /// Title: Delete existing transaction
  ///
  /// In en, this message translates to:
  /// **'Delete Transaction'**
  String get transactionTitleDelete;

  /// Title: Edit existing transaction
  ///
  /// In en, this message translates to:
  /// **'Edit Transaction'**
  String get transactionTitleEdit;

  /// Deposit transaction type
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get transactionTypeDeposit;

  /// Transfer transaction type
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get transactionTypeTransfer;

  /// Withdrawal transaction type
  ///
  /// In en, this message translates to:
  /// **'Withdrawal'**
  String get transactionTypeWithdrawal;

  /// Number of actions configured for a notification rule.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No actions} =1{1 action} other{{count} actions}}'**
  String notificationsRuleActionCount(int count);

  /// Title of the applicability conditions section in a notification rule.
  ///
  /// In en, this message translates to:
  /// **'Applies when'**
  String get notificationsRuleAppliesWhenTitle;

  /// Description of first-match behavior in the rule applicability section.
  ///
  /// In en, this message translates to:
  /// **'Rules are checked from top to bottom. This rule is selected when every condition below matches.'**
  String get notificationsRuleAppliesWhenDescription;

  /// Empty state for a rule without applicability conditions.
  ///
  /// In en, this message translates to:
  /// **'No conditions: this rule always matches.'**
  String get notificationsRuleAlwaysMatches;

  /// Title of actions that always run for a selected notification rule.
  ///
  /// In en, this message translates to:
  /// **'Always executed actions'**
  String get notificationsRuleAlwaysActionsTitle;

  /// Description of the actions that always run for a selected notification rule.
  ///
  /// In en, this message translates to:
  /// **'Run whenever this rule is selected, before matching conditional actions.'**
  String get notificationsRuleAlwaysActionsDescription;

  /// Title of the conditional action groups section.
  ///
  /// In en, this message translates to:
  /// **'Conditional actions'**
  String get notificationsRuleConditionalActionsTitle;

  /// Description of conditional action group ordering and override behavior.
  ///
  /// In en, this message translates to:
  /// **'Every matching group runs from top to bottom. Later values override earlier ones.'**
  String get notificationsRuleConditionalActionsDescription;

  /// Empty state for a rule without conditional action groups.
  ///
  /// In en, this message translates to:
  /// **'No conditional actions'**
  String get notificationsRuleNoConditionalActions;

  /// Button label for adding a conditional action group.
  ///
  /// In en, this message translates to:
  /// **'Add conditional action'**
  String get notificationsRuleAddConditionalActions;

  /// Label for the conditional action name field.
  ///
  /// In en, this message translates to:
  /// **'Conditional action name'**
  String get notificationsRuleConditionalActionName;

  /// Description shown before creating a conditional action.
  ///
  /// In en, this message translates to:
  /// **'Give this conditional action a clear name.'**
  String get notificationsRuleNameConditionalActionDescription;

  /// Tooltip for a conditional action options menu.
  ///
  /// In en, this message translates to:
  /// **'Conditional action options'**
  String get notificationsRuleConditionalActionOptions;

  /// Title for the rename conditional action dialog.
  ///
  /// In en, this message translates to:
  /// **'Rename conditional action'**
  String get notificationsRuleRenameConditionalActionTitle;

  /// Description for the rename conditional action dialog.
  ///
  /// In en, this message translates to:
  /// **'Choose a name that describes when these actions run.'**
  String get notificationsRuleRenameConditionalActionDescription;

  /// Title for the conditional action removal confirmation dialog.
  ///
  /// In en, this message translates to:
  /// **'Remove conditional action?'**
  String get notificationsRuleRemoveConditionalActionTitle;

  /// Description for the conditional action removal confirmation dialog.
  ///
  /// In en, this message translates to:
  /// **'\"{name}\" and all of its conditions and actions will be removed.'**
  String notificationsRuleRemoveConditionalActionDescription(String name);

  /// Title of the conditions section in a conditional action group.
  ///
  /// In en, this message translates to:
  /// **'Applies when'**
  String get notificationsRuleConditionalGroupWhenTitle;

  /// Description of conditions in a conditional action group.
  ///
  /// In en, this message translates to:
  /// **'This group runs when every condition below matches the notification or extracted values.'**
  String get notificationsRuleConditionalGroupWhenDescription;

  /// Empty state for a conditional action group without conditions.
  ///
  /// In en, this message translates to:
  /// **'No conditions defined. This conditional action will not run.'**
  String get notificationsRuleConditionalGroupNoConditions;

  /// Empty state for a conditional action group without actions.
  ///
  /// In en, this message translates to:
  /// **'No actions defined. This conditional action will not change the transaction.'**
  String get notificationsRuleConditionalGroupNoActions;

  /// Status message shown when a conditional action group has no conditions.
  ///
  /// In en, this message translates to:
  /// **'Add at least one condition so this conditional action only runs when it should.'**
  String get notificationsRuleConditionalGroupNeedsConditionsMessage;

  /// Status message shown when a conditional action group has no actions.
  ///
  /// In en, this message translates to:
  /// **'Add at least one action so this conditional action can change the transaction.'**
  String get notificationsRuleConditionalGroupNeedsActionsMessage;

  /// Description of the custom notification rule actions section.
  ///
  /// In en, this message translates to:
  /// **'Choose which transaction fields this rule sets when its conditions match.'**
  String get notificationsRuleActionsDescription;

  /// Title of the custom notification rule actions section.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get notificationsRuleActionsTitle;

  /// Button label for adding a notification rule condition.
  ///
  /// In en, this message translates to:
  /// **'Add condition'**
  String get notificationsRuleAddCondition;

  /// Number of conditions configured for a notification rule.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No conditions} =1{1 condition} other{{count} conditions}}'**
  String notificationsRuleConditionCount(int count);

  /// Custom extractor capture used by a condition.
  ///
  /// In en, this message translates to:
  /// **'Capture: {capture}'**
  String notificationsRuleConditionCapture(String capture);

  /// Custom extractor captures used by a condition.
  ///
  /// In en, this message translates to:
  /// **'Captures: {captures}'**
  String notificationsRuleConditionCaptures(String captures);

  /// Compact test result for a matching condition.
  ///
  /// In en, this message translates to:
  /// **'Matches'**
  String get notificationsRuleMatches;

  /// Compact test result for a non-matching condition.
  ///
  /// In en, this message translates to:
  /// **'Does not match'**
  String get notificationsRuleDoesNotMatch;

  /// Compact test result when a condition operand could not be resolved.
  ///
  /// In en, this message translates to:
  /// **'Could not evaluate'**
  String get notificationsRuleCouldNotEvaluate;

  /// Label for a resolved condition operand in test mode.
  ///
  /// In en, this message translates to:
  /// **'Sample value: '**
  String get notificationsRuleSampleValueLabel;

  /// Label for the left condition operand in test mode.
  ///
  /// In en, this message translates to:
  /// **'Left value: '**
  String get notificationsRuleLeftSampleValueLabel;

  /// Label for the right condition operand in test mode.
  ///
  /// In en, this message translates to:
  /// **'Right value: '**
  String get notificationsRuleRightSampleValueLabel;

  /// Test-mode summary of matching child conditions.
  ///
  /// In en, this message translates to:
  /// **'{matched} of {total} match'**
  String notificationsRuleConditionMatchSummary(int matched, int total);

  /// Test-mode summary of child conditions with unresolved operands.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 could not be evaluated} other{{count} could not be evaluated}}'**
  String notificationsRuleConditionUnresolvedSummary(int count);

  /// Test-mode result of the condition nested inside a NOT group.
  ///
  /// In en, this message translates to:
  /// **'Nested condition: {result}'**
  String notificationsRuleNestedConditionResult(String result);

  /// Description of the notification rule conditions section.
  ///
  /// In en, this message translates to:
  /// **'This rule runs only when every condition matches.'**
  String get notificationsRuleConditionsDescription;

  /// Title of the notification rule conditions section.
  ///
  /// In en, this message translates to:
  /// **'Conditions'**
  String get notificationsRuleConditionsTitle;

  /// Button and menu label for deleting a notification rule.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get notificationsRuleDelete;

  /// Description in the notification rule deletion confirmation dialog.
  ///
  /// In en, this message translates to:
  /// **'This rule, including its conditions and actions, will be removed.'**
  String get notificationsRuleDeleteDescription;

  /// Title of the notification rule deletion confirmation dialog.
  ///
  /// In en, this message translates to:
  /// **'Delete rule?'**
  String get notificationsRuleDeleteTitle;

  /// Tooltip for editing the notification sample in test mode.
  ///
  /// In en, this message translates to:
  /// **'Edit test notification'**
  String get notificationsRuleEditTestNotification;

  /// Tooltip for enabling notification rule test mode.
  ///
  /// In en, this message translates to:
  /// **'Enter test mode'**
  String get notificationsRuleEnterTestMode;

  /// Tooltip for disabling notification rule test mode.
  ///
  /// In en, this message translates to:
  /// **'Exit test mode'**
  String get notificationsRuleExitTestMode;

  /// Status label for a notification rule requiring additional setup.
  ///
  /// In en, this message translates to:
  /// **'Needs setup'**
  String get notificationsRuleNeedsSetup;

  /// Message explaining that a notification rule is incomplete.
  ///
  /// In en, this message translates to:
  /// **'Complete or fix the rule\'s actions before it can produce a valid transaction.'**
  String get notificationsRuleNeedsSetupMessage;

  /// Empty state for a notification rule without actions.
  ///
  /// In en, this message translates to:
  /// **'No actions defined.'**
  String get notificationsRuleNoActions;

  /// Empty state for a notification rule without conditions.
  ///
  /// In en, this message translates to:
  /// **'No conditions: this rule always runs.'**
  String get notificationsRuleNoConditions;

  /// Tooltip for the notification rule options menu.
  ///
  /// In en, this message translates to:
  /// **'Rule options'**
  String get notificationsRuleOptions;

  /// Description of the predefined notification rule mappings section.
  ///
  /// In en, this message translates to:
  /// **'Review how notification values fill transaction fields. Firefly-linked fields, such as currency, can use existing Firefly entries.'**
  String get notificationsRulePredefinedActionsDescription;

  /// Confirmation button label for removing a notification rule item.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get notificationsRuleRemove;

  /// Description in the notification rule action removal confirmation dialog.
  ///
  /// In en, this message translates to:
  /// **'This action will no longer set a transaction field when \"{name}\" runs.'**
  String notificationsRuleRemoveActionDescription(String name);

  /// Title of the notification rule action removal confirmation dialog.
  ///
  /// In en, this message translates to:
  /// **'Remove action?'**
  String get notificationsRuleRemoveActionTitle;

  /// Description in the notification rule condition removal confirmation dialog.
  ///
  /// In en, this message translates to:
  /// **'This condition will no longer control when \"{name}\" runs.'**
  String notificationsRuleRemoveConditionDescription(String name);

  /// Title of the notification rule condition removal confirmation dialog.
  ///
  /// In en, this message translates to:
  /// **'Remove condition?'**
  String get notificationsRuleRemoveConditionTitle;

  /// Menu label for renaming a notification rule.
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get notificationsRuleRename;

  /// Status label for a notification rule that needs review.
  ///
  /// In en, this message translates to:
  /// **'Needs review'**
  String get notificationsRuleNeedsReview;

  /// Message explaining that predefined rule mappings require review.
  ///
  /// In en, this message translates to:
  /// **'Review the suggested transaction field mappings before using this rule.'**
  String get notificationsRuleNeedsReviewMessage;

  /// Warning when a rule contains a conditional action without both conditions and actions.
  ///
  /// In en, this message translates to:
  /// **'Review conditional actions marked Needs review and any suggested field mappings before using this rule.'**
  String get notificationsConditionalActionsNeedReviewMessage;

  /// Informational message displayed while a notification rule is in test mode.
  ///
  /// In en, this message translates to:
  /// **'Values and availability below are evaluated against the current sample notification.'**
  String get notificationsRuleTestModeMessage;

  /// Heading for the notification rule test sample.
  ///
  /// In en, this message translates to:
  /// **'Sample notification'**
  String get notificationsRuleSampleNotification;

  /// Description of why a rule can override the definition sample.
  ///
  /// In en, this message translates to:
  /// **'Fine-tune the sample for this rule while keeping the definition sample available throughout the definition.'**
  String get notificationsRuleSampleDescription;

  /// Description of why a conditional action can use a more focused sample.
  ///
  /// In en, this message translates to:
  /// **'Fine-tune the sample for this conditional action while keeping the rule sample available to the rest of the rule.'**
  String get notificationsConditionalActionSampleDescription;

  /// Tooltip for clearing a sample override and returning to the definition sample.
  ///
  /// In en, this message translates to:
  /// **'Use definition sample'**
  String get notificationsUseDefinitionSample;

  /// Tooltip for clearing a conditional action sample override and returning to the rule sample.
  ///
  /// In en, this message translates to:
  /// **'Use rule sample'**
  String get notificationsUseRuleSample;

  /// Button label for adding an action to a notification rule.
  ///
  /// In en, this message translates to:
  /// **'Add action'**
  String get notificationsRuleAddAction;

  /// Label indicating that a notification rule is in test mode.
  ///
  /// In en, this message translates to:
  /// **'Test mode'**
  String get notificationsRuleTestMode;

  /// Title of the predefined notification rule mappings section.
  ///
  /// In en, this message translates to:
  /// **'Transaction details'**
  String get notificationsRuleTransactionDetails;

  /// Tooltip for a notification rule action options menu.
  ///
  /// In en, this message translates to:
  /// **'Action options'**
  String get notificationsRuleActionOptions;

  /// Button and dialog title for adding an optional predefined field.
  ///
  /// In en, this message translates to:
  /// **'Add optional field'**
  String get notificationsRuleAddOptionalField;

  /// Tooltip for adding tags to a notification rule action.
  ///
  /// In en, this message translates to:
  /// **'Add tag(s)'**
  String get notificationsRuleAddTags;

  /// Heading for editable predefined notification rule mappings.
  ///
  /// In en, this message translates to:
  /// **'Adjustable mappings'**
  String get notificationsRuleAdjustableMappings;

  /// Description of editable predefined notification rule mappings.
  ///
  /// In en, this message translates to:
  /// **'Review editable mappings and add optional fields before marking the rule complete.'**
  String get notificationsRuleAdjustableMappingsDescription;

  /// Label for a group where every notification condition must match.
  ///
  /// In en, this message translates to:
  /// **'All conditions match'**
  String get notificationsRuleAllConditionsMatch;

  /// Description for an optional predefined field already configured.
  ///
  /// In en, this message translates to:
  /// **'Already added.'**
  String get notificationsRuleAlreadyAdded;

  /// Label for a group where any notification condition can match.
  ///
  /// In en, this message translates to:
  /// **'Any condition matches'**
  String get notificationsRuleAnyConditionMatches;

  /// Error asking the user to choose one regular expression match for a notification rule action.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No matches are available from \"{extractor}\".} =1{Choose the match from \"{extractor}\".} other{Choose one of the {count} matches from \"{extractor}\".}}'**
  String notificationsRuleChooseExtractorMatch(int count, String extractor);

  /// Error stating that a predefined currency action needs a mapped Firefly currency.
  ///
  /// In en, this message translates to:
  /// **'Choose a matching Firefly currency.'**
  String get notificationsRuleChooseMatchingCurrency;

  /// Snackbar shown when a currency mapping cannot be marked as reviewed.
  ///
  /// In en, this message translates to:
  /// **'Choose a matching Firefly currency before marking this mapping as done.'**
  String get notificationsRuleChooseMatchingCurrencyBeforeReview;

  /// Label for a negated notification condition.
  ///
  /// In en, this message translates to:
  /// **'Condition does not match'**
  String get notificationsRuleConditionDoesNotMatch;

  /// Tooltip for a notification rule condition options menu.
  ///
  /// In en, this message translates to:
  /// **'Condition options'**
  String get notificationsRuleConditionOptions;

  /// Error explaining that an action references a deleted extractor.
  ///
  /// In en, this message translates to:
  /// **'The extractor used by \"{name}\" was deleted.'**
  String notificationsRuleDeletedCaptureExtractor(String name);

  /// Fallback extractor name when an action references a deleted extractor.
  ///
  /// In en, this message translates to:
  /// **'Deleted extractor'**
  String get notificationsRuleDeletedExtractor;

  /// Tooltip for deleting a notification condition.
  ///
  /// In en, this message translates to:
  /// **'Delete condition'**
  String get notificationsRuleDeleteCondition;

  /// Menu label for editing a notification rule item.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get notificationsRuleEdit;

  /// Menu label for duplicating a notification condition.
  ///
  /// In en, this message translates to:
  /// **'Duplicate'**
  String get notificationsRuleDuplicate;

  /// Menu label for copying a notification condition.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get notificationsRuleCopy;

  /// Heading shown while choosing a destination for a copied condition.
  ///
  /// In en, this message translates to:
  /// **'Copying condition'**
  String get notificationsRuleCopyingCondition;

  /// Confirmation title when leaving during a pending condition copy.
  ///
  /// In en, this message translates to:
  /// **'Leave while copying a condition?'**
  String get notificationsRuleLeaveCopyingConditionTitle;

  /// Confirmation text when leaving during a pending condition copy.
  ///
  /// In en, this message translates to:
  /// **'The copy hasn\'t been pasted. Leaving will cancel it.'**
  String get notificationsRuleLeaveCopyingConditionDescription;

  /// Confirmation text when leaving during a pending condition copy with unsaved changes.
  ///
  /// In en, this message translates to:
  /// **'The copy hasn\'t been pasted. Leaving will cancel it and discard your unsaved changes.'**
  String get notificationsRuleLeaveCopyingConditionDirty;

  /// Confirmation title when leaving during a pending condition move.
  ///
  /// In en, this message translates to:
  /// **'Leave while moving a condition?'**
  String get notificationsRuleLeaveMovingConditionTitle;

  /// Confirmation text when leaving during a pending condition move.
  ///
  /// In en, this message translates to:
  /// **'The condition hasn\'t been moved. Leaving will cancel the move.'**
  String get notificationsRuleLeaveMovingConditionDescription;

  /// Confirmation text when leaving during a pending condition move with unsaved changes.
  ///
  /// In en, this message translates to:
  /// **'The condition hasn\'t been moved. Leaving will cancel the move and discard your unsaved changes.'**
  String get notificationsRuleLeaveMovingConditionDirty;

  /// Button confirming navigation away during a pending condition copy or move.
  ///
  /// In en, this message translates to:
  /// **'Leave page'**
  String get notificationsRuleLeavePage;

  /// Button retaining the editor and pending condition copy or move.
  ///
  /// In en, this message translates to:
  /// **'Stay here'**
  String get notificationsRuleStayHere;

  /// Menu label for moving a notification condition to another condition group.
  ///
  /// In en, this message translates to:
  /// **'Move'**
  String get notificationsRuleMove;

  /// Heading shown while choosing a destination for a condition being moved.
  ///
  /// In en, this message translates to:
  /// **'Moving condition'**
  String get notificationsRuleMovingCondition;

  /// Instruction shown while choosing where to move a condition.
  ///
  /// In en, this message translates to:
  /// **'Select a destination.'**
  String get notificationsRuleSelectMoveDestination;

  /// Button that moves a condition into a selected condition group.
  ///
  /// In en, this message translates to:
  /// **'Move here'**
  String get notificationsRuleMoveHere;

  /// Menu label for pasting a copied notification condition.
  ///
  /// In en, this message translates to:
  /// **'Paste'**
  String get notificationsRulePaste;

  /// Button for pasting a copied condition into the rule's top-level condition list.
  ///
  /// In en, this message translates to:
  /// **'Paste here'**
  String get notificationsRulePasteHere;

  /// Tooltip for editing a predefined currency mapping.
  ///
  /// In en, this message translates to:
  /// **'Edit currency mapping'**
  String get notificationsRuleEditCurrencyMapping;

  /// Heading for immutable predefined notification rule mappings.
  ///
  /// In en, this message translates to:
  /// **'Fixed mappings'**
  String get notificationsRuleFixedMappings;

  /// Description of immutable predefined notification rule mappings.
  ///
  /// In en, this message translates to:
  /// **'These mappings are managed by Basic mode and cannot be edited here.'**
  String get notificationsRuleFixedMappingsDescription;

  /// Tooltip for marking a predefined mapping as reviewed.
  ///
  /// In en, this message translates to:
  /// **'Mark mapping as done'**
  String get notificationsRuleMarkMappingDone;

  /// Tooltip for marking a predefined mapping as needing review.
  ///
  /// In en, this message translates to:
  /// **'Mark mapping as needing review'**
  String get notificationsRuleMarkMappingNeedsReview;

  /// Title of the section listing unresolved values required by a rule.
  ///
  /// In en, this message translates to:
  /// **'Sample value issues'**
  String get notificationsRuleSampleValueIssuesTitle;

  /// Description of unresolved sample value diagnostics.
  ///
  /// In en, this message translates to:
  /// **'These values are required by this rule or its inherited actions but could not be resolved from the sample notification.'**
  String get notificationsRuleSampleValueIssuesDescription;

  /// Label for a sample value issue introduced by a shared action.
  ///
  /// In en, this message translates to:
  /// **'Inherited from shared actions'**
  String get notificationsRuleInheritedFromSharedActions;

  /// Diagnostic shown when a rule references a deleted extractor.
  ///
  /// In en, this message translates to:
  /// **'The required extractor no longer exists.'**
  String get notificationsRuleMissingRequiredExtractor;

  /// Title for a sample value issue caused by a deleted extractor.
  ///
  /// In en, this message translates to:
  /// **'Missing extractor'**
  String get notificationsRuleMissingExtractorTitle;

  /// Diagnostic listing captures that did not resolve from the sample.
  ///
  /// In en, this message translates to:
  /// **'No sample value was captured for: {names}.'**
  String notificationsRuleMissingCaptureValues(String names);

  /// Error explaining that a capture has no value in the notification test sample.
  ///
  /// In en, this message translates to:
  /// **'No value captured from \"{name}\" in the sample.'**
  String notificationsRuleNoCapturedValue(String name);

  /// Tooltip for removing an optional predefined mapping.
  ///
  /// In en, this message translates to:
  /// **'Remove optional mapping'**
  String get notificationsRuleRemoveOptionalMapping;

  /// Number of tags configured for a notification rule action.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No tags selected} =1{1 tag selected} other{{count} tags selected}}'**
  String notificationsRuleSelectedTagCount(int count);

  /// Title for an action that sets transaction tags.
  ///
  /// In en, this message translates to:
  /// **'Set transaction tags'**
  String get notificationsRuleSetTransactionTags;

  /// Error shown for an unrecognized notification rule action.
  ///
  /// In en, this message translates to:
  /// **'Unsupported action.'**
  String get notificationsRuleUnsupportedAction;

  /// Status label for a notification definition that is ready to use.
  ///
  /// In en, this message translates to:
  /// **'Ready'**
  String get notificationsDefinitionReady;

  /// Snackbar message when deleting a notification definition fails.
  ///
  /// In en, this message translates to:
  /// **'The application registration could not be deleted.'**
  String get notificationsDefinitionDeleteFailure;

  /// Button and menu label for deleting a notification definition.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get notificationsDefinitionDelete;

  /// Save error for actions referencing deleted extractors.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No actions reference deleted extractors.} =1{Fix the action that references a deleted extractor before saving.} other{Fix {count} actions that reference deleted extractors before saving.}}'**
  String notificationsDefinitionFixDanglingActions(int count);

  /// Status label for a notification definition requiring additional setup.
  ///
  /// In en, this message translates to:
  /// **'Needs setup'**
  String get notificationsDefinitionNeedsSetup;

  /// Message explaining that a notification definition is incomplete.
  ///
  /// In en, this message translates to:
  /// **'Complete the sample, extractors, rules, and required actions before this application can process notifications.'**
  String get notificationsDefinitionNeedsSetupMessage;

  /// Context-aware message explaining the specific notification definition setup requirements that are incomplete.
  ///
  /// In en, this message translates to:
  /// **'Finish setting up {requirements} before this application can process notifications.'**
  String notificationsDefinitionNeedsSetupSpecificMessage(String requirements);

  /// Requirement phrase for a notification definition missing a sample notification.
  ///
  /// In en, this message translates to:
  /// **'a sample notification'**
  String get notificationsDefinitionSetupRequirementSample;

  /// Requirement phrase for a notification definition missing extractors.
  ///
  /// In en, this message translates to:
  /// **'at least one extractor'**
  String get notificationsDefinitionSetupRequirementExtractors;

  /// Requirement phrase for a notification definition missing both rules and shared actions.
  ///
  /// In en, this message translates to:
  /// **'at least one rule or shared action'**
  String get notificationsDefinitionSetupRequirementRulesOrActions;

  /// Requirement phrase for notification actions with unresolved required transaction fields.
  ///
  /// In en, this message translates to:
  /// **'required transaction fields'**
  String get notificationsDefinitionSetupRequirementActionFields;

  /// Formats a two-item inline list.
  ///
  /// In en, this message translates to:
  /// **'{first} and {second}'**
  String notificationsListPair(String first, String second);

  /// Formats the final item of an inline list with three or more entries.
  ///
  /// In en, this message translates to:
  /// **'{leading}, and {last}'**
  String notificationsListMultiple(String leading, String last);

  /// Tooltip for the notification definition options menu.
  ///
  /// In en, this message translates to:
  /// **'Definition options'**
  String get notificationsDefinitionOptions;

  /// Status label for a notification definition that needs review.
  ///
  /// In en, this message translates to:
  /// **'Needs review'**
  String get notificationsDefinitionNeedsReview;

  /// Message explaining that predefined notification mappings require review.
  ///
  /// In en, this message translates to:
  /// **'Review the suggested transaction field mappings before using this application.'**
  String get notificationsDefinitionNeedsReviewMessage;

  /// Warning when an application's rules contain conditional actions without both conditions and actions.
  ///
  /// In en, this message translates to:
  /// **'Review conditional actions marked Needs review and any suggested field mappings before using this application.'**
  String get notificationsDefinitionConditionalActionsNeedReviewMessage;

  /// Status title on a registered application card with outstanding migration issues.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Imported setup needs attention} other{Imported setup needs attention · {count} issues}}'**
  String notificationsDefinitionMigrationNeedsAttention(int count);

  /// Fallback registered-application card message for a failed migration without a structured reason.
  ///
  /// In en, this message translates to:
  /// **'Waterfly could not finish importing the previous notification settings.'**
  String get notificationsDefinitionMigrationFailedMessage;

  /// Fallback registered-application card message for an older migration alert without a structured reason.
  ///
  /// In en, this message translates to:
  /// **'Review the imported notification settings before using this application.'**
  String get notificationsDefinitionMigrationReviewMessage;

  /// Action hint on a registered application card with outstanding migration issues.
  ///
  /// In en, this message translates to:
  /// **'Open this setup to resolve the migration issues.'**
  String get notificationsDefinitionMigrationOpenSetupHint;

  /// Message explaining that notification processing has not been configured.
  ///
  /// In en, this message translates to:
  /// **'Choose how Waterfly should read this application\'s notifications.'**
  String get notificationsDefinitionNotConfiguredMessage;

  /// Description of the notification definition sample.
  ///
  /// In en, this message translates to:
  /// **'Use one representative notification to preview extractors and rules. Individual extractors and rules can use separate test samples.'**
  String get notificationsDefinitionSampleDescription;

  /// Label for the editable timestamp of a sample notification.
  ///
  /// In en, this message translates to:
  /// **'Sample time'**
  String get notificationsSampleTimestamp;

  /// Heading for the notification definition sample.
  ///
  /// In en, this message translates to:
  /// **'Sample notification'**
  String get notificationsDefinitionSampleNotification;

  /// Tooltip for saving a notification definition.
  ///
  /// In en, this message translates to:
  /// **'Save definition'**
  String get notificationsDefinitionSave;

  /// Snackbar message when saving a notification definition fails.
  ///
  /// In en, this message translates to:
  /// **'The notification definition could not be saved.'**
  String get notificationsDefinitionSaveFailure;

  /// Confirmation dialog title when leaving a notification editor with unsaved changes.
  ///
  /// In en, this message translates to:
  /// **'Discard changes?'**
  String get notificationsDiscardChangesTitle;

  /// Confirmation dialog description when leaving a notification editor with unsaved changes.
  ///
  /// In en, this message translates to:
  /// **'Your unsaved changes will be lost.'**
  String get notificationsDiscardChangesDescription;

  /// Confirmation button label for discarding unsaved notification editor changes.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get notificationsDiscard;

  /// Status label for a notification definition that has not been configured.
  ///
  /// In en, this message translates to:
  /// **'Not configured'**
  String get notificationsDefinitionNotConfigured;

  /// Confirmation button label for changing notification definition setup mode.
  ///
  /// In en, this message translates to:
  /// **'Convert'**
  String get notificationsDefinitionConvert;

  /// Menu label for changing a notification definition to advanced setup.
  ///
  /// In en, this message translates to:
  /// **'Convert to advanced'**
  String get notificationsDefinitionConvertToAdvanced;

  /// Description for converting a notification definition to advanced setup.
  ///
  /// In en, this message translates to:
  /// **'Your existing extractors and rules will be kept and can be edited in Advanced mode.'**
  String get notificationsDefinitionConvertToAdvancedDescription;

  /// Confirmation dialog title for converting a notification definition to advanced setup.
  ///
  /// In en, this message translates to:
  /// **'Convert to advanced?'**
  String get notificationsDefinitionConvertToAdvancedTitle;

  /// Menu label for changing a notification definition to basic setup.
  ///
  /// In en, this message translates to:
  /// **'Convert to basic'**
  String get notificationsDefinitionConvertToBasic;

  /// Description for converting a notification definition to basic setup.
  ///
  /// In en, this message translates to:
  /// **'Your custom extractors and rules will be replaced with the standard transaction fields and rule used by Basic mode.'**
  String get notificationsDefinitionConvertToBasicDescription;

  /// Confirmation dialog title for converting a notification definition to basic setup.
  ///
  /// In en, this message translates to:
  /// **'Convert to basic?'**
  String get notificationsDefinitionConvertToBasicTitle;

  /// Tooltip for adding a notification application registration.
  ///
  /// In en, this message translates to:
  /// **'Add application'**
  String get notificationsDefinitionsAddApplication;

  /// Title for selecting the installed application that owns an imported notification definition.
  ///
  /// In en, this message translates to:
  /// **'Choose application'**
  String get notificationsApplicationsRecoverTitle;

  /// Explanation shown when recovering an imported notification definition with unavailable application identity.
  ///
  /// In en, this message translates to:
  /// **'Waterfly could not identify the application associated with these imported settings. Choose the installed application that should use this configuration.'**
  String get notificationsApplicationsRecoverDescription;

  /// Description in the notification application registration deletion dialog.
  ///
  /// In en, this message translates to:
  /// **'{name} will no longer process notifications.'**
  String notificationsDefinitionsDeleteDescription(String name);

  /// Title of the notification application registration deletion dialog.
  ///
  /// In en, this message translates to:
  /// **'Delete application registration?'**
  String get notificationsDefinitionsDeleteTitle;

  /// Snackbar message when an application registration already exists.
  ///
  /// In en, this message translates to:
  /// **'This application is already registered.'**
  String get notificationsDefinitionsDuplicate;

  /// Empty state for notification application registrations.
  ///
  /// In en, this message translates to:
  /// **'No apps are configured to process notifications.'**
  String get notificationsDefinitionsEmpty;

  /// Title shown when no notification applications are registered.
  ///
  /// In en, this message translates to:
  /// **'No registered applications'**
  String get notificationsDefinitionsEmptyTitle;

  /// Description shown when no notification applications are registered.
  ///
  /// In en, this message translates to:
  /// **'Add an application to choose which notifications Waterfly should turn into transactions.'**
  String get notificationsDefinitionsEmptyDescription;

  /// Description shown when no notification applications are registered and notification access is disabled.
  ///
  /// In en, this message translates to:
  /// **'Add and configure an application now. Waterfly will begin processing its notifications after notification access is enabled.'**
  String get notificationsDefinitionsEmptyDescriptionAccessNeeded;

  /// Error message when notification definitions cannot be loaded.
  ///
  /// In en, this message translates to:
  /// **'Notification definitions could not be loaded.'**
  String get notificationsDefinitionsLoadFailure;

  /// Error shown when notification definitions load but their migration alerts cannot be loaded.
  ///
  /// In en, this message translates to:
  /// **'Migration review details could not be loaded.'**
  String get notificationsDefinitionsMigrationAlertsLoadFailure;

  /// Heading for notification application registrations.
  ///
  /// In en, this message translates to:
  /// **'Registered applications'**
  String get notificationsDefinitionsRegisteredApplications;

  /// Description below the registered applications heading on the notification definitions page.
  ///
  /// In en, this message translates to:
  /// **'Manage which apps\' notifications Waterfly processes. Open an app to configure its extractors, rules, and actions.'**
  String get notificationsDefinitionsRegisteredApplicationsDescription;

  /// Fallback name shown for a notification definition when the application name is unavailable.
  ///
  /// In en, this message translates to:
  /// **'Unknown application'**
  String get notificationsDefinitionsUnknownApplication;

  /// Snackbar message when an application registration cannot be saved.
  ///
  /// In en, this message translates to:
  /// **'The application registration could not be saved.'**
  String get notificationsDefinitionsSaveFailure;

  /// Title for the notification alerts page.
  ///
  /// In en, this message translates to:
  /// **'Notification alerts'**
  String get notificationsAlertsTitle;

  /// Explanation of the notification alerts page and its alert grouping behavior.
  ///
  /// In en, this message translates to:
  /// **'Review notification processing issues that may require attention. Alerts are grouped by application, and repeated occurrences are combined.'**
  String get notificationsAlertsDescription;

  /// Button label for dismissing every visible notification alert.
  ///
  /// In en, this message translates to:
  /// **'Dismiss all'**
  String get notificationsAlertsDismissAll;

  /// Error state for the notification alerts page.
  ///
  /// In en, this message translates to:
  /// **'Notification alerts could not be loaded.'**
  String get notificationsAlertsLoadFailure;

  /// Snackbar shown when alert application names cannot be loaded and package IDs are used instead.
  ///
  /// In en, this message translates to:
  /// **'Application names could not be loaded. Package IDs are shown instead.'**
  String get notificationsAlertsApplicationNamesLoadFailure;

  /// Empty state for notification alerts.
  ///
  /// In en, this message translates to:
  /// **'No notification alerts need your attention.'**
  String get notificationsAlertsEmpty;

  /// Title shown when there are no notification alerts.
  ///
  /// In en, this message translates to:
  /// **'All clear'**
  String get notificationsAlertsEmptyTitle;

  /// Title shown while notification definitions cannot be loaded.
  ///
  /// In en, this message translates to:
  /// **'Notification processing is paused'**
  String get notificationsHealthActiveTitle;

  /// Description of an active notification listener health incident.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Waterfly could not load your notification setup. One notification may have been skipped.} other{Waterfly could not load your notification setup. {count} notifications may have been skipped.}}'**
  String notificationsHealthActiveDescription(int count);

  /// Title shown after notification definition loading recovers.
  ///
  /// In en, this message translates to:
  /// **'Notification processing recovered'**
  String get notificationsHealthRecoveredTitle;

  /// Description of a recovered notification listener health incident.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Processing is working again, but one notification may have been skipped.} other{Processing is working again, but {count} notifications may have been skipped.}}'**
  String notificationsHealthRecoveredDescription(int count);

  /// Action to retry loading notification definitions.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get notificationsHealthRetry;

  /// Action to open notification processing setup from a health incident.
  ///
  /// In en, this message translates to:
  /// **'Review setup'**
  String get notificationsHealthReviewSetup;

  /// Action to acknowledge and dismiss a recovered notification processing incident.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get notificationsHealthDismiss;

  /// Snackbar shown when retrying notification processing fails.
  ///
  /// In en, this message translates to:
  /// **'Notification processing is still unavailable.'**
  String get notificationsHealthRetryFailure;

  /// Snackbar shown when acknowledging a recovered notification processing incident fails.
  ///
  /// In en, this message translates to:
  /// **'The recovered processing notice could not be dismissed.'**
  String get notificationsHealthDismissFailure;

  /// Message shown when listener health status cannot be loaded.
  ///
  /// In en, this message translates to:
  /// **'Notification processing status could not be loaded.'**
  String get notificationsHealthStatusLoadFailure;

  /// Snackbar message when dismissing an alert fails.
  ///
  /// In en, this message translates to:
  /// **'The alert could not be dismissed.'**
  String get notificationsAlertsDismissFailure;

  /// Snackbar message after dismissing one alert.
  ///
  /// In en, this message translates to:
  /// **'Alert dismissed.'**
  String get notificationsAlertsDismissed;

  /// Snackbar action that restores dismissed alerts.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get notificationsAlertsUndo;

  /// Confirmation dialog title for dismissing all notification alerts.
  ///
  /// In en, this message translates to:
  /// **'Dismiss all alerts?'**
  String get notificationsAlertsDismissAllTitle;

  /// Confirmation dialog description for dismissing all notification alerts.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No alerts will be dismissed.} =1{1 alert will be dismissed.} other{{count} alerts will be dismissed.}}'**
  String notificationsAlertsDismissAllDescription(int count);

  /// Snackbar message after dismissing notification alerts.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No alerts dismissed.} =1{1 alert dismissed.} other{{count} alerts dismissed.}}'**
  String notificationsAlertsDismissedCount(int count);

  /// Snackbar message after some notification alerts are dismissed.
  ///
  /// In en, this message translates to:
  /// **'{dismissed, plural, =0{No alerts dismissed.} =1{1 of {total} alerts dismissed.} other{{dismissed} of {total} alerts dismissed.}}'**
  String notificationsAlertsPartiallyDismissed(int dismissed, int total);

  /// Snackbar message after some notification alerts are restored.
  ///
  /// In en, this message translates to:
  /// **'{restored, plural, =0{No alerts restored.} =1{1 of {total} alerts restored.} other{{restored} of {total} alerts restored.}}'**
  String notificationsAlertsPartiallyRestored(int restored, int total);

  /// Snackbar message when restoring an alert fails.
  ///
  /// In en, this message translates to:
  /// **'The alert could not be restored.'**
  String get notificationsAlertsRestoreFailure;

  /// Snackbar message when an alert's rule no longer exists.
  ///
  /// In en, this message translates to:
  /// **'The rule is no longer available.'**
  String get notificationsAlertsRuleUnavailable;

  /// Snackbar message when an alert's rule cannot be opened.
  ///
  /// In en, this message translates to:
  /// **'The rule could not be opened.'**
  String get notificationsAlertsOpenRuleFailure;

  /// Snackbar message when an alert's notification setup no longer exists.
  ///
  /// In en, this message translates to:
  /// **'The notification setup is no longer available.'**
  String get notificationsAlertsSetupUnavailable;

  /// Snackbar message when an alert's notification setup cannot be opened.
  ///
  /// In en, this message translates to:
  /// **'The notification setup could not be opened.'**
  String get notificationsAlertsOpenSetupFailure;

  /// Snackbar message when edits made from an alert cannot be saved.
  ///
  /// In en, this message translates to:
  /// **'The rule changes could not be saved.'**
  String get notificationsAlertsRuleSaveFailure;

  /// Alert detail that identifies the source application.
  ///
  /// In en, this message translates to:
  /// **'App: {name}'**
  String notificationsAlertsApplicationDetail(String name);

  /// Alert detail that identifies an application package.
  ///
  /// In en, this message translates to:
  /// **'Package: {packageId}'**
  String notificationsAlertsPackageDetail(String packageId);

  /// Alert detail that identifies the notification rule.
  ///
  /// In en, this message translates to:
  /// **'Rule: {name}'**
  String notificationsAlertsRuleDetail(String name);

  /// Alert detail that identifies the notification action.
  ///
  /// In en, this message translates to:
  /// **'Action: {name}'**
  String notificationsAlertsActionDetail(String name);

  /// Button label for dismissing one notification alert.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get notificationsAlertsDismiss;

  /// Button label that opens the rule associated with an alert.
  ///
  /// In en, this message translates to:
  /// **'Open rule'**
  String get notificationsAlertsOpenRule;

  /// Button label that opens the notification setup associated with an alert.
  ///
  /// In en, this message translates to:
  /// **'Open setup'**
  String get notificationsAlertsOpenSetup;

  /// Number of times a notification alert has occurred.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No occurrences} =1{1 occurrence} other{{count} occurrences}}'**
  String notificationsAlertsOccurrenceCount(int count);

  /// Number of distinct notification alerts grouped for an application.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No issues} =1{1 issue} other{{count} issues}}'**
  String notificationsAlertsIssueCount(int count);

  /// Number of additional issues hidden in a collapsed application alert card.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 more issue} other{{count} more issues}}'**
  String notificationsAlertsMoreIssues(int count);

  /// Tooltip for dismissing one issue from a grouped alert card.
  ///
  /// In en, this message translates to:
  /// **'Dismiss issue'**
  String get notificationsAlertsDismissIssue;

  /// Button label for dismissing every issue for one application.
  ///
  /// In en, this message translates to:
  /// **'Dismiss all issues'**
  String get notificationsAlertsDismissGroup;

  /// Label for a failed notification settings migration.
  ///
  /// In en, this message translates to:
  /// **'Migration failed'**
  String get notificationsAlertsKindMigrationFailed;

  /// Label for imported notification settings requiring review.
  ///
  /// In en, this message translates to:
  /// **'Migration needs review'**
  String get notificationsAlertsKindMigrationNeedsReview;

  /// Label for an invalid notification definition.
  ///
  /// In en, this message translates to:
  /// **'Definition invalid'**
  String get notificationsAlertsKindDefinitionInvalid;

  /// Label for a notification rule evaluation failure.
  ///
  /// In en, this message translates to:
  /// **'Rule evaluation failed'**
  String get notificationsAlertsKindEvaluationFailed;

  /// Label for a notification action failure.
  ///
  /// In en, this message translates to:
  /// **'Action failed'**
  String get notificationsAlertsKindActionFailed;

  /// Title for a migrated automatic configuration that was changed to Prompt mode.
  ///
  /// In en, this message translates to:
  /// **'Automatic creation paused'**
  String get notificationsMigrationAutomaticPausedTitle;

  /// Guidance for a migrated automatic configuration that was changed to Prompt mode.
  ///
  /// In en, this message translates to:
  /// **'Transactions will use Prompt mode until you review the imported setup.'**
  String get notificationsMigrationAutomaticPausedMessage;

  /// Title for a migrated automatic configuration without an account mapping.
  ///
  /// In en, this message translates to:
  /// **'Account required for automatic creation'**
  String get notificationsMigrationMissingAccountTitle;

  /// Guidance for a migrated automatic configuration without an account mapping.
  ///
  /// In en, this message translates to:
  /// **'Choose an account before enabling automatic transaction creation.'**
  String get notificationsMigrationMissingAccountMessage;

  /// Title for imported notification settings without an application name.
  ///
  /// In en, this message translates to:
  /// **'Application name unavailable'**
  String get notificationsMigrationMissingApplicationNameTitle;

  /// Guidance for imported notification settings without an application name.
  ///
  /// In en, this message translates to:
  /// **'Waterfly could not identify the application for this imported setup. Open it and choose the installed application that should use this configuration.'**
  String get notificationsMigrationMissingApplicationNameMessage;

  /// Title for a legacy notification registration without saved settings.
  ///
  /// In en, this message translates to:
  /// **'Previous settings unavailable'**
  String get notificationsMigrationMissingSettingsTitle;

  /// Guidance for a legacy notification registration without saved settings.
  ///
  /// In en, this message translates to:
  /// **'No saved configuration was found for this application. Create a new setup manually.'**
  String get notificationsMigrationMissingSettingsMessage;

  /// Title for an invalid imported notification regular expression.
  ///
  /// In en, this message translates to:
  /// **'Imported expression is invalid'**
  String get notificationsMigrationInvalidRegexTitle;

  /// Guidance for an invalid imported notification regular expression.
  ///
  /// In en, this message translates to:
  /// **'Update or replace the expression before using this setup.'**
  String get notificationsMigrationInvalidRegexMessage;

  /// Title for an imported regular expression that does not match its sample.
  ///
  /// In en, this message translates to:
  /// **'Expression does not match the sample'**
  String get notificationsMigrationRegexMismatchTitle;

  /// Guidance for an imported regular expression that does not match its sample.
  ///
  /// In en, this message translates to:
  /// **'Update the expression or select another sample notification.'**
  String get notificationsMigrationRegexMismatchMessage;

  /// Title for an imported sample containing multiple monetary values.
  ///
  /// In en, this message translates to:
  /// **'Choose the transaction amount'**
  String get notificationsMigrationAmbiguousAmountTitle;

  /// Guidance for an imported sample containing multiple monetary values.
  ///
  /// In en, this message translates to:
  /// **'The sample contains more than one monetary value. Select the value that represents the transaction amount.'**
  String get notificationsMigrationAmbiguousAmountMessage;

  /// Title for an imported sample without a recognized monetary value.
  ///
  /// In en, this message translates to:
  /// **'Transaction amount not found'**
  String get notificationsMigrationAmountNotFoundTitle;

  /// Guidance for an imported sample without a recognized monetary value.
  ///
  /// In en, this message translates to:
  /// **'Select or configure an extractor for the transaction amount.'**
  String get notificationsMigrationAmountNotFoundMessage;

  /// Title for imported notification settings without a usable sample.
  ///
  /// In en, this message translates to:
  /// **'Sample notification required'**
  String get notificationsMigrationSampleMissingTitle;

  /// Guidance for imported notification settings without a usable sample.
  ///
  /// In en, this message translates to:
  /// **'Capture or enter a sample notification to finish this setup.'**
  String get notificationsMigrationSampleMissingMessage;

  /// Title for an imported sample whose currency could not be resolved uniquely.
  ///
  /// In en, this message translates to:
  /// **'Choose the transaction currency'**
  String get notificationsMigrationCurrencyUnresolvedTitle;

  /// Guidance for an imported sample whose currency could not be resolved uniquely.
  ///
  /// In en, this message translates to:
  /// **'The sample currency could not be matched uniquely. Select the intended Firefly currency.'**
  String get notificationsMigrationCurrencyUnresolvedMessage;

  /// Title for legacy notification settings that could not be converted.
  ///
  /// In en, this message translates to:
  /// **'Previous settings could not be imported'**
  String get notificationsMigrationConversionFailedTitle;

  /// Guidance for legacy notification settings that could not be converted.
  ///
  /// In en, this message translates to:
  /// **'Complete this notification setup manually.'**
  String get notificationsMigrationConversionFailedMessage;

  /// Title for the recent notifications page.
  ///
  /// In en, this message translates to:
  /// **'Recent notifications'**
  String get notificationsHistoryTitle;

  /// Explanation that recent notification processing details are historical snapshots.
  ///
  /// In en, this message translates to:
  /// **'Review captured notifications and their processing results. Matched rules and actions reflect what was configured when each notification was processed.'**
  String get notificationsHistoryDescription;

  /// Error state for the recent notifications page.
  ///
  /// In en, this message translates to:
  /// **'Recent notifications could not be loaded.'**
  String get notificationsHistoryLoadFailure;

  /// Error shown below loaded notification history when an earlier page cannot be loaded.
  ///
  /// In en, this message translates to:
  /// **'Earlier notifications could not be loaded.'**
  String get notificationsHistoryLoadMoreFailure;

  /// Button that retries loading an earlier page of notification history.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get notificationsHistoryLoadMoreRetry;

  /// Heading for notification history entries received today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get notificationsHistoryToday;

  /// Heading for notification history entries received yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get notificationsHistoryYesterday;

  /// Empty state for recent notifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications have been recorded yet.'**
  String get notificationsHistoryEmpty;

  /// Title shown when notification history is empty.
  ///
  /// In en, this message translates to:
  /// **'No recent notifications'**
  String get notificationsHistoryEmptyTitle;

  /// Description shown when notification history is empty.
  ///
  /// In en, this message translates to:
  /// **'Notifications received by Waterfly will appear here.'**
  String get notificationsHistoryEmptyDescription;

  /// Button that starts a rule from a recent notification.
  ///
  /// In en, this message translates to:
  /// **'Create rule'**
  String get notificationsHistoryCreateRule;

  /// Title for a recent notification that does not match any rule.
  ///
  /// In en, this message translates to:
  /// **'No matching rule'**
  String get notificationsHistoryNoMatchingRuleTitle;

  /// Explanation shown when a recent notification does not match any rule.
  ///
  /// In en, this message translates to:
  /// **'Create a rule so similar notifications can be processed automatically.'**
  String get notificationsHistoryNoMatchingRuleMessage;

  /// Title for a recent notification that failed during processing.
  ///
  /// In en, this message translates to:
  /// **'Could not process notification'**
  String get notificationsHistoryProcessingFailureTitle;

  /// Title for a recent notification that can create a transaction from shared actions without a specific matching rule.
  ///
  /// In en, this message translates to:
  /// **'Transaction fields matched'**
  String get notificationsHistorySharedActionsTitle;

  /// Explanation for a recent notification that can create a transaction from shared actions without a specific matching rule.
  ///
  /// In en, this message translates to:
  /// **'Shared actions can create a transaction from this notification.'**
  String get notificationsHistorySharedActionsMessage;

  /// Label preceding the name of the matched notification rule.
  ///
  /// In en, this message translates to:
  /// **'Matched rule'**
  String get notificationsHistoryMatchingRuleLabel;

  /// Label preceding conditional actions that matched a recent notification.
  ///
  /// In en, this message translates to:
  /// **'Matched actions'**
  String get notificationsHistoryMatchingConditionalActionsLabel;

  /// Button opening transaction creation from a recent notification.
  ///
  /// In en, this message translates to:
  /// **'Create transaction'**
  String get notificationsHistoryCreateTransaction;

  /// Title for notification history that successfully created a Firefly III transaction automatically.
  ///
  /// In en, this message translates to:
  /// **'Transaction created automatically'**
  String get notificationsHistoryTransactionCreatedTitle;

  /// Title for notification history when the user created a Firefly III transaction from the notification.
  ///
  /// In en, this message translates to:
  /// **'Transaction created from notification'**
  String get notificationsHistoryTransactionCreatedByUserTitle;

  /// Neutral title for older notification history with unknown transaction creation provenance.
  ///
  /// In en, this message translates to:
  /// **'Transaction created'**
  String get notificationsHistoryTransactionCreated;

  /// Button opening the Firefly III transaction created from a notification.
  ///
  /// In en, this message translates to:
  /// **'View transaction'**
  String get notificationsHistoryViewTransaction;

  /// Error shown when an automatically created transaction is no longer available.
  ///
  /// In en, this message translates to:
  /// **'The created transaction could not be opened. It may have been deleted.'**
  String get notificationsHistoryOpenTransactionFailure;

  /// Error shown when a transaction account configured by notification processing cannot be resolved.
  ///
  /// In en, this message translates to:
  /// **'The configured account \"{account}\" is no longer available. Select an account before saving.'**
  String notificationsTransactionAccountUnavailable(String account);

  /// Menu action that opens the matched notification rule from a recent notification.
  ///
  /// In en, this message translates to:
  /// **'Edit rule'**
  String get notificationsHistoryEditRule;

  /// Menu action that opens the application notification definition from a recent notification.
  ///
  /// In en, this message translates to:
  /// **'Go to definition'**
  String get notificationsHistoryGoToDefinition;

  /// Error opening a recent notification's definition.
  ///
  /// In en, this message translates to:
  /// **'The notification definition could not be opened.'**
  String get notificationsHistoryOpenDefinitionFailure;

  /// The definition for a recent notification was deleted before it could be opened.
  ///
  /// In en, this message translates to:
  /// **'The notification definition is no longer available.'**
  String get notificationsHistoryDefinitionUnavailable;

  /// Button label for default-rule notification actions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get notificationsHistoryActions;

  /// Menu action that removes one recent notification history entry.
  ///
  /// In en, this message translates to:
  /// **'Remove from recent history'**
  String get notificationsHistoryRemoveFromHistory;

  /// Confirmation title for removing one recent notification history entry.
  ///
  /// In en, this message translates to:
  /// **'Remove notification from history?'**
  String get notificationsHistoryRemoveTitle;

  /// Confirmation message for removing one recent notification history entry.
  ///
  /// In en, this message translates to:
  /// **'This removes the notification record from Waterfly. Any Firefly transaction created from it will not be deleted.'**
  String get notificationsHistoryRemoveConfirm;

  /// Snackbar shown after one recent notification history entry is removed.
  ///
  /// In en, this message translates to:
  /// **'Notification removed from recent history.'**
  String get notificationsHistoryRemoved;

  /// Snackbar action that restores a removed recent notification history entry.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get notificationsHistoryUndo;

  /// Snackbar shown when a removed recent notification history entry cannot be restored.
  ///
  /// In en, this message translates to:
  /// **'The notification could not be restored to recent history.'**
  String get notificationsHistoryRestoreFailure;

  /// Snackbar shown when one recent notification history entry cannot be removed.
  ///
  /// In en, this message translates to:
  /// **'The notification could not be removed from recent history.'**
  String get notificationsHistoryRemoveFailure;

  /// Title shown for recent notification history entries stored without title or body contents.
  ///
  /// In en, this message translates to:
  /// **'Notification details hidden'**
  String get notificationsHistoryRedactedTitle;

  /// Body shown for recent notification history entries stored without title or body contents.
  ///
  /// In en, this message translates to:
  /// **'Only delivery metadata was stored for this notification.'**
  String get notificationsHistoryRedactedBody;

  /// Privacy message shown when metadata-only history stores an outcome without transaction field values.
  ///
  /// In en, this message translates to:
  /// **'Transaction details hidden'**
  String get notificationsHistoryTransactionDetailsHidden;

  /// Heading for a compact notification transaction summary.
  ///
  /// In en, this message translates to:
  /// **'Transaction summary'**
  String get notificationsTransactionSummary;

  /// Heading for account fields in a notification transaction summary.
  ///
  /// In en, this message translates to:
  /// **'Accounts'**
  String get notificationsTransactionAccounts;

  /// Heading for category, currency, subscription, and piggy bank fields in a notification transaction summary.
  ///
  /// In en, this message translates to:
  /// **'Classification'**
  String get notificationsTransactionClassification;

  /// Heading for date, time, and notes in a notification transaction summary.
  ///
  /// In en, this message translates to:
  /// **'Additional details'**
  String get notificationsTransactionAdditionalDetails;

  /// Privacy-safe failure message shown when metadata-only history does not retain detailed failure text.
  ///
  /// In en, this message translates to:
  /// **'Processing failed. Open Alerts for diagnostic details.'**
  String get notificationsHistoryRedactedFailureMessage;

  /// Button opening the notification alert related to a failed history entry.
  ///
  /// In en, this message translates to:
  /// **'View alert'**
  String get notificationsHistoryViewAlert;

  /// Button opening notification alerts when a failed history entry has no correlated alert.
  ///
  /// In en, this message translates to:
  /// **'View alerts'**
  String get notificationsHistoryViewAlerts;

  /// Tooltip for the notification feature overflow menu.
  ///
  /// In en, this message translates to:
  /// **'Notification options'**
  String get notificationsMenuOptions;

  /// Snackbar message when a rule created from history cannot be saved.
  ///
  /// In en, this message translates to:
  /// **'The rule could not be saved.'**
  String get notificationsMenuRuleSaveFailure;

  /// Menu item that opens notification alerts.
  ///
  /// In en, this message translates to:
  /// **'Alerts'**
  String get notificationsMenuAlerts;

  /// Title for the notification processing settings page and menu item.
  ///
  /// In en, this message translates to:
  /// **'Notification processing settings'**
  String get notificationsProcessingSettingsTitle;

  /// Error state for the notification processing settings page.
  ///
  /// In en, this message translates to:
  /// **'Notification processing settings could not be loaded.'**
  String get notificationsProcessingSettingsLoadFailure;

  /// Snackbar shown when notification processing settings cannot be saved.
  ///
  /// In en, this message translates to:
  /// **'Notification processing settings could not be saved.'**
  String get notificationsProcessingSettingsSaveFailure;

  /// Section title for notification processing backup and restore options.
  ///
  /// In en, this message translates to:
  /// **'Backup and restore'**
  String get notificationsProcessingConfigurationTitle;

  /// Description for the notification processing configuration section.
  ///
  /// In en, this message translates to:
  /// **'Export or restore your notification setup and processing preferences.'**
  String get notificationsProcessingConfigurationDescription;

  /// Action that creates a notification processing backup.
  ///
  /// In en, this message translates to:
  /// **'Create backup'**
  String get notificationsProcessingCreateBackup;

  /// Description for creating a notification processing backup.
  ///
  /// In en, this message translates to:
  /// **'Export your notification setup and processing preferences with obfuscated data. Recent history and alerts are not included.'**
  String get notificationsProcessingCreateBackupDescription;

  /// Description shown when a notification backup cannot be created because no applications are registered.
  ///
  /// In en, this message translates to:
  /// **'Add at least one application before creating a backup.'**
  String get notificationsProcessingCreateBackupDisabledDescription;

  /// Action that restores a notification processing backup.
  ///
  /// In en, this message translates to:
  /// **'Restore backup'**
  String get notificationsProcessingRestoreBackup;

  /// Description for restoring a notification processing backup.
  ///
  /// In en, this message translates to:
  /// **'Replace your current notification setup and processing preferences with a backup.'**
  String get notificationsProcessingRestoreBackupDescription;

  /// Section title for notification history and privacy settings.
  ///
  /// In en, this message translates to:
  /// **'History and stored data'**
  String get notificationsProcessingStoredDataTitle;

  /// Description for notification stored data and privacy settings.
  ///
  /// In en, this message translates to:
  /// **'Choose what recent history keeps and how long stored records remain on this device.'**
  String get notificationsProcessingStoredDataDescription;

  /// Setting label for notification history storage mode.
  ///
  /// In en, this message translates to:
  /// **'Recent notification history'**
  String get notificationsProcessingHistoryStorageMode;

  /// Description for notification history storage mode.
  ///
  /// In en, this message translates to:
  /// **'Choose whether recent history keeps full notification content, metadata only, or nothing.'**
  String get notificationsProcessingHistoryStorageModeDescription;

  /// Option that disables notification history storage.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get notificationsProcessingHistoryStorageDisabled;

  /// Option that stores notification history metadata without title or body.
  ///
  /// In en, this message translates to:
  /// **'Metadata only'**
  String get notificationsProcessingHistoryStorageMetadata;

  /// Option that stores full notification history contents.
  ///
  /// In en, this message translates to:
  /// **'Full'**
  String get notificationsProcessingHistoryStorageFull;

  /// Setting label for recent notification history retention.
  ///
  /// In en, this message translates to:
  /// **'History retention'**
  String get notificationsProcessingHistoryRetention;

  /// Description for recent notification history retention.
  ///
  /// In en, this message translates to:
  /// **'Automatically remove recent notification records older than this period.'**
  String get notificationsProcessingHistoryRetentionDescription;

  /// Retention option for seven days.
  ///
  /// In en, this message translates to:
  /// **'7 days'**
  String get notificationsProcessingRetentionSevenDays;

  /// Retention option for thirty days.
  ///
  /// In en, this message translates to:
  /// **'30 days'**
  String get notificationsProcessingRetentionThirtyDays;

  /// Retention option for ninety days.
  ///
  /// In en, this message translates to:
  /// **'90 days'**
  String get notificationsProcessingRetentionNinetyDays;

  /// Retention option that keeps records forever.
  ///
  /// In en, this message translates to:
  /// **'Forever'**
  String get notificationsProcessingRetentionForever;

  /// Action that clears recent notification history.
  ///
  /// In en, this message translates to:
  /// **'Clear recent history'**
  String get notificationsProcessingClearHistory;

  /// Description for clearing recent notification history.
  ///
  /// In en, this message translates to:
  /// **'Delete all recent notification records.'**
  String get notificationsProcessingClearHistoryDescription;

  /// Action that clears notification processing alerts.
  ///
  /// In en, this message translates to:
  /// **'Clear processing alerts'**
  String get notificationsProcessingClearAlerts;

  /// Description for clearing notification processing alerts.
  ///
  /// In en, this message translates to:
  /// **'Delete all current processing alerts.'**
  String get notificationsProcessingClearAlertsDescription;

  /// Label for a grouped set of destructive notification stored data cleanup actions.
  ///
  /// In en, this message translates to:
  /// **'Clear history and alerts'**
  String get notificationsProcessingClearStoredDataTitle;

  /// Section title for notification processing offboarding actions.
  ///
  /// In en, this message translates to:
  /// **'Notification access and setup'**
  String get notificationsProcessingOffboardingTitle;

  /// Description for notification processing offboarding actions.
  ///
  /// In en, this message translates to:
  /// **'Manage Waterfly\'s Android notification access or remove the saved notification setup.'**
  String get notificationsProcessingOffboardingDescription;

  /// Action that opens Android notification access settings.
  ///
  /// In en, this message translates to:
  /// **'Open notification access settings'**
  String get notificationsProcessingOpenAccessSettings;

  /// Description for opening Android notification access settings.
  ///
  /// In en, this message translates to:
  /// **'Review or revoke Waterfly\'s notification access in Android settings.'**
  String get notificationsProcessingOpenAccessSettingsDescription;

  /// Action that removes all notification processing setup and data.
  ///
  /// In en, this message translates to:
  /// **'Remove notification setup'**
  String get notificationsProcessingRemoveSetup;

  /// Action that deletes every notification application registration.
  ///
  /// In en, this message translates to:
  /// **'Delete all application registrations'**
  String get notificationsProcessingDeleteRegistrations;

  /// Description for deleting all notification application registrations.
  ///
  /// In en, this message translates to:
  /// **'Delete every registered application and its rules while keeping notification access and processing preferences.'**
  String get notificationsProcessingDeleteRegistrationsDescription;

  /// Confirmation title for deleting every notification application registration.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Delete 1 application registration?} other{Delete {count} application registrations?}}'**
  String notificationsProcessingDeleteRegistrationsTitle(int count);

  /// Confirmation message for deleting every notification application registration.
  ///
  /// In en, this message translates to:
  /// **'Their rules, recent history, and alerts will also be deleted. Processing preferences and notification access will not change.'**
  String get notificationsProcessingDeleteRegistrationsConfirm;

  /// Snackbar message after deleting every notification application registration.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 application registration deleted.} other{{count} application registrations deleted.}}'**
  String notificationsProcessingRegistrationsDeleted(int count);

  /// Snackbar message after deleting every notification application registration when related-data cleanup is incomplete.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 application registration deleted, but its related history or alerts could not be completely cleared.} other{{count} application registrations deleted, but their related history or alerts could not be completely cleared.}}'**
  String notificationsProcessingRegistrationsDeletedCleanupFailure(int count);

  /// Description for removing notification setup.
  ///
  /// In en, this message translates to:
  /// **'Delete saved apps, rules, recent history, and alerts, then reset processing preferences.'**
  String get notificationsProcessingRemoveSetupDescription;

  /// Label for a grouped destructive notification processing setup removal action.
  ///
  /// In en, this message translates to:
  /// **'Remove saved setup'**
  String get notificationsProcessingRemoveSetupGroupTitle;

  /// File picker title for saving notification processing exports.
  ///
  /// In en, this message translates to:
  /// **'Save notification processing file'**
  String get notificationsProcessingSaveFileTitle;

  /// Snackbar shown after export file selection is cancelled.
  ///
  /// In en, this message translates to:
  /// **'Export cancelled.'**
  String get notificationsProcessingExportCancelled;

  /// Snackbar shown after creating a notification processing backup.
  ///
  /// In en, this message translates to:
  /// **'Notification processing backup created.'**
  String get notificationsProcessingBackupComplete;

  /// Confirmation title for restoring a notification processing backup.
  ///
  /// In en, this message translates to:
  /// **'Restore notification processing backup?'**
  String get notificationsProcessingRestoreBackupTitle;

  /// Confirmation text for restoring a notification processing backup.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{This backup contains no definitions. It will replace your current setup and processing settings.} =1{This backup contains 1 definition. It will replace your current setup and processing settings.} other{This backup contains {count} definitions. It will replace your current setup and processing settings.}}'**
  String notificationsProcessingRestoreBackupConfirm(int count);

  /// Snackbar shown after restoring a notification processing backup.
  ///
  /// In en, this message translates to:
  /// **'Notification processing backup restored.'**
  String get notificationsProcessingRestoreBackupComplete;

  /// Confirmation title for clearing recent notification history.
  ///
  /// In en, this message translates to:
  /// **'Clear recent notification history?'**
  String get notificationsProcessingClearHistoryTitle;

  /// Confirmation text for clearing recent notification history.
  ///
  /// In en, this message translates to:
  /// **'All stored recent notification records will be deleted.'**
  String get notificationsProcessingClearHistoryConfirm;

  /// Snackbar shown after clearing recent notification history.
  ///
  /// In en, this message translates to:
  /// **'Recent notification history cleared.'**
  String get notificationsProcessingHistoryCleared;

  /// Confirmation title for clearing notification alerts.
  ///
  /// In en, this message translates to:
  /// **'Clear notification alerts?'**
  String get notificationsProcessingClearAlertsTitle;

  /// Confirmation text for clearing notification alerts.
  ///
  /// In en, this message translates to:
  /// **'All processing alerts will be deleted.'**
  String get notificationsProcessingClearAlertsConfirm;

  /// Snackbar shown after clearing notification alerts.
  ///
  /// In en, this message translates to:
  /// **'Notification alerts cleared.'**
  String get notificationsProcessingAlertsCleared;

  /// Confirmation title for removing notification setup.
  ///
  /// In en, this message translates to:
  /// **'Remove notification setup?'**
  String get notificationsProcessingRemoveSetupTitle;

  /// Confirmation text for removing notification setup.
  ///
  /// In en, this message translates to:
  /// **'Definitions, recent history, alerts, and processing settings will be removed. Android settings will open next so you can turn off Waterfly\'s notification access.'**
  String get notificationsProcessingRemoveSetupConfirm;

  /// Snackbar shown after removing notification setup and opening Android notification access settings.
  ///
  /// In en, this message translates to:
  /// **'Notification setup removed. Turn off Waterfly in Android notification access settings to stop listener access.'**
  String get notificationsProcessingRemoveSetupComplete;

  /// Snackbar shown after removing notification setup when Android notification access settings cannot be opened.
  ///
  /// In en, this message translates to:
  /// **'Notification setup removed. Open Android notification access settings to turn off listener access.'**
  String get notificationsProcessingRemoveSetupCompleteNoSettings;

  /// Snackbar shown after Android notification access settings are opened.
  ///
  /// In en, this message translates to:
  /// **'Notification access settings opened.'**
  String get notificationsProcessingAccessSettingsOpened;

  /// Snackbar shown when Android notification access settings cannot be opened.
  ///
  /// In en, this message translates to:
  /// **'Notification access settings could not be opened.'**
  String get notificationsProcessingAccessSettingsOpenFailure;

  /// Snackbar shown when a notification processing settings action fails.
  ///
  /// In en, this message translates to:
  /// **'The notification processing action could not be completed.'**
  String get notificationsProcessingActionFailure;

  /// Tooltip for an extractor action menu.
  ///
  /// In en, this message translates to:
  /// **'Extractor actions'**
  String get notificationsExtractorActions;

  /// Menu label for editing an item's name and optional description.
  ///
  /// In en, this message translates to:
  /// **'Edit details'**
  String get notificationsEditDetails;

  /// Field label for an optional notification configuration description.
  ///
  /// In en, this message translates to:
  /// **'Description (optional)'**
  String get notificationsDescriptionOptional;

  /// Button and menu label for deleting an extractor.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get notificationsExtractorDelete;

  /// Status label for an extractor with an invalid regular expression.
  ///
  /// In en, this message translates to:
  /// **'Invalid pattern'**
  String get notificationsExtractorInvalidPattern;

  /// Message explaining that an extractor pattern is invalid.
  ///
  /// In en, this message translates to:
  /// **'Fix the regular expression before this extractor can provide values.'**
  String get notificationsExtractorInvalidPatternMessage;

  /// Status title shown when a custom extractor sample exceeds the safe evaluation limit.
  ///
  /// In en, this message translates to:
  /// **'Sample is too long'**
  String get notificationsExtractorInputTooLong;

  /// Message explaining that a custom extractor input exceeds the safe evaluation limit.
  ///
  /// In en, this message translates to:
  /// **'Regular expression extractors can safely evaluate up to {maximumLength} characters. Use a shorter sample or simplify the source notification.'**
  String notificationsExtractorInputTooLongMessage(int maximumLength);

  /// Warning title shown for a regular expression with potentially expensive repetition.
  ///
  /// In en, this message translates to:
  /// **'Pattern may be slow'**
  String get notificationsExtractorPerformanceWarning;

  /// Warning message shown for a potentially expensive custom regular expression.
  ///
  /// In en, this message translates to:
  /// **'Nested or repeated broad matching can delay notification processing. Test this pattern with representative notifications before enabling automation.'**
  String get notificationsExtractorPerformanceWarningMessage;

  /// Status label for a valid extractor that does not match its sample.
  ///
  /// In en, this message translates to:
  /// **'No sample match'**
  String get notificationsExtractorNoSampleMatch;

  /// Message explaining that an extractor does not match its sample.
  ///
  /// In en, this message translates to:
  /// **'This extractor does not find a value in the current sample notification.'**
  String get notificationsExtractorNoSampleMatchMessage;

  /// Tooltip for clearing a rename text field.
  ///
  /// In en, this message translates to:
  /// **'Clear text'**
  String get notificationsClearText;

  /// Heading for the extractor sample notification.
  ///
  /// In en, this message translates to:
  /// **'Sample notification'**
  String get notificationsExtractorSampleNotification;

  /// Description of why an extractor can override the definition sample.
  ///
  /// In en, this message translates to:
  /// **'Fine-tune the sample for this extractor while keeping the definition sample available to other extractors and rules.'**
  String get notificationsExtractorSampleDescription;

  /// Confirmation dialog title for deleting an extractor.
  ///
  /// In en, this message translates to:
  /// **'Delete extractor?'**
  String get notificationsExtractorDeleteTitle;

  /// Confirmation dialog description for deleting an extractor.
  ///
  /// In en, this message translates to:
  /// **'\"{name}\" will be removed. Rules using its captured values may need updating.'**
  String notificationsExtractorDeleteDescription(String name);

  /// Title for the rename extractor dialog.
  ///
  /// In en, this message translates to:
  /// **'Rename extractor'**
  String get notificationsExtractorRenameTitle;

  /// Description for the rename extractor dialog.
  ///
  /// In en, this message translates to:
  /// **'Choose a name that identifies this extractor in rules.'**
  String get notificationsExtractorRenameDescription;

  /// Title for editing an extractor's name and description.
  ///
  /// In en, this message translates to:
  /// **'Edit extractor details'**
  String get notificationsExtractorEditDetailsTitle;

  /// Description for editing extractor details.
  ///
  /// In en, this message translates to:
  /// **'Use a clear name and optionally describe the value this extractor provides.'**
  String get notificationsExtractorEditDetailsDescription;

  /// Field label for an extractor name.
  ///
  /// In en, this message translates to:
  /// **'Extractor name'**
  String get notificationsExtractorName;

  /// Button label that saves an extractor name.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get notificationsExtractorSave;

  /// Navigation button label that returns to the previous dialog step.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get notificationsBack;

  /// Button label that adds a notification configuration item.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get notificationsAdd;

  /// Label for a built-in notification configuration option.
  ///
  /// In en, this message translates to:
  /// **'Predefined'**
  String get notificationsPredefined;

  /// Button or dialog title for adding an extractor.
  ///
  /// In en, this message translates to:
  /// **'Add extractor'**
  String get notificationsDefinitionAddExtractor;

  /// Title for selecting a built-in extractor.
  ///
  /// In en, this message translates to:
  /// **'Select predefined extractor'**
  String get notificationsDefinitionSelectPredefinedExtractor;

  /// Title for naming a regular expression extractor.
  ///
  /// In en, this message translates to:
  /// **'Name regular expression extractor'**
  String get notificationsDefinitionNameCustomExtractor;

  /// Description for extractor type selection.
  ///
  /// In en, this message translates to:
  /// **'Choose a built-in extractor or create one with a regular expression.'**
  String get notificationsDefinitionChooseExtractorType;

  /// Description for built-in extractor selection.
  ///
  /// In en, this message translates to:
  /// **'Select the notification field to extract.'**
  String get notificationsDefinitionSelectNotificationField;

  /// Description for custom extractor naming.
  ///
  /// In en, this message translates to:
  /// **'Name this extractor before entering its regular expression.'**
  String get notificationsDefinitionNameExtractorDescription;

  /// Description for the built-in extractor option.
  ///
  /// In en, this message translates to:
  /// **'Use a built-in value such as the notification title, message, or received time.'**
  String get notificationsDefinitionPredefinedExtractorDescription;

  /// Label for the regular expression extractor option.
  ///
  /// In en, this message translates to:
  /// **'Regular expression'**
  String get notificationsDefinitionRegularExpressionExtractor;

  /// Description for the regular expression extractor option.
  ///
  /// In en, this message translates to:
  /// **'Capture values from the notification with a regular expression.'**
  String get notificationsDefinitionCustomExtractorDescription;

  /// Status for an extractor that is already configured.
  ///
  /// In en, this message translates to:
  /// **'Already added.'**
  String get notificationsDefinitionAlreadyAdded;

  /// Description of the title extractor.
  ///
  /// In en, this message translates to:
  /// **'Captures the notification title.'**
  String get notificationsDefinitionCaptureNotificationTitle;

  /// Description of the message extractor.
  ///
  /// In en, this message translates to:
  /// **'Captures the notification message.'**
  String get notificationsDefinitionCaptureNotificationMessage;

  /// Description of the date extractor.
  ///
  /// In en, this message translates to:
  /// **'Captures the time the notification was received.'**
  String get notificationsDefinitionCaptureNotificationDate;

  /// Description of the amount extractor.
  ///
  /// In en, this message translates to:
  /// **'Captures an amount in the message.'**
  String get notificationsDefinitionCaptureAmount;

  /// Description of the currency extractor.
  ///
  /// In en, this message translates to:
  /// **'Captures currency before or after an amount.'**
  String get notificationsDefinitionCaptureCurrency;

  /// Button or dialog title for adding a rule.
  ///
  /// In en, this message translates to:
  /// **'Add rule'**
  String get notificationsDefinitionAddRule;

  /// Description for custom rule naming.
  ///
  /// In en, this message translates to:
  /// **'Name this rule before defining when it runs and which fields it sets.'**
  String get notificationsDefinitionNameRuleDescription;

  /// Field label for a notification rule name.
  ///
  /// In en, this message translates to:
  /// **'Rule name'**
  String get notificationsRuleName;

  /// Heading for notification definition options.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get notificationsDefinitionOptionsHeading;

  /// Description for notification definition options.
  ///
  /// In en, this message translates to:
  /// **'Choose whether matching notifications create transactions automatically or wait for review.'**
  String get notificationsDefinitionOptionsDescription;

  /// Option to automatically create matching transactions.
  ///
  /// In en, this message translates to:
  /// **'Create transaction automatically'**
  String get notificationsDefinitionCreateAutomatically;

  /// Description when automatic transaction creation is enabled.
  ///
  /// In en, this message translates to:
  /// **'Create a transaction automatically for each matching notification.'**
  String get notificationsDefinitionCreateAutomaticallyEnabled;

  /// Description when automatic transaction creation is disabled.
  ///
  /// In en, this message translates to:
  /// **'Review each matching transaction before it is created.'**
  String get notificationsDefinitionCreateAutomaticallyDisabled;

  /// Required title field for automatic notification transactions.
  ///
  /// In en, this message translates to:
  /// **'title'**
  String get notificationsDefinitionAutomaticRequirementTitle;

  /// Required positive amount for automatic notification transactions.
  ///
  /// In en, this message translates to:
  /// **'positive amount'**
  String get notificationsDefinitionAutomaticRequirementAmount;

  /// Required account field for automatic notification transactions.
  ///
  /// In en, this message translates to:
  /// **'source or destination account'**
  String get notificationsDefinitionAutomaticRequirementAccount;

  /// Warning shown when automatic notification transaction creation lacks required shared fields.
  ///
  /// In en, this message translates to:
  /// **'Automatic processing is disabled until shared actions provide: {requirements}.'**
  String notificationsDefinitionAutomaticIncomplete(String requirements);

  /// Title for an incomplete automatic notification transaction warning.
  ///
  /// In en, this message translates to:
  /// **'Automatic creation is incomplete'**
  String get notificationsDefinitionAutomaticIncompleteTitle;

  /// Placeholder text when a definition has no sample notification.
  ///
  /// In en, this message translates to:
  /// **'Sample notification required'**
  String get notificationsDefinitionSampleRequired;

  /// Tooltip for editing a definition sample notification.
  ///
  /// In en, this message translates to:
  /// **'Edit sample notification'**
  String get notificationsDefinitionEditSample;

  /// Heading for notification definition extractors.
  ///
  /// In en, this message translates to:
  /// **'Extractors'**
  String get notificationsDefinitionExtractorsHeading;

  /// Description for notification definition extractors.
  ///
  /// In en, this message translates to:
  /// **'Extractors turn notification details, such as title, message, or received time, into values rules can use.'**
  String get notificationsDefinitionExtractorsDescription;

  /// Empty state for custom extractors.
  ///
  /// In en, this message translates to:
  /// **'No extractors defined'**
  String get notificationsDefinitionNoExtractors;

  /// Number of regular expression matches.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No matches} =1{1 match} other{{count} matches}}'**
  String notificationsDefinitionMatchCount(int count);

  /// Heading for notification definition rules.
  ///
  /// In en, this message translates to:
  /// **'Rules'**
  String get notificationsDefinitionRulesHeading;

  /// Description of ordered first-match rule selection.
  ///
  /// In en, this message translates to:
  /// **'Rules are checked from top to bottom. The first matching rule handles the notification.'**
  String get notificationsDefinitionRulesOrderDescription;

  /// Warning shown when an unconditional rule makes following rules unreachable.
  ///
  /// In en, this message translates to:
  /// **'Always applies · Rules below cannot be reached'**
  String get notificationsDefinitionRuleShadowsFollowing;

  /// Heading and editor title for actions shared by every selected rule.
  ///
  /// In en, this message translates to:
  /// **'Shared actions'**
  String get notificationsDefinitionSharedActionsTitle;

  /// Description of when shared notification actions run.
  ///
  /// In en, this message translates to:
  /// **'Shared actions run before each matching rule. Rule actions can override their values.'**
  String get notificationsDefinitionSharedActionsDescription;

  /// Status message shown in the shared actions editor when neither shared fields nor rules are configured.
  ///
  /// In en, this message translates to:
  /// **'Add a shared transaction field here, or go back and create a rule, before this application can process notifications.'**
  String get notificationsDefinitionSharedActionsNeedSetupMessage;

  /// Title of the card that opens shared transaction field actions.
  ///
  /// In en, this message translates to:
  /// **'Shared transaction fields'**
  String get notificationsDefinitionSharedTransactionFields;

  /// Error-style subtitle shown when shared transaction fields are empty and the definition still needs setup.
  ///
  /// In en, this message translates to:
  /// **'No shared fields configured'**
  String get notificationsDefinitionNoSharedFields;

  /// Basic-mode title for configuring transaction field actions.
  ///
  /// In en, this message translates to:
  /// **'Set transaction fields'**
  String get notificationsDefinitionSetTransactionFields;

  /// Error-style subtitle shown when basic transaction fields are empty and the definition still needs setup.
  ///
  /// In en, this message translates to:
  /// **'No transaction fields configured'**
  String get notificationsDefinitionNoTransactionFields;

  /// Basic-mode description of transaction field actions.
  ///
  /// In en, this message translates to:
  /// **'Set transaction fields for every matching notification.'**
  String get notificationsDefinitionBasicActionsDescription;

  /// Status message shown in the basic transaction fields editor when no transaction fields are configured.
  ///
  /// In en, this message translates to:
  /// **'Add at least one transaction field before this application can process notifications.'**
  String get notificationsDefinitionBasicActionsNeedSetupMessage;

  /// Attribution label for a resolved transaction value set by shared actions.
  ///
  /// In en, this message translates to:
  /// **'Shared actions'**
  String get notificationsDefinitionPreviewSharedActions;

  /// Heading for the resolved transaction fields section in a rule editor.
  ///
  /// In en, this message translates to:
  /// **'Resolved transaction fields'**
  String get notificationsDefinitionResolvedTransaction;

  /// Description for the resolved transaction values section in a rule editor.
  ///
  /// In en, this message translates to:
  /// **'Shows the transaction created from shared actions, always-run actions, and matching conditional actions. Later values override earlier ones.'**
  String get notificationsDefinitionResolvedTransactionDescription;

  /// Description for the group-scoped resolved transaction fields section in a conditional action editor.
  ///
  /// In en, this message translates to:
  /// **'Shows the transaction fields this conditional action resolves from the current sample.'**
  String get notificationsConditionalActionResolvedTransactionDescription;

  /// Empty state for an effective transaction preview.
  ///
  /// In en, this message translates to:
  /// **'No transaction fields resolve from this rule.'**
  String get notificationsDefinitionNoResolvedTransactionFields;

  /// Attribution label for a resolved transaction value set by the rule currently being edited.
  ///
  /// In en, this message translates to:
  /// **'This rule'**
  String get notificationsDefinitionPreviewThisRule;

  /// Attribution label for resolved tags contributed by more than one rule.
  ///
  /// In en, this message translates to:
  /// **'Multiple rules'**
  String get notificationsDefinitionPreviewMultipleRules;

  /// Attribution label for the rule that set a resolved transaction value.
  ///
  /// In en, this message translates to:
  /// **'Set by: {rule}'**
  String notificationsDefinitionPreviewSetBy(String rule);

  /// Attribution label listing earlier action sources overridden by the resolved transaction value.
  ///
  /// In en, this message translates to:
  /// **'Overrides: {sources}'**
  String notificationsDefinitionPreviewOverrides(String sources);

  /// Empty state for notification definition rules.
  ///
  /// In en, this message translates to:
  /// **'No rules defined.'**
  String get notificationsDefinitionNoRules;

  /// Condition and action counts for a conditional action group or a rule without conditional actions.
  ///
  /// In en, this message translates to:
  /// **'{conditions, plural, =0{No conditions} =1{1 condition} other{{conditions} conditions}} · {actions, plural, =0{No actions} =1{1 action} other{{actions} actions}}'**
  String notificationsDefinitionConditionActionCount(
    int conditions,
    int actions,
  );

  /// Condition, always-run action, and conditional action counts for a rule with conditional actions.
  ///
  /// In en, this message translates to:
  /// **'{conditions, plural, =0{No conditions} =1{1 condition} other{{conditions} conditions}} · {actions, plural, =0{No always-run actions} =1{1 always-run action} other{{actions} always-run actions}} · {groups, plural, =1{1 conditional action} other{{groups} conditional actions}}'**
  String notificationsDefinitionRuleConditionActionGroupCount(
    int conditions,
    int actions,
    int groups,
  );

  /// Heading for notification definition setup mode.
  ///
  /// In en, this message translates to:
  /// **'Set up notification processing'**
  String get notificationsDefinitionSetupHeading;

  /// Description for notification definition setup mode.
  ///
  /// In en, this message translates to:
  /// **'Choose how Waterfly reads this app\'s notifications and turns them into transactions.'**
  String get notificationsDefinitionSetupDescription;

  /// Warning shown before a sample notification is provided.
  ///
  /// In en, this message translates to:
  /// **'Add a sample notification before choosing a setup option.'**
  String get notificationsDefinitionSetupSampleRequired;

  /// Basic notification processing mode.
  ///
  /// In en, this message translates to:
  /// **'Basic'**
  String get notificationsDefinitionBasic;

  /// Description for basic notification processing mode.
  ///
  /// In en, this message translates to:
  /// **'Use built-in extractors and standard transaction mappings. Review uncertain values before creating a transaction.'**
  String get notificationsDefinitionBasicDescription;

  /// Advanced notification processing mode.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get notificationsDefinitionAdvanced;

  /// Description for advanced notification processing mode.
  ///
  /// In en, this message translates to:
  /// **'Create your own extractors and rules for full control over how notifications become transactions.'**
  String get notificationsDefinitionAdvancedDescription;

  /// Description for the notification title property extractor.
  ///
  /// In en, this message translates to:
  /// **'Uses the notification title supplied by the source app.'**
  String get notificationsExtractorUsesTitle;

  /// Description for the notification message property extractor.
  ///
  /// In en, this message translates to:
  /// **'Uses the notification message supplied by the source app.'**
  String get notificationsExtractorUsesMessage;

  /// Description for the notification date property extractor.
  ///
  /// In en, this message translates to:
  /// **'Uses the time Android recorded when the notification arrived.'**
  String get notificationsExtractorUsesReceivedTime;

  /// Label for a notification title value.
  ///
  /// In en, this message translates to:
  /// **'Notification title'**
  String get notificationsExtractorNotificationTitle;

  /// Label for a notification message value.
  ///
  /// In en, this message translates to:
  /// **'Notification message'**
  String get notificationsExtractorNotificationMessage;

  /// Heading for an extractor description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get notificationsExtractorDescription;

  /// Heading for extractor matches.
  ///
  /// In en, this message translates to:
  /// **'Matches'**
  String get notificationsExtractorMatches;

  /// Description of property extractor match highlighting.
  ///
  /// In en, this message translates to:
  /// **'Captured values are highlighted in the matching sample field.'**
  String get notificationsExtractorPropertyMatchesDescription;

  /// Heading for an extractor pattern.
  ///
  /// In en, this message translates to:
  /// **'Pattern'**
  String get notificationsExtractorPattern;

  /// Description for an editable extractor pattern.
  ///
  /// In en, this message translates to:
  /// **'Edit the regular expression and preview matches in the sample notification.'**
  String get notificationsExtractorPatternEditableDescription;

  /// Description for a read-only extractor pattern.
  ///
  /// In en, this message translates to:
  /// **'This built-in pattern is managed by Basic mode and cannot be edited here.'**
  String get notificationsExtractorPatternReadOnlyDescription;

  /// Field label for an extractor regular expression.
  ///
  /// In en, this message translates to:
  /// **'Regular expression'**
  String get notificationsExtractorRegularExpression;

  /// Tooltip for pasting an extractor regular expression.
  ///
  /// In en, this message translates to:
  /// **'Paste regular expression'**
  String get notificationsExtractorPasteRegularExpression;

  /// Description of regular expression match highlighting.
  ///
  /// In en, this message translates to:
  /// **'Regular expression matches are highlighted in the sample notification.'**
  String get notificationsExtractorPatternMatchesDescription;

  /// Label for a regular expression match.
  ///
  /// In en, this message translates to:
  /// **'Match'**
  String get notificationsExtractorMatch;

  /// Label for a numbered regular expression match.
  ///
  /// In en, this message translates to:
  /// **'Match {count}'**
  String notificationsExtractorMatchNumber(int count);

  /// Value type label for text.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get notificationsValueTypeText;

  /// Value type label for a number.
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get notificationsValueTypeNumber;

  /// Value type label for a currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get notificationsValueTypeCurrency;

  /// Value type label for a date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get notificationsValueTypeDate;

  /// Value type label for a time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get notificationsValueTypeTime;

  /// Value type label for a date and time.
  ///
  /// In en, this message translates to:
  /// **'Date and time'**
  String get notificationsValueTypeDateTime;

  /// Empty state in the extractor capture picker.
  ///
  /// In en, this message translates to:
  /// **'No matching extractor captures are available.'**
  String get notificationsCaptureEmpty;

  /// Number of captured regular expression groups.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No captured groups} =1{1 captured group} other{{count} captured groups}}'**
  String notificationsCaptureGroupCount(int count);

  /// Breadcrumb for an extractor match.
  ///
  /// In en, this message translates to:
  /// **'{name} > Match {count}'**
  String notificationsCaptureExtractorMatch(String name, int count);

  /// Prefix for a quoted capture group name.
  ///
  /// In en, this message translates to:
  /// **'Group \"'**
  String get notificationsCaptureGroupPrefix;

  /// Prefix for a quoted group in a numbered match.
  ///
  /// In en, this message translates to:
  /// **'Match {count} - Group \"'**
  String notificationsCaptureMatchGroupPrefix(int count);

  /// Prefix for a quoted resolved value.
  ///
  /// In en, this message translates to:
  /// **'Resolved value: \"'**
  String get notificationsResolvedValuePrefix;

  /// Title for the rename notification rule dialog.
  ///
  /// In en, this message translates to:
  /// **'Rename rule'**
  String get notificationsRuleRenameTitle;

  /// Description for the rename notification rule dialog.
  ///
  /// In en, this message translates to:
  /// **'Choose a name that describes when this rule applies.'**
  String get notificationsRuleRenameDescription;

  /// Title for editing a rule's name and description.
  ///
  /// In en, this message translates to:
  /// **'Edit rule details'**
  String get notificationsRuleEditDetailsTitle;

  /// Description for editing rule details.
  ///
  /// In en, this message translates to:
  /// **'Use a clear name and optionally describe when this rule should be used.'**
  String get notificationsRuleEditDetailsDescription;

  /// Status text for a value that could not be resolved.
  ///
  /// In en, this message translates to:
  /// **'unresolved'**
  String get notificationsUnresolved;

  /// Label before a resolved value.
  ///
  /// In en, this message translates to:
  /// **'Resolved value: '**
  String get notificationsResolvedValueLabel;

  /// Label before a localized representation of a raw extractor value.
  ///
  /// In en, this message translates to:
  /// **'Localized value: '**
  String get notificationsLocalizedValueLabel;

  /// Capitalized prefix before an extractor name.
  ///
  /// In en, this message translates to:
  /// **'Extractor '**
  String get notificationsRuleExtractor;

  /// Lowercase prefix before an extractor name.
  ///
  /// In en, this message translates to:
  /// **'extractor '**
  String get notificationsRuleExtractorLowercase;

  /// Suffix after an extractor name in a condition summary.
  ///
  /// In en, this message translates to:
  /// **' value'**
  String get notificationsRuleValueSuffix;

  /// Condition summary operator.
  ///
  /// In en, this message translates to:
  /// **'exists'**
  String get notificationsConditionExists;

  /// Condition summary operator.
  ///
  /// In en, this message translates to:
  /// **'equals'**
  String get notificationsConditionEquals;

  /// Condition summary operator.
  ///
  /// In en, this message translates to:
  /// **'contains'**
  String get notificationsConditionContains;

  /// Condition summary operator.
  ///
  /// In en, this message translates to:
  /// **'is greater than'**
  String get notificationsConditionGreaterThan;

  /// Condition kind label.
  ///
  /// In en, this message translates to:
  /// **'Greater than'**
  String get notificationsConditionGreaterThanLabel;

  /// Condition summary operator.
  ///
  /// In en, this message translates to:
  /// **'is at least'**
  String get notificationsConditionAtLeast;

  /// Condition kind label.
  ///
  /// In en, this message translates to:
  /// **'At least'**
  String get notificationsConditionAtLeastLabel;

  /// Condition summary operator.
  ///
  /// In en, this message translates to:
  /// **'is less than'**
  String get notificationsConditionLessThan;

  /// Condition kind label.
  ///
  /// In en, this message translates to:
  /// **'Less than'**
  String get notificationsConditionLessThanLabel;

  /// Condition summary operator.
  ///
  /// In en, this message translates to:
  /// **'is at most'**
  String get notificationsConditionAtMost;

  /// Condition kind label.
  ///
  /// In en, this message translates to:
  /// **'At most'**
  String get notificationsConditionAtMostLabel;

  /// Prefix for an optional transaction field action.
  ///
  /// In en, this message translates to:
  /// **'Optional field '**
  String get notificationsRuleOptionalFieldPrefix;

  /// Prefix for a transaction field action.
  ///
  /// In en, this message translates to:
  /// **'Set field '**
  String get notificationsRuleSetFieldPrefix;

  /// Fragment before an extractor in an action summary.
  ///
  /// In en, this message translates to:
  /// **' from extractor '**
  String get notificationsRuleFromExtractorPrefix;

  /// Fragment before an action value in an action summary.
  ///
  /// In en, this message translates to:
  /// **' to '**
  String get notificationsRuleToPrefix;

  /// Value-source label for a literal transaction action.
  ///
  /// In en, this message translates to:
  /// **'literal value'**
  String get notificationsRuleLiteralValue;

  /// Value-source label for a Firefly-provided transaction action.
  ///
  /// In en, this message translates to:
  /// **'Firefly supplied value'**
  String get notificationsRuleFireflySuppliedValue;

  /// Title for the sample notification dialog.
  ///
  /// In en, this message translates to:
  /// **'Add sample notification'**
  String get notificationsSampleAddTitle;

  /// Title for the sample notification dialog when a sample exists.
  ///
  /// In en, this message translates to:
  /// **'Change sample notification'**
  String get notificationsSampleChangeTitle;

  /// Description for the sample notification dialog.
  ///
  /// In en, this message translates to:
  /// **'Enter a representative notification title, message, and received time to preview your extractors and rules.'**
  String get notificationsSampleDescription;

  /// Description for the sample notification dialog opened from an extractor.
  ///
  /// In en, this message translates to:
  /// **'Enter a notification title, message, and received time to test this extractor. This sample applies only to this extractor.'**
  String get notificationsSampleExtractorDescription;

  /// Description for the sample notification dialog opened from a rule.
  ///
  /// In en, this message translates to:
  /// **'Enter a notification title, message, and received time to test this rule. This sample applies to the rule and its conditional actions.'**
  String get notificationsSampleRuleDescription;

  /// Description for the sample notification dialog opened from a conditional action.
  ///
  /// In en, this message translates to:
  /// **'Enter a notification title, message, and received time to test this conditional action. This sample applies only to this conditional action.'**
  String get notificationsSampleConditionalActionDescription;

  /// Description for the notification used to test a rule.
  ///
  /// In en, this message translates to:
  /// **'Use this notification only to test this rule. It does not change the definition\'s sample notification.'**
  String get notificationsRuleTestSampleDescription;

  /// Label identifying a sample notification source application.
  ///
  /// In en, this message translates to:
  /// **'Notification source'**
  String get notificationsSampleSource;

  /// Button label that advances notification setup.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get notificationsContinue;

  /// Button label that applies sample notification changes.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get notificationsApply;

  /// Description for application selection.
  ///
  /// In en, this message translates to:
  /// **'Choose the app whose notifications you want Waterfly to process.'**
  String get notificationsApplicationsChooseDescription;

  /// Explanation of filtered application candidates.
  ///
  /// In en, this message translates to:
  /// **'Suggested apps are shown first. Apps already configured are hidden.'**
  String get notificationsApplicationsLikelySendersDescription;

  /// Section title for likely notification sender application candidates.
  ///
  /// In en, this message translates to:
  /// **'Suggested apps'**
  String get notificationsApplicationsSuggestedTitle;

  /// Section title for the complete installed application list.
  ///
  /// In en, this message translates to:
  /// **'All installed apps'**
  String get notificationsApplicationsAllTitle;

  /// Field label for searching installed applications.
  ///
  /// In en, this message translates to:
  /// **'Search applications'**
  String get notificationsApplicationsSearch;

  /// Error state for loading application candidates.
  ///
  /// In en, this message translates to:
  /// **'Applications could not be loaded.'**
  String get notificationsApplicationsLoadFailure;

  /// Empty state when the application search query has no matches.
  ///
  /// In en, this message translates to:
  /// **'No applications match your search.'**
  String get notificationsApplicationsNoSearchMatches;

  /// Empty state when every suggested notification sender has already been registered.
  ///
  /// In en, this message translates to:
  /// **'All suggested applications are already registered.'**
  String get notificationsApplicationsSuggestedRegistered;

  /// Empty state when every installed application has already been registered.
  ///
  /// In en, this message translates to:
  /// **'All installed applications are already registered.'**
  String get notificationsApplicationsAllRegistered;

  /// Empty state when no installed application is an eligible suggested notification sender.
  ///
  /// In en, this message translates to:
  /// **'No suggested applications are available. Try viewing all installed apps.'**
  String get notificationsApplicationsNoneSuggested;

  /// Empty state when the device reports no installed applications.
  ///
  /// In en, this message translates to:
  /// **'No installed applications are available.'**
  String get notificationsApplicationsNoneInstalled;

  /// Transaction field label.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get notificationsFieldTitle;

  /// Transaction field label.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get notificationsFieldAmount;

  /// Transaction field label.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get notificationsFieldDate;

  /// Transaction field label.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get notificationsFieldTime;

  /// Transaction field label.
  ///
  /// In en, this message translates to:
  /// **'Source account'**
  String get notificationsFieldSourceAccount;

  /// Transaction field label.
  ///
  /// In en, this message translates to:
  /// **'Destination account'**
  String get notificationsFieldDestinationAccount;

  /// Transaction field label.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get notificationsFieldCategory;

  /// Transaction field label.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get notificationsFieldTags;

  /// Transaction field label.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notificationsFieldNotes;

  /// Transaction field label.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get notificationsFieldSubscription;

  /// Transaction field label.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get notificationsFieldCurrency;

  /// Transaction field label.
  ///
  /// In en, this message translates to:
  /// **'Piggy bank'**
  String get notificationsFieldPiggyBank;

  /// Transaction field validation error.
  ///
  /// In en, this message translates to:
  /// **'Amount must be a number.'**
  String get notificationsFieldInvalidAmount;

  /// Transaction field validation error.
  ///
  /// In en, this message translates to:
  /// **'Date must be an ISO-8601 date.'**
  String get notificationsFieldInvalidDate;

  /// Transaction field validation error.
  ///
  /// In en, this message translates to:
  /// **'Time must use HH:mm or HH:mm:ss.'**
  String get notificationsFieldInvalidTime;

  /// Transaction action dialog title.
  ///
  /// In en, this message translates to:
  /// **'Add action'**
  String get notificationsActionSelectField;

  /// Transaction action dialog title.
  ///
  /// In en, this message translates to:
  /// **'Set {field}'**
  String notificationsActionSetField(String field);

  /// Transaction action dialog description.
  ///
  /// In en, this message translates to:
  /// **'Choose the transaction field this rule should set.'**
  String get notificationsActionChooseField;

  /// Transaction action dialog description.
  ///
  /// In en, this message translates to:
  /// **'Choose the value source for this transaction field.'**
  String get notificationsActionChooseSource;

  /// Transaction action source label.
  ///
  /// In en, this message translates to:
  /// **'Extractor capture'**
  String get notificationsActionExtractorCapture;

  /// Transaction action source description.
  ///
  /// In en, this message translates to:
  /// **'Use a value captured by an extractor, selected by capture name or match position.'**
  String get notificationsActionExtractorCaptureDescription;

  /// Transaction action source label.
  ///
  /// In en, this message translates to:
  /// **'Literal value'**
  String get notificationsActionLiteralValue;

  /// Transaction action source description.
  ///
  /// In en, this message translates to:
  /// **'Enter a value to use for every matching notification.'**
  String get notificationsActionLiteralDescription;

  /// Transaction action source label.
  ///
  /// In en, this message translates to:
  /// **'Build text'**
  String get notificationsActionBuildText;

  /// Transaction action source description.
  ///
  /// In en, this message translates to:
  /// **'Combine extractor captures and fixed text in order.'**
  String get notificationsActionBuildTextDescription;

  /// Empty state in the build text editor.
  ///
  /// In en, this message translates to:
  /// **'Add a part to start building the text.'**
  String get notificationsActionBuildTextEmpty;

  /// Button for adding a build text part.
  ///
  /// In en, this message translates to:
  /// **'Add part'**
  String get notificationsActionBuildTextAddPart;

  /// Build text preview label.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get notificationsActionBuildTextPreview;

  /// Heading above the ordered parts in the Build Text action editor.
  ///
  /// In en, this message translates to:
  /// **'Parts'**
  String get notificationsActionBuildTextParts;

  /// Build text unresolved preview.
  ///
  /// In en, this message translates to:
  /// **'Preview unavailable because a capture did not resolve.'**
  String get notificationsActionBuildTextUnresolved;

  /// Build text part type.
  ///
  /// In en, this message translates to:
  /// **'Extractor capture'**
  String get notificationsActionBuildTextCapturePart;

  /// Build text part type.
  ///
  /// In en, this message translates to:
  /// **'Fixed text'**
  String get notificationsActionBuildTextFixedPart;

  /// Fixed text editor title.
  ///
  /// In en, this message translates to:
  /// **'Choose fixed text'**
  String get notificationsActionBuildTextFixedPrompt;

  /// Custom fixed text option.
  ///
  /// In en, this message translates to:
  /// **'Custom text'**
  String get notificationsActionBuildTextCustom;

  /// Fixed text preset.
  ///
  /// In en, this message translates to:
  /// **'Space'**
  String get notificationsActionBuildTextSpace;

  /// Fixed text preset.
  ///
  /// In en, this message translates to:
  /// **'Line break'**
  String get notificationsActionBuildTextLineBreak;

  /// Fixed text preset.
  ///
  /// In en, this message translates to:
  /// **'Blank line'**
  String get notificationsActionBuildTextBlankLine;

  /// Fixed text preset.
  ///
  /// In en, this message translates to:
  /// **'Dash'**
  String get notificationsActionBuildTextDash;

  /// Fixed text preset.
  ///
  /// In en, this message translates to:
  /// **'Colon'**
  String get notificationsActionBuildTextColon;

  /// Build text part action.
  ///
  /// In en, this message translates to:
  /// **'Move up'**
  String get notificationsActionBuildTextMoveUp;

  /// Build text part action.
  ///
  /// In en, this message translates to:
  /// **'Move down'**
  String get notificationsActionBuildTextMoveDown;

  /// Transaction action source label.
  ///
  /// In en, this message translates to:
  /// **'Select from Firefly'**
  String get notificationsActionSelectFirefly;

  /// Transaction action source description.
  ///
  /// In en, this message translates to:
  /// **'Choose a value from your existing Firefly data.'**
  String get notificationsActionFireflyDescription;

  /// Disabled transaction field description.
  ///
  /// In en, this message translates to:
  /// **'Already set by this rule.'**
  String get notificationsActionAlreadySet;

  /// Firefly resource picker field label.
  ///
  /// In en, this message translates to:
  /// **'Search Firefly'**
  String get notificationsActionSearchFirefly;

  /// Tag selector description for notification actions.
  ///
  /// In en, this message translates to:
  /// **'Choose the tags added to the transaction when this rule runs.'**
  String get notificationsTagsRuleDescription;

  /// Message shown when Firefly tags cannot be loaded for a notification action.
  ///
  /// In en, this message translates to:
  /// **'Tags could not be loaded.'**
  String get notificationsActionTagsLoadFailure;

  /// Description for choosing a condition category.
  ///
  /// In en, this message translates to:
  /// **'Choose the kind of condition to add.'**
  String get notificationsConditionChooseCategory;

  /// Category for conditions that evaluate notification or extracted values.
  ///
  /// In en, this message translates to:
  /// **'Value condition'**
  String get notificationsConditionValueCategory;

  /// Description of the value condition category.
  ///
  /// In en, this message translates to:
  /// **'Check whether a value exists, contains text, or compares with another value.'**
  String get notificationsConditionValueCategoryDescription;

  /// Category for conditions that contain or modify other conditions.
  ///
  /// In en, this message translates to:
  /// **'Condition group'**
  String get notificationsConditionGroupCategory;

  /// Description of the condition group category.
  ///
  /// In en, this message translates to:
  /// **'Combine multiple conditions or invert another condition.'**
  String get notificationsConditionGroupCategoryDescription;

  /// Description for choosing a value condition type.
  ///
  /// In en, this message translates to:
  /// **'Choose how values should be evaluated.'**
  String get notificationsConditionChooseValueKind;

  /// Description for choosing a condition group type.
  ///
  /// In en, this message translates to:
  /// **'Choose how nested conditions should be combined.'**
  String get notificationsConditionChooseGroupKind;

  /// Explanation shown when nested condition groups can no longer be added.
  ///
  /// In en, this message translates to:
  /// **'The maximum of {maximumDepth} nested condition levels has been reached. Choose an individual condition, or split complex logic across rules or conditional-action groups.'**
  String notificationsConditionMaximumNestingDescription(int maximumDepth);

  /// Explanation shown for a redundant nested condition group.
  ///
  /// In en, this message translates to:
  /// **'This group is supplied by its parent condition.'**
  String get notificationsConditionMergedGroupDescription;

  /// Information shown when matching nested condition groups are flattened.
  ///
  /// In en, this message translates to:
  /// **'Merged nested condition groups.'**
  String get notificationsRuleFlattenedGroups;

  /// Condition source label.
  ///
  /// In en, this message translates to:
  /// **'Extractor capture'**
  String get notificationsConditionExtractorCapture;

  /// Condition source label.
  ///
  /// In en, this message translates to:
  /// **'Literal value'**
  String get notificationsConditionLiteralValue;

  /// Condition source description.
  ///
  /// In en, this message translates to:
  /// **'Use a value captured from the notification.'**
  String get notificationsConditionUseCapture;

  /// Condition capture picker empty message.
  ///
  /// In en, this message translates to:
  /// **'No extractor captures are available for this sample.'**
  String get notificationsConditionNoCaptures;

  /// Condition editor menu tooltip.
  ///
  /// In en, this message translates to:
  /// **'Change value type'**
  String get notificationsConditionChangeValueType;

  /// Fallback extractor name.
  ///
  /// In en, this message translates to:
  /// **'Deleted extractor'**
  String get notificationsConditionDeletedExtractor;

  /// Condition literal value type.
  ///
  /// In en, this message translates to:
  /// **'Number value'**
  String get notificationsConditionNumberValue;

  /// Condition literal value type.
  ///
  /// In en, this message translates to:
  /// **'Date and time value'**
  String get notificationsConditionDateTimeValue;

  /// Condition literal value type.
  ///
  /// In en, this message translates to:
  /// **'Date value'**
  String get notificationsConditionDateValue;

  /// Condition literal value type.
  ///
  /// In en, this message translates to:
  /// **'Time value'**
  String get notificationsConditionTimeValue;

  /// Condition literal type description.
  ///
  /// In en, this message translates to:
  /// **'Enter fixed text.'**
  String get notificationsConditionTextDescription;

  /// Condition literal type description.
  ///
  /// In en, this message translates to:
  /// **'Enter a numeric value.'**
  String get notificationsConditionNumberDescription;

  /// Condition literal type description.
  ///
  /// In en, this message translates to:
  /// **'Choose a date and time.'**
  String get notificationsConditionDateTimeDescription;

  /// Condition literal type description.
  ///
  /// In en, this message translates to:
  /// **'Enter or choose an ISO date.'**
  String get notificationsConditionDateDescription;

  /// Condition literal type description.
  ///
  /// In en, this message translates to:
  /// **'Enter or choose a time.'**
  String get notificationsConditionTimeDescription;

  /// Condition kind label.
  ///
  /// In en, this message translates to:
  /// **'Any condition matches'**
  String get notificationsConditionAny;

  /// Condition kind description.
  ///
  /// In en, this message translates to:
  /// **'Require at least one nested condition to match.'**
  String get notificationsConditionAnyDescription;

  /// Condition kind label.
  ///
  /// In en, this message translates to:
  /// **'All conditions match'**
  String get notificationsConditionAll;

  /// Condition kind description.
  ///
  /// In en, this message translates to:
  /// **'Require every nested condition to match.'**
  String get notificationsConditionAllDescription;

  /// Condition kind label.
  ///
  /// In en, this message translates to:
  /// **'Condition does not match'**
  String get notificationsConditionNot;

  /// Condition kind description.
  ///
  /// In en, this message translates to:
  /// **'Invert a single nested condition.'**
  String get notificationsConditionNotDescription;

  /// Condition kind label.
  ///
  /// In en, this message translates to:
  /// **'Value exists'**
  String get notificationsConditionExistsLabel;

  /// Condition kind description.
  ///
  /// In en, this message translates to:
  /// **'Require a value to be available.'**
  String get notificationsConditionExistsDescription;

  /// Condition kind label.
  ///
  /// In en, this message translates to:
  /// **'Equals value'**
  String get notificationsConditionEqualsLabel;

  /// Condition kind label.
  ///
  /// In en, this message translates to:
  /// **'Contains text'**
  String get notificationsConditionContainsLabel;

  /// Condition kind description.
  ///
  /// In en, this message translates to:
  /// **'Compare two numeric values.'**
  String get notificationsConditionComparisonDescription;

  /// Condition builder title.
  ///
  /// In en, this message translates to:
  /// **'Choose condition to negate'**
  String get notificationsConditionSelectNegated;

  /// Condition builder title.
  ///
  /// In en, this message translates to:
  /// **'Edit condition'**
  String get notificationsConditionEdit;

  /// Condition builder description.
  ///
  /// In en, this message translates to:
  /// **'Choose the value to compare with.'**
  String get notificationsConditionCompareDescription;

  /// Condition builder description.
  ///
  /// In en, this message translates to:
  /// **'Choose the value this condition evaluates.'**
  String get notificationsConditionValueDescription;

  /// Condition builder description.
  ///
  /// In en, this message translates to:
  /// **'Review the condition before applying it.'**
  String get notificationsConditionReview;

  /// Condition date time picker prompt.
  ///
  /// In en, this message translates to:
  /// **'Choose date and time'**
  String get notificationsConditionChooseDateTime;

  /// Action dialog back button.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get notificationsActionBack;

  /// Action dialog save button.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get notificationsActionSave;

  /// Currency capture mapping title.
  ///
  /// In en, this message translates to:
  /// **'Match extracted currency'**
  String get notificationsActionMatchCurrency;

  /// Currency mapping description.
  ///
  /// In en, this message translates to:
  /// **'Choose the Firefly currency for the captured value.'**
  String get notificationsActionChooseCurrency;

  /// Currency mapping search field label.
  ///
  /// In en, this message translates to:
  /// **'Search Firefly currencies'**
  String get notificationsActionSearchCurrencies;

  /// Currency mapping load error.
  ///
  /// In en, this message translates to:
  /// **'Firefly currencies could not be loaded.'**
  String get notificationsActionCurrenciesLoadFailure;

  /// Fallback captured value label.
  ///
  /// In en, this message translates to:
  /// **'no value'**
  String get notificationsActionNoValue;

  /// Currency capture mapping description.
  ///
  /// In en, this message translates to:
  /// **'Extracted value \"{value}\". Select its matching Firefly currency.'**
  String notificationsActionExtractedCurrency(String value);

  /// Transaction field description.
  ///
  /// In en, this message translates to:
  /// **'The transaction description shown in Firefly.'**
  String get notificationsFieldTitleDescription;

  /// Transaction field description.
  ///
  /// In en, this message translates to:
  /// **'A numeric amount, such as 12.50.'**
  String get notificationsFieldAmountDescription;

  /// Transaction field description.
  ///
  /// In en, this message translates to:
  /// **'An ISO date in the form YYYY-MM-DD.'**
  String get notificationsFieldDateDescription;

  /// Transaction field description.
  ///
  /// In en, this message translates to:
  /// **'A time in the form HH:mm or HH:mm:ss.'**
  String get notificationsFieldTimeDescription;

  /// Transaction field description.
  ///
  /// In en, this message translates to:
  /// **'The account the money is sent from.'**
  String get notificationsFieldSourceAccountDescription;

  /// Transaction field description.
  ///
  /// In en, this message translates to:
  /// **'The account the money is sent to.'**
  String get notificationsFieldDestinationAccountDescription;

  /// Transaction field description.
  ///
  /// In en, this message translates to:
  /// **'A Firefly category for the transaction.'**
  String get notificationsFieldCategoryDescription;

  /// Transaction field description.
  ///
  /// In en, this message translates to:
  /// **'One or more Firefly tags.'**
  String get notificationsFieldTagsDescription;

  /// Transaction field description.
  ///
  /// In en, this message translates to:
  /// **'Extra information attached to the transaction.'**
  String get notificationsFieldNotesDescription;

  /// Transaction field description.
  ///
  /// In en, this message translates to:
  /// **'A matching Firefly subscription.'**
  String get notificationsFieldSubscriptionDescription;

  /// Transaction field description.
  ///
  /// In en, this message translates to:
  /// **'The currency used for the transaction.'**
  String get notificationsFieldCurrencyDescription;

  /// Transaction field description.
  ///
  /// In en, this message translates to:
  /// **'A Firefly piggy bank to associate.'**
  String get notificationsFieldPiggyBankDescription;

  /// Date picker tooltip.
  ///
  /// In en, this message translates to:
  /// **'Choose date'**
  String get notificationsActionChooseDate;

  /// Time picker tooltip.
  ///
  /// In en, this message translates to:
  /// **'Choose time'**
  String get notificationsActionChooseTime;

  /// Description of actions in a conditional action group.
  ///
  /// In en, this message translates to:
  /// **'Run when this group matches. These values override shared and always-run actions, and later groups can override them.'**
  String get notificationsRuleConditionalGroupActionsDescription;

  /// Currency mapping empty state.
  ///
  /// In en, this message translates to:
  /// **'No matching Firefly currencies found.'**
  String get notificationsActionNoCurrencies;
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ca',
    'cs',
    'da',
    'de',
    'en',
    'es',
    'fa',
    'fr',
    'hu',
    'id',
    'it',
    'ko',
    'nl',
    'pl',
    'pt',
    'ro',
    'ru',
    'sl',
    'sv',
    'tr',
    'uk',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return SPtBr();
        }
        break;
      }
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'TW':
            return SZhTw();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ca':
      return SCa();
    case 'cs':
      return SCs();
    case 'da':
      return SDa();
    case 'de':
      return SDe();
    case 'en':
      return SEn();
    case 'es':
      return SEs();
    case 'fa':
      return SFa();
    case 'fr':
      return SFr();
    case 'hu':
      return SHu();
    case 'id':
      return SId();
    case 'it':
      return SIt();
    case 'ko':
      return SKo();
    case 'nl':
      return SNl();
    case 'pl':
      return SPl();
    case 'pt':
      return SPt();
    case 'ro':
      return SRo();
    case 'ru':
      return SRu();
    case 'sl':
      return SSl();
    case 'sv':
      return SSv();
    case 'tr':
      return STr();
    case 'uk':
      return SUk();
    case 'zh':
      return SZh();
  }

  throw FlutterError(
    'S.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
