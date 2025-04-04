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
      'weekly': 'weekly',
      'monthly': 'monthly',
      'quarterly': 'quarterly',
      'halfyear': 'half-yearly',
      'yearly': 'yearly',
      'other': 'unknown',
    });
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
    String value,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'weekly',
      'monthly': 'monthly',
      'quarterly': 'quarterly',
      'halfyear': 'half-yearly',
      'yearly': 'yearly',
      'other': 'unknown',
    });
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
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Weekly',
      'monthly': 'Monthly',
      'quarterly': 'Quarterly',
      'halfyear': 'Half-yearly',
      'yearly': 'Yearly',
      'other': 'Unknown',
    });
    return '$_temp0';
  }

  @override
  String billsFrequencySkip(String frequency, num skip) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Weekly',
      'monthly': 'Monthly',
      'quarterly': 'Quarterly',
      'halfyear': 'Half-yearly',
      'yearly': 'Yearly',
      'other': 'Unknown',
    });
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
    return 'Minimum Firefly API Version v$requiredVersion required. Please upgrade.';
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
  String get generalAssets => 'Assets';

  @override
  String get generalBalance => 'Sold';

  @override
  String generalBalanceOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Balance on $dateString';
  }

  @override
  String get generalBill => 'Subscription';

  @override
  String get generalBudget => 'Buget';

  @override
  String get generalCategory => 'Categorie';

  @override
  String get generalCurrency => 'Valută';

  @override
  String get generalDefault => 'implicit';

  @override
  String get generalDestinationAccount => 'Destination Account';

  @override
  String get generalDismiss => 'Închide';

  @override
  String get generalEarned => 'Earned';

  @override
  String get generalError => 'Eroare';

  @override
  String get generalExpenses => 'Cheltuieli';

  @override
  String get generalIncome => 'Venit';

  @override
  String get generalLiabilities => 'Liabilities';

  @override
  String get generalMultiple => 'multiplu';

  @override
  String get generalNever => 'niciodată';

  @override
  String get generalReconcile => 'Reconciled';

  @override
  String get generalReset => 'Reset';

  @override
  String get generalSourceAccount => 'Source Account';

  @override
  String get generalSpent => 'Spent';

  @override
  String get generalSum => 'Sumă';

  @override
  String get generalTarget => 'Țintă';

  @override
  String get generalUnknown => 'Necunoscut';

  @override
  String homeMainBillsInterval(String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'weekly',
      'monthly': 'monthly',
      'quarterly': 'quarterly',
      'halfyear': 'half-year',
      'yearly': 'yearly',
      'other': 'unknown',
    });
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

    return ' ($fromString la $toString, $period)';
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
  String get homeMainChartNetEarningsTitle => 'Net Earnings';

  @override
  String get homeMainChartNetWorthTitle => 'Net Worth';

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
  String get homeMainDialogSettingsTitle => 'Customize Dashboard';

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
  String homePiggyTarget(String amount) {
    return 'Suma ţintă: $amount';
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
  String get homeTransactionsDialogFilterBillsAll => '<All Subscriptions>';

  @override
  String get homeTransactionsDialogFilterBillUnset => '<No Subscription set>';

  @override
  String get homeTransactionsDialogFilterBudgetsAll => '<Toate bugetele>';

  @override
  String get homeTransactionsDialogFilterBudgetUnset => '<No Budget set>';

  @override
  String get homeTransactionsDialogFilterCategoriesAll => '<Toate categoriile>';

  @override
  String get homeTransactionsDialogFilterCategoryUnset => '<No Category set>';

  @override
  String get homeTransactionsDialogFilterCurrenciesAll => '<Toate valutele>';

  @override
  String get homeTransactionsDialogFilterFutureTransactions =>
      'Show future transactions';

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
      'Show tags in transaction list';

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
  String get logoutConfirmation => 'Are you sure you want to log out?';

  @override
  String get navigationAccounts => 'Conturi';

  @override
  String get navigationBills => 'Subscriptions';

  @override
  String get navigationCategories => 'Categories';

  @override
  String get navigationMain => 'Panou principal';

  @override
  String get navigationSettings => 'Setări';

  @override
  String get no => 'No';

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
  String get settingsFAQ => 'FAQ';

  @override
  String get settingsFAQHelp => 'Opens in Browser. Only available in English.';

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
  String get settingsNLAutoAdd => 'Create transaction without interaction';

  @override
  String get settingsNLDescription =>
      'Acest serviciu vă permite să preluați detaliile tranzacției de la notificările push primite. În plus, puteți selecta un cont implicit căruia trebuie să îi fie atribuită tranzacția - dacă nu este setată nicio valoare, se va încerca să extragerea un cont din notificare.';

  @override
  String get settingsNLEmptyNote => 'Keep note field empty';

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
      'Prefill transaction title with notification title';

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
  String get settingsUseServerTimezone => 'Use server timezone';

  @override
  String get settingsUseServerTimezoneHelp =>
      'Show all times in the server timezone. This mimics the behavior of the webinterface.';

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
  String get transactionDialogBillNoBill => 'No subscription';

  @override
  String get transactionDialogBillTitle => 'Link to Subscription';

  @override
  String get transactionDialogCurrencyTitle => 'Selectează valuta';

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
  String get transactionErrorNoAccounts => 'Please fill in the accounts first.';

  @override
  String get transactionErrorNoAssetAccount =>
      'Please select an asset account.';

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
      'Change Split Destination Account';

  @override
  String get transactionSplitChangeSourceAccount =>
      'Change Split Source Account';

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
