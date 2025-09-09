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
  String get accountRoleAssetDefault => 'Alapértelmezett vagyon számla';

  @override
  String get accountRoleAssetSavings => 'Megtakarítási számla';

  @override
  String get accountRoleAssetShared => 'Megosztott vagyon számla';

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
  String get generalDefault => 'alapértelmezett';

  @override
  String get generalDestinationAccount => 'Destination Account';

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
  String get generalSourceAccount => 'Source Account';

  @override
  String get generalSpent => 'Elköltött';

  @override
  String get generalSum => 'Összesen';

  @override
  String get generalTarget => 'Cél';

  @override
  String get generalUnknown => 'Ismeretlen';

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
  String get homeMainChartTagsTitle => 'Tag Summary for current month';

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
  String get homeMainDialogSettingsTitle => 'Customize Dashboard';

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
  String homePiggyTarget(String amount) {
    return 'Célösszeg: $amount';
  }

  @override
  String get homeTabLabelBalance => 'Mérleg';

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
  String get homeTransactionsDialogFilterDateRange => 'Date Range';

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
  String get loginFormLabelAPIKey => 'Érvényes API kulcs';

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
  String get navigationMain => 'Főoldal';

  @override
  String get generalSettings => 'Settings';

  @override
  String get no => 'Nem';

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
  String get settingsLockscreenHelp =>
      'Hitelesítés szükséges az alkalmazás indításakor';

  @override
  String get settingsLockscreenInitial =>
      'A lezárási képernyő engedélyezéséhez hitelesítsen.';

  @override
  String get settingsNLAppAccount => 'Alapértelmezett Számla';

  @override
  String get settingsNLAppAccountDynamic => '<Dinamikus>';

  @override
  String get settingsNLAppAdd => 'Alkalmazás Hozzáadása';

  @override
  String get settingsNLAppAddHelp =>
      'Kattintson a figyelni kívánt alkalmazás hozzáadásához. Csak az erre jogosult alkalmazások jelennek meg a listában.';

  @override
  String get settingsNLAppAddInfo =>
      'Egy alkalmazás ezen listához adásához indítson olyan tranzakciókat amelyek telefonértesítéseket generálnak. Ha az alkalmazás továbbra sem jelenik meg, kérjük, jelentse az app@vogt.pw email címre írva.';

  @override
  String get settingsNLAutoAdd =>
      'Tranzakció létrehozása felhasználói beavatkozás nélkül';

  @override
  String get settingsNLDescription =>
      'Ez a szolgáltatás lehetővé teszi a tranzakció részleteinek lekérését a bejövő értesítésekből. Továbbá kiválaszthat egy alapértelmezett számlát, amelyhez a tranzakciót hozzá kívánja rendelni - amennyiben ez nincs beállítva, akkor a szolgáltatás az értesítés szövegéből kisérli meg annak kinyerését.';

  @override
  String get settingsNLEmptyNote => 'A \"Jegyzetek\" mező maradjon üres';

  @override
  String get settingsNLPermissionGrant => 'Koppintson az engedélyezéshez.';

  @override
  String get settingsNLPermissionNotGranted => 'Hozzáférés megtagadva.';

  @override
  String get settingsNLPermissionRemove => 'Eltávolítja a jogosultságot?';

  @override
  String get settingsNLPermissionRemoveHelp =>
      'A szolgáltatás letiltásához kattintson az alkalmazásra, majd távolítsa el az engedélyeket a következő képernyőn.';

  @override
  String get settingsNLPrefillTXTitle =>
      'A tranzakció leírásának előzetes kitöltése az értesítés címével';

  @override
  String get settingsNLServiceChecking => 'Állapot ellenőrzése…';

  @override
  String settingsNLServiceCheckingError(String error) {
    return 'Hibaellenőrzés állapota: $error';
  }

  @override
  String get settingsNLServiceRunning => 'A szolgáltatás fut.';

  @override
  String get settingsNLServiceStatus => 'Szolgáltatás Állapota';

  @override
  String get settingsNLServiceStopped => 'A szolgáltatás leállt.';

  @override
  String get settingsNotificationListener => 'Értesítés Figyelő Szolgáltatás';

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
  String get transactionErrorNoAccounts => 'Please fill in the accounts first.';

  @override
  String get transactionErrorNoAssetAccount =>
      'Please select an asset account.';

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
      'Change Split Destination Account';

  @override
  String get transactionSplitChangeSourceAccount =>
      'Change Split Source Account';

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
}
