// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class SDe extends S {
  SDe([String locale = 'de']) : super(locale);

  @override
  String get accountRoleAssetCashWallet => 'Geldbörse';

  @override
  String get accountRoleAssetCC => 'Kreditkarte';

  @override
  String get accountRoleAssetDefault => 'Standard-Bestandskonto';

  @override
  String get accountRoleAssetSavings => 'Sparkonto';

  @override
  String get accountRoleAssetShared => 'Gemeinsames Bestandskonto';

  @override
  String get accountsLabelAsset => 'Bestandskonten';

  @override
  String get accountsLabelExpense => 'Ausgabekonten';

  @override
  String get accountsLabelLiabilities => 'Verbindlichkeiten';

  @override
  String get accountsLabelRevenue => 'Einnahmekonten';

  @override
  String accountsLiabilitiesInterest(double interest, String period) {
    String _temp0 = intl.Intl.selectLogic(
      period,
      {
        'weekly': 'Woche',
        'monthly': 'Monat',
        'quarterly': 'Quartal',
        'halfyear': 'halbes Jahr',
        'yearly': 'Jahr',
        'other': 'Unbekannt',
      },
    );
    return '$interest% Zinsen pro $_temp0';
  }

  @override
  String billsAmountAndFrequency(
      String minValue, String maxvalue, String frequency, num skip) {
    String _temp0 = intl.Intl.selectLogic(
      frequency,
      {
        'weekly': 'wöchentlich',
        'monthly': 'monatlich',
        'quarterly': 'vierteljährlich',
        'halfyear': 'halbjährlich',
        'yearly': 'jährlich',
        'other': 'unbekannt',
      },
    );
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', überspringt $skip',
      zero: '',
    );
    return 'Rechnung passt zu Transaktionen zwischen $minValue und $maxvalue. Wiederholt sich $_temp0$_temp1.';
  }

  @override
  String get billsChangeLayoutTooltip => 'Layout ändern';

  @override
  String get billsChangeSortOrderTooltip => 'Sortierung ändern';

  @override
  String get billsErrorLoading => 'Fehler beim Laden der Rechnungen.';

  @override
  String billsExactAmountAndFrequency(
      String value, String frequency, num skip) {
    String _temp0 = intl.Intl.selectLogic(
      frequency,
      {
        'weekly': 'wöchentlich',
        'monthly': 'monatlich',
        'quarterly': 'vierteljährlich',
        'halfyear': 'halbjährlich',
        'yearly': 'jährlich',
        'other': 'unbekannt',
      },
    );
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', überspringt $skip',
      zero: '',
    );
    return 'Rechnung passt zu Transaktionen mit $value. Wiederholt sich $_temp0$_temp1.';
  }

  @override
  String billsExpectedOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Voraussichtlich $dateString';
  }

  @override
  String billsFrequency(String frequency) {
    String _temp0 = intl.Intl.selectLogic(
      frequency,
      {
        'weekly': 'Wöchentlich',
        'monthly': 'Monatlich',
        'quarterly': 'Vierteljährlich',
        'halfyear': 'Halbjährlich',
        'yearly': 'Jährlich',
        'other': 'Unbekannt',
      },
    );
    return '$_temp0';
  }

  @override
  String billsFrequencySkip(String frequency, num skip) {
    String _temp0 = intl.Intl.selectLogic(
      frequency,
      {
        'weekly': 'Wöchentlich',
        'monthly': 'Monatlich',
        'quarterly': 'Vierteljährlich',
        'halfyear': 'Halbjährlich',
        'yearly': 'Jährlich',
        'other': 'Unbekannt',
      },
    );
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', überspringt $skip',
      zero: '',
    );
    return '$_temp0$_temp1';
  }

  @override
  String get billsInactive => 'Inaktiv';

  @override
  String get billsIsActive => 'Rechnung ist aktiv';

  @override
  String get billsLayoutGroupSubtitle =>
      'Rechnungen werden in ihrer Gruppe angezeigt.';

  @override
  String get billsLayoutGroupTitle => 'Gruppe';

  @override
  String get billsLayoutListSubtitle =>
      'Rechnungen werden sortiert in einer Liste angezeigt.';

  @override
  String get billsLayoutListTitle => 'Liste';

  @override
  String get billsListEmpty => 'Diese Liste ist momentan leer.';

  @override
  String get billsNextExpectedMatch => 'Nächste erwartete Übereinstimmung';

  @override
  String get billsNotActive => 'Rechnung ist inaktiv';

  @override
  String get billsNotExpected => 'In diesem Zeitraum nicht erwartet';

  @override
  String get billsNoTransactions => 'Keine Transaktionen gefunden.';

  @override
  String billsPaidOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Bezahlt am $dateString';
  }

  @override
  String get billsSortAlphabetical => 'Alphabetisch';

  @override
  String get billsSortByTimePeriod => 'Nach Zeitraum';

  @override
  String get billsSortFrequency => 'Häufigkeit';

  @override
  String get billsSortName => 'Name';

  @override
  String get billsUngrouped => 'Keine Gruppe';

  @override
  String get categoryDeleteConfirm =>
      'Möchtest du diese Kategorie wirklich löschen? Die Transaktionen werden nicht gelöscht, werden aber keine Kategorie mehr haben.';

  @override
  String get categoryErrorLoading => 'Fehler beim Laden der Kategorien.';

  @override
  String get categoryFormLabelIncludeInSum => 'In Monatssumme einbeziehen';

  @override
  String get categoryFormLabelName => 'Kategoriename';

  @override
  String get categoryMonthNext => 'Nächster Monat';

  @override
  String get categoryMonthPrev => 'Voriger Monat';

  @override
  String get categorySumExcluded => 'ausgenommen';

  @override
  String get categoryTitleAdd => 'Kategorie hinzufügen';

  @override
  String get categoryTitleDelete => 'Kategorie löschen';

  @override
  String get categoryTitleEdit => 'Kategorie bearbeiten';

  @override
  String get catNone => '<keine Kategorie>';

  @override
  String get catOther => 'Andere';

  @override
  String errorAPIInvalidResponse(String message) {
    return 'Ungültige API-Antwort: $message';
  }

  @override
  String get errorAPIUnavailable => 'API nicht verfügbar';

  @override
  String get errorFieldRequired => 'Dies ist ein Pflichtfeld.';

  @override
  String get errorInvalidURL => 'Ungültige URL';

  @override
  String errorMinAPIVersion(String requiredVersion) {
    return 'Mindestens Firefly API-Version v$requiredVersion benötigt. Bitte updaten.';
  }

  @override
  String errorStatusCode(int code) {
    return 'Status-Code: $code';
  }

  @override
  String get errorUnknown => 'Unbekannter Fehler.';

  @override
  String get formButtonHelp => 'Hilfe';

  @override
  String get formButtonLogin => 'Login';

  @override
  String get formButtonLogout => 'Logout';

  @override
  String get formButtonRemove => 'Entfernen';

  @override
  String get formButtonResetLogin => 'Login zurücksetzen';

  @override
  String get formButtonTransactionAdd => 'Transaktion hinzufügen';

  @override
  String get formButtonTryAgain => 'Nochmals versuchen';

  @override
  String get generalAccount => 'Konten';

  @override
  String get generalAssets => 'Vermögen';

  @override
  String get generalBalance => 'Kontostand';

  @override
  String generalBalanceOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Kontostand am $dateString';
  }

  @override
  String get generalBill => 'Rechnung';

  @override
  String get generalBudget => 'Budget';

  @override
  String get generalCategory => 'Kategorie';

  @override
  String get generalCurrency => 'Währung';

  @override
  String get generalDefault => 'Standard';

  @override
  String get generalDestinationAccount => 'Destination Account';

  @override
  String get generalDismiss => 'Verwerfen';

  @override
  String get generalEarned => 'Verdient';

  @override
  String get generalError => 'Fehler';

  @override
  String get generalExpenses => 'Ausgaben';

  @override
  String get generalIncome => 'Einnahmen';

  @override
  String get generalLiabilities => 'Verbindlichkeiten';

  @override
  String get generalMultiple => 'mehrere';

  @override
  String get generalNever => 'nie';

  @override
  String get generalReconcile => 'Abgeglichen';

  @override
  String get generalReset => 'Zurücksetzen';

  @override
  String get generalSourceAccount => 'Source Account';

  @override
  String get generalSpent => 'Ausgegeben';

  @override
  String get generalSum => 'Summe';

  @override
  String get generalTarget => 'Ziel';

  @override
  String get generalUnknown => 'Unbekannt';

  @override
  String homeMainBillsInterval(String period) {
    String _temp0 = intl.Intl.selectLogic(
      period,
      {
        'weekly': 'wöchentlich',
        'monthly': 'monatlich',
        'quarterly': 'vierteljährlich',
        'halfyear': 'halbjährlich',
        'yearly': 'jährlich',
        'other': 'unbekannt',
      },
    );
    return ' ($_temp0)';
  }

  @override
  String get homeMainBillsTitle => 'Rechnungen in der nächsten Woche';

  @override
  String homeMainBudgetInterval(DateTime from, DateTime to, String period) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return ' ($fromString bis $toString, $period)';
  }

  @override
  String homeMainBudgetIntervalSingle(DateTime from, DateTime to) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return ' ($fromString bis $toString)';
  }

  @override
  String homeMainBudgetSum(String current, String status, String available) {
    String _temp0 = intl.Intl.selectLogic(
      status,
      {
        'over': 'über',
        'other': 'bis',
      },
    );
    return '$current $_temp0 $available';
  }

  @override
  String get homeMainBudgetTitle => 'Budgets für diesen Monat';

  @override
  String get homeMainChartAccountsTitle => 'Konten-Übersicht';

  @override
  String get homeMainChartCategoriesTitle =>
      'Kategorie-Übersicht für diesen Monat';

  @override
  String get homeMainChartDailyAvg => '7-Tage-Durchschnitt';

  @override
  String get homeMainChartDailyTitle => 'Tägliche Zusammenfassung';

  @override
  String get homeMainChartNetEarningsTitle => 'Überschuss';

  @override
  String get homeMainChartNetWorthTitle => 'Nettovermögen';

  @override
  String get homePiggyAdjustDialogTitle => 'Geld sparen/ausgeben';

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

    return 'Zieldatum: $dateString';
  }

  @override
  String get homeMainDialogSettingsTitle => 'Customize Dashboard';

  @override
  String homePiggyLinked(String account) {
    return 'Verknüpft mit $account';
  }

  @override
  String get homePiggyNoAccounts => 'Keine Sparschweine vorhanden.';

  @override
  String get homePiggyNoAccountsSubtitle => 'Erstelle welche im Webinterface!';

  @override
  String homePiggyRemaining(String amount) {
    return 'Noch zu sparen: $amount';
  }

  @override
  String homePiggySaved(String amount) {
    return 'Bereits gespart: $amount';
  }

  @override
  String homePiggyTarget(String amount) {
    return 'Sparziel: $amount';
  }

  @override
  String get homeTabLabelBalance => 'Kontostände';

  @override
  String get homeTabLabelMain => 'Übersicht';

  @override
  String get homeTabLabelPiggybanks => 'Sparschweine';

  @override
  String get homeTabLabelTransactions => 'Transaktionen';

  @override
  String get homeTransactionsActionFilter => 'Liste filtern';

  @override
  String get homeTransactionsDialogFilterAccountsAll => '<Alle Konten>';

  @override
  String get homeTransactionsDialogFilterBillsAll => '<Alle Rechnungen>';

  @override
  String get homeTransactionsDialogFilterBillUnset => '<Ohne Rechnung>';

  @override
  String get homeTransactionsDialogFilterBudgetsAll => '<Alle Budgets>';

  @override
  String get homeTransactionsDialogFilterBudgetUnset => '<Ohne Budget>';

  @override
  String get homeTransactionsDialogFilterCategoriesAll => '<Alle Kategorien>';

  @override
  String get homeTransactionsDialogFilterCategoryUnset => '<Ohne Kategorie>';

  @override
  String get homeTransactionsDialogFilterCurrenciesAll => '<Alle Währungen>';

  @override
  String get homeTransactionsDialogFilterFutureTransactions =>
      'Zeige zukünftige Transaktionen';

  @override
  String get homeTransactionsDialogFilterSearch => 'Suchbegriff';

  @override
  String get homeTransactionsDialogFilterTitle => 'Filter auswählen';

  @override
  String get homeTransactionsEmpty => 'Keine Transaktionen gefunden.';

  @override
  String homeTransactionsMultipleCategories(int num) {
    return '$num Kategorien';
  }

  @override
  String get homeTransactionsSettingsShowTags =>
      'Schlagwörter in der Transaktionsliste anzeigen';

  @override
  String get liabilityDirectionCredit => 'Mir wird dies geschuldet';

  @override
  String get liabilityDirectionDebit => 'Ich schulde dies jemandem';

  @override
  String get liabilityTypeDebt => 'Schulden';

  @override
  String get liabilityTypeLoan => 'Darlehen';

  @override
  String get liabilityTypeMortgage => 'Hypothek';

  @override
  String get loginAbout =>
      'Um Waterfly III nutzen zu können, wird ein eigener Server mit Firefly III oder das Firefly III Add-on für Home Assistant benötigt.\n\nBitte gebe den kompletten Link und den persönlichen Zugangs-Token (Einstellungen → Profil → OAuth → Persönliche Zugangs-Tokens) ein.';

  @override
  String get loginFormLabelAPIKey => 'Gültiger API-Schlüssel';

  @override
  String get loginFormLabelHost => 'Server URL';

  @override
  String get loginWelcome => 'Willkommen zu Waterfly III';

  @override
  String get logoutConfirmation => 'Wirklich ausloggen?';

  @override
  String get navigationAccounts => 'Konten';

  @override
  String get navigationBills => 'Rechnungen';

  @override
  String get navigationCategories => 'Kategorien';

  @override
  String get navigationMain => 'Übersicht';

  @override
  String get navigationSettings => 'Einstellungen';

  @override
  String get no => 'Nein';

  @override
  String numPercent(double num) {
    final intl.NumberFormat numNumberFormat =
        intl.NumberFormat.decimalPercentPattern(
            locale: localeName, decimalDigits: 0);
    final String numString = numNumberFormat.format(num);

    return '$numString';
  }

  @override
  String numPercentOf(double perc, String of) {
    final intl.NumberFormat percNumberFormat =
        intl.NumberFormat.decimalPercentPattern(
            locale: localeName, decimalDigits: 0);
    final String percString = percNumberFormat.format(perc);

    return '$percString von $of';
  }

  @override
  String get settingsDialogDebugInfo =>
      'Hier kann die Fehlerprotokollierung aktiviert werden. Die Protokollierung hat einen negativen Einfluss auf die App-Performance, deshalb aktiviere sie bitte nur nach Absprache. Beim Deaktivieren werden die gespeicherten Protokolle gelöscht.';

  @override
  String get settingsDialogDebugMailCreate => 'E-Mail erstellen';

  @override
  String get settingsDialogDebugMailDisclaimer =>
      'ACHTUNG: Ein E-Mail Entwurf wird mit angehängtem Fehlerprotokoll erstellt. Das Fehlerprotokoll kann sensitive Informationen wie zum Beispiel die URL deiner Firefly-Instanz enthalten (auch wenn ich versuche geheime Informationen wie den API-Schlüssel nicht zu protokollieren). Bitte lese vor dem Senden der Mail das Protokoll durch und zensiere alle Informationen, die du nicht teilen möchtest.\n\nBitte sende keine Fehlerprotokolle ohne vorherige Absprache mit mir via Mail/GitHub. Ich werde alle ohne Kontext eingesendete Protokolle aus Datenschutzgründen löschen. Lade die Protokolle nie auf GitHub oder anderswo hoch.';

  @override
  String get settingsDialogDebugSendButton => 'Protokoll via Mail schicken';

  @override
  String get settingsDialogDebugTitle => 'Fehlerprotokolle';

  @override
  String get settingsDialogLanguageTitle => 'Sprache auswählen';

  @override
  String get settingsDialogThemeTitle => 'Erscheinungsbild auswählen';

  @override
  String get settingsFAQ => 'FAQ';

  @override
  String get settingsFAQHelp => 'Opens in Browser. Only available in English.';

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String get settingsLockscreen => 'App-Sperre';

  @override
  String get settingsLockscreenHelp =>
      'Authentifizierung beim Start der App erzwingen';

  @override
  String get settingsLockscreenInitial =>
      'Bitte authentifiziere dich, um die App-Sperre zu aktivieren.';

  @override
  String get settingsNLAppAccount => 'Standard-Konto';

  @override
  String get settingsNLAppAccountDynamic => '<Dynamisch>';

  @override
  String get settingsNLAppAdd => 'App hinzufügen';

  @override
  String get settingsNLAppAddHelp =>
      'Füge eine neue App hinzu. Nur qualifizierte Apps werden gelistet.';

  @override
  String get settingsNLAppAddInfo =>
      'Führe eine Zahlung durch, bei der die gewünschte Benachrichtigung erscheint, um eine App zu dieser Liste hinzuzufügen. Wenn die App trotzdem nicht erscheint, bitte melde dies an app@vogt.pw.';

  @override
  String get settingsNLAutoAdd => 'Transaktion ohne Nachfragen erstellen';

  @override
  String get settingsNLDescription =>
      'Dieser Dienst erlaubt dir, Transaktionen aus Benachrichtigungen zu erstellen. Außerdem kannst du das Standard-Konto auswählen, zu dem die Transaktion zugeordnet wird - ansonsten wird dynamisch versucht, ein Konto zu ermitteln.';

  @override
  String get settingsNLEmptyNote => 'Notizfeld leer lassen';

  @override
  String get settingsNLPermissionGrant =>
      'Klicke, um die Berechtigung zu erteilen.';

  @override
  String get settingsNLPermissionNotGranted => 'Berechtigung nicht erteilt.';

  @override
  String get settingsNLPermissionRemove => 'Berechtigung löschen?';

  @override
  String get settingsNLPermissionRemoveHelp =>
      'Um den Dienst zu deaktivieren, klicke auf die App und entferne die Berechtigungen im nächsten Bildschirm.';

  @override
  String get settingsNLPrefillTXTitle =>
      'Transaktionstitel mit Benachrichtigungstitel befüllen';

  @override
  String get settingsNLServiceChecking => 'Status wird geprüft…';

  @override
  String settingsNLServiceCheckingError(String error) {
    return 'Fehler beim Status prüfen: $error';
  }

  @override
  String get settingsNLServiceRunning => 'Dienst läuft.';

  @override
  String get settingsNLServiceStatus => 'Dienst-Status';

  @override
  String get settingsNLServiceStopped => 'Dienst ist gestoppt.';

  @override
  String get settingsNotificationListener =>
      'Dienst zum Auslesen von Benachrichtigungen';

  @override
  String get settingsTheme => 'Erscheinungsbild';

  @override
  String get settingsThemeDynamicColors => 'Dyn. Farben';

  @override
  String settingsThemeValue(String theme) {
    String _temp0 = intl.Intl.selectLogic(
      theme,
      {
        'dark': 'Dunkel',
        'light': 'Hell',
        'other': 'Systemeinstellung',
      },
    );
    return '$_temp0';
  }

  @override
  String get settingsUseServerTimezone => 'Server-Zeitzone benutzen';

  @override
  String get settingsUseServerTimezoneHelp =>
      'Zeigt alle Zeiten in der Server-Zeitzone an. Dies entspricht dem Verhalten des Webinterfaces.';

  @override
  String get settingsVersion => 'App-Version';

  @override
  String get settingsVersionChecking => 'Überprüfe…';

  @override
  String get transactionAttachments => 'Anhänge';

  @override
  String get transactionDeleteConfirm =>
      'Soll diese Transaktion wirklich gelöscht werden?';

  @override
  String get transactionDialogAttachmentsDelete => 'Anhang löschen';

  @override
  String get transactionDialogAttachmentsDeleteConfirm =>
      'Soll dieser Anhang wirklich gelöscht werden?';

  @override
  String get transactionDialogAttachmentsErrorDownload =>
      'Datei konnte nicht geladen werden.';

  @override
  String transactionDialogAttachmentsErrorOpen(String error) {
    return 'Datei konnte nicht geöffnet werden: $error';
  }

  @override
  String transactionDialogAttachmentsErrorUpload(String error) {
    return 'Datei konnte nicht hochgeladen werden: $error';
  }

  @override
  String get transactionDialogAttachmentsTitle => 'Anhänge';

  @override
  String get transactionDialogBillNoBill => 'Ohne Rechnung';

  @override
  String get transactionDialogBillTitle => 'Mit Rechnung verknüpfen';

  @override
  String get transactionDialogCurrencyTitle => 'Währung auswählen';

  @override
  String get transactionDialogTagsAdd => 'Schlagwort hinzufügen';

  @override
  String get transactionDialogTagsHint => 'Schlagwort suchen/hinzufügen';

  @override
  String get transactionDialogTagsTitle => 'Schlagwörter auswählen';

  @override
  String get transactionDuplicate => 'Duplizieren';

  @override
  String get transactionErrorInvalidAccount => 'Ungültiges Konto';

  @override
  String get transactionErrorInvalidBudget => 'Ungültiges Budget';

  @override
  String get transactionErrorNoAccounts => 'Please fill in the accounts first.';

  @override
  String get transactionErrorNoAssetAccount =>
      'Please select an asset account.';

  @override
  String get transactionErrorTitle => 'Bitte gebe einen Titel an.';

  @override
  String get transactionFormLabelAccountDestination => 'Ziel-Konto';

  @override
  String get transactionFormLabelAccountForeign => 'Fremdes Konto';

  @override
  String get transactionFormLabelAccountOwn => 'Eigenes Konto';

  @override
  String get transactionFormLabelAccountSource => 'Quell-Konto';

  @override
  String get transactionFormLabelNotes => 'Notizen';

  @override
  String get transactionFormLabelTags => 'Schlagwörter';

  @override
  String get transactionFormLabelTitle => 'Titel der Transaktion';

  @override
  String get transactionSplitAdd => 'Aufteilung hinzufügen';

  @override
  String get transactionSplitChangeCurrency => 'Währung der Aufteilung ändern';

  @override
  String get transactionSplitChangeDestinationAccount =>
      'Change Split Destination Account';

  @override
  String get transactionSplitChangeSourceAccount =>
      'Change Split Source Account';

  @override
  String get transactionSplitChangeTarget => 'Zielkonto der Aufteilung ändern';

  @override
  String get transactionSplitDelete => 'Aufteilung löschen';

  @override
  String get transactionTitleAdd => 'Transaktion hinzufügen';

  @override
  String get transactionTitleDelete => 'Transaktion löschen';

  @override
  String get transactionTitleEdit => 'Transaktion bearbeiten';

  @override
  String get transactionTypeDeposit => 'Einnahme';

  @override
  String get transactionTypeTransfer => 'Umbuchung';

  @override
  String get transactionTypeWithdrawal => 'Ausgabe';
}
