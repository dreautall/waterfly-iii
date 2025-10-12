// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class SCs extends S {
  SCs([String locale = 'cs']) : super(locale);

  @override
  String get accountRoleAssetCashWallet => 'Peněženka';

  @override
  String get accountRoleAssetCC => 'Kreditní karta';

  @override
  String get accountRoleAssetDefault => 'Výchozí účet majetku';

  @override
  String get accountRoleAssetSavings => 'Spořicí účet';

  @override
  String get accountRoleAssetShared => 'Sdílený účet aktiv';

  @override
  String get accountsLabelAsset => 'Účty majetku';

  @override
  String get accountsLabelExpense => 'Výdajové účty';

  @override
  String get accountsLabelLiabilities => 'Závazky';

  @override
  String get accountsLabelRevenue => 'Příjmové účty';

  @override
  String accountsLiabilitiesInterest(double interest, String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'týden',
      'monthly': 'měsíc',
      'quarterly': 'čtvrtletí',
      'halfyear': 'půlrok',
      'yearly': 'rok',
      'other': 'neznámé',
    });
    return '$interest% úrok za $_temp0';
  }

  @override
  String billsAmountAndFrequency(
    String minValue,
    String maxvalue,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'týdně',
      'monthly': 'měsíčně',
      'quarterly': 'čtvrtletně',
      'halfyear': 'pololetně',
      'yearly': 'ročně',
      'other': 'neznámé',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', přeskočí $skip',
      zero: '',
    );
    return 'Předplatné odpovídá transakcím mezi $minValue a $maxvalue. Opakuje se $_temp0$_temp1.';
  }

  @override
  String get billsChangeLayoutTooltip => 'Změnit rozložení';

  @override
  String get billsChangeSortOrderTooltip => 'Změnit pořadí řazení';

  @override
  String get billsErrorLoading => 'Chyba při načítání předplatných.';

  @override
  String billsExactAmountAndFrequency(
    String value,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'týdně',
      'monthly': 'měsíčně',
      'quarterly': 'čtvrtletně',
      'halfyear': 'pololetně',
      'yearly': 'ročně',
      'other': 'neznámé',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', přeskočí $skip',
      zero: '',
    );
    return 'Předplatné odpovídá transakcím v hodnotě $value. Opakuje se $_temp0$_temp1.';
  }

  @override
  String billsExpectedOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Očekáváno $dateString';
  }

  @override
  String billsFrequency(String frequency) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Týdně',
      'monthly': 'Měsíčně',
      'quarterly': 'Čtvrtletně',
      'halfyear': 'Pololetně',
      'yearly': 'Ročně',
      'other': 'Neznámé',
    });
    return '$_temp0';
  }

  @override
  String billsFrequencySkip(String frequency, num skip) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Týdně',
      'monthly': 'Měsíčně',
      'quarterly': 'Čtvrtletně',
      'halfyear': 'Pololetně',
      'yearly': 'Ročně',
      'other': 'Neznámé',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', přeskočí $skip',
      zero: '',
    );
    return '$_temp0$_temp1';
  }

  @override
  String get billsInactive => 'Neaktivní';

  @override
  String get billsIsActive => 'Předplatné je aktivní';

  @override
  String get billsLayoutGroupSubtitle =>
      'Předplatná zobrazená v přiřazených skupinách.';

  @override
  String get billsLayoutGroupTitle => 'Skupina';

  @override
  String get billsLayoutListSubtitle =>
      'Předplatná zobrazená v seznamu seřazeném podle určitých kritérií.';

  @override
  String get billsLayoutListTitle => 'Seznam';

  @override
  String get billsListEmpty => 'Seznam je aktuálně prázdný.';

  @override
  String get billsNextExpectedMatch => 'Další očekávaná shoda';

  @override
  String get billsNotActive => 'Předplatné je neaktivní';

  @override
  String get billsNotExpected => 'V tomto období neočekáváno';

  @override
  String get billsNoTransactions => 'Nebyly nalezeny žádné transakce.';

  @override
  String billsPaidOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Zaplaceno $dateString';
  }

  @override
  String get billsSortAlphabetical => 'Abecedně';

  @override
  String get billsSortByTimePeriod => 'Podle časového období';

  @override
  String get billsSortFrequency => 'Frekvence';

  @override
  String get billsSortName => 'Název';

  @override
  String get billsUngrouped => 'Neseskupené';

  @override
  String get billsSettingsShowOnlyActive => 'Zobrazit pouze aktivní';

  @override
  String get billsSettingsShowOnlyActiveDesc =>
      'Zobrazuje pouze aktivní předplatná.';

  @override
  String get billsSettingsShowOnlyExpected => 'Zobrazit pouze očekávané';

  @override
  String get billsSettingsShowOnlyExpectedDesc =>
      'Zobrazuje pouze ta předplatná, která jsou očekávána (nebo zaplacena) tento měsíc.';

  @override
  String get categoryDeleteConfirm =>
      'Opravdu chcete smazat tuto kategorii? Transakce nebudou smazány, ale již nebudou mít přiřazenou kategorii.';

  @override
  String get categoryErrorLoading => 'Chyba při načítání kategorií.';

  @override
  String get categoryFormLabelIncludeInSum => 'Zahrnout do měsíčního součtu';

  @override
  String get categoryFormLabelName => 'Název kategorie';

  @override
  String get categoryMonthNext => 'Příští měsíc';

  @override
  String get categoryMonthPrev => 'Předchozí měsíc';

  @override
  String get categorySumExcluded => 'vyloučeno';

  @override
  String get categoryTitleAdd => 'Přidat kategorii';

  @override
  String get categoryTitleDelete => 'Smazat kategorii';

  @override
  String get categoryTitleEdit => 'Upravit kategorii';

  @override
  String get catNone => '<bez kategorie>';

  @override
  String get catOther => 'Ostatní';

  @override
  String errorAPIInvalidResponse(String message) {
    return 'Neplatná odpověď z API: $message';
  }

  @override
  String get errorAPIUnavailable => 'API není dostupné';

  @override
  String get errorFieldRequired => 'Toto pole je povinné.';

  @override
  String get errorInvalidURL => 'Neplatná URL adresa';

  @override
  String errorMinAPIVersion(String requiredVersion) {
    return 'Je vyžadováno minimálně Firefly API verze $requiredVersion. Prosíme proveďte aktualizaci.';
  }

  @override
  String errorStatusCode(int code) {
    return 'Stavový kód: $code';
  }

  @override
  String get errorUnknown => 'Neznámá chyba.';

  @override
  String get formButtonHelp => 'Nápověda';

  @override
  String get formButtonLogin => 'Přihlásit se';

  @override
  String get formButtonLogout => 'Odhlásit se';

  @override
  String get formButtonRemove => 'Odstranit';

  @override
  String get formButtonResetLogin => 'Resetovat přihlášení';

  @override
  String get formButtonTransactionAdd => 'Přidat transakci';

  @override
  String get formButtonTryAgain => 'Zkusit znovu';

  @override
  String get generalAccount => 'Účet';

  @override
  String get generalAssets => 'Aktiva';

  @override
  String get generalBalance => 'Zůstatek';

  @override
  String generalBalanceOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Zůstatek k $dateString';
  }

  @override
  String get generalBill => 'Účtenka';

  @override
  String get generalBudget => 'Rozpočet';

  @override
  String get generalCategory => 'Kategorie';

  @override
  String get generalCurrency => 'Měna';

  @override
  String get generalDateRangeCurrentMonth => 'Aktuální měsíc';

  @override
  String get generalDateRangeLast30Days => 'Posledních 30 dní';

  @override
  String get generalDateRangeCurrentYear => 'Aktuální rok';

  @override
  String get generalDateRangeLastYear => 'Minulý rok';

  @override
  String get generalDateRangeAll => 'Vše';

  @override
  String get generalDefault => 'výchozí';

  @override
  String get generalDestinationAccount => 'Cílový účet';

  @override
  String get generalDismiss => 'Zrušit';

  @override
  String get generalEarned => 'Získané';

  @override
  String get generalError => 'Chyba';

  @override
  String get generalExpenses => 'Výdaje';

  @override
  String get generalIncome => 'Příjmy';

  @override
  String get generalLiabilities => 'Závazky';

  @override
  String get generalMultiple => 'několik';

  @override
  String get generalNever => 'nikdy';

  @override
  String get generalReconcile => 'Ověřeno';

  @override
  String get generalReset => 'Resetovat';

  @override
  String get generalSourceAccount => 'Zdrojový účet';

  @override
  String get generalSpent => 'Utracené';

  @override
  String get generalSum => 'Součet';

  @override
  String get generalTarget => 'Cíl';

  @override
  String get generalUnknown => 'Neznámý';

  @override
  String homeMainBillsInterval(String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'týdně',
      'monthly': 'měsíčně',
      'quarterly': 'čtvrtletně',
      'halfyear': 'půlročně',
      'yearly': 'ročně',
      'other': 'neznámé',
    });
    return ' ($_temp0)';
  }

  @override
  String get homeMainBillsTitle => 'Účty na příští týden';

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
      'over': 'přes',
      'other': 'zbývá z',
    });
    return '$current $_temp0 $available';
  }

  @override
  String get homeMainBudgetTitle => 'Rozpočty na aktuální měsíc';

  @override
  String get homeMainChartAccountsTitle => 'Souhrn účtu';

  @override
  String get homeMainChartCategoriesTitle =>
      'Souhrn kategorie pro aktuální měsíc';

  @override
  String get homeMainChartDailyAvg => 'Průměr za 7 dní';

  @override
  String get homeMainChartDailyTitle => 'Denní souhrn';

  @override
  String get homeMainChartNetEarningsTitle => 'Čisté příjmy';

  @override
  String get homeMainChartNetWorthTitle => 'Čisté jmění';

  @override
  String get homeMainChartTagsTitle => 'Souhrn štítků za aktuální měsíc';

  @override
  String get homePiggyAdjustDialogTitle => 'Uložit/utratit peníze';

  @override
  String homePiggyDateStart(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Datum začátku: $dateString';
  }

  @override
  String homePiggyDateTarget(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Datum cíle: $dateString';
  }

  @override
  String get homeMainDialogSettingsTitle => 'Přizpůsobit nástěnku';

  @override
  String homePiggyLinked(String account) {
    return 'Připojeno k $account';
  }

  @override
  String get homePiggyNoAccounts => 'Nebyly vytvořeny žádné pokladničky.';

  @override
  String get homePiggyNoAccountsSubtitle =>
      'Vytvořte si nějaké pokladničky ve webovém rozhraní!';

  @override
  String homePiggyRemaining(String amount) {
    return 'Zbývá našetřit: $amount';
  }

  @override
  String homePiggySaved(String amount) {
    return 'Dosud našetřeno: $amount';
  }

  @override
  String get homePiggySavedMultiple => 'Dosud ušetřeno:';

  @override
  String homePiggyTarget(String amount) {
    return 'Cílová částka: $amount';
  }

  @override
  String get homePiggyAccountStatus => 'Stav účtu';

  @override
  String get homePiggyAvailableAmounts => 'Dostupné částky';

  @override
  String homePiggyAvailable(String amount) {
    return 'K dispozici: $amount';
  }

  @override
  String homePiggyInPiggyBanks(String amount) {
    return 'V prasátkách: $amount';
  }

  @override
  String get homeTabLabelBalance => 'Zůstatek';

  @override
  String get homeTabLabelMain => 'Hlavní';

  @override
  String get homeTabLabelPiggybanks => 'Pokladničky';

  @override
  String get homeTabLabelTransactions => 'Transakce';

  @override
  String get homeTransactionsActionFilter => 'Seznam filtrů';

  @override
  String get homeTransactionsDialogFilterAccountsAll => '<Všechny účty>';

  @override
  String get homeTransactionsDialogFilterBillsAll => '<Všechny účty>';

  @override
  String get homeTransactionsDialogFilterBillUnset =>
      '<Žádný účet není nastaven>';

  @override
  String get homeTransactionsDialogFilterBudgetsAll => '<Všechny rozpočty>';

  @override
  String get homeTransactionsDialogFilterBudgetUnset =>
      '<Nebyl vybrán žádný rozpočeet>';

  @override
  String get homeTransactionsDialogFilterCategoriesAll => '<Všechny kategorie>';

  @override
  String get homeTransactionsDialogFilterCategoryUnset =>
      '<Žádná kategorie není nastavena>';

  @override
  String get homeTransactionsDialogFilterCurrenciesAll => '<Všechny měny>';

  @override
  String get homeTransactionsDialogFilterDateRange => 'Rozsah dat';

  @override
  String get homeTransactionsDialogFilterFutureTransactions =>
      'Zobrazit budoucí transakce';

  @override
  String get homeTransactionsDialogFilterSearch => 'Hledaný výraz';

  @override
  String get homeTransactionsDialogFilterTitle => 'Vybrat filtry';

  @override
  String get homeTransactionsEmpty => 'Nebyly nalezeny žádné transakce.';

  @override
  String homeTransactionsMultipleCategories(int num) {
    return '$num kategorií';
  }

  @override
  String get homeTransactionsSettingsShowTags =>
      'Zobrazit štítky v seznamu transakcí';

  @override
  String get liabilityDirectionCredit => 'Je mi dlužen tento dluh';

  @override
  String get liabilityDirectionDebit => 'Já dlužím tento dluh';

  @override
  String get liabilityTypeDebt => 'Dluh';

  @override
  String get liabilityTypeLoan => 'Půjčka';

  @override
  String get liabilityTypeMortgage => 'Hypotéka';

  @override
  String get loginAbout =>
      'Pro používání Waterfly III potřebujete Váš server s instancí Firefly III nebo doplněk Firefly III v rámci Home Assistant.\n\nZadejte celou adresu URL spolu s Vašim osobním přístupovým tokenem (Settings -> Profile -> OAuth -> Personal Access Token) níže.';

  @override
  String get loginFormLabelAPIKey => 'Platný klíč API';

  @override
  String get loginFormLabelHost => 'URL serveru';

  @override
  String get loginWelcome => 'Vítejte ve Waterfly III';

  @override
  String get logoutConfirmation => 'Opravdu se chcete odhlásit?';

  @override
  String get navigationAccounts => 'Účty';

  @override
  String get navigationBills => 'Předplatné';

  @override
  String get navigationCategories => 'Kategorie';

  @override
  String get navigationMain => 'Přehled';

  @override
  String get generalSettings => 'Nastavení';

  @override
  String get no => 'Ne';

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
      'Zde můžete povolit a odeslat protokoly ladění. Toto nastavení má negativní dopad na výkon aplikace, proto je prosím nepovolujte pokud to není nutné. Zakázáním logování bude odstraněn uložený protokol.';

  @override
  String get settingsDialogDebugMailCreate => 'Vytvořit e-mail';

  @override
  String get settingsDialogDebugMailDisclaimer =>
      'VAROVÁNÍ: Bude otevřen koncept e-mailu s přiloženým log souborem (v textovém formátu). Protokoly mohou obsahovat citlivé informace, například název a doménu Vaší instance Firefly (přestože se snažím zabránit logování jakýchkoliv citlivých informací, jako je API klíč). Prosím přečtěte si pečlivě přiložený log a odeberte jakékoliv informace, které nechcete sdílet a/nebo nejsou relevantní pro problém, který chcete nahlásit.\n\nNeposílejte prosím žádné logy bez předchozí domluvy prostřednictvím e-mailu nebo GitHub. Z důvodů ochrany osobních údajů smažu všechny protokoly odeslané bez kontextu. Nikdy nenahrávejte necenzurovaný log na GitHub nebo kamkoliv jinam.';

  @override
  String get settingsDialogDebugSendButton => 'Poslat protokoly přes e-mail';

  @override
  String get settingsDialogDebugTitle => 'Protokoly ladění';

  @override
  String get settingsDialogLanguageTitle => 'Vyberte jazyk';

  @override
  String get settingsDialogThemeTitle => 'Vyberte motiv';

  @override
  String get settingsFAQ => 'Často kladené dotazy';

  @override
  String get settingsFAQHelp =>
      'Otevře se v prohlížeči. Dostupné pouze v angličtině.';

  @override
  String get settingsLanguage => 'Jazyk';

  @override
  String get settingsLockscreen => 'Obrazovka uzamčení';

  @override
  String get settingsLockscreenHelp =>
      'Při spuštění aplikace požadovat ověření';

  @override
  String get settingsLockscreenInitial =>
      'Pro povolení zamykací obrazovky se prosím ověřte.';

  @override
  String get settingsNLAppAccount => 'Výchozí účet';

  @override
  String get settingsNLAppAccountDynamic => '<Dynamický>';

  @override
  String get settingsNLAppAdd => 'Přidat aplikaci';

  @override
  String get settingsNLAppAddHelp =>
      'Kliknutím přidáte aplikaci, které má aplikace poslouchat. V seznamu se zobrazí pouze podporované aplikace.';

  @override
  String get settingsNLAppAddInfo =>
      'Proveďte transakce při kterých dostáváte notifikaci v telefonu pro přidání aplikací do tohoto seznamu. Pokud se přesto aplikace nezobrazí, prosíme nahlašte to na app@vogt.pw.';

  @override
  String get settingsNLAutoAdd => 'Vytvořit transakci bez interakce';

  @override
  String get settingsNLDescription =>
      'Tato služba umožňuje načíst detaily transakce z příchozích push notifikací. Kromě toho si můžete vybrat výchozí účet, ke kterému by měla být transakce přiřazena - pokud není nastavena žádná hodnota, služba se snaží získat účet z textu notifikace.';

  @override
  String get settingsNLEmptyNote => 'Ponechat pole poznámky prázdné';

  @override
  String get settingsNLPermissionGrant => 'Klepnutím udělte oprávnění.';

  @override
  String get settingsNLPermissionNotGranted => 'Oprávnění nebylo uděleno.';

  @override
  String get settingsNLPermissionRemove => 'Odstranit oprávnění?';

  @override
  String get settingsNLPermissionRemoveHelp =>
      'Chcete-li zakázat tuto službu, klikněte na aplikaci a odeberte oprávnění na další obrazovce.';

  @override
  String get settingsNLPrefillTXTitle =>
      'Doplnit název transakce pomocí nadpisu nofikace';

  @override
  String get settingsNLServiceChecking => 'Kontroluji stav…';

  @override
  String settingsNLServiceCheckingError(String error) {
    return 'Chyba při kontrole stavu: $error';
  }

  @override
  String get settingsNLServiceRunning => 'Služba je spuštěna.';

  @override
  String get settingsNLServiceStatus => 'Stav služby';

  @override
  String get settingsNLServiceStopped => 'Služba je zastavena.';

  @override
  String get settingsNotificationListener => 'Služba pro čtení notifikací';

  @override
  String get settingsTheme => 'Motiv aplikace';

  @override
  String get settingsThemeDynamicColors => 'Dynamické barvy';

  @override
  String settingsThemeValue(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'dark': 'Tmavý motiv',
      'light': 'Světlý motiv',
      'other': 'Výchozí systému',
    });
    return '$_temp0';
  }

  @override
  String get settingsUseServerTimezone => 'Použít časové pásmo serveru';

  @override
  String get settingsUseServerTimezoneHelp =>
      'Zobrazit všechny časy v časovém pásmu serveru. Toto napodobuje chování webového rozhraní.';

  @override
  String get settingsVersion => 'Verze aplikace';

  @override
  String get settingsVersionChecking => 'kontroluji…';

  @override
  String get transactionAttachments => 'Přílohy';

  @override
  String get transactionDeleteConfirm =>
      'Opravdu chcete tuto transakci smazat?';

  @override
  String get transactionDialogAttachmentsDelete => 'Smazat přílohu';

  @override
  String get transactionDialogAttachmentsDeleteConfirm =>
      'Opravdu chcete tuto přílohu smazat?';

  @override
  String get transactionDialogAttachmentsErrorDownload =>
      'Soubor se nepodařilo stáhnout.';

  @override
  String transactionDialogAttachmentsErrorOpen(String error) {
    return 'Nepodařilo se otevřít soubor: $error';
  }

  @override
  String transactionDialogAttachmentsErrorUpload(String error) {
    return 'Nepodařilo se nahrát soubor: $error';
  }

  @override
  String get transactionDialogAttachmentsTitle => 'Přílohy';

  @override
  String get transactionDialogBillNoBill => 'Žádný účet';

  @override
  String get transactionDialogBillTitle => 'Odkaz na účet';

  @override
  String get transactionDialogCurrencyTitle => 'Vybrat měnu';

  @override
  String get transactionDialogTagsAdd => 'Přidat štítek';

  @override
  String get transactionDialogTagsHint => 'Hledat/Přidat štítek';

  @override
  String get transactionDialogTagsTitle => 'Vybrat štítky';

  @override
  String get transactionDuplicate => 'Duplikovat';

  @override
  String get transactionErrorInvalidAccount => 'Neplatný účet';

  @override
  String get transactionErrorInvalidBudget => 'Neplatný rozpočet';

  @override
  String get transactionErrorNoAccounts => 'Prosím, nejprve vyplňte účty.';

  @override
  String get transactionErrorNoAssetAccount =>
      'Prosím, vyberte majetkový účet.';

  @override
  String get transactionErrorTitle => 'Zadejte prosím název.';

  @override
  String get transactionFormLabelAccountDestination => 'Cílový účet';

  @override
  String get transactionFormLabelAccountForeign => 'Zahraniční účet';

  @override
  String get transactionFormLabelAccountOwn => 'Vlastní účet';

  @override
  String get transactionFormLabelAccountSource => 'Zdrojový účet';

  @override
  String get transactionFormLabelNotes => 'Poznámky';

  @override
  String get transactionFormLabelTags => 'Štítky';

  @override
  String get transactionFormLabelTitle => 'Název transakce';

  @override
  String get transactionSplitAdd => 'Přidat rozdělenou transakci';

  @override
  String get transactionSplitChangeCurrency => 'Změnit rozdělenou měnu';

  @override
  String get transactionSplitChangeDestinationAccount =>
      'Změnit cílový účet rozdělené transakce';

  @override
  String get transactionSplitChangeSourceAccount =>
      'Změnit zdrojový účet rozdělené transakce';

  @override
  String get transactionSplitChangeTarget => 'Změnit cílový účet rozdělení';

  @override
  String get transactionSplitDelete => 'Odstranit rozdělení';

  @override
  String get transactionTitleAdd => 'Přidat transakci';

  @override
  String get transactionTitleDelete => 'Smazat transakci';

  @override
  String get transactionTitleEdit => 'Upravit transakci';

  @override
  String get transactionTypeDeposit => 'Vklad';

  @override
  String get transactionTypeTransfer => 'Převod';

  @override
  String get transactionTypeWithdrawal => 'Výběr';
}
