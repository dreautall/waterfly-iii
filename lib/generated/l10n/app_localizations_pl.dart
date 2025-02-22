// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class SPl extends S {
  SPl([String locale = 'pl']) : super(locale);

  @override
  String get accountRoleAssetCashWallet => 'Portfel gotówkowy';

  @override
  String get accountRoleAssetCC => 'Karta kredytowa';

  @override
  String get accountRoleAssetDefault => 'Domyślne konto aktywów';

  @override
  String get accountRoleAssetSavings => 'Konto oszczędnościowe';

  @override
  String get accountRoleAssetShared => 'Współdzielone konto aktywów';

  @override
  String get accountsLabelAsset => 'Konta aktywów';

  @override
  String get accountsLabelExpense => 'Konta wydatków';

  @override
  String get accountsLabelLiabilities => 'Zobowiązania';

  @override
  String get accountsLabelRevenue => 'Konta przychodów';

  @override
  String accountsLiabilitiesInterest(double interest, String period) {
    String _temp0 = intl.Intl.selectLogic(
      period,
      {
        'weekly': 'tydzień',
        'monthly': 'miesiąc',
        'quarterly': 'kwartał',
        'halfyear': 'pół roku',
        'yearly': 'rok',
        'other': 'nieznany',
      },
    );
    return '$interest% odsetek za $_temp0';
  }

  @override
  String billsAmountAndFrequency(
      String minValue, String maxvalue, String frequency, num skip) {
    String _temp0 = intl.Intl.selectLogic(
      frequency,
      {
        'weekly': 'weekly',
        'monthly': 'monthly',
        'quarterly': 'quarterly',
        'halfyear': 'half-yearly',
        'yearly': 'yearly',
        'other': 'unknown',
      },
    );
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
      String value, String frequency, num skip) {
    String _temp0 = intl.Intl.selectLogic(
      frequency,
      {
        'weekly': 'weekly',
        'monthly': 'monthly',
        'quarterly': 'quarterly',
        'halfyear': 'half-yearly',
        'yearly': 'yearly',
        'other': 'unknown',
      },
    );
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
    String _temp0 = intl.Intl.selectLogic(
      frequency,
      {
        'weekly': 'Weekly',
        'monthly': 'Monthly',
        'quarterly': 'Quarterly',
        'halfyear': 'Half-yearly',
        'yearly': 'Yearly',
        'other': 'Unknown',
      },
    );
    return '$_temp0';
  }

  @override
  String billsFrequencySkip(String frequency, num skip) {
    String _temp0 = intl.Intl.selectLogic(
      frequency,
      {
        'weekly': 'Weekly',
        'monthly': 'Monthly',
        'quarterly': 'Quarterly',
        'halfyear': 'Half-yearly',
        'yearly': 'Yearly',
        'other': 'Unknown',
      },
    );
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
  String get catOther => 'Inne';

  @override
  String errorAPIInvalidResponse(String message) {
    return 'Nieprawidłowa odpowiedź od API: $message';
  }

  @override
  String get errorAPIUnavailable => 'API niedostępne';

  @override
  String get errorFieldRequired => 'To pole jest wymagane.';

  @override
  String get errorInvalidURL => 'Nieprawidłowy adres URL';

  @override
  String errorMinAPIVersion(String requiredVersion) {
    return 'Wymagana minimalna wersja API Firefly v$requiredVersion. Proszę zaktualizować.';
  }

  @override
  String errorStatusCode(int code) {
    return 'Kod statusu: $code';
  }

  @override
  String get errorUnknown => 'Nieznany błąd.';

  @override
  String get formButtonHelp => 'Pomoc';

  @override
  String get formButtonLogin => 'Zaloguj się';

  @override
  String get formButtonLogout => 'Wyloguj się';

  @override
  String get formButtonRemove => 'Usuń';

  @override
  String get formButtonResetLogin => 'Resetuj logowanie';

  @override
  String get formButtonTransactionAdd => 'Dodaj transakcję';

  @override
  String get formButtonTryAgain => 'Spróbuj ponownie';

  @override
  String get generalAccount => 'Konto';

  @override
  String get generalAssets => 'Assets';

  @override
  String get generalBalance => 'Saldo';

  @override
  String generalBalanceOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Balance on $dateString';
  }

  @override
  String get generalBill => 'Rachunek';

  @override
  String get generalBudget => 'Budżet';

  @override
  String get generalCategory => 'Kategoria';

  @override
  String get generalCurrency => 'Waluta';

  @override
  String get generalDefault => 'domyślnie';

  @override
  String get generalDismiss => 'Anuluj';

  @override
  String get generalEarned => 'Earned';

  @override
  String get generalError => 'Błąd';

  @override
  String get generalExpenses => 'Wydatki';

  @override
  String get generalIncome => 'Przychód';

  @override
  String get generalLiabilities => 'Liabilities';

  @override
  String get generalMultiple => 'wiele';

  @override
  String get generalNever => 'nigdy';

  @override
  String get generalReconcile => 'Zatwierdzone';

  @override
  String get generalReset => 'Resetuj';

  @override
  String get generalSpent => 'Spent';

  @override
  String get generalSum => 'Suma';

  @override
  String get generalTarget => 'Cel';

  @override
  String get generalUnknown => 'Nieznany';

  @override
  String homeMainBillsInterval(String period) {
    String _temp0 = intl.Intl.selectLogic(
      period,
      {
        'weekly': 'weekly',
        'monthly': 'monthly',
        'quarterly': 'quarterly',
        'halfyear': 'half-year',
        'yearly': 'yearly',
        'other': 'unknown',
      },
    );
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

    return ' ($fromString do $toString, $period)';
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
    String _temp0 = intl.Intl.selectLogic(
      status,
      {
        'over': 'ponad',
        'other': 'zostało z',
      },
    );
    return '$current $_temp0 $available';
  }

  @override
  String get homeMainBudgetTitle => 'Budżety na bieżący miesiąc';

  @override
  String get homeMainChartAccountsTitle => 'Podsumowanie konta';

  @override
  String get homeMainChartCategoriesTitle =>
      'Podsumowanie kategorii dla bieżącego miesiąca';

  @override
  String get homeMainChartDailyAvg => 'Średnia z 7 dni';

  @override
  String get homeMainChartDailyTitle => 'Podsumowanie dnia';

  @override
  String get homeMainChartNetEarningsTitle => 'Net Earnings';

  @override
  String get homeMainChartNetWorthTitle => 'Net Worth';

  @override
  String get homePiggyAdjustDialogTitle => 'Wrzuć/Wyjmij Pieniądze';

  @override
  String homePiggyDateStart(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Data rozpoczęcia: $dateString';
  }

  @override
  String homePiggyDateTarget(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Data docelowa: $dateString';
  }

  @override
  String get homeMainDialogSettingsTitle => 'Customize Dashboard';

  @override
  String homePiggyLinked(String account) {
    return 'Powiązane z $account';
  }

  @override
  String get homePiggyNoAccounts => 'Żadne skarbonki nie zostały utworzone.';

  @override
  String get homePiggyNoAccountsSubtitle =>
      'Utwórz jakieś w interfejsie internetowym!';

  @override
  String homePiggyRemaining(String amount) {
    return 'Pozostało do zaoszczędzenia: $amount';
  }

  @override
  String homePiggySaved(String amount) {
    return 'Zaoszczędzono dotychczas: $amount';
  }

  @override
  String homePiggyTarget(String amount) {
    return 'Docelowa kwota: $amount';
  }

  @override
  String get homeTabLabelBalance => 'Zestawienie Bilansowe';

  @override
  String get homeTabLabelMain => 'Główna';

  @override
  String get homeTabLabelPiggybanks => 'Skarbonki';

  @override
  String get homeTabLabelTransactions => 'Transakcje';

  @override
  String get homeTransactionsActionFilter => 'Lista filtrów';

  @override
  String get homeTransactionsDialogFilterAccountsAll => '<Wszystkie konta>';

  @override
  String get homeTransactionsDialogFilterBillsAll => '<Wszystkie rachunki>';

  @override
  String get homeTransactionsDialogFilterBillUnset =>
      '<Brak wybranego rachunku>';

  @override
  String get homeTransactionsDialogFilterBudgetsAll => '<Wszystkie budżety>';

  @override
  String get homeTransactionsDialogFilterBudgetUnset =>
      '<Brak wybranego budżetu>';

  @override
  String get homeTransactionsDialogFilterCategoriesAll =>
      '<Wszystkie kategorie>';

  @override
  String get homeTransactionsDialogFilterCategoryUnset =>
      '<Brak wybranej kategorii>';

  @override
  String get homeTransactionsDialogFilterCurrenciesAll => '<Wszystkie waluty>';

  @override
  String get homeTransactionsDialogFilterFutureTransactions =>
      'Show future transactions';

  @override
  String get homeTransactionsDialogFilterSearch => 'Szukana fraza';

  @override
  String get homeTransactionsDialogFilterTitle => 'Wybierz filtry';

  @override
  String get homeTransactionsEmpty => 'Nie znaleziono transakcji.';

  @override
  String homeTransactionsMultipleCategories(int num) {
    return '$num kategorie';
  }

  @override
  String get homeTransactionsSettingsShowTags =>
      'Show tags in transaction list';

  @override
  String get liabilityDirectionCredit => 'Zadłużenie wobec mnie';

  @override
  String get liabilityDirectionDebit => 'Jestem dłużny';

  @override
  String get liabilityTypeDebt => 'Dług';

  @override
  String get liabilityTypeLoan => 'Pożyczka';

  @override
  String get liabilityTypeMortgage => 'Hipoteka';

  @override
  String get loginAbout =>
      'Aby wydajnie korzystać z Waterfly III, potrzebujesz własnego serwera z instancją Firefly III lub dodatkiem Firefly III dla asystenta domowego.\n\nWprowadź pełny adres URL oraz osobisty token dostępu (Ustawienia -> Profil -> OAuth -> Osobisty token dostępu) poniżej.';

  @override
  String get loginFormLabelAPIKey => 'Prawidłowy klucz API';

  @override
  String get loginFormLabelHost => 'Adres URL hosta';

  @override
  String get loginWelcome => 'Witaj w Waterfly III';

  @override
  String get logoutConfirmation =>
      'Czy jesteś pewien, że chcesz się wylogować?';

  @override
  String get navigationAccounts => 'Konta';

  @override
  String get navigationBills => 'Subscriptions';

  @override
  String get navigationCategories => 'Categories';

  @override
  String get navigationMain => 'Panel główny';

  @override
  String get navigationSettings => 'Ustawienia';

  @override
  String get no => 'No';

  @override
  String numPercent(double num) {
    final intl.NumberFormat numNumberFormat =
        intl.NumberFormat.decimalPercentPattern(
            locale: localeName, decimalDigits: 0);
    final String numString = numNumberFormat.format(num);

    return '$numString';
  }

  @override
  String numPercentOf(double perc, String of) {
    final intl.NumberFormat percNumberFormat =
        intl.NumberFormat.decimalPercentPattern(
            locale: localeName, decimalDigits: 0);
    final String percString = percNumberFormat.format(perc);

    return '$percString z $of';
  }

  @override
  String get settingsDialogDebugInfo =>
      'Możesz tutaj włączyć i wysłać logi debugowania. Mają one zły wpływ na wydajność, więc nie włączaj ich, chyba że ktoś ci to zalecił. Wyłączenie logowania spowoduje usunięcie zapisanych logów.';

  @override
  String get settingsDialogDebugMailCreate => 'Stwórz email';

  @override
  String get settingsDialogDebugMailDisclaimer =>
      'OSTRZEŻENIE: Szkic wiadomości zostanie otwarty wraz z załączonym plikiem logów (w formacie tekstowym). Logi mogą zawierać poufne informacje, takie jak nazwa hosta twojej instancji Firefly (chociaż staram się unikać logowania wszelkich sekretów, takich jak klucz api). Przeczytaj uważnie logi i ocenzuruj informacje, których nie chcesz udostępniać i/lub które nie są istotne dla problemu, który chcesz zgłosić.\n\nProszę nie wysyłaj logów bez uprzedniego dogadania się poprzez mail/GitHub. Usunę wszystkie wpisy wysłane bez kontekstu ze względu na prywatność. Nigdy nie wysyłaj nieocenzurowanych logów na GitHub lub gdzieś indziej.';

  @override
  String get settingsDialogDebugSendButton => 'Wyślij logi poprzez e-mail';

  @override
  String get settingsDialogDebugTitle => 'Logi Debugowania';

  @override
  String get settingsDialogLanguageTitle => 'Wybierz język';

  @override
  String get settingsDialogThemeTitle => 'Wybierz motyw';

  @override
  String get settingsFAQ => 'FAQ';

  @override
  String get settingsFAQHelp => 'Opens in Browser. Only available in English.';

  @override
  String get settingsLanguage => 'Język';

  @override
  String get settingsLockscreen => 'Ekran blokady';

  @override
  String get settingsLockscreenHelp =>
      'Wymagaj uwierzytelnienia przy starcie aplikacji';

  @override
  String get settingsLockscreenInitial =>
      'Proszę uwierzytelnić się, aby włączyć ekran blokady.';

  @override
  String get settingsNLAppAccount => 'Konto domyślne';

  @override
  String get settingsNLAppAccountDynamic => '<Dynamicznie>';

  @override
  String get settingsNLAppAdd => 'Dodaj aplikację';

  @override
  String get settingsNLAppAddHelp =>
      'Kliknij, aby dodać aplikację do nasłuchiwania. Tylko kwalifikujące się aplikacje pojawią się na liście.';

  @override
  String get settingsNLAppAddInfo =>
      'Wykonaj transakcje, w których otrzymujesz powiadomienia telefoniczne, aby dodać aplikacje do tej listy. Jeśli aplikacja nadal się nie pojawia, zgłoś to do app@vogt.pw.';

  @override
  String get settingsNLAutoAdd => 'Create transaction without interaction';

  @override
  String get settingsNLDescription =>
      'Ta usługa pozwala na pobranie szczegółów transakcji z przychodzących powiadomień. Dodatkowo możesz wybrać domyślne konto, do którego transakcja powinna być przypisana — jeśli wartość nie jest ustawiona, spróbuje dopisać konto z powiadomienia.';

  @override
  String get settingsNLEmptyNote => 'Keep note field empty';

  @override
  String get settingsNLPermissionGrant => 'Dotknij, aby udzielić uprawnień.';

  @override
  String get settingsNLPermissionNotGranted => 'Nie przyznano uprawnień.';

  @override
  String get settingsNLPermissionRemove => 'Usunąć uprawnienia?';

  @override
  String get settingsNLPermissionRemoveHelp =>
      'Aby wyłączyć tę usługę, kliknij w aplikację i usuń uprawnienia na następnym ekranie.';

  @override
  String get settingsNLPrefillTXTitle =>
      'Prefill transaction title with notification title';

  @override
  String get settingsNLServiceChecking => 'Sprawdzam stan…';

  @override
  String settingsNLServiceCheckingError(String error) {
    return 'Błąd podczas sprawdzania statusu: $error';
  }

  @override
  String get settingsNLServiceRunning => 'Usługa jest uruchomiona.';

  @override
  String get settingsNLServiceStatus => 'Status usługi';

  @override
  String get settingsNLServiceStopped => 'Usługa jest zatrzymana.';

  @override
  String get settingsNotificationListener => 'Usługa nasłuchiwania powiadomień';

  @override
  String get settingsTheme => 'Motyw aplikacji';

  @override
  String get settingsThemeDynamicColors => 'Dynamiczne kolory';

  @override
  String settingsThemeValue(String theme) {
    String _temp0 = intl.Intl.selectLogic(
      theme,
      {
        'dark': 'Tryb ciemny',
        'light': 'Tryb lekki',
        'other': 'Domyślny systemu',
      },
    );
    return '$_temp0';
  }

  @override
  String get settingsUseServerTimezone => 'Use server timezone';

  @override
  String get settingsUseServerTimezoneHelp =>
      'Show all times in the server timezone. This mimics the behavior of the webinterface.';

  @override
  String get settingsVersion => 'Wersja Aplikacji';

  @override
  String get settingsVersionChecking => 'sprawdzenie…';

  @override
  String get transactionAttachments => 'Załączniki';

  @override
  String get transactionDeleteConfirm =>
      'Czy na pewno chcesz usunąć tę transakcję?';

  @override
  String get transactionDialogAttachmentsDelete => 'Usuń załącznik';

  @override
  String get transactionDialogAttachmentsDeleteConfirm =>
      'Jesteś pewien, że chcesz usunąć ten załącznik?';

  @override
  String get transactionDialogAttachmentsErrorDownload =>
      'Nie można pobrać pliku.';

  @override
  String transactionDialogAttachmentsErrorOpen(String error) {
    return 'Nie można otworzyć pliku: $error';
  }

  @override
  String transactionDialogAttachmentsErrorUpload(String error) {
    return 'Nie można przesłać pliku: $error';
  }

  @override
  String get transactionDialogAttachmentsTitle => 'Załączniki';

  @override
  String get transactionDialogBillNoBill => 'Brak rachunku';

  @override
  String get transactionDialogBillTitle => 'Połącz z rachunkiem';

  @override
  String get transactionDialogCurrencyTitle => 'Wybierz walutę';

  @override
  String get transactionDialogTagsAdd => 'Dodaj Tag';

  @override
  String get transactionDialogTagsHint => 'Szukaj/Dodaj Tag';

  @override
  String get transactionDialogTagsTitle => 'Wybierz tagi';

  @override
  String get transactionDuplicate => 'Duplikat';

  @override
  String get transactionErrorInvalidAccount => 'Błędne konto';

  @override
  String get transactionErrorInvalidBudget => 'Błędny budżet';

  @override
  String get transactionErrorTitle => 'Proszę podać tytuł.';

  @override
  String get transactionFormLabelAccountDestination => 'Konto docelowe';

  @override
  String get transactionFormLabelAccountForeign => 'Konto zagraniczne';

  @override
  String get transactionFormLabelAccountOwn => 'Własne konto';

  @override
  String get transactionFormLabelAccountSource => 'Konto źródłowe';

  @override
  String get transactionFormLabelNotes => 'Notatki';

  @override
  String get transactionFormLabelTags => 'Tagi';

  @override
  String get transactionFormLabelTitle => 'Tytuł transakcji';

  @override
  String get transactionSplitAdd => 'Dodaj podzieloną transakcję';

  @override
  String get transactionSplitChangeCurrency => 'Zmień walutę podziału';

  @override
  String get transactionSplitChangeTarget => 'Zmień docelowe konto dzielenia';

  @override
  String get transactionSplitDelete => 'Usuń podział';

  @override
  String get transactionTitleAdd => 'Dodaj transakcję';

  @override
  String get transactionTitleDelete => 'Usuń transakcję';

  @override
  String get transactionTitleEdit => 'Edytuj transakcję';

  @override
  String get transactionTypeDeposit => 'Wpłata';

  @override
  String get transactionTypeTransfer => 'Przelew';

  @override
  String get transactionTypeWithdrawal => 'Wypłata';
}
