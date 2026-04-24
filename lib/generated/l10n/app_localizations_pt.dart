// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class SPt extends S {
  SPt([String locale = 'pt']) : super(locale);

  @override
  String get accountRoleAssetCashWallet => 'Carteira de dinheiro';

  @override
  String get accountRoleAssetCC => 'Cartão de crédito';

  @override
  String get accountRoleAssetDefault => 'Conta de ativos padrão';

  @override
  String get accountRoleAssetSavings => 'Conta poupança';

  @override
  String get accountRoleAssetShared => 'Conta de ativos compartilhados';

  @override
  String get accountsLabelAsset => 'Contas de ativos';

  @override
  String get accountsLabelExpense => 'Contas de despesas';

  @override
  String get accountsLabelLiabilities => 'Passivos';

  @override
  String get accountsLabelRevenue => 'Conta de receitas';

  @override
  String accountsLiabilitiesInterest(double interest, String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'semana',
      'monthly': 'mês',
      'quarterly': 'trimestre',
      'halfyear': 'semestre',
      'yearly': 'ano',
      'other': 'desconhecido',
    });
    return '$interest% de interesse por $_temp0';
  }

  @override
  String billsAmountAndFrequency(
    String minValue,
    String maxvalue,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'semanalmente',
      'monthly': 'mensalmente',
      'quarterly': 'trimestralmente',
      'halfyear': 'semestralmente',
      'yearly': 'anualmente',
      'other': 'desconhecido',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', pulando $skip',
      one: ', pulando 1',
      zero: '',
    );
    return 'A assinatura corresponde a transações entre $minValue e $maxvalue. Repete-se $_temp0$_temp1.';
  }

  @override
  String get billsChangeLayoutTooltip => 'Alterar layout';

  @override
  String get billsChangeSortOrderTooltip => 'Alterar ordem de classificação';

  @override
  String get billsErrorLoading => 'Erro ao carregar assinaturas.';

  @override
  String billsExactAmountAndFrequency(
    String value,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'semanalmente',
      'monthly': 'mensalmente',
      'quarterly': 'trimestralmente',
      'halfyear': 'semestralmente',
      'yearly': 'anualmente',
      'other': 'desconhecido',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', pulando $skip',
      one: ', pulando 1',
      zero: '',
    );
    return 'A assinatura corresponde a transações de $value. Repete-se $_temp0$_temp1.';
  }

  @override
  String billsExpectedOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Esperado em $dateString';
  }

  @override
  String billsFrequency(String frequency) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Semanal',
      'monthly': 'Mensal',
      'quarterly': 'Trimestral',
      'halfyear': 'Semestral',
      'yearly': 'Anual',
      'other': 'Desconhecido',
    });
    return '$_temp0';
  }

  @override
  String billsFrequencySkip(String frequency, num skip) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Semanal',
      'monthly': 'Mensal',
      'quarterly': 'Trimestral',
      'halfyear': 'Semestral',
      'yearly': 'Anual',
      'other': 'Desconhecido',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', pulando $skip',
      one: ', pulando 1',
      zero: '',
    );
    return '$_temp0$_temp1';
  }

  @override
  String get billsInactive => 'Inativa';

  @override
  String get billsIsActive => 'A assinatura está ativa';

  @override
  String get billsLayoutGroupSubtitle =>
      'Assinaturas exibidas em seus grupos atribuídos.';

  @override
  String get billsLayoutGroupTitle => 'Grupo';

  @override
  String get billsLayoutListSubtitle =>
      'Assinaturas exibidas em uma lista ordenada por critérios específicos.';

  @override
  String get billsLayoutListTitle => 'Lista';

  @override
  String get billsListEmpty => 'A lista está vazia no momento.';

  @override
  String get billsNextExpectedMatch => 'Próxima correspondência esperada';

  @override
  String get billsNotActive => 'A assinatura está inativa';

  @override
  String get billsNotExpected => 'Não esperado neste período';

  @override
  String get billsNoTransactions => 'Nenhuma transação encontrada.';

  @override
  String billsPaidOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Pago em $dateString';
  }

  @override
  String get billsSortAlphabetical => 'Alfabética';

  @override
  String get billsSortByTimePeriod => 'Por período';

  @override
  String get billsSortFrequency => 'Frequência';

  @override
  String get billsSortName => 'Nome';

  @override
  String get billsUngrouped => 'Sem grupo';

  @override
  String get billsSettingsShowOnlyActive => 'Mostrar apenas ativas';

  @override
  String get billsSettingsShowOnlyActiveDesc =>
      'Mostra apenas as assinaturas ativas.';

  @override
  String get billsSettingsShowOnlyExpected => 'Mostrar apenas esperadas';

  @override
  String get billsSettingsShowOnlyExpectedDesc =>
      'Mostra apenas as assinaturas que são esperadas (ou pagas) este mês.';

  @override
  String get categoryDeleteConfirm =>
      'Tem certeza de que deseja excluir esta categoria? As transações não serão excluídas, mas ficarão sem categoria.';

  @override
  String get categoryErrorLoading => 'Erro ao carregar categorias.';

  @override
  String get categoryFormLabelIncludeInSum => 'Incluir na soma mensal';

  @override
  String get categoryFormLabelName => 'Nome da Categoria';

  @override
  String get categoryMonthNext => 'Próximo Mês';

  @override
  String get categoryMonthPrev => 'Mês Anterior';

  @override
  String get categorySumExcluded => 'excluído';

  @override
  String get categoryTitleAdd => 'Adicionar Categoria';

  @override
  String get categoryTitleDelete => 'Excluir Categoria';

  @override
  String get categoryTitleEdit => 'Editar Categoria';

  @override
  String get catNone => '<sem categoria>';

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
    return 'Versão mínima da API do Firefly v$requiredVersion necessária. Por favor, atualize.';
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
  String get formButtonRemove => 'Excluir';

  @override
  String get formButtonResetLogin => 'Redefinir login';

  @override
  String get formButtonTransactionAdd => 'Adicionar transação';

  @override
  String get formButtonTryAgain => 'Tentar novamente';

  @override
  String get generalAccount => 'Conta';

  @override
  String get generalAssets => 'Ativos';

  @override
  String get generalBalance => 'Saldo';

  @override
  String generalBalanceOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Saldo em $dateString';
  }

  @override
  String get generalBill => 'Assinatura';

  @override
  String get generalBudget => 'Orçamento';

  @override
  String get generalCategory => 'Categoria';

  @override
  String get generalCurrency => 'Moeda';

  @override
  String get generalDateRangeCurrentMonth => 'Mês atual';

  @override
  String get generalDateRangeLast30Days => 'Últimos 30 dias';

  @override
  String get generalDateRangeCurrentYear => 'Ano atual';

  @override
  String get generalDateRangeLastYear => 'Ano passado';

  @override
  String get generalDateRangeAll => 'Tudo';

  @override
  String get generalDefault => 'padrão';

  @override
  String get generalDestinationAccount => 'Conta de destino';

  @override
  String get generalDismiss => 'Dispensar';

  @override
  String get generalEarned => 'Recebido';

  @override
  String get generalError => 'Erro';

  @override
  String get generalExpenses => 'Despesas';

  @override
  String get generalIncome => 'Receita';

  @override
  String get generalLiabilities => 'Passivos';

  @override
  String get generalMultiple => 'múltiplos';

  @override
  String get generalNever => 'nunca';

  @override
  String get generalReconcile => 'Conciliado';

  @override
  String get generalReset => 'Limpar';

  @override
  String get generalSourceAccount => 'Conta de origem';

  @override
  String get generalSpent => 'Gasto';

  @override
  String get generalSum => 'Soma';

  @override
  String get generalTarget => 'Meta';

  @override
  String get generalUnknown => 'Desconhecido';

  @override
  String homeMainBillsInterval(String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'semanal',
      'monthly': 'mensal',
      'quarterly': 'trimestral',
      'halfyear': 'semestral',
      'yearly': 'anual',
      'other': 'desconhecido',
    });
    return ' ($_temp0)';
  }

  @override
  String get homeMainBillsTitle => 'Assinaturas para a próxima semana';

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

    return ' ($fromString a $toString)';
  }

  @override
  String homeMainBudgetSum(String current, String status, String available) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'over': 'acima do orçamento de',
      'other': 'restantes de',
    });
    return '$current $_temp0 $available';
  }

  @override
  String get homeMainBudgetTitle => 'Orçamentos do mês atual';

  @override
  String get homeMainChartAccountsTitle => 'Resumo das Contas';

  @override
  String get homeMainChartCategoriesTitle =>
      'Resumo de Categorias do mês atual';

  @override
  String get homeMainChartDailyAvg => 'Média de 7 dias';

  @override
  String get homeMainChartDailyTitle => 'Resumo Diário';

  @override
  String get homeMainChartNetEarningsTitle => 'Ganhos Líquidos';

  @override
  String get homeMainChartNetWorthTitle => 'Patrimônio Líquido';

  @override
  String get homeMainChartTagsTitle => 'Resumo de Etiquetas do mês atual';

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

    return 'Data alvo: $dateString';
  }

  @override
  String get homeMainDialogSettingsTitle => 'Personalizar Painel';

  @override
  String homePiggyLinked(String account) {
    return 'Vinculado a $account';
  }

  @override
  String get homePiggyNoAccounts => 'Nenhum mealheiro configurado.';

  @override
  String get homePiggyNoAccountsSubtitle => 'Crie alguns na interface web!';

  @override
  String homePiggyRemaining(String amount) {
    return 'Falta guardar: $amount';
  }

  @override
  String homePiggySaved(String amount) {
    return 'Guardado até agora: $amount';
  }

  @override
  String get homePiggySavedMultiple => 'Guardado até agora:';

  @override
  String homePiggyTarget(String amount) {
    return 'Valor alvo: $amount';
  }

  @override
  String get homePiggyAccountStatus => 'Status da Conta';

  @override
  String get homePiggyAvailableAmounts => 'Montantes Disponíveis';

  @override
  String homePiggyAvailable(String amount) {
    return 'Disponível: $amount';
  }

  @override
  String homePiggyInPiggyBanks(String amount) {
    return 'Em mealheiros: $amount';
  }

  @override
  String get homeTabLabelBalance => 'Balanço';

  @override
  String get homeTabLabelMain => 'Início';

  @override
  String get homeTabLabelPiggybanks => 'Mealheiros';

  @override
  String get homeTabLabelTransactions => 'Transações';

  @override
  String get homeTransactionsActionFilter => 'Filtrar Lista';

  @override
  String get homeTransactionsDialogFilterAccountsAll => '<Todas as Contas>';

  @override
  String get homeTransactionsDialogFilterBillsAll => '<Todas as Assinaturas>';

  @override
  String get homeTransactionsDialogFilterBillUnset =>
      '<Sem Assinatura definida>';

  @override
  String get homeTransactionsDialogFilterBudgetsAll => '<Todos os Orçamentos>';

  @override
  String get homeTransactionsDialogFilterBudgetUnset =>
      '<Sem Orçamento definido>';

  @override
  String get homeTransactionsDialogFilterCategoriesAll =>
      '<Todas as Categorias>';

  @override
  String get homeTransactionsDialogFilterCategoryUnset =>
      '<Sem Categoria definida>';

  @override
  String get homeTransactionsDialogFilterCurrenciesAll => '<Todas as Moedas>';

  @override
  String get homeTransactionsDialogFilterDateRange => 'Intervalo de Datas';

  @override
  String get homeTransactionsDialogFilterFutureTransactions =>
      'Mostrar transações futuras';

  @override
  String get homeTransactionsDialogFilterSearch => 'Termo de pesquisa';

  @override
  String get homeTransactionsDialogFilterTitle => 'Selecionar filtros';

  @override
  String get homeTransactionsEmpty => 'Nenhuma transação encontrada.';

  @override
  String homeTransactionsMultipleCategories(int num) {
    String _temp0 = intl.Intl.pluralLogic(
      num,
      locale: localeName,
      other: '$num categorias',
      one: '1 categoria',
    );
    return '$_temp0';
  }

  @override
  String get homeTransactionsSettingsShowTags =>
      'Mostrar etiquetas na lista de transações';

  @override
  String get liabilityDirectionCredit => 'Tenho esta dívida a receber';

  @override
  String get liabilityDirectionDebit => 'Devo esta dívida';

  @override
  String get liabilityTypeDebt => 'Dívida';

  @override
  String get liabilityTypeLoan => 'Empréstimo';

  @override
  String get liabilityTypeMortgage => 'Hipoteca';

  @override
  String get loginAbout =>
      'Para usar o Waterfly III produtivamente, você precisa do seu próprio servidor com uma instância do Firefly III ou o complemento do Firefly III para o Home Assistant.\n\nPor favor, insira a URL completa, bem como um token de acesso pessoal (Configurações -> Perfil -> OAuth -> Token de acesso pessoal) abaixo.';

  @override
  String get loginFormButtonHideHeaders => 'Ocultar Cabeçalhos';

  @override
  String get loginFormButtonShowHeaders => 'Cabeçalhos Personalizados';

  @override
  String get loginFormLabelAPIKey => 'Chave de API Válida';

  @override
  String get loginFormLabelHeaders => 'Cabeçalhos Personalizados (opcional)';

  @override
  String get loginFormLabelHeadersHelp =>
      'Um por linha, formato: NomeDoCabecalho: valor';

  @override
  String get loginFormLabelHost => 'URL do Host';

  @override
  String get loginWelcome => 'Bem-vindo ao Waterfly III';

  @override
  String get logoutConfirmation => 'Tem certeza de que deseja sair?';

  @override
  String get navigationAccounts => 'Contas';

  @override
  String get navigationBills => 'Assinaturas';

  @override
  String get navigationCategories => 'Categorias';

  @override
  String get navigationMain => 'Painel';

  @override
  String get generalSettings => 'Configurações';

  @override
  String get no => 'Não';

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

    return '$percString de $of';
  }

  @override
  String get settingsDialogDebugInfo =>
      'Você pode habilitar e enviar logs de depuração aqui. Eles têm um impacto negativo no desempenho, portanto, não os habilite, a menos que seja aconselhado a fazê-lo. Desativar o registro excluirá o log armazenado.';

  @override
  String get settingsDialogDebugMailCreate => 'Criar E-mail';

  @override
  String get settingsDialogDebugMailDisclaimer =>
      'AVISO: Um rascunho de e-mail será aberto com o arquivo de log anexado (em formato de texto). Os logs podem conter informações confidenciais, como o nome do host da sua instância Firefly (embora eu tente evitar registrar quaisquer segredos, como a chave da API). Por favor, leia o log cuidadosamente e censure qualquer informação que você não queira compartilhar e/ou que não seja relevante para o problema que deseja relatar.\n\nPor favor, não envie logs sem acordo prévio via e-mail/GitHub. Excluirei quaisquer logs enviados sem contexto por motivos de privacidade. Nunca carregue o log sem censura no GitHub ou em qualquer outro lugar.';

  @override
  String get settingsDialogDebugSendButton => 'Enviar Logs por E-mail';

  @override
  String get settingsDialogDebugTitle => 'Registros de Depuração';

  @override
  String get settingsDialogLanguageTitle => 'Selecionar Idioma';

  @override
  String get settingsDialogThemeTitle => 'Selecionar Tema';

  @override
  String get settingsFAQ => 'Perguntas Frequentes';

  @override
  String get settingsFAQHelp =>
      'Abre no navegador. Disponível apenas em inglês.';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLockscreen => 'Tela de bloqueio';

  @override
  String get settingsLockscreenHelp =>
      'Exigir autenticação ao iniciar o aplicativo';

  @override
  String get settingsLockscreenInitial =>
      'Por favor, autentique-se para ativar a tela de bloqueio.';

  @override
  String get settingsNLAppAccount => 'Conta Padrão';

  @override
  String get settingsNLAppAccountDynamic => '<Dinâmico>';

  @override
  String get settingsNLAppAdd => 'Adicionar Aplicativo';

  @override
  String get settingsNLAppAddHelp =>
      'Clique para adicionar um aplicativo para monitorar. Apenas aplicativos elegíveis aparecerão na lista.';

  @override
  String get settingsNLAppAddInfo =>
      'Faça algumas transações onde você receba notificações no telefone para adicionar aplicativos a esta lista. Se o aplicativo ainda não aparecer, por favor, relate para app@vogt.pw.';

  @override
  String get settingsNLAutoAdd => 'Criar transação sem interação';

  @override
  String get settingsNLDescription =>
      'Este serviço permite buscar detalhes de transações a partir de notificações push recebidas. Além disso, você pode selecionar uma conta padrão à qual a transação deve ser atribuída - se nenhum valor for definido, ele tentará extrair uma conta da notificação.';

  @override
  String get settingsNLEmptyNote => 'Manter campo de nota vazio';

  @override
  String get settingsNLHistory => 'Histórico de Notificações';

  @override
  String get settingsNLHistoryEmpty =>
      'Nenhuma notificação registrada até o momento.';

  @override
  String settingsNLHistoryLongDescription(int notificationHistorySize) {
    String _temp0 = intl.Intl.pluralLogic(
      notificationHistorySize,
      locale: localeName,
      other:
          'Este é o histórico das últimas $notificationHistorySize notificações recebidas pelo aplicativo. Além disso, você pode criar transações a partir de notificações (válidas) ou ver o motivo pelo qual uma notificação não pôde ser processada.',
      one:
          'Este é o histórico da última notificação recebida pelo aplicativo. Além disso, você pode criar transações a partir de notificações (válidas) ou ver o motivo pelo qual uma notificação não pôde ser processada.',
    );
    return '$_temp0';
  }

  @override
  String settingsNLHistoryRejectedReason(String reason) {
    String _temp0 = intl.Intl.selectLogic(reason, {
      'noMoney': 'Nenhum valor monetário encontrado',
      'noCurrency': 'Nenhuma moeda encontrada',
      'appNotUsed': 'Aplicativo não monitorado',
      'other': 'Motivo desconhecido',
    });
    return 'Notificação ignorada: $_temp0.';
  }

  @override
  String get settingsNLHistoryShortDescription =>
      'Listar notificações anteriores';

  @override
  String get settingsNLPermissionGrant => 'Toque para conceder permissão.';

  @override
  String get settingsNLPermissionNotGranted => 'Permissão não concedida.';

  @override
  String get settingsNLPermissionRemove => 'Remover permissão?';

  @override
  String get settingsNLPermissionRemoveHelp =>
      'Para desativar este serviço, clique na aplicação e remova as permissões no ecrã seguinte.';

  @override
  String get settingsNLPrefillTXTitle =>
      'Preencher título da transação com título da notificação';

  @override
  String get settingsNLRegularExpression => 'Expressão Regular (opcional)';

  @override
  String get settingsNLRegularExpressionInvalid => 'Expressão Regular inválida';

  @override
  String get settingsNLServiceChecking => 'A verificar estado…';

  @override
  String settingsNLServiceCheckingError(String error) {
    return 'Erro ao verificar o estado: $error';
  }

  @override
  String get settingsNLServiceRunning => 'O serviço está em execução.';

  @override
  String get settingsNLServiceStatus => 'Estado do Serviço';

  @override
  String get settingsNLServiceStopped => 'O serviço está parado.';

  @override
  String get settingsNotificationListener =>
      'Serviço de Escuta de Notificações';

  @override
  String get settingsServerConnection => 'Ligação ao Servidor';

  @override
  String get settingsServerConnectionUpdated =>
      'Definições de ligação atualizadas.';

  @override
  String get settingsTheme => 'Tema da Aplicação';

  @override
  String get settingsThemeDynamicColors => 'Cores Dinâmicas';

  @override
  String settingsThemeValue(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'dark': 'Modo Escuro',
      'light': 'Modo Claro',
      'other': 'Predefinição do Sistema',
    });
    return '$_temp0';
  }

  @override
  String get settingsUseServerTimezone => 'Usar fuso horário do servidor';

  @override
  String get settingsUseServerTimezoneHelp =>
      'Mostrar todas as horas no fuso horário do servidor. Isto imita o comportamento da interface web.';

  @override
  String get settingsVersion => 'Versão da Aplicação';

  @override
  String get settingsVersionChecking => 'a verificar…';

  @override
  String get transactionAttachments => 'Anexos';

  @override
  String get transactionDeleteConfirm =>
      'Tem a certeza de que pretende eliminar esta transação?';

  @override
  String get transactionDialogAttachmentsDelete => 'Eliminar Anexo';

  @override
  String get transactionDialogAttachmentsDeleteConfirm =>
      'Tem a certeza de que pretende eliminar este anexo?';

  @override
  String get transactionDialogAttachmentsErrorDownload =>
      'Não foi possível descarregar o ficheiro.';

  @override
  String transactionDialogAttachmentsErrorOpen(String error) {
    return 'Não foi possível abrir o ficheiro: $error';
  }

  @override
  String transactionDialogAttachmentsErrorUpload(String error) {
    return 'Não foi possível carregar o ficheiro: $error';
  }

  @override
  String get transactionDialogAttachmentsTitle => 'Anexos';

  @override
  String get transactionDialogBillNoBill => 'Sem subscrição';

  @override
  String get transactionDialogBillTitle => 'Associar a uma Subscrição';

  @override
  String get transactionDialogCurrencyTitle => 'Selecionar moeda';

  @override
  String get transactionDialogPiggyNoPiggy => 'Sem mealheiro';

  @override
  String get transactionDialogPiggyTitle => 'Associar a um Mealheiro';

  @override
  String get transactionDialogTagsAdd => 'Adicionar Etiqueta';

  @override
  String get transactionDialogTagsHint => 'Pesquisar/Adicionar Etiqueta';

  @override
  String get transactionDialogTagsTitle => 'Selecionar etiquetas';

  @override
  String get transactionDuplicate => 'Duplicar';

  @override
  String get transactionErrorInvalidAccount => 'Conta inválida';

  @override
  String get transactionErrorInvalidBudget => 'Orçamento inválido';

  @override
  String get transactionErrorNoAccounts =>
      'Por favor, preencha primeiro as contas.';

  @override
  String get transactionErrorNoAssetAccount =>
      'Por favor, selecione uma conta de ativos.';

  @override
  String get transactionErrorTitle => 'Por favor, forneça um título.';

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
  String get transactionFormLabelTags => 'Etiquetas';

  @override
  String get transactionFormLabelTitle => 'Título da Transação';

  @override
  String get transactionSplitAdd => 'Adicionar transação dividida';

  @override
  String get transactionSplitChangeCurrency => 'Alterar moeda da divisão';

  @override
  String get transactionSplitChangeDestinationAccount =>
      'Alterar conta de destino da divisão';

  @override
  String get transactionSplitChangeSourceAccount =>
      'Alterar conta de origem da divisão';

  @override
  String get transactionSplitChangeTarget =>
      'Alterar conta de destino da divisão';

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
  String get transactionTypeWithdrawal => 'Saque';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class SPtBr extends SPt {
  SPtBr() : super('pt_BR');

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
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'semanais',
      'monthly': 'ao mês',
      'quarterly': 'por trimestre',
      'halfyear': 'por semestre',
      'yearly': 'ao ano',
      'other': 'desconhecido',
    });
    return '$interest% de juros $_temp0';
  }

  @override
  String billsAmountAndFrequency(
    String minValue,
    String maxvalue,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'semanalmente',
      'monthly': 'mensalmente',
      'quarterly': 'trimestralmente',
      'halfyear': 'semestralmente',
      'yearly': 'anualmente',
      'other': 'desconhecido',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', pula $skip',
      zero: '',
    );
    return 'A assinatura corresponde a transações entre $minValue e $maxvalue. Repete $_temp0$_temp1.';
  }

  @override
  String get billsChangeLayoutTooltip => 'Alterar layout';

  @override
  String get billsChangeSortOrderTooltip => 'Alterar ordem de classificação';

  @override
  String get billsErrorLoading => 'Erro ao carregar assinaturas.';

  @override
  String billsExactAmountAndFrequency(
    String value,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'semanalmente',
      'monthly': 'mensalmente',
      'quarterly': 'trimestralmente',
      'halfyear': 'semestralmente',
      'yearly': 'anualmente',
      'other': 'desconhecido',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', pula $skip',
      zero: '',
    );
    return 'A assinatura corresponde a transações de $value. Repete $_temp0$_temp1.';
  }

  @override
  String billsExpectedOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Vencimento em$dateString';
  }

  @override
  String billsFrequency(String frequency) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Semanal',
      'monthly': 'Mensal',
      'quarterly': 'Trimestral',
      'halfyear': 'Semestral',
      'yearly': 'Anual',
      'other': 'Desconhecida',
    });
    return '$_temp0';
  }

  @override
  String billsFrequencySkip(String frequency, num skip) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Semanal',
      'monthly': 'Mensal',
      'quarterly': 'Trimestral',
      'halfyear': 'Semestral',
      'yearly': 'Anual',
      'other': 'Desconhecida',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', pula $skip',
      zero: '',
    );
    return '$_temp0$_temp1';
  }

  @override
  String get billsInactive => 'Inativo';

  @override
  String get billsIsActive => 'A assinatura está ativa';

  @override
  String get billsLayoutGroupSubtitle =>
      'Assinaturas exibidas em seus grupos designados.';

  @override
  String get billsLayoutGroupTitle => 'Grupo';

  @override
  String get billsLayoutListSubtitle =>
      'Assinaturas exibidas em uma lista organizada por certos critérios.';

  @override
  String get billsLayoutListTitle => 'Lista';

  @override
  String get billsListEmpty => 'A lista está vazia atualmente.';

  @override
  String get billsNextExpectedMatch => 'Próxima combinação parecida';

  @override
  String get billsNotActive => 'A assinatura está inativa';

  @override
  String get billsNotExpected => 'Período não esperado';

  @override
  String get billsNoTransactions => 'Nenhuma transação encontrada.';

  @override
  String billsPaidOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Pago em $dateString';
  }

  @override
  String get billsSortAlphabetical => 'Em Ordem Alfabética';

  @override
  String get billsSortByTimePeriod => 'Por período de tempo';

  @override
  String get billsSortFrequency => 'Frequência';

  @override
  String get billsSortName => 'Nome';

  @override
  String get billsUngrouped => 'Sem Grupo';

  @override
  String get billsSettingsShowOnlyActive => 'Mostrar apenas ativas';

  @override
  String get billsSettingsShowOnlyActiveDesc =>
      'Mostra apenas as subscrições ativas.';

  @override
  String get billsSettingsShowOnlyExpected => 'Mostrar apenas as esperadas';

  @override
  String get billsSettingsShowOnlyExpectedDesc =>
      'Mostra apenas as subscrições que são esperadas (ou pagas) este mês.';

  @override
  String get categoryDeleteConfirm =>
      'Tem certeza de que deseja excluir esta categoria? As transações não serão excluídas, mas não terão mais uma categoria.';

  @override
  String get categoryErrorLoading => 'Erro ao carregar categorias.';

  @override
  String get categoryFormLabelIncludeInSum => 'Incluir na soma mensal';

  @override
  String get categoryFormLabelName => 'Nome da Categoria';

  @override
  String get categoryMonthNext => 'Próximo mês';

  @override
  String get categoryMonthPrev => 'Mês Anterior';

  @override
  String get categorySumExcluded => 'excluído';

  @override
  String get categoryTitleAdd => 'Adicionar Categoria';

  @override
  String get categoryTitleDelete => 'Excluir Categoria';

  @override
  String get categoryTitleEdit => 'Editar Categoria';

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
    return 'Versão mínima do Firefly API necessária: $requiredVersion. Por favor, atualize.';
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
  String get generalAssets => 'Ativos';

  @override
  String get generalBalance => 'Saldo';

  @override
  String generalBalanceOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Saldo em $dateString';
  }

  @override
  String get generalBill => 'Subscrição';

  @override
  String get generalBudget => 'Orçamento';

  @override
  String get generalCategory => 'Categoria';

  @override
  String get generalCurrency => 'Moeda';

  @override
  String get generalDateRangeCurrentMonth => 'Mês Atual';

  @override
  String get generalDateRangeLast30Days => 'Últimos 30 dias';

  @override
  String get generalDateRangeCurrentYear => 'Ano Atual';

  @override
  String get generalDateRangeLastYear => 'Ano passado';

  @override
  String get generalDateRangeAll => 'Todos';

  @override
  String get generalDefault => 'padrão';

  @override
  String get generalDestinationAccount => 'Conta de Destino';

  @override
  String get generalDismiss => 'Dispensar';

  @override
  String get generalEarned => 'Ganhos';

  @override
  String get generalError => 'Erro';

  @override
  String get generalExpenses => 'Despesas';

  @override
  String get generalIncome => 'Receitas';

  @override
  String get generalLiabilities => 'Passivos';

  @override
  String get generalMultiple => 'vários(as)';

  @override
  String get generalNever => 'nunca';

  @override
  String get generalReconcile => 'Reconciliado';

  @override
  String get generalReset => 'Redefinir';

  @override
  String get generalSourceAccount => 'Conta de Origem';

  @override
  String get generalSpent => 'Gastos';

  @override
  String get generalSum => 'Soma';

  @override
  String get generalTarget => 'Objetivo';

  @override
  String get generalUnknown => 'Desconhecido(a)';

  @override
  String homeMainBillsInterval(String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'semanal',
      'monthly': 'mensal',
      'quarterly': 'trimestral',
      'halfyear': 'semestral',
      'yearly': 'anual',
      'other': 'desconhecido',
    });
    return ' ($_temp0)';
  }

  @override
  String get homeMainBillsTitle => 'Subscrições para a próxima semana';

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

    return ' ($fromString a $toString)';
  }

  @override
  String homeMainBudgetSum(String current, String status, String available) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'over': 'acima de',
      'other': 'restantes de',
    });
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
  String get homeMainChartNetEarningsTitle => 'Lucro Líquido';

  @override
  String get homeMainChartNetWorthTitle => 'Património Líquido';

  @override
  String get homeMainChartTagsTitle => 'Resumo de Etiquetas para o mês atual';

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
  String get homeMainDialogSettingsTitle => 'Personalizar Painel';

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
  String get homePiggySavedMultiple => 'Guardado até agora:';

  @override
  String homePiggyTarget(String amount) {
    return 'Valor almejado: $amount';
  }

  @override
  String get homePiggyAccountStatus => 'Estado da Conta';

  @override
  String get homePiggyAvailableAmounts => 'Valores Disponíveis';

  @override
  String homePiggyAvailable(String amount) {
    return 'Disponível: $amount';
  }

  @override
  String homePiggyInPiggyBanks(String amount) {
    return 'Em mealheiros: $amount';
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
  String get homeTransactionsDialogFilterBillsAll => '<Todas as Subscrições>';

  @override
  String get homeTransactionsDialogFilterBillUnset =>
      '<Nenhuma Subscrição definida>';

  @override
  String get homeTransactionsDialogFilterBudgetsAll => '<Todos os Orçamentos>';

  @override
  String get homeTransactionsDialogFilterBudgetUnset =>
      '<Nenhum Orçamento definido>';

  @override
  String get homeTransactionsDialogFilterCategoriesAll =>
      '<Todas as Categorias>';

  @override
  String get homeTransactionsDialogFilterCategoryUnset =>
      '<Nenhuma Categoria definida>';

  @override
  String get homeTransactionsDialogFilterCurrenciesAll => '<All Currencies>';

  @override
  String get homeTransactionsDialogFilterDateRange => 'Intervalo de Datas';

  @override
  String get homeTransactionsDialogFilterFutureTransactions =>
      'Mostrar transações futuras';

  @override
  String get homeTransactionsDialogFilterSearch => 'Palavras-chave';

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
      'Mostrar etiquetas na lista de transações';

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
  String get loginFormButtonHideHeaders => 'Ocultar cabeçalhos';

  @override
  String get loginFormButtonShowHeaders => 'Cabeçalhos personalizados';

  @override
  String get loginFormLabelAPIKey => 'Chave de API válida';

  @override
  String get loginFormLabelHeaders => 'Cabeçalhos personalizados (opcional)';

  @override
  String get loginFormLabelHeadersHelp =>
      'Um por linha, formato: NomeDoCabeçalho: valor';

  @override
  String get loginFormLabelHost => 'URL do servidor';

  @override
  String get loginWelcome => 'Bem vindo ao Waterfly III';

  @override
  String get logoutConfirmation => 'Tem certeza que deseja sair?';

  @override
  String get navigationAccounts => 'Contas';

  @override
  String get navigationBills => 'Assinaturas';

  @override
  String get navigationCategories => 'Categorias';

  @override
  String get navigationMain => 'Painel';

  @override
  String get generalSettings => 'Configurações';

  @override
  String get no => 'Não';

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
  String get settingsFAQ => 'Perguntas Frequentes';

  @override
  String get settingsFAQHelp =>
      'Abre no navegador. Disponível apenas em inglês.';

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
  String get settingsNLAutoAdd => 'Criar transação sem interação';

  @override
  String get settingsNLDescription =>
      'Esse serviço permite que você obtenha transações a partir de notificações push recebidas. Além disso, você pode selecionar uma conta padrão para a qual a transação deve ser atribuída - se nenhum valor for definido, ele tentará inferir a conta a partir da notificação.';

  @override
  String get settingsNLEmptyNote => 'Manter campo de nota vazio';

  @override
  String get settingsNLHistory => 'Histórico de notificações';

  @override
  String get settingsNLHistoryEmpty =>
      'Nenhuma notificação registrada até o momento.';

  @override
  String settingsNLHistoryLongDescription(int notificationHistorySize) {
    String _temp0 = intl.Intl.pluralLogic(
      notificationHistorySize,
      locale: localeName,
      other:
          'Este é o histórico das últimas $notificationHistorySize notificações recebidas pelo aplicativo.',
      one: 'Este é o histórico da última notificação recebida pelo aplicativo.',
    );
    return '$_temp0 Adicionalmente, você pode criar transações a partir de notificações (válidas) ou ver o motivo pelo qual uma notificação não pôde ser processada.';
  }

  @override
  String settingsNLHistoryRejectedReason(String reason) {
    String _temp0 = intl.Intl.selectLogic(reason, {
      'noMoney': 'Nenhum valor monetário encontrado',
      'noCurrency': 'Nenhuma moeda encontrada',
      'appNotUsed': 'Aplicativo não monitorado',
      'other': 'Motivo desconhecido',
    });
    return 'Notificação ignorada: $_temp0.';
  }

  @override
  String get settingsNLHistoryShortDescription =>
      'Listar notificações anteriores';

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
      'Preencher título da transação com o título da notificação';

  @override
  String get settingsNLRegularExpression => 'Expressão regular (opcional)';

  @override
  String get settingsNLRegularExpressionInvalid => 'Expressão regular inválida';

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
  String get settingsServerConnection => 'Conexão com o servidor';

  @override
  String get settingsServerConnectionUpdated =>
      'Configurações de conexão atualizadas.';

  @override
  String get settingsTheme => 'Tema do aplicativo';

  @override
  String get settingsThemeDynamicColors => 'Cores Dinâmicas';

  @override
  String settingsThemeValue(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'dark': 'Modo escuro',
      'light': 'Modo claro',
      'other': 'Padrão do Sistema',
    });
    return '$_temp0';
  }

  @override
  String get settingsUseServerTimezone => 'Usar fuso horário do servidor';

  @override
  String get settingsUseServerTimezoneHelp =>
      'Mostrar todos os horários no fuso horário do servidor. Isso imita o comportamento da interface web.';

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
  String get transactionDialogBillNoBill => 'Sem assinatura';

  @override
  String get transactionDialogBillTitle => 'Vincular à Assinatura';

  @override
  String get transactionDialogCurrencyTitle => 'Selecione a moeda';

  @override
  String get transactionDialogPiggyNoPiggy => 'Nenhum Cofrinho';

  @override
  String get transactionDialogPiggyTitle => 'Vincular a Cofrinho';

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
  String get transactionErrorNoAccounts =>
      'Por favor, preencha as contas primeiro.';

  @override
  String get transactionErrorNoAssetAccount =>
      'Por favor, selecione uma conta de ativo.';

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
  String get transactionFormLabelTags => 'Etiquetas';

  @override
  String get transactionFormLabelTitle => 'Título da Transação';

  @override
  String get transactionSplitAdd => 'Adicionar divisão';

  @override
  String get transactionSplitChangeCurrency => 'Alterar Moeda da Divisão';

  @override
  String get transactionSplitChangeDestinationAccount =>
      'Alterar Conta de Destino da Divisão';

  @override
  String get transactionSplitChangeSourceAccount =>
      'Alterar Conta de Origem da Divisão';

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
