// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class SDa extends S {
  SDa([String locale = 'da']) : super(locale);

  @override
  String get accountRoleAssetCashWallet => 'Kontantstegnebog';

  @override
  String get accountRoleAssetCC => 'Kreditkort';

  @override
  String get accountRoleAssetDefault => 'Standard aktivkonto';

  @override
  String get accountRoleAssetSavings => 'Opsparingskonto';

  @override
  String get accountRoleAssetShared => 'Delt aktivkonto';

  @override
  String get accountsLabelAsset => 'Aktivkonti';

  @override
  String get accountsLabelExpense => 'Udgiftskonti';

  @override
  String get accountsLabelLiabilities => 'Gældsforpligtelser';

  @override
  String get accountsLabelRevenue => 'Indtægtskonti';

  @override
  String accountsLiabilitiesInterest(double interest, String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'uge',
      'monthly': 'måned',
      'quarterly': 'kvartal',
      'halfyear': 'halvår',
      'yearly': 'år',
      'other': 'ukendt',
    });
    return '$interest% renter per $_temp0';
  }

  @override
  String billsAmountAndFrequency(
    String minValue,
    String maxvalue,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'ugentligt',
      'monthly': 'månedligt',
      'quarterly': 'kvartalsvis',
      'halfyear': 'halvårligt',
      'yearly': 'årligt',
      'other': 'ukendt',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', springer over $skip',
      zero: '',
    );
    return 'Abonnement matcher transaktioner mellem $minValue og $maxvalue. Gentages $_temp0$_temp1.';
  }

  @override
  String get billsChangeLayoutTooltip => 'Skift layout';

  @override
  String get billsChangeSortOrderTooltip => 'Skift sorteringsrækkefølge';

  @override
  String get billsErrorLoading => 'Fejl ved indlæsning af abonnementer.';

  @override
  String billsExactAmountAndFrequency(
    String value,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'ugentligt',
      'monthly': 'månedligt',
      'quarterly': 'kvartalsvis',
      'halfyear': 'halvårligt',
      'yearly': 'årligt',
      'other': 'ukendt',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', springer over $skip',
      zero: '',
    );
    return 'Abonnement matcher transaktioner af $value. Gentages $_temp0$_temp1.';
  }

  @override
  String billsExpectedOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Forventet $dateString';
  }

  @override
  String billsFrequency(String frequency) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Ugentlig',
      'monthly': 'Månedlig',
      'quarterly': 'Kvartalsvis',
      'halfyear': 'Halvårlig',
      'yearly': 'Årlig',
      'other': 'Ukendt',
    });
    return '$_temp0';
  }

  @override
  String billsFrequencySkip(String frequency, num skip) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Ugentlig',
      'monthly': 'Månedlig',
      'quarterly': 'Kvartalsvis',
      'halfyear': 'Halvårlig',
      'yearly': 'Årlig',
      'other': 'Ukendt',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', springer over $skip',
      zero: '',
    );
    return '$_temp0$_temp1';
  }

  @override
  String get billsInactive => 'Inaktiv';

  @override
  String get billsIsActive => 'Abonnementet er aktivt';

  @override
  String get billsLayoutGroupSubtitle =>
      'Abonnementer vises i deres tildelte grupper.';

  @override
  String get billsLayoutGroupTitle => 'Gruppe';

  @override
  String get billsLayoutListSubtitle =>
      'Abonnementer vises på en liste sorteret efter bestemte kriterier.';

  @override
  String get billsLayoutListTitle => 'Liste';

  @override
  String get billsListEmpty => 'Listen er i øjeblikket tom.';

  @override
  String get billsNextExpectedMatch => 'Næste forventede match';

  @override
  String get billsNotActive => 'Abonnementet er inaktivt';

  @override
  String get billsNotExpected => 'Ikke forventet i denne periode';

  @override
  String get billsNoTransactions => 'Ingen transaktioner fundet.';

  @override
  String billsPaidOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Betalt $dateString';
  }

  @override
  String get billsSortAlphabetical => 'Alfabetisk';

  @override
  String get billsSortByTimePeriod => 'Efter tidsperiode';

  @override
  String get billsSortFrequency => 'Frekvens';

  @override
  String get billsSortName => 'Navn';

  @override
  String get billsUngrouped => 'Ugrupperede';

  @override
  String get billsSettingsShowOnlyActive => 'Vis kun aktive';

  @override
  String get billsSettingsShowOnlyActiveDesc =>
      'Viser kun aktive abonnementer.';

  @override
  String get billsSettingsShowOnlyExpected => 'Vis kun forventede';

  @override
  String get billsSettingsShowOnlyExpectedDesc =>
      'Viser kun de abonnementer, der forventes (eller er betalt) denne måned.';

  @override
  String get categoryDeleteConfirm =>
      'Er du sikker på, at du vil slette denne kategori? Transaktionerne vil ikke blive slettet, men vil ikke længere have en kategori.';

  @override
  String get categoryErrorLoading => 'Fejl ved indlæsning af kategorier.';

  @override
  String get categoryFormLabelIncludeInSum => 'Medregn i månedlig sum';

  @override
  String get categoryFormLabelName => 'Kategorinavn';

  @override
  String get categoryMonthNext => 'Næste måned';

  @override
  String get categoryMonthPrev => 'Sidste måned';

  @override
  String get categorySumExcluded => 'udelukket';

  @override
  String get categoryTitleAdd => 'Tilføj kategori';

  @override
  String get categoryTitleDelete => 'Slet kategori';

  @override
  String get categoryTitleEdit => 'Redigér kategori';

  @override
  String get catNone => '<ingen kategori>';

  @override
  String get catOther => 'Andet';

  @override
  String errorAPIInvalidResponse(String message) {
    return 'Ugyldigt svar fra API: $message';
  }

  @override
  String get errorAPIUnavailable => 'API utilgængelig';

  @override
  String get errorFieldRequired => 'Dette felt er påkrævet.';

  @override
  String get errorInvalidURL => 'Ugyldig URL';

  @override
  String errorMinAPIVersion(String requiredVersion) {
    return 'Minimum Firefly API-version v$requiredVersion påkrævet. Opgradér venligst.';
  }

  @override
  String errorStatusCode(int code) {
    return 'Statuskode: $code';
  }

  @override
  String get errorUnknown => 'Ukendt fejl.';

  @override
  String get formButtonHelp => 'Hjælp';

  @override
  String get formButtonLogin => 'Log ind';

  @override
  String get formButtonLogout => 'Log ud';

  @override
  String get formButtonRemove => 'Fjern';

  @override
  String get formButtonResetLogin => 'Nulstil login';

  @override
  String get formButtonTransactionAdd => 'Tilføj transaktion';

  @override
  String get formButtonTryAgain => 'Prøv igen';

  @override
  String get generalAccount => 'Konto';

  @override
  String get generalAssets => 'Aktiver';

  @override
  String get generalBalance => 'Saldo';

  @override
  String generalBalanceOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Saldo på $dateString';
  }

  @override
  String get generalBill => 'Regning';

  @override
  String get generalBudget => 'Budgetter';

  @override
  String get generalCategory => 'Kategori';

  @override
  String get generalCurrency => 'Valuta';

  @override
  String get generalDateRangeCurrentMonth => 'Nuværende måned';

  @override
  String get generalDateRangeLast30Days => 'Sidste 30 dage';

  @override
  String get generalDateRangeCurrentYear => 'Nuværende år';

  @override
  String get generalDateRangeLastYear => 'Sidste år';

  @override
  String get generalDateRangeAll => 'Alle';

  @override
  String get generalDefault => 'standard';

  @override
  String get generalDestinationAccount => 'Destinationskonto';

  @override
  String get generalDismiss => 'Afvis';

  @override
  String get generalEarned => 'Optjent';

  @override
  String get generalError => 'Fejl';

  @override
  String get generalExpenses => 'Udgifter';

  @override
  String get generalIncome => 'Indtægter';

  @override
  String get generalLeft => 'Left';

  @override
  String get generalLiabilities => 'Gældsforpligtelser';

  @override
  String get generalMultiple => 'flere';

  @override
  String get generalNever => 'aldrig';

  @override
  String get generalReconcile => 'Afstemt';

  @override
  String get generalReset => 'Nulstil';

  @override
  String get generalSourceAccount => 'Kildekonto';

  @override
  String get generalSpent => 'Brugt';

  @override
  String get generalSum => 'I alt';

  @override
  String get generalTarget => 'Mål';

  @override
  String get generalUnknown => 'Ukendt';

  @override
  String get homeMainActionPrivacyMode =>
      'Show/Hide all amounts (Privacy Mode)';

  @override
  String homeMainBillsInterval(String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'ugentligt',
      'monthly': 'månedligt',
      'quarterly': 'kvartalsvis',
      'halfyear': 'halvårligt',
      'yearly': 'årligt',
      'other': 'ukendt',
    });
    return '($_temp0)';
  }

  @override
  String get homeMainBillsTitle => 'Regninger for næste uge';

  @override
  String homeMainBudgetInterval(DateTime from, DateTime to, String period) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return '($fromString til $toString, $period)';
  }

  @override
  String homeMainBudgetIntervalSingle(DateTime from, DateTime to) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return '($fromString til $toString)';
  }

  @override
  String homeMainBudgetSum(String current, String status, String available) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'over': 'over',
      'other': 'tilbage af',
    });
    return '$current$_temp0 $available';
  }

  @override
  String get homeMainBudgetTitle => 'Budgetter for denne måned';

  @override
  String get homeMainChartAccountsTitle => 'Kontooversigt';

  @override
  String get homeMainChartCategoriesTitle => 'Kategorioversigt for denne måned';

  @override
  String get homeMainChartDailyAvg => '7 dages-gennemsnit';

  @override
  String get homeMainChartDailyTitle => 'Dagsoversigt';

  @override
  String get homeMainChartNetEarningsTitle => 'Nettoindtjening';

  @override
  String get homeMainChartNetWorthTitle => 'Nettoværdi';

  @override
  String get homeMainChartTagsTitle => 'Tag-oversigt for nuværende måned';

  @override
  String get homePiggyAdjustDialogTitle => 'Gem/brug penge';

  @override
  String homePiggyDateStart(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Startdato: $dateString';
  }

  @override
  String homePiggyDateTarget(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Måldato: $dateString';
  }

  @override
  String get homeMainDialogSettingsTitle => 'Tilpas Dashboard';

  @override
  String homePiggyLinked(String account) {
    return 'Knyttet til $account';
  }

  @override
  String get homePiggyNoAccounts => 'Ingen sparegris er sat op.';

  @override
  String get homePiggyNoAccountsSubtitle => 'Opret nogle i webgrænsefladen!';

  @override
  String homePiggyRemaining(String amount) {
    return 'Mangler at spare: $amount';
  }

  @override
  String homePiggySaved(String amount) {
    return 'Gemt indtil videre: $amount';
  }

  @override
  String homePiggySavePerMonth(String amount) {
    return 'Save per month: $amount';
  }

  @override
  String get homePiggySavedMultiple => 'Opsparet indtil videre:';

  @override
  String homePiggyTarget(String amount) {
    return 'Målbeløb: $amount';
  }

  @override
  String get homePiggyAccountStatus => 'Kontostatus';

  @override
  String get homePiggyAvailableAmounts => 'Tilgængelige beløb';

  @override
  String homePiggyAvailable(String amount) {
    return 'Tilgængelig: $amount';
  }

  @override
  String homePiggyInPiggyBanks(String amount) {
    return 'I sparegrise: $amount';
  }

  @override
  String homePiggyTotal(String amount) {
    return 'Total: $amount';
  }

  @override
  String get homeTabLabelBalance => 'Balance';

  @override
  String get homeTabLabelMain => 'Primær';

  @override
  String get homeTabLabelPiggybanks => 'Sparegrise';

  @override
  String get homeTabLabelTransactions => 'Transaktioner';

  @override
  String get homeTransactionsActionFilter => 'Filterliste';

  @override
  String get homeTransactionsDialogFilterAccountsAll => '<Alle konti>';

  @override
  String get homeTransactionsDialogFilterBillsAll => '<All Bills>';

  @override
  String get homeTransactionsDialogFilterBillUnset => '<No Bill set>';

  @override
  String get homeTransactionsDialogFilterBudgetsAll => '<Alle budgetter>';

  @override
  String get homeTransactionsDialogFilterBudgetUnset =>
      '<Intet budget tildelt>';

  @override
  String get homeTransactionsDialogFilterCategoriesAll => '<Alle kategorier>';

  @override
  String get homeTransactionsDialogFilterCategoryUnset =>
      '<Ingen kategori tildelt>';

  @override
  String get homeTransactionsDialogFilterCurrenciesAll => '<Alle valutaer>';

  @override
  String get homeTransactionsDialogFilterDateRange => 'Datointerval';

  @override
  String get homeTransactionsDialogFilterFutureTransactions =>
      'Vis fremtidige transaktioner';

  @override
  String get homeTransactionsDialogFilterSearch => 'Søgeord';

  @override
  String get homeTransactionsDialogFilterTitle => 'Vælg filtre';

  @override
  String get homeTransactionsEmpty => 'Ingen transaktioner fundet.';

  @override
  String homeTransactionsMultipleCategories(int num) {
    return '$num kategorier';
  }

  @override
  String get homeTransactionsSettingsShowTags =>
      'Vis tags på transaktionslisten';

  @override
  String get liabilityDirectionCredit => 'Jeg er skyldt denne gæld';

  @override
  String get liabilityDirectionDebit => 'Jeg skylder denne gæld';

  @override
  String get liabilityTypeDebt => 'Gæld';

  @override
  String get liabilityTypeLoan => 'Lån';

  @override
  String get liabilityTypeMortgage => 'Boliglån';

  @override
  String get loginAbout =>
      'For at bruge Waterfly III produktivt har du brug for din egen server med en Firefly III-instans eller Firefly II-add-on til Home Assistant.\n\nIndtast venligst det fulde URL samt en personlig adgangstoken (Indstillinger -> Profil -> OAuth -> Personlig adgangstoken) nedenfor.';

  @override
  String get loginFormButtonHideHeaders => 'Skjul headere';

  @override
  String get loginFormButtonShowHeaders => 'Brugerdefinerede headere';

  @override
  String get loginFormLabelAPIKey => 'Gyldig API-nøgle';

  @override
  String get loginFormLabelHeaders => 'Brugerdefinerede headere (valgfri)';

  @override
  String get loginFormLabelHeadersHelp =>
      'Én pr. linje, format: HeaderNavn: værdi';

  @override
  String get loginFormLabelHost => 'Værts-URL';

  @override
  String get loginWelcome => 'Velkommen til Waterfly III';

  @override
  String get logoutConfirmation => 'Er du sikker på, at du vil logge ud?';

  @override
  String get navigationAccounts => 'Konti';

  @override
  String get navigationBills => 'Abonnementer';

  @override
  String get navigationCategories => 'Kategorier';

  @override
  String get navigationMain => 'Oversigt';

  @override
  String get generalSettings => 'Indstillinger';

  @override
  String get no => 'Nej';

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

    return '$percString af $of';
  }

  @override
  String get settingsDialogDebugInfo =>
      'Du kan aktivere og sende fejfindingslogs her. Disse har en dårlig indvirkning på ydeevnen, så du skal venligst ikke aktivere dem, medmindre du rådes til at gøre det. Deaktivering af logning vil slette den gemte log.';

  @override
  String get settingsDialogDebugMailCreate => 'Opret mail';

  @override
  String get settingsDialogDebugMailDisclaimer =>
      'ADVARSEL: En mailkladde åbnes med logfilen vedhæftet (i tekstformat). Logfilerne kan indeholdet følsomme oplysninger, såsom værtsnavnet på din Firefly instans (selvom jeg forsøger at undgå logning af eventuelle hemmeligheder, såsom api-nøgle). Læs venligst loggen grundigt og censurér alle oplysninger, du ikke ønsker at dele og/eller ikke er relevante for det problem, du ønsker at rapportere.';

  @override
  String get settingsDialogDebugSendButton => 'Send logfiler via e-mail';

  @override
  String get settingsDialogDebugTitle => 'Fejlfindingslogs';

  @override
  String get settingsDialogLanguageTitle => 'Vælg sprog';

  @override
  String get settingsDialogThemeTitle => 'Vælg tema';

  @override
  String get settingsFAQ => 'Ofte stillede spørgsmål';

  @override
  String get settingsFAQHelp =>
      'Åbnes i browseren. Kun tilgængelig på engelsk.';

  @override
  String get settingsLanguage => 'Sprog';

  @override
  String get settingsLockscreen => 'Låst skærm';

  @override
  String get settingsLockscreenHelp => 'Require authentication on app startup';

  @override
  String get settingsLockscreenInitial =>
      'Godkend venligst for at aktivere skærmlåsning.';

  @override
  String get settingsNLDescription =>
      'Denne tjeneste giver dig mulighed for at hente transaktionsoplysninger fra indgående push-notifikationer. Derudover kan du vælge en standardkonto, som transaktionen skal tildeles til - hvis ingen værdi er angivet, vil den prøve at udtrække en konto fra notifikationen.';

  @override
  String get settingsNLPermissionNotGranted => 'Tilladelse ikke givet.';

  @override
  String get settingsNLServiceChecking => 'Tjekker status…';

  @override
  String get settingsNLServiceCheckingTitle => 'Checking notification access';

  @override
  String settingsNLServiceCheckingError(String error) {
    return 'Fejl under kontrol af status: $error';
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
  String get settingsNLServiceRunning => 'Tjenesten kører.';

  @override
  String get settingsNLServiceStatus => 'Tjenestestatus';

  @override
  String get settingsNLServiceStopped => 'Tjenesten er stoppet.';

  @override
  String get settingsNotificationListener => 'Notifikationslytter-service';

  @override
  String get settingsServerConnection => 'Serverforbindelse';

  @override
  String get settingsServerConnectionUpdated =>
      'Forbindelsesindstillinger opdateret.';

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
  String get settingsTheme => 'App tema';

  @override
  String get settingsThemeDynamicColors => 'Dynamisk farve';

  @override
  String settingsThemeValue(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'dark': 'Mørk tilstand',
      'light': 'Lys tilstand',
      'other': 'Systemstandard',
    });
    return '$_temp0';
  }

  @override
  String get settingsUseServerTimezone => 'Brug serverens tidszone';

  @override
  String get settingsUseServerTimezoneHelp =>
      'Vis alle gange i serverens tidszone. Dette efterligner webgrænsefladens opførsel.';

  @override
  String get settingsVersion => 'Appversion';

  @override
  String get settingsVersionChecking => 'tjekker…';

  @override
  String get tagNone => '<no tag>';

  @override
  String get transactionAttachments => 'Bilag';

  @override
  String get transactionDeleteConfirm =>
      'Er du sikker på, at du vil slette denne transaktion?';

  @override
  String get transactionDialogAttachmentsDelete => 'Slet bilag';

  @override
  String get transactionDialogAttachmentsDeleteConfirm =>
      'Er du sikker på, at du vil slette dette bilag?';

  @override
  String get transactionDialogAttachmentsErrorDownload =>
      'Kunne ikke downloade fil.';

  @override
  String transactionDialogAttachmentsErrorOpen(String error) {
    return 'Kunne ikke åbne fil: $error';
  }

  @override
  String transactionDialogAttachmentsErrorUpload(String error) {
    return 'Kunne ikke uploade fil: $error';
  }

  @override
  String get transactionDialogAttachmentsTitle => 'Bilag';

  @override
  String get transactionDialogBillNoBill => 'Ingen regning';

  @override
  String get transactionDialogBillTitle => 'Link til regning';

  @override
  String get transactionDialogCurrencyTitle => 'Vælg valuta';

  @override
  String get transactionDialogPiggyNoPiggy => 'Ingen opsparingsmål';

  @override
  String get transactionDialogPiggyTitle => 'Knyt til opsparingsmål';

  @override
  String get transactionDialogTagsAdd => 'Tilføj etiket';

  @override
  String get transactionDialogTagsHint => 'Søg/Tilføj Tag';

  @override
  String get transactionDialogTagsTitle => 'Vælg etiketter';

  @override
  String get transactionDuplicate => 'Duplikér';

  @override
  String get transactionErrorInvalidAccount => 'Ugyldig konto';

  @override
  String get transactionErrorInvalidBudget => 'Ugyldigt Budget';

  @override
  String get transactionErrorNoAccounts => 'Udfyld venligst konti først.';

  @override
  String get transactionErrorNoAssetAccount => 'Vælg venligst en aktivkonto.';

  @override
  String get transactionErrorTitle => 'Angiv venligst en titel.';

  @override
  String get transactionFormLabelAccountDestination => 'Destinationskonto';

  @override
  String get transactionFormLabelAccountForeign => 'Fremmed konto';

  @override
  String get transactionFormLabelAccountOwn => 'Egen konto';

  @override
  String get transactionFormLabelAccountSource => 'Fra konto';

  @override
  String get transactionFormLabelNotes => 'Noter';

  @override
  String get transactionFormLabelTags => 'Etiketter';

  @override
  String get transactionFormLabelTitle => 'Transaktionstitel';

  @override
  String get transactionSplitAdd => 'Tilføj delt transaktion';

  @override
  String get transactionSplitChangeCurrency => 'Ændr delt valuta';

  @override
  String get transactionSplitChangeDestinationAccount =>
      'Skift destinationkonto for opdeling';

  @override
  String get transactionSplitChangeSourceAccount =>
      'Skift kildekonto for opdeling';

  @override
  String get transactionSplitChangeTarget => 'Ændr delt målkonto';

  @override
  String get transactionSplitDelete => 'Slet split';

  @override
  String get transactionTitleAdd => 'Tilføj transaktion';

  @override
  String get transactionTitleDelete => 'Slet transaktion';

  @override
  String get transactionTitleEdit => 'Redigér transaktion';

  @override
  String get transactionTypeDeposit => 'Indbetal';

  @override
  String get transactionTypeTransfer => 'Overfør';

  @override
  String get transactionTypeWithdrawal => 'Hævning';

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
  String get notificationsHistoryLoadMoreFailure =>
      'Earlier notifications could not be loaded.';

  @override
  String get notificationsHistoryLoadMoreRetry => 'Retry';

  @override
  String get notificationsHistoryToday => 'Today';

  @override
  String get notificationsHistoryYesterday => 'Yesterday';

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
