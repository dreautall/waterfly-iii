// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class SIt extends S {
  SIt([String locale = 'it']) : super(locale);

  @override
  String get accountRoleAssetCashWallet => 'Portafoglio contanti';

  @override
  String get accountRoleAssetCC => 'Carta di credito';

  @override
  String get accountRoleAssetDefault => 'Conto attività predefinito';

  @override
  String get accountRoleAssetSavings => 'Conto risparmi';

  @override
  String get accountRoleAssetShared => 'Conto attività condiviso';

  @override
  String get accountsLabelAsset => 'Conti attività';

  @override
  String get accountsLabelExpense => 'Conti uscite';

  @override
  String get accountsLabelLiabilities => 'Passività';

  @override
  String get accountsLabelRevenue => 'Conti entrate';

  @override
  String accountsLiabilitiesInterest(double interest, String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'settimana',
      'monthly': 'mese',
      'quarterly': 'trimestre',
      'halfyear': 'semestre',
      'yearly': 'anno',
      'other': 'sconosciuto',
    });
    return '$interest% di interesse per $_temp0';
  }

  @override
  String billsAmountAndFrequency(
    String minValue,
    String maxvalue,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'settimanale',
      'monthly': 'mensile',
      'quarterly': 'trimestrale',
      'halfyear': 'semestrale',
      'yearly': 'annuale',
      'other': 'sconosciuta',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', rimandata il $skip',
      zero: '',
    );
    return 'Il pagamento ricorrente comprende le transazioni con importo tra $minValue e $maxvalue. Si ripete con frequenza $_temp0$_temp1.';
  }

  @override
  String get billsChangeLayoutTooltip => 'Cambia layout';

  @override
  String get billsChangeSortOrderTooltip => 'Modifica ordinamento';

  @override
  String get billsErrorLoading => 'Errore caricando i pagamenti ricorrenti.';

  @override
  String billsExactAmountAndFrequency(
    String value,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'settimanale',
      'monthly': 'mensile',
      'quarterly': 'trimestrale',
      'halfyear': 'semestrale',
      'yearly': 'annuale',
      'other': 'sconosciuta',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', rimandata il $skip',
      zero: '',
    );
    return 'Il pagamento ricorrente comprende transazioni di valore $value. Si ripete con frequenza $_temp0$_temp1.';
  }

  @override
  String billsExpectedOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Attesa per $dateString';
  }

  @override
  String billsFrequency(String frequency) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Settimanale',
      'monthly': 'Mensile',
      'quarterly': 'Trimestrale',
      'halfyear': 'Semestrale',
      'yearly': 'Annuale',
      'other': 'Sconosciuta',
    });
    return '$_temp0';
  }

  @override
  String billsFrequencySkip(String frequency, num skip) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Settimanale',
      'monthly': 'Mensile',
      'quarterly': 'Trimestrale',
      'halfyear': 'Semestrale',
      'yearly': 'Annuale',
      'other': 'Sconosciuta',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', rimandata il $skip',
      zero: '',
    );
    return '$_temp0$_temp1';
  }

  @override
  String get billsInactive => 'Non attiva';

  @override
  String get billsIsActive => 'Il pagamento ricorrente è attivo';

  @override
  String get billsLayoutGroupSubtitle =>
      'Pagamenti ricorrenti visualizzati nei gruppi assegnati.';

  @override
  String get billsLayoutGroupTitle => 'Gruppo';

  @override
  String get billsLayoutListSubtitle =>
      'Pagamenti ricorrenti visualizzati in un elenco ordinate in base a determinati criteri.';

  @override
  String get billsLayoutListTitle => 'Elenco';

  @override
  String get billsListEmpty => 'Questo elenco è attualmente vuoto.';

  @override
  String get billsNextExpectedMatch => 'Prossima';

  @override
  String get billsNotActive => 'Il pagamento ricorrente è inattivo';

  @override
  String get billsNotExpected => 'Non prevista in questo periodo';

  @override
  String get billsNoTransactions => 'Nessuna transazione trovata.';

  @override
  String billsPaidOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Pagata $dateString';
  }

  @override
  String get billsSortAlphabetical => 'Alfabetico';

  @override
  String get billsSortByTimePeriod => 'Per periodo di tempo';

  @override
  String get billsSortFrequency => 'Frequenza';

  @override
  String get billsSortName => 'Nome';

  @override
  String get billsUngrouped => 'Non raggruppate';

  @override
  String get categoryDeleteConfirm =>
      'Sei sicuro di voler eliminare questa categoria? Le transazioni non saranno eliminate, ma non avranno più una categoria.';

  @override
  String get categoryErrorLoading => 'Errore nel caricamento delle categorie.';

  @override
  String get categoryFormLabelIncludeInSum => 'Includi nel totale mensile';

  @override
  String get categoryFormLabelName => 'Nome categoria';

  @override
  String get categoryMonthNext => 'Mese prossimo';

  @override
  String get categoryMonthPrev => 'Mese precedente';

  @override
  String get categorySumExcluded => 'esclusa';

  @override
  String get categoryTitleAdd => 'Aggiungi Categoria';

  @override
  String get categoryTitleDelete => 'Elimina Categoria';

  @override
  String get categoryTitleEdit => 'Modifica Categoria';

  @override
  String get catNone => '(nessuna categoria)';

  @override
  String get catOther => 'Altro';

  @override
  String errorAPIInvalidResponse(String message) {
    return 'Risposta non valida dall\'API: $message';
  }

  @override
  String get errorAPIUnavailable => 'API non raggiungibile';

  @override
  String get errorFieldRequired => 'Questo campo è obbligatorio.';

  @override
  String get errorInvalidURL => 'URL non valido';

  @override
  String errorMinAPIVersion(String requiredVersion) {
    return 'È richiesta almeno la versione API v$requiredVersion su Firefly. Per favore, aggiornare.';
  }

  @override
  String errorStatusCode(int code) {
    return 'Codice di stato: $code';
  }

  @override
  String get errorUnknown => 'Errore sconosciuto.';

  @override
  String get formButtonHelp => 'Aiuto';

  @override
  String get formButtonLogin => 'Accedi';

  @override
  String get formButtonLogout => 'Esci';

  @override
  String get formButtonRemove => 'Rimuovi';

  @override
  String get formButtonResetLogin => 'Reimposta accesso';

  @override
  String get formButtonTransactionAdd => 'Aggiungi transazione';

  @override
  String get formButtonTryAgain => 'Riprova';

  @override
  String get generalAccount => 'Conto';

  @override
  String get generalAssets => 'Attività';

  @override
  String get generalBalance => 'Saldo';

  @override
  String generalBalanceOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Saldo al $dateString';
  }

  @override
  String get generalBill => 'Bolletta';

  @override
  String get generalBudget => 'Bilancio';

  @override
  String get generalCategory => 'Categoria';

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
  String get generalDefault => 'predefinito';

  @override
  String get generalDestinationAccount => 'Conto di destinazione';

  @override
  String get generalDismiss => 'Ignora';

  @override
  String get generalEarned => 'Guadagnato';

  @override
  String get generalError => 'Errore';

  @override
  String get generalExpenses => 'Spese';

  @override
  String get generalIncome => 'Entrate';

  @override
  String get generalLiabilities => 'Passività';

  @override
  String get generalMultiple => 'molteplice';

  @override
  String get generalNever => 'mai';

  @override
  String get generalReconcile => 'Contabilizzato';

  @override
  String get generalReset => 'Reimposta';

  @override
  String get generalSourceAccount => 'Conto di origine';

  @override
  String get generalSpent => 'Speso';

  @override
  String get generalSum => 'Totale';

  @override
  String get generalTarget => 'Obiettivo';

  @override
  String get generalUnknown => 'Sconosciuto';

  @override
  String homeMainBillsInterval(String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'settimanale',
      'monthly': 'mensile',
      'quarterly': 'trimestrale',
      'halfyear': 'semestrale',
      'yearly': 'annuale',
      'other': 'sconosciuto',
    });
    return ' ($_temp0)';
  }

  @override
  String get homeMainBillsTitle => 'Bollette per la prossima settimana';

  @override
  String homeMainBudgetInterval(DateTime from, DateTime to, String period) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return ' (da $fromString a $toString, $period)';
  }

  @override
  String homeMainBudgetIntervalSingle(DateTime from, DateTime to) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return ' (da $fromString al $toString)';
  }

  @override
  String homeMainBudgetSum(String current, String status, String available) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'over': 'su',
      'other': 'rimanente da',
    });
    return '$current $_temp0 $available';
  }

  @override
  String get homeMainBudgetTitle => 'Bilanci per il mese corrente';

  @override
  String get homeMainChartAccountsTitle => 'Riepilogo conti';

  @override
  String get homeMainChartCategoriesTitle =>
      'Riepilogo categorie per il mese corrente';

  @override
  String get homeMainChartDailyAvg => 'Media di 7 giorni';

  @override
  String get homeMainChartDailyTitle => 'Riepilogo giornaliero';

  @override
  String get homeMainChartNetEarningsTitle => 'Guadagni Netti';

  @override
  String get homeMainChartNetWorthTitle => 'Patrimonio';

  @override
  String get homeMainChartTagsTitle => 'Tag Summary for current month';

  @override
  String get homePiggyAdjustDialogTitle => 'Risparmia/Spendi Denaro';

  @override
  String homePiggyDateStart(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Data inizio: $dateString';
  }

  @override
  String homePiggyDateTarget(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Data termine: $dateString';
  }

  @override
  String get homeMainDialogSettingsTitle => 'Personalizza Dashboard';

  @override
  String homePiggyLinked(String account) {
    return 'Collegato a $account';
  }

  @override
  String get homePiggyNoAccounts => 'Nessun salvadanaio impostato.';

  @override
  String get homePiggyNoAccountsSubtitle =>
      'Creane alcuni dall\'interfaccia web!';

  @override
  String homePiggyRemaining(String amount) {
    return 'Da risparmiare: $amount';
  }

  @override
  String homePiggySaved(String amount) {
    return 'Risparmiato finora: $amount';
  }

  @override
  String get homePiggySavedMultiple => 'Saved so far:';

  @override
  String homePiggyTarget(String amount) {
    return 'Importo obiettivo: $amount';
  }

  @override
  String get homeTabLabelBalance => 'Bilancio';

  @override
  String get homeTabLabelMain => 'Principale';

  @override
  String get homeTabLabelPiggybanks => 'Salvadanai';

  @override
  String get homeTabLabelTransactions => 'Transazioni';

  @override
  String get homeTransactionsActionFilter => 'Elenco Filtri';

  @override
  String get homeTransactionsDialogFilterAccountsAll => '<Tutti i conti>';

  @override
  String get homeTransactionsDialogFilterBillsAll => '<Tutte le bollette>';

  @override
  String get homeTransactionsDialogFilterBillUnset => '<Nessuna bolletta>';

  @override
  String get homeTransactionsDialogFilterBudgetsAll => '<Tutti i bilanci>';

  @override
  String get homeTransactionsDialogFilterBudgetUnset => '<Nessun bilancio>';

  @override
  String get homeTransactionsDialogFilterCategoriesAll =>
      '<Tutte le categorie>';

  @override
  String get homeTransactionsDialogFilterCategoryUnset => '<Nessuna categoria>';

  @override
  String get homeTransactionsDialogFilterCurrenciesAll => '<Tutte le valute>';

  @override
  String get homeTransactionsDialogFilterDateRange => 'Date Range';

  @override
  String get homeTransactionsDialogFilterFutureTransactions =>
      'Mostra transazioni future';

  @override
  String get homeTransactionsDialogFilterSearch => 'Termine di ricerca';

  @override
  String get homeTransactionsDialogFilterTitle => 'Seleziona filtri';

  @override
  String get homeTransactionsEmpty => 'Nessuna transazione trovata.';

  @override
  String homeTransactionsMultipleCategories(int num) {
    return '$num categorie';
  }

  @override
  String get homeTransactionsSettingsShowTags =>
      'Mostra etichette nella lista transazioni';

  @override
  String get liabilityDirectionCredit => 'Questo debito mi è dovuto';

  @override
  String get liabilityDirectionDebit => 'Ho questo debito';

  @override
  String get liabilityTypeDebt => 'Debito';

  @override
  String get liabilityTypeLoan => 'Prestito';

  @override
  String get liabilityTypeMortgage => 'Mutuo';

  @override
  String get loginAbout =>
      'Per utilizzare Waterfly III produttivamente è necessario il proprio server con un\'istanza di Firefly III o l\'add-on di Firefly III per Home Assistant.\n\nInserisci l\'URL completo e un token di accesso personale (Opzioni -> Profilo -> OAuth -> Token di accesso personale) qui sotto.';

  @override
  String get loginFormLabelAPIKey => 'Chiave API valida';

  @override
  String get loginFormLabelHost => 'URL del server';

  @override
  String get loginWelcome => 'Benvenuto su Waterfly III';

  @override
  String get logoutConfirmation => 'Sei sicuro di volerti disconnettere?';

  @override
  String get navigationAccounts => 'Conti';

  @override
  String get navigationBills => 'Pagamenti ricorrenti';

  @override
  String get navigationCategories => 'Categorie';

  @override
  String get navigationMain => 'Dashboard principale';

  @override
  String get navigationSettings => 'Impostazioni';

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

    return '$percString di $of';
  }

  @override
  String get settingsDialogDebugInfo =>
      'Qui puoi abilitare il registro di debug e inviarlo. Questo ha un impatto significativo sulle prestazioni, quindi non attivarlo a meno che non venga suggerito di farlo. Disabilitare il registro cancellerà quello memorizzato in precedenza.';

  @override
  String get settingsDialogDebugMailCreate => 'Crea E-mail';

  @override
  String get settingsDialogDebugMailDisclaimer =>
      'ATTENZIONE: Si aprirà una bozza di e-mail con il file di registro allegato (in formato testuale). I registri potrebbero contenere informazioni sensibili, come il nome host della tua istanza di Firefly (anche se cerco di evitare la registrazione di qualsiasi segreto, come la chiave API). Si prega di leggere attentamente il registro e censurare qualsiasi informazione che non si desidera condividere e/o non è rilevante per il problema che si desidera segnalare.\n\nPer favore non inviare il registro senza previo accordo via e-mail/GitHub. Eliminerò tutti i registri inviati senza contesto per motivi di privacy. Non caricare mai il registro senza censura su GitHub o altrove.';

  @override
  String get settingsDialogDebugSendButton => 'Invia registro via e-mail';

  @override
  String get settingsDialogDebugTitle => 'Registro di debug';

  @override
  String get settingsDialogLanguageTitle => 'Seleziona Lingua';

  @override
  String get settingsDialogThemeTitle => 'Seleziona Tema';

  @override
  String get settingsFAQ => 'Domande frequenti';

  @override
  String get settingsFAQHelp => 'Si apre nel browser. Solo in inglese.';

  @override
  String get settingsLanguage => 'Lingua';

  @override
  String get settingsLockscreen => 'Schermata di blocco';

  @override
  String get settingsLockscreenHelp =>
      'Richiedi l\'autenticazione all\'avvio dell\'app';

  @override
  String get settingsLockscreenInitial =>
      'Si prega di autenticarsi per abilitare la schermata di blocco.';

  @override
  String get settingsNLAppAccount => 'Conto Predefinito';

  @override
  String get settingsNLAppAccountDynamic => '<Dinamico>';

  @override
  String get settingsNLAppAdd => 'Aggiungi App';

  @override
  String get settingsNLAppAddHelp =>
      'Tocca per aggiungere un\'app di cui leggere le notifiche. Solo le app idonee verranno visualizzate nella lista.';

  @override
  String get settingsNLAppAddInfo =>
      'Effettua alcune transazioni per le quali ricevi notifiche sullo smartphone per aggiungere app a questo elenco. Se l\'app che cerchi non è comunque presente, si prega di segnalarla ad app@vogt.pw.';

  @override
  String get settingsNLAutoAdd => 'Crea transazione automaticamente';

  @override
  String get settingsNLDescription =>
      'Questo servizio consente di recuperare i dettagli delle transazioni dalle notifiche push che ricevi. Inoltre, è possibile selezionare un account predefinito a cui la transazione dovrebbe essere assegnata - se non è impostato alcun valore, il servizio cerca di estrarre un account dal testo della notifica.';

  @override
  String get settingsNLEmptyNote => 'Lascia vuota l\'annotazione';

  @override
  String get settingsNLPermissionGrant => 'Tocca per concedere i permessi.';

  @override
  String get settingsNLPermissionNotGranted => 'Permesso non concesso.';

  @override
  String get settingsNLPermissionRemove => 'Rimuovere il permesso?';

  @override
  String get settingsNLPermissionRemoveHelp =>
      'Per disabilitare questo servizio, fare clic sull\'app e rimuovi i permessi nella schermata successiva.';

  @override
  String get settingsNLPrefillTXTitle =>
      'Compila il titolo della transazione con il titolo della notifica';

  @override
  String get settingsNLServiceChecking => 'Controllo dello stato…';

  @override
  String settingsNLServiceCheckingError(String error) {
    return 'Errore nel controllo dello stato: $error';
  }

  @override
  String get settingsNLServiceRunning => 'Servizio in esecuzione.';

  @override
  String get settingsNLServiceStatus => 'Stato del Servizio';

  @override
  String get settingsNLServiceStopped => 'Il servizio è interrotto.';

  @override
  String get settingsNotificationListener => 'Servizio di Lettura Notifiche';

  @override
  String get settingsTheme => 'Tema App';

  @override
  String get settingsThemeDynamicColors => 'Colori Dinamici';

  @override
  String settingsThemeValue(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'dark': 'Modalità Scura',
      'light': 'Modalità Chiara',
      'other': 'Predefinito di sistema',
    });
    return '$_temp0';
  }

  @override
  String get settingsUseServerTimezone => 'Usa fuso orario del server';

  @override
  String get settingsUseServerTimezoneHelp =>
      'Mostra tutti gli orari nel fuso orario del server. Questo simula il comportamento dell\'interfaccia web.';

  @override
  String get settingsVersion => 'Versione App';

  @override
  String get settingsVersionChecking => 'verifica…';

  @override
  String get transactionAttachments => 'Allegati';

  @override
  String get transactionDeleteConfirm =>
      'Confermare l\'eliminazione della transazione?';

  @override
  String get transactionDialogAttachmentsDelete => 'Elimina Allegato';

  @override
  String get transactionDialogAttachmentsDeleteConfirm =>
      'Confermare l\'eliminazione dell\'allegato?';

  @override
  String get transactionDialogAttachmentsErrorDownload =>
      'Impossibile scaricare il file.';

  @override
  String transactionDialogAttachmentsErrorOpen(String error) {
    return 'Impossibile aprire il file: $error';
  }

  @override
  String transactionDialogAttachmentsErrorUpload(String error) {
    return 'Impossibile caricare il file: $error';
  }

  @override
  String get transactionDialogAttachmentsTitle => 'Allegati';

  @override
  String get transactionDialogBillNoBill => 'Nessuna bolletta';

  @override
  String get transactionDialogBillTitle => 'Collega a bolletta';

  @override
  String get transactionDialogCurrencyTitle => 'Seleziona la valuta';

  @override
  String get transactionDialogTagsAdd => 'Aggiungi Etichetta';

  @override
  String get transactionDialogTagsHint => 'Ricerca/Aggiungi Etichetta';

  @override
  String get transactionDialogTagsTitle => 'Seleziona etichette';

  @override
  String get transactionDuplicate => 'Duplica';

  @override
  String get transactionErrorInvalidAccount => 'Conto non valido';

  @override
  String get transactionErrorInvalidBudget => 'Bilancio non valido';

  @override
  String get transactionErrorNoAccounts =>
      'Si prega di compilare prima i conti.';

  @override
  String get transactionErrorNoAssetAccount =>
      'Si prega di selezionare un conto attività.';

  @override
  String get transactionErrorTitle => 'Si prega di fornire un titolo.';

  @override
  String get transactionFormLabelAccountDestination => 'Conto di destinazione';

  @override
  String get transactionFormLabelAccountForeign => 'Conto esterno';

  @override
  String get transactionFormLabelAccountOwn => 'Conto personale';

  @override
  String get transactionFormLabelAccountSource => 'Conto di origine';

  @override
  String get transactionFormLabelNotes => 'Note';

  @override
  String get transactionFormLabelTags => 'Etichette';

  @override
  String get transactionFormLabelTitle => 'Titolo Transazione';

  @override
  String get transactionSplitAdd => 'Aggiungi transazione suddivisa';

  @override
  String get transactionSplitChangeCurrency => 'Modifica Valuta Suddivisa';

  @override
  String get transactionSplitChangeDestinationAccount =>
      'Cambia conto di destinazione diviso';

  @override
  String get transactionSplitChangeSourceAccount =>
      'Cambia conto di origine diviso';

  @override
  String get transactionSplitChangeTarget =>
      'Modifica conto destinazione suddivisa';

  @override
  String get transactionSplitDelete => 'Elimina suddivisione';

  @override
  String get transactionTitleAdd => 'Aggiungi transazione';

  @override
  String get transactionTitleDelete => 'Elimina Transazione';

  @override
  String get transactionTitleEdit => 'Modifica Transazione';

  @override
  String get transactionTypeDeposit => 'Deposito';

  @override
  String get transactionTypeTransfer => 'Trasferimento';

  @override
  String get transactionTypeWithdrawal => 'Prelievo';
}
