// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class SCa extends S {
  SCa([String locale = 'ca']) : super(locale);

  @override
  String get accountRoleAssetCashWallet => 'Cartera d\'Efectiu';

  @override
  String get accountRoleAssetCC => 'Targeta de crèdit';

  @override
  String get accountRoleAssetDefault => 'Compte d\'actius per defecte';

  @override
  String get accountRoleAssetSavings => 'Compte d\'estalvis';

  @override
  String get accountRoleAssetShared => 'Compte d\'actius compartit';

  @override
  String get accountsLabelAsset => 'Comptes d\'Actius';

  @override
  String get accountsLabelExpense => 'Comptes de Despeses';

  @override
  String get accountsLabelLiabilities => 'Passius';

  @override
  String get accountsLabelRevenue => 'Comptes d\'Ingressos';

  @override
  String accountsLiabilitiesInterest(double interest, String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'setmana',
      'monthly': 'mes',
      'quarterly': 'quadrimestre',
      'halfyear': 'mig any',
      'yearly': 'any',
      'other': 'desconegut',
    });
    return '$interest% d\'interès per $_temp0';
  }

  @override
  String billsAmountAndFrequency(
    String minValue,
    String maxvalue,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'setmanalment',
      'monthly': 'mensualment',
      'quarterly': 'quadrimestralment',
      'halfyear': 'bianualment',
      'yearly': 'anualment',
      'other': 'en altres freqüències',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', salta a partir de $skip',
      zero: '',
      one: '',
    );
    return 'Factures de transaccions entre $minValue i $maxvalue. Es repeteixen $_temp0$_temp1.';
  }

  @override
  String get billsChangeLayoutTooltip => 'Canvia la disposició';

  @override
  String get billsChangeSortOrderTooltip => 'Canvia l\'ordenació';

  @override
  String get billsErrorLoading => 'Error carregant les factures.';

  @override
  String billsExactAmountAndFrequency(
    String value,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'setmanalment',
      'monthly': 'mensualment',
      'quarterly': 'quadrimestralment',
      'halfyear': 'bianualment',
      'yearly': 'anualment',
      'other': 'en altres freqüències',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', salta a partir de $skip',
      zero: '',
      one: '',
    );
    return 'Factures de transaccions $value. Es repeteixen $_temp0$_temp1.';
  }

  @override
  String billsExpectedOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Data estimada $dateString';
  }

  @override
  String billsFrequency(String frequency) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Setmanal',
      'monthly': 'Mensual',
      'quarterly': 'Quadrimestral',
      'halfyear': 'Bianual',
      'yearly': 'Anual',
      'other': 'Altres',
    });
    return '$_temp0';
  }

  @override
  String billsFrequencySkip(String frequency, num skip) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Setmanal',
      'monthly': 'Mensual',
      'quarterly': 'Qaudrimestral',
      'halfyear': 'Bianual',
      'yearly': 'Anual',
      'other': 'Altres',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', salta a partir de $skip',
      zero: '',
      one: '',
    );
    return '$_temp0$_temp1';
  }

  @override
  String get billsInactive => 'Inactiva';

  @override
  String get billsIsActive => 'Factura activa';

  @override
  String get billsLayoutGroupSubtitle =>
      'Factures mostrades als seus grups assignats.';

  @override
  String get billsLayoutGroupTitle => 'Grup';

  @override
  String get billsLayoutListSubtitle =>
      'Factures ordenades segons algun criteri.';

  @override
  String get billsLayoutListTitle => 'Llista';

  @override
  String get billsListEmpty => 'La llista es troba actualment buida.';

  @override
  String get billsNextExpectedMatch => 'Pròxima coincidència esperada';

  @override
  String get billsNotActive => 'Factura inactiva';

  @override
  String get billsNotExpected => 'No s\'espera aquest periode';

  @override
  String get billsNoTransactions => 'No s\'ha trobat cap transacció.';

  @override
  String billsPaidOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Pagada a $dateString';
  }

  @override
  String get billsSortAlphabetical => 'Alfabètic';

  @override
  String get billsSortByTimePeriod => 'Per període de temps';

  @override
  String get billsSortFrequency => 'Freqüència';

  @override
  String get billsSortName => 'Nom';

  @override
  String get billsUngrouped => 'Sense grup';

  @override
  String get categoryDeleteConfirm =>
      'N\'estàs segur que vols esborrar aquesta categoria? Les transaccions no s\'esborraran, però ja no tindran cap categoria assignada.';

  @override
  String get categoryErrorLoading => 'Error al carregar les categories.';

  @override
  String get categoryFormLabelIncludeInSum => 'Inclou a la suma mensual';

  @override
  String get categoryFormLabelName => 'Nom de la categoria';

  @override
  String get categoryMonthNext => 'Mes següent';

  @override
  String get categoryMonthPrev => 'Mes anterior';

  @override
  String get categorySumExcluded => 'exclosa';

  @override
  String get categoryTitleAdd => 'Afegeix Categoria';

  @override
  String get categoryTitleDelete => 'Esborra la categoria';

  @override
  String get categoryTitleEdit => 'Edita la categoria';

  @override
  String get catNone => '<sense categoria>';

  @override
  String get catOther => 'Altres';

  @override
  String errorAPIInvalidResponse(String message) {
    return 'Resposta de l\'API invàlida: $message';
  }

  @override
  String get errorAPIUnavailable => 'API no disponible';

  @override
  String get errorFieldRequired => 'Aquest camp és obligatori.';

  @override
  String get errorInvalidURL => 'URL invàlida';

  @override
  String errorMinAPIVersion(String requiredVersion) {
    return 'Cal disposar com a mínim de la versió v$requiredVersion de Firefly. Per favor, actualitza.';
  }

  @override
  String errorStatusCode(int code) {
    return 'Codi d\'Estat: $code';
  }

  @override
  String get errorUnknown => 'Error desconegut.';

  @override
  String get formButtonHelp => 'Ajuda';

  @override
  String get formButtonLogin => 'Accedir';

  @override
  String get formButtonLogout => 'Tanca la Sessió';

  @override
  String get formButtonRemove => 'Elimina';

  @override
  String get formButtonResetLogin => 'Reinicia l\'inici de sessió';

  @override
  String get formButtonTransactionAdd => 'Afegir Transacció';

  @override
  String get formButtonTryAgain => 'Torna a provar';

  @override
  String get generalAccount => 'Compte';

  @override
  String get generalAssets => 'Actius';

  @override
  String get generalBalance => 'Balanç';

  @override
  String generalBalanceOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Balanç el $dateString';
  }

  @override
  String get generalBill => 'Factura';

  @override
  String get generalBudget => 'Pressupost';

  @override
  String get generalCategory => 'Categoria';

  @override
  String get generalCurrency => 'Moneda';

  @override
  String get generalDefault => 'per defecte';

  @override
  String get generalDestinationAccount => 'Destination Account';

  @override
  String get generalDismiss => 'Ignora';

  @override
  String get generalEarned => 'Guanyat';

  @override
  String get generalError => 'Error';

  @override
  String get generalExpenses => 'Despeses';

  @override
  String get generalIncome => 'Ingressos';

  @override
  String get generalLiabilities => 'Passius';

  @override
  String get generalMultiple => 'múltiples';

  @override
  String get generalNever => 'mai';

  @override
  String get generalReconcile => 'Consolidat';

  @override
  String get generalReset => 'Restableix';

  @override
  String get generalSourceAccount => 'Source Account';

  @override
  String get generalSpent => 'Gastat';

  @override
  String get generalSum => 'Suma';

  @override
  String get generalTarget => 'Destí';

  @override
  String get generalUnknown => 'Desconegut';

  @override
  String homeMainBillsInterval(String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'setmanalment',
      'monthly': 'mensualment',
      'quarterly': 'quatrimestralment',
      'halfyear': 'semestralment',
      'yearly': 'anualment',
      'other': 'desconegut',
    });
    return ' ($_temp0)';
  }

  @override
  String get homeMainBillsTitle => 'Factures per a la pròxima setmana';

  @override
  String homeMainBudgetInterval(DateTime from, DateTime to, String period) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return ' ($fromString fins a $toString, $period)';
  }

  @override
  String homeMainBudgetIntervalSingle(DateTime from, DateTime to) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return ' ($fromString fins a $toString)';
  }

  @override
  String homeMainBudgetSum(String current, String status, String available) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'over': 'per damunt de',
      'other': 'queden de',
    });
    return '$current $_temp0 $available';
  }

  @override
  String get homeMainBudgetTitle => 'Pressupostos per al mes actual';

  @override
  String get homeMainChartAccountsTitle => 'Resum del Compte';

  @override
  String get homeMainChartCategoriesTitle =>
      'Resum de la Categoria per a aquest mes';

  @override
  String get homeMainChartDailyAvg => 'Mitjana de 7 dies';

  @override
  String get homeMainChartDailyTitle => 'Resum Diari';

  @override
  String get homeMainChartNetEarningsTitle => 'Ingressos Nets';

  @override
  String get homeMainChartNetWorthTitle => 'Valor Net';

  @override
  String get homeMainChartTagsTitle => 'Tag Summary for current month';

  @override
  String get homePiggyAdjustDialogTitle => 'Estalvia/Gasta Diners';

  @override
  String homePiggyDateStart(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Data d\'inici: $dateString';
  }

  @override
  String homePiggyDateTarget(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Data objectiu: $dateString';
  }

  @override
  String get homeMainDialogSettingsTitle => 'Customize Dashboard';

  @override
  String homePiggyLinked(String account) {
    return 'Enllaçada a $account';
  }

  @override
  String get homePiggyNoAccounts => 'No s\'ha configurat cap guardiola.';

  @override
  String get homePiggyNoAccountsSubtitle => 'Crea\'n una a la interfície web!';

  @override
  String homePiggyRemaining(String amount) {
    return 'Queda per estalviar: $amount';
  }

  @override
  String homePiggySaved(String amount) {
    return 'Has estalviat: $amount';
  }

  @override
  String homePiggyTarget(String amount) {
    return 'Quantitat objectiu: $amount';
  }

  @override
  String get homeTabLabelBalance => 'Fulla de Balanços';

  @override
  String get homeTabLabelMain => 'Principal';

  @override
  String get homeTabLabelPiggybanks => 'Guardioles';

  @override
  String get homeTabLabelTransactions => 'Transaccions';

  @override
  String get homeTransactionsActionFilter => 'Llista de filtres';

  @override
  String get homeTransactionsDialogFilterAccountsAll => '<Tots els Comptes>';

  @override
  String get homeTransactionsDialogFilterBillsAll => '<Totes les Factures>';

  @override
  String get homeTransactionsDialogFilterBillUnset =>
      '<Cap Factura establerta>';

  @override
  String get homeTransactionsDialogFilterBudgetsAll =>
      '<Tots els Pressupostos>';

  @override
  String get homeTransactionsDialogFilterBudgetUnset =>
      '<Cap Pressupost establert>';

  @override
  String get homeTransactionsDialogFilterCategoriesAll =>
      '<Totes les Categories>';

  @override
  String get homeTransactionsDialogFilterCategoryUnset =>
      '<Cap Categoria establerta>';

  @override
  String get homeTransactionsDialogFilterCurrenciesAll => '<Totes les Monedes>';

  @override
  String get homeTransactionsDialogFilterFutureTransactions =>
      'Mostra transaccions futures';

  @override
  String get homeTransactionsDialogFilterSearch => 'Cerca un terme';

  @override
  String get homeTransactionsDialogFilterTitle => 'Selecciona filtres';

  @override
  String get homeTransactionsEmpty => 'No s\'ha trobat cap transacció.';

  @override
  String homeTransactionsMultipleCategories(int num) {
    return '$num categories';
  }

  @override
  String get homeTransactionsSettingsShowTags =>
      'Mostra les etiquetes a la llista de transaccions';

  @override
  String get liabilityDirectionCredit => 'Se\'m deu aquest deute';

  @override
  String get liabilityDirectionDebit => 'Dec aquest deute';

  @override
  String get liabilityTypeDebt => 'Deute';

  @override
  String get liabilityTypeLoan => 'Préstec';

  @override
  String get liabilityTypeMortgage => 'Hipoteca';

  @override
  String get loginAbout =>
      'Per a fer servir Waterfly III adequadament cal que tingues el teu propi servidor de Firefly III o l\'add-on de Firefly III a Home Assistant.\n\nPer favor, introdueix la URL completa a més del token d\'accés (Configuració -> Perfil -> OAuth -> Token d\'Accés Personal) a sota.';

  @override
  String get loginFormLabelAPIKey => 'Clau d\'API vàlida';

  @override
  String get loginFormLabelHost => 'URL d\'allotjament';

  @override
  String get loginWelcome => 'Benvingut/da a Waterfly III';

  @override
  String get logoutConfirmation => 'Segur que vols tancar la sessió?';

  @override
  String get navigationAccounts => 'Comptes';

  @override
  String get navigationBills => 'Factures';

  @override
  String get navigationCategories => 'Categories';

  @override
  String get navigationMain => 'Tauler de control Principal';

  @override
  String get navigationSettings => 'Configuració';

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

    return '$percString de $of';
  }

  @override
  String get settingsDialogDebugInfo =>
      'Pots habilitar i enviar registres des d\'ací. Aquests poden tenir un impacte sobre el rendiment de l\'aplicació, així que no ho actives si no se t\'ha demanat. Deshabilitar els registres eliminarà els que hi puguin haver desats.';

  @override
  String get settingsDialogDebugMailCreate => 'Crear correu electrònic';

  @override
  String get settingsDialogDebugMailDisclaimer =>
      'ADVERTIMENT: s\'obrirà un esborrany de correu amb el fitxer de registre adjunt (en format de text). Els registres poden contenir informació sensible, com ara el nom d\'amfitrió de la vostra instància de Firefly (tot i que intento evitar el registre de qualsevol secret, com ara la clau API). Si us plau, llegiu atentament el registre i censureu qualsevol informació que no vulgueu compartir i/o que no sigui rellevant per al problema que voleu informar.\n\nSi us plau, no envieu registres sense un acord previ per correu electrònic/GitHub per fer-ho. Suprimiré tots els registres enviats sense context per motius de privadesa. No carregueu mai el registre sense censura a GitHub ni a cap altre lloc.';

  @override
  String get settingsDialogDebugSendButton =>
      'Envia registres per Correu Electrònic';

  @override
  String get settingsDialogDebugTitle => 'Registres de depuració';

  @override
  String get settingsDialogLanguageTitle => 'Selecciona un idioma';

  @override
  String get settingsDialogThemeTitle => 'Selecciona un Tema';

  @override
  String get settingsFAQ => 'FAQ';

  @override
  String get settingsFAQHelp => 'Opens in Browser. Only available in English.';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLockscreen => 'Pantalla de Bloqueig';

  @override
  String get settingsLockscreenHelp =>
      'Requereix autenticació en iniciar l\'aplicació';

  @override
  String get settingsLockscreenInitial =>
      'Per favor, autentica\'t per habilitar la pantalla de bloqueig.';

  @override
  String get settingsNLAppAccount => 'Compte per Defecte';

  @override
  String get settingsNLAppAccountDynamic => '<Dinàmic>';

  @override
  String get settingsNLAppAdd => 'Afegir Aplicació';

  @override
  String get settingsNLAppAddHelp =>
      'Toca per afegir una aplicació a la qual escoltar. Només es mostraran les aplicacions compatibles.';

  @override
  String get settingsNLAppAddInfo =>
      'Fes algunes transaccions de les aplicacions on rebis notificacions per afegir-les a la llista. Si encara no es mostren, per favor informa app@vogt.pw.';

  @override
  String get settingsNLAutoAdd => 'Create transaction without interaction';

  @override
  String get settingsNLDescription =>
      'Aquest servei et permet obtenir detalls de transaccions a partir de notificacions. Addicionalment, pots seleccionar un compte per defecte al qual assignar les transaccions - si no s\'estableix cap valor, s\'intenta extreure el compte de la notificació.';

  @override
  String get settingsNLEmptyNote => 'Keep note field empty';

  @override
  String get settingsNLPermissionGrant => 'Toca per a donar permís.';

  @override
  String get settingsNLPermissionNotGranted => 'Permís no concedit.';

  @override
  String get settingsNLPermissionRemove => 'Eliminar permís?';

  @override
  String get settingsNLPermissionRemoveHelp =>
      'Per a deshabilitar aquest servei, toca en l\'app i elimina els permisos a la pantalla següent.';

  @override
  String get settingsNLPrefillTXTitle =>
      'Emplena automàticament el títol de la transacció amb el títol de la notificació';

  @override
  String get settingsNLServiceChecking => 'Comprovant l\'estat…';

  @override
  String settingsNLServiceCheckingError(String error) {
    return 'No s\'ha pogut comprovar l\'estat: $error';
  }

  @override
  String get settingsNLServiceRunning => 'El servei s\'està executant.';

  @override
  String get settingsNLServiceStatus => 'Estat del Servei';

  @override
  String get settingsNLServiceStopped => 'El servei s\'ha detingut.';

  @override
  String get settingsNotificationListener =>
      'Servei d\'escolta de notificacions';

  @override
  String get settingsTheme => 'Tema de l\'aplicació';

  @override
  String get settingsThemeDynamicColors => 'Colors Dinàmics';

  @override
  String settingsThemeValue(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'dark': 'Tema Obscur',
      'light': 'Tema Clar',
      'other': 'Per defecte',
    });
    return '$_temp0';
  }

  @override
  String get settingsUseServerTimezone =>
      'Utilitza la zona horària del servidor';

  @override
  String get settingsUseServerTimezoneHelp =>
      'Mostra totes les hores a la zona horària del servidor. Això mimetitza el comportament de la interfície web.';

  @override
  String get settingsVersion => 'Versió de l\'aplicació';

  @override
  String get settingsVersionChecking => 'comprovant…';

  @override
  String get transactionAttachments => 'Adjunts';

  @override
  String get transactionDeleteConfirm =>
      'Segur que vols eliminar aquesta transacció?';

  @override
  String get transactionDialogAttachmentsDelete => 'Elimina l\'adjunt';

  @override
  String get transactionDialogAttachmentsDeleteConfirm =>
      'Segur que vols eliminar aquest adjunt?';

  @override
  String get transactionDialogAttachmentsErrorDownload =>
      'No s\'ha pogut baixar el fitxer.';

  @override
  String transactionDialogAttachmentsErrorOpen(String error) {
    return 'No s\'ha pogut obrir el fitxer: $error';
  }

  @override
  String transactionDialogAttachmentsErrorUpload(String error) {
    return 'No s\'ha pogut penjar el fitxer: $error';
  }

  @override
  String get transactionDialogAttachmentsTitle => 'Adjunts';

  @override
  String get transactionDialogBillNoBill => 'Cap factura';

  @override
  String get transactionDialogBillTitle => 'Enllaça a una factura';

  @override
  String get transactionDialogCurrencyTitle => 'Tria una Moneda';

  @override
  String get transactionDialogTagsAdd => 'Afegir Etiqueta';

  @override
  String get transactionDialogTagsHint => 'Cerca/Afegeix una Etiqueta';

  @override
  String get transactionDialogTagsTitle => 'Selecciona Etiquetes';

  @override
  String get transactionDuplicate => 'Duplicada';

  @override
  String get transactionErrorInvalidAccount => 'Compte Invàlid';

  @override
  String get transactionErrorInvalidBudget => 'Pressupost Invàlid';

  @override
  String get transactionErrorNoAccounts => 'Please fill in the accounts first.';

  @override
  String get transactionErrorNoAssetAccount =>
      'Please select an asset account.';

  @override
  String get transactionErrorTitle => 'Per favor, introdueix un títol.';

  @override
  String get transactionFormLabelAccountDestination => 'Compte de destí';

  @override
  String get transactionFormLabelAccountForeign => 'Compte estranger';

  @override
  String get transactionFormLabelAccountOwn => 'Compte propi';

  @override
  String get transactionFormLabelAccountSource => 'Compte d\'origen';

  @override
  String get transactionFormLabelNotes => 'Notes';

  @override
  String get transactionFormLabelTags => 'Etiquetes';

  @override
  String get transactionFormLabelTitle => 'Títol de la Transacció';

  @override
  String get transactionSplitAdd => 'Afegeix una transacció dividida';

  @override
  String get transactionSplitChangeCurrency => 'Canvia la moneda de la divisió';

  @override
  String get transactionSplitChangeDestinationAccount =>
      'Change Split Destination Account';

  @override
  String get transactionSplitChangeSourceAccount =>
      'Change Split Source Account';

  @override
  String get transactionSplitChangeTarget =>
      'Canvia el compte destí de la divisió';

  @override
  String get transactionSplitDelete => 'Elimina la divisió';

  @override
  String get transactionTitleAdd => 'Afegir Transacció';

  @override
  String get transactionTitleDelete => 'Elimina la Transacció';

  @override
  String get transactionTitleEdit => 'Edita la Transacció';

  @override
  String get transactionTypeDeposit => 'Ingrés';

  @override
  String get transactionTypeTransfer => 'Transferència';

  @override
  String get transactionTypeWithdrawal => 'Retirada';
}
