// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class SFa extends S {
  SFa([String locale = 'fa']) : super(locale);

  @override
  String get accountRoleAssetCashWallet => 'کیف پول نقد\n';

  @override
  String get accountRoleAssetCC => 'کارت اعتباری';

  @override
  String get accountRoleAssetDefault => 'حساب دارایی پیش فرض\n';

  @override
  String get accountRoleAssetSavings => 'حساب پس انداز';

  @override
  String get accountRoleAssetShared => 'حساب دارایی مشترک\n';

  @override
  String get accountsLabelAsset => 'حساب های دارایی';

  @override
  String get accountsLabelExpense => 'حساب‌های هزینه';

  @override
  String get accountsLabelLiabilities => 'بدهی ها';

  @override
  String get accountsLabelRevenue => 'حساب‌های درآمد';

  @override
  String accountsLiabilitiesInterest(double interest, String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'هفته',
      'monthly': 'ماه',
      'quarterly': 'سه‌ماهه',
      'halfyear': 'نیم‌ساله',
      'yearly': 'سال',
      'other': 'نامشخص',
    });
    return '$interest% سود به ازای هر $_temp0';
  }

  @override
  String billsAmountAndFrequency(
    String minValue,
    String maxvalue,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'هفتگی',
      'monthly': 'ماهیانه',
      'quarterly': 'سه‌ماهه',
      'halfyear': 'نیم‌ساله',
      'yearly': 'سالیانه',
      'other': 'نامشخص',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: '، از $skip گذر می‌کند',
      zero: '',
    );
    return 'قبض مطابق با تراکنش‌ها بین $minValue و $maxvalue است. تکرارها $_temp0$_temp1.';
  }

  @override
  String get billsChangeLayoutTooltip => 'تغییر چیدمان';

  @override
  String get billsChangeSortOrderTooltip => 'تغییر ترتیب مرتب‌سازی\n';

  @override
  String get billsErrorLoading => 'خطا در بارگیری صورتحساب.\n';

  @override
  String billsExactAmountAndFrequency(
    String value,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'هفتگی',
      'monthly': 'ماهیانه',
      'quarterly': 'سه‌ماهه',
      'halfyear': 'نیم‌ساله',
      'yearly': 'سالیانه',
      'other': 'نامشخص',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: '، از $skip گذر می‌کند',
      zero: '',
    );
    return 'قبض با تراکنش‌های مبلغ $value مطابقت دارد. تکرارها $_temp0$_temp1.';
  }

  @override
  String billsExpectedOn(DateTime date) {
    return 'تاریخ مورد انتظار: :date\n\n\n\n\n\n';
  }

  @override
  String billsFrequency(String frequency) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'هفتگی',
      'monthly': 'ماهیانه',
      'quarterly': 'سه‌ماهه',
      'halfyear': 'نیم‌ساله',
      'yearly': 'سالیانه',
      'other': 'نامشخص',
    });
    return '$_temp0';
  }

  @override
  String billsFrequencySkip(String frequency, num skip) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'هفتگی',
      'monthly': 'ماهیانه',
      'quarterly': 'سه‌ماهه',
      'halfyear': 'نیم‌ساله',
      'yearly': 'سالیانه',
      'other': 'نامشخص',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: '، از $skip گذر می‌کند',
      zero: '',
    );
    return '$_temp0$_temp1';
  }

  @override
  String get billsInactive => 'غیر فعال';

  @override
  String get billsIsActive => 'قبض فعال است\n\n\n\n\n\n';

  @override
  String get billsLayoutGroupSubtitle =>
      'صورت‌حساب‌ها در گروه‌های اختصاص داده شده نمایش داده می‌شوند.\n';

  @override
  String get billsLayoutGroupTitle => 'گروه';

  @override
  String get billsLayoutListSubtitle =>
      'صورت‌حساب‌ها در فهرستی که بر اساس معیارهای خاصی مرتب شده‌اند نمایش داده می‌شوند.\n';

  @override
  String get billsLayoutListTitle => 'لیست';

  @override
  String get billsListEmpty => 'لیست در حال حاضر خالی است.\n';

  @override
  String get billsNextExpectedMatch => 'مسابقه بعدی مورد انتظار\n';

  @override
  String get billsNotActive => 'قبض غیرفعال است\n\n\n\n\n\n';

  @override
  String get billsNotExpected => 'این دوره انتظار نمی رود\n';

  @override
  String get billsNoTransactions => 'هیچ تراکنشی یافت نشد';

  @override
  String billsPaidOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'پرداخت شده $dateString\n';
  }

  @override
  String get billsSortAlphabetical => 'الفبایی';

  @override
  String get billsSortByTimePeriod => 'بر اساس دوره زمانی\n';

  @override
  String get billsSortFrequency => 'فرکانس';

  @override
  String get billsSortName => 'نام';

  @override
  String get billsUngrouped => 'گروه‌بندی نشده';

  @override
  String get categoryDeleteConfirm =>
      'آیا مطمئن هستید که می‌خواهید این دسته را حذف کنید؟ تراکنش ها حذف نمی شوند، اما دیگر دسته بندی نخواهند داشت.\n';

  @override
  String get categoryErrorLoading => 'خطا در بارگیری دسته‌ها.\n';

  @override
  String get categoryFormLabelIncludeInSum => 'در جمع ماهیانه لحاظ شود\n';

  @override
  String get categoryFormLabelName => 'نام دسته';

  @override
  String get categoryMonthNext => 'ماه آینده';

  @override
  String get categoryMonthPrev => 'ماه قبل';

  @override
  String get categorySumExcluded => 'مستثتی شده';

  @override
  String get categoryTitleAdd => 'افزودن دسته';

  @override
  String get categoryTitleDelete => 'حذف دسته';

  @override
  String get categoryTitleEdit => 'ویرایش دسته‌ بندی';

  @override
  String get catNone => '<no category>';

  @override
  String get catOther => 'دیگر';

  @override
  String errorAPIInvalidResponse(String message) {
    return 'پاسخ نامعتبر از API: $message\n';
  }

  @override
  String get errorAPIUnavailable => 'API در دسترس نیست\n';

  @override
  String get errorFieldRequired => 'این فیلد الزامی است.\n';

  @override
  String get errorInvalidURL => 'آدرس نامعتبر';

  @override
  String errorMinAPIVersion(String requiredVersion) {
    return 'حداقل نسخه Firefly API v$requiredVersion مورد نیاز است. لطفا ارتقا دهید.\n';
  }

  @override
  String errorStatusCode(int code) {
    return 'کد وضعیت: $code\n';
  }

  @override
  String get errorUnknown => 'خطای ناشناخته.\n';

  @override
  String get formButtonHelp => 'راهنما';

  @override
  String get formButtonLogin => 'ورود';

  @override
  String get formButtonLogout => 'خروج از سیستم';

  @override
  String get formButtonRemove => 'پاک کردن';

  @override
  String get formButtonResetLogin => 'بازنشانی ورود به سیستم\n';

  @override
  String get formButtonTransactionAdd => 'افزودن تراکنش';

  @override
  String get formButtonTryAgain => 'دوباره سعی کنید';

  @override
  String get generalAccount => 'حساب';

  @override
  String get generalAssets => 'دارایی ها';

  @override
  String get generalBalance => 'مانده حساب';

  @override
  String generalBalanceOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'موجودی در تاریخ $dateString';
  }

  @override
  String get generalBill => 'صورت حساب';

  @override
  String get generalBudget => 'بودجه';

  @override
  String get generalCategory => 'دسته‌بندی';

  @override
  String get generalCurrency => 'واحدپول';

  @override
  String get generalDefault => 'پیش فرض';

  @override
  String get generalDestinationAccount => 'Destination Account';

  @override
  String get generalDismiss => 'نادیده گرفتن';

  @override
  String get generalEarned => 'به دست آورده';

  @override
  String get generalError => 'خطا';

  @override
  String get generalExpenses => 'هزینه ها';

  @override
  String get generalIncome => 'درآمد';

  @override
  String get generalLiabilities => 'بدهی ها';

  @override
  String get generalMultiple => 'چندتایی';

  @override
  String get generalNever => 'هرگز';

  @override
  String get generalReconcile => 'مغایرت گیری شده';

  @override
  String get generalReset => 'تنظیم مجدد';

  @override
  String get generalSourceAccount => 'Source Account';

  @override
  String get generalSpent => 'خرج شده';

  @override
  String get generalSum => 'مجموع';

  @override
  String get generalTarget => 'هدف';

  @override
  String get generalUnknown => 'ناشناخته';

  @override
  String homeMainBillsInterval(String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'هفتگی',
      'monthly': 'ماهیانه',
      'quarterly': 'سه‌ماهه',
      'halfyear': 'نیم‌ساله',
      'yearly': 'سالیانه',
      'other': 'نامشخص',
    });
    return '($_temp0)';
  }

  @override
  String get homeMainBillsTitle => 'صورت حساب های هفته آینده\n';

  @override
  String homeMainBudgetInterval(DateTime from, DateTime to, String period) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return '($fromString تا $toString، $period)';
  }

  @override
  String homeMainBudgetIntervalSingle(DateTime from, DateTime to) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return '($fromString تا $toString)';
  }

  @override
  String homeMainBudgetSum(String current, String status, String available) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'over': 'از',
      'other': 'باقیمانده از',
    });
    return '$current $_temp0 $available';
  }

  @override
  String get homeMainBudgetTitle => 'بودجه ماه جاری';

  @override
  String get homeMainChartAccountsTitle => 'خلاصه حساب\n';

  @override
  String get homeMainChartCategoriesTitle => 'خلاصه دسته برای ماه جاری\n';

  @override
  String get homeMainChartDailyAvg => 'میانگین 7 روز\n';

  @override
  String get homeMainChartDailyTitle => 'خلاصه روزانه';

  @override
  String get homeMainChartNetEarningsTitle => 'دریافتی خالص';

  @override
  String get homeMainChartNetWorthTitle => 'ارزش خالص\n';

  @override
  String get homeMainChartTagsTitle => 'Tag Summary for current month';

  @override
  String get homePiggyAdjustDialogTitle => 'پس انداز/خرج پول\n';

  @override
  String homePiggyDateStart(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'تاریخ شروع: $dateString\n';
  }

  @override
  String homePiggyDateTarget(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'تاریخ هدف: $dateString\n';
  }

  @override
  String get homeMainDialogSettingsTitle => 'Customize Dashboard';

  @override
  String homePiggyLinked(String account) {
    return 'لینک به $account\n';
  }

  @override
  String get homePiggyNoAccounts => 'هیچ پس‌اندازی تنظیم نشده است.\n\n';

  @override
  String get homePiggyNoAccountsSubtitle => 'مقداری در رابط وب ایجاد کنید!\n';

  @override
  String homePiggyRemaining(String amount) {
    return 'باقی مانده برای ذخیره: $amount\n';
  }

  @override
  String homePiggySaved(String amount) {
    return 'ذخیره شده تا کنون: $amount\n';
  }

  @override
  String homePiggyTarget(String amount) {
    return 'مقدار هدف: $amount\n';
  }

  @override
  String get homeTabLabelBalance => 'ترازنامه';

  @override
  String get homeTabLabelMain => 'اصلی';

  @override
  String get homeTabLabelPiggybanks => 'صندوق پس‌انداز\n\n\n\n\n\n';

  @override
  String get homeTabLabelTransactions => 'تراکنش‌ها';

  @override
  String get homeTransactionsActionFilter => 'لیست فیلتر';

  @override
  String get homeTransactionsDialogFilterAccountsAll => '<همه حساب‌ها>';

  @override
  String get homeTransactionsDialogFilterBillsAll => '<همه قبوض>';

  @override
  String get homeTransactionsDialogFilterBillUnset =>
      '<بدون تنظیم صورت حساب>\n';

  @override
  String get homeTransactionsDialogFilterBudgetsAll => '<همه بودجه‌ها>\n';

  @override
  String get homeTransactionsDialogFilterBudgetUnset => '<بدون تنظیم بودجه>\n';

  @override
  String get homeTransactionsDialogFilterCategoriesAll => '<همه دسته‌ها>\n';

  @override
  String get homeTransactionsDialogFilterCategoryUnset => '<بدون دسته بندی>\n';

  @override
  String get homeTransactionsDialogFilterCurrenciesAll => '<همه ارزها>\n';

  @override
  String get homeTransactionsDialogFilterFutureTransactions =>
      'نمایش معاملات آتی\n';

  @override
  String get homeTransactionsDialogFilterSearch => 'عبارت جستجو';

  @override
  String get homeTransactionsDialogFilterTitle => 'فیلترها را انتخاب کنید';

  @override
  String get homeTransactionsEmpty => 'هیچ تراکنشی یافت نشد';

  @override
  String homeTransactionsMultipleCategories(int num) {
    return '$num دسته\n';
  }

  @override
  String get homeTransactionsSettingsShowTags =>
      'Show tags in transaction list';

  @override
  String get liabilityDirectionCredit => 'این بدهی متعلق به من است';

  @override
  String get liabilityDirectionDebit => 'این بدهی را بدهکارم\n';

  @override
  String get liabilityTypeDebt => 'بدهی';

  @override
  String get liabilityTypeLoan => 'وام';

  @override
  String get liabilityTypeMortgage => 'رهن';

  @override
  String get loginAbout =>
      'برای استفاده مؤثر از Waterfly III به سرور خود با نمونه Firefly III یا افزونه Firefly III برای Home Assistant نیاز دارید.\n\nلطفاً URL کامل و همچنین یک نشانه دسترسی شخصی (تنظیمات -> نمایه -> OAuth -> رمز دسترسی شخصی) را در زیر وارد کنید.\n';

  @override
  String get loginFormLabelAPIKey => 'کلید API معتبر\n';

  @override
  String get loginFormLabelHost => 'URL میزبان\n';

  @override
  String get loginWelcome => 'به Waterfly III خوش آمدید\n';

  @override
  String get logoutConfirmation => 'آیا برای خارج شدن مطمئن هستید؟\n';

  @override
  String get navigationAccounts => 'حساب‌ها';

  @override
  String get navigationBills => 'صورت حساب';

  @override
  String get navigationCategories => 'دسته\n';

  @override
  String get navigationMain => 'داشبورد اصلی\n';

  @override
  String get navigationSettings => 'تنظیمات';

  @override
  String get no => 'نه';

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

    return '$percString از $of\n\n\n\n\n\n';
  }

  @override
  String get settingsDialogDebugInfo =>
      'می‌توانید گزارش‌های اشکال‌زدایی را در اینجا فعال و ارسال کنید. اینها تأثیر بدی بر عملکرد دارند، بنابراین لطفاً آنها را فعال نکنید مگر اینکه به شما توصیه شده باشد. غیرفعال کردن گزارش، گزارش ذخیره شده را حذف می کند.\n';

  @override
  String get settingsDialogDebugMailCreate => 'ایجاد ایمیل\n';

  @override
  String get settingsDialogDebugMailDisclaimer =>
      '\nهشدار: یک پیش‌نویس ایمیل با پیوست فایل گزارش (به فرمت متنی) باز می‌شود. گزارش‌ها ممکن است اطلاعات حساسی را مانند نام میزبان نمونه Firefly شما (هرچند که سعی در ثبت اطلاعات محرمانه مانند کلید API نداریم) شامل شوند. لطفاً با دقت گزارش را مطالعه کرده و هرگونه اطلاعاتی که نمی‌خواهید به اشتراک بگذارید و/یا با موضوع گزارش مرتبط نیست را سانسور کنید.\n\nلطفاً قبل از ارسال هرگونه گزارش، توافق قبلی را از طریق ایمیل/گیت‌هاب برای انجام این کار داشته باشید. هرگونه گزارشی که بدون در نظر گرفتن متن مناسبی برای حریم خصوصی ارسال شود، توسط من به دلایل حفظ حریم خصوصی حذف خواهد شد.هرگز گزارش را بدون سانسور مطلق به گیت‌هاب یا جای دیگری آپلود نکنید.\n\n\n\n\n';

  @override
  String get settingsDialogDebugSendButton => 'ارسال گزارش از طریق ایمیل\n';

  @override
  String get settingsDialogDebugTitle => 'گزارش اشکالات';

  @override
  String get settingsDialogLanguageTitle => 'انتخاب زبان';

  @override
  String get settingsDialogThemeTitle => 'انتخاب تم';

  @override
  String get settingsFAQ => 'FAQ';

  @override
  String get settingsFAQHelp => 'Opens in Browser. Only available in English.';

  @override
  String get settingsLanguage => 'زبان';

  @override
  String get settingsLockscreen => 'صفحه قفل';

  @override
  String get settingsLockscreenHelp =>
      'نیاز به احراز هویت در راه اندازی برنامه\n';

  @override
  String get settingsLockscreenInitial =>
      'لطفاً برای فعال کردن صفحه قفل، احراز هویت کنید.\n';

  @override
  String get settingsNLAppAccount => 'حساب پیش فرض';

  @override
  String get settingsNLAppAccountDynamic => '<Dynamic>';

  @override
  String get settingsNLAppAdd => 'افزودن برنامه\n';

  @override
  String get settingsNLAppAddHelp =>
      'برای افزودن یک برنامه برای گوش دادن کلیک کنید. فقط برنامه های واجد شرایط در لیست نمایش داده می شوند.\n';

  @override
  String get settingsNLAppAddInfo =>
      'برخی از تراکنش‌ها را در جایی که اعلان‌های تلفن دریافت می‌کنید انجام دهید تا برنامه‌ها را به این فهرست اضافه کنید. اگر برنامه همچنان نمایش داده نشد، لطفاً آن را به app@vogt.pw گزارش دهید.\n';

  @override
  String get settingsNLAutoAdd => 'Create transaction without interaction';

  @override
  String get settingsNLDescription =>
      'این سرویس به شما امکان می‌دهد جزئیات تراکنش را از اعلان‌های فشار دریافتی دریافت کنید. علاوه بر این، می‌توانید یک حساب پیش فرض را انتخاب کنید که تراکنش باید به آن اختصاص یابد - اگر مقداری تنظیم نشده باشد، سعی می‌کند یک حساب از اعلان استخراج کند.\n';

  @override
  String get settingsNLEmptyNote => 'Keep note field empty';

  @override
  String get settingsNLPermissionGrant => 'برای اعطای مجوز ضربه بزنید.\n';

  @override
  String get settingsNLPermissionNotGranted => 'مجوز داده نشد';

  @override
  String get settingsNLPermissionRemove => 'مجوز حذف شود؟\n';

  @override
  String get settingsNLPermissionRemoveHelp =>
      'برای غیرفعال کردن این سرویس، روی برنامه کلیک کنید و مجوزها را در صفحه بعدی حذف کنید.\n';

  @override
  String get settingsNLPrefillTXTitle =>
      'عنوان تراکنش را با عنوان اعلان از قبل پر کنید\n';

  @override
  String get settingsNLServiceChecking => 'در حال بررسی وضعیت...';

  @override
  String settingsNLServiceCheckingError(String error) {
    return 'خطا در بررسی وضعیت: $error\n';
  }

  @override
  String get settingsNLServiceRunning => 'سرویس در حال اجرا است.\n';

  @override
  String get settingsNLServiceStatus => 'وضعیت سرویس\n';

  @override
  String get settingsNLServiceStopped => 'سرویس متوقف شده است.\n';

  @override
  String get settingsNotificationListener => 'سرویس شنونده اعلان\n';

  @override
  String get settingsTheme => 'تم برنامه\n';

  @override
  String get settingsThemeDynamicColors => 'رنگ‌های پویا';

  @override
  String settingsThemeValue(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'dark': 'حالت تاریک',
      'light': 'حالت روشن',
      'other': 'پیش‌فرض سیستم',
    });
    return '$_temp0';
  }

  @override
  String get settingsUseServerTimezone => 'از منطقه زمانی سرور استفاده کنید\n';

  @override
  String get settingsUseServerTimezoneHelp =>
      'نمایش همه زمان‌ها در منطقه زمانی سرور. این رفتار رابط وب را تقلید می کند.\n';

  @override
  String get settingsVersion => 'نسخه نرم افزاز';

  @override
  String get settingsVersionChecking => 'چک کردن…';

  @override
  String get transactionAttachments => 'پیوست ها';

  @override
  String get transactionDeleteConfirm =>
      'آیا مطمئن هستید که می خواهید این تراکنش را حذف کنید؟\n';

  @override
  String get transactionDialogAttachmentsDelete => 'حذف پیوست\n';

  @override
  String get transactionDialogAttachmentsDeleteConfirm =>
      'آیا مطمئن هستید که می خواهید این پیوست را حذف کنید؟\n';

  @override
  String get transactionDialogAttachmentsErrorDownload => 'فایل دانلود نشد\n';

  @override
  String transactionDialogAttachmentsErrorOpen(String error) {
    return 'فایل باز نشد: $error\n';
  }

  @override
  String transactionDialogAttachmentsErrorUpload(String error) {
    return 'فایل آپلود نشد: $error\n';
  }

  @override
  String get transactionDialogAttachmentsTitle => 'پیوست ها';

  @override
  String get transactionDialogBillNoBill => 'بدون صورتحساب\n';

  @override
  String get transactionDialogBillTitle => 'پیوند به بیل\n';

  @override
  String get transactionDialogCurrencyTitle => 'واحد پول را انتخاب کنید\n';

  @override
  String get transactionDialogTagsAdd => 'افزودن برچسب';

  @override
  String get transactionDialogTagsHint => 'جستجو/افزودن برچسب\n';

  @override
  String get transactionDialogTagsTitle => 'برچسب ها را انتخاب کنید';

  @override
  String get transactionDuplicate => 'کپی کردن';

  @override
  String get transactionErrorInvalidAccount => 'حساب نامعتبر';

  @override
  String get transactionErrorInvalidBudget => 'بودجه نامعتبر\n';

  @override
  String get transactionErrorNoAccounts => 'Please fill in the accounts first.';

  @override
  String get transactionErrorNoAssetAccount =>
      'Please select an asset account.';

  @override
  String get transactionErrorTitle => 'لطفا عنوان بفرمایید\n';

  @override
  String get transactionFormLabelAccountDestination => 'حساب مقصد\n';

  @override
  String get transactionFormLabelAccountForeign => 'حساب خارجی\n';

  @override
  String get transactionFormLabelAccountOwn => 'حساب شخصی\n';

  @override
  String get transactionFormLabelAccountSource => 'حساب منبع\n';

  @override
  String get transactionFormLabelNotes => 'یادداشت';

  @override
  String get transactionFormLabelTags => 'برچسب ها';

  @override
  String get transactionFormLabelTitle => 'عنوان معامله\n';

  @override
  String get transactionSplitAdd => 'اضافه کردن تراکنش تقسیم\n';

  @override
  String get transactionSplitChangeCurrency => 'ارز تقسیم شده را تغییر دهید\n';

  @override
  String get transactionSplitChangeDestinationAccount =>
      'Change Split Destination Account';

  @override
  String get transactionSplitChangeSourceAccount =>
      'Change Split Source Account';

  @override
  String get transactionSplitChangeTarget => 'تغییر حساب هدف تقسیم شده\n';

  @override
  String get transactionSplitDelete => 'حذف تقسیم\n';

  @override
  String get transactionTitleAdd => 'افزودن تراکنش';

  @override
  String get transactionTitleDelete => 'حذف تراکنش\n';

  @override
  String get transactionTitleEdit => 'ویرایش تراکنش\n';

  @override
  String get transactionTypeDeposit => 'سپرده';

  @override
  String get transactionTypeTransfer => 'انتقال';

  @override
  String get transactionTypeWithdrawal => 'درخواست برداشت';
}
