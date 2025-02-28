// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovenian (`sl`).
class SSl extends S {
  SSl([String locale = 'sl']) : super(locale);

  @override
  String get accountRoleAssetCashWallet => 'Gotovina';

  @override
  String get accountRoleAssetCC => 'Kreditna kartica';

  @override
  String get accountRoleAssetDefault => 'Privzeti premoženjski račun';

  @override
  String get accountRoleAssetSavings => 'Varčevalni račun';

  @override
  String get accountRoleAssetShared => 'Skupni račun sredstev';

  @override
  String get accountsLabelAsset => 'Računi sredstev';

  @override
  String get accountsLabelExpense => 'Računi stroškov';

  @override
  String get accountsLabelLiabilities => 'Obveznosti';

  @override
  String get accountsLabelRevenue => 'Računi prihodkov';

  @override
  String accountsLiabilitiesInterest(double interest, String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'tedensko',
      'monthly': 'mesečno',
      'quarterly': 'četrtletno',
      'halfyear': 'polletno',
      'yearly': 'letno',
      'other': 'neznano',
    });
    return '$interest% obresti $_temp0';
  }

  @override
  String billsAmountAndFrequency(
    String minValue,
    String maxvalue,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'tedensko',
      'monthly': 'mesečno',
      'quarterly': 'četrtletno',
      'halfyear': 'polletno',
      'yearly': 'letno',
      'other': 'neznano',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', preskoči čez $skip',
      zero: '',
    );
    return 'Račun se ujema s transakcijami med $minValue in $maxvalue. Ponavlja se $_temp0$_temp1.';
  }

  @override
  String get billsChangeLayoutTooltip => 'Spremeni postavitev';

  @override
  String get billsChangeSortOrderTooltip => 'Spremeni vrstni red';

  @override
  String get billsErrorLoading => 'Napaka pri nalaganju transakcij.';

  @override
  String billsExactAmountAndFrequency(
    String value,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'tedensko',
      'monthly': 'mesečno',
      'quarterly': 'četrtletno',
      'halfyear': 'polletno',
      'yearly': 'letno',
      'other': 'neznano',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', preskoči čez $skip',
      zero: '',
    );
    return 'Račun se ujema s transakcijami v vrednosti $value. Ponavlja se $_temp0$_temp1.';
  }

  @override
  String billsExpectedOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Predvideno $dateString';
  }

  @override
  String billsFrequency(String frequency) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Tedensko',
      'monthly': 'Mesečno',
      'quarterly': 'Četrtletno',
      'halfyear': 'Polletno',
      'yearly': 'Letno',
      'other': 'Neznano',
    });
    return '$_temp0';
  }

  @override
  String billsFrequencySkip(String frequency, num skip) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Tedensko',
      'monthly': 'Mesečno',
      'quarterly': 'Četrtletno',
      'halfyear': 'Polletno',
      'yearly': 'Letno',
      'other': 'Neznano',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', preskoči čez $skip',
      zero: '',
    );
    return '$_temp0$_temp1';
  }

  @override
  String get billsInactive => 'Neaktiven';

  @override
  String get billsIsActive => 'Transakcija je aktivna';

  @override
  String get billsLayoutGroupSubtitle =>
      'Transakcije, prikazane v dodeljenih skupinah.';

  @override
  String get billsLayoutGroupTitle => 'Skupina';

  @override
  String get billsLayoutListSubtitle =>
      'Transakcije prikazane na seznamu, razvrščenem po določenih kriterijih.';

  @override
  String get billsLayoutListTitle => 'Seznam';

  @override
  String get billsListEmpty => 'Seznam je trenutno prazen.';

  @override
  String get billsNextExpectedMatch => 'Naslednje pričakovano ujemanje';

  @override
  String get billsNotActive => 'Transakcija ni aktivna';

  @override
  String get billsNotExpected => 'Ni pričakovano v tem obdobju';

  @override
  String get billsNoTransactions => 'Ni najdenih transakcij.';

  @override
  String billsPaidOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Plačano dne $dateString';
  }

  @override
  String get billsSortAlphabetical => 'Po abecedi';

  @override
  String get billsSortByTimePeriod => 'Po časovnem obdobju';

  @override
  String get billsSortFrequency => 'Pogostost';

  @override
  String get billsSortName => 'Naziv';

  @override
  String get billsUngrouped => 'Nezdruženo';

  @override
  String get categoryDeleteConfirm =>
      'Ali ste prepričani, da želite izbrisati to kategorijo? Transakcije ne bodo izbrisane, vendar ne bodo imele več kategorije.';

  @override
  String get categoryErrorLoading => 'Napaka pri nalaganju kategorij.';

  @override
  String get categoryFormLabelIncludeInSum => 'Vključi v mesečni znesek';

  @override
  String get categoryFormLabelName => 'Ime kategorije';

  @override
  String get categoryMonthNext => 'Naslednji mesec';

  @override
  String get categoryMonthPrev => 'Prejšnji mesec';

  @override
  String get categorySumExcluded => 'izvzeto';

  @override
  String get categoryTitleAdd => 'Dodaj kategorijo';

  @override
  String get categoryTitleDelete => 'Izbriši kategorijo';

  @override
  String get categoryTitleEdit => 'Uredi kategorijo';

  @override
  String get catNone => '<brez kategorije>';

  @override
  String get catOther => 'Ostalo';

  @override
  String errorAPIInvalidResponse(String message) {
    return 'Neveljaven odgovor API-ja: $message';
  }

  @override
  String get errorAPIUnavailable => 'API ni na voljo';

  @override
  String get errorFieldRequired => 'To polje je obvezno.';

  @override
  String get errorInvalidURL => 'Neveljaven URL';

  @override
  String errorMinAPIVersion(String requiredVersion) {
    return 'Zahtevana najmanjša različica Firefly API je v$requiredVersion. Prosimo nadgradite.';
  }

  @override
  String errorStatusCode(int code) {
    return 'Statusna koda: $code';
  }

  @override
  String get errorUnknown => 'Neznana napaka.';

  @override
  String get formButtonHelp => 'Pomoč';

  @override
  String get formButtonLogin => 'Prijava';

  @override
  String get formButtonLogout => 'Odjava';

  @override
  String get formButtonRemove => 'Odstrani';

  @override
  String get formButtonResetLogin => 'Ponastavi prijavo';

  @override
  String get formButtonTransactionAdd => 'Dodaj transakcijo';

  @override
  String get formButtonTryAgain => 'Poskusite znova';

  @override
  String get generalAccount => 'Račun';

  @override
  String get generalAssets => 'Sredstva';

  @override
  String get generalBalance => 'Stanje';

  @override
  String generalBalanceOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Stanje na $dateString';
  }

  @override
  String get generalBill => 'Račun';

  @override
  String get generalBudget => 'Proračun';

  @override
  String get generalCategory => 'Kategorija';

  @override
  String get generalCurrency => 'Valuta';

  @override
  String get generalDefault => 'privzeto';

  @override
  String get generalDestinationAccount => 'Destination Account';

  @override
  String get generalDismiss => 'Opusti';

  @override
  String get generalEarned => 'Prisluženo';

  @override
  String get generalError => 'Napaka';

  @override
  String get generalExpenses => 'Stroški';

  @override
  String get generalIncome => 'Prihodek';

  @override
  String get generalLiabilities => 'Obveznosti';

  @override
  String get generalMultiple => 'več';

  @override
  String get generalNever => 'nikoli';

  @override
  String get generalReconcile => 'Usklajeno';

  @override
  String get generalReset => 'Ponastavi';

  @override
  String get generalSourceAccount => 'Source Account';

  @override
  String get generalSpent => 'Porabljeno';

  @override
  String get generalSum => 'Vsota';

  @override
  String get generalTarget => 'Ciljni';

  @override
  String get generalUnknown => 'Neznano';

  @override
  String homeMainBillsInterval(String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'tedensko',
      'monthly': 'mesečno',
      'quarterly': 'četrtletno',
      'halfyear': 'polletno',
      'yearly': 'letno',
      'other': 'neznano',
    });
    return ' ($_temp0)';
  }

  @override
  String get homeMainBillsTitle => 'Računi za naslednji teden';

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
      'over': 'čez',
      'other': 'ostane še',
    });
    return '$current $_temp0 $available';
  }

  @override
  String get homeMainBudgetTitle => 'Proračuni za tekoči mesec';

  @override
  String get homeMainChartAccountsTitle => 'Povzetek računa';

  @override
  String get homeMainChartCategoriesTitle =>
      'Povzetek kategorij za tekoči mesec';

  @override
  String get homeMainChartDailyAvg => 'Povprečno 7 dni';

  @override
  String get homeMainChartDailyTitle => 'Dnevno povprečje';

  @override
  String get homeMainChartNetEarningsTitle => 'Neto zaslužek';

  @override
  String get homeMainChartNetWorthTitle => 'Neto vrednost';

  @override
  String get homePiggyAdjustDialogTitle => 'Prihranek/poraba denarja';

  @override
  String homePiggyDateStart(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Začetni datum: $dateString';
  }

  @override
  String homePiggyDateTarget(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Ciljni datum: $dateString';
  }

  @override
  String get homeMainDialogSettingsTitle => 'Customize Dashboard';

  @override
  String homePiggyLinked(String account) {
    return 'Povezano z $account';
  }

  @override
  String get homePiggyNoAccounts => 'Nimate še hranilnikov.';

  @override
  String get homePiggyNoAccountsSubtitle =>
      'Ustvarite jih v spletnem vmesniku!';

  @override
  String homePiggyRemaining(String amount) {
    return 'Preostalo za varčevanje: $amount';
  }

  @override
  String homePiggySaved(String amount) {
    return 'Privarčevano do sedaj: $amount';
  }

  @override
  String homePiggyTarget(String amount) {
    return 'Ciljni znesek: $amount';
  }

  @override
  String get homeTabLabelBalance => 'Bilanca stanja';

  @override
  String get homeTabLabelMain => 'Glavna';

  @override
  String get homeTabLabelPiggybanks => 'Hranilniki';

  @override
  String get homeTabLabelTransactions => 'Transakcije';

  @override
  String get homeTransactionsActionFilter => 'Seznam filtrov';

  @override
  String get homeTransactionsDialogFilterAccountsAll => '<Vsi računi>';

  @override
  String get homeTransactionsDialogFilterBillsAll => '<Vsi računi>';

  @override
  String get homeTransactionsDialogFilterBillUnset => '<Ni računov>';

  @override
  String get homeTransactionsDialogFilterBudgetsAll => '<Vsi proračuni>';

  @override
  String get homeTransactionsDialogFilterBudgetUnset =>
      '<Proračuni niso nastavljeni>';

  @override
  String get homeTransactionsDialogFilterCategoriesAll => '<Vse kategorije>';

  @override
  String get homeTransactionsDialogFilterCategoryUnset =>
      '<Kategorije niso nastavljene>';

  @override
  String get homeTransactionsDialogFilterCurrenciesAll => '<Vse valute>';

  @override
  String get homeTransactionsDialogFilterFutureTransactions =>
      'Prikaži bodoče transakcije';

  @override
  String get homeTransactionsDialogFilterSearch => 'Iskalni pojem';

  @override
  String get homeTransactionsDialogFilterTitle => 'Izberi filter';

  @override
  String get homeTransactionsEmpty => 'Ni najdenih transakcij.';

  @override
  String homeTransactionsMultipleCategories(int num) {
    return '$num kategorij';
  }

  @override
  String get homeTransactionsSettingsShowTags =>
      'Pokaži oznake na seznamu transakcij';

  @override
  String get liabilityDirectionCredit => 'Dolžan sem ta dolg';

  @override
  String get liabilityDirectionDebit => 'To dolgujem';

  @override
  String get liabilityTypeDebt => 'Dolg';

  @override
  String get liabilityTypeLoan => 'Posojilo';

  @override
  String get liabilityTypeMortgage => 'Hipoteka';

  @override
  String get loginAbout =>
      'Za funkcijsko uporabo Waterfly III potrebujete lasten strežnik z namestitvijo Firefly III ali dodatek Firefly III za Home Assistant.\n\nSpodaj vnesite poln URL in osebni žeton dostopa (Možnosti-> Profil -> OAuth -> Osebni dostopni žetoni).';

  @override
  String get loginFormLabelAPIKey => 'Veljaven API ključ';

  @override
  String get loginFormLabelHost => 'URL gostitelja';

  @override
  String get loginWelcome => 'Dobrodošli v Waterfly III';

  @override
  String get logoutConfirmation => 'Ali ste prepričani, da se želite odjaviti?';

  @override
  String get navigationAccounts => 'Računi';

  @override
  String get navigationBills => 'Transakcije';

  @override
  String get navigationCategories => 'Kategorije';

  @override
  String get navigationMain => 'Glavna nadzorna plošča';

  @override
  String get navigationSettings => 'Nastavitve';

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

    return '$percString od $of';
  }

  @override
  String get settingsDialogDebugInfo =>
      'Tukaj lahko omogočite in pošljete dnevnike odpravljanja napak. Vklop slabo vpliva na delovanje aplikacije, zato jih ne omogočite, razen če so vam tako svetovali. Če onemogočite beleženje, boste izbrisali shranjeni dnevnik.';

  @override
  String get settingsDialogDebugMailCreate => 'Ustvari e-pošto';

  @override
  String get settingsDialogDebugMailDisclaimer =>
      'OPOZORILO: Odpre se osnutek pošte s priloženo dnevniško datoteko (v besedilni obliki). Dnevniki lahko vsebujejo občutljive podatke, kot je ime gostitelja vašega primerka Firefly (čeprav se poskušam izogniti zapisovanju kakršnih koli skrivnosti, kot je API ključ). Pozorno preberite dnevnik in cenzurirajte vse informacije, ki jih ne želite deliti in/ali niso pomembne za težavo, ki jo želite prijaviti.\n\nProsimo, ne pošiljajte dnevnikov brez predhodnega dogovora po pošti/GitHubu. Izbrisal bom vse dnevnike, poslane brez konteksta, zaradi zasebnosti. Dnevnika nikoli ne nalagajte necenzuriranega na GitHub ali drugam.';

  @override
  String get settingsDialogDebugSendButton => 'Pošlji dnevnike po e-pošti';

  @override
  String get settingsDialogDebugTitle => 'Debug dnevniki';

  @override
  String get settingsDialogLanguageTitle => 'Izberite jezik';

  @override
  String get settingsDialogThemeTitle => 'Izberite temo';

  @override
  String get settingsFAQ => 'FAQ';

  @override
  String get settingsFAQHelp => 'Opens in Browser. Only available in English.';

  @override
  String get settingsLanguage => 'Jezik';

  @override
  String get settingsLockscreen => 'Zaklenjen zaslon';

  @override
  String get settingsLockscreenHelp =>
      'Zahtevaj preverjanje pristnosti ob zagonu aplikacije';

  @override
  String get settingsLockscreenInitial =>
      'Preverite pristnost, da omogočite zaklenjeni zaslon.';

  @override
  String get settingsNLAppAccount => 'Privzeti račun';

  @override
  String get settingsNLAppAccountDynamic => '<Dinamično>';

  @override
  String get settingsNLAppAdd => 'Dodaj aplikacijo';

  @override
  String get settingsNLAppAddHelp =>
      'Kliknite, če želite dodati aplikacijo za poslušanje. Na seznamu bodo prikazane samo primerne aplikacije.';

  @override
  String get settingsNLAppAddInfo =>
      'Izvedite nekaj transakcij, pri katerih prejmete telefonska obvestila za dodajanje aplikacij na ta seznam. Če se aplikacija še vedno ne prikaže, mi prijavite na app@vogt.pw.';

  @override
  String get settingsNLAutoAdd => 'Ustvari transakcijo brez interakcije';

  @override
  String get settingsNLDescription =>
      'Ta storitev vam omogoča pridobivanje podrobnosti transakcije iz dohodnih potisnih obvestil. Poleg tega lahko izberete privzeti račun, ki naj mu bo dodeljena transakcija - če vrednost ni nastavljena, poskuša iz obvestila izvleči račun.';

  @override
  String get settingsNLEmptyNote => 'Polje za opombo naj bo prazno';

  @override
  String get settingsNLPermissionGrant => 'Pritisnite za odobritev dovoljenja.';

  @override
  String get settingsNLPermissionNotGranted => 'Dovoljenje ni odobreno.';

  @override
  String get settingsNLPermissionRemove => 'Odstrani dovoljenje?';

  @override
  String get settingsNLPermissionRemoveHelp =>
      'Če želite onemogočiti to storitev, kliknite aplikacijo in na naslednjem zaslonu odstranite dovoljenja.';

  @override
  String get settingsNLPrefillTXTitle =>
      'Vnaprej izpolnite naslov transakcije z naslovom obvestila';

  @override
  String get settingsNLServiceChecking => 'Preverjanje stanja…';

  @override
  String settingsNLServiceCheckingError(String error) {
    return 'Napaka pri preverjanju stanja: $error';
  }

  @override
  String get settingsNLServiceRunning => 'Storitev je zagnana.';

  @override
  String get settingsNLServiceStatus => 'Stanje storitve';

  @override
  String get settingsNLServiceStopped => 'Storitev je ustavljena.';

  @override
  String get settingsNotificationListener => 'Storitev poslušanja obvestil';

  @override
  String get settingsTheme => 'Tema aplikacije';

  @override
  String get settingsThemeDynamicColors => 'Dinamične barve';

  @override
  String settingsThemeValue(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'dark': 'Temen način',
      'light': 'Svetel način',
      'other': 'Sistemsko privzeto',
    });
    return '$_temp0';
  }

  @override
  String get settingsUseServerTimezone => 'Uporabite časovni pas strežnika';

  @override
  String get settingsUseServerTimezoneHelp =>
      'Prikaži vse čase v časovnem pasu strežnika. To posnema vedenje spletnega vmesnika.';

  @override
  String get settingsVersion => 'Verzija aplikacije';

  @override
  String get settingsVersionChecking => 'preverjam…';

  @override
  String get transactionAttachments => 'Priponke';

  @override
  String get transactionDeleteConfirm =>
      'Ali ste prepričani, da želite izbrisati to transakcijo?';

  @override
  String get transactionDialogAttachmentsDelete => 'Izbriši priponko';

  @override
  String get transactionDialogAttachmentsDeleteConfirm =>
      'Ali ste prepričani, da želite izbrisati to priponko?';

  @override
  String get transactionDialogAttachmentsErrorDownload =>
      'Datoteke ni bilo mogoče prenesti.';

  @override
  String transactionDialogAttachmentsErrorOpen(String error) {
    return 'Ni bilo mogoče odpreti datoteke: $error';
  }

  @override
  String transactionDialogAttachmentsErrorUpload(String error) {
    return 'Ni bilo mogoče naložiti datoteke: $error';
  }

  @override
  String get transactionDialogAttachmentsTitle => 'Priponke';

  @override
  String get transactionDialogBillNoBill => 'Ni računa';

  @override
  String get transactionDialogBillTitle => 'Poveži z računom';

  @override
  String get transactionDialogCurrencyTitle => 'Izberi valuto';

  @override
  String get transactionDialogTagsAdd => 'Dodaj oznako';

  @override
  String get transactionDialogTagsHint => 'Išči/dodaj oznako';

  @override
  String get transactionDialogTagsTitle => 'Izberi oznake';

  @override
  String get transactionDuplicate => 'Podvoji';

  @override
  String get transactionErrorInvalidAccount => 'Neveljaven račun';

  @override
  String get transactionErrorInvalidBudget => 'Neveljaven proračun';

  @override
  String get transactionErrorNoAccounts => 'Please fill in the accounts first.';

  @override
  String get transactionErrorNoAssetAccount =>
      'Please select an asset account.';

  @override
  String get transactionErrorTitle => 'Prosim navedite naslov.';

  @override
  String get transactionFormLabelAccountDestination => 'Ciljni račun';

  @override
  String get transactionFormLabelAccountForeign => 'Tuji račun';

  @override
  String get transactionFormLabelAccountOwn => 'Lastni račun';

  @override
  String get transactionFormLabelAccountSource => 'Izvorni račun';

  @override
  String get transactionFormLabelNotes => 'Zapiski';

  @override
  String get transactionFormLabelTags => 'Oznake';

  @override
  String get transactionFormLabelTitle => 'Naslov transakcije';

  @override
  String get transactionSplitAdd => 'Dodaj razdeljeno transakcijo';

  @override
  String get transactionSplitChangeCurrency => 'Spremeni valuto razdelitve';

  @override
  String get transactionSplitChangeDestinationAccount =>
      'Change Split Destination Account';

  @override
  String get transactionSplitChangeSourceAccount =>
      'Change Split Source Account';

  @override
  String get transactionSplitChangeTarget => 'Spremeni ciljni račun razdelitve';

  @override
  String get transactionSplitDelete => 'Izbriši razdelitev';

  @override
  String get transactionTitleAdd => 'Dodaj transakcijo';

  @override
  String get transactionTitleDelete => 'Izbriši transakcijo';

  @override
  String get transactionTitleEdit => 'Uredi transakcijo';

  @override
  String get transactionTypeDeposit => 'Polog';

  @override
  String get transactionTypeTransfer => 'Prenos';

  @override
  String get transactionTypeWithdrawal => 'Dvig';
}
