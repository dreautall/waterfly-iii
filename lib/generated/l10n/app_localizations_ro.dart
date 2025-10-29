// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class SRo extends S {
  SRo([String locale = 'ro']) : super(locale);

  @override
  String get accountRoleAssetCashWallet => 'Portofel numerar';

  @override
  String get accountRoleAssetCC => 'Card de credit';

  @override
  String get accountRoleAssetDefault => 'Cont de active implicit';

  @override
  String get accountRoleAssetSavings => 'Cont de economii';

  @override
  String get accountRoleAssetShared => 'Contul de active partajat';

  @override
  String get accountsLabelAsset => 'Conturi de active';

  @override
  String get accountsLabelExpense => 'Conturi de cheltuieli';

  @override
  String get accountsLabelLiabilities => 'Pasive';

  @override
  String get accountsLabelRevenue => 'Conturi de venituri';

  @override
  String accountsLiabilitiesInterest(double interest, String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'săptămână',
      'monthly': 'lună',
      'quarterly': 'trimestru',
      'halfyear': 'semestru',
      'yearly': 'an',
      'other': 'necunoscut',
    });
    return '$interest% dobândă per $_temp0';
  }

  @override
  String billsAmountAndFrequency(
    String minValue,
    String maxvalue,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'săptămânal',
      'monthly': 'lunar',
      'quarterly': 'trimestrial',
      'halfyear': 'semestrial',
      'yearly': 'anual',
      'other': 'necunoscut',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', sare peste $skip',
      zero: '',
    );
    return 'Abonamentul se potrivește cu tranzacții între $minValue și $maxvalue. Se repetă $_temp0$_temp1.';
  }

  @override
  String get billsChangeLayoutTooltip => 'Schimbă aspectul';

  @override
  String get billsChangeSortOrderTooltip => 'Schimbă ordinea de sortare';

  @override
  String get billsErrorLoading => 'Eroare la încărcarea abonamentelor.';

  @override
  String billsExactAmountAndFrequency(
    String value,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'săptămânal',
      'monthly': 'lunar',
      'quarterly': 'trimestrial',
      'halfyear': 'semestrial',
      'yearly': 'anual',
      'other': 'necunoscut',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', sare peste $skip',
      zero: '',
    );
    return 'Abonamentul se potrivește cu tranzacții de $value. Se repetă $_temp0$_temp1.';
  }

  @override
  String billsExpectedOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Estimată la data de $dateString';
  }

  @override
  String billsFrequency(String frequency) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Săptămânal',
      'monthly': 'Lunar',
      'quarterly': 'Trimestrial',
      'halfyear': 'Semestrial',
      'yearly': 'Anual',
      'other': 'Necunoscut',
    });
    return '$_temp0';
  }

  @override
  String billsFrequencySkip(String frequency, num skip) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Săptămânal',
      'monthly': 'Lunar',
      'quarterly': 'Trimestrial',
      'halfyear': 'Semestrial',
      'yearly': 'Anual',
      'other': 'Necunoscut',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', sare peste $skip',
      zero: '',
    );
    return '$_temp0$_temp1';
  }

  @override
  String get billsInactive => 'Inactiv';

  @override
  String get billsIsActive => 'Abonamentul este activ';

  @override
  String get billsLayoutGroupSubtitle =>
      'Abonamentele sunt afișate în grupurile lor atribuite.';

  @override
  String get billsLayoutGroupTitle => 'Grup';

  @override
  String get billsLayoutListSubtitle =>
      'Abonamentele sunt afișate într-o listă sortată după anumite criterii.';

  @override
  String get billsLayoutListTitle => 'Listă';

  @override
  String get billsListEmpty => 'Lista este momentan goală.';

  @override
  String get billsNextExpectedMatch => 'Următoarea potrivire estimată';

  @override
  String get billsNotActive => 'Abonamentul este inactiv';

  @override
  String get billsNotExpected => 'Neestimat în această perioadă';

  @override
  String get billsNoTransactions => 'Nu s-au găsit tranzacții.';

  @override
  String billsPaidOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Plătit la data de $dateString';
  }

  @override
  String get billsSortAlphabetical => 'Alfabetic';

  @override
  String get billsSortByTimePeriod => 'După perioadă de timp';

  @override
  String get billsSortFrequency => 'Frecvență';

  @override
  String get billsSortName => 'Nume';

  @override
  String get billsUngrouped => 'Negrupate';

  @override
  String get billsSettingsShowOnlyActive => 'Arată doar active';

  @override
  String get billsSettingsShowOnlyActiveDesc =>
      'Afișează doar abonamentele active.';

  @override
  String get billsSettingsShowOnlyExpected => 'Arată doar așteptate';

  @override
  String get billsSettingsShowOnlyExpectedDesc =>
      'Afișează doar abonamentele așteptate (sau plătite) în această lună.';

  @override
  String get categoryDeleteConfirm =>
      'Sigur doriți să ștergeți această categorie? Tranzacțiile nu vor fi șterse, dar nu vor mai avea o categorie.';

  @override
  String get categoryErrorLoading => 'Eroare la încărcarea categoriilor.';

  @override
  String get categoryFormLabelIncludeInSum => 'Include în suma lunară';

  @override
  String get categoryFormLabelName => 'Nume categorie';

  @override
  String get categoryMonthNext => 'Luna următoare';

  @override
  String get categoryMonthPrev => 'Luna precedentă';

  @override
  String get categorySumExcluded => 'exclus';

  @override
  String get categoryTitleAdd => 'Adaugă categorie';

  @override
  String get categoryTitleDelete => 'Șterge categorie';

  @override
  String get categoryTitleEdit => 'Editează categorie';

  @override
  String get catNone => '<fără categorie>';

  @override
  String get catOther => 'Altele';

  @override
  String errorAPIInvalidResponse(String message) {
    return 'Răspuns invalid de la API: $message';
  }

  @override
  String get errorAPIUnavailable => 'API indisponibil';

  @override
  String get errorFieldRequired => 'Acest câmp este obligatoriu.';

  @override
  String get errorInvalidURL => 'URL invalid';

  @override
  String errorMinAPIVersion(String requiredVersion) {
    return 'Este necesară versiunea minimă Firefly API v$requiredVersion. Vă rugăm să actualizați.';
  }

  @override
  String errorStatusCode(int code) {
    return 'Cod de stare: $code';
  }

  @override
  String get errorUnknown => 'Eroare necunoscută.';

  @override
  String get formButtonHelp => 'Ajutor';

  @override
  String get formButtonLogin => 'Autentificare';

  @override
  String get formButtonLogout => 'Deconectare';

  @override
  String get formButtonRemove => 'Șterge';

  @override
  String get formButtonResetLogin => 'Resetare autentificare';

  @override
  String get formButtonTransactionAdd => 'Adaugă Tranzacție';

  @override
  String get formButtonTryAgain => 'Încearcă din nou';

  @override
  String get generalAccount => 'Cont';

  @override
  String get generalAssets => 'Active';

  @override
  String get generalBalance => 'Sold';

  @override
  String generalBalanceOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Sold la $dateString';
  }

  @override
  String get generalBill => 'Abonament';

  @override
  String get generalBudget => 'Buget';

  @override
  String get generalCategory => 'Categorie';

  @override
  String get generalCurrency => 'Valută';

  @override
  String get generalDateRangeCurrentMonth => 'Luna curentă';

  @override
  String get generalDateRangeLast30Days => 'Ultimele 30 de zile';

  @override
  String get generalDateRangeCurrentYear => 'Anul curent';

  @override
  String get generalDateRangeLastYear => 'Anul trecut';

  @override
  String get generalDateRangeAll => 'Toate';

  @override
  String get generalDefault => 'implicit';

  @override
  String get generalDestinationAccount => 'Cont Destinație';

  @override
  String get generalDismiss => 'Închide';

  @override
  String get generalEarned => 'Câștigat';

  @override
  String get generalError => 'Eroare';

  @override
  String get generalExpenses => 'Cheltuieli';

  @override
  String get generalIncome => 'Venit';

  @override
  String get generalLiabilities => 'Datorii';

  @override
  String get generalMultiple => 'multiplu';

  @override
  String get generalNever => 'niciodată';

  @override
  String get generalReconcile => 'Reconciliat';

  @override
  String get generalReset => 'Resetare';

  @override
  String get generalSourceAccount => 'Cont Sursă';

  @override
  String get generalSpent => 'Cheltuit';

  @override
  String get generalSum => 'Sumă';

  @override
  String get generalTarget => 'Țintă';

  @override
  String get generalUnknown => 'Necunoscut';

  @override
  String homeMainBillsInterval(String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'săptămânal',
      'monthly': 'lunar',
      'quarterly': 'trimestrial',
      'halfyear': 'semestrial',
      'yearly': 'anual',
      'other': 'necunoscut',
    });
    return ' ($_temp0)';
  }

  @override
  String get homeMainBillsTitle => 'Abonamente pentru săptămâna viitoare';

  @override
  String homeMainBudgetInterval(DateTime from, DateTime to, String period) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return ' ($fromString la $toString, $period)';
  }

  @override
  String homeMainBudgetIntervalSingle(DateTime from, DateTime to) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return ' ($fromString - $toString)';
  }

  @override
  String homeMainBudgetSum(String current, String status, String available) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'over': 'peste',
      'other': 'rămase din',
    });
    return '$current $_temp0 $available';
  }

  @override
  String get homeMainBudgetTitle => 'Bugete pentru luna curentă';

  @override
  String get homeMainChartAccountsTitle => 'Sumar cont';

  @override
  String get homeMainChartCategoriesTitle =>
      'Rezumat categorie pentru luna curentă';

  @override
  String get homeMainChartDailyAvg => 'Media pe 7 de zile';

  @override
  String get homeMainChartDailyTitle => 'Rezumat zilnic';

  @override
  String get homeMainChartNetEarningsTitle => 'Câștig Net';

  @override
  String get homeMainChartNetWorthTitle => 'Valoare Netă';

  @override
  String get homeMainChartTagsTitle => 'Sumar etichete pentru luna curentă';

  @override
  String get homePiggyAdjustDialogTitle => 'Salvează/cheltuie bani';

  @override
  String homePiggyDateStart(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Data de început: $dateString';
  }

  @override
  String homePiggyDateTarget(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Data țintă: $dateString';
  }

  @override
  String get homeMainDialogSettingsTitle => 'Personalizează Tabloul de Bord';

  @override
  String homePiggyLinked(String account) {
    return 'Conectat la $account';
  }

  @override
  String get homePiggyNoAccounts => 'Nicio pușculiță creată.';

  @override
  String get homePiggyNoAccountsSubtitle => 'Creează câteva în interfața web!';

  @override
  String homePiggyRemaining(String amount) {
    return 'Mai trebuie economisit: $amount';
  }

  @override
  String homePiggySaved(String amount) {
    return 'Economisit până acum: $amount';
  }

  @override
  String get homePiggySavedMultiple => 'Economisit până acum:';

  @override
  String homePiggyTarget(String amount) {
    return 'Suma ţintă: $amount';
  }

  @override
  String get homePiggyAccountStatus => 'Starea Contului';

  @override
  String get homePiggyAvailableAmounts => 'Sume Disponibile';

  @override
  String homePiggyAvailable(String amount) {
    return 'Disponibil: $amount';
  }

  @override
  String homePiggyInPiggyBanks(String amount) {
    return 'În pușculițe: $amount';
  }

  @override
  String get homeTabLabelBalance => 'Bilanțul soldului';

  @override
  String get homeTabLabelMain => 'Principal';

  @override
  String get homeTabLabelPiggybanks => 'Pușculițe';

  @override
  String get homeTabLabelTransactions => 'Tranzacții';

  @override
  String get homeTransactionsActionFilter => 'Lista de filtre';

  @override
  String get homeTransactionsDialogFilterAccountsAll => '<Toate conturile>';

  @override
  String get homeTransactionsDialogFilterBillsAll => '<Toate abonamentele>';

  @override
  String get homeTransactionsDialogFilterBillUnset =>
      '<Niciun abonament setat>';

  @override
  String get homeTransactionsDialogFilterBudgetsAll => '<Toate bugetele>';

  @override
  String get homeTransactionsDialogFilterBudgetUnset => '<Niciun buget setat>';

  @override
  String get homeTransactionsDialogFilterCategoriesAll => '<Toate categoriile>';

  @override
  String get homeTransactionsDialogFilterCategoryUnset =>
      '<Nicio categorie setată>';

  @override
  String get homeTransactionsDialogFilterCurrenciesAll => '<Toate valutele>';

  @override
  String get homeTransactionsDialogFilterDateRange => 'Interval de date';

  @override
  String get homeTransactionsDialogFilterFutureTransactions =>
      'Afișează tranzacțiile viitoare';

  @override
  String get homeTransactionsDialogFilterSearch => 'Caută termen';

  @override
  String get homeTransactionsDialogFilterTitle => 'Selectează filtre';

  @override
  String get homeTransactionsEmpty => 'Nicio tranzacție găsită.';

  @override
  String homeTransactionsMultipleCategories(int num) {
    return '$num categorii';
  }

  @override
  String get homeTransactionsSettingsShowTags =>
      'Afișează etichetele în lista de tranzacții';

  @override
  String get liabilityDirectionCredit => 'Îmi sunt datorate aceste datorii';

  @override
  String get liabilityDirectionDebit => 'Datorez această datorie';

  @override
  String get liabilityTypeDebt => 'Datorie';

  @override
  String get liabilityTypeLoan => 'Împrumut';

  @override
  String get liabilityTypeMortgage => 'Credit ipotecar';

  @override
  String get loginAbout =>
      'Pentru a folosi Waterfly III în mod productiv ai nevoie de propriul server cu o instanță Firefly III sau cu suplimentul Firefly III pentru asistentul la domiciliu.\n\nVă rugăm să introduceți adresa URL completă, precum și un token personal de acces (Setări -> Profile -> OAuth -> Personal Access Token) de mai jos.';

  @override
  String get loginFormLabelAPIKey => 'Cheie API validă';

  @override
  String get loginFormLabelHost => 'URL Host';

  @override
  String get loginWelcome => 'Bine ai venit la Waterfly III';

  @override
  String get logoutConfirmation => 'Ești sigur(ă) că vrei să te deconectezi?';

  @override
  String get navigationAccounts => 'Conturi';

  @override
  String get navigationBills => 'Abonamente';

  @override
  String get navigationCategories => 'Categorii';

  @override
  String get navigationMain => 'Panou principal';

  @override
  String get generalSettings => 'Setări';

  @override
  String get no => 'Nu';

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

    return '$percString din $of';
  }

  @override
  String get settingsDialogDebugInfo =>
      'Poți activa și trimite jurnale de depanare aici. Acestea au un impact negativ asupra performanței, așa că vă rog să nu le activați decât dacă sunteți sfătuit să faceți acest lucru. Dezactivarea jurnalului va șterge jurnalul stocat.';

  @override
  String get settingsDialogDebugMailCreate => 'Creează e-mail';

  @override
  String get settingsDialogDebugMailDisclaimer =>
      'AVERTISMENT: O ciornă de mail se va deschide cu fişierul de jurnal ataşat (în format de text). Jurnalele ar putea conține informații sensibile, cum ar fi numele gazdei instanței dvs. Firefly (deși încerc să evit logarea oricăror secrete, cum ar fi cheia API). Vă rugăm să citiți jurnalul cu atenție și să cenzurați orice informație pe care nu doriți să o împărtășiți și/sau nu este relevantă pentru problema pe care doriți să o raportați.\n\nVă rugăm să nu trimiteți jurnale fără acord prealabil prin mail/GitHub pentru a face acest lucru. Voi șterge orice jurnal trimis fără context din motive de confidențialitate. Nu încărca niciodată jurnalul necenzurat pe GitHub sau în altă parte.';

  @override
  String get settingsDialogDebugSendButton => 'Trimite jurnale prin e-mail';

  @override
  String get settingsDialogDebugTitle => 'Jurnalul de depanare';

  @override
  String get settingsDialogLanguageTitle => 'Selectează limba';

  @override
  String get settingsDialogThemeTitle => 'Selectează tema';

  @override
  String get settingsFAQ => 'Întrebări frecvente';

  @override
  String get settingsFAQHelp =>
      'Se deschide în browser. Disponibil doar în engleză.';

  @override
  String get settingsLanguage => 'Limba';

  @override
  String get settingsLockscreen => 'Ecran de blocare';

  @override
  String get settingsLockscreenHelp =>
      'Necesită autentificarea la pornirea aplicației';

  @override
  String get settingsLockscreenInitial =>
      'Vă rugăm să vă autentificați pentru a activa ecranul de blocare.';

  @override
  String get settingsNLAppAccount => 'Cont implicit';

  @override
  String get settingsNLAppAccountDynamic => '<Dinamic>';

  @override
  String get settingsNLAppAdd => 'Adaugă aplicaţie';

  @override
  String get settingsNLAppAddHelp =>
      'Faceți clic pentru a adăuga o aplicație ce va fi ascultă. Numai aplicațiile eligibile vor apărea în listă.';

  @override
  String get settingsNLAppAddInfo =>
      'Efectuați unele tranzacții în care primiți notificări prin telefon pentru a adăuga aplicații la această listă. Dacă aplicația încă nu apare, vă rugăm să raportați la app@vogt.pw.';

  @override
  String get settingsNLAutoAdd => 'Creează tranzacție fără interacțiune';

  @override
  String get settingsNLDescription =>
      'Acest serviciu vă permite să preluați detaliile tranzacției de la notificările push primite. În plus, puteți selecta un cont implicit căruia trebuie să îi fie atribuită tranzacția - dacă nu este setată nicio valoare, se va încerca să extragerea un cont din notificare.';

  @override
  String get settingsNLEmptyNote => 'Păstrează câmpul notei gol';

  @override
  String get settingsNLPermissionGrant =>
      'Atingeţi pentru a acorda permisiunea.';

  @override
  String get settingsNLPermissionNotGranted =>
      'Permisiunea nu a fost acordată.';

  @override
  String get settingsNLPermissionRemove => 'Eliminaţi permisiunea?';

  @override
  String get settingsNLPermissionRemoveHelp =>
      'Pentru a dezactiva acest serviciu, faceți clic pe aplicație și eliminați permisiunile de pe ecranul următor.';

  @override
  String get settingsNLPrefillTXTitle =>
      'Completează automat titlul tranzacției cu titlul notificării';

  @override
  String get settingsNLServiceChecking => 'Verificare stare…';

  @override
  String settingsNLServiceCheckingError(String error) {
    return 'Eroare la verificarea stării: $error';
  }

  @override
  String get settingsNLServiceRunning => 'Serviciul rulează.';

  @override
  String get settingsNLServiceStatus => 'Starea serviciului';

  @override
  String get settingsNLServiceStopped => 'Serviciul este oprit.';

  @override
  String get settingsNotificationListener =>
      'Serviciul de clasificare a notificărilor';

  @override
  String get settingsTheme => 'Tema aplicației';

  @override
  String get settingsThemeDynamicColors => 'Culori dinamice';

  @override
  String settingsThemeValue(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'dark': 'Mod întunecat',
      'light': 'Mod luminos',
      'other': 'Sistem Implicit',
    });
    return '$_temp0';
  }

  @override
  String get settingsUseServerTimezone => 'Utilizează fusul orar al serverului';

  @override
  String get settingsUseServerTimezoneHelp =>
      'Afișează toate orele în fusul orar al serverului. Aceasta imită comportamentul interfeței web.';

  @override
  String get settingsVersion => 'Versiune aplicaţie';

  @override
  String get settingsVersionChecking => 'verificare…';

  @override
  String get transactionAttachments => 'Atașamente';

  @override
  String get transactionDeleteConfirm =>
      'Ești sigur că vrei să ștergi tranzacția selectată?';

  @override
  String get transactionDialogAttachmentsDelete => 'Şterge ataşament';

  @override
  String get transactionDialogAttachmentsDeleteConfirm =>
      'Ești sigur că dorești să ștergi acest atașament?';

  @override
  String get transactionDialogAttachmentsErrorDownload =>
      'Descărcarea fișierului a eșuat.';

  @override
  String transactionDialogAttachmentsErrorOpen(String error) {
    return 'Nu s-a putut deschide fișierul: $error';
  }

  @override
  String transactionDialogAttachmentsErrorUpload(String error) {
    return 'Nu s-a putut încărca fișierul: $error';
  }

  @override
  String get transactionDialogAttachmentsTitle => 'Atașamente';

  @override
  String get transactionDialogBillNoBill => 'Fără abonament';

  @override
  String get transactionDialogBillTitle => 'Asociază cu Abonamentul';

  @override
  String get transactionDialogCurrencyTitle => 'Selectează valuta';

  @override
  String get transactionDialogPiggyNoPiggy => 'No Piggy Bank';

  @override
  String get transactionDialogPiggyTitle => 'Link to Piggy Bank';

  @override
  String get transactionDialogTagsAdd => 'Adaugă etichetă';

  @override
  String get transactionDialogTagsHint => 'Caută/Adaugă etichetă';

  @override
  String get transactionDialogTagsTitle => 'Alege etichete';

  @override
  String get transactionDuplicate => 'Duplică';

  @override
  String get transactionErrorInvalidAccount => 'Cont invalid';

  @override
  String get transactionErrorInvalidBudget => 'Buget invalid';

  @override
  String get transactionErrorNoAccounts =>
      'Te rugăm să completezi conturile mai întâi.';

  @override
  String get transactionErrorNoAssetAccount =>
      'Te rugăm să selectezi un cont de active.';

  @override
  String get transactionErrorTitle => 'Te rog introdu un titlu.';

  @override
  String get transactionFormLabelAccountDestination => 'Cont destinație';

  @override
  String get transactionFormLabelAccountForeign => 'Cont extern';

  @override
  String get transactionFormLabelAccountOwn => 'Cont propriu';

  @override
  String get transactionFormLabelAccountSource => 'Cont sursă';

  @override
  String get transactionFormLabelNotes => 'Notițe';

  @override
  String get transactionFormLabelTags => 'Etichete';

  @override
  String get transactionFormLabelTitle => 'Titlul tranzacției';

  @override
  String get transactionSplitAdd => 'Adaugă tranzacție divizată';

  @override
  String get transactionSplitChangeCurrency => 'Schimbă moneda divizată';

  @override
  String get transactionSplitChangeDestinationAccount =>
      'Schimbă contul destinație al diviziunii';

  @override
  String get transactionSplitChangeSourceAccount =>
      'Schimbă contul sursă al diviziunii';

  @override
  String get transactionSplitChangeTarget => 'Schimbă contul țintă divizat';

  @override
  String get transactionSplitDelete => 'Șterge diviziune';

  @override
  String get transactionTitleAdd => 'Adaugă Tranzacție';

  @override
  String get transactionTitleDelete => 'Şterge tranzacţia';

  @override
  String get transactionTitleEdit => 'Editează tranzacția';

  @override
  String get transactionTypeDeposit => 'Depune';

  @override
  String get transactionTypeTransfer => 'Transferă';

  @override
  String get transactionTypeWithdrawal => 'Retragere';
}
