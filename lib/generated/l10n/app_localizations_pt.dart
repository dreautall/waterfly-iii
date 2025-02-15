// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class SPt extends S {
  SPt([String locale = 'pt']) : super(locale);

  @override
  String get accountRoleAssetCashWallet => 'Carteira de Dinheiro';

  @override
  String get accountRoleAssetCC => 'Cartão de crédito';

  @override
  String get accountRoleAssetDefault => 'Conta de ativos padrão';

  @override
  String get accountRoleAssetSavings => 'Conta poupança';

  @override
  String get accountRoleAssetShared => 'Contas de ativos compartilhadas';

  @override
  String get accountsLabelAsset => 'Contas de Ativos';

  @override
  String get accountsLabelExpense => 'Contas de Despesas';

  @override
  String get accountsLabelLiabilities => 'Passivos';

  @override
  String get accountsLabelRevenue => 'Contas de Receita';

  @override
  String accountsLiabilitiesInterest(double interest, String period) {
    String _temp0 = intl.Intl.selectLogic(
      period,
      {
        'weekly': 'semanais',
        'monthly': 'ao mês',
        'quarterly': 'por trimestre',
        'halfyear': 'por semestre',
        'yearly': 'ao ano',
        'other': 'desconhecido',
      },
    );
    return '$interest% de juros $_temp0';
  }

  @override
  String billsAmountAndFrequency(
      String minValue, String maxvalue, String frequency, num skip) {
    String _temp0 = intl.Intl.selectLogic(
      frequency,
      {
        'weekly': 'weekly',
        'monthly': 'monthly',
        'quarterly': 'quarterly',
        'halfyear': 'half-yearly',
        'yearly': 'yearly',
        'other': 'unknown',
      },
    );
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', skips over $skip',
      zero: '',
    );
    return 'Bill matches transactions between $minValue and $maxvalue. Repeats $_temp0$_temp1.';
  }

  @override
  String get billsChangeLayoutTooltip => 'Change layout';

  @override
  String get billsChangeSortOrderTooltip => 'Change sort order';

  @override
  String get billsErrorLoading => 'Error loading bills.';

  @override
  String billsExactAmountAndFrequency(
      String value, String frequency, num skip) {
    String _temp0 = intl.Intl.selectLogic(
      frequency,
      {
        'weekly': 'weekly',
        'monthly': 'monthly',
        'quarterly': 'quarterly',
        'halfyear': 'half-yearly',
        'yearly': 'yearly',
        'other': 'unknown',
      },
    );
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', skips over $skip',
      zero: '',
    );
    return 'Bill matches transactions of $value. Repeats $_temp0$_temp1.';
  }

  @override
  String billsExpectedOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Expected $dateString';
  }

  @override
  String billsFrequency(String frequency) {
    String _temp0 = intl.Intl.selectLogic(
      frequency,
      {
        'weekly': 'Weekly',
        'monthly': 'Monthly',
        'quarterly': 'Quarterly',
        'halfyear': 'Half-yearly',
        'yearly': 'Yearly',
        'other': 'Unknown',
      },
    );
    return '$_temp0';
  }

  @override
  String billsFrequencySkip(String frequency, num skip) {
    String _temp0 = intl.Intl.selectLogic(
      frequency,
      {
        'weekly': 'Weekly',
        'monthly': 'Monthly',
        'quarterly': 'Quarterly',
        'halfyear': 'Half-yearly',
        'yearly': 'Yearly',
        'other': 'Unknown',
      },
    );
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
  String get billsIsActive => 'Bill is active';

  @override
  String get billsLayoutGroupSubtitle =>
      'Bills displayed in their assigned groups.';

  @override
  String get billsLayoutGroupTitle => 'Group';

  @override
  String get billsLayoutListSubtitle =>
      'Bills displayed in a list sorted by certain criteria.';

  @override
  String get billsLayoutListTitle => 'List';

  @override
  String get billsListEmpty => 'The list is currently empty.';

  @override
  String get billsNextExpectedMatch => 'Next expected match';

  @override
  String get billsNotActive => 'Bill is inactive';

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
  String get catOther => 'Outros';

  @override
  String errorAPIInvalidResponse(String message) {
    return 'Resposta inválida da API: $message';
  }

  @override
  String get errorAPIUnavailable => 'API indisponível';

  @override
  String get errorFieldRequired => 'Este campo é obrigatório.';

  @override
  String get errorInvalidURL => 'URL inválida';

  @override
  String errorMinAPIVersion(String requiredVersion) {
    return 'Minimum Firefly API Version v$requiredVersion required. Please upgrade.';
  }

  @override
  String errorStatusCode(int code) {
    return 'Código de Status: $code';
  }

  @override
  String get errorUnknown => 'Erro desconhecido.';

  @override
  String get formButtonHelp => 'Ajuda';

  @override
  String get formButtonLogin => 'Entrar';

  @override
  String get formButtonLogout => 'Sair';

  @override
  String get formButtonRemove => 'Remover';

  @override
  String get formButtonResetLogin => 'Redefinir acesso';

  @override
  String get formButtonTransactionAdd => 'Adicionar Transação';

  @override
  String get formButtonTryAgain => 'Tentar novamente';

  @override
  String get generalAccount => 'Conta';

  @override
  String get generalAssets => 'Assets';

  @override
  String get generalBalance => 'Saldo';

  @override
  String generalBalanceOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Balance on $dateString';
  }

  @override
  String get generalBill => 'Bill';

  @override
  String get generalBudget => 'Orçamento';

  @override
  String get generalCategory => 'Categoria';

  @override
  String get generalCurrency => 'Moeda';

  @override
  String get generalDefault => 'padrão';

  @override
  String get generalDismiss => 'Dispensar';

  @override
  String get generalEarned => 'Earned';

  @override
  String get generalError => 'Erro';

  @override
  String get generalExpenses => 'Despesas';

  @override
  String get generalIncome => 'Receitas';

  @override
  String get generalLiabilities => 'Liabilities';

  @override
  String get generalMultiple => 'vários(as)';

  @override
  String get generalNever => 'nunca';

  @override
  String get generalReconcile => 'Reconciled';

  @override
  String get generalReset => 'Reset';

  @override
  String get generalSpent => 'Spent';

  @override
  String get generalSum => 'Soma';

  @override
  String get generalTarget => 'Objetivo';

  @override
  String get generalUnknown => 'Desconhecido(a)';

  @override
  String homeMainBillsInterval(String period) {
    String _temp0 = intl.Intl.selectLogic(
      period,
      {
        'weekly': 'weekly',
        'monthly': 'monthly',
        'quarterly': 'quarterly',
        'halfyear': 'half-year',
        'yearly': 'yearly',
        'other': 'unknown',
      },
    );
    return ' ($_temp0)';
  }

  @override
  String get homeMainBillsTitle => 'Bills for the next week';

  @override
  String homeMainBudgetInterval(DateTime from, DateTime to, String period) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return ' ($fromString a $toString, $period)';
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
    String _temp0 = intl.Intl.selectLogic(
      status,
      {
        'over': 'acima de',
        'other': 'restantes de',
      },
    );
    return '$current $_temp0 $available';
  }

  @override
  String get homeMainBudgetTitle => 'Orçamentos para o mês atual';

  @override
  String get homeMainChartAccountsTitle => 'Resumo da Conta';

  @override
  String get homeMainChartCategoriesTitle =>
      'Resumo da categoria para o mês atual';

  @override
  String get homeMainChartDailyAvg => 'Média de 7 dias';

  @override
  String get homeMainChartDailyTitle => 'Resumo Diário';

  @override
  String get homeMainChartNetEarningsTitle => 'Net Earnings';

  @override
  String get homeMainChartNetWorthTitle => 'Net Worth';

  @override
  String get homePiggyAdjustDialogTitle => 'Guardar/Gastar Dinheiro';

  @override
  String homePiggyDateStart(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Data de início: $dateString';
  }

  @override
  String homePiggyDateTarget(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Data de término: $dateString';
  }

  @override
  String homePiggyLinked(String account) {
    return 'Vinculado a $account';
  }

  @override
  String get homePiggyNoAccounts => 'Nenhum cofrinho configurado.';

  @override
  String get homePiggyNoAccountsSubtitle => 'Crie alguns na interface web!';

  @override
  String homePiggyRemaining(String amount) {
    return 'Restante para poupar: $amount';
  }

  @override
  String homePiggySaved(String amount) {
    return 'Poupado até agora: $amount';
  }

  @override
  String homePiggyTarget(String amount) {
    return 'Valor almejado: $amount';
  }

  @override
  String get homeTabLabelBalance => 'Balanço Financeiro';

  @override
  String get homeTabLabelMain => 'Geral';

  @override
  String get homeTabLabelPiggybanks => 'Cofrinhos';

  @override
  String get homeTabLabelTransactions => 'Transações';

  @override
  String get homeTransactionsActionFilter => 'Filtros';

  @override
  String get homeTransactionsDialogFilterAccountsAll => '<Todas as Contas>';

  @override
  String get homeTransactionsDialogFilterBillsAll => '<All Bills>';

  @override
  String get homeTransactionsDialogFilterBillUnset => '<No Bill set>';

  @override
  String get homeTransactionsDialogFilterBudgetsAll => '<Todos os Orçamentos>';

  @override
  String get homeTransactionsDialogFilterBudgetUnset => '<No Budget set>';

  @override
  String get homeTransactionsDialogFilterCategoriesAll =>
      '<Todas as Categorias>';

  @override
  String get homeTransactionsDialogFilterCategoryUnset => '<No Category set>';

  @override
  String get homeTransactionsDialogFilterCurrenciesAll => '<Todas as Moedas>';

  @override
  String get homeTransactionsDialogFilterFutureTransactions =>
      'Show future transactions';

  @override
  String get homeTransactionsDialogFilterSearch => 'Busca';

  @override
  String get homeTransactionsDialogFilterTitle => 'Filtrar';

  @override
  String get homeTransactionsEmpty => 'Nenhuma transação encontrada.';

  @override
  String homeTransactionsMultipleCategories(int num) {
    return '$num categorias';
  }

  @override
  String get homeTransactionsSettingsShowTags =>
      'Show tags in transaction list';

  @override
  String get liabilityDirectionCredit => 'É devido a mim';

  @override
  String get liabilityDirectionDebit => 'Devo isso';

  @override
  String get liabilityTypeDebt => 'Dívida';

  @override
  String get liabilityTypeLoan => 'Empréstimo';

  @override
  String get liabilityTypeMortgage => 'Hipoteca';

  @override
  String get loginAbout =>
      'Para usar o Waterfly III de maneira produtiva, você precisa de seu próprio servidor com uma instância do Firefly III ou o add-on Firefly III para o Home Assistant.\n\nPor favor, insira a URL completa, bem como um token de acesso pessoal (Opções -> Perfil -> OAuth -> Tokens de acesso pessoal) abaixo.';

  @override
  String get loginFormLabelAPIKey => 'Chave de API válida';

  @override
  String get loginFormLabelHost => 'URL do servidor';

  @override
  String get loginWelcome => 'Bem vindo ao Waterfly III';

  @override
  String get logoutConfirmation => 'Tem certeza que deseja sair?';

  @override
  String get navigationAccounts => 'Contas';

  @override
  String get navigationBills => 'Bills';

  @override
  String get navigationCategories => 'Categories';

  @override
  String get navigationMain => 'Painel Principal';

  @override
  String get navigationSettings => 'Configurações';

  @override
  String get no => 'No';

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

    return '$percString de $of';
  }

  @override
  String get settingsDialogDebugInfo =>
      'Você pode habilitar e enviar logs de depuração aqui. Eles têm um impacto negativo no desempenho, então, por favor, não os habilite a menos que seja conselhado a fazê-lo. Ao desativá-los, os logs armazenados serão apagados.';

  @override
  String get settingsDialogDebugMailCreate => 'Criar e-mail';

  @override
  String get settingsDialogDebugMailDisclaimer =>
      'AVISO: Um rascunho de e-mail será aberto com o arquivo de log anexo (em formato texto). Os logs podem conter informações confidenciais, tais como o host da sua instância do Firefly (embora eu tente evitar o log de segredos, como a chave de api). Por favor, leia o log com cuidado e censure quaisquer informações que você não deseje compartilhar e/ou não seja relevante ao problema que você deseja relatar.\n\nPor favor, não envie logs sem antes combinar via e-mail/GitHub. Eu irei apagar quaisquer logs que me forem enviados sem contexto, por motivos de privacidade. Nunca envie o log não censurado ao GitHub ou qualquer outro lugar.';

  @override
  String get settingsDialogDebugSendButton => 'Enviar Logs por E-mail';

  @override
  String get settingsDialogDebugTitle => 'Logs de Depuração';

  @override
  String get settingsDialogLanguageTitle => 'Selecionar Idioma';

  @override
  String get settingsDialogThemeTitle => 'Selecionar Tema';

  @override
  String get settingsFAQ => 'FAQ';

  @override
  String get settingsFAQHelp => 'Opens in Browser. Only available in English.';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLockscreen => 'Tela de bloqueio';

  @override
  String get settingsLockscreenHelp => 'Exigir autenticação ao abrir o app';

  @override
  String get settingsLockscreenInitial =>
      'Por favor, autentique-se para ativar a tela de bloqueio.';

  @override
  String get settingsNLAppAccount => 'Conta Padrão';

  @override
  String get settingsNLAppAccountDynamic => '<Dinâmica>';

  @override
  String get settingsNLAppAdd => 'Adicionar Aplicativo';

  @override
  String get settingsNLAppAddHelp =>
      'Clique para adicionar um aplicativo para monitorar. Apenas aplicativos onde isso for possível irão aparecer na lista.';

  @override
  String get settingsNLAppAddInfo =>
      'Faça algumas transações que gerem notificações no seu celular para popular essa lista. Se o app ainda não aparecer, por favor, reporte-o para app@vogt.pw.';

  @override
  String get settingsNLAutoAdd => 'Create transaction without interaction';

  @override
  String get settingsNLDescription =>
      'Esse serviço permite que você obtenha transações a partir de notificações push recebidas. Além disso, você pode selecionar uma conta padrão para a qual a transação deve ser atribuída - se nenhum valor for definido, ele tentará inferir a conta a partir da notificação.';

  @override
  String get settingsNLEmptyNote => 'Keep note field empty';

  @override
  String get settingsNLPermissionGrant => 'Toque para permitir.';

  @override
  String get settingsNLPermissionNotGranted => 'Permissão não concedida.';

  @override
  String get settingsNLPermissionRemove => 'Remover permissão?';

  @override
  String get settingsNLPermissionRemoveHelp =>
      'Para desabilitar este serviço, clique no app e remova a permissão na tela seguinte.';

  @override
  String get settingsNLPrefillTXTitle =>
      'Prefill transaction title with notification title';

  @override
  String get settingsNLServiceChecking => 'Verificando status…';

  @override
  String settingsNLServiceCheckingError(String error) {
    return 'Erro ao verificar status: $error';
  }

  @override
  String get settingsNLServiceRunning => 'Serviço em execução.';

  @override
  String get settingsNLServiceStatus => 'Status do Serviço';

  @override
  String get settingsNLServiceStopped => 'Serviço desativado.';

  @override
  String get settingsNotificationListener => 'Monitorar Notificações';

  @override
  String get settingsTheme => 'Tema do aplicativo';

  @override
  String get settingsThemeDynamicColors => 'Cores Dinâmicas';

  @override
  String settingsThemeValue(String theme) {
    String _temp0 = intl.Intl.selectLogic(
      theme,
      {
        'dark': 'Modo escuro',
        'light': 'Modo claro',
        'other': 'Padrão do Sistema',
      },
    );
    return '$_temp0';
  }

  @override
  String get settingsUseServerTimezone => 'Use server timezone';

  @override
  String get settingsUseServerTimezoneHelp =>
      'Show all times in the server timezone. This mimics the behavior of the webinterface.';

  @override
  String get settingsVersion => 'Versão do Aplicativo';

  @override
  String get settingsVersionChecking => 'verificando…';

  @override
  String get transactionAttachments => 'Anexos';

  @override
  String get transactionDeleteConfirm =>
      'Tem certeza de que deseja apagar esta transação?';

  @override
  String get transactionDialogAttachmentsDelete => 'Apagar Anexo';

  @override
  String get transactionDialogAttachmentsDeleteConfirm =>
      'Tem certeza de que deseja excluir esse anexo?';

  @override
  String get transactionDialogAttachmentsErrorDownload =>
      'Não foi possível baixar o arquivo.';

  @override
  String transactionDialogAttachmentsErrorOpen(String error) {
    return 'Não foi possível abrir o arquivo: $error';
  }

  @override
  String transactionDialogAttachmentsErrorUpload(String error) {
    return 'Não foi possível enviar o arquivo: $error';
  }

  @override
  String get transactionDialogAttachmentsTitle => 'Anexos';

  @override
  String get transactionDialogBillNoBill => 'No bill';

  @override
  String get transactionDialogBillTitle => 'Link to Bill';

  @override
  String get transactionDialogCurrencyTitle => 'Selecione a moeda';

  @override
  String get transactionDialogTagsAdd => 'Adicionar Tag';

  @override
  String get transactionDialogTagsHint => 'Buscar/Adicionar Tag';

  @override
  String get transactionDialogTagsTitle => 'Selecionar tags';

  @override
  String get transactionDuplicate => 'Duplicar';

  @override
  String get transactionErrorInvalidAccount => 'Conta inválida';

  @override
  String get transactionErrorInvalidBudget => 'Orçamento Inválido';

  @override
  String get transactionErrorTitle => 'Por favor, especifique um título.';

  @override
  String get transactionFormLabelAccountDestination => 'Conta de destino';

  @override
  String get transactionFormLabelAccountForeign => 'Conta externa';

  @override
  String get transactionFormLabelAccountOwn => 'Conta própria';

  @override
  String get transactionFormLabelAccountSource => 'Conta de origem';

  @override
  String get transactionFormLabelNotes => 'Notas';

  @override
  String get transactionFormLabelTags => 'Tags';

  @override
  String get transactionFormLabelTitle => 'Título da Transação';

  @override
  String get transactionSplitAdd => 'Adicionar divisão';

  @override
  String get transactionSplitChangeCurrency => 'Alterar Moeda da Divisão';

  @override
  String get transactionSplitChangeTarget => 'Alterar Conta Alvo da Divisão';

  @override
  String get transactionSplitDelete => 'Excluir divisão';

  @override
  String get transactionTitleAdd => 'Adicionar Transação';

  @override
  String get transactionTitleDelete => 'Excluir Transação';

  @override
  String get transactionTitleEdit => 'Editar Transação';

  @override
  String get transactionTypeDeposit => 'Depósito';

  @override
  String get transactionTypeTransfer => 'Transferência';

  @override
  String get transactionTypeWithdrawal => 'Retirada';
}
