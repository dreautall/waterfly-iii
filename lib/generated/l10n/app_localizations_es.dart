// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class SEs extends S {
  SEs([String locale = 'es']) : super(locale);

  @override
  String get accountRoleAssetCashWallet => 'Billetera de efectivo';

  @override
  String get accountRoleAssetCC => 'Tarjeta de crédito';

  @override
  String get accountRoleAssetDefault => 'Cuenta de activos por defecto';

  @override
  String get accountRoleAssetSavings => 'Cuenta de ahorros';

  @override
  String get accountRoleAssetShared => 'Cuenta de activos compartida';

  @override
  String get accountsLabelAsset => 'Cuentas de activos';

  @override
  String get accountsLabelExpense => 'Cuentas de gastos';

  @override
  String get accountsLabelLiabilities => 'Pasivos';

  @override
  String get accountsLabelRevenue => 'Cuentas de ingresos';

  @override
  String accountsLiabilitiesInterest(double interest, String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'semana',
      'monthly': 'mes',
      'quarterly': 'trimestre',
      'halfyear': 'semestre',
      'yearly': 'año',
      'other': 'desconocido',
    });
    return '$interest% de interés por $_temp0';
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
      'monthly': 'mensualmente',
      'quarterly': 'trimestralmente',
      'halfyear': 'semestralmente',
      'yearly': 'anualmente',
      'other': 'desconocido',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', saltarse $skip',
      zero: '',
    );
    return 'Factura coincide con transacciones entre $minValue y $maxvalue. Se repite $_temp0$_temp1.';
  }

  @override
  String get billsChangeLayoutTooltip => 'Cambiar diseño';

  @override
  String get billsChangeSortOrderTooltip => 'Cambiar orden de clasificación';

  @override
  String get billsSettingsTooltip => 'Settings';

  @override
  String get billsErrorLoading => 'Error al cargar facturas.';

  @override
  String billsExactAmountAndFrequency(
    String value,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'semanalmente',
      'monthly': 'mensualmente',
      'quarterly': 'trimestralmente',
      'halfyear': 'semestralmente',
      'yearly': 'anualmente',
      'other': 'desconocido',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', saltarse $skip',
      zero: '',
    );
    return 'La factura coincide con las transacciones de $value. Se repite $_temp0$_temp1.';
  }

  @override
  String billsExpectedOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Esperado $dateString';
  }

  @override
  String billsFrequency(String frequency) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Semanal',
      'monthly': 'Mensual',
      'quarterly': 'Trimestral',
      'halfyear': 'Semestral',
      'yearly': 'Anual',
      'other': 'Desconocido',
    });
    return '$_temp0';
  }

  @override
  String billsFrequencySkip(String frequency, num skip) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Semanal',
      'monthly': 'Mensual',
      'quarterly': 'Trimestral',
      'halfyear': 'Semestral',
      'yearly': 'Anual',
      'other': 'Desconocido',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', saltarse $skip',
      zero: '',
    );
    return '$_temp0$_temp1';
  }

  @override
  String get billsInactive => 'Inactiva';

  @override
  String get billsIsActive => 'La factura está activa';

  @override
  String get billsLayoutGroupSubtitle =>
      'Facturas mostradas en sus grupos asignados.';

  @override
  String get billsLayoutGroupTitle => 'Grupo';

  @override
  String get billsLayoutListSubtitle =>
      'Facturas mostradas en una lista ordenada por ciertos criterios.';

  @override
  String get billsLayoutListTitle => 'Lista';

  @override
  String get billsListEmpty => 'La lista está actualmente vacía.';

  @override
  String get billsNextExpectedMatch => 'Próxima coincidencia esperada';

  @override
  String get billsNotActive => 'La factura está inactiva';

  @override
  String get billsNotExpected => 'No se esperaba este período';

  @override
  String get billsNoTransactions => 'No se encontraron transacciones.';

  @override
  String billsPaidOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Pagado $dateString';
  }

  @override
  String get billsSortAlphabetical => 'Alfabético';

  @override
  String get billsSortByTimePeriod => 'Por período de tiempo';

  @override
  String get billsSortFrequency => 'Frecuencia';

  @override
  String get billsSortName => 'Nombre';

  @override
  String get billsUngrouped => 'Sin agrupar';

  @override
  String get billsSettingsShowOnlyActive => 'Show only active';

  @override
  String get billsSettingsShowOnlyActiveDesc =>
      'Shows only active subscriptions.';

  @override
  String get billsSettingsShowOnlyExpected => 'Show only expected';

  @override
  String get billsSettingsShowOnlyExpectedDesc =>
      'Shows only those subscriptions that are expected (or paid) this month.';

  @override
  String get categoryDeleteConfirm =>
      '¿Estás seguro de que deseas eliminar esta categoría? Las transacciones no serán eliminadas, pero ya no tendrán categoría.';

  @override
  String get categoryErrorLoading => 'Error cargando categorías.';

  @override
  String get categoryFormLabelIncludeInSum => 'Incluir en suma mensual';

  @override
  String get categoryFormLabelName => 'Nombre de la categoría';

  @override
  String get categoryMonthNext => 'Próximo Mes';

  @override
  String get categoryMonthPrev => 'Mes anterior';

  @override
  String get categorySumExcluded => 'excluida';

  @override
  String get categoryTitleAdd => 'Agregar categoría';

  @override
  String get categoryTitleDelete => 'Eliminar categoría';

  @override
  String get categoryTitleEdit => 'Editar categoría';

  @override
  String get catNone => '(sin categoría)';

  @override
  String get catOther => 'Otros';

  @override
  String errorAPIInvalidResponse(String message) {
    return 'Respuesta inválida de la API: $message';
  }

  @override
  String get errorAPIUnavailable => 'API no disponible';

  @override
  String get errorFieldRequired => 'Este campo es obligatorio.';

  @override
  String get errorInvalidURL => 'URL inválida';

  @override
  String errorMinAPIVersion(String requiredVersion) {
    return 'Se requiere una versión mínima de la API Firefly -$requiredVersion Por favor, actualice.';
  }

  @override
  String errorStatusCode(int code) {
    return 'Código de estado: $code';
  }

  @override
  String get errorUnknown => 'Error desconocido.';

  @override
  String get formButtonHelp => 'Ayuda';

  @override
  String get formButtonLogin => 'Iniciar Sesión';

  @override
  String get formButtonLogout => 'Cerrar sesión';

  @override
  String get formButtonRemove => 'Eliminar';

  @override
  String get formButtonResetLogin => 'Restablecer inicio de sesión';

  @override
  String get formButtonTransactionAdd => 'Añadir Transacción';

  @override
  String get formButtonTryAgain => 'Inténtalo de nuevo';

  @override
  String get generalAccount => 'Cuenta';

  @override
  String get generalAssets => 'Activos';

  @override
  String get generalBalance => 'Saldo';

  @override
  String generalBalanceOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Saldo a $dateString';
  }

  @override
  String get generalBill => 'Factura';

  @override
  String get generalBudget => 'Presupuesto';

  @override
  String get generalCategory => 'Categoría';

  @override
  String get generalCurrency => 'Divisa';

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
  String get generalDefault => 'por defecto';

  @override
  String get generalDestinationAccount => 'Cuenta de Destino';

  @override
  String get generalDismiss => 'Descartar';

  @override
  String get generalEarned => 'Ingresado';

  @override
  String get generalError => 'Error';

  @override
  String get generalExpenses => 'Gastos';

  @override
  String get generalIncome => 'Ingresos';

  @override
  String get generalLiabilities => 'Pasivos';

  @override
  String get generalMultiple => 'múltiple';

  @override
  String get generalNever => 'nunca';

  @override
  String get generalReconcile => 'Reconciliado';

  @override
  String get generalReset => 'Restablecer';

  @override
  String get generalSourceAccount => 'Cuenta de Origen';

  @override
  String get generalSpent => 'Gastado';

  @override
  String get generalSum => 'Suma';

  @override
  String get generalTarget => 'Objetivo';

  @override
  String get generalUnknown => 'Desconocido';

  @override
  String homeMainBillsInterval(String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'semanalmente',
      'monthly': 'mensualmente',
      'quarterly': 'trimestralmente',
      'halfyear': 'semestralmente',
      'yearly': 'anualmente',
      'other': 'desconocido',
    });
    return ' ($_temp0)';
  }

  @override
  String get homeMainBillsTitle => 'Facturas para la próxima semana';

  @override
  String homeMainBudgetInterval(DateTime from, DateTime to, String period) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return ' ($fromString hasta $toString, $period)';
  }

  @override
  String homeMainBudgetIntervalSingle(DateTime from, DateTime to) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return ' ($fromString hasta $toString)';
  }

  @override
  String homeMainBudgetSum(String current, String status, String available) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'over': 'más de',
      'other': 'restante',
    });
    return '$current $_temp0 $available';
  }

  @override
  String get homeMainBudgetTitle => 'Presupuestos para el mes actual';

  @override
  String get homeMainChartAccountsTitle => 'Resumen de la cuenta';

  @override
  String get homeMainChartCategoriesTitle =>
      'Resumen de categoría para el mes actual';

  @override
  String get homeMainChartDailyAvg => 'promedio de 7 días';

  @override
  String get homeMainChartDailyTitle => 'Resumen diario';

  @override
  String get homeMainChartNetEarningsTitle => 'Beneficio';

  @override
  String get homeMainChartNetWorthTitle => 'Valor neto';

  @override
  String get homeMainChartTagsTitle => 'Resumen de etiquetas del mes actual';

  @override
  String get homePiggyAdjustDialogTitle => 'Ahorrar/Gastar dinero';

  @override
  String homePiggyDateStart(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Fecha de inicio: $dateString';
  }

  @override
  String homePiggyDateTarget(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Fecha objetivo: $dateString';
  }

  @override
  String get homeMainDialogSettingsTitle => 'Personalizar el panel';

  @override
  String homePiggyLinked(String account) {
    return 'Vinculado a $account';
  }

  @override
  String get homePiggyNoAccounts => 'No se han creado huchas.';

  @override
  String get homePiggyNoAccountsSubtitle => '¡Cree alguna en la interfaz web!';

  @override
  String homePiggyRemaining(String amount) {
    return 'Pendiente de ahorrar: $amount';
  }

  @override
  String homePiggySaved(String amount) {
    return 'Ahorrado hasta ahora: $amount';
  }

  @override
  String homePiggyTarget(String amount) {
    return 'Objetivo de ahorro: $amount';
  }

  @override
  String get homeTabLabelBalance => 'Hoja de balance';

  @override
  String get homeTabLabelMain => 'Principal';

  @override
  String get homeTabLabelPiggybanks => 'Huchas';

  @override
  String get homeTabLabelTransactions => 'Transacciones';

  @override
  String get homeTransactionsActionFilter => 'Listado de filtros';

  @override
  String get homeTransactionsDialogFilterAccountsAll => '<Todas las cuentas>';

  @override
  String get homeTransactionsDialogFilterBillsAll => '<Todas las facturas>';

  @override
  String get homeTransactionsDialogFilterBillUnset =>
      '<Factura no establecida>';

  @override
  String get homeTransactionsDialogFilterBudgetsAll =>
      '<Todos los presupuestos>';

  @override
  String get homeTransactionsDialogFilterBudgetUnset =>
      '<Presupuesto no establecido>';

  @override
  String get homeTransactionsDialogFilterCategoriesAll =>
      '<Todas las categorías>';

  @override
  String get homeTransactionsDialogFilterCategoryUnset =>
      '<Categoría no establecida>';

  @override
  String get homeTransactionsDialogFilterCurrenciesAll => '<Todas las divisas>';

  @override
  String get homeTransactionsDialogFilterDateRange => 'Date Range';

  @override
  String get homeTransactionsDialogFilterFutureTransactions =>
      'Mostrar transacciones futuras';

  @override
  String get homeTransactionsDialogFilterSearch => 'Término de búsqueda';

  @override
  String get homeTransactionsDialogFilterTitle => 'Seleccionar filtros';

  @override
  String get homeTransactionsEmpty => 'No se encontraron transacciones.';

  @override
  String homeTransactionsMultipleCategories(int num) {
    return '$num categorías';
  }

  @override
  String get homeTransactionsSettingsShowTags =>
      'Mostrar etiquetas en la lista de transacciones';

  @override
  String get liabilityDirectionCredit => 'Se me debe esta deuda';

  @override
  String get liabilityDirectionDebit => 'Le debo esta deuda a otra persona';

  @override
  String get liabilityTypeDebt => 'Deuda';

  @override
  String get liabilityTypeLoan => 'Préstamo';

  @override
  String get liabilityTypeMortgage => 'Hipoteca';

  @override
  String get loginAbout =>
      'Para usar Waterfly III es necesario disponer de un servidor con una instancia de Firefly III o del add-on de Firefly III para Home Assistant.\n\nPor favor, introduzca la URL completa y el token de acceso personal (Ajustes -> Perfil -> OAuth -> Token de Acceso Personal) debajo.';

  @override
  String get loginFormLabelAPIKey => 'Clave API válida';

  @override
  String get loginFormLabelHost => 'URL del servidor';

  @override
  String get loginWelcome => 'Bienvenido a Waterfly III';

  @override
  String get logoutConfirmation => '¿Estás seguro de que deseas cerrar sesión?';

  @override
  String get navigationAccounts => 'Cuentas';

  @override
  String get navigationBills => 'Facturas';

  @override
  String get navigationCategories => 'Categorías';

  @override
  String get navigationMain => 'Panel principal';

  @override
  String get navigationSettings => 'Ajustes';

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
      'Puede activar y enviar los registros de depuración desde aquí. Su activación tiene un impacto perjudicial en el rendimiento, así que no los active a no ser que se le haya recomendado. Desactivar los registros elimina los guardados anteriormente.';

  @override
  String get settingsDialogDebugMailCreate => 'Crear email';

  @override
  String get settingsDialogDebugMailDisclaimer =>
      'ATENCIÓN: Se abrirá un borrador de email con los registros de depuración como archivo adjunto (en formato de texto). Los registros pueden contener información sensible, como el nombre del anfitrión de su instancia de Firefly (aunque se ha tratado de no registrar secretos, como la clave API). Por favor, revise los registros cuidadosamente y censure cualquier información que no desea compartir y/o no es relevante para el problema sobre el que quiere informar.';

  @override
  String get settingsDialogDebugSendButton => 'Enviar registros por correo';

  @override
  String get settingsDialogDebugTitle => 'Registros de depuración';

  @override
  String get settingsDialogLanguageTitle => 'Seleccionar idioma';

  @override
  String get settingsDialogThemeTitle => 'Seleccionar tema';

  @override
  String get settingsFAQ => 'FAQ';

  @override
  String get settingsFAQHelp =>
      'Se abre en el navegador. Sólo disponible en inglés.';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLockscreen => 'Pantalla de bloqueo';

  @override
  String get settingsLockscreenHelp =>
      'Requerir autenticación al iniciar la aplicación';

  @override
  String get settingsLockscreenInitial =>
      'Por favor, autentíquese para activar la pantalla de bloqueo.';

  @override
  String get settingsNLAppAccount => 'Cuenta por defecto';

  @override
  String get settingsNLAppAccountDynamic => '<Dinámico>';

  @override
  String get settingsNLAppAdd => 'Añadir aplicación';

  @override
  String get settingsNLAppAddHelp =>
      'Haga clic para añadir una aplicación para escuchar. Sólo las aplicaciones elegibles aparecerán en la lista.';

  @override
  String get settingsNLAppAddInfo =>
      'Haga algunas transacciones que generen notificaciones en el teléfono para añadir aplicaciones a esta lista. Si la aplicación todavía no aparece, por favor, informe a app@vogt.pw.';

  @override
  String get settingsNLAutoAdd => 'Crear transacción sin interacción';

  @override
  String get settingsNLDescription =>
      'Este servicio permite obtener detalles de la transacción a partir de notificaciones entrantes. Además, puede seleccionar una cuenta por defecto a la que asignar la transacción. Si no se establece ningún valor, trata de extraer la información de la notificación.';

  @override
  String get settingsNLEmptyNote => 'Mantener campo nota vacío';

  @override
  String get settingsNLPermissionGrant => 'Toque para conceder permiso.';

  @override
  String get settingsNLPermissionNotGranted => 'Permiso no concedido.';

  @override
  String get settingsNLPermissionRemove => 'Quitar el permiso?';

  @override
  String get settingsNLPermissionRemoveHelp =>
      'Para desactivar este servicio, haga clic en la aplicación y elimine los permisos en la siguiente pantalla.';

  @override
  String get settingsNLPrefillTXTitle =>
      'Rellenar el título de la transacción con el título de la notificación';

  @override
  String get settingsNLServiceChecking => 'Comprobando estado…';

  @override
  String settingsNLServiceCheckingError(String error) {
    return 'Error comprobando estado: $error';
  }

  @override
  String get settingsNLServiceRunning => 'El servicio se está ejecutando.';

  @override
  String get settingsNLServiceStatus => 'Estado del servicio';

  @override
  String get settingsNLServiceStopped => 'El servicio está detenido.';

  @override
  String get settingsNotificationListener =>
      'Servicio de escucha de notificaciones';

  @override
  String get settingsTheme => 'Tema de la aplicación';

  @override
  String get settingsThemeDynamicColors => 'Colores dinámicos';

  @override
  String settingsThemeValue(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'dark': 'Modo Oscuro',
      'light': 'Modo Luz',
      'other': 'Predeterminado del sistema',
    });
    return '$_temp0';
  }

  @override
  String get settingsUseServerTimezone => 'Usar la zona horaria del servidor';

  @override
  String get settingsUseServerTimezoneHelp =>
      'Mostrar todas las horas en la zona horaria del servidor. Esto imita el comportamiento de la interfaz web.';

  @override
  String get settingsVersion => 'Versión de la aplicación';

  @override
  String get settingsVersionChecking => 'comprobando…';

  @override
  String get transactionAttachments => 'Archivos adjuntos';

  @override
  String get transactionDeleteConfirm =>
      '¿Seguro que desea eliminar esta transacción?';

  @override
  String get transactionDialogAttachmentsDelete => 'Eliminar archivo adjunto';

  @override
  String get transactionDialogAttachmentsDeleteConfirm =>
      '¿Está seguro de que desea eliminar el archivo adjunto?';

  @override
  String get transactionDialogAttachmentsErrorDownload =>
      'No se pudo descargar el archivo.';

  @override
  String transactionDialogAttachmentsErrorOpen(String error) {
    return 'No se pudo abrir el archivo: $error';
  }

  @override
  String transactionDialogAttachmentsErrorUpload(String error) {
    return 'No se pudo subir el archivo: $error';
  }

  @override
  String get transactionDialogAttachmentsTitle => 'Archivos adjuntos';

  @override
  String get transactionDialogBillNoBill => 'Sin factura';

  @override
  String get transactionDialogBillTitle => 'Enlace a la factura';

  @override
  String get transactionDialogCurrencyTitle => 'Seleccionar divisa';

  @override
  String get transactionDialogTagsAdd => 'Añadir etiqueta';

  @override
  String get transactionDialogTagsHint => 'Buscar/Añadir etiqueta';

  @override
  String get transactionDialogTagsTitle => 'Seleccionar etiquetas';

  @override
  String get transactionDuplicate => 'Duplicado';

  @override
  String get transactionErrorInvalidAccount => 'Cuenta inválida';

  @override
  String get transactionErrorInvalidBudget => 'Presupuesto inválido';

  @override
  String get transactionErrorNoAccounts =>
      'Por favor, primero rellene las cuentas.';

  @override
  String get transactionErrorNoAssetAccount =>
      'Por favor, seleccione una cuenta de activo.';

  @override
  String get transactionErrorTitle => 'Por favor, proporcione un título.';

  @override
  String get transactionFormLabelAccountDestination => 'Cuenta de destino';

  @override
  String get transactionFormLabelAccountForeign => 'Cuenta extranjera';

  @override
  String get transactionFormLabelAccountOwn => 'Cuenta propia';

  @override
  String get transactionFormLabelAccountSource => 'Cuenta de origen';

  @override
  String get transactionFormLabelNotes => 'Notas';

  @override
  String get transactionFormLabelTags => 'Etiquetas';

  @override
  String get transactionFormLabelTitle => 'Título de la transacción';

  @override
  String get transactionSplitAdd => 'Añadir transacción dividida';

  @override
  String get transactionSplitChangeCurrency => 'Cambiar moneda dividida';

  @override
  String get transactionSplitChangeDestinationAccount =>
      'Cambiar cuenta de destino dividida';

  @override
  String get transactionSplitChangeSourceAccount =>
      'Cambiar cuenta de origen dividida';

  @override
  String get transactionSplitChangeTarget =>
      'Cambiar cuenta de destina dividida';

  @override
  String get transactionSplitDelete => 'Eliminar división';

  @override
  String get transactionTitleAdd => 'Añadir Transacción';

  @override
  String get transactionTitleDelete => 'Eliminar transacción';

  @override
  String get transactionTitleEdit => 'Editar Transacción';

  @override
  String get transactionTypeDeposit => 'Ingreso';

  @override
  String get transactionTypeTransfer => 'Transferencia';

  @override
  String get transactionTypeWithdrawal => 'Retirada';
}
