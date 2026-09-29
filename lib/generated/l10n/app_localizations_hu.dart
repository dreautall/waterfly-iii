// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class SHu extends S {
  SHu([String locale = 'hu']) : super(locale);

  @override
  String get accountRoleAssetCashWallet => 'Készpénz';

  @override
  String get accountRoleAssetCC => 'Hitelkártya';

  @override
  String get accountRoleAssetDefault => 'Alapértelmezett eszközszámla';

  @override
  String get accountRoleAssetSavings => 'Megtakarítási számla';

  @override
  String get accountRoleAssetShared => 'Megosztott eszközszámla';

  @override
  String get accountsLabelAsset => 'Eszközszámlák';

  @override
  String get accountsLabelExpense => 'Költségszámlák';

  @override
  String get accountsLabelLiabilities => 'Kötelezettségek';

  @override
  String get accountsLabelRevenue => 'Bevételi Számlák';

  @override
  String accountsLiabilitiesInterest(double interest, String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'hét',
      'monthly': 'hónap',
      'quarterly': 'negyedév',
      'halfyear': 'félév',
      'yearly': 'év',
      'other': 'ismeretlen',
    });
    return '$interest% kamat per $_temp0';
  }

  @override
  String billsAmountAndFrequency(
    String minValue,
    String maxvalue,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Heti',
      'monthly': 'Havi',
      'quarterly': 'Negyedéves',
      'halfyear': 'Féléves',
      'yearly': 'Éves',
      'other': 'Ismeretlen',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', $skip ismétlést átugorva',
      zero: '',
    );
    return 'A számla $minValue és $maxvalue közötti értékű tranzakcióknak felel meg. $_temp0 ismétlődésű$_temp1.';
  }

  @override
  String get billsChangeLayoutTooltip => 'Elrendezés módosítása';

  @override
  String get billsChangeSortOrderTooltip => 'Rendezési sorrend módosítása';

  @override
  String get billsErrorLoading => 'Hiba a számla betöltése során.';

  @override
  String billsExactAmountAndFrequency(
    String value,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Heti',
      'monthly': 'Havi',
      'quarterly': 'Negyedéves',
      'halfyear': 'Féléves',
      'yearly': 'Éves',
      'other': 'Ismeretlen',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', $skip ismétlést átugorva',
      zero: '',
    );
    return 'A számla $value értékű tranzakcióknak felel meg. $_temp0 ismétlődésű$_temp1.';
  }

  @override
  String billsExpectedOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Várható dátum $dateString';
  }

  @override
  String billsFrequency(String frequency) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Heti',
      'monthly': 'Havi',
      'quarterly': 'Negyedéves',
      'halfyear': 'Féléves',
      'yearly': 'Éves',
      'other': 'Ismeretlen',
    });
    return '$_temp0';
  }

  @override
  String billsFrequencySkip(String frequency, num skip) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Heti',
      'monthly': 'Havi',
      'quarterly': 'Negyedéves',
      'halfyear': 'Féléves',
      'yearly': 'Éves',
      'other': 'Ismeretlen',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', $skip ismétlést átugorva',
      zero: '',
    );
    return '$_temp0 ismétlődésű$_temp1';
  }

  @override
  String get billsInactive => 'Inaktív';

  @override
  String get billsIsActive => 'Aktív számla';

  @override
  String get billsLayoutGroupSubtitle =>
      'Számlák megjelenítése a hozzájuk rendelt csoportokban.';

  @override
  String get billsLayoutGroupTitle => 'Csoport';

  @override
  String get billsLayoutListSubtitle =>
      'Számlák megjelenítése egy listában bizonyos kritériumok szerint rendezve.';

  @override
  String get billsLayoutListTitle => 'Lista';

  @override
  String get billsListEmpty => 'A lista jelenleg üres.';

  @override
  String get billsNextExpectedMatch => 'Következő várható egyezés';

  @override
  String get billsNotActive => 'Inaktív számla';

  @override
  String get billsNotExpected => 'Nem várható ebben az időszakban';

  @override
  String get billsNoTransactions => 'Nem található tranzakció.';

  @override
  String billsPaidOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Kifizetés dátuma $dateString';
  }

  @override
  String get billsSortAlphabetical => 'Betűrendi';

  @override
  String get billsSortByTimePeriod => 'Időszak szerint';

  @override
  String get billsSortFrequency => 'Gyakoriság';

  @override
  String get billsSortName => 'Név';

  @override
  String get billsUngrouped => 'Csoportosítatlan';

  @override
  String get billsSettingsShowOnlyActive => 'Csak az aktívak';

  @override
  String get billsSettingsShowOnlyActiveDesc =>
      'Csak az aktív előfizetéseket mutatja.';

  @override
  String get billsSettingsShowOnlyExpected => 'Csak a várhatók';

  @override
  String get billsSettingsShowOnlyExpectedDesc =>
      'Csak azokat az előfizetéseket mutatja, amelyek várhatóak (vagy kifizetésre kerültek) ebben a hónapban.';

  @override
  String get categoryDeleteConfirm =>
      'Biztosan törli ezt a kategóriát? A tranzakciók nem kerülnek törlésre, ugyanakkor nem lesznek kategóriához rendelve.';

  @override
  String get categoryErrorLoading => 'Hiba a kategóriák betöltése során.';

  @override
  String get categoryFormLabelIncludeInSum => 'Beleszámítani a havi összegbe';

  @override
  String get categoryFormLabelName => 'Kategória neve';

  @override
  String get categoryMonthNext => 'Következő hónap';

  @override
  String get categoryMonthPrev => 'Előző hónap';

  @override
  String get categorySumExcluded => 'nem számított';

  @override
  String get categoryTitleAdd => 'Kategória hozzáadása';

  @override
  String get categoryTitleDelete => 'Kategória törlése';

  @override
  String get categoryTitleEdit => 'Kategória szerkesztése';

  @override
  String get catNone => '<nincs kategória>';

  @override
  String get catOther => 'Egyéb';

  @override
  String errorAPIInvalidResponse(String message) {
    return 'Érvénytelen válasz az API-tól: $message';
  }

  @override
  String get errorAPIUnavailable => 'API nem érhető el';

  @override
  String get errorFieldRequired => 'A mező kitöltése kötelező.';

  @override
  String get errorInvalidURL => 'Érvénytelen URL';

  @override
  String errorMinAPIVersion(String requiredVersion) {
    return 'Minimális támogatott Firefly API-verzió: v$requiredVersion. Kérjük, frissítsen.';
  }

  @override
  String errorStatusCode(int code) {
    return 'Státusz kód: $code';
  }

  @override
  String get errorUnknown => 'Ismeretlen hiba.';

  @override
  String get formButtonHelp => 'Súgó';

  @override
  String get formButtonLogin => 'Bejelentkezés';

  @override
  String get formButtonLogout => 'Kijelentkezés';

  @override
  String get formButtonRemove => 'Eltávolítás';

  @override
  String get formButtonResetLogin => 'A bejelentkezés visszaállítása';

  @override
  String get formButtonTransactionAdd => 'Tranzakció Hozzáadása';

  @override
  String get formButtonTryAgain => 'Próbálja újra';

  @override
  String get generalAccount => 'Számla';

  @override
  String get generalAssets => 'Vagyonok';

  @override
  String get generalBalance => 'Egyenleg';

  @override
  String generalBalanceOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Egyenleg ekkor: $dateString';
  }

  @override
  String get generalBill => 'Számla';

  @override
  String get generalBudget => 'Költségkeret';

  @override
  String get generalCategory => 'Kategória';

  @override
  String get generalCurrency => 'Pénznem';

  @override
  String get generalDateRangeCurrentMonth => 'Aktuális hónap';

  @override
  String get generalDateRangeLast30Days => 'Utolsó 30 nap';

  @override
  String get generalDateRangeCurrentYear => 'Aktuális év';

  @override
  String get generalDateRangeLastYear => 'Előző év';

  @override
  String get generalDateRangeAll => 'Összes';

  @override
  String get generalDefault => 'alapértelmezett';

  @override
  String get generalDestinationAccount => 'Célszámla';

  @override
  String get generalDismiss => 'Elvetés';

  @override
  String get generalEarned => 'Megkeresett';

  @override
  String get generalError => 'Hiba';

  @override
  String get generalExpenses => 'Kiadások';

  @override
  String get generalIncome => 'Bevétel';

  @override
  String get generalLeft => 'Left';

  @override
  String get generalLiabilities => 'Kötelezettségek';

  @override
  String get generalMultiple => 'több';

  @override
  String get generalNever => 'soha';

  @override
  String get generalReconcile => 'Egyeztetve';

  @override
  String get generalReset => 'Visszaállítás';

  @override
  String get generalSourceAccount => 'Forrásszámla';

  @override
  String get generalSpent => 'Elköltött';

  @override
  String get generalSum => 'Összesen';

  @override
  String get generalTarget => 'Cél';

  @override
  String get generalUnknown => 'Ismeretlen';

  @override
  String get homeMainActionPrivacyMode =>
      'Show/Hide all amounts (Privacy Mode)';

  @override
  String homeMainBillsInterval(String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'heti',
      'monthly': 'havi',
      'quarterly': 'negyedéves',
      'halfyear': 'féléves',
      'yearly': 'éves',
      'other': 'ismeretlen',
    });
    return ' ($_temp0)';
  }

  @override
  String get homeMainBillsTitle => 'Számlák a következő hétre';

  @override
  String homeMainBudgetInterval(DateTime from, DateTime to, String period) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return ' (Ettől: $fromString eddig: $toString, $period)';
  }

  @override
  String homeMainBudgetIntervalSingle(DateTime from, DateTime to) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return ' (Ettől: $fromString eddig: $toString)';
  }

  @override
  String homeMainBudgetSum(String current, String status, String available) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'over': 'többletköltség a',
      'other': 'maradt a',
    });
    String _temp1 = intl.Intl.selectLogic(status, {
      'over': 'limithez képest',
      'other': 'limitből',
    });
    return '$current $_temp0 $available $_temp1';
  }

  @override
  String get homeMainBudgetTitle => 'Költségkeretek erre a hónapra';

  @override
  String get homeMainChartAccountsTitle => 'Számla Áttekintése';

  @override
  String get homeMainChartCategoriesTitle =>
      'Kategória összefoglaló az aktuális hónapra';

  @override
  String get homeMainChartDailyAvg => '7 napi átlag';

  @override
  String get homeMainChartDailyTitle => 'Napi Összefoglaló';

  @override
  String get homeMainChartNetEarningsTitle => 'Nettó Kereset';

  @override
  String get homeMainChartNetWorthTitle => 'Nettó Érték';

  @override
  String get homeMainChartTagsTitle => 'Címke összefoglaló az aktuális hónapra';

  @override
  String get homePiggyAdjustDialogTitle => 'Pénz megtakarítása/költése';

  @override
  String homePiggyDateStart(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Kezdés dátuma: $dateString';
  }

  @override
  String homePiggyDateTarget(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Céldátum: $dateString';
  }

  @override
  String get homeMainDialogSettingsTitle => 'Műszerfal testreszabása';

  @override
  String homePiggyLinked(String account) {
    return 'Összekapcsolva a következővel: $account';
  }

  @override
  String get homePiggyNoAccounts => 'Még nincsenek malacperselyek.';

  @override
  String get homePiggyNoAccountsSubtitle =>
      'Hozzon létre néhányat a webes felületen!';

  @override
  String homePiggyRemaining(String amount) {
    return 'Megtakarításra váró összeg: $amount';
  }

  @override
  String homePiggySaved(String amount) {
    return 'Eddig megtakarított összeg: $amount';
  }

  @override
  String homePiggySavePerMonth(String amount) {
    return 'Spórolás havonta: $amount';
  }

  @override
  String get homePiggySavedMultiple => 'Eddig megtakarítva:';

  @override
  String homePiggyTarget(String amount) {
    return 'Célösszeg: $amount';
  }

  @override
  String get homePiggyAccountStatus => 'Számla állapota';

  @override
  String get homePiggyAvailableAmounts => 'Rendelkezésre álló összegek';

  @override
  String homePiggyAvailable(String amount) {
    return 'Rendelkezésre álló: $amount';
  }

  @override
  String homePiggyInPiggyBanks(String amount) {
    return 'Perselyekben: $amount';
  }

  @override
  String homePiggyTotal(String amount) {
    return 'Egyenleg: $amount';
  }

  @override
  String get homeTabLabelBalance => 'Egyenleg';

  @override
  String get homeTabLabelMain => 'Kezdőlap';

  @override
  String get homeTabLabelPiggybanks => 'Malacperselyek';

  @override
  String get homeTabLabelTransactions => 'Tranzakciók';

  @override
  String get homeTransactionsActionFilter => 'Szűrő lista';

  @override
  String get homeTransactionsDialogFilterAccountsAll => '<Összes Számla>';

  @override
  String get homeTransactionsDialogFilterBillsAll => '<Összes Számla>';

  @override
  String get homeTransactionsDialogFilterBillUnset =>
      '<Nincs Számla Kiválasztva>';

  @override
  String get homeTransactionsDialogFilterBudgetsAll => '<Összes Költségkeret>';

  @override
  String get homeTransactionsDialogFilterBudgetUnset =>
      '<Nincs Költségkeret Kiválasztva>';

  @override
  String get homeTransactionsDialogFilterCategoriesAll => '<Összes Kategória>';

  @override
  String get homeTransactionsDialogFilterCategoryUnset =>
      '<Nincs Kategória Kiválasztva>';

  @override
  String get homeTransactionsDialogFilterCurrenciesAll => '<Összes Pénznem>';

  @override
  String get homeTransactionsDialogFilterDateRange => 'Dátumtartomány';

  @override
  String get homeTransactionsDialogFilterFutureTransactions =>
      'Jövőbeli tranzakciók megjelenítése';

  @override
  String get homeTransactionsDialogFilterSearch => 'Keresési Kifejezés';

  @override
  String get homeTransactionsDialogFilterTitle => 'Szűrők kiválasztása';

  @override
  String get homeTransactionsEmpty => 'Nem található tranzakció.';

  @override
  String homeTransactionsMultipleCategories(int num) {
    return '$num kategória';
  }

  @override
  String get homeTransactionsSettingsShowTags =>
      'Címkék megjelenítése a tranzakciós listában';

  @override
  String get liabilityDirectionCredit => 'Tartoznak nekem ezzel az adóssággal';

  @override
  String get liabilityDirectionDebit => 'Tartozom ezzel az adóssággal';

  @override
  String get liabilityTypeDebt => 'Adósság';

  @override
  String get liabilityTypeLoan => 'Kölcsön';

  @override
  String get liabilityTypeMortgage => 'Jelzálog';

  @override
  String get loginAbout =>
      'A Waterfly III hatékony használatához saját szerveren futtatott Firefly III-ra vagy Firefly III kiegészítővel ellátott Home Assistant-re van szükség.\n\nKérjük, adja meg alább a teljes URL-t, valamint egy személyes hozzáférési tokent (Beállítások -> Profil -> OAuth -> Személyes hozzáférési tokenek).';

  @override
  String get loginFormButtonHideHeaders => 'Fejlécek elrejtése';

  @override
  String get loginFormButtonShowHeaders => 'Egyéni fejlécek';

  @override
  String get loginFormLabelAPIKey => 'Érvényes API kulcs';

  @override
  String get loginFormLabelHeaders => 'Egyéni fejlécek (opcionális)';

  @override
  String get loginFormLabelHeadersHelp =>
      'Soronként egy, formátum: FejlécNév: érték';

  @override
  String get loginFormLabelHost => 'Szerver URL';

  @override
  String get loginWelcome => 'Üdvözöljük a Waterfly III-ban';

  @override
  String get logoutConfirmation => 'Biztos, hogy ki szeretne jelentkezni?';

  @override
  String get navigationAccounts => 'Fiókok';

  @override
  String get navigationBills => 'Számlák';

  @override
  String get navigationCategories => 'Kategóriák';

  @override
  String get navigationMain => 'Irányítópult';

  @override
  String get generalSettings => 'Beállítások';

  @override
  String get no => 'Nem';

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

    return '$of $percString-a';
  }

  @override
  String get settingsDialogDebugInfo =>
      'Itt engedélyezheti és küldheti el a hibakeresési naplókat. A naplók gyűjtése rossz hatással van a teljesítményre, ezért kérjük, ne engedélyezze őket, hacsak nem kapott erre javaslatot. A naplózás letiltása törli a tárolt naplót.';

  @override
  String get settingsDialogDebugMailCreate => 'Levél Létrehozása';

  @override
  String get settingsDialogDebugMailDisclaimer =>
      'FIGYELMEZTETÉS: Egy levél piszkozat fog megnyílni a csatolt naplófájllal (szöveg formátumban). A naplók érzékeny információkat tartalmazhatnak, például a Firefly-példány gazdagépnevét (bár igyekszem elkerülni a titkok, például az API-kulcs naplózását). Kérjük, figyelmesen olvassa el a naplót, és cenzúrázzon minden olyan információt, amelyet nem szeretne megosztani, és/vagy nem kapcsolódik a jelenteni kívánt problémához.\n\nKérjük, ne küldjön naplókat előzetes egyeztetés nélkül e-mailben/GitHubon keresztül. Adatvédelmi okokból törlöm a kontextus nélkül küldött naplókat. Soha ne töltse fel a naplót cenzúrázatlanul a GitHub-ra vagy máshová.';

  @override
  String get settingsDialogDebugSendButton => 'Naplók küldése e-mailben';

  @override
  String get settingsDialogDebugTitle => 'Hibakeresési Naplók';

  @override
  String get settingsDialogLanguageTitle => 'Nyelv Kiválasztása';

  @override
  String get settingsDialogThemeTitle => 'Téma Kiválasztása';

  @override
  String get settingsFAQ => 'GYIK';

  @override
  String get settingsFAQHelp =>
      'Megnyitás böngészőben. Csak angol nyelven elérhető.';

  @override
  String get settingsLanguage => 'Nyelv';

  @override
  String get settingsLockscreen => 'Zárképernyő';

  @override
  String get settingsLockscreenHelp => 'Require authentication on app startup';

  @override
  String get settingsLockscreenInitial =>
      'A lezárási képernyő engedélyezéséhez hitelesítsen.';

  @override
  String get settingsNLDescription =>
      'Ez a szolgáltatás lehetővé teszi a tranzakció részleteinek lekérését a bejövő értesítésekből. Továbbá kiválaszthat egy alapértelmezett számlát, amelyhez a tranzakciót hozzá kívánja rendelni - amennyiben ez nincs beállítva, akkor a szolgáltatás az értesítés szövegéből kisérli meg annak kinyerését.';

  @override
  String get settingsNLPermissionNotGranted => 'Hozzáférés megtagadva.';

  @override
  String get settingsNLServiceChecking => 'Állapot ellenőrzése…';

  @override
  String get settingsNLServiceCheckingTitle => 'Checking notification access';

  @override
  String settingsNLServiceCheckingError(String error) {
    return 'Hibaellenőrzés állapota: $error';
  }

  @override
  String get settingsNLServiceUnavailableTitle => 'Status unavailable';

  @override
  String get settingsNLAccessNeededTitle => 'Notification access needed';

  @override
  String get settingsNLAccessNeededDescription =>
      'Grant notification access so Waterfly can read supported notifications.';

  @override
  String get settingsNLAccessEnabledTitle => 'Notification access enabled';

  @override
  String get settingsNLAccessEnabledDescription =>
      'Waterfly can listen for supported notifications.';

  @override
  String get settingsNLListenerStoppedTitle => 'Listener service stopped';

  @override
  String get settingsNLListenerStoppedDescription =>
      'Open Android notification access settings and re-enable Waterfly.';

  @override
  String get settingsNLServiceRunning => 'A szolgáltatás fut.';

  @override
  String get settingsNLServiceStatus => 'Szolgáltatás Állapota';

  @override
  String get settingsNLServiceStopped => 'A szolgáltatás leállt.';

  @override
  String get settingsNotificationListener => 'Értesítés Figyelő Szolgáltatás';

  @override
  String get settingsServerConnection => 'Kiszolgáló kapcsolat';

  @override
  String get settingsServerConnectionUpdated =>
      'Kapcsolati beállítások frissítve.';

  @override
  String get settingsTag => 'Tag Transactions';

  @override
  String get settingsTagAllHelp =>
      'Automatically add a tag for all new transactions.';

  @override
  String settingsTagList(int count, String tags) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'tags: $tags',
      one: 'tag: $tags',
    );
    return 'Selected $_temp0';
  }

  @override
  String get settingsTagNLHelp =>
      'Automatically add a tag for transactions created from the listener.';

  @override
  String get settingsTheme => 'Alkalmazás Téma';

  @override
  String get settingsThemeDynamicColors => 'Dinamikus Színek';

  @override
  String settingsThemeValue(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'dark': 'Sötét',
      'light': 'Világos',
      'other': 'Alapértelmezett',
    });
    return '$_temp0';
  }

  @override
  String get settingsUseServerTimezone => 'Használja a szerver időzónáját';

  @override
  String get settingsUseServerTimezoneHelp =>
      'Minden időpont megjelenítése a szerver időzónájában. Ez a webes felület viselkedését utánozza.';

  @override
  String get settingsVersion => 'Alkalmazás Verzió';

  @override
  String get settingsVersionChecking => 'ellenőrzés…';

  @override
  String get tagNone => '<no tag>';

  @override
  String get transactionAttachments => 'Mellékletek';

  @override
  String get transactionDeleteConfirm =>
      'Biztos benne, hogy törölni szeretné ezt a tranzakciót?';

  @override
  String get transactionDialogAttachmentsDelete => 'Melléklet Törlése';

  @override
  String get transactionDialogAttachmentsDeleteConfirm =>
      'Biztos benne, hogy törölni szeretné ezt a mellékletet?';

  @override
  String get transactionDialogAttachmentsErrorDownload =>
      'Nem sikerült letölteni a fájlt.';

  @override
  String transactionDialogAttachmentsErrorOpen(String error) {
    return 'Nem sikerült megnyitni a fájlt: $error';
  }

  @override
  String transactionDialogAttachmentsErrorUpload(String error) {
    return 'Nem sikerült feltölteni a fájlt: $error';
  }

  @override
  String get transactionDialogAttachmentsTitle => 'Mellékletek';

  @override
  String get transactionDialogBillNoBill => 'Nincs számla';

  @override
  String get transactionDialogBillTitle => 'Számlához Rendelés';

  @override
  String get transactionDialogCurrencyTitle => 'Pénznem kiválasztása';

  @override
  String get transactionDialogPiggyNoPiggy => 'Nincs malacpersely';

  @override
  String get transactionDialogPiggyTitle => 'Kapcsolás malacperselyhez';

  @override
  String get transactionDialogTagsAdd => 'Címke hozzáadása';

  @override
  String get transactionDialogTagsHint => 'Címke keresése/hozzáadása';

  @override
  String get transactionDialogTagsTitle => 'Címke kiválasztása';

  @override
  String get transactionDuplicate => 'Duplikálás';

  @override
  String get transactionErrorInvalidAccount => 'Érvénytelen Számla';

  @override
  String get transactionErrorInvalidBudget => 'Érvénytelen Költségkeret';

  @override
  String get transactionErrorNoAccounts =>
      'Kérjük, először töltse ki a számlákat.';

  @override
  String get transactionErrorNoAssetAccount =>
      'Kérjük, válasszon ki egy eszközzámlát.';

  @override
  String get transactionErrorTitle => 'Kérjük, adjon meg egy leírást.';

  @override
  String get transactionFormLabelAccountDestination => 'Célszámla';

  @override
  String get transactionFormLabelAccountForeign => 'Külföldi számla';

  @override
  String get transactionFormLabelAccountOwn => 'Saját számla';

  @override
  String get transactionFormLabelAccountSource => 'Forrás számla';

  @override
  String get transactionFormLabelNotes => 'Jegyzetek';

  @override
  String get transactionFormLabelTags => 'Címkék';

  @override
  String get transactionFormLabelTitle => 'Tranzakció Leírása';

  @override
  String get transactionSplitAdd => 'Osztott tranzakció hozzáadása';

  @override
  String get transactionSplitChangeCurrency =>
      'Felosztás Pénznemének Megváltoztatása';

  @override
  String get transactionSplitChangeDestinationAccount =>
      'Részletes felosztás célszámlájának módosítása';

  @override
  String get transactionSplitChangeSourceAccount =>
      'Részletes felosztás forrásszámlájának módosítása';

  @override
  String get transactionSplitChangeTarget =>
      'Felosztás Célszámlájának Megváltoztatása';

  @override
  String get transactionSplitDelete => 'Felosztás törlése';

  @override
  String get transactionTitleAdd => 'Tranzakció Hozzáadása';

  @override
  String get transactionTitleDelete => 'Tranzakció Törlése';

  @override
  String get transactionTitleEdit => 'Tranzakció Szerkesztése';

  @override
  String get transactionTypeDeposit => 'Bevétel';

  @override
  String get transactionTypeTransfer => 'Átvezetés';

  @override
  String get transactionTypeWithdrawal => 'Költség';

  @override
  String notificationsRuleActionCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count actions',
      one: '1 action',
      zero: 'No actions',
    );
    return '$_temp0';
  }

  @override
  String get notificationsRuleAppliesWhenTitle => 'Applies when';

  @override
  String get notificationsRuleAppliesWhenDescription =>
      'Rules are checked from top to bottom. This rule is selected when every condition below matches.';

  @override
  String get notificationsRuleAlwaysMatches =>
      'No conditions: this rule always matches.';

  @override
  String get notificationsRuleAlwaysActionsTitle => 'Always executed actions';

  @override
  String get notificationsRuleAlwaysActionsDescription =>
      'Run whenever this rule is selected, before matching conditional actions.';

  @override
  String get notificationsRuleConditionalActionsTitle => 'Conditional actions';

  @override
  String get notificationsRuleConditionalActionsDescription =>
      'Every matching group runs from top to bottom. Later values override earlier ones.';

  @override
  String get notificationsRuleNoConditionalActions => 'No conditional actions';

  @override
  String get notificationsRuleAddConditionalActions => 'Add conditional action';

  @override
  String get notificationsRuleConditionalActionName =>
      'Conditional action name';

  @override
  String get notificationsRuleNameConditionalActionDescription =>
      'Give this conditional action a clear name.';

  @override
  String get notificationsRuleConditionalActionOptions =>
      'Conditional action options';

  @override
  String get notificationsRuleRenameConditionalActionTitle =>
      'Rename conditional action';

  @override
  String get notificationsRuleRenameConditionalActionDescription =>
      'Choose a name that describes when these actions run.';

  @override
  String get notificationsRuleRemoveConditionalActionTitle =>
      'Remove conditional action?';

  @override
  String notificationsRuleRemoveConditionalActionDescription(String name) {
    return '\"$name\" and all of its conditions and actions will be removed.';
  }

  @override
  String get notificationsRuleConditionalGroupWhenTitle => 'Applies when';

  @override
  String get notificationsRuleConditionalGroupWhenDescription =>
      'This group runs when every condition below matches the notification or extracted values.';

  @override
  String get notificationsRuleConditionalGroupNoConditions =>
      'No conditions defined. This conditional action will not run.';

  @override
  String get notificationsRuleConditionalGroupNoActions =>
      'No actions defined. This conditional action will not change the transaction.';

  @override
  String get notificationsRuleConditionalGroupNeedsConditionsMessage =>
      'Add at least one condition so this conditional action only runs when it should.';

  @override
  String get notificationsRuleConditionalGroupNeedsActionsMessage =>
      'Add at least one action so this conditional action can change the transaction.';

  @override
  String get notificationsRuleActionsDescription =>
      'Choose which transaction fields this rule sets when its conditions match.';

  @override
  String get notificationsRuleActionsTitle => 'Actions';

  @override
  String get notificationsRuleAddCondition => 'Add condition';

  @override
  String notificationsRuleConditionCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count conditions',
      one: '1 condition',
      zero: 'No conditions',
    );
    return '$_temp0';
  }

  @override
  String notificationsRuleConditionCapture(String capture) {
    return 'Capture: $capture';
  }

  @override
  String notificationsRuleConditionCaptures(String captures) {
    return 'Captures: $captures';
  }

  @override
  String get notificationsRuleMatches => 'Matches';

  @override
  String get notificationsRuleDoesNotMatch => 'Does not match';

  @override
  String get notificationsRuleCouldNotEvaluate => 'Could not evaluate';

  @override
  String get notificationsRuleSampleValueLabel => 'Sample value: ';

  @override
  String get notificationsRuleLeftSampleValueLabel => 'Left value: ';

  @override
  String get notificationsRuleRightSampleValueLabel => 'Right value: ';

  @override
  String notificationsRuleConditionMatchSummary(int matched, int total) {
    return '$matched of $total match';
  }

  @override
  String notificationsRuleConditionUnresolvedSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count could not be evaluated',
      one: '1 could not be evaluated',
    );
    return '$_temp0';
  }

  @override
  String notificationsRuleNestedConditionResult(String result) {
    return 'Nested condition: $result';
  }

  @override
  String get notificationsRuleConditionsDescription =>
      'This rule runs only when every condition matches.';

  @override
  String get notificationsRuleConditionsTitle => 'Conditions';

  @override
  String get notificationsRuleDelete => 'Delete';

  @override
  String get notificationsRuleDeleteDescription =>
      'This rule, including its conditions and actions, will be removed.';

  @override
  String get notificationsRuleDeleteTitle => 'Delete rule?';

  @override
  String get notificationsRuleEditTestNotification => 'Edit test notification';

  @override
  String get notificationsRuleEnterTestMode => 'Enter test mode';

  @override
  String get notificationsRuleExitTestMode => 'Exit test mode';

  @override
  String get notificationsRuleNeedsSetup => 'Needs setup';

  @override
  String get notificationsRuleNeedsSetupMessage =>
      'Complete or fix the rule\'s actions before it can produce a valid transaction.';

  @override
  String get notificationsRuleNoActions => 'No actions defined.';

  @override
  String get notificationsRuleNoConditions =>
      'No conditions: this rule always runs.';

  @override
  String get notificationsRuleOptions => 'Rule options';

  @override
  String get notificationsRulePredefinedActionsDescription =>
      'Review how notification values fill transaction fields. Firefly-linked fields, such as currency, can use existing Firefly entries.';

  @override
  String get notificationsRuleRemove => 'Remove';

  @override
  String notificationsRuleRemoveActionDescription(String name) {
    return 'This action will no longer set a transaction field when \"$name\" runs.';
  }

  @override
  String get notificationsRuleRemoveActionTitle => 'Remove action?';

  @override
  String notificationsRuleRemoveConditionDescription(String name) {
    return 'This condition will no longer control when \"$name\" runs.';
  }

  @override
  String get notificationsRuleRemoveConditionTitle => 'Remove condition?';

  @override
  String get notificationsRuleRename => 'Rename';

  @override
  String get notificationsRuleNeedsReview => 'Needs review';

  @override
  String get notificationsRuleNeedsReviewMessage =>
      'Review the suggested transaction field mappings before using this rule.';

  @override
  String get notificationsConditionalActionsNeedReviewMessage =>
      'Review conditional actions marked Needs review and any suggested field mappings before using this rule.';

  @override
  String get notificationsRuleTestModeMessage =>
      'Values and availability below are evaluated against the current sample notification.';

  @override
  String get notificationsRuleSampleNotification => 'Sample notification';

  @override
  String get notificationsRuleSampleDescription =>
      'Fine-tune the sample for this rule while keeping the definition sample available throughout the definition.';

  @override
  String get notificationsConditionalActionSampleDescription =>
      'Fine-tune the sample for this conditional action while keeping the rule sample available to the rest of the rule.';

  @override
  String get notificationsUseDefinitionSample => 'Use definition sample';

  @override
  String get notificationsUseRuleSample => 'Use rule sample';

  @override
  String get notificationsRuleAddAction => 'Add action';

  @override
  String get notificationsRuleTestMode => 'Test mode';

  @override
  String get notificationsRuleTransactionDetails => 'Transaction details';

  @override
  String get notificationsRuleActionOptions => 'Action options';

  @override
  String get notificationsRuleAddOptionalField => 'Add optional field';

  @override
  String get notificationsRuleAddTags => 'Add tag(s)';

  @override
  String get notificationsRuleAdjustableMappings => 'Adjustable mappings';

  @override
  String get notificationsRuleAdjustableMappingsDescription =>
      'Review editable mappings and add optional fields before marking the rule complete.';

  @override
  String get notificationsRuleAllConditionsMatch => 'All conditions match';

  @override
  String get notificationsRuleAlreadyAdded => 'Already added.';

  @override
  String get notificationsRuleAnyConditionMatches => 'Any condition matches';

  @override
  String notificationsRuleChooseExtractorMatch(int count, String extractor) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Choose one of the $count matches from \"$extractor\".',
      one: 'Choose the match from \"$extractor\".',
      zero: 'No matches are available from \"$extractor\".',
    );
    return '$_temp0';
  }

  @override
  String get notificationsRuleChooseMatchingCurrency =>
      'Choose a matching Firefly currency.';

  @override
  String get notificationsRuleChooseMatchingCurrencyBeforeReview =>
      'Choose a matching Firefly currency before marking this mapping as done.';

  @override
  String get notificationsRuleConditionDoesNotMatch =>
      'Condition does not match';

  @override
  String get notificationsRuleConditionOptions => 'Condition options';

  @override
  String notificationsRuleDeletedCaptureExtractor(String name) {
    return 'The extractor used by \"$name\" was deleted.';
  }

  @override
  String get notificationsRuleDeletedExtractor => 'Deleted extractor';

  @override
  String get notificationsRuleDeleteCondition => 'Delete condition';

  @override
  String get notificationsRuleEdit => 'Edit';

  @override
  String get notificationsRuleDuplicate => 'Duplicate';

  @override
  String get notificationsRuleCopy => 'Copy';

  @override
  String get notificationsRuleCopyingCondition => 'Copying condition';

  @override
  String get notificationsRuleLeaveCopyingConditionTitle =>
      'Leave while copying a condition?';

  @override
  String get notificationsRuleLeaveCopyingConditionDescription =>
      'The copy hasn\'t been pasted. Leaving will cancel it.';

  @override
  String get notificationsRuleLeaveCopyingConditionDirty =>
      'The copy hasn\'t been pasted. Leaving will cancel it and discard your unsaved changes.';

  @override
  String get notificationsRuleLeaveMovingConditionTitle =>
      'Leave while moving a condition?';

  @override
  String get notificationsRuleLeaveMovingConditionDescription =>
      'The condition hasn\'t been moved. Leaving will cancel the move.';

  @override
  String get notificationsRuleLeaveMovingConditionDirty =>
      'The condition hasn\'t been moved. Leaving will cancel the move and discard your unsaved changes.';

  @override
  String get notificationsRuleLeavePage => 'Leave page';

  @override
  String get notificationsRuleStayHere => 'Stay here';

  @override
  String get notificationsRuleMove => 'Move';

  @override
  String get notificationsRuleMovingCondition => 'Moving condition';

  @override
  String get notificationsRuleSelectMoveDestination => 'Select a destination.';

  @override
  String get notificationsRuleMoveHere => 'Move here';

  @override
  String get notificationsRulePaste => 'Paste';

  @override
  String get notificationsRulePasteHere => 'Paste here';

  @override
  String get notificationsRuleEditCurrencyMapping => 'Edit currency mapping';

  @override
  String get notificationsRuleFixedMappings => 'Fixed mappings';

  @override
  String get notificationsRuleFixedMappingsDescription =>
      'These mappings are managed by Basic mode and cannot be edited here.';

  @override
  String get notificationsRuleMarkMappingDone => 'Mark mapping as done';

  @override
  String get notificationsRuleMarkMappingNeedsReview =>
      'Mark mapping as needing review';

  @override
  String get notificationsRuleSampleValueIssuesTitle => 'Sample value issues';

  @override
  String get notificationsRuleSampleValueIssuesDescription =>
      'These values are required by this rule or its inherited actions but could not be resolved from the sample notification.';

  @override
  String get notificationsRuleInheritedFromSharedActions =>
      'Inherited from shared actions';

  @override
  String get notificationsRuleMissingRequiredExtractor =>
      'The required extractor no longer exists.';

  @override
  String get notificationsRuleMissingExtractorTitle => 'Missing extractor';

  @override
  String notificationsRuleMissingCaptureValues(String names) {
    return 'No sample value was captured for: $names.';
  }

  @override
  String notificationsRuleNoCapturedValue(String name) {
    return 'No value captured from \"$name\" in the sample.';
  }

  @override
  String get notificationsRuleRemoveOptionalMapping =>
      'Remove optional mapping';

  @override
  String notificationsRuleSelectedTagCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tags selected',
      one: '1 tag selected',
      zero: 'No tags selected',
    );
    return '$_temp0';
  }

  @override
  String get notificationsRuleSetTransactionTags => 'Set transaction tags';

  @override
  String get notificationsRuleUnsupportedAction => 'Unsupported action.';

  @override
  String get notificationsDefinitionReady => 'Ready';

  @override
  String get notificationsDefinitionDeleteFailure =>
      'The application registration could not be deleted.';

  @override
  String get notificationsDefinitionDelete => 'Delete';

  @override
  String notificationsDefinitionFixDanglingActions(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Fix $count actions that reference deleted extractors before saving.',
      one: 'Fix the action that references a deleted extractor before saving.',
      zero: 'No actions reference deleted extractors.',
    );
    return '$_temp0';
  }

  @override
  String get notificationsDefinitionNeedsSetup => 'Needs setup';

  @override
  String get notificationsDefinitionNeedsSetupMessage =>
      'Complete the sample, extractors, rules, and required actions before this application can process notifications.';

  @override
  String notificationsDefinitionNeedsSetupSpecificMessage(String requirements) {
    return 'Finish setting up $requirements before this application can process notifications.';
  }

  @override
  String get notificationsDefinitionSetupRequirementSample =>
      'a sample notification';

  @override
  String get notificationsDefinitionSetupRequirementExtractors =>
      'at least one extractor';

  @override
  String get notificationsDefinitionSetupRequirementRulesOrActions =>
      'at least one rule or shared action';

  @override
  String get notificationsDefinitionSetupRequirementActionFields =>
      'required transaction fields';

  @override
  String notificationsListPair(String first, String second) {
    return '$first and $second';
  }

  @override
  String notificationsListMultiple(String leading, String last) {
    return '$leading, and $last';
  }

  @override
  String get notificationsDefinitionOptions => 'Definition options';

  @override
  String get notificationsDefinitionNeedsReview => 'Needs review';

  @override
  String get notificationsDefinitionNeedsReviewMessage =>
      'Review the suggested transaction field mappings before using this application.';

  @override
  String get notificationsDefinitionConditionalActionsNeedReviewMessage =>
      'Review conditional actions marked Needs review and any suggested field mappings before using this application.';

  @override
  String notificationsDefinitionMigrationNeedsAttention(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Imported setup needs attention · $count issues',
      one: 'Imported setup needs attention',
    );
    return '$_temp0';
  }

  @override
  String get notificationsDefinitionMigrationFailedMessage =>
      'Waterfly could not finish importing the previous notification settings.';

  @override
  String get notificationsDefinitionMigrationReviewMessage =>
      'Review the imported notification settings before using this application.';

  @override
  String get notificationsDefinitionMigrationOpenSetupHint =>
      'Open this setup to resolve the migration issues.';

  @override
  String get notificationsDefinitionNotConfiguredMessage =>
      'Choose how Waterfly should read this application\'s notifications.';

  @override
  String get notificationsDefinitionSampleDescription =>
      'Use one representative notification to preview extractors and rules. Individual extractors and rules can use separate test samples.';

  @override
  String get notificationsSampleTimestamp => 'Sample time';

  @override
  String get notificationsDefinitionSampleNotification => 'Sample notification';

  @override
  String get notificationsDefinitionSave => 'Save definition';

  @override
  String get notificationsDefinitionSaveFailure =>
      'The notification definition could not be saved.';

  @override
  String get notificationsDiscardChangesTitle => 'Discard changes?';

  @override
  String get notificationsDiscardChangesDescription =>
      'Your unsaved changes will be lost.';

  @override
  String get notificationsDiscard => 'Discard';

  @override
  String get notificationsDefinitionNotConfigured => 'Not configured';

  @override
  String get notificationsDefinitionConvert => 'Convert';

  @override
  String get notificationsDefinitionConvertToAdvanced => 'Convert to advanced';

  @override
  String get notificationsDefinitionConvertToAdvancedDescription =>
      'Your existing extractors and rules will be kept and can be edited in Advanced mode.';

  @override
  String get notificationsDefinitionConvertToAdvancedTitle =>
      'Convert to advanced?';

  @override
  String get notificationsDefinitionConvertToBasic => 'Convert to basic';

  @override
  String get notificationsDefinitionConvertToBasicDescription =>
      'Your custom extractors and rules will be replaced with the standard transaction fields and rule used by Basic mode.';

  @override
  String get notificationsDefinitionConvertToBasicTitle => 'Convert to basic?';

  @override
  String get notificationsDefinitionsAddApplication => 'Add application';

  @override
  String get notificationsApplicationsRecoverTitle => 'Choose application';

  @override
  String get notificationsApplicationsRecoverDescription =>
      'Waterfly could not identify the application associated with these imported settings. Choose the installed application that should use this configuration.';

  @override
  String notificationsDefinitionsDeleteDescription(String name) {
    return '$name will no longer process notifications.';
  }

  @override
  String get notificationsDefinitionsDeleteTitle =>
      'Delete application registration?';

  @override
  String get notificationsDefinitionsDuplicate =>
      'This application is already registered.';

  @override
  String get notificationsDefinitionsEmpty =>
      'No apps are configured to process notifications.';

  @override
  String get notificationsDefinitionsEmptyTitle => 'No registered applications';

  @override
  String get notificationsDefinitionsEmptyDescription =>
      'Add an application to choose which notifications Waterfly should turn into transactions.';

  @override
  String get notificationsDefinitionsEmptyDescriptionAccessNeeded =>
      'Add and configure an application now. Waterfly will begin processing its notifications after notification access is enabled.';

  @override
  String get notificationsDefinitionsLoadFailure =>
      'Notification definitions could not be loaded.';

  @override
  String get notificationsDefinitionsMigrationAlertsLoadFailure =>
      'Migration review details could not be loaded.';

  @override
  String get notificationsDefinitionsRegisteredApplications =>
      'Registered applications';

  @override
  String get notificationsDefinitionsRegisteredApplicationsDescription =>
      'Manage which apps\' notifications Waterfly processes. Open an app to configure its extractors, rules, and actions.';

  @override
  String get notificationsDefinitionsUnknownApplication =>
      'Unknown application';

  @override
  String get notificationsDefinitionsSaveFailure =>
      'The application registration could not be saved.';

  @override
  String get notificationsAlertsTitle => 'Notification alerts';

  @override
  String get notificationsAlertsDescription =>
      'Review notification processing issues that may require attention. Alerts are grouped by application, and repeated occurrences are combined.';

  @override
  String get notificationsAlertsDismissAll => 'Dismiss all';

  @override
  String get notificationsAlertsLoadFailure =>
      'Notification alerts could not be loaded.';

  @override
  String get notificationsAlertsApplicationNamesLoadFailure =>
      'Application names could not be loaded. Package IDs are shown instead.';

  @override
  String get notificationsAlertsEmpty =>
      'No notification alerts need your attention.';

  @override
  String get notificationsAlertsEmptyTitle => 'All clear';

  @override
  String get notificationsHealthActiveTitle =>
      'Notification processing is paused';

  @override
  String notificationsHealthActiveDescription(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Waterfly could not load your notification setup. $count notifications may have been skipped.',
      one:
          'Waterfly could not load your notification setup. One notification may have been skipped.',
    );
    return '$_temp0';
  }

  @override
  String get notificationsHealthRecoveredTitle =>
      'Notification processing recovered';

  @override
  String notificationsHealthRecoveredDescription(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Processing is working again, but $count notifications may have been skipped.',
      one:
          'Processing is working again, but one notification may have been skipped.',
    );
    return '$_temp0';
  }

  @override
  String get notificationsHealthRetry => 'Retry';

  @override
  String get notificationsHealthReviewSetup => 'Review setup';

  @override
  String get notificationsHealthDismiss => 'Dismiss';

  @override
  String get notificationsHealthRetryFailure =>
      'Notification processing is still unavailable.';

  @override
  String get notificationsHealthDismissFailure =>
      'The recovered processing notice could not be dismissed.';

  @override
  String get notificationsHealthStatusLoadFailure =>
      'Notification processing status could not be loaded.';

  @override
  String get notificationsAlertsDismissFailure =>
      'The alert could not be dismissed.';

  @override
  String get notificationsAlertsDismissed => 'Alert dismissed.';

  @override
  String get notificationsAlertsUndo => 'Undo';

  @override
  String get notificationsAlertsDismissAllTitle => 'Dismiss all alerts?';

  @override
  String notificationsAlertsDismissAllDescription(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alerts will be dismissed.',
      one: '1 alert will be dismissed.',
      zero: 'No alerts will be dismissed.',
    );
    return '$_temp0';
  }

  @override
  String notificationsAlertsDismissedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alerts dismissed.',
      one: '1 alert dismissed.',
      zero: 'No alerts dismissed.',
    );
    return '$_temp0';
  }

  @override
  String notificationsAlertsPartiallyDismissed(int dismissed, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      dismissed,
      locale: localeName,
      other: '$dismissed of $total alerts dismissed.',
      one: '1 of $total alerts dismissed.',
      zero: 'No alerts dismissed.',
    );
    return '$_temp0';
  }

  @override
  String notificationsAlertsPartiallyRestored(int restored, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      restored,
      locale: localeName,
      other: '$restored of $total alerts restored.',
      one: '1 of $total alerts restored.',
      zero: 'No alerts restored.',
    );
    return '$_temp0';
  }

  @override
  String get notificationsAlertsRestoreFailure =>
      'The alert could not be restored.';

  @override
  String get notificationsAlertsRuleUnavailable =>
      'The rule is no longer available.';

  @override
  String get notificationsAlertsOpenRuleFailure =>
      'The rule could not be opened.';

  @override
  String get notificationsAlertsSetupUnavailable =>
      'The notification setup is no longer available.';

  @override
  String get notificationsAlertsOpenSetupFailure =>
      'The notification setup could not be opened.';

  @override
  String get notificationsAlertsRuleSaveFailure =>
      'The rule changes could not be saved.';

  @override
  String notificationsAlertsApplicationDetail(String name) {
    return 'App: $name';
  }

  @override
  String notificationsAlertsPackageDetail(String packageId) {
    return 'Package: $packageId';
  }

  @override
  String notificationsAlertsRuleDetail(String name) {
    return 'Rule: $name';
  }

  @override
  String notificationsAlertsActionDetail(String name) {
    return 'Action: $name';
  }

  @override
  String get notificationsAlertsDismiss => 'Dismiss';

  @override
  String get notificationsAlertsOpenRule => 'Open rule';

  @override
  String get notificationsAlertsOpenSetup => 'Open setup';

  @override
  String notificationsAlertsOccurrenceCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count occurrences',
      one: '1 occurrence',
      zero: 'No occurrences',
    );
    return '$_temp0';
  }

  @override
  String notificationsAlertsIssueCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count issues',
      one: '1 issue',
      zero: 'No issues',
    );
    return '$_temp0';
  }

  @override
  String notificationsAlertsMoreIssues(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count more issues',
      one: '1 more issue',
    );
    return '$_temp0';
  }

  @override
  String get notificationsAlertsDismissIssue => 'Dismiss issue';

  @override
  String get notificationsAlertsDismissGroup => 'Dismiss all issues';

  @override
  String get notificationsAlertsKindMigrationFailed => 'Migration failed';

  @override
  String get notificationsAlertsKindMigrationNeedsReview =>
      'Migration needs review';

  @override
  String get notificationsAlertsKindDefinitionInvalid => 'Definition invalid';

  @override
  String get notificationsAlertsKindEvaluationFailed =>
      'Rule evaluation failed';

  @override
  String get notificationsAlertsKindActionFailed => 'Action failed';

  @override
  String get notificationsMigrationAutomaticPausedTitle =>
      'Automatic creation paused';

  @override
  String get notificationsMigrationAutomaticPausedMessage =>
      'Transactions will use Prompt mode until you review the imported setup.';

  @override
  String get notificationsMigrationMissingAccountTitle =>
      'Account required for automatic creation';

  @override
  String get notificationsMigrationMissingAccountMessage =>
      'Choose an account before enabling automatic transaction creation.';

  @override
  String get notificationsMigrationMissingApplicationNameTitle =>
      'Application name unavailable';

  @override
  String get notificationsMigrationMissingApplicationNameMessage =>
      'Waterfly could not identify the application for this imported setup. Open it and choose the installed application that should use this configuration.';

  @override
  String get notificationsMigrationMissingSettingsTitle =>
      'Previous settings unavailable';

  @override
  String get notificationsMigrationMissingSettingsMessage =>
      'No saved configuration was found for this application. Create a new setup manually.';

  @override
  String get notificationsMigrationInvalidRegexTitle =>
      'Imported expression is invalid';

  @override
  String get notificationsMigrationInvalidRegexMessage =>
      'Update or replace the expression before using this setup.';

  @override
  String get notificationsMigrationRegexMismatchTitle =>
      'Expression does not match the sample';

  @override
  String get notificationsMigrationRegexMismatchMessage =>
      'Update the expression or select another sample notification.';

  @override
  String get notificationsMigrationAmbiguousAmountTitle =>
      'Choose the transaction amount';

  @override
  String get notificationsMigrationAmbiguousAmountMessage =>
      'The sample contains more than one monetary value. Select the value that represents the transaction amount.';

  @override
  String get notificationsMigrationAmountNotFoundTitle =>
      'Transaction amount not found';

  @override
  String get notificationsMigrationAmountNotFoundMessage =>
      'Select or configure an extractor for the transaction amount.';

  @override
  String get notificationsMigrationSampleMissingTitle =>
      'Sample notification required';

  @override
  String get notificationsMigrationSampleMissingMessage =>
      'Capture or enter a sample notification to finish this setup.';

  @override
  String get notificationsMigrationCurrencyUnresolvedTitle =>
      'Choose the transaction currency';

  @override
  String get notificationsMigrationCurrencyUnresolvedMessage =>
      'The sample currency could not be matched uniquely. Select the intended Firefly currency.';

  @override
  String get notificationsMigrationConversionFailedTitle =>
      'Previous settings could not be imported';

  @override
  String get notificationsMigrationConversionFailedMessage =>
      'Complete this notification setup manually.';

  @override
  String get notificationsHistoryTitle => 'Recent notifications';

  @override
  String get notificationsHistoryDescription =>
      'Review captured notifications and their processing results. Matched rules and actions reflect what was configured when each notification was processed.';

  @override
  String get notificationsHistoryLoadFailure =>
      'Recent notifications could not be loaded.';

  @override
  String get notificationsHistoryEmpty =>
      'No notifications have been recorded yet.';

  @override
  String get notificationsHistoryEmptyTitle => 'No recent notifications';

  @override
  String get notificationsHistoryEmptyDescription =>
      'Notifications received by Waterfly will appear here.';

  @override
  String get notificationsHistoryCreateRule => 'Create rule';

  @override
  String get notificationsHistoryNoMatchingRuleTitle => 'No matching rule';

  @override
  String get notificationsHistoryNoMatchingRuleMessage =>
      'Create a rule so similar notifications can be processed automatically.';

  @override
  String get notificationsHistoryProcessingFailureTitle =>
      'Could not process notification';

  @override
  String get notificationsHistorySharedActionsTitle =>
      'Transaction fields matched';

  @override
  String get notificationsHistorySharedActionsMessage =>
      'Shared actions can create a transaction from this notification.';

  @override
  String get notificationsHistoryMatchingRuleLabel => 'Matched rule';

  @override
  String get notificationsHistoryMatchingConditionalActionsLabel =>
      'Matched actions';

  @override
  String get notificationsHistoryCreateTransaction => 'Create transaction';

  @override
  String get notificationsHistoryTransactionCreatedTitle =>
      'Transaction created automatically';

  @override
  String get notificationsHistoryTransactionCreatedByUserTitle =>
      'Transaction created from notification';

  @override
  String get notificationsHistoryTransactionCreated => 'Transaction created';

  @override
  String get notificationsHistoryViewTransaction => 'View transaction';

  @override
  String get notificationsHistoryOpenTransactionFailure =>
      'The created transaction could not be opened. It may have been deleted.';

  @override
  String notificationsTransactionAccountUnavailable(String account) {
    return 'The configured account \"$account\" is no longer available. Select an account before saving.';
  }

  @override
  String get notificationsHistoryEditRule => 'Edit rule';

  @override
  String get notificationsHistoryGoToDefinition => 'Go to definition';

  @override
  String get notificationsHistoryOpenDefinitionFailure =>
      'The notification definition could not be opened.';

  @override
  String get notificationsHistoryDefinitionUnavailable =>
      'The notification definition is no longer available.';

  @override
  String get notificationsHistoryActions => 'Actions';

  @override
  String get notificationsHistoryRemoveFromHistory =>
      'Remove from recent history';

  @override
  String get notificationsHistoryRemoveTitle =>
      'Remove notification from history?';

  @override
  String get notificationsHistoryRemoveConfirm =>
      'This removes the notification record from Waterfly. Any Firefly transaction created from it will not be deleted.';

  @override
  String get notificationsHistoryRemoved =>
      'Notification removed from recent history.';

  @override
  String get notificationsHistoryUndo => 'Undo';

  @override
  String get notificationsHistoryRestoreFailure =>
      'The notification could not be restored to recent history.';

  @override
  String get notificationsHistoryRemoveFailure =>
      'The notification could not be removed from recent history.';

  @override
  String get notificationsHistoryRedactedTitle => 'Notification details hidden';

  @override
  String get notificationsHistoryRedactedBody =>
      'Only delivery metadata was stored for this notification.';

  @override
  String get notificationsHistoryTransactionDetailsHidden =>
      'Transaction details hidden';

  @override
  String get notificationsTransactionSummary => 'Transaction summary';

  @override
  String get notificationsTransactionAccounts => 'Accounts';

  @override
  String get notificationsTransactionClassification => 'Classification';

  @override
  String get notificationsTransactionAdditionalDetails => 'Additional details';

  @override
  String get notificationsHistoryRedactedFailureMessage =>
      'Processing failed. Open Alerts for diagnostic details.';

  @override
  String get notificationsHistoryViewAlert => 'View alert';

  @override
  String get notificationsHistoryViewAlerts => 'View alerts';

  @override
  String get notificationsMenuOptions => 'Notification options';

  @override
  String get notificationsMenuRuleSaveFailure => 'The rule could not be saved.';

  @override
  String get notificationsMenuAlerts => 'Alerts';

  @override
  String get notificationsProcessingSettingsTitle =>
      'Notification processing settings';

  @override
  String get notificationsProcessingSettingsLoadFailure =>
      'Notification processing settings could not be loaded.';

  @override
  String get notificationsProcessingSettingsSaveFailure =>
      'Notification processing settings could not be saved.';

  @override
  String get notificationsProcessingConfigurationTitle => 'Backup and restore';

  @override
  String get notificationsProcessingConfigurationDescription =>
      'Export or restore your notification setup and processing preferences.';

  @override
  String get notificationsProcessingCreateBackup => 'Create backup';

  @override
  String get notificationsProcessingCreateBackupDescription =>
      'Export your notification setup and processing preferences with obfuscated data. Recent history and alerts are not included.';

  @override
  String get notificationsProcessingCreateBackupDisabledDescription =>
      'Add at least one application before creating a backup.';

  @override
  String get notificationsProcessingRestoreBackup => 'Restore backup';

  @override
  String get notificationsProcessingRestoreBackupDescription =>
      'Replace your current notification setup and processing preferences with a backup.';

  @override
  String get notificationsProcessingStoredDataTitle =>
      'History and stored data';

  @override
  String get notificationsProcessingStoredDataDescription =>
      'Choose what recent history keeps and how long stored records remain on this device.';

  @override
  String get notificationsProcessingHistoryStorageMode =>
      'Recent notification history';

  @override
  String get notificationsProcessingHistoryStorageModeDescription =>
      'Choose whether recent history keeps full notification content, metadata only, or nothing.';

  @override
  String get notificationsProcessingHistoryStorageDisabled => 'Disabled';

  @override
  String get notificationsProcessingHistoryStorageMetadata => 'Metadata only';

  @override
  String get notificationsProcessingHistoryStorageFull => 'Full';

  @override
  String get notificationsProcessingHistoryRetention => 'History retention';

  @override
  String get notificationsProcessingHistoryRetentionDescription =>
      'Automatically remove recent notification records older than this period.';

  @override
  String get notificationsProcessingRetentionSevenDays => '7 days';

  @override
  String get notificationsProcessingRetentionThirtyDays => '30 days';

  @override
  String get notificationsProcessingRetentionNinetyDays => '90 days';

  @override
  String get notificationsProcessingRetentionForever => 'Forever';

  @override
  String get notificationsProcessingClearHistory => 'Clear recent history';

  @override
  String get notificationsProcessingClearHistoryDescription =>
      'Delete all recent notification records.';

  @override
  String get notificationsProcessingClearAlerts => 'Clear processing alerts';

  @override
  String get notificationsProcessingClearAlertsDescription =>
      'Delete all current processing alerts.';

  @override
  String get notificationsProcessingClearStoredDataTitle =>
      'Clear history and alerts';

  @override
  String get notificationsProcessingOffboardingTitle =>
      'Notification access and setup';

  @override
  String get notificationsProcessingOffboardingDescription =>
      'Manage Waterfly\'s Android notification access or remove the saved notification setup.';

  @override
  String get notificationsProcessingOpenAccessSettings =>
      'Open notification access settings';

  @override
  String get notificationsProcessingOpenAccessSettingsDescription =>
      'Review or revoke Waterfly\'s notification access in Android settings.';

  @override
  String get notificationsProcessingRemoveSetup => 'Remove notification setup';

  @override
  String get notificationsProcessingDeleteRegistrations =>
      'Delete all application registrations';

  @override
  String get notificationsProcessingDeleteRegistrationsDescription =>
      'Delete every registered application and its rules while keeping notification access and processing preferences.';

  @override
  String notificationsProcessingDeleteRegistrationsTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Delete $count application registrations?',
      one: 'Delete 1 application registration?',
    );
    return '$_temp0';
  }

  @override
  String get notificationsProcessingDeleteRegistrationsConfirm =>
      'Their rules, recent history, and alerts will also be deleted. Processing preferences and notification access will not change.';

  @override
  String notificationsProcessingRegistrationsDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count application registrations deleted.',
      one: '1 application registration deleted.',
    );
    return '$_temp0';
  }

  @override
  String notificationsProcessingRegistrationsDeletedCleanupFailure(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count application registrations deleted, but their related history or alerts could not be completely cleared.',
      one:
          '1 application registration deleted, but its related history or alerts could not be completely cleared.',
    );
    return '$_temp0';
  }

  @override
  String get notificationsProcessingRemoveSetupDescription =>
      'Delete saved apps, rules, recent history, and alerts, then reset processing preferences.';

  @override
  String get notificationsProcessingRemoveSetupGroupTitle =>
      'Remove saved setup';

  @override
  String get notificationsProcessingSaveFileTitle =>
      'Save notification processing file';

  @override
  String get notificationsProcessingExportCancelled => 'Export cancelled.';

  @override
  String get notificationsProcessingBackupComplete =>
      'Notification processing backup created.';

  @override
  String get notificationsProcessingRestoreBackupTitle =>
      'Restore notification processing backup?';

  @override
  String notificationsProcessingRestoreBackupConfirm(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'This backup contains $count definitions. It will replace your current setup and processing settings.',
      one:
          'This backup contains 1 definition. It will replace your current setup and processing settings.',
      zero:
          'This backup contains no definitions. It will replace your current setup and processing settings.',
    );
    return '$_temp0';
  }

  @override
  String get notificationsProcessingRestoreBackupComplete =>
      'Notification processing backup restored.';

  @override
  String get notificationsProcessingClearHistoryTitle =>
      'Clear recent notification history?';

  @override
  String get notificationsProcessingClearHistoryConfirm =>
      'All stored recent notification records will be deleted.';

  @override
  String get notificationsProcessingHistoryCleared =>
      'Recent notification history cleared.';

  @override
  String get notificationsProcessingClearAlertsTitle =>
      'Clear notification alerts?';

  @override
  String get notificationsProcessingClearAlertsConfirm =>
      'All processing alerts will be deleted.';

  @override
  String get notificationsProcessingAlertsCleared =>
      'Notification alerts cleared.';

  @override
  String get notificationsProcessingRemoveSetupTitle =>
      'Remove notification setup?';

  @override
  String get notificationsProcessingRemoveSetupConfirm =>
      'Definitions, recent history, alerts, and processing settings will be removed. Android settings will open next so you can turn off Waterfly\'s notification access.';

  @override
  String get notificationsProcessingRemoveSetupComplete =>
      'Notification setup removed. Turn off Waterfly in Android notification access settings to stop listener access.';

  @override
  String get notificationsProcessingRemoveSetupCompleteNoSettings =>
      'Notification setup removed. Open Android notification access settings to turn off listener access.';

  @override
  String get notificationsProcessingAccessSettingsOpened =>
      'Notification access settings opened.';

  @override
  String get notificationsProcessingAccessSettingsOpenFailure =>
      'Notification access settings could not be opened.';

  @override
  String get notificationsProcessingActionFailure =>
      'The notification processing action could not be completed.';

  @override
  String get notificationsExtractorActions => 'Extractor actions';

  @override
  String get notificationsEditDetails => 'Edit details';

  @override
  String get notificationsDescriptionOptional => 'Description (optional)';

  @override
  String get notificationsExtractorDelete => 'Delete';

  @override
  String get notificationsExtractorInvalidPattern => 'Invalid pattern';

  @override
  String get notificationsExtractorInvalidPatternMessage =>
      'Fix the regular expression before this extractor can provide values.';

  @override
  String get notificationsExtractorInputTooLong => 'Sample is too long';

  @override
  String notificationsExtractorInputTooLongMessage(int maximumLength) {
    return 'Regular expression extractors can safely evaluate up to $maximumLength characters. Use a shorter sample or simplify the source notification.';
  }

  @override
  String get notificationsExtractorPerformanceWarning => 'Pattern may be slow';

  @override
  String get notificationsExtractorPerformanceWarningMessage =>
      'Nested or repeated broad matching can delay notification processing. Test this pattern with representative notifications before enabling automation.';

  @override
  String get notificationsExtractorNoSampleMatch => 'No sample match';

  @override
  String get notificationsExtractorNoSampleMatchMessage =>
      'This extractor does not find a value in the current sample notification.';

  @override
  String get notificationsClearText => 'Clear text';

  @override
  String get notificationsExtractorSampleNotification => 'Sample notification';

  @override
  String get notificationsExtractorSampleDescription =>
      'Fine-tune the sample for this extractor while keeping the definition sample available to other extractors and rules.';

  @override
  String get notificationsExtractorDeleteTitle => 'Delete extractor?';

  @override
  String notificationsExtractorDeleteDescription(String name) {
    return '\"$name\" will be removed. Rules using its captured values may need updating.';
  }

  @override
  String get notificationsExtractorRenameTitle => 'Rename extractor';

  @override
  String get notificationsExtractorRenameDescription =>
      'Choose a name that identifies this extractor in rules.';

  @override
  String get notificationsExtractorEditDetailsTitle => 'Edit extractor details';

  @override
  String get notificationsExtractorEditDetailsDescription =>
      'Use a clear name and optionally describe the value this extractor provides.';

  @override
  String get notificationsExtractorName => 'Extractor name';

  @override
  String get notificationsExtractorSave => 'Save';

  @override
  String get notificationsBack => 'Back';

  @override
  String get notificationsAdd => 'Add';

  @override
  String get notificationsPredefined => 'Predefined';

  @override
  String get notificationsDefinitionAddExtractor => 'Add extractor';

  @override
  String get notificationsDefinitionSelectPredefinedExtractor =>
      'Select predefined extractor';

  @override
  String get notificationsDefinitionNameCustomExtractor =>
      'Name regular expression extractor';

  @override
  String get notificationsDefinitionChooseExtractorType =>
      'Choose a built-in extractor or create one with a regular expression.';

  @override
  String get notificationsDefinitionSelectNotificationField =>
      'Select the notification field to extract.';

  @override
  String get notificationsDefinitionNameExtractorDescription =>
      'Name this extractor before entering its regular expression.';

  @override
  String get notificationsDefinitionPredefinedExtractorDescription =>
      'Use a built-in value such as the notification title, message, or received time.';

  @override
  String get notificationsDefinitionRegularExpressionExtractor =>
      'Regular expression';

  @override
  String get notificationsDefinitionCustomExtractorDescription =>
      'Capture values from the notification with a regular expression.';

  @override
  String get notificationsDefinitionAlreadyAdded => 'Already added.';

  @override
  String get notificationsDefinitionCaptureNotificationTitle =>
      'Captures the notification title.';

  @override
  String get notificationsDefinitionCaptureNotificationMessage =>
      'Captures the notification message.';

  @override
  String get notificationsDefinitionCaptureNotificationDate =>
      'Captures the time the notification was received.';

  @override
  String get notificationsDefinitionCaptureAmount =>
      'Captures an amount in the message.';

  @override
  String get notificationsDefinitionCaptureCurrency =>
      'Captures currency before or after an amount.';

  @override
  String get notificationsDefinitionAddRule => 'Add rule';

  @override
  String get notificationsDefinitionNameRuleDescription =>
      'Name this rule before defining when it runs and which fields it sets.';

  @override
  String get notificationsRuleName => 'Rule name';

  @override
  String get notificationsDefinitionOptionsHeading => 'Options';

  @override
  String get notificationsDefinitionOptionsDescription =>
      'Choose whether matching notifications create transactions automatically or wait for review.';

  @override
  String get notificationsDefinitionCreateAutomatically =>
      'Create transaction automatically';

  @override
  String get notificationsDefinitionCreateAutomaticallyEnabled =>
      'Create a transaction automatically for each matching notification.';

  @override
  String get notificationsDefinitionCreateAutomaticallyDisabled =>
      'Review each matching transaction before it is created.';

  @override
  String get notificationsDefinitionAutomaticRequirementTitle => 'title';

  @override
  String get notificationsDefinitionAutomaticRequirementAmount =>
      'positive amount';

  @override
  String get notificationsDefinitionAutomaticRequirementAccount =>
      'source or destination account';

  @override
  String notificationsDefinitionAutomaticIncomplete(String requirements) {
    return 'Automatic processing is disabled until shared actions provide: $requirements.';
  }

  @override
  String get notificationsDefinitionAutomaticIncompleteTitle =>
      'Automatic creation is incomplete';

  @override
  String get notificationsDefinitionSampleRequired =>
      'Sample notification required';

  @override
  String get notificationsDefinitionEditSample => 'Edit sample notification';

  @override
  String get notificationsDefinitionExtractorsHeading => 'Extractors';

  @override
  String get notificationsDefinitionExtractorsDescription =>
      'Extractors turn notification details, such as title, message, or received time, into values rules can use.';

  @override
  String get notificationsDefinitionNoExtractors => 'No extractors defined';

  @override
  String notificationsDefinitionMatchCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count matches',
      one: '1 match',
      zero: 'No matches',
    );
    return '$_temp0';
  }

  @override
  String get notificationsDefinitionRulesHeading => 'Rules';

  @override
  String get notificationsDefinitionRulesOrderDescription =>
      'Rules are checked from top to bottom. The first matching rule handles the notification.';

  @override
  String get notificationsDefinitionRuleShadowsFollowing =>
      'Always applies · Rules below cannot be reached';

  @override
  String get notificationsDefinitionSharedActionsTitle => 'Shared actions';

  @override
  String get notificationsDefinitionSharedActionsDescription =>
      'Shared actions run before each matching rule. Rule actions can override their values.';

  @override
  String get notificationsDefinitionSharedActionsNeedSetupMessage =>
      'Add a shared transaction field here, or go back and create a rule, before this application can process notifications.';

  @override
  String get notificationsDefinitionSharedTransactionFields =>
      'Shared transaction fields';

  @override
  String get notificationsDefinitionNoSharedFields =>
      'No shared fields configured';

  @override
  String get notificationsDefinitionSetTransactionFields =>
      'Set transaction fields';

  @override
  String get notificationsDefinitionNoTransactionFields =>
      'No transaction fields configured';

  @override
  String get notificationsDefinitionBasicActionsDescription =>
      'Set transaction fields for every matching notification.';

  @override
  String get notificationsDefinitionBasicActionsNeedSetupMessage =>
      'Add at least one transaction field before this application can process notifications.';

  @override
  String get notificationsDefinitionPreviewSharedActions => 'Shared actions';

  @override
  String get notificationsDefinitionResolvedTransaction =>
      'Resolved transaction fields';

  @override
  String get notificationsDefinitionResolvedTransactionDescription =>
      'Shows the transaction created from shared actions, always-run actions, and matching conditional actions. Later values override earlier ones.';

  @override
  String get notificationsConditionalActionResolvedTransactionDescription =>
      'Shows the transaction fields this conditional action resolves from the current sample.';

  @override
  String get notificationsDefinitionNoResolvedTransactionFields =>
      'No transaction fields resolve from this rule.';

  @override
  String get notificationsDefinitionPreviewThisRule => 'This rule';

  @override
  String get notificationsDefinitionPreviewMultipleRules => 'Multiple rules';

  @override
  String notificationsDefinitionPreviewSetBy(String rule) {
    return 'Set by: $rule';
  }

  @override
  String notificationsDefinitionPreviewOverrides(String sources) {
    return 'Overrides: $sources';
  }

  @override
  String get notificationsDefinitionNoRules => 'No rules defined.';

  @override
  String notificationsDefinitionConditionActionCount(
    int conditions,
    int actions,
  ) {
    String _temp0 = intl.Intl.pluralLogic(
      conditions,
      locale: localeName,
      other: '$conditions conditions',
      one: '1 condition',
      zero: 'No conditions',
    );
    String _temp1 = intl.Intl.pluralLogic(
      actions,
      locale: localeName,
      other: '$actions actions',
      one: '1 action',
      zero: 'No actions',
    );
    return '$_temp0 · $_temp1';
  }

  @override
  String notificationsDefinitionRuleConditionActionGroupCount(
    int conditions,
    int actions,
    int groups,
  ) {
    String _temp0 = intl.Intl.pluralLogic(
      conditions,
      locale: localeName,
      other: '$conditions conditions',
      one: '1 condition',
      zero: 'No conditions',
    );
    String _temp1 = intl.Intl.pluralLogic(
      actions,
      locale: localeName,
      other: '$actions always-run actions',
      one: '1 always-run action',
      zero: 'No always-run actions',
    );
    String _temp2 = intl.Intl.pluralLogic(
      groups,
      locale: localeName,
      other: '$groups conditional actions',
      one: '1 conditional action',
    );
    return '$_temp0 · $_temp1 · $_temp2';
  }

  @override
  String get notificationsDefinitionSetupHeading =>
      'Set up notification processing';

  @override
  String get notificationsDefinitionSetupDescription =>
      'Choose how Waterfly reads this app\'s notifications and turns them into transactions.';

  @override
  String get notificationsDefinitionSetupSampleRequired =>
      'Add a sample notification before choosing a setup option.';

  @override
  String get notificationsDefinitionBasic => 'Basic';

  @override
  String get notificationsDefinitionBasicDescription =>
      'Use built-in extractors and standard transaction mappings. Review uncertain values before creating a transaction.';

  @override
  String get notificationsDefinitionAdvanced => 'Advanced';

  @override
  String get notificationsDefinitionAdvancedDescription =>
      'Create your own extractors and rules for full control over how notifications become transactions.';

  @override
  String get notificationsExtractorUsesTitle =>
      'Uses the notification title supplied by the source app.';

  @override
  String get notificationsExtractorUsesMessage =>
      'Uses the notification message supplied by the source app.';

  @override
  String get notificationsExtractorUsesReceivedTime =>
      'Uses the time Android recorded when the notification arrived.';

  @override
  String get notificationsExtractorNotificationTitle => 'Notification title';

  @override
  String get notificationsExtractorNotificationMessage =>
      'Notification message';

  @override
  String get notificationsExtractorDescription => 'Description';

  @override
  String get notificationsExtractorMatches => 'Matches';

  @override
  String get notificationsExtractorPropertyMatchesDescription =>
      'Captured values are highlighted in the matching sample field.';

  @override
  String get notificationsExtractorPattern => 'Pattern';

  @override
  String get notificationsExtractorPatternEditableDescription =>
      'Edit the regular expression and preview matches in the sample notification.';

  @override
  String get notificationsExtractorPatternReadOnlyDescription =>
      'This built-in pattern is managed by Basic mode and cannot be edited here.';

  @override
  String get notificationsExtractorRegularExpression => 'Regular expression';

  @override
  String get notificationsExtractorPasteRegularExpression =>
      'Paste regular expression';

  @override
  String get notificationsExtractorPatternMatchesDescription =>
      'Regular expression matches are highlighted in the sample notification.';

  @override
  String get notificationsExtractorMatch => 'Match';

  @override
  String notificationsExtractorMatchNumber(int count) {
    return 'Match $count';
  }

  @override
  String get notificationsValueTypeText => 'Text';

  @override
  String get notificationsValueTypeNumber => 'Number';

  @override
  String get notificationsValueTypeCurrency => 'Currency';

  @override
  String get notificationsValueTypeDate => 'Date';

  @override
  String get notificationsValueTypeTime => 'Time';

  @override
  String get notificationsValueTypeDateTime => 'Date and time';

  @override
  String get notificationsCaptureEmpty =>
      'No matching extractor captures are available.';

  @override
  String notificationsCaptureGroupCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count captured groups',
      one: '1 captured group',
      zero: 'No captured groups',
    );
    return '$_temp0';
  }

  @override
  String notificationsCaptureExtractorMatch(String name, int count) {
    return '$name > Match $count';
  }

  @override
  String get notificationsCaptureGroupPrefix => 'Group \"';

  @override
  String notificationsCaptureMatchGroupPrefix(int count) {
    return 'Match $count - Group \"';
  }

  @override
  String get notificationsResolvedValuePrefix => 'Resolved value: \"';

  @override
  String get notificationsRuleRenameTitle => 'Rename rule';

  @override
  String get notificationsRuleRenameDescription =>
      'Choose a name that describes when this rule applies.';

  @override
  String get notificationsRuleEditDetailsTitle => 'Edit rule details';

  @override
  String get notificationsRuleEditDetailsDescription =>
      'Use a clear name and optionally describe when this rule should be used.';

  @override
  String get notificationsUnresolved => 'unresolved';

  @override
  String get notificationsResolvedValueLabel => 'Resolved value: ';

  @override
  String get notificationsLocalizedValueLabel => 'Localized value: ';

  @override
  String get notificationsRuleExtractor => 'Extractor ';

  @override
  String get notificationsRuleExtractorLowercase => 'extractor ';

  @override
  String get notificationsRuleValueSuffix => ' value';

  @override
  String get notificationsConditionExists => 'exists';

  @override
  String get notificationsConditionEquals => 'equals';

  @override
  String get notificationsConditionContains => 'contains';

  @override
  String get notificationsConditionGreaterThan => 'is greater than';

  @override
  String get notificationsConditionGreaterThanLabel => 'Greater than';

  @override
  String get notificationsConditionAtLeast => 'is at least';

  @override
  String get notificationsConditionAtLeastLabel => 'At least';

  @override
  String get notificationsConditionLessThan => 'is less than';

  @override
  String get notificationsConditionLessThanLabel => 'Less than';

  @override
  String get notificationsConditionAtMost => 'is at most';

  @override
  String get notificationsConditionAtMostLabel => 'At most';

  @override
  String get notificationsRuleOptionalFieldPrefix => 'Optional field ';

  @override
  String get notificationsRuleSetFieldPrefix => 'Set field ';

  @override
  String get notificationsRuleFromExtractorPrefix => ' from extractor ';

  @override
  String get notificationsRuleToPrefix => ' to ';

  @override
  String get notificationsRuleLiteralValue => 'literal value';

  @override
  String get notificationsRuleFireflySuppliedValue => 'Firefly supplied value';

  @override
  String get notificationsSampleAddTitle => 'Add sample notification';

  @override
  String get notificationsSampleChangeTitle => 'Change sample notification';

  @override
  String get notificationsSampleDescription =>
      'Enter a representative notification title, message, and received time to preview your extractors and rules.';

  @override
  String get notificationsSampleExtractorDescription =>
      'Enter a notification title, message, and received time to test this extractor. This sample applies only to this extractor.';

  @override
  String get notificationsSampleRuleDescription =>
      'Enter a notification title, message, and received time to test this rule. This sample applies to the rule and its conditional actions.';

  @override
  String get notificationsSampleConditionalActionDescription =>
      'Enter a notification title, message, and received time to test this conditional action. This sample applies only to this conditional action.';

  @override
  String get notificationsRuleTestSampleDescription =>
      'Use this notification only to test this rule. It does not change the definition\'s sample notification.';

  @override
  String get notificationsSampleSource => 'Notification source';

  @override
  String get notificationsContinue => 'Continue';

  @override
  String get notificationsApply => 'Apply';

  @override
  String get notificationsApplicationsChooseDescription =>
      'Choose the app whose notifications you want Waterfly to process.';

  @override
  String get notificationsApplicationsLikelySendersDescription =>
      'Suggested apps are shown first. Apps already configured are hidden.';

  @override
  String get notificationsApplicationsSuggestedTitle => 'Suggested apps';

  @override
  String get notificationsApplicationsAllTitle => 'All installed apps';

  @override
  String get notificationsApplicationsSearch => 'Search applications';

  @override
  String get notificationsApplicationsLoadFailure =>
      'Applications could not be loaded.';

  @override
  String get notificationsApplicationsNoSearchMatches =>
      'No applications match your search.';

  @override
  String get notificationsApplicationsSuggestedRegistered =>
      'All suggested applications are already registered.';

  @override
  String get notificationsApplicationsAllRegistered =>
      'All installed applications are already registered.';

  @override
  String get notificationsApplicationsNoneSuggested =>
      'No suggested applications are available. Try viewing all installed apps.';

  @override
  String get notificationsApplicationsNoneInstalled =>
      'No installed applications are available.';

  @override
  String get notificationsFieldTitle => 'Title';

  @override
  String get notificationsFieldAmount => 'Amount';

  @override
  String get notificationsFieldDate => 'Date';

  @override
  String get notificationsFieldTime => 'Time';

  @override
  String get notificationsFieldSourceAccount => 'Source account';

  @override
  String get notificationsFieldDestinationAccount => 'Destination account';

  @override
  String get notificationsFieldCategory => 'Category';

  @override
  String get notificationsFieldTags => 'Tags';

  @override
  String get notificationsFieldNotes => 'Notes';

  @override
  String get notificationsFieldSubscription => 'Subscription';

  @override
  String get notificationsFieldCurrency => 'Currency';

  @override
  String get notificationsFieldPiggyBank => 'Piggy bank';

  @override
  String get notificationsFieldInvalidAmount => 'Amount must be a number.';

  @override
  String get notificationsFieldInvalidDate => 'Date must be an ISO-8601 date.';

  @override
  String get notificationsFieldInvalidTime =>
      'Time must use HH:mm or HH:mm:ss.';

  @override
  String get notificationsActionSelectField => 'Add action';

  @override
  String notificationsActionSetField(String field) {
    return 'Set $field';
  }

  @override
  String get notificationsActionChooseField =>
      'Choose the transaction field this rule should set.';

  @override
  String get notificationsActionChooseSource =>
      'Choose the value source for this transaction field.';

  @override
  String get notificationsActionExtractorCapture => 'Extractor capture';

  @override
  String get notificationsActionExtractorCaptureDescription =>
      'Use a value captured by an extractor, selected by capture name or match position.';

  @override
  String get notificationsActionLiteralValue => 'Literal value';

  @override
  String get notificationsActionLiteralDescription =>
      'Enter a value to use for every matching notification.';

  @override
  String get notificationsActionBuildText => 'Build text';

  @override
  String get notificationsActionBuildTextDescription =>
      'Combine extractor captures and fixed text in order.';

  @override
  String get notificationsActionBuildTextEmpty =>
      'Add a part to start building the text.';

  @override
  String get notificationsActionBuildTextAddPart => 'Add part';

  @override
  String get notificationsActionBuildTextPreview => 'Preview';

  @override
  String get notificationsActionBuildTextParts => 'Parts';

  @override
  String get notificationsActionBuildTextUnresolved =>
      'Preview unavailable because a capture did not resolve.';

  @override
  String get notificationsActionBuildTextCapturePart => 'Extractor capture';

  @override
  String get notificationsActionBuildTextFixedPart => 'Fixed text';

  @override
  String get notificationsActionBuildTextFixedPrompt => 'Choose fixed text';

  @override
  String get notificationsActionBuildTextCustom => 'Custom text';

  @override
  String get notificationsActionBuildTextSpace => 'Space';

  @override
  String get notificationsActionBuildTextLineBreak => 'Line break';

  @override
  String get notificationsActionBuildTextBlankLine => 'Blank line';

  @override
  String get notificationsActionBuildTextDash => 'Dash';

  @override
  String get notificationsActionBuildTextColon => 'Colon';

  @override
  String get notificationsActionBuildTextMoveUp => 'Move up';

  @override
  String get notificationsActionBuildTextMoveDown => 'Move down';

  @override
  String get notificationsActionSelectFirefly => 'Select from Firefly';

  @override
  String get notificationsActionFireflyDescription =>
      'Choose a value from your existing Firefly data.';

  @override
  String get notificationsActionAlreadySet => 'Already set by this rule.';

  @override
  String get notificationsActionSearchFirefly => 'Search Firefly';

  @override
  String get notificationsTagsRuleDescription =>
      'Choose the tags added to the transaction when this rule runs.';

  @override
  String get notificationsActionTagsLoadFailure => 'Tags could not be loaded.';

  @override
  String get notificationsConditionChooseCategory =>
      'Choose the kind of condition to add.';

  @override
  String get notificationsConditionValueCategory => 'Value condition';

  @override
  String get notificationsConditionValueCategoryDescription =>
      'Check whether a value exists, contains text, or compares with another value.';

  @override
  String get notificationsConditionGroupCategory => 'Condition group';

  @override
  String get notificationsConditionGroupCategoryDescription =>
      'Combine multiple conditions or invert another condition.';

  @override
  String get notificationsConditionChooseValueKind =>
      'Choose how values should be evaluated.';

  @override
  String get notificationsConditionChooseGroupKind =>
      'Choose how nested conditions should be combined.';

  @override
  String notificationsConditionMaximumNestingDescription(int maximumDepth) {
    return 'The maximum of $maximumDepth nested condition levels has been reached. Choose an individual condition, or split complex logic across rules or conditional-action groups.';
  }

  @override
  String get notificationsConditionMergedGroupDescription =>
      'This group is supplied by its parent condition.';

  @override
  String get notificationsRuleFlattenedGroups =>
      'Merged nested condition groups.';

  @override
  String get notificationsConditionExtractorCapture => 'Extractor capture';

  @override
  String get notificationsConditionLiteralValue => 'Literal value';

  @override
  String get notificationsConditionUseCapture =>
      'Use a value captured from the notification.';

  @override
  String get notificationsConditionNoCaptures =>
      'No extractor captures are available for this sample.';

  @override
  String get notificationsConditionChangeValueType => 'Change value type';

  @override
  String get notificationsConditionDeletedExtractor => 'Deleted extractor';

  @override
  String get notificationsConditionNumberValue => 'Number value';

  @override
  String get notificationsConditionDateTimeValue => 'Date and time value';

  @override
  String get notificationsConditionDateValue => 'Date value';

  @override
  String get notificationsConditionTimeValue => 'Time value';

  @override
  String get notificationsConditionTextDescription => 'Enter fixed text.';

  @override
  String get notificationsConditionNumberDescription =>
      'Enter a numeric value.';

  @override
  String get notificationsConditionDateTimeDescription =>
      'Choose a date and time.';

  @override
  String get notificationsConditionDateDescription =>
      'Enter or choose an ISO date.';

  @override
  String get notificationsConditionTimeDescription => 'Enter or choose a time.';

  @override
  String get notificationsConditionAny => 'Any condition matches';

  @override
  String get notificationsConditionAnyDescription =>
      'Require at least one nested condition to match.';

  @override
  String get notificationsConditionAll => 'All conditions match';

  @override
  String get notificationsConditionAllDescription =>
      'Require every nested condition to match.';

  @override
  String get notificationsConditionNot => 'Condition does not match';

  @override
  String get notificationsConditionNotDescription =>
      'Invert a single nested condition.';

  @override
  String get notificationsConditionExistsLabel => 'Value exists';

  @override
  String get notificationsConditionExistsDescription =>
      'Require a value to be available.';

  @override
  String get notificationsConditionEqualsLabel => 'Equals value';

  @override
  String get notificationsConditionContainsLabel => 'Contains text';

  @override
  String get notificationsConditionComparisonDescription =>
      'Compare two numeric values.';

  @override
  String get notificationsConditionSelectNegated =>
      'Choose condition to negate';

  @override
  String get notificationsConditionEdit => 'Edit condition';

  @override
  String get notificationsConditionCompareDescription =>
      'Choose the value to compare with.';

  @override
  String get notificationsConditionValueDescription =>
      'Choose the value this condition evaluates.';

  @override
  String get notificationsConditionReview =>
      'Review the condition before applying it.';

  @override
  String get notificationsConditionChooseDateTime => 'Choose date and time';

  @override
  String get notificationsActionBack => 'Back';

  @override
  String get notificationsActionSave => 'Save';

  @override
  String get notificationsActionMatchCurrency => 'Match extracted currency';

  @override
  String get notificationsActionChooseCurrency =>
      'Choose the Firefly currency for the captured value.';

  @override
  String get notificationsActionSearchCurrencies => 'Search Firefly currencies';

  @override
  String get notificationsActionCurrenciesLoadFailure =>
      'Firefly currencies could not be loaded.';

  @override
  String get notificationsActionNoValue => 'no value';

  @override
  String notificationsActionExtractedCurrency(String value) {
    return 'Extracted value \"$value\". Select its matching Firefly currency.';
  }

  @override
  String get notificationsFieldTitleDescription =>
      'The transaction description shown in Firefly.';

  @override
  String get notificationsFieldAmountDescription =>
      'A numeric amount, such as 12.50.';

  @override
  String get notificationsFieldDateDescription =>
      'An ISO date in the form YYYY-MM-DD.';

  @override
  String get notificationsFieldTimeDescription =>
      'A time in the form HH:mm or HH:mm:ss.';

  @override
  String get notificationsFieldSourceAccountDescription =>
      'The account the money is sent from.';

  @override
  String get notificationsFieldDestinationAccountDescription =>
      'The account the money is sent to.';

  @override
  String get notificationsFieldCategoryDescription =>
      'A Firefly category for the transaction.';

  @override
  String get notificationsFieldTagsDescription => 'One or more Firefly tags.';

  @override
  String get notificationsFieldNotesDescription =>
      'Extra information attached to the transaction.';

  @override
  String get notificationsFieldSubscriptionDescription =>
      'A matching Firefly subscription.';

  @override
  String get notificationsFieldCurrencyDescription =>
      'The currency used for the transaction.';

  @override
  String get notificationsFieldPiggyBankDescription =>
      'A Firefly piggy bank to associate.';

  @override
  String get notificationsActionChooseDate => 'Choose date';

  @override
  String get notificationsActionChooseTime => 'Choose time';

  @override
  String get notificationsRuleConditionalGroupActionsDescription =>
      'Run when this group matches. These values override shared and always-run actions, and later groups can override them.';

  @override
  String get notificationsActionNoCurrencies =>
      'No matching Firefly currencies found.';
}
