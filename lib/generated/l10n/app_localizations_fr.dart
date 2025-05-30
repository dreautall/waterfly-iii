// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class SFr extends S {
  SFr([String locale = 'fr']) : super(locale);

  @override
  String get accountRoleAssetCashWallet => 'Porte-monnaie';

  @override
  String get accountRoleAssetCC => 'Carte de crédit';

  @override
  String get accountRoleAssetDefault => 'Compte d\'actif par défaut';

  @override
  String get accountRoleAssetSavings => 'Compte d\'épargne';

  @override
  String get accountRoleAssetShared => 'Compte d\'actif partagé';

  @override
  String get accountsLabelAsset => 'Comptes d\'actifs';

  @override
  String get accountsLabelExpense => 'Comptes de dépenses';

  @override
  String get accountsLabelLiabilities => 'Passifs';

  @override
  String get accountsLabelRevenue => 'Comptes de recettes';

  @override
  String accountsLiabilitiesInterest(double interest, String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'semaine',
      'monthly': 'mois',
      'quarterly': 'trimestre',
      'halfyear': 'semestre',
      'yearly': 'année',
      'other': 'inconnue',
    });
    return '$interest% d\'intérêts par $_temp0';
  }

  @override
  String billsAmountAndFrequency(
    String minValue,
    String maxvalue,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'toutes les semaines',
      'monthly': 'tous les mois',
      'quarterly': 'tous les trimestres',
      'halfyear': 'tous les six mois',
      'yearly': 'tous les ans',
      'other': 'autre',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', ignorer $skip répétitions',
      zero: '',
      one: '',
    );
    return 'La facture correspond aux transactions entre $minValue et $maxvalue. Se répète $_temp0$_temp1.';
  }

  @override
  String get billsChangeLayoutTooltip => 'Modifier la mise en page';

  @override
  String get billsChangeSortOrderTooltip => 'Changer l\'ordre de tri';

  @override
  String get billsErrorLoading => 'Erreur lors du chargement des factures.';

  @override
  String billsExactAmountAndFrequency(
    String value,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'toutes les semaines',
      'monthly': 'tous les mois',
      'quarterly': 'tous les trimestres',
      'halfyear': 'tous les six mois',
      'yearly': 'tous les ans',
      'other': 'autre',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', ignorer $skip répétitions',
      zero: '',
      one: '',
    );
    return 'La facture correspond à des transactions de $value. Se répète $_temp0$_temp1.';
  }

  @override
  String billsExpectedOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Prévu le $dateString';
  }

  @override
  String billsFrequency(String frequency) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Hebdomadaire',
      'monthly': 'Mensuelle',
      'quarterly': 'Trimestrielle',
      'halfyear': 'Semestrielle',
      'yearly': 'Annuelle',
      'other': 'Autre',
    });
    return '$_temp0';
  }

  @override
  String billsFrequencySkip(String frequency, num skip) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Hebdomadaire',
      'monthly': 'Mensuelle',
      'quarterly': 'Trimestrielle',
      'halfyear': 'Semestrielle',
      'yearly': 'Annuelle',
      'other': 'Autre',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', ignorer $skip répétitions',
      zero: '',
      one: '',
    );
    return '$_temp0$_temp1';
  }

  @override
  String get billsInactive => 'Inactive';

  @override
  String get billsIsActive => 'Facture active';

  @override
  String get billsLayoutGroupSubtitle =>
      'Factures affichées par groupe assigné.';

  @override
  String get billsLayoutGroupTitle => 'Groupe';

  @override
  String get billsLayoutListSubtitle =>
      'Factures affichées dans une liste triée selon certains critères.';

  @override
  String get billsLayoutListTitle => 'Liste';

  @override
  String get billsListEmpty => 'La liste est actuellement vide.';

  @override
  String get billsNextExpectedMatch => 'Prochaine association attendue';

  @override
  String get billsNotActive => 'Facture inactive';

  @override
  String get billsNotExpected => 'Non attendu cette période';

  @override
  String get billsNoTransactions => 'Aucune transaction trouvée.';

  @override
  String billsPaidOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Payée le $dateString';
  }

  @override
  String get billsSortAlphabetical => 'Alphabétique';

  @override
  String get billsSortByTimePeriod => 'Par période';

  @override
  String get billsSortFrequency => 'Fréquence';

  @override
  String get billsSortName => 'Nom';

  @override
  String get billsUngrouped => 'Sans groupe';

  @override
  String get categoryDeleteConfirm =>
      'Êtes-vous sûr de vouloir supprimer cette catégorie ? Les transactions ne seront pas supprimées, mais n\'auront plus de catégorie.';

  @override
  String get categoryErrorLoading => 'Erreur de chargement des catégories.';

  @override
  String get categoryFormLabelIncludeInSum => 'Inclure dans le montant mensuel';

  @override
  String get categoryFormLabelName => 'Nom de catégorie';

  @override
  String get categoryMonthNext => 'Le mois prochain';

  @override
  String get categoryMonthPrev => 'Le mois précédent';

  @override
  String get categorySumExcluded => 'exclue';

  @override
  String get categoryTitleAdd => 'Ajouter une catégorie';

  @override
  String get categoryTitleDelete => 'Supprimer la catégorie';

  @override
  String get categoryTitleEdit => 'Modifier la catégorie';

  @override
  String get catNone => '<aucune catégorie>';

  @override
  String get catOther => 'Autre';

  @override
  String errorAPIInvalidResponse(String message) {
    return 'Réponse invalide de l\'API : $message';
  }

  @override
  String get errorAPIUnavailable => 'API indisponible';

  @override
  String get errorFieldRequired => 'Ce champ est obligatoire.';

  @override
  String get errorInvalidURL => 'URL invalide';

  @override
  String errorMinAPIVersion(String requiredVersion) {
    return 'Version minimale de l\'API Firefly v$requiredVersion requise. Veuillez mettre à niveau.';
  }

  @override
  String errorStatusCode(int code) {
    return 'Code d\'état : $code';
  }

  @override
  String get errorUnknown => 'Erreur inconnue.';

  @override
  String get formButtonHelp => 'Aide';

  @override
  String get formButtonLogin => 'Se connecter';

  @override
  String get formButtonLogout => 'Se déconnecter';

  @override
  String get formButtonRemove => 'Retirer';

  @override
  String get formButtonResetLogin => 'Réinitialiser l\'authentification';

  @override
  String get formButtonTransactionAdd => 'Ajouter une opération';

  @override
  String get formButtonTryAgain => 'Réessayer';

  @override
  String get generalAccount => 'Compte';

  @override
  String get generalAssets => 'Actifs';

  @override
  String get generalBalance => 'Solde';

  @override
  String generalBalanceOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Solde au $dateString';
  }

  @override
  String get generalBill => 'Facture';

  @override
  String get generalBudget => 'Budget';

  @override
  String get generalCategory => 'Catégorie';

  @override
  String get generalCurrency => 'Devise';

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
  String get generalDefault => 'par défaut';

  @override
  String get generalDestinationAccount => 'Destination Account';

  @override
  String get generalDismiss => 'Annuler';

  @override
  String get generalEarned => 'Gagné';

  @override
  String get generalError => 'Erreur';

  @override
  String get generalExpenses => 'Dépenses';

  @override
  String get generalIncome => 'Revenus';

  @override
  String get generalLiabilities => 'Passifs';

  @override
  String get generalMultiple => 'plusieurs';

  @override
  String get generalNever => 'jamais';

  @override
  String get generalReconcile => 'Rapproché';

  @override
  String get generalReset => 'Réinitialiser';

  @override
  String get generalSourceAccount => 'Source Account';

  @override
  String get generalSpent => 'Dépensé';

  @override
  String get generalSum => 'Total';

  @override
  String get generalTarget => 'Objectif';

  @override
  String get generalUnknown => 'Inconnu';

  @override
  String homeMainBillsInterval(String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'hebdomadaire',
      'monthly': 'mensuel',
      'quarterly': 'trimestriel',
      'halfyear': 'semestriel',
      'yearly': 'annuel',
      'other': 'inconnu',
    });
    return ' ($_temp0)';
  }

  @override
  String get homeMainBillsTitle => 'Factures pour la semaine prochaine';

  @override
  String homeMainBudgetInterval(DateTime from, DateTime to, String period) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return ' ($fromString au $toString, $period)';
  }

  @override
  String homeMainBudgetIntervalSingle(DateTime from, DateTime to) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return ' ($fromString au $toString)';
  }

  @override
  String homeMainBudgetSum(String current, String status, String available) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'over': 'au-dessus de',
      'other': 'restant sur',
    });
    return '$current $_temp0 $available';
  }

  @override
  String get homeMainBudgetTitle => 'Budgets du mois en cours';

  @override
  String get homeMainChartAccountsTitle => 'Résumé des comptes';

  @override
  String get homeMainChartCategoriesTitle =>
      'Résumé des catégories pour le mois en cours';

  @override
  String get homeMainChartDailyAvg => 'Moyenne sur 7 jours';

  @override
  String get homeMainChartDailyTitle => 'Résumé quotidien';

  @override
  String get homeMainChartNetEarningsTitle => 'Revenus nets';

  @override
  String get homeMainChartNetWorthTitle => 'Avoir net';

  @override
  String get homeMainChartTagsTitle => 'Tag Summary for current month';

  @override
  String get homePiggyAdjustDialogTitle => 'Économiser/Dépenser de l\'argent';

  @override
  String homePiggyDateStart(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Date de début : $dateString';
  }

  @override
  String homePiggyDateTarget(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Date cible : $dateString';
  }

  @override
  String get homeMainDialogSettingsTitle => 'Customize Dashboard';

  @override
  String homePiggyLinked(String account) {
    return 'Liée à $account';
  }

  @override
  String get homePiggyNoAccounts => 'Aucune tirelire n\'a été créée.';

  @override
  String get homePiggyNoAccountsSubtitle =>
      'Créez-en une depuis l\'interface Web !';

  @override
  String homePiggyRemaining(String amount) {
    return 'Reste à économiser : $amount';
  }

  @override
  String homePiggySaved(String amount) {
    return 'Économisé jusqu\'à présent : $amount';
  }

  @override
  String homePiggyTarget(String amount) {
    return 'Montant cible : $amount';
  }

  @override
  String get homeTabLabelBalance => 'Bilan';

  @override
  String get homeTabLabelMain => 'Accueil';

  @override
  String get homeTabLabelPiggybanks => 'Tirelires';

  @override
  String get homeTabLabelTransactions => 'Opérations';

  @override
  String get homeTransactionsActionFilter => 'Liste de filtres';

  @override
  String get homeTransactionsDialogFilterAccountsAll => '<Tous les comptes>';

  @override
  String get homeTransactionsDialogFilterBillsAll => '<Toutes les factures>';

  @override
  String get homeTransactionsDialogFilterBillUnset =>
      '<Aucune facture établie>';

  @override
  String get homeTransactionsDialogFilterBudgetsAll => '<Tous les budgets>';

  @override
  String get homeTransactionsDialogFilterBudgetUnset => '<Aucun budget défini>';

  @override
  String get homeTransactionsDialogFilterCategoriesAll =>
      '<Toutes les catégories>';

  @override
  String get homeTransactionsDialogFilterCategoryUnset =>
      '<Aucune catégorie définie>';

  @override
  String get homeTransactionsDialogFilterCurrenciesAll => '<Toutes le devises>';

  @override
  String get homeTransactionsDialogFilterDateRange => 'Date Range';

  @override
  String get homeTransactionsDialogFilterFutureTransactions =>
      'Afficher les futures transactions';

  @override
  String get homeTransactionsDialogFilterSearch => 'Terme de recherche';

  @override
  String get homeTransactionsDialogFilterTitle => 'Sélectionnez les filtres';

  @override
  String get homeTransactionsEmpty => 'Aucune transaction trouvée.';

  @override
  String homeTransactionsMultipleCategories(int num) {
    return '$num catégories';
  }

  @override
  String get homeTransactionsSettingsShowTags =>
      'Afficher les étiquettes dans la liste des transactions';

  @override
  String get liabilityDirectionCredit => 'On me doit cette dette';

  @override
  String get liabilityDirectionDebit => 'Je dois cette dette';

  @override
  String get liabilityTypeDebt => 'Dette';

  @override
  String get liabilityTypeLoan => 'Prêt';

  @override
  String get liabilityTypeMortgage => 'Emprunts';

  @override
  String get loginAbout =>
      'Pour utiliser Waterfly III, vous avez besoin de votre propre serveur avec une instance Firefly III ou le module complémentaire Firefly III pour Home Assistant.\n\nVeuillez renseigner l\'URL complète ainsi qu\'un jeton d\'accès personnel (Options -> Profil -> OAuth -> Jetons d\'accès personnel) ci-dessous.';

  @override
  String get loginFormLabelAPIKey => 'Clé API valide';

  @override
  String get loginFormLabelHost => 'URL du serveur';

  @override
  String get loginWelcome => 'Bienvenue sur Waterfly III';

  @override
  String get logoutConfirmation =>
      'Êtes-vous sûr de vouloir vous déconnecter ?';

  @override
  String get navigationAccounts => 'Comptes';

  @override
  String get navigationBills => 'Factures';

  @override
  String get navigationCategories => 'Catégories';

  @override
  String get navigationMain => 'Tableau de bord';

  @override
  String get navigationSettings => 'Options';

  @override
  String get no => 'Non';

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

    return '$percString sur $of';
  }

  @override
  String get settingsDialogDebugInfo =>
      'Vous pouvez activer et envoyer les journaux de débogage ici. Ces derniers ont un impact négatif sur les performances, veuillez ne pas les activer à moins que cela ne vous soit demandé. La désactivation de la journalisation supprimera le journal stocké.';

  @override
  String get settingsDialogDebugMailCreate => 'Créer un e-mail';

  @override
  String get settingsDialogDebugMailDisclaimer =>
      'AVERTISSEMENT : Un brouillon d\'e-mail s\'ouvrira avec le fichier journal en pièce jointe (au format texte). Les journaux peuvent contenir des informations sensibles, telles que le nom d\'hôte de votre instance Firefly (bien que j\'essaie d\'éviter de consigner des éléments confidentiels, tels que la clé API). Veuillez lire attentivement le journal et censurer toute information que vous ne souhaitez pas partager et/ou qui n\'est pas pertinente par rapport au problème que vous souhaitez signaler.\n\nVeuillez ne pas envoyer de journaux sans accord préalable via e-mail/GitHub. Je supprimerai tous les journaux envoyés sans contexte pour des raisons de confidentialité. N\'envoyez jamais de journal non censuré sur GitHub ou ailleurs.';

  @override
  String get settingsDialogDebugSendButton => 'Envoyer les journaux par e-mail';

  @override
  String get settingsDialogDebugTitle => 'Journaux de débogage';

  @override
  String get settingsDialogLanguageTitle => 'Choisir la langue';

  @override
  String get settingsDialogThemeTitle => 'Choisir un thème';

  @override
  String get settingsFAQ => 'FAQ';

  @override
  String get settingsFAQHelp => 'Opens in Browser. Only available in English.';

  @override
  String get settingsLanguage => 'Langage';

  @override
  String get settingsLockscreen => 'Écran de verrouillage';

  @override
  String get settingsLockscreenHelp =>
      'Exiger une authentification au démarrage de l\'application';

  @override
  String get settingsLockscreenInitial =>
      'Veuillez vous authentifier pour activer l\'écran de verrouillage.';

  @override
  String get settingsNLAppAccount => 'Compte par défaut';

  @override
  String get settingsNLAppAccountDynamic => '<Dynamique>';

  @override
  String get settingsNLAppAdd => 'Ajouter appli';

  @override
  String get settingsNLAppAddHelp =>
      'Cliquez pour ajouter une application à écouter. Seules les applications éligibles apparaîtront dans la liste.';

  @override
  String get settingsNLAppAddInfo =>
      'Effectuez des opérations pour lesquelles vous recevez des notifications sur votre téléphone afin d\'ajouter des applications à cette liste. Si l\'application ne s\'affiche toujours pas, veuillez le signaler à app@vogt.pw.';

  @override
  String get settingsNLAutoAdd => 'Créer une transaction sans interaction';

  @override
  String get settingsNLDescription =>
      'Ce service vous permet de récupérer les détails des opérations à partir des notifications push entrantes. De plus, vous pouvez sélectionner un compte par défaut auquel l\'opération doit être affectée - si aucune valeur n\'est définie, il essaie d\'extraire un compte de la notification.';

  @override
  String get settingsNLEmptyNote => 'Conserver le champ de note vide';

  @override
  String get settingsNLPermissionGrant =>
      'Appuyez pour accorder la permission.';

  @override
  String get settingsNLPermissionNotGranted => 'Permission non accordée.';

  @override
  String get settingsNLPermissionRemove => 'Supprimer la permission ?';

  @override
  String get settingsNLPermissionRemoveHelp =>
      'Pour désactiver ce service, cliquez sur l\'application et supprimez les autorisations dans l\'écran suivant.';

  @override
  String get settingsNLPrefillTXTitle =>
      'Pré-remplir le titre de la transaction avec le titre de la notification';

  @override
  String get settingsNLServiceChecking => 'Vérification de l\'état…';

  @override
  String settingsNLServiceCheckingError(String error) {
    return 'Erreur lors de la vérification de l\'état : $error';
  }

  @override
  String get settingsNLServiceRunning => 'Service en cours d\'exécution.';

  @override
  String get settingsNLServiceStatus => 'État du service';

  @override
  String get settingsNLServiceStopped => 'Le service est arrêté.';

  @override
  String get settingsNotificationListener =>
      'Service d\'écoute des notifications';

  @override
  String get settingsTheme => 'Thème de l\'appli';

  @override
  String get settingsThemeDynamicColors => 'Couleurs dyn.';

  @override
  String settingsThemeValue(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'dark': 'Sombre',
      'light': 'Clair',
      'other': 'Système',
    });
    return '$_temp0';
  }

  @override
  String get settingsUseServerTimezone =>
      'Utiliser le fuseau horaire du serveur';

  @override
  String get settingsUseServerTimezoneHelp =>
      'Afficher tous les horaires dans le fuseau horaire du serveur. Cela reproduit le comportement de l\'interface web.';

  @override
  String get settingsVersion => 'Version de l’appli';

  @override
  String get settingsVersionChecking => 'vérification…';

  @override
  String get transactionAttachments => 'Pièces jointes';

  @override
  String get transactionDeleteConfirm =>
      'Êtes-vous sûr de vouloir supprimer cette opération ?';

  @override
  String get transactionDialogAttachmentsDelete => 'Supprimer la pièce jointe';

  @override
  String get transactionDialogAttachmentsDeleteConfirm =>
      'Êtes-vous sûr de vouloir supprimer cette pièce jointe ?';

  @override
  String get transactionDialogAttachmentsErrorDownload =>
      'Impossible de télécharger le fichier.';

  @override
  String transactionDialogAttachmentsErrorOpen(String error) {
    return 'Impossible d\'ouvrir le fichier : $error';
  }

  @override
  String transactionDialogAttachmentsErrorUpload(String error) {
    return 'Impossible d\'envoyer le fichier : $error';
  }

  @override
  String get transactionDialogAttachmentsTitle => 'Pièces jointes';

  @override
  String get transactionDialogBillNoBill => 'Aucune facture';

  @override
  String get transactionDialogBillTitle => 'Lien vers la facture';

  @override
  String get transactionDialogCurrencyTitle => 'Sélectionnez la devise';

  @override
  String get transactionDialogTagsAdd => 'Ajouter une étiquette';

  @override
  String get transactionDialogTagsHint => 'Rechercher/Ajouter une étiquette';

  @override
  String get transactionDialogTagsTitle => 'Sélectionnez des étiquettes';

  @override
  String get transactionDuplicate => 'Dupliquer';

  @override
  String get transactionErrorInvalidAccount => 'Compte non valide';

  @override
  String get transactionErrorInvalidBudget => 'Budget non valide';

  @override
  String get transactionErrorNoAccounts => 'Please fill in the accounts first.';

  @override
  String get transactionErrorNoAssetAccount =>
      'Please select an asset account.';

  @override
  String get transactionErrorTitle => 'Veuillez indiquer un titre.';

  @override
  String get transactionFormLabelAccountDestination => 'Compte destinataire';

  @override
  String get transactionFormLabelAccountForeign => 'Compte externe';

  @override
  String get transactionFormLabelAccountOwn => 'Compte personnel';

  @override
  String get transactionFormLabelAccountSource => 'Compte source';

  @override
  String get transactionFormLabelNotes => 'Notes';

  @override
  String get transactionFormLabelTags => 'Étiquettes';

  @override
  String get transactionFormLabelTitle => 'Titre de l\'opération';

  @override
  String get transactionSplitAdd => 'Ajouter une opération fractionnée';

  @override
  String get transactionSplitChangeCurrency => 'Changer de devise';

  @override
  String get transactionSplitChangeDestinationAccount =>
      'Change Split Destination Account';

  @override
  String get transactionSplitChangeSourceAccount =>
      'Change Split Source Account';

  @override
  String get transactionSplitChangeTarget => 'Changer de compte cible';

  @override
  String get transactionSplitDelete => 'Supprimer l\'opération fractionnée';

  @override
  String get transactionTitleAdd => 'Ajouter une opération';

  @override
  String get transactionTitleDelete => 'Supprimer l\'opération';

  @override
  String get transactionTitleEdit => 'Modifier l\'opération';

  @override
  String get transactionTypeDeposit => 'Dépôt';

  @override
  String get transactionTypeTransfer => 'Transfert';

  @override
  String get transactionTypeWithdrawal => 'Dépense';
}
