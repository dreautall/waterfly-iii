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
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ro.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_sl.dart';
import 'app_localizations_sv.dart';
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
    Locale('pl'),
    Locale('pt'),
    Locale('ro'),
    Locale('ru'),
    Locale('sl'),
    Locale('sv'),
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

  /// How much money should be saved
  ///
  /// In en, this message translates to:
  /// **'Target amount: {amount}'**
  String homePiggyTarget(String amount);

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

  /// Login Form: Label for API Key field
  ///
  /// In en, this message translates to:
  /// **'Valid API Key'**
  String get loginFormLabelAPIKey;

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

  /// Navigation Label: Settings
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navigationSettings;

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
  /// **'Require authenticiation on app startup'**
  String get settingsLockscreenHelp;

  /// Prompt to authenticate once to set up the lockscreen
  ///
  /// In en, this message translates to:
  /// **'Please authenticate to enable the lock screen.'**
  String get settingsLockscreenInitial;

  /// Default account which will be used for the transaction.
  ///
  /// In en, this message translates to:
  /// **'Default Account'**
  String get settingsNLAppAccount;

  /// Account will be selected dynamically by the content of the notification.
  ///
  /// In en, this message translates to:
  /// **'<Dynamic>'**
  String get settingsNLAppAccountDynamic;

  /// Button title to add a new app.
  ///
  /// In en, this message translates to:
  /// **'Add App'**
  String get settingsNLAppAdd;

  /// Help text below adding the new app button.
  ///
  /// In en, this message translates to:
  /// **'Click to add an app to listen to. Only eligible apps will show up in the list.'**
  String get settingsNLAppAddHelp;

  /// Help text when no more app is available to add.
  ///
  /// In en, this message translates to:
  /// **'Make some transactions where you receive phone notifications to add apps to this list. If the app still doesn\'t show up, please report it to app@vogt.pw.'**
  String get settingsNLAppAddInfo;

  /// With this setting enabled, the transaction will be added automatically without further user interaction.
  ///
  /// In en, this message translates to:
  /// **'Create transaction without interaction'**
  String get settingsNLAutoAdd;

  /// Description text for the notification listener service.
  ///
  /// In en, this message translates to:
  /// **'This service allows you to fetch transaction details from incoming push notifications. Additionally, you can select a default account which the transaction should be assigned to - if no value is set, it tries to extract an account from the notification.'**
  String get settingsNLDescription;

  /// Usually the note field will be pre-filled with the notification details. With this setting enabled, it will be empty instead.
  ///
  /// In en, this message translates to:
  /// **'Keep note field empty'**
  String get settingsNLEmptyNote;

  /// Indicates user should tap the text to grant certain permissions (notification access).
  ///
  /// In en, this message translates to:
  /// **'Tap to grant permission.'**
  String get settingsNLPermissionGrant;

  /// A requested permission was not granted.
  ///
  /// In en, this message translates to:
  /// **'Permission not granted.'**
  String get settingsNLPermissionNotGranted;

  /// Dialog title asking if permission should be removed.
  ///
  /// In en, this message translates to:
  /// **'Remove permission?'**
  String get settingsNLPermissionRemove;

  /// Dialog text giving hint how to remove the permission.
  ///
  /// In en, this message translates to:
  /// **'To disable this service, click on the app and remove the permissions in the next screen.'**
  String get settingsNLPermissionRemoveHelp;

  /// Setting pre-fill transaction title with notification title.
  ///
  /// In en, this message translates to:
  /// **'Prefill transaction title with notification title'**
  String get settingsNLPrefillTXTitle;

  /// Checking the status of the background service
  ///
  /// In en, this message translates to:
  /// **'Checking status…'**
  String get settingsNLServiceChecking;

  /// An error occurred while checking the service status
  ///
  /// In en, this message translates to:
  /// **'Error checking status: {error}'**
  String settingsNLServiceCheckingError(String error);

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
    'pl',
    'pt',
    'ro',
    'ru',
    'sl',
    'sv',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {
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
