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
      'weekly': 'тиждень',
      'monthly': 'місяць',
      'quarterly': 'квартал',
      'halfyear': 'півріччя',
      'yearly': 'рік',
      'other': 'невідомий',
    });
    return '$interest% відсотків на $_temp0';
  }

  @override
  String billsAmountAndFrequency(
    String minValue,
    String maxvalue,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'щотижня',
      'monthly': 'щомісяця',
      'quarterly': 'щокварталу',
      'halfyear': 'щопівроку',
      'yearly': 'щороку',
      'other': 'невідомо',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', пропускає $skip разів',
      many: ', пропускає $skip разів',
      few: ', пропускає $skip рази',
      one: ', пропускає $skip раз',
      zero: '',
    );
    return 'Підписка відповідає транзакціям від $minValue до $maxvalue. Періодичність: $_temp0$_temp1.';
  }

  @override
  String get billsChangeLayoutTooltip => 'Змінити вигляд';

  @override
  String get billsChangeSortOrderTooltip => 'Змінити порядок сортування';

  @override
  String get billsErrorLoading => 'Помилка завантаження підписок.';

  @override
  String billsExactAmountAndFrequency(
    String value,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'щотижня',
      'monthly': 'щомісяця',
      'quarterly': 'щокварталу',
      'halfyear': 'щопівроку',
      'yearly': 'щороку',
      'other': 'невідомо',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', пропускає $skip разів',
      many: ', пропускає $skip разів',
      few: ', пропускає $skip рази',
      one: ', пропускає $skip раз',
      zero: '',
    );
    return 'Підписка відповідає транзакціям на суму $value. Періодичність: $_temp0$_temp1.';
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
      'weekly': 'Щотижня',
      'monthly': 'Щомісяця',
      'quarterly': 'Щокварталу',
      'halfyear': 'Щопівроку',
      'yearly': 'Щороку',
      'other': 'Невідомо',
    });
    return '$_temp0';
  }

  @override
  String billsFrequencySkip(String frequency, num skip) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Щотижнєво',
      'monthly': 'Щомісячно',
      'quarterly': 'Щоквартально',
      'halfyear': 'Щопівроку',
      'yearly': 'Щорічно',
      'other': 'Невідомо',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', пропускає $skip раз',
      many: ', пропускає $skip разів',
      few: ', пропускає $skip рази',
      one: ', пропускає $skip раз',
      zero: '',
    );
    return '$_temp0$_temp1';
  }

  @override
  String get billsInactive => 'Неактивний';

  @override
  String get billsIsActive => 'Підписка активна';

  @override
  String get billsLayoutGroupSubtitle =>
      'Підписки відображаються у призначених їм групах.';

  @override
  String get billsLayoutGroupTitle => 'Група';

  @override
  String get billsLayoutListSubtitle =>
      'Підписки відображаються списком, відсортованим за певними критеріями.';

  @override
  String get billsLayoutListTitle => 'Список';

  @override
  String get billsListEmpty => 'Список наразі порожній.';

  @override
  String get billsNextExpectedMatch => 'Наступний очікуваний збіг';

  @override
  String get billsNotActive => 'Підписка неактивна';

  @override
  String get billsNotExpected => 'Не очікується в цьому періоді';

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
  String get billsSettingsShowOnlyActive => 'Показувати тільки активні';

  @override
  String get billsSettingsShowOnlyActiveDesc =>
      'Показує лише активні підписки.';

  @override
  String get billsSettingsShowOnlyExpected => 'Показувати тільки очікувані';

  @override
  String get billsSettingsShowOnlyExpectedDesc =>
      'Показує лише ті підписки, які очікуються (або сплачені) цього місяця.';

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
    return 'Код статусу: $code';
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
  String get formButtonResetLogin => 'Скинути вхід';

  @override
  String get formButtonTransactionAdd => 'Додати транзакцію';

  @override
  String get formButtonTryAgain => 'Спробувати ще раз';

  @override
  String get generalAccount => 'Рахунок';

  @override
  String get generalAssets => 'Активи';

  @override
  String get generalBalance => 'Баланс';

  @override
  String generalBalanceOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Баланс на $dateString';
  }

  @override
  String get generalBill => 'Підписка';

  @override
  String get generalBudget => 'Бюджет';

  @override
  String get generalCategory => 'Категорія';

  @override
  String get generalCurrency => 'Валюта';

  @override
  String get generalDateRangeCurrentMonth => 'Поточний місяць';

  @override
  String get generalDateRangeLast30Days => 'Останні 30 днів';

  @override
  String get generalDateRangeCurrentYear => 'Поточний рік';

  @override
  String get generalDateRangeLastYear => 'Минулий рік';

  @override
  String get generalDateRangeAll => 'Всі';

  @override
  String get generalDefault => 'за замовчуванням';

  @override
  String get generalDestinationAccount => 'Цільовий рахунок';

  @override
  String get generalDismiss => 'Скасувати';

  @override
  String get generalEarned => 'Зароблено';

  @override
  String get generalError => 'Помилка';

  @override
  String get generalExpenses => 'Витрати';

  @override
  String get generalIncome => 'Дохід';

  @override
  String get generalLiabilities => 'Зобов’язання';

  @override
  String get generalMultiple => 'декілька';

  @override
  String get generalNever => 'ніколи';

  @override
  String get generalReconcile => 'Звірено';

  @override
  String get generalReset => 'Скинути';

  @override
  String get generalSourceAccount => 'Вихідний рахунок';

  @override
  String get generalSpent => 'Витрачено';

  @override
  String get generalSum => 'Сума';

  @override
  String get generalTarget => 'Ціль';

  @override
  String get generalUnknown => 'Невідомо';

  @override
  String homeMainBillsInterval(String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'щотижня',
      'monthly': 'щомісяця',
      'quarterly': 'щоквартально',
      'halfyear': 'раз на пів року',
      'yearly': 'щороку',
      'other': 'невідомо',
    });
    return ' ($_temp0)';
  }

  @override
  String get homeMainBillsTitle => 'Підписки на наступний тиждень';

  @override
  String homeMainBudgetInterval(DateTime from, DateTime to, String period) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return ' (з $fromString по $toString, $period)';
  }

  @override
  String homeMainBudgetIntervalSingle(DateTime from, DateTime to) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return ' (з $fromString по $toString)';
  }

  @override
  String homeMainBudgetSum(String current, String status, String available) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'over': 'перевищено на',
      'other': 'залишилось від',
    });
    return '$current $_temp0 $available';
  }

  @override
  String get homeMainBudgetTitle => 'Бюджети на поточний місяць';

  @override
  String get homeMainChartAccountsTitle => 'Підсумок за рахунками';

  @override
  String get homeMainChartCategoriesTitle =>
      'Підсумок за категоріями на поточний місяць';

  @override
  String get homeMainChartDailyAvg => 'Середнє за 7 днів';

  @override
  String get homeMainChartDailyTitle => 'Щоденний підсумок';

  @override
  String get homeMainChartNetEarningsTitle => 'Чистий дохід';

  @override
  String get homeMainChartNetWorthTitle => 'Чистий капітал';

  @override
  String get homeMainChartTagsTitle => 'Підсумок за тегами на поточний місяць';

  @override
  String get homePiggyAdjustDialogTitle => 'Відкласти/Витратити гроші';

  @override
  String homePiggyDateStart(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Дата початку: $dateString';
  }

  @override
  String homePiggyDateTarget(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Цільова дата: $dateString';
  }

  @override
  String get homeMainDialogSettingsTitle => 'Налаштування панелі керування';

  @override
  String homePiggyLinked(String account) {
    return 'Прив\'язано до $account';
  }

  @override
  String get homePiggyNoAccounts => 'Скарбнички не налаштовані.';

  @override
  String get homePiggyNoAccountsSubtitle => 'Створіть їх у веб-інтерфейсі!';

  @override
  String homePiggyRemaining(String amount) {
    return 'Залишилося накопичити: $amount';
  }

  @override
  String homePiggySaved(String amount) {
    return 'Накопичено: $amount';
  }

  @override
  String homePiggySavePerMonth(String amount) {
    return 'Save per month: $amount';
  }

  @override
  String get homePiggySavedMultiple => 'Накопичено:';

  @override
  String homePiggyTarget(String amount) {
    return 'Цільова сума: $amount';
  }

  @override
  String get homePiggyAccountStatus => 'Стан рахунку';

  @override
  String get homePiggyAvailableAmounts => 'Доступні суми';

  @override
  String homePiggyAvailable(String amount) {
    return 'Доступно: $amount';
  }

  @override
  String homePiggyInPiggyBanks(String amount) {
    return 'У скарбничках: $amount';
  }

  @override
  String homePiggyTotal(String amount) {
    return 'Total: $amount';
  }

  @override
  String get homeTabLabelBalance => 'Баланс';

  @override
  String get homeTabLabelMain => 'Головна';

  @override
  String get homeTabLabelPiggybanks => 'Скарбнички';

  @override
  String get homeTabLabelTransactions => 'Транзакції';

  @override
  String get homeTransactionsActionFilter => 'Фільтр списку';

  @override
  String get homeTransactionsDialogFilterAccountsAll => '<Усі рахунки>';

  @override
  String get homeTransactionsDialogFilterBillsAll => '<Усі рахунки до оплати>';

  @override
  String get homeTransactionsDialogFilterBillUnset =>
      '<Рахунок до оплати не встановлено>';

  @override
  String get homeTransactionsDialogFilterBudgetsAll => '<Усі бюджети>';

  @override
  String get homeTransactionsDialogFilterBudgetUnset =>
      '<Бюджет не встановлено>';

  @override
  String get homeTransactionsDialogFilterCategoriesAll => '<Усі категорії>';

  @override
  String get homeTransactionsDialogFilterCategoryUnset =>
      '<Категорію не встановлено>';

  @override
  String get homeTransactionsDialogFilterCurrenciesAll => '<Усі валюти>';

  @override
  String get homeTransactionsDialogFilterDateRange => 'Діапазон дат';

  @override
  String get homeTransactionsDialogFilterFutureTransactions =>
      'Показувати майбутні транзакції';

  @override
  String get homeTransactionsDialogFilterSearch => 'Пошуковий запит';

  @override
  String get homeTransactionsDialogFilterTitle => 'Виберіть фільтри';

  @override
  String get homeTransactionsEmpty => 'Трансакцій не знайдено.';

  @override
  String homeTransactionsMultipleCategories(int num) {
    String _temp0 = intl.Intl.pluralLogic(
      num,
      locale: localeName,
      other: '$num категорії',
      many: '$num категорій',
      few: '$num категорії',
      one: '$num категорія',
    );
    return '$_temp0';
  }

  @override
  String get homeTransactionsSettingsShowTags =>
      'Показувати теги у списку транзакцій';

  @override
  String get liabilityDirectionCredit => 'Мені винні ці кошти';

  @override
  String get liabilityDirectionDebit => 'Я винен ці кошти';

  @override
  String get liabilityTypeDebt => 'Борг';

  @override
  String get liabilityTypeLoan => 'Позика';

  @override
  String get liabilityTypeMortgage => 'Іпотека';

  @override
  String get loginAbout =>
      'Щоб ефективно використовувати Waterfly III, вам потрібен власний сервер із встановленим екземпляром Firefly III або доповненням Firefly III для Home Assistant.\n\nБудь ласка, введіть повну URL-адресу та персональний токен доступу (Settings -> Profile -> OAuth -> Personal Access Token) нижче.';

  @override
  String get loginFormButtonHideHeaders => 'Приховати заголовки';

  @override
  String get loginFormButtonShowHeaders => 'Власні заголовки';

  @override
  String get loginFormLabelAPIKey => 'Дійсний API-ключ';

  @override
  String get loginFormLabelHeaders =>
      'Користувацькі заголовки (необов\'язково)';

  @override
  String get loginFormLabelHeadersHelp =>
      'Один на рядок, формат: HeaderName: значення';

  @override
  String get loginFormLabelHost => 'URL хоста';

  @override
  String get loginWelcome => 'Ласкаво просимо до Waterfly III';

  @override
  String get logoutConfirmation => 'Ви впевнені, що хочете вийти?';

  @override
  String get navigationAccounts => 'Рахунки';

  @override
  String get navigationBills => 'Підписки';

  @override
  String get navigationCategories => 'Категорії';

  @override
  String get navigationMain => 'Панель керування';

  @override
  String get generalSettings => 'Налаштування';

  @override
  String get no => 'Ні';

  @override
  String numPercent(double num) {
    final intl.NumberFormat numNumberFormat =
        intl.NumberFormat.decimalPercentPattern(
          locale: localeName,
          decimalDigits: 0,
        );
    final String numString = numNumberFormat.format(num);

    return '$numString';
  }

  @override
  String numPercentOf(double perc, String of) {
    final intl.NumberFormat percNumberFormat =
        intl.NumberFormat.decimalPercentPattern(
          locale: localeName,
          decimalDigits: 0,
        );
    final String percString = percNumberFormat.format(perc);

    return '$percString з $of';
  }

  @override
  String get settingsDialogDebugInfo =>
      'Ви можете ввімкнути та надіслати журнали налагодження тут. Це негативно впливає на продуктивність, тому не вмикайте їх, якщо вас не попросили це зробити. Вимкнення журналювання видалить збережений журнал.';

  @override
  String get settingsDialogDebugMailCreate => 'Створити лист';

  @override
  String get settingsDialogDebugMailDisclaimer =>
      'ПОПЕРЕДЖЕННЯ: Буде створено чернетку листа з прикріпленим файлом журналу (у текстовому форматі). Журнали можуть містити конфіденційну інформацію, таку як ім\'я хоста вашого екземпляра Firefly (хоча я намагаюся уникати запису будь-яких секретів, наприклад, API-ключа). Будь ласка, уважно прочитайте журнал і видаліть будь-яку інформацію, якою ви не хочете ділитися та/або яка не стосується проблеми, про яку ви хочете повідомити.\n\nБудь ласка, не надсилайте журнали без попередньої домовленості електронною поштою/GitHub. З міркувань конфіденційності я видалятиму будь-які журнали, надіслані без контексту. Ніколи не завантажуйте незацензурований журнал на GitHub або будь-де інше.';

  @override
  String get settingsDialogDebugSendButton =>
      'Надіслати журнали електронною поштою';

  @override
  String get settingsDialogDebugTitle => 'Журнали налагодження';

  @override
  String get settingsDialogLanguageTitle => 'Вибрати мову';

  @override
  String get settingsDialogThemeTitle => 'Вибрати тему';

  @override
  String get settingsFAQ => 'FAQ';

  @override
  String get settingsFAQHelp =>
      'Відкривається у браузері. Доступно лише англійською мовою.';

  @override
  String get settingsLanguage => 'Мова';

  @override
  String get settingsLockscreen => 'Екран блокування';

  @override
  String get settingsLockscreenHelp =>
      'Вимагати автентифікацію при запуску програми';

  @override
  String get settingsLockscreenInitial =>
      'Будь ласка, пройдіть автентифікацію, щоб увімкнути екран блокування.';

  @override
  String get settingsNLAppAccount => 'Типовий рахунок';

  @override
  String get settingsNLAppAccountDynamic => '<Динамічно>';

  @override
  String get settingsNLAppAdd => 'Додати програму';

  @override
  String get settingsNLAppAddHelp =>
      'Натисніть, щоб додати програму для відстеження. У списку відображатимуться лише відповідні програми.';

  @override
  String get settingsNLAppAddInfo =>
      'Здійсніть кілька транзакцій, після яких ви отримуєте сповіщення на телефон, щоб додати програми до цього списку. Якщо програма все одно не з\'являється, будь ласка, повідомте про це на app@vogt.pw.';

  @override
  String get settingsNLAutoAdd => 'Створювати транзакцію без взаємодії';

  @override
  String get settingsNLDescription =>
      'Ця служба дозволяє отримувати деталі транзакцій з вхідних push-сповіщень. Крім того, ви можете вибрати типовий рахунок, до якого має бути прив\'язана транзакція — якщо значення не встановлено, програма спробує витягти рахунок зі сповіщення.';

  @override
  String get settingsNLEmptyNote => 'Залишати поле примітки порожнім';

  @override
  String get settingsNLHistory => 'Історія сповіщень';

  @override
  String get settingsNLHistoryEmpty => 'Сповіщень поки не записано.';

  @override
  String settingsNLHistoryLongDescription(int notificationHistorySize) {
    String _temp0 = intl.Intl.pluralLogic(
      notificationHistorySize,
      locale: localeName,
      other:
          'Це історія останніх $notificationHistorySize сповіщень, отриманих програмою. Крім того, ви можете створювати транзакції з (дійсних) сповіщень або дізнатися причину, чому сповіщення не вдалося опрацювати.',
      many:
          'Це історія останніх $notificationHistorySize сповіщень, отриманих програмою. Крім того, ви можете створювати транзакції з (дійсних) сповіщень або дізнатися причину, чому сповіщення не вдалося опрацювати.',
      few:
          'Це історія останніх $notificationHistorySize сповіщень, отриманих програмою. Крім того, ви можете створювати транзакції з (дійсних) сповіщень або дізнатися причину, чому сповіщення не вдалося опрацювати.',
      one:
          'Це історія останнього сповіщення, отриманого програмою. Крім того, ви можете створювати транзакції з (дійсних) сповіщень або дізнатися причину, чому сповіщення не вдалося опрацювати.',
    );
    return '$_temp0';
  }

  @override
  String settingsNLHistoryRejectedReason(String reason) {
    String _temp0 = intl.Intl.selectLogic(reason, {
      'noMoney': 'Грошову суму не знайдено',
      'noCurrency': 'Валюту не знайдено',
      'appNotUsed': 'Програму не відстежуємо',
      'other': 'Невідома причина',
    });
    return 'Сповіщення пропущено: $_temp0.';
  }

  @override
  String get settingsNLHistoryShortDescription =>
      'Переглянути попередні сповіщення';

  @override
  String get settingsNLPermissionGrant => 'Торкніться, щоб надати дозвіл.';

  @override
  String get settingsNLPermissionNotGranted => 'Дозвіл не надано.';

  @override
  String get settingsNLPermissionRemove => 'Скасувати дозвіл?';

  @override
  String get settingsNLPermissionRemoveHelp =>
      'Щоб вимкнути цю службу, натисніть на додаток і видаліть дозволи на наступному екрані.';

  @override
  String get settingsNLPrefillTXTitle =>
      'Попередньо заповнювати назву транзакції заголовком сповіщення';

  @override
  String get settingsNLRegularExpression => 'Регулярний вираз (необов\'язково)';

  @override
  String get settingsNLRegularExpressionInvalid => 'Недійсний регулярний вираз';

  @override
  String get settingsNLServiceChecking => 'Перевірка стану…';

  @override
  String settingsNLServiceCheckingError(String error) {
    return 'Помилка перевірки стану: $error';
  }

  @override
  String get settingsNLServiceRunning => 'Служба запущена.';

  @override
  String get settingsNLServiceStatus => 'Стан служби';

  @override
  String get settingsNLServiceStopped => 'Служба зупинена.';

  @override
  String get settingsNotificationListener => 'Служба прослуховування сповіщень';

  @override
  String get settingsServerConnection => 'Підключення до сервера';

  @override
  String get settingsServerConnectionUpdated =>
      'Налаштування підключення оновлено.';

  @override
  String get settingsTheme => 'Тема додатку';

  @override
  String get settingsThemeDynamicColors => 'Динамічні кольори';

  @override
  String settingsThemeValue(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'dark': 'Темна тема',
      'light': 'Світла тема',
      'other': 'Як у системі',
    });
    return '$_temp0';
  }

  @override
  String get settingsUseServerTimezone =>
      'Використовувати часовий пояс сервера';

  @override
  String get settingsUseServerTimezoneHelp =>
      'Відображати час у часовому поясі сервера. Це повторює поведінку веб-інтерфейсу.';

  @override
  String get settingsVersion => 'Версія додатку';

  @override
  String get settingsVersionChecking => 'перевірка…';

  @override
  String get transactionAttachments => 'Вкладення';

  @override
  String get transactionDeleteConfirm =>
      'Ви впевнені, що хочете видалити цю транзакцію?';

  @override
  String get transactionDialogAttachmentsDelete => 'Видалити вкладення';

  @override
  String get transactionDialogAttachmentsDeleteConfirm =>
      'Ви впевнені, що хочете видалити це вкладення?';

  @override
  String get transactionDialogAttachmentsErrorDownload =>
      'Не вдалося завантажити файл.';

  @override
  String transactionDialogAttachmentsErrorOpen(String error) {
    return 'Не вдалося відкрити файл: $error';
  }

  @override
  String transactionDialogAttachmentsErrorUpload(String error) {
    return 'Не вдалося завантажити файл: $error';
  }

  @override
  String get transactionDialogAttachmentsTitle => 'Вкладення';

  @override
  String get transactionDialogBillNoBill => 'Без підписки';

  @override
  String get transactionDialogBillTitle => 'Прив\'язати до підписки';

  @override
  String get transactionDialogCurrencyTitle => 'Виберіть валюту';

  @override
  String get transactionDialogPiggyNoPiggy => 'Без скарбнички';

  @override
  String get transactionDialogPiggyTitle => 'Прив\'язати до скарбнички';

  @override
  String get transactionDialogTagsAdd => 'Додати тег';

  @override
  String get transactionDialogTagsHint => 'Пошук/додавання тегу';

  @override
  String get transactionDialogTagsTitle => 'Виберіть теги';

  @override
  String get transactionDuplicate => 'Дублювати';

  @override
  String get transactionErrorInvalidAccount => 'Недійсний рахунок';

  @override
  String get transactionErrorInvalidBudget => 'Недійсний бюджет';

  @override
  String get transactionErrorNoAccounts =>
      'Будь ласка, спочатку заповніть рахунки.';

  @override
  String get transactionErrorNoAssetAccount =>
      'Будь ласка, виберіть активний рахунок.';

  @override
  String get transactionErrorTitle => 'Будь ласка, вкажіть назву.';

  @override
  String get transactionFormLabelAccountDestination => 'Рахунок призначення';

  @override
  String get transactionFormLabelAccountForeign => 'Зовнішній рахунок';

  @override
  String get transactionFormLabelAccountOwn => 'Власний рахунок';

  @override
  String get transactionFormLabelAccountSource => 'Рахунок-джерело';

  @override
  String get transactionFormLabelNotes => 'Нотатки';

  @override
  String get transactionFormLabelTags => 'Теги';

  @override
  String get transactionFormLabelTitle => 'Назва транзакції';

  @override
  String get transactionSplitAdd => 'Додати розділену транзакцію';

  @override
  String get transactionSplitChangeCurrency => 'Змінити валюту розділення';

  @override
  String get transactionSplitChangeDestinationAccount =>
      'Змінити рахунок призначення розділення';

  @override
  String get transactionSplitChangeSourceAccount =>
      'Змінити вихідний рахунок поділу';

  @override
  String get transactionSplitChangeTarget => 'Змінити цільовий рахунок поділу';

  @override
  String get transactionSplitDelete => 'Видалити поділ';

  @override
  String get transactionTitleAdd => 'Додати транзакцію';

  @override
  String get transactionTitleDelete => 'Видалити транзакцію';

  @override
  String get transactionTitleEdit => 'Редагувати транзакцію';

  @override
  String get transactionTypeDeposit => 'Депозит';

  @override
  String get transactionTypeTransfer => 'Переказ';

  @override
  String get transactionTypeWithdrawal => 'Зняття коштів';
}
