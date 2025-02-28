// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class SRu extends S {
  SRu([String locale = 'ru']) : super(locale);

  @override
  String get accountRoleAssetCashWallet => 'Денежный кошелек';

  @override
  String get accountRoleAssetCC => 'Кредитная карта';

  @override
  String get accountRoleAssetDefault => 'Счёт по умолчанию';

  @override
  String get accountRoleAssetSavings => 'Сберегательный счет';

  @override
  String get accountRoleAssetShared => 'Общий основной счёт';

  @override
  String get accountsLabelAsset => 'Счета активов';

  @override
  String get accountsLabelExpense => 'Счета расходов';

  @override
  String get accountsLabelLiabilities => 'Обязательства';

  @override
  String get accountsLabelRevenue => 'Счета учета доходов';

  @override
  String accountsLiabilitiesInterest(double interest, String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'неделя',
      'monthly': 'месяц',
      'quarterly': 'квартал',
      'halfyear': 'полугодие',
      'yearly': 'год',
      'other': 'неизвестно',
    });
    return '$interest% за $_temp0';
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
  String get billsChangeLayoutTooltip => 'Change layout';

  @override
  String get billsChangeSortOrderTooltip => 'Change sort order';

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
  String get categoryDeleteConfirm =>
      'Вы уверены, что хотите удалить категорию? Транзакции, входящие в нее, удалены не будут, они просто останутся без категории.';

  @override
  String get categoryErrorLoading => 'Ошибка загрузки категорий.';

  @override
  String get categoryFormLabelIncludeInSum => 'Include in monthly sum';

  @override
  String get categoryFormLabelName => 'Category Name';

  @override
  String get categoryMonthNext => 'След. месяц';

  @override
  String get categoryMonthPrev => 'Пред. месяц';

  @override
  String get categorySumExcluded => 'excluded';

  @override
  String get categoryTitleAdd => 'Добавить категорию';

  @override
  String get categoryTitleDelete => 'Удалить категорию';

  @override
  String get categoryTitleEdit => 'Изменить категорию';

  @override
  String get catNone => '<без категории>';

  @override
  String get catOther => 'Прочее';

  @override
  String errorAPIInvalidResponse(String message) {
    return 'Неверный ответ API: $message';
  }

  @override
  String get errorAPIUnavailable => 'API недоступен';

  @override
  String get errorFieldRequired => 'Обязательное поле.';

  @override
  String get errorInvalidURL => 'Неверный URL-адрес';

  @override
  String errorMinAPIVersion(String requiredVersion) {
    return 'Минимально требуемая версия Firefly API $requiredVersion. Пожалуйста, выполните обновление.';
  }

  @override
  String errorStatusCode(int code) {
    return 'Код ошибки: $code';
  }

  @override
  String get errorUnknown => 'Неизвестная ошибка.';

  @override
  String get formButtonHelp => 'Помощь';

  @override
  String get formButtonLogin => 'Вход';

  @override
  String get formButtonLogout => 'Выход';

  @override
  String get formButtonRemove => 'Убрать';

  @override
  String get formButtonResetLogin => 'Сбросить логин';

  @override
  String get formButtonTransactionAdd => 'Добавить транзакцию';

  @override
  String get formButtonTryAgain => 'Попробовать снова';

  @override
  String get generalAccount => 'Аккаунт';

  @override
  String get generalAssets => 'Активы';

  @override
  String get generalBalance => 'Баланс';

  @override
  String generalBalanceOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Баланс на $dateString';
  }

  @override
  String get generalBill => 'Счет';

  @override
  String get generalBudget => 'Бюджет';

  @override
  String get generalCategory => 'Категория';

  @override
  String get generalCurrency => 'Валюта';

  @override
  String get generalDefault => 'по умолчанию';

  @override
  String get generalDestinationAccount => 'Destination Account';

  @override
  String get generalDismiss => 'Отмена';

  @override
  String get generalEarned => 'Заработано';

  @override
  String get generalError => 'Ошибка';

  @override
  String get generalExpenses => 'Расходы';

  @override
  String get generalIncome => 'Доходы';

  @override
  String get generalLiabilities => 'Обязательства';

  @override
  String get generalMultiple => 'множественные';

  @override
  String get generalNever => 'никогда';

  @override
  String get generalReconcile => 'Согласованный';

  @override
  String get generalReset => 'Сбросить';

  @override
  String get generalSourceAccount => 'Source Account';

  @override
  String get generalSpent => 'Потрачено';

  @override
  String get generalSum => 'Сумма';

  @override
  String get generalTarget => 'Цель';

  @override
  String get generalUnknown => 'Неизвестно';

  @override
  String homeMainBillsInterval(String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'еженедельно',
      'monthly': 'ежемесячно',
      'quarterly': 'ежеквартально',
      'halfyear': 'каждые полгода',
      'yearly': 'ежегодно',
      'other': 'неизвестно',
    });
    return ' ($_temp0)';
  }

  @override
  String get homeMainBillsTitle => 'Счета на следующую неделю';

  @override
  String homeMainBudgetInterval(DateTime from, DateTime to, String period) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return ' ($fromString до $toString, $period)';
  }

  @override
  String homeMainBudgetIntervalSingle(DateTime from, DateTime to) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return 'С $fromString до $toString';
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
  String get homeMainBudgetTitle => 'Бюджеты за текущий месяц';

  @override
  String get homeMainChartAccountsTitle => 'Сведения об аккаунте';

  @override
  String get homeMainChartCategoriesTitle =>
      'Сводка по категории за текущий месяц';

  @override
  String get homeMainChartDailyAvg => 'Среднее за 7 дней';

  @override
  String get homeMainChartDailyTitle => 'Ежедневная сводка';

  @override
  String get homeMainChartNetEarningsTitle => 'Чистый доход';

  @override
  String get homeMainChartNetWorthTitle => 'Общая средства';

  @override
  String get homePiggyAdjustDialogTitle => 'Сохранить/потратить деньги';

  @override
  String homePiggyDateStart(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Начальная дата: $dateString';
  }

  @override
  String homePiggyDateTarget(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Целевая дата: $dateString';
  }

  @override
  String get homeMainDialogSettingsTitle => 'Customize Dashboard';

  @override
  String homePiggyLinked(String account) {
    return 'Привязано к $account';
  }

  @override
  String get homePiggyNoAccounts => 'Копилки не созданы.';

  @override
  String get homePiggyNoAccountsSubtitle => 'Создайте в веб-интерфейсе!';

  @override
  String homePiggyRemaining(String amount) {
    return 'Осталось накопить: $amount';
  }

  @override
  String homePiggySaved(String amount) {
    return 'Накоплено: $amount';
  }

  @override
  String homePiggyTarget(String amount) {
    return 'Целевая сумма: $amount';
  }

  @override
  String get homeTabLabelBalance => 'Балансовая ведомость';

  @override
  String get homeTabLabelMain => 'Главная';

  @override
  String get homeTabLabelPiggybanks => 'Копилки';

  @override
  String get homeTabLabelTransactions => 'Транзакции';

  @override
  String get homeTransactionsActionFilter => 'Фильтровать список';

  @override
  String get homeTransactionsDialogFilterAccountsAll => '<All Accounts>';

  @override
  String get homeTransactionsDialogFilterBillsAll => '<All Bills>';

  @override
  String get homeTransactionsDialogFilterBillUnset => '<No Bill set>';

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
  String get homeTransactionsDialogFilterFutureTransactions =>
      'Показать предстоящие транзакции';

  @override
  String get homeTransactionsDialogFilterSearch => 'Искать термин';

  @override
  String get homeTransactionsDialogFilterTitle => 'Выбрать фильтры';

  @override
  String get homeTransactionsEmpty => 'Транзакций не найдено.';

  @override
  String homeTransactionsMultipleCategories(int num) {
    return '$num категории';
  }

  @override
  String get homeTransactionsSettingsShowTags =>
      'Show tags in transaction list';

  @override
  String get liabilityDirectionCredit => 'Мне причитается этот долг';

  @override
  String get liabilityDirectionDebit => 'Я в долгу';

  @override
  String get liabilityTypeDebt => 'Долг';

  @override
  String get liabilityTypeLoan => 'Заём';

  @override
  String get liabilityTypeMortgage => 'Ипотека';

  @override
  String get loginAbout =>
      'Для эффективного использования Waterfly III Вам необходим собственный сервер с установленным Firefly III или аддоном Firefly III для Home Assistant.\n\nПожалуйста, введите полный URL-адрес и персональный ключ доступа (Настройки -> Профиль -> OAuth -> Персональный ключ доступа).';

  @override
  String get loginFormLabelAPIKey => 'Действительный ключ API';

  @override
  String get loginFormLabelHost => 'URL-адрес хоста';

  @override
  String get loginWelcome => 'Добро пожаловать в Waterfly III';

  @override
  String get logoutConfirmation => 'Вы уверены, что хотите выйти?';

  @override
  String get navigationAccounts => 'Аккаунты';

  @override
  String get navigationBills => 'Subscriptions';

  @override
  String get navigationCategories => 'Категории';

  @override
  String get navigationMain => 'Главное табло';

  @override
  String get navigationSettings => 'Настройки';

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

    return '$percString из $of';
  }

  @override
  String get settingsDialogDebugInfo =>
      'Здесь можно включить и отправить журналы отладки. Они плохо влияют на производительность, поэтому не включайте их, если вам не рекомендовано это делать. Отключение регистрации приведет к удалению сохраненного журнала.';

  @override
  String get settingsDialogDebugMailCreate => 'Создать почту';

  @override
  String get settingsDialogDebugMailDisclaimer =>
      'ВНИМАНИЕ: Будет открыт почтовый проект с прикрепленным файлом журнала (в текстовом формате). В журнале может содержаться конфиденциальная информация, например, имя хоста вашего экземпляра Firefly (хотя я стараюсь избегать записи в журнал каких-либо секретов, например, api ключ). Пожалуйста, внимательно прочитайте журнал и вычеркните из него ту информацию, которой вы не хотите делиться и/или которая не имеет отношения к проблеме, о которой вы хотите сообщить.\n\nПожалуйста, не присылайте логи без предварительного согласия на это по почте/GitHub. Я буду удалять любые журналы, присланные без контекста, из соображений конфиденциальности. Никогда не загружайте журнал без цензуры на GitHub или куда-либо еще.';

  @override
  String get settingsDialogDebugSendButton => 'Отправлять логи по почте';

  @override
  String get settingsDialogDebugTitle => 'Отладочные логи';

  @override
  String get settingsDialogLanguageTitle => 'Выберите язык';

  @override
  String get settingsDialogThemeTitle => 'Выберите тему';

  @override
  String get settingsFAQ => 'FAQ';

  @override
  String get settingsFAQHelp => 'Opens in Browser. Only available in English.';

  @override
  String get settingsLanguage => 'Язык';

  @override
  String get settingsLockscreen => 'Экран блокировки';

  @override
  String get settingsLockscreenHelp =>
      'Требовать аутентификацию при запуске приложения';

  @override
  String get settingsLockscreenInitial =>
      'Пожалуйста, авторизуйтесь, чтобы включить экран блокировки.';

  @override
  String get settingsNLAppAccount => 'Аккаунт по умолчанию';

  @override
  String get settingsNLAppAccountDynamic => '<Dynamic>';

  @override
  String get settingsNLAppAdd => 'Добавить приложение';

  @override
  String get settingsNLAppAddHelp =>
      'Нажмите, чтобы добавить приложение для прослушивания. В списке будут отображаться только подходящие приложения.';

  @override
  String get settingsNLAppAddInfo =>
      'Сделайте несколько транзакций, в которых Вы должны получить уведомление на телефон, для добавления приложения в этот лист. Если приложение до сих пор не отображается, пожалуйста, сообщите нам на app@vogt.pw.';

  @override
  String get settingsNLAutoAdd => 'Create transaction without interaction';

  @override
  String get settingsNLDescription =>
      'Данный сервис позволяет получать данные о транзакциях из входящих push-уведомлений. Кроме того, можно выбрать счет по умолчанию, к которому должна быть отнесена транзакция, - если значение не задано, он пытается извлечь счет из уведомления.';

  @override
  String get settingsNLEmptyNote => 'Keep note field empty';

  @override
  String get settingsNLPermissionGrant => 'Нажмите для подтверждения.';

  @override
  String get settingsNLPermissionNotGranted => 'Разрешение не было получено.';

  @override
  String get settingsNLPermissionRemove => 'Удалить разрешение?';

  @override
  String get settingsNLPermissionRemoveHelp =>
      'Чтобы отключить эту службу, кликните на приложение и удалите разрешения на следующем экране.';

  @override
  String get settingsNLPrefillTXTitle =>
      'Заполнить заголовок транзакции, используя заголовок уведомления';

  @override
  String get settingsNLServiceChecking => 'Проверка статуса…';

  @override
  String settingsNLServiceCheckingError(String error) {
    return 'Ошибка проверки статуса: $error';
  }

  @override
  String get settingsNLServiceRunning => 'Сервис запущен.';

  @override
  String get settingsNLServiceStatus => 'Статус сервиса';

  @override
  String get settingsNLServiceStopped => 'Сервис остановлен.';

  @override
  String get settingsNotificationListener => 'Сервис прослушивания уведомлений';

  @override
  String get settingsTheme => 'Тема приложения';

  @override
  String get settingsThemeDynamicColors => 'Динамические цвета';

  @override
  String settingsThemeValue(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'dark': 'Темная',
      'light': 'Светлая',
      'other': 'Системная',
    });
    return '$_temp0';
  }

  @override
  String get settingsUseServerTimezone => 'Использовать часовой пояс сервера';

  @override
  String get settingsUseServerTimezoneHelp =>
      'Показывать время по часовому поясу сервера. Имитирует веб-интерфейс.';

  @override
  String get settingsVersion => 'Версия приложения';

  @override
  String get settingsVersionChecking => 'проверка…';

  @override
  String get transactionAttachments => 'Вложения';

  @override
  String get transactionDeleteConfirm =>
      'Вы уверены, что хотите удалить эту транзакцию?';

  @override
  String get transactionDialogAttachmentsDelete => 'Удалить вложение';

  @override
  String get transactionDialogAttachmentsDeleteConfirm =>
      'Вы уверены что хотите удалить это вложение?';

  @override
  String get transactionDialogAttachmentsErrorDownload =>
      'Не удалось скачать файл.';

  @override
  String transactionDialogAttachmentsErrorOpen(String error) {
    return 'Не удалось открыть файл: $error';
  }

  @override
  String transactionDialogAttachmentsErrorUpload(String error) {
    return 'Не удалось загрузить файл: $error';
  }

  @override
  String get transactionDialogAttachmentsTitle => 'Вложения';

  @override
  String get transactionDialogBillNoBill => 'Нет счета';

  @override
  String get transactionDialogBillTitle => 'Ссылка на счет';

  @override
  String get transactionDialogCurrencyTitle => 'Выбор валюты';

  @override
  String get transactionDialogTagsAdd => 'Добавить тег';

  @override
  String get transactionDialogTagsHint => 'Искать/Добавить тег';

  @override
  String get transactionDialogTagsTitle => 'Выбрать теги';

  @override
  String get transactionDuplicate => 'Дубликат';

  @override
  String get transactionErrorInvalidAccount => 'Недействительный аккаунт';

  @override
  String get transactionErrorInvalidBudget => 'Неверный бюджет';

  @override
  String get transactionErrorNoAccounts => 'Please fill in the accounts first.';

  @override
  String get transactionErrorNoAssetAccount =>
      'Please select an asset account.';

  @override
  String get transactionErrorTitle => 'Пожалуйста, укажите заголовок.';

  @override
  String get transactionFormLabelAccountDestination => 'Счет назначения';

  @override
  String get transactionFormLabelAccountForeign => 'Внешний счет';

  @override
  String get transactionFormLabelAccountOwn => 'Собственный аккаунт';

  @override
  String get transactionFormLabelAccountSource => 'Исходный аккаунт';

  @override
  String get transactionFormLabelNotes => 'Примечания';

  @override
  String get transactionFormLabelTags => 'Теги';

  @override
  String get transactionFormLabelTitle => 'Название транзакции';

  @override
  String get transactionSplitAdd => 'Добавить разделенную транзакцию';

  @override
  String get transactionSplitChangeCurrency => 'Изменить раздельную валюту';

  @override
  String get transactionSplitChangeDestinationAccount =>
      'Change Split Destination Account';

  @override
  String get transactionSplitChangeSourceAccount =>
      'Change Split Source Account';

  @override
  String get transactionSplitChangeTarget =>
      'Изменение раздельного целевого счета';

  @override
  String get transactionSplitDelete => 'Удалить разделение';

  @override
  String get transactionTitleAdd => 'Добавить транзакцию';

  @override
  String get transactionTitleDelete => 'Удалить транзакцию';

  @override
  String get transactionTitleEdit => 'Редактировать транзакцию';

  @override
  String get transactionTypeDeposit => 'Депозит';

  @override
  String get transactionTypeTransfer => 'Перемещение';

  @override
  String get transactionTypeWithdrawal => 'Вывод средств';
}
