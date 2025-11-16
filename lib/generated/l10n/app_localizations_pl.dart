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
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'tydzień',
      'monthly': 'miesiąc',
      'quarterly': 'kwartał',
      'halfyear': 'pół roku',
      'yearly': 'rok',
      'other': 'nieznany',
    });
    return '$interest% odsetek za $_temp0';
  }

  @override
  String billsAmountAndFrequency(
    String minValue,
    String maxvalue,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Tygodniowo',
      'monthly': 'Miesięcznie',
      'quarterly': 'Kwartalnie',
      'halfyear': 'Półrocznie',
      'yearly': 'Rocznie',
      'other': 'Nieznany',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', pomiń $skip',
      zero: '',
    );
    return 'Subskrypcja odpowiada transakcjom pomiędzy $minValue, a $maxvalue. Powtarza się $_temp0$_temp1';
  }

  @override
  String get billsChangeLayoutTooltip => 'Zmień układ';

  @override
  String get billsChangeSortOrderTooltip => 'Zmień kolejność sortowania';

  @override
  String get billsErrorLoading => 'Błąd podczas ładowania subskrypcji.';

  @override
  String billsExactAmountAndFrequency(
    String value,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Tygodniowo',
      'monthly': 'Miesięcznie',
      'quarterly': 'Kwartalnie',
      'halfyear': 'Półrocznie',
      'yearly': 'Rocznie',
      'other': 'Nieznany',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', pomiń $skip',
      zero: '',
    );
    return 'Subskrypcja odpowiada transakcjom z $value. Powtarza się $_temp0$_temp1';
  }

  @override
  String billsExpectedOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Oczekiwany $dateString';
  }

  @override
  String billsFrequency(String frequency) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Tygodniowo',
      'monthly': 'miesięcznie',
      'quarterly': 'Kwartalnie',
      'halfyear': 'Półrocznie',
      'yearly': 'rocznie',
      'other': 'Nieznany',
    });
    return '$_temp0';
  }

  @override
  String billsFrequencySkip(String frequency, num skip) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Tygodniowo',
      'monthly': 'Miesięcznie',
      'quarterly': 'Kwartalnie',
      'halfyear': 'Półrocznie',
      'yearly': 'Rocznie',
      'other': 'Nieznany',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', pomiń $skip',
      zero: '',
    );
    return '$_temp0$_temp1';
  }

  @override
  String get billsInactive => 'Nieaktywny';

  @override
  String get billsIsActive => 'Subskrypcja aktywna';

  @override
  String get billsLayoutGroupSubtitle =>
      'Subskrypcje wyświetlane w przypisanych im grupach.';

  @override
  String get billsLayoutGroupTitle => 'Grupa';

  @override
  String get billsLayoutListSubtitle =>
      'Subskrypcje wyświetlane na liście posortowanej według określonych kryteriów.';

  @override
  String get billsLayoutListTitle => 'Lista';

  @override
  String get billsListEmpty => 'Lista jest obecnie pusta.';

  @override
  String get billsNextExpectedMatch => 'Następne oczekiwane dopasowanie';

  @override
  String get billsNotActive => 'Subskrypcja nieaktywna';

  @override
  String get billsNotExpected => 'Nie oczekiwany w tym okresie';

  @override
  String get billsNoTransactions => 'Nie znaleziono transakcji.';

  @override
  String billsPaidOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Zapłacone $dateString';
  }

  @override
  String get billsSortAlphabetical => 'Alfabetycznie';

  @override
  String get billsSortByTimePeriod => 'Według okresu';

  @override
  String get billsSortFrequency => 'Częstotliwość';

  @override
  String get billsSortName => 'Nazwa';

  @override
  String get billsUngrouped => 'Niezgrupowane';

  @override
  String get billsSettingsShowOnlyActive => 'Pokaż tylko aktywne';

  @override
  String get billsSettingsShowOnlyActiveDesc =>
      'Pokazuje tylko aktywne subskrypcje.';

  @override
  String get billsSettingsShowOnlyExpected => 'Pokaż tylko oczekiwane';

  @override
  String get billsSettingsShowOnlyExpectedDesc =>
      'Pokazuje tylko te subskrypcje, które są oczekiwane (lub opłacone) w tym miesiącu.';

  @override
  String get categoryDeleteConfirm =>
      'Czy na pewno chcesz usunąć tę kategorię? Transakcje nie zostaną usunięte, ale nie będą już posiadały kategorii.';

  @override
  String get categoryErrorLoading => 'Błąd podczas ładowania kategorii.';

  @override
  String get categoryFormLabelIncludeInSum => 'Uwzględnij w sumie miesięcznej';

  @override
  String get categoryFormLabelName => 'Nazwa Kategorii';

  @override
  String get categoryMonthNext => 'Następny Miesiąc';

  @override
  String get categoryMonthPrev => 'Poprzedni Miesiąc';

  @override
  String get categorySumExcluded => 'wykluczone';

  @override
  String get categoryTitleAdd => 'Dodaj Kategorię';

  @override
  String get categoryTitleDelete => 'Usuń kategorię';

  @override
  String get categoryTitleEdit => 'Edytuj Kategorię';

  @override
  String get catNone => '<Bez kategorii><no category>';

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
  String get generalAssets => 'Aktywa';

  @override
  String get generalBalance => 'Saldo';

  @override
  String generalBalanceOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Saldo na $dateString';
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
  String get generalDateRangeCurrentMonth => 'Bieżący miesiąc';

  @override
  String get generalDateRangeLast30Days => 'Ostatnie 30 dni';

  @override
  String get generalDateRangeCurrentYear => 'Bieżący rok';

  @override
  String get generalDateRangeLastYear => 'Poprzedni rok';

  @override
  String get generalDateRangeAll => 'Wszystko';

  @override
  String get generalDefault => 'domyślnie';

  @override
  String get generalDestinationAccount => 'Konto docelowe';

  @override
  String get generalDismiss => 'Anuluj';

  @override
  String get generalEarned => 'Zarobiono';

  @override
  String get generalError => 'Błąd';

  @override
  String get generalExpenses => 'Wydatki';

  @override
  String get generalIncome => 'Przychód';

  @override
  String get generalLiabilities => 'Zobowiązania';

  @override
  String get generalMultiple => 'wiele';

  @override
  String get generalNever => 'nigdy';

  @override
  String get generalReconcile => 'Zatwierdzone';

  @override
  String get generalReset => 'Resetuj';

  @override
  String get generalSourceAccount => 'Konto źródłowe';

  @override
  String get generalSpent => 'Wydano';

  @override
  String get generalSum => 'Suma';

  @override
  String get generalTarget => 'Cel';

  @override
  String get generalUnknown => 'Nieznany';

  @override
  String homeMainBillsInterval(String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'tydzień',
      'monthly': 'miesiąc',
      'quarterly': 'kwartał',
      'halfyear': 'pół roku',
      'yearly': 'rok',
      'other': 'nieznany',
    });
    return '$_temp0';
  }

  @override
  String get homeMainBillsTitle => 'Subskrypcje w następnym tygodniu';

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

    return ' ($fromString do $toString)';
  }

  @override
  String homeMainBudgetSum(String current, String status, String available) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'over': 'ponad',
      'other': 'zostało z',
    });
    return '$current $_temp0 $available';
  }

  @override
  String get homeMainBudgetTitle => 'Budżety na bieżący miesiąc';

  @override
  String get homeMainChartAccountsTitle => 'Podsumowanie konta';

  @override
  String get homeMainChartCategoriesTitle =>
      'Bilans kategorii dla bieżącego miesiąca';

  @override
  String get homeMainChartDailyAvg => 'Średnia z 7 dni';

  @override
  String get homeMainChartDailyTitle => 'Podsumowanie dnia';

  @override
  String get homeMainChartNetEarningsTitle => 'Przychody netto';

  @override
  String get homeMainChartNetWorthTitle => 'Wartość netto';

  @override
  String get homeMainChartTagsTitle => 'Bilans tagów dla bieżącego miesiąca';

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
  String get homeMainDialogSettingsTitle => 'Dostosuj pulpit';

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
  String get homePiggySavedMultiple => 'Zaoszczędzono do tej pory:';

  @override
  String homePiggyTarget(String amount) {
    return 'Docelowa kwota: $amount';
  }

  @override
  String get homePiggyAccountStatus => 'Status konta';

  @override
  String get homePiggyAvailableAmounts => 'Dostępne kwoty';

  @override
  String homePiggyAvailable(String amount) {
    return 'Dostępne: $amount';
  }

  @override
  String homePiggyInPiggyBanks(String amount) {
    return 'W skarbonkach: $amount';
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
  String get homeTransactionsDialogFilterDateRange => 'Zakres dat';

  @override
  String get homeTransactionsDialogFilterFutureTransactions =>
      'Pokaż przyszłe transakcje';

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
      'Pokaż tagi na liście transakcji';

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
  String get navigationBills => 'Subskrypcje';

  @override
  String get navigationCategories => 'Kategorie';

  @override
  String get navigationMain => 'Panel główny';

  @override
  String get generalSettings => 'Ustawienia';

  @override
  String get no => 'Nie';

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
  String get settingsFAQHelp =>
      'Otwórz w przeglądarce. Dostępne tylko w języku angielskim.';

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
  String get settingsNLAutoAdd => 'Utwórz transakcję bez interakcji';

  @override
  String get settingsNLDescription =>
      'Ta usługa pozwala na pobranie szczegółów transakcji z przychodzących powiadomień. Dodatkowo możesz wybrać domyślne konto, do którego transakcja powinna być przypisana — jeśli wartość nie jest ustawiona, spróbuje dopisać konto z powiadomienia.';

  @override
  String get settingsNLEmptyNote => 'Pozostaw pole notatki puste';

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
      'Uzupełnij tytuł transakcji tytułem powiadomienia';

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
    String _temp0 = intl.Intl.selectLogic(theme, {
      'dark': 'Tryb ciemny',
      'light': 'Tryb lekki',
      'other': 'Domyślny systemu',
    });
    return '$_temp0';
  }

  @override
  String get settingsUseServerTimezone => 'Użyj strefy czasowej serwera';

  @override
  String get settingsUseServerTimezoneHelp =>
      'Pokaż wszystkie czasy w strefie czasowej serwera. To naśladuje zachowanie interfejsu web.';

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
  String get transactionDialogPiggyNoPiggy => 'Brak skarbonki';

  @override
  String get transactionDialogPiggyTitle => 'Połącz ze skarbonką';

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
  String get transactionErrorNoAccounts => 'Proszę najpierw wypełnić konta.';

  @override
  String get transactionErrorNoAssetAccount => 'Proszę wybrać konto aktywów.';

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
  String get transactionSplitChangeDestinationAccount => 'Zmień konto docelowe';

  @override
  String get transactionSplitChangeSourceAccount => 'Zmień konto źródłowe';

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
