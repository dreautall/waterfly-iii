// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class SZh extends S {
  SZh([String locale = 'zh']) : super(locale);

  @override
  String get accountRoleAssetCashWallet => '现金';

  @override
  String get accountRoleAssetCC => '信用卡';

  @override
  String get accountRoleAssetDefault => '默认资产账户';

  @override
  String get accountRoleAssetSavings => '储蓄账户';

  @override
  String get accountRoleAssetShared => '共用资产账户';

  @override
  String get accountsLabelAsset => '资产账户';

  @override
  String get accountsLabelExpense => '支出账户';

  @override
  String get accountsLabelLiabilities => '负债';

  @override
  String get accountsLabelRevenue => '收入账户';

  @override
  String accountsLiabilitiesInterest(double interest, String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': '每周',
      'monthly': '每月',
      'quarterly': '每季度',
      'halfyear': '每半年',
      'yearly': '每年',
      'other': '其它',
    });
    return '$_temp0的利率为 $interest%';
  }

  @override
  String billsAmountAndFrequency(
    String minValue,
    String maxvalue,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': '每周',
      'monthly': '每月',
      'quarterly': '每季度',
      'halfyear': '每半年',
      'yearly': '每年',
      'other': '未知',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: '，跳过 $skip 次',
      zero: '',
    );
    return '账单匹配金额在 $minValue 和 $maxvalue 之间的交易。$_temp0重复$_temp1。';
  }

  @override
  String get billsChangeLayoutTooltip => '更改布局';

  @override
  String get billsChangeSortOrderTooltip => '更改排序顺序';

  @override
  String get billsSettingsTooltip => 'Settings';

  @override
  String get billsErrorLoading => '加载账单时出错。';

  @override
  String billsExactAmountAndFrequency(
    String value,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': '每周',
      'monthly': '每月',
      'quarterly': '每季度',
      'halfyear': '每半年',
      'yearly': '每年',
      'other': '未知',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: '，跳过 $skip 次',
      zero: '',
    );
    return '账单匹配金额为 $value 的交易。$_temp0重复$_temp1。';
  }

  @override
  String billsExpectedOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '预计日期 $dateString';
  }

  @override
  String billsFrequency(String frequency) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': '每周',
      'monthly': '每月',
      'quarterly': '每季度',
      'halfyear': '每半年',
      'yearly': '每年',
      'other': '未知',
    });
    return '$_temp0';
  }

  @override
  String billsFrequencySkip(String frequency, num skip) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': '每周',
      'monthly': '每月',
      'quarterly': '每季度',
      'halfyear': '每半年',
      'yearly': '每年',
      'other': '未知',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: '，跳过 $skip 次',
      zero: '',
    );
    return '$_temp0重复$_temp1';
  }

  @override
  String get billsInactive => '未启用';

  @override
  String get billsIsActive => '账单已启用';

  @override
  String get billsLayoutGroupSubtitle => '账单显示在指定的组中。';

  @override
  String get billsLayoutGroupTitle => '组';

  @override
  String get billsLayoutListSubtitle => '账单显示在按特定标准排序的列表中。';

  @override
  String get billsLayoutListTitle => '列表';

  @override
  String get billsListEmpty => '该列表当前为空。';

  @override
  String get billsNextExpectedMatch => '下次预期的支付匹配';

  @override
  String get billsNotActive => '账单未启用';

  @override
  String get billsNotExpected => '此周期内没有预期的支付';

  @override
  String get billsNoTransactions => '未找到交易记录。';

  @override
  String billsPaidOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '支付日期 $dateString';
  }

  @override
  String get billsSortAlphabetical => '按字母排序';

  @override
  String get billsSortByTimePeriod => '按时间间隔排序';

  @override
  String get billsSortFrequency => '频率';

  @override
  String get billsSortName => '名称';

  @override
  String get billsUngrouped => '未分组的';

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
  String get categoryDeleteConfirm => '您确定要删除这个分类吗？与该分类关联的账单不会被删除，但该分类将彻底删除。';

  @override
  String get categoryErrorLoading => '加载分类时出错。';

  @override
  String get categoryFormLabelIncludeInSum => '包括在每月金额';

  @override
  String get categoryFormLabelName => '分类名称';

  @override
  String get categoryMonthNext => '下个月';

  @override
  String get categoryMonthPrev => '上个月';

  @override
  String get categorySumExcluded => '排除';

  @override
  String get categoryTitleAdd => '添加分类';

  @override
  String get categoryTitleDelete => '删除分类';

  @override
  String get categoryTitleEdit => '编辑分类';

  @override
  String get catNone => '<未分类>';

  @override
  String get catOther => '其他';

  @override
  String errorAPIInvalidResponse(String message) {
    return 'API 的无效响应: $message';
  }

  @override
  String get errorAPIUnavailable => 'API不可用';

  @override
  String get errorFieldRequired => '此字段是必需项.';

  @override
  String get errorInvalidURL => '地址无效';

  @override
  String errorMinAPIVersion(String requiredVersion) {
    return '需要最低 Firefly API 版本 v$requiredVersion，请升级。';
  }

  @override
  String errorStatusCode(int code) {
    return '状态代码：$code';
  }

  @override
  String get errorUnknown => '未知错误';

  @override
  String get formButtonHelp => '帮助';

  @override
  String get formButtonLogin => '登录';

  @override
  String get formButtonLogout => '登出';

  @override
  String get formButtonRemove => '移除';

  @override
  String get formButtonResetLogin => '重置登录';

  @override
  String get formButtonTransactionAdd => '添加交易';

  @override
  String get formButtonTryAgain => '再试一次';

  @override
  String get generalAccount => '账户';

  @override
  String get generalAssets => '资产';

  @override
  String get generalBalance => '金额';

  @override
  String generalBalanceOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString 的余额';
  }

  @override
  String get generalBill => '账单';

  @override
  String get generalBudget => '预算';

  @override
  String get generalCategory => '类别';

  @override
  String get generalCurrency => '货币';

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
  String get generalDefault => '默认';

  @override
  String get generalDestinationAccount => '目标账户';

  @override
  String get generalDismiss => '放弃';

  @override
  String get generalEarned => '收入';

  @override
  String get generalError => '错误';

  @override
  String get generalExpenses => '支出';

  @override
  String get generalIncome => '收入';

  @override
  String get generalLiabilities => '负债';

  @override
  String get generalMultiple => '多个';

  @override
  String get generalNever => '永不';

  @override
  String get generalReconcile => '已对账';

  @override
  String get generalReset => '重置';

  @override
  String get generalSourceAccount => '源账户';

  @override
  String get generalSpent => '支出';

  @override
  String get generalSum => '总额';

  @override
  String get generalTarget => '目标';

  @override
  String get generalUnknown => '未知';

  @override
  String homeMainBillsInterval(String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': '每周',
      'monthly': '每月',
      'quarterly': '每季度',
      'halfyear': '每半年',
      'yearly': '每年',
      'other': '其它',
    });
    return ' （$_temp0）';
  }

  @override
  String get homeMainBillsTitle => '下周的账单';

  @override
  String homeMainBudgetInterval(DateTime from, DateTime to, String period) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return ' （从 $fromString 至 $toString，$period）';
  }

  @override
  String homeMainBudgetIntervalSingle(DateTime from, DateTime to) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return ' （从 $fromString 到 $toString）';
  }

  @override
  String homeMainBudgetSum(String current, String status, String available) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'over': '超出',
      'other': '剩余',
    });
    return '总计 $available $_temp0 $current';
  }

  @override
  String get homeMainBudgetTitle => '本月预算';

  @override
  String get homeMainChartAccountsTitle => '帐户概览';

  @override
  String get homeMainChartCategoriesTitle => '当月类别摘要';

  @override
  String get homeMainChartDailyAvg => '7日均线';

  @override
  String get homeMainChartDailyTitle => '每日总结';

  @override
  String get homeMainChartNetEarningsTitle => '净收入';

  @override
  String get homeMainChartNetWorthTitle => '净值';

  @override
  String get homeMainChartTagsTitle => '';

  @override
  String get homePiggyAdjustDialogTitle => '存钱/花钱';

  @override
  String homePiggyDateStart(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '开始日期:$dateString';
  }

  @override
  String homePiggyDateTarget(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '付款期限：$dateString';
  }

  @override
  String get homeMainDialogSettingsTitle => '自定义面板';

  @override
  String homePiggyLinked(String account) {
    return '关联账号 $account';
  }

  @override
  String get homePiggyNoAccounts => '没有设立存钱罐。';

  @override
  String get homePiggyNoAccountsSubtitle => '在网络界面中创建一些！';

  @override
  String homePiggyRemaining(String amount) {
    return '留下来保存: $amount';
  }

  @override
  String homePiggySaved(String amount) {
    return '到目前为止已保存: $amount';
  }

  @override
  String homePiggyTarget(String amount) {
    return '收费金额: $amount%';
  }

  @override
  String get homeTabLabelBalance => '资产负债表';

  @override
  String get homeTabLabelMain => '主要的';

  @override
  String get homeTabLabelPiggybanks => '存钱罐';

  @override
  String get homeTabLabelTransactions => '交易记录';

  @override
  String get homeTransactionsActionFilter => '过滤列表';

  @override
  String get homeTransactionsDialogFilterAccountsAll => '<全部账户>';

  @override
  String get homeTransactionsDialogFilterBillsAll => '<全部账单>';

  @override
  String get homeTransactionsDialogFilterBillUnset => '<未设置账单>';

  @override
  String get homeTransactionsDialogFilterBudgetsAll => '<全部预算>';

  @override
  String get homeTransactionsDialogFilterBudgetUnset => '<未设置预算>';

  @override
  String get homeTransactionsDialogFilterCategoriesAll => '<全部分类>';

  @override
  String get homeTransactionsDialogFilterCategoryUnset => '<未设置分类>';

  @override
  String get homeTransactionsDialogFilterCurrenciesAll => '<全部货币>';

  @override
  String get homeTransactionsDialogFilterDateRange => 'Date Range';

  @override
  String get homeTransactionsDialogFilterFutureTransactions => '显示未来交易';

  @override
  String get homeTransactionsDialogFilterSearch => '搜索条件';

  @override
  String get homeTransactionsDialogFilterTitle => '选择筛选项';

  @override
  String get homeTransactionsEmpty => '未找到交易记录。';

  @override
  String homeTransactionsMultipleCategories(int num) {
    return '$num 类别';
  }

  @override
  String get homeTransactionsSettingsShowTags => '在交易列表中显示标签';

  @override
  String get liabilityDirectionCredit => '我欠了这笔债务';

  @override
  String get liabilityDirectionDebit => '我欠这笔债务';

  @override
  String get liabilityTypeDebt => '债务';

  @override
  String get liabilityTypeLoan => '贷款';

  @override
  String get liabilityTypeMortgage => '抵押';

  @override
  String get loginAbout =>
      '要生产性地使用 WaterFly III，您需要您自己的服务器与 Fifly III 实例或家庭助手的 Firefly III附加组件。\n\n请输入完整的URL以及个人访问令牌(设置 -> 个人资料-> OAuth -> 个人访问令牌)。';

  @override
  String get loginFormLabelAPIKey => '无效的 API 密钥';

  @override
  String get loginFormLabelHost => '主机URL';

  @override
  String get loginWelcome => '欢迎使用 Firefly III！';

  @override
  String get logoutConfirmation => '您确定要退出吗？';

  @override
  String get navigationAccounts => '帐户';

  @override
  String get navigationBills => '账单';

  @override
  String get navigationCategories => '分类';

  @override
  String get navigationMain => '主仪表盘';

  @override
  String get navigationSettings => '设置';

  @override
  String get no => '取消';

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

    return '$of 中的 $percString';
  }

  @override
  String get settingsDialogDebugInfo =>
      '您可以在此启用并发送调试日志。 这些会对性能产生不良影响，所以请不要启用它们，除非你建议这样做。 禁用日志将删除存储的日志。';

  @override
  String get settingsDialogDebugMailCreate => '创建电子邮件';

  @override
  String get settingsDialogDebugMailDisclaimer =>
      '警告：邮件草稿将与日志文件一起打开(文本格式)。 日志可能包含敏感信息 例如您的 Frefly 实例的主机名 (尽管我试图避免记录任何秘密，如api 密钥)。 请仔细阅读日志并检查您不想分享的任何信息和/或与您想报告的问题无关。\n\n请不要在没有事先同意的情况下通过邮件/GitHub 发送日志。 出于隐私原因，我将删除没有上下文发送的任何日志。永远不要上传不受检查的日志到 GitHub 或其他地方。';

  @override
  String get settingsDialogDebugSendButton => '通过邮件发送日志';

  @override
  String get settingsDialogDebugTitle => '调试日志';

  @override
  String get settingsDialogLanguageTitle => '选择语言';

  @override
  String get settingsDialogThemeTitle => '选择主题';

  @override
  String get settingsFAQ => '常见问答（FAQ）';

  @override
  String get settingsFAQHelp => '在浏览器内打开。仅支持英文。';

  @override
  String get settingsLanguage => '切换语言';

  @override
  String get settingsLockscreen => '锁屏选项';

  @override
  String get settingsLockscreenHelp => '应用程序启动时需要进行身份验证';

  @override
  String get settingsLockscreenInitial => '请验证以启用锁屏界面。';

  @override
  String get settingsNLAppAccount => '默认账户';

  @override
  String get settingsNLAppAccountDynamic => '<自动>';

  @override
  String get settingsNLAppAdd => '添加应用';

  @override
  String get settingsNLAppAddHelp => '点击添加一个应用来收听。只有合格的应用才会显示在列表中。';

  @override
  String get settingsNLAppAddInfo =>
      '在您接收手机通知以添加应用程序到此列表的交易中。 如果应用程序仍未显示, 请向app@vogt.pw报告。';

  @override
  String get settingsNLAutoAdd => '创建无互动的交易';

  @override
  String get settingsNLDescription =>
      '此服务允许您从传入推送通知中获取交易细节。 此外，您可以选择一个交易应该分配给的默认账户 - 如果没有设置值。 它试图从通知中提取一个帐户。';

  @override
  String get settingsNLEmptyNote => '不填写备注';

  @override
  String get settingsNLPermissionGrant => '轻触来授予权限。';

  @override
  String get settingsNLPermissionNotGranted => '未授予权限';

  @override
  String get settingsNLPermissionRemove => '移除权限';

  @override
  String get settingsNLPermissionRemoveHelp => '要禁用此服务，请点击应用并删除下一个屏幕中的权限。';

  @override
  String get settingsNLPrefillTXTitle => '使用通知标题预填交易标题';

  @override
  String get settingsNLServiceChecking => '正在检查状态...';

  @override
  String settingsNLServiceCheckingError(String error) {
    return '检查状态时出错：$error';
  }

  @override
  String get settingsNLServiceRunning => '服务正在运行';

  @override
  String get settingsNLServiceStatus => '服务状态';

  @override
  String get settingsNLServiceStopped => '服务已停止';

  @override
  String get settingsNotificationListener => '提示监听服务';

  @override
  String get settingsTheme => '应用主题';

  @override
  String get settingsThemeDynamicColors => '动态取色';

  @override
  String settingsThemeValue(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'dark': '暗色模式',
      'light': '光明模式',
      'other': '系统默认',
    });
    return '$_temp0';
  }

  @override
  String get settingsUseServerTimezone => '使用服务器时区';

  @override
  String get settingsUseServerTimezoneHelp => '显示服务器时区中的所有时间。这模拟了 Web 端的行为。';

  @override
  String get settingsVersion => '应用版本';

  @override
  String get settingsVersionChecking => '正在检查…';

  @override
  String get transactionAttachments => '附件';

  @override
  String get transactionDeleteConfirm => '确定删除此项交易？';

  @override
  String get transactionDialogAttachmentsDelete => '删除附件';

  @override
  String get transactionDialogAttachmentsDeleteConfirm => '确认删除此附件？';

  @override
  String get transactionDialogAttachmentsErrorDownload => '无法下载文件。';

  @override
  String transactionDialogAttachmentsErrorOpen(String error) {
    return '无法打开文件: $error';
  }

  @override
  String transactionDialogAttachmentsErrorUpload(String error) {
    return '无法打开文件: $error';
  }

  @override
  String get transactionDialogAttachmentsTitle => '附件';

  @override
  String get transactionDialogBillNoBill => '无账单';

  @override
  String get transactionDialogBillTitle => '链接账单';

  @override
  String get transactionDialogCurrencyTitle => '选择货币种类';

  @override
  String get transactionDialogTagsAdd => '添加标签';

  @override
  String get transactionDialogTagsHint => '按标签搜索';

  @override
  String get transactionDialogTagsTitle => '选择标签';

  @override
  String get transactionDuplicate => '创建副本';

  @override
  String get transactionErrorInvalidAccount => '帐户无效';

  @override
  String get transactionErrorInvalidBudget => '无效的预算';

  @override
  String get transactionErrorNoAccounts => '请先填写账户。';

  @override
  String get transactionErrorNoAssetAccount => '请选择一个资产账户。';

  @override
  String get transactionErrorTitle => '请输入标题';

  @override
  String get transactionFormLabelAccountDestination => '目标账户';

  @override
  String get transactionFormLabelAccountForeign => '外部账户';

  @override
  String get transactionFormLabelAccountOwn => '自有账号';

  @override
  String get transactionFormLabelAccountSource => '来源账户';

  @override
  String get transactionFormLabelNotes => '备注';

  @override
  String get transactionFormLabelTags => '标签';

  @override
  String get transactionFormLabelTitle => '交易名称';

  @override
  String get transactionSplitAdd => '拆分交易';

  @override
  String get transactionSplitChangeCurrency => '更改基本货币';

  @override
  String get transactionSplitChangeDestinationAccount => '更改拆分目的账户';

  @override
  String get transactionSplitChangeSourceAccount => '更改拆分源账户';

  @override
  String get transactionSplitChangeTarget => '更改拆分目标账户';

  @override
  String get transactionSplitDelete => '删除拆分';

  @override
  String get transactionTitleAdd => '添加交易';

  @override
  String get transactionTitleDelete => '删除交易';

  @override
  String get transactionTitleEdit => '编辑交易';

  @override
  String get transactionTypeDeposit => '存款';

  @override
  String get transactionTypeTransfer => '转帐';

  @override
  String get transactionTypeWithdrawal => '取款';
}
