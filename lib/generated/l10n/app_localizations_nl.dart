// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class SNl extends S {
  SNl([String locale = 'nl']) : super(locale);

  @override
  String get accountRoleAssetCashWallet => 'Cash Wallet';

  @override
  String get accountRoleAssetCC => 'Kredietkaart';

  @override
  String get accountRoleAssetDefault => 'Standaard activarekening';

  @override
  String get accountRoleAssetSavings => 'Spaarrekening';

  @override
  String get accountRoleAssetShared => 'Gedeelde activarekening';

  @override
  String get accountsLabelAsset => 'Betaalrekeningen';

  @override
  String get accountsLabelExpense => 'Kostenrekeningen';

  @override
  String get accountsLabelLiabilities => 'Schulden';

  @override
  String get accountsLabelRevenue => 'Omzetrekeningen';

  @override
  String accountsLiabilitiesInterest(double interest, String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'wekelijks',
      'monthly': 'maandelijks',
      'quarterly': 'kwartaal',
      'halfyear': 'halfjaarlijks',
      'yearly': 'jaarlijks',
      'other': 'onbekend',
    });
    return '$interest% rente per $_temp0';
  }

  @override
  String billsAmountAndFrequency(
    String minValue,
    String maxvalue,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'wekelijks',
      'monthly': 'maandelijks',
      'quarterly': 'per kwartaal',
      'halfyear': 'halfjaarlijks',
      'yearly': 'jaarlijks',
      'other': 'onbekend',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', slaat over $skip',
      zero: '',
    );
    return 'Abonnementen komen overeen met transacties tussen $minValue en $maxvalue. Herhalingen $_temp0$_temp1.';
  }

  @override
  String get billsChangeLayoutTooltip => 'Lay-out wijzigen';

  @override
  String get billsChangeSortOrderTooltip => 'Sorteervolgorde wijzigen';

  @override
  String get billsErrorLoading => 'Fout bij het laden van abonnementen.';

  @override
  String billsExactAmountAndFrequency(
    String value,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'wekelijks',
      'monthly': 'maandelijks',
      'quarterly': 'per kwartaal',
      'halfyear': 'halfjaarlijks',
      'yearly': 'jaarlijks',
      'other': 'onbekend',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', slaat over $skip',
      zero: '',
    );
    return 'Abonnement komt overeen met transacties van $value. Herhaald $_temp0$_temp1.';
  }

  @override
  String billsExpectedOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Verwacht $dateString';
  }

  @override
  String billsFrequency(String frequency) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'wekelijks',
      'monthly': 'maandelijks',
      'quarterly': 'per kwartaal',
      'halfyear': 'halfjaarlijks',
      'yearly': 'jaarlijks',
      'other': 'onbekend',
    });
    return '$_temp0';
  }

  @override
  String billsFrequencySkip(String frequency, num skip) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'wekelijks',
      'monthly': 'maandelijks',
      'quarterly': 'per kwartaal',
      'halfyear': 'halfjaarlijks',
      'yearly': 'jaarlijks',
      'other': 'onbekend',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', slaat over $skip',
      zero: '',
    );
    return '$_temp0$_temp1';
  }

  @override
  String get billsInactive => 'Inactief';

  @override
  String get billsIsActive => 'Abonnement is actief';

  @override
  String get billsLayoutGroupSubtitle =>
      'Abonnementen weergegeven in hun toegewezen groepen.';

  @override
  String get billsLayoutGroupTitle => 'Groep';

  @override
  String get billsLayoutListSubtitle =>
      'Abonnementen weergegeven in hun toegewezen groepen.';

  @override
  String get billsLayoutListTitle => 'Lijst';

  @override
  String get billsListEmpty => 'De lijst is momenteel leeg.';

  @override
  String get billsNextExpectedMatch => 'Volgende verwachte match';

  @override
  String get billsNotActive => 'Abonnement is inactief';

  @override
  String get billsNotExpected => 'Niet verwacht in deze periode';

  @override
  String get billsNoTransactions => 'Geen transacties gevonden.';

  @override
  String billsPaidOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Betaald $dateString';
  }

  @override
  String get billsSortAlphabetical => 'Alfabetisch';

  @override
  String get billsSortByTimePeriod => 'Per periode';

  @override
  String get billsSortFrequency => 'Frequentie';

  @override
  String get billsSortName => 'Naam';

  @override
  String get billsUngrouped => 'Niet gegroepeerd';

  @override
  String get billsSettingsShowOnlyActive => 'Alleen actieve weergeven';

  @override
  String get billsSettingsShowOnlyActiveDesc =>
      'Toont alleen actieve abonnementen.';

  @override
  String get billsSettingsShowOnlyExpected => 'Alleen verwachte weergeven';

  @override
  String get billsSettingsShowOnlyExpectedDesc =>
      'Toont alleen de abonnementen die deze maand worden verwacht (of betaald).';

  @override
  String get categoryDeleteConfirm =>
      'Weet u zeker dat u deze categorie wilt verwijderen? De transacties worden niet verwijderd, maar hebben geen categorie meer.';

  @override
  String get categoryErrorLoading => 'Fout bij het laden van categorieën.';

  @override
  String get categoryFormLabelIncludeInSum => 'Opnemen in maandelijkse som';

  @override
  String get categoryFormLabelName => 'Categorie naam';

  @override
  String get categoryMonthNext => 'Volgende maand';

  @override
  String get categoryMonthPrev => 'Vorige maand';

  @override
  String get categorySumExcluded => 'Uitgesloten';

  @override
  String get categoryTitleAdd => 'Categorie toevoegen';

  @override
  String get categoryTitleDelete => 'Categorie verwijderen';

  @override
  String get categoryTitleEdit => 'Categorie bewerken';

  @override
  String get catNone => '<geen categorie>';

  @override
  String get catOther => 'Andere';

  @override
  String errorAPIInvalidResponse(String message) {
    return 'Categorie Naam Ongeldige reactie van API: $message';
  }

  @override
  String get errorAPIUnavailable => 'API niet beschikbaar';

  @override
  String get errorFieldRequired => 'Dit veld is verplicht.';

  @override
  String get errorInvalidURL => 'Ongeldige URL';

  @override
  String errorMinAPIVersion(String requiredVersion) {
    return 'Minimale Firefly API versie v$requiredVersion vereist. Upgrade aub.';
  }

  @override
  String errorStatusCode(int code) {
    return 'Statuscode: $code';
  }

  @override
  String get errorUnknown => 'Onbekende fout.';

  @override
  String get formButtonHelp => 'Hulp';

  @override
  String get formButtonLogin => 'Aanmelden';

  @override
  String get formButtonLogout => 'Afmelden';

  @override
  String get formButtonRemove => 'Verwijderen';

  @override
  String get formButtonResetLogin => 'Login opnieuw instellen';

  @override
  String get formButtonTransactionAdd => 'Transactie toevoegen';

  @override
  String get formButtonTryAgain => 'Probeer het opnieuw';

  @override
  String get generalAccount => 'Rekening';

  @override
  String get generalAssets => 'Activa';

  @override
  String get generalBalance => 'Saldo';

  @override
  String generalBalanceOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Saldo op $dateString';
  }

  @override
  String get generalBill => 'Abonnement';

  @override
  String get generalBudget => 'Budget';

  @override
  String get generalCategory => 'Categorie';

  @override
  String get generalCurrency => 'Valuta';

  @override
  String get generalDateRangeCurrentMonth => 'Huidige maand';

  @override
  String get generalDateRangeLast30Days => 'Afgelopen 30 dagen';

  @override
  String get generalDateRangeCurrentYear => 'Huidig Jaar';

  @override
  String get generalDateRangeLastYear => 'Afgelopen jaar';

  @override
  String get generalDateRangeAll => 'Alle';

  @override
  String get generalDefault => 'standaard';

  @override
  String get generalDestinationAccount => 'Doelrekening';

  @override
  String get generalDismiss => 'Negeren';

  @override
  String get generalEarned => 'Verdiend';

  @override
  String get generalError => 'Fout';

  @override
  String get generalExpenses => 'Uitgaven';

  @override
  String get generalIncome => 'Inkomen';

  @override
  String get generalLiabilities => 'Schulden';

  @override
  String get generalMultiple => 'meerdere';

  @override
  String get generalNever => 'nooit';

  @override
  String get generalReconcile => 'Bevestigd';

  @override
  String get generalReset => 'Herstellen';

  @override
  String get generalSourceAccount => 'Bronrekening';

  @override
  String get generalSpent => 'Uitgegeven';

  @override
  String get generalSum => 'Som';

  @override
  String get generalTarget => 'Doel';

  @override
  String get generalUnknown => 'Onbekend';

  @override
  String homeMainBillsInterval(String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'wekelijks',
      'monthly': 'maandelijks',
      'quarterly': 'per kwartaal',
      'halfyear': 'halfjaarlijks',
      'yearly': 'jaarlijks',
      'other': 'onbekend',
    });
    return '$_temp0';
  }

  @override
  String get homeMainBillsTitle => 'Abonnementen voor de volgende week';

  @override
  String homeMainBudgetInterval(DateTime from, DateTime to, String period) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return ' ($fromString tot $toString, $period)';
  }

  @override
  String homeMainBudgetIntervalSingle(DateTime from, DateTime to) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return ' ($fromString tot $toString)';
  }

  @override
  String homeMainBudgetSum(String current, String status, String available) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'over': 'over',
      'other': 'over van',
    });
    return '$current$_temp0 $available';
  }

  @override
  String get homeMainBudgetTitle => 'Budgetten voor deze maand';

  @override
  String get homeMainChartAccountsTitle => 'Accountoverzicht';

  @override
  String get homeMainChartCategoriesTitle =>
      'Categorie samenvatting voor huidige maand';

  @override
  String get homeMainChartDailyAvg => 'Gemiddelde van 7 dagen';

  @override
  String get homeMainChartDailyTitle => 'Dagelijks overzicht';

  @override
  String get homeMainChartNetEarningsTitle => 'Netto inkomen';

  @override
  String get homeMainChartNetWorthTitle => 'Nettowaarde';

  @override
  String get homeMainChartTagsTitle => 'Tag samenvatting voor huidige maand';

  @override
  String get homePiggyAdjustDialogTitle => 'Gespaard/uitgeven geld';

  @override
  String homePiggyDateStart(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Begindatum: $dateString';
  }

  @override
  String homePiggyDateTarget(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Doeldatum: $dateString';
  }

  @override
  String get homeMainDialogSettingsTitle => 'Dashboard aanpassen';

  @override
  String homePiggyLinked(String account) {
    return 'Gekoppeld aan $account';
  }

  @override
  String get homePiggyNoAccounts => 'Geen spaarpotjes opgezet.';

  @override
  String get homePiggyNoAccountsSubtitle => 'Maak wat aan in het webinterface!';

  @override
  String homePiggyRemaining(String amount) {
    return 'Nog te sparen: $amount';
  }

  @override
  String homePiggySaved(String amount) {
    return 'Tot nu toe gespaard: $amount';
  }

  @override
  String get homePiggySavedMultiple => 'Tot nu toe gespaard:';

  @override
  String homePiggyTarget(String amount) {
    return 'Doelbedrag: $amount';
  }

  @override
  String get homePiggyAccountStatus => 'Rekeningstatus';

  @override
  String get homePiggyAvailableAmounts => 'Beschikbaar bedrag';

  @override
  String homePiggyAvailable(String amount) {
    return 'Beschikbaar: $amount';
  }

  @override
  String homePiggyInPiggyBanks(String amount) {
    return 'In spaarpotjes: $amount';
  }

  @override
  String get homeTabLabelBalance => 'Balans';

  @override
  String get homeTabLabelMain => 'Hoofd';

  @override
  String get homeTabLabelPiggybanks => 'Spaarpotjes';

  @override
  String get homeTabLabelTransactions => 'Transacties';

  @override
  String get homeTransactionsActionFilter => 'Filter lijst';

  @override
  String get homeTransactionsDialogFilterAccountsAll => '<Alle Rekeningen>';

  @override
  String get homeTransactionsDialogFilterBillsAll => '<Alle Abonnementen>';

  @override
  String get homeTransactionsDialogFilterBillUnset =>
      '<Geen abonnement ingesteld>';

  @override
  String get homeTransactionsDialogFilterBudgetsAll => '<Alle Budgets>';

  @override
  String get homeTransactionsDialogFilterBudgetUnset =>
      '<Geen budget ingesteld>';

  @override
  String get homeTransactionsDialogFilterCategoriesAll => '<Alle categorieën>';

  @override
  String get homeTransactionsDialogFilterCategoryUnset =>
      '<Geen categorie ingesteld>';

  @override
  String get homeTransactionsDialogFilterCurrenciesAll => '<Alle Valuta>';

  @override
  String get homeTransactionsDialogFilterDateRange => 'Datum bereik';

  @override
  String get homeTransactionsDialogFilterFutureTransactions =>
      'Toon toekomstige transacties';

  @override
  String get homeTransactionsDialogFilterSearch => 'Zoekterm';

  @override
  String get homeTransactionsDialogFilterTitle => 'Filters kiezen';

  @override
  String get homeTransactionsEmpty => 'Geen transacties gevonden.';

  @override
  String homeTransactionsMultipleCategories(int num) {
    return '$num categorieën';
  }

  @override
  String get homeTransactionsSettingsShowTags => 'Toon tags in transactielijst';

  @override
  String get liabilityDirectionCredit => 'Ik heb deze schuld te goed.';

  @override
  String get liabilityDirectionDebit => 'Ik ben deze schuld verschuldigd';

  @override
  String get liabilityTypeDebt => 'Schuld';

  @override
  String get liabilityTypeLoan => 'Lening';

  @override
  String get liabilityTypeMortgage => 'Hypotheek';

  @override
  String get loginAbout =>
      'Om Waterfly III productief te gebruiken, heb je je eigen server nodig met een Firefly III-installatie of de Firefly III-add-on voor Home Assistant.\n\nVoer de volledige URL en ook een persoonlijke toegangstoken in (Instellingen -> Profiel -> OAuth -> Persoonlijke Toegang) hieronder in.';

  @override
  String get loginFormLabelAPIKey => 'Geldige API-sleutel';

  @override
  String get loginFormLabelHost => 'Host-URL';

  @override
  String get loginWelcome => 'Welkom bij Waterfly III';

  @override
  String get logoutConfirmation => 'Weet u zeker dat u zich wilt afmelden?';

  @override
  String get navigationAccounts => 'Rekeningen';

  @override
  String get navigationBills => 'Abonnementen';

  @override
  String get navigationCategories => 'Categorieën';

  @override
  String get navigationMain => 'Hoofd Dashboard';

  @override
  String get generalSettings => 'Instellingen';

  @override
  String get no => 'Nee';

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

    return '$percString van $of';
  }

  @override
  String get settingsDialogDebugInfo =>
      'U kunt debug logs hier inschakelen en versturen. Deze hebben een slechte invloed op de prestaties, dus schakel ze alstublieft niet in tenzij u aangeraden hebt. Logboekregistratie uitschakelen zal het opgeslagen logboek verwijderen.';

  @override
  String get settingsDialogDebugMailCreate => 'Maak e-mail';

  @override
  String get settingsDialogDebugMailDisclaimer =>
      'WAARSCHUWING: Een concept voor e-mail opent met het bijgevoegde logbestand (in tekstformaat). De logs kunnen gevoelige informatie bevatten, zoals de hostnaam van je Firefly (hoewel ik probeer te vermijden om geheimen te loggen, zoals de api sleutel). Lees het logboek zorgvuldig door en censureert alle informatie die je niet wilt delen en/of niet relevant is voor het probleem dat je wilt melden.\n\nGelieve geen logs te versturen zonder voorafgaande toestemming via mail/GitHub om dit te doen. Ik zal alle logs verwijderen die zijn verzonden vanwege privacyredenen. Upload de log nooit ongecensureerd naar GitHub of elders.';

  @override
  String get settingsDialogDebugSendButton => 'Logs versturen via e-mail';

  @override
  String get settingsDialogDebugTitle => 'Logs voor Foutoplossing';

  @override
  String get settingsDialogLanguageTitle => 'Taal selecteren';

  @override
  String get settingsDialogThemeTitle => 'Selecteer een thema';

  @override
  String get settingsFAQ => 'Veelgestelde vragen (FAQ)';

  @override
  String get settingsFAQHelp =>
      'Opent in browser. Alleen beschikbaar in het Engels.';

  @override
  String get settingsLanguage => 'Taal';

  @override
  String get settingsLockscreen => 'Vergrendelscherm';

  @override
  String get settingsLockscreenHelp =>
      'Authenticatie vereist bij opstarten van de app';

  @override
  String get settingsLockscreenInitial =>
      'Authenticeer a.u.b. om het vergrendelscherm in te schakelen.';

  @override
  String get settingsNLAppAccount => 'Standaard account';

  @override
  String get settingsNLAppAccountDynamic => '<Dynamic>';

  @override
  String get settingsNLAppAdd => 'App toevoegen';

  @override
  String get settingsNLAppAddHelp =>
      'Klik om een app toe te voegen om naar te luisteren. Alleen geschikte apps worden weergegeven in de lijst.';

  @override
  String get settingsNLAppAddInfo =>
      'Maak enkele transacties waar je telefoonmeldingen ontvangt om apps toe te voegen aan deze lijst. Als de app nog steeds niet verschijnt, rapporteer deze dan aan app@vogt.pw.';

  @override
  String get settingsNLAutoAdd => 'Transactie zonder interactie maken';

  @override
  String get settingsNLDescription =>
      'Deze service stelt u in staat om transactiegegevens op te halen van inkomende push-meldingen. Daarnaast kunt u een standaard account selecteren waaraan de transactie moet worden toegewezen - als er geen waarde is ingesteld. het probeert een account uit de melding te halen.';

  @override
  String get settingsNLEmptyNote => 'Houd notitie veld leeg';

  @override
  String get settingsNLPermissionGrant => 'Klik hier om toestemming te geven.';

  @override
  String get settingsNLPermissionNotGranted => 'Toestemming niet verleend.';

  @override
  String get settingsNLPermissionRemove => 'Verwijder toestemming?';

  @override
  String get settingsNLPermissionRemoveHelp =>
      'Om deze service uit te schakelen, klik op de app en verwijder de machtigingen op het volgende scherm.';

  @override
  String get settingsNLPrefillTXTitle =>
      'Transactietitel vooraf invullen met meldingstitel';

  @override
  String get settingsNLServiceChecking => 'Status controleren…';

  @override
  String settingsNLServiceCheckingError(String error) {
    return 'Fout bij controleren status: $error';
  }

  @override
  String get settingsNLServiceRunning => 'De service wordt uitgevoerd';

  @override
  String get settingsNLServiceStatus => 'Service Status';

  @override
  String get settingsNLServiceStopped => 'Service is gestopt.';

  @override
  String get settingsNotificationListener => 'Notificatie Luister Service';

  @override
  String get settingsTheme => 'Applicatie thema';

  @override
  String get settingsThemeDynamicColors => 'Dynamische kleuren';

  @override
  String settingsThemeValue(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'dark': 'Donkere modus',
      'light': 'Licht Modus',
      'other': 'Systeem standaard',
    });
    return '$_temp0';
  }

  @override
  String get settingsUseServerTimezone => 'Gebruik server tijdzone';

  @override
  String get settingsUseServerTimezoneHelp =>
      'Laat alle tijden zien in de server tijdzone. Dit geeft het gedrag van de webinterface weer.';

  @override
  String get settingsVersion => 'App versie';

  @override
  String get settingsVersionChecking => 'controleren...';

  @override
  String get transactionAttachments => 'Bijlagen';

  @override
  String get transactionDeleteConfirm =>
      'Weet u zeker dat u deze transactie wil verwijderen?';

  @override
  String get transactionDialogAttachmentsDelete => 'Bijlage verwijderen';

  @override
  String get transactionDialogAttachmentsDeleteConfirm =>
      'Weet je zeker dat je deze bijlage wilt verwijderen?';

  @override
  String get transactionDialogAttachmentsErrorDownload =>
      'Kan het bestand niet downloaden.';

  @override
  String transactionDialogAttachmentsErrorOpen(String error) {
    return 'Kan het bestand niet openen: $error';
  }

  @override
  String transactionDialogAttachmentsErrorUpload(String error) {
    return 'Kan bestand niet uploaden: $error';
  }

  @override
  String get transactionDialogAttachmentsTitle => 'Bijlagen';

  @override
  String get transactionDialogBillNoBill => 'Geen abonnement';

  @override
  String get transactionDialogBillTitle => 'Link naar abonnement';

  @override
  String get transactionDialogCurrencyTitle => 'Selecteer valuta';

  @override
  String get transactionDialogPiggyNoPiggy => 'No Piggy Bank';

  @override
  String get transactionDialogPiggyTitle => 'Link to Piggy Bank';

  @override
  String get transactionDialogTagsAdd => 'Label toevoegen';

  @override
  String get transactionDialogTagsHint => 'Labels zoeken/toevoegen';

  @override
  String get transactionDialogTagsTitle => 'Selecteer labels';

  @override
  String get transactionDuplicate => 'Dupliceer';

  @override
  String get transactionErrorInvalidAccount => 'Ongeldige rekening';

  @override
  String get transactionErrorInvalidBudget => 'Ongeldig budget';

  @override
  String get transactionErrorNoAccounts => 'Vul eerst de rekeningen in.';

  @override
  String get transactionErrorNoAssetAccount => 'Selecteer een betaalrekening.';

  @override
  String get transactionErrorTitle => 'Voer een titel in.';

  @override
  String get transactionFormLabelAccountDestination => 'Doelrekening';

  @override
  String get transactionFormLabelAccountForeign => 'Vreemde rekeningen';

  @override
  String get transactionFormLabelAccountOwn => 'Eigen Account';

  @override
  String get transactionFormLabelAccountSource => 'Bron account';

  @override
  String get transactionFormLabelNotes => 'Notitie';

  @override
  String get transactionFormLabelTags => 'Tags';

  @override
  String get transactionFormLabelTitle => 'Transactie naam';

  @override
  String get transactionSplitAdd => 'Afsplitsing transactie toevoegen';

  @override
  String get transactionSplitChangeCurrency => 'Verander Split Valuta';

  @override
  String get transactionSplitChangeDestinationAccount =>
      'Verander Split-Doelaccount';

  @override
  String get transactionSplitChangeSourceAccount => 'Wijzig Split-Bron Account';

  @override
  String get transactionSplitChangeTarget => 'Verander Split-doelaccount';

  @override
  String get transactionSplitDelete => 'Afsplitsing verwijderen';

  @override
  String get transactionTitleAdd => 'Transactie toevoegen';

  @override
  String get transactionTitleDelete => 'Verwijder Transactie';

  @override
  String get transactionTitleEdit => 'Bewerk Transactie';

  @override
  String get transactionTypeDeposit => 'Storten';

  @override
  String get transactionTypeTransfer => 'Transactie';

  @override
  String get transactionTypeWithdrawal => 'Opname';
}
