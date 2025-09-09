// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class SSv extends S {
  SSv([String locale = 'sv']) : super(locale);

  @override
  String get accountRoleAssetCashWallet => 'Plånbok';

  @override
  String get accountRoleAssetCC => 'Kreditkort';

  @override
  String get accountRoleAssetDefault => 'Förvalt tillgångskonto';

  @override
  String get accountRoleAssetSavings => 'Sparkonto';

  @override
  String get accountRoleAssetShared => 'Delat tillgångskonto';

  @override
  String get accountsLabelAsset => 'Tillgångskonton';

  @override
  String get accountsLabelExpense => 'Kostnadskonton';

  @override
  String get accountsLabelLiabilities => 'Skulder';

  @override
  String get accountsLabelRevenue => 'Intäktskonton';

  @override
  String accountsLiabilitiesInterest(double interest, String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'vecka',
      'monthly': 'månad',
      'quarterly': 'kvartal',
      'halfyear': 'halvår',
      'yearly': 'år',
      'other': 'okänd',
    });
    return '$interest% ränta per $_temp0';
  }

  @override
  String billsAmountAndFrequency(
    String minValue,
    String maxvalue,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'veckovis',
      'monthly': 'månadsvis',
      'quarterly': 'kvartalsvis',
      'halfyear': 'halvårsvis',
      'yearly': 'årligen',
      'other': 'okänt',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', hoppar över $skip',
      zero: '',
    );
    return 'Räkningen matchar transaktioner mellan $minValue och $maxvalue. Upprepas $_temp0$_temp1.';
  }

  @override
  String get billsChangeLayoutTooltip => 'Ändra layout';

  @override
  String get billsChangeSortOrderTooltip => 'Ändra sorteringsordning';

  @override
  String get billsErrorLoading => 'Fel vid laddning av räkningar.';

  @override
  String billsExactAmountAndFrequency(
    String value,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'veckovis',
      'monthly': 'månadsvis',
      'quarterly': 'kvartalsvis',
      'halfyear': 'halvårsvis',
      'yearly': 'årligen',
      'other': 'okänt',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', hoppar över $skip',
      zero: '',
    );
    return 'Räkningen matchar transaktioner på $value. Upprepas $_temp0$_temp1.';
  }

  @override
  String billsExpectedOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Förväntad $dateString';
  }

  @override
  String billsFrequency(String frequency) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Veckovis',
      'monthly': 'Månadsvis',
      'quarterly': 'Kvartalsvis',
      'halfyear': 'Halvårsvis',
      'yearly': 'Årligen',
      'other': 'Okänt',
    });
    return '$_temp0';
  }

  @override
  String billsFrequencySkip(String frequency, num skip) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Veckovis',
      'monthly': 'Månadsvis',
      'quarterly': 'Kvartalsvis',
      'halfyear': 'Halvårsvis',
      'yearly': 'Årligen',
      'other': 'Okänt',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', hoppar över $skip',
      zero: '',
    );
    return '$_temp0$_temp1';
  }

  @override
  String get billsInactive => 'Inaktiv';

  @override
  String get billsIsActive => 'Räkningen aktiv';

  @override
  String get billsLayoutGroupSubtitle =>
      'Räkningar visas i sina tilldelade grupper.';

  @override
  String get billsLayoutGroupTitle => 'Grupp';

  @override
  String get billsLayoutListSubtitle =>
      'Räkningar visas i en lista sorterad efter vissa kriterier.';

  @override
  String get billsLayoutListTitle => 'Lista';

  @override
  String get billsListEmpty => 'Den här listan är för närvarande tom.';

  @override
  String get billsNextExpectedMatch => 'Nästa förväntade träff';

  @override
  String get billsNotActive => 'Räkningen är inaktiv';

  @override
  String get billsNotExpected => 'Ej förväntat denna period';

  @override
  String get billsNoTransactions => 'Inga transaktioner hittade.';

  @override
  String billsPaidOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Betald $dateString';
  }

  @override
  String get billsSortAlphabetical => 'Alfabetisk';

  @override
  String get billsSortByTimePeriod => 'Efter tidsperiod';

  @override
  String get billsSortFrequency => 'Frekvens';

  @override
  String get billsSortName => 'Namn';

  @override
  String get billsUngrouped => 'Ogrupperad';

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
      'Är du säker på att du vill ta bort denna kategori? Transaktionerna kommer inte att tas bort, men kommer inte att ha en kategori längre.';

  @override
  String get categoryErrorLoading => 'Fel vid laddning av kategorier.';

  @override
  String get categoryFormLabelIncludeInSum => 'Inkludera i månadssumman';

  @override
  String get categoryFormLabelName => 'Kategorinamn';

  @override
  String get categoryMonthNext => 'Nästa Månad';

  @override
  String get categoryMonthPrev => 'Föregående månad';

  @override
  String get categorySumExcluded => 'exkluderad';

  @override
  String get categoryTitleAdd => 'Lägg till kategori';

  @override
  String get categoryTitleDelete => 'Ta bort kategori';

  @override
  String get categoryTitleEdit => 'Redigera kategori';

  @override
  String get catNone => '<ingen kategori>';

  @override
  String get catOther => 'Övrigt';

  @override
  String errorAPIInvalidResponse(String message) {
    return 'Ogiltigt svar från API: $message';
  }

  @override
  String get errorAPIUnavailable => 'API inte tillgängligt';

  @override
  String get errorFieldRequired => 'Detta fält är obligatoriskt.';

  @override
  String get errorInvalidURL => 'Ogiltig URL';

  @override
  String errorMinAPIVersion(String requiredVersion) {
    return 'Minsta Firefly API Version v$requiredVersion krävs. Vänligen uppdatera Firefly.';
  }

  @override
  String errorStatusCode(int code) {
    return 'Statuskod: $code';
  }

  @override
  String get errorUnknown => 'Okänt fel.';

  @override
  String get formButtonHelp => 'Hjälp';

  @override
  String get formButtonLogin => 'Logga in';

  @override
  String get formButtonLogout => 'Logga ut';

  @override
  String get formButtonRemove => 'Ta bort';

  @override
  String get formButtonResetLogin => 'Återställ inloggning';

  @override
  String get formButtonTransactionAdd => 'Lägg till transaktion';

  @override
  String get formButtonTryAgain => 'Försök igen';

  @override
  String get generalAccount => 'Konto';

  @override
  String get generalAssets => 'Tillgångar';

  @override
  String get generalBalance => 'Balans';

  @override
  String generalBalanceOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Saldo för $dateString';
  }

  @override
  String get generalBill => 'Räkning';

  @override
  String get generalBudget => 'Budget';

  @override
  String get generalCategory => 'Kategori';

  @override
  String get generalCurrency => 'Valuta';

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
  String get generalDefault => 'förvald';

  @override
  String get generalDestinationAccount => 'Destination Account';

  @override
  String get generalDismiss => 'Stäng';

  @override
  String get generalEarned => 'Intjänat';

  @override
  String get generalError => 'Fel';

  @override
  String get generalExpenses => 'Utgifter';

  @override
  String get generalIncome => 'Inkomst';

  @override
  String get generalLiabilities => 'Skulder';

  @override
  String get generalMultiple => 'multipla';

  @override
  String get generalNever => 'aldrig';

  @override
  String get generalReconcile => 'Avstämt';

  @override
  String get generalReset => 'Återställ';

  @override
  String get generalSourceAccount => 'Source Account';

  @override
  String get generalSpent => 'Spenderat';

  @override
  String get generalSum => 'Summa';

  @override
  String get generalTarget => 'Mål';

  @override
  String get generalUnknown => 'Okänt';

  @override
  String homeMainBillsInterval(String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'veckovis',
      'monthly': 'månadsvis',
      'quarterly': 'kvartalsvis',
      'halfyear': 'årligen',
      'yearly': '',
      'other': 'okänd',
    });
    return ' ($_temp0)';
  }

  @override
  String get homeMainBillsTitle => 'Räkningar inför nästa vecka';

  @override
  String homeMainBudgetInterval(DateTime from, DateTime to, String period) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return ' ($fromString till $toString, $period)';
  }

  @override
  String homeMainBudgetIntervalSingle(DateTime from, DateTime to) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return ' ($fromString till $toString)';
  }

  @override
  String homeMainBudgetSum(String current, String status, String available) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'over': 'över',
      'other': 'kvar från',
    });
    return '$current $_temp0 $available';
  }

  @override
  String get homeMainBudgetTitle => 'Budgetar för den aktuella månaden';

  @override
  String get homeMainChartAccountsTitle => 'Kontosammanfattning';

  @override
  String get homeMainChartCategoriesTitle =>
      'Kategorisammanfattning för aktuell månad';

  @override
  String get homeMainChartDailyAvg => '7 dagars genomsnitt';

  @override
  String get homeMainChartDailyTitle => 'Daglig sammanfattning';

  @override
  String get homeMainChartNetEarningsTitle => 'Nettoinkomst';

  @override
  String get homeMainChartNetWorthTitle => 'Nettoförmögenhet';

  @override
  String get homeMainChartTagsTitle => 'Tag Summary for current month';

  @override
  String get homePiggyAdjustDialogTitle => 'Spara/spendera pengar';

  @override
  String homePiggyDateStart(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Startdatum: $dateString';
  }

  @override
  String homePiggyDateTarget(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Måldatum: $dateString';
  }

  @override
  String get homeMainDialogSettingsTitle => 'Customize Dashboard';

  @override
  String homePiggyLinked(String account) {
    return 'Länkad till $account';
  }

  @override
  String get homePiggyNoAccounts => 'Inga spargrisar har inrättats.';

  @override
  String get homePiggyNoAccountsSubtitle => 'Skapa några i webbgränssnittet!';

  @override
  String homePiggyRemaining(String amount) {
    return 'Kvar att spara: $amount';
  }

  @override
  String homePiggySaved(String amount) {
    return 'Sparat hittills: $amount';
  }

  @override
  String get homePiggySavedMultiple => 'Saved so far:';

  @override
  String homePiggyTarget(String amount) {
    return 'Målbelopp: $amount';
  }

  @override
  String get homeTabLabelBalance => 'Balansräkning';

  @override
  String get homeTabLabelMain => 'Start';

  @override
  String get homeTabLabelPiggybanks => 'Spargris';

  @override
  String get homeTabLabelTransactions => 'Transaktioner';

  @override
  String get homeTransactionsActionFilter => 'Filtrera listan';

  @override
  String get homeTransactionsDialogFilterAccountsAll => '<Alla konton>';

  @override
  String get homeTransactionsDialogFilterBillsAll => '<Alla räkningar>';

  @override
  String get homeTransactionsDialogFilterBillUnset => '<Utan räkning>';

  @override
  String get homeTransactionsDialogFilterBudgetsAll => '<All budgetar>';

  @override
  String get homeTransactionsDialogFilterBudgetUnset => '<Utan budget>';

  @override
  String get homeTransactionsDialogFilterCategoriesAll => '<All kategorier>';

  @override
  String get homeTransactionsDialogFilterCategoryUnset => '<Utan kategori>';

  @override
  String get homeTransactionsDialogFilterCurrenciesAll => '<Alla valutor>';

  @override
  String get homeTransactionsDialogFilterDateRange => 'Date Range';

  @override
  String get homeTransactionsDialogFilterFutureTransactions =>
      'Visa framtida transaktioner';

  @override
  String get homeTransactionsDialogFilterSearch => 'Sökord';

  @override
  String get homeTransactionsDialogFilterTitle => 'Välj filter';

  @override
  String get homeTransactionsEmpty => 'Inga transaktioner hittade.';

  @override
  String homeTransactionsMultipleCategories(int num) {
    return '$num kategorier';
  }

  @override
  String get homeTransactionsSettingsShowTags =>
      'Show tags in transaction list';

  @override
  String get liabilityDirectionCredit => 'Jag är skyldig denna skuld';

  @override
  String get liabilityDirectionDebit => 'Jag har denna skuld';

  @override
  String get liabilityTypeDebt => 'Skuld';

  @override
  String get liabilityTypeLoan => 'Lån';

  @override
  String get liabilityTypeMortgage => 'Bolån';

  @override
  String get loginAbout =>
      'För att använda Waterfly III på ett produktivt sätt behöver du din egen server med en Firefly III instans eller Firefly III-tillägget för Home Assistant.\n\nAnge hela URL: en samt en personlig åtkomst-token (inställningar -> Profil -> OAuth -> Personlig åtkomst-token) nedan.';

  @override
  String get loginFormLabelAPIKey => 'Giltig API-nyckel';

  @override
  String get loginFormLabelHost => 'Värd URL';

  @override
  String get loginWelcome => 'Välkommen till Waterfly III';

  @override
  String get logoutConfirmation => 'Är du säker på att du vill logga ut?';

  @override
  String get navigationAccounts => 'Konton';

  @override
  String get navigationBills => 'Räkningar';

  @override
  String get navigationCategories => 'Kategorier';

  @override
  String get navigationMain => 'Kontrollpanel';

  @override
  String get generalSettings => 'Settings';

  @override
  String get no => 'Nej';

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

    return '$percString av $of';
  }

  @override
  String get settingsDialogDebugInfo =>
      'Du kan aktivera och skicka felsökningsloggar här. Dessa har en dålig inverkan på prestandan, så var snäll och aktivera dem inte om du inte rekommenderas att göra det. Inaktivering av loggning kommer att ta bort den lagrade loggen.';

  @override
  String get settingsDialogDebugMailCreate => 'Skapa e-post';

  @override
  String get settingsDialogDebugMailDisclaimer =>
      'VARNING: Ett e-postutkast öppnas med loggfilen bifogad (i textformat). Loggarna kan innehålla känslig information, såsom värdnamnet för din Firefly instans (även om jag försöker undvika loggning av några hemligheter, såsom api nyckel). Läs igenom loggen noga och censurera all information som du inte vill dela och/eller inte är relevant för det problem du vill rapportera.\n\nSkicka inte in loggar utan föregående överenskommelse via mail/GitHub. Jag kommer att ta bort alla loggar som skickas utan kontext av sekretessskäl. Ladda aldrig upp loggen ocensurerad till GitHub eller någon annanstans.';

  @override
  String get settingsDialogDebugSendButton => 'Skicka loggar via e-post';

  @override
  String get settingsDialogDebugTitle => 'Felsökningsloggar';

  @override
  String get settingsDialogLanguageTitle => 'Välj språk';

  @override
  String get settingsDialogThemeTitle => 'Välj tema';

  @override
  String get settingsFAQ => 'FAQ';

  @override
  String get settingsFAQHelp => 'Opens in Browser. Only available in English.';

  @override
  String get settingsLanguage => 'Språk';

  @override
  String get settingsLockscreen => 'Låsskärm';

  @override
  String get settingsLockscreenHelp => 'Kräv autentisering vid appstart';

  @override
  String get settingsLockscreenInitial =>
      'Vänligen autentisera för att aktivera låsskärmen.';

  @override
  String get settingsNLAppAccount => 'Förvalt konto';

  @override
  String get settingsNLAppAccountDynamic => '<Dynamiskt>';

  @override
  String get settingsNLAppAdd => 'Lägg till app';

  @override
  String get settingsNLAppAddHelp =>
      'Klicka för att lägga till en app att lyssna efter. Endast kvalificerade appar visas i listan.';

  @override
  String get settingsNLAppAddInfo =>
      'Gör några transaktioner där du får telefonaviseringar för att lägga till appar i den här listan. Om appen fortfarande inte dyker upp, vänligen rapportera det till app@vogt.pw.';

  @override
  String get settingsNLAutoAdd => 'Create transaction without interaction';

  @override
  String get settingsNLDescription =>
      'Den här tjänsten låter dig hämta transaktionsdetaljer från inkommande pushnotifikationer. Du kan även välja ett förvalt konto som transaktionen ska göras på - om inget värde ges försöker den extrahera kontot från notifikationen.';

  @override
  String get settingsNLEmptyNote => 'Keep note field empty';

  @override
  String get settingsNLPermissionGrant => 'Tryck för att bevilja tillstånd.';

  @override
  String get settingsNLPermissionNotGranted => 'Behörighet inte beviljad.';

  @override
  String get settingsNLPermissionRemove => 'Ta bort behörigheten?';

  @override
  String get settingsNLPermissionRemoveHelp =>
      'För att avaktivera den här tjänsten, tryck på appen och ta bort behörigheterna på den nästa skärmen.';

  @override
  String get settingsNLPrefillTXTitle =>
      'Fyll i transaktionstiteln med nofikationstiteln i förväg';

  @override
  String get settingsNLServiceChecking => 'Kontrollerar status…';

  @override
  String settingsNLServiceCheckingError(String error) {
    return 'Fel vid kontroll av status: $error';
  }

  @override
  String get settingsNLServiceRunning => 'Tjänsten körs.';

  @override
  String get settingsNLServiceStatus => 'Tjänstestatus';

  @override
  String get settingsNLServiceStopped => 'Tjänsten är stoppad.';

  @override
  String get settingsNotificationListener => 'Notifikationslyssningstjänst';

  @override
  String get settingsTheme => 'Apptema';

  @override
  String get settingsThemeDynamicColors => 'Dynamiska färger';

  @override
  String settingsThemeValue(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'dark': 'Mörkt läge',
      'light': 'Ljust läge',
      'other': 'Systemstandard',
    });
    return '$_temp0';
  }

  @override
  String get settingsUseServerTimezone => 'Använd serverns tidszon';

  @override
  String get settingsUseServerTimezoneHelp =>
      'Visa alla tider i serverns tidszon. Detta härmar beteendet hos webbgränssnittet.';

  @override
  String get settingsVersion => 'Appversion';

  @override
  String get settingsVersionChecking => 'kontrollerar…';

  @override
  String get transactionAttachments => 'Bilagor';

  @override
  String get transactionDeleteConfirm =>
      'Är du säker att du vill radera denna transaktion?';

  @override
  String get transactionDialogAttachmentsDelete => 'Ta bort bifogad fil';

  @override
  String get transactionDialogAttachmentsDeleteConfirm =>
      'Är du säker på att du vill radera bilagan?';

  @override
  String get transactionDialogAttachmentsErrorDownload =>
      'Kunde inte ladda ner filen.';

  @override
  String transactionDialogAttachmentsErrorOpen(String error) {
    return 'Kunde inte öppna filen: $error';
  }

  @override
  String transactionDialogAttachmentsErrorUpload(String error) {
    return 'Kunde inte ladda upp filen: $error';
  }

  @override
  String get transactionDialogAttachmentsTitle => 'Bilagor';

  @override
  String get transactionDialogBillNoBill => 'Ingen faktura';

  @override
  String get transactionDialogBillTitle => 'Länk till faktura';

  @override
  String get transactionDialogCurrencyTitle => 'Välj valuta';

  @override
  String get transactionDialogTagsAdd => 'Lägg till Tagg';

  @override
  String get transactionDialogTagsHint => 'Sök/Lägg till tagg';

  @override
  String get transactionDialogTagsTitle => 'Välj taggar';

  @override
  String get transactionDuplicate => 'Dubblett';

  @override
  String get transactionErrorInvalidAccount => 'Ogiltigt konto';

  @override
  String get transactionErrorInvalidBudget => 'Ogiltig budget';

  @override
  String get transactionErrorNoAccounts => 'Please fill in the accounts first.';

  @override
  String get transactionErrorNoAssetAccount =>
      'Please select an asset account.';

  @override
  String get transactionErrorTitle => 'Vänligen ange en titel.';

  @override
  String get transactionFormLabelAccountDestination => 'Till konto';

  @override
  String get transactionFormLabelAccountForeign => 'Mottagarkonto';

  @override
  String get transactionFormLabelAccountOwn => 'Källkonto';

  @override
  String get transactionFormLabelAccountSource => 'Källkonto';

  @override
  String get transactionFormLabelNotes => 'Anteckningar';

  @override
  String get transactionFormLabelTags => 'Taggar';

  @override
  String get transactionFormLabelTitle => 'Transaktionstitel';

  @override
  String get transactionSplitAdd => 'Lägg till delad transaktion';

  @override
  String get transactionSplitChangeCurrency => 'Ändra delad valuta';

  @override
  String get transactionSplitChangeDestinationAccount =>
      'Change Split Destination Account';

  @override
  String get transactionSplitChangeSourceAccount =>
      'Change Split Source Account';

  @override
  String get transactionSplitChangeTarget => 'Ändra delat målkonto';

  @override
  String get transactionSplitDelete => 'Ta bort delning';

  @override
  String get transactionTitleAdd => 'Lägg till transaktion';

  @override
  String get transactionTitleDelete => 'Ta bort transaktion';

  @override
  String get transactionTitleEdit => 'Ändra transaktion';

  @override
  String get transactionTypeDeposit => 'Insättning';

  @override
  String get transactionTypeTransfer => 'Överföring';

  @override
  String get transactionTypeWithdrawal => 'Uttag';
}
