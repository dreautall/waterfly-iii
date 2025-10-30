// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class SKo extends S {
  SKo([String locale = 'ko']) : super(locale);

  @override
  String get accountRoleAssetCashWallet => '현금 지갑';

  @override
  String get accountRoleAssetCC => '신용카드';

  @override
  String get accountRoleAssetDefault => '기본 자산 계정';

  @override
  String get accountRoleAssetSavings => '예금 계좌';

  @override
  String get accountRoleAssetShared => '공유 자산 계정';

  @override
  String get accountsLabelAsset => '자산 계정';

  @override
  String get accountsLabelExpense => '지출 계정';

  @override
  String get accountsLabelLiabilities => '부채';

  @override
  String get accountsLabelRevenue => '수익 계정';

  @override
  String accountsLiabilitiesInterest(double interest, String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': '주별',
      'monthly': '월별',
      'quarterly': '분기별',
      'halfyear': '반기별',
      'yearly': '연별',
      'other': '기타',
    });
    return '$_temp0 이자율 $interest%';
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
    return '구독은 $minValue - $maxvalue 사이의 거래를 매치하며 $_temp0$_temp1 반복합니다.';
  }

  @override
  String get billsChangeLayoutTooltip => '레이아웃 변경';

  @override
  String get billsChangeSortOrderTooltip => '정렬 순서 변경';

  @override
  String get billsErrorLoading => '구독을 불러오는 중 오류가 발생했습니다.';

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
    return '구독은 $value 거래와 일치하며 $_temp0$_temp1 반복합니다.';
  }

  @override
  String billsExpectedOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString 예정';
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
  String get billsInactive => '비활성';

  @override
  String get billsIsActive => '구독이 활성화 되었습니다';

  @override
  String get billsLayoutGroupSubtitle => '할당된 그룹에 구독이 표시됩니다.';

  @override
  String get billsLayoutGroupTitle => '그룹';

  @override
  String get billsLayoutListSubtitle => '특정 기준에 따라 정렬된 목록으로 표시되는 구독입니다.';

  @override
  String get billsLayoutListTitle => '목록';

  @override
  String get billsListEmpty => '현재 목록이 비어 있습니다.';

  @override
  String get billsNextExpectedMatch => 'Next expected match';

  @override
  String get billsNotActive => '구독이 비활성화되어 있습니다';

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
  String get billsSortAlphabetical => '알파벳 순';

  @override
  String get billsSortByTimePeriod => '기간별';

  @override
  String get billsSortFrequency => '주기';

  @override
  String get billsSortName => '이름';

  @override
  String get billsUngrouped => '그룹 지정 안 됨';

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
      'Are you sure you want to delete this category? The transactions will not be deleted, but will not have a category anymore.';

  @override
  String get categoryErrorLoading => '분류를 읽어들이는 중 오류가 발생했습니다.';

  @override
  String get categoryFormLabelIncludeInSum => '월간 합계에 포함';

  @override
  String get categoryFormLabelName => '분류명';

  @override
  String get categoryMonthNext => '다음 달';

  @override
  String get categoryMonthPrev => '전월';

  @override
  String get categorySumExcluded => '제외된';

  @override
  String get categoryTitleAdd => '카테고리 추가';

  @override
  String get categoryTitleDelete => '카테고리 삭제';

  @override
  String get categoryTitleEdit => '카테고리 수정';

  @override
  String get catNone => '<no category>';

  @override
  String get catOther => 'Other';

  @override
  String errorAPIInvalidResponse(String message) {
    return 'API에서 잘못된 응답: $message';
  }

  @override
  String get errorAPIUnavailable => 'API를 사용할 수 없습니다';

  @override
  String get errorFieldRequired => '필수 입력 사항입니다.';

  @override
  String get errorInvalidURL => '잘못된 URL';

  @override
  String errorMinAPIVersion(String requiredVersion) {
    return '최소 Firefly API 버전 v$requiredVersion이 필요합니다. 업그레이드 요망.';
  }

  @override
  String errorStatusCode(int code) {
    return '상태 코드: $code';
  }

  @override
  String get errorUnknown => '알수없는 오류.';

  @override
  String get formButtonHelp => '도움말';

  @override
  String get formButtonLogin => '로그인';

  @override
  String get formButtonLogout => '로그아웃';

  @override
  String get formButtonRemove => '삭제';

  @override
  String get formButtonResetLogin => '로그인 재설정';

  @override
  String get formButtonTransactionAdd => '거래 추가';

  @override
  String get formButtonTryAgain => '재시도';

  @override
  String get generalAccount => '계정';

  @override
  String get generalAssets => '자산';

  @override
  String get generalBalance => '잔액';

  @override
  String generalBalanceOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString 잔액';
  }

  @override
  String get generalBill => '구독';

  @override
  String get generalBudget => '예산';

  @override
  String get generalCategory => '분류';

  @override
  String get generalCurrency => '화폐';

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
  String get generalDefault => 'default';

  @override
  String get generalDestinationAccount => '대상 계정';

  @override
  String get generalDismiss => '닫기';

  @override
  String get generalEarned => '수입';

  @override
  String get generalError => '오류';

  @override
  String get generalExpenses => '지출';

  @override
  String get generalIncome => '수입';

  @override
  String get generalLiabilities => '부채';

  @override
  String get generalMultiple => 'multiple';

  @override
  String get generalNever => 'never';

  @override
  String get generalReconcile => '조정됨';

  @override
  String get generalReset => '재설정';

  @override
  String get generalSourceAccount => '소스 계정';

  @override
  String get generalSpent => '지출';

  @override
  String get generalSum => '합계';

  @override
  String get generalTarget => '대상';

  @override
  String get generalUnknown => '알 수 없는';

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
  String get homeMainBillsTitle => '다음 주 구독';

  @override
  String homeMainBudgetInterval(DateTime from, DateTime to, String period) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return ' ($fromString 부터 $toString, $period)';
  }

  @override
  String homeMainBudgetIntervalSingle(DateTime from, DateTime to) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return ' ($fromString 부터 $toString)';
  }

  @override
  String homeMainBudgetSum(String current, String status, String available) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'over': 'over',
      'other': 'left from',
    });
    return '$current $_temp0 $available';
  }

  @override
  String get homeMainBudgetTitle => '현재 월 예산';

  @override
  String get homeMainChartAccountsTitle => '계정 요약';

  @override
  String get homeMainChartCategoriesTitle => '이번달 분류 요약';

  @override
  String get homeMainChartDailyAvg => '7 일 평균';

  @override
  String get homeMainChartDailyTitle => '일일 요약';

  @override
  String get homeMainChartNetEarningsTitle => '순수익';

  @override
  String get homeMainChartNetWorthTitle => '순자산';

  @override
  String get homeMainChartTagsTitle => 'Tag Summary for current month';

  @override
  String get homePiggyAdjustDialogTitle => '지출/저장';

  @override
  String homePiggyDateStart(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '시작일: $dateString';
  }

  @override
  String homePiggyDateTarget(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '대상일: $dateString';
  }

  @override
  String get homeMainDialogSettingsTitle => '맞춤형 보고서';

  @override
  String homePiggyLinked(String account) {
    return 'Linked to $account';
  }

  @override
  String get homePiggyNoAccounts => '저금통이 설정되지 않음.';

  @override
  String get homePiggyNoAccountsSubtitle => '웹 인터페이스 만들기!';

  @override
  String homePiggyRemaining(String amount) {
    return 'Left to save: $amount';
  }

  @override
  String homePiggySaved(String amount) {
    return 'Saved so far: $amount';
  }

  @override
  String get homePiggySavedMultiple => 'Saved so far:';

  @override
  String homePiggyTarget(String amount) {
    return 'Target amount: $amount';
  }

  @override
  String get homePiggyAccountStatus => 'Account Status';

  @override
  String get homePiggyAvailableAmounts => 'Available Amounts';

  @override
  String homePiggyAvailable(String amount) {
    return 'Available: $amount';
  }

  @override
  String homePiggyInPiggyBanks(String amount) {
    return 'In piggy banks: $amount';
  }

  @override
  String get homeTabLabelBalance => 'Balance Sheet';

  @override
  String get homeTabLabelMain => '메인';

  @override
  String get homeTabLabelPiggybanks => '저금통';

  @override
  String get homeTabLabelTransactions => '거래';

  @override
  String get homeTransactionsActionFilter => '필터 목록';

  @override
  String get homeTransactionsDialogFilterAccountsAll => '<모든 계정>';

  @override
  String get homeTransactionsDialogFilterBillsAll => '<All Subscriptions>';

  @override
  String get homeTransactionsDialogFilterBillUnset => '<No Subscription set>';

  @override
  String get homeTransactionsDialogFilterBudgetsAll => '<All Budgets>';

  @override
  String get homeTransactionsDialogFilterBudgetUnset => '<No Budget set>';

  @override
  String get homeTransactionsDialogFilterCategoriesAll => '<All Categories>';

  @override
  String get homeTransactionsDialogFilterCategoryUnset => '<No Category set>';

  @override
  String get homeTransactionsDialogFilterCurrenciesAll => '<All Currencies>';

  @override
  String get homeTransactionsDialogFilterDateRange => 'Date Range';

  @override
  String get homeTransactionsDialogFilterFutureTransactions =>
      'Show future transactions';

  @override
  String get homeTransactionsDialogFilterSearch => '검색어';

  @override
  String get homeTransactionsDialogFilterTitle => '필터 선택';

  @override
  String get homeTransactionsEmpty => 'No transactions found.';

  @override
  String homeTransactionsMultipleCategories(int num) {
    return '$num 분류';
  }

  @override
  String get homeTransactionsSettingsShowTags => '거래 목록에 태그 표시';

  @override
  String get liabilityDirectionCredit => 'I am owed this debt';

  @override
  String get liabilityDirectionDebit => 'I owe this debt';

  @override
  String get liabilityTypeDebt => 'Debt';

  @override
  String get liabilityTypeLoan => '대출';

  @override
  String get liabilityTypeMortgage => '대출';

  @override
  String get loginAbout =>
      'Waterfly III를 사용하려면 Firefly III 인스턴스가 있는 서버나 Home Assistant용 Firefly III 애드온이 필요합니다.\n\n아래에 전체 URL과 개인 액세스 토큰(설정 -> 프로필 -> OAuth -> 개인 액세스 토큰)을 입력하세요.';

  @override
  String get loginFormLabelAPIKey => '유효한 API 키';

  @override
  String get loginFormLabelHost => '호스트 URL';

  @override
  String get loginWelcome => 'Waterfly III에 오신 것을 환영합니다';

  @override
  String get logoutConfirmation => '로그아웃 하시겠습니까?';

  @override
  String get navigationAccounts => '계정';

  @override
  String get navigationBills => '구독';

  @override
  String get navigationCategories => '분류';

  @override
  String get navigationMain => '보고서';

  @override
  String get generalSettings => 'Settings';

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

    return '$percString of $of';
  }

  @override
  String get settingsDialogDebugInfo =>
      '여기에서 디버그 로그를 활성화하고 보낼 수 있습니다. 이는 성능에 나쁜 영향을 미치므로 권장받지 않는 한 활성화하지 마십시오. 로깅을 비활성화하면 저장된 로그가 삭제됩니다.';

  @override
  String get settingsDialogDebugMailCreate => '메일 작성';

  @override
  String get settingsDialogDebugMailDisclaimer =>
      '경고: 로그 파일이 첨부된 메일 초안이 열립니다(텍스트 형식). 로그에는 Firefly 인스턴스의 호스트 이름과 같은 민감한 정보가 포함될 수 있습니다(API 키와 같은 비밀은 기록하지 않으려고 노력합니다). 로그를 주의 깊게 읽고 공유하고 싶지 않거나 보고하려는 문제와 관련이 없는 정보는 삭제하세요.\n\n사전 동의 없이 메일/GitHub을 통해 로그를 보내지 마십시오. 개인 정보 보호를 위해 맥락 없이 보낸 로그는 삭제합니다. 검열되지 않은 로그를 GitHub이나 다른 곳에 업로드하지 마십시오.';

  @override
  String get settingsDialogDebugSendButton => '메일로 로그 전송';

  @override
  String get settingsDialogDebugTitle => '디버그 로그';

  @override
  String get settingsDialogLanguageTitle => '언어 선택';

  @override
  String get settingsDialogThemeTitle => '테마 변경';

  @override
  String get settingsFAQ => '자주하는 질문';

  @override
  String get settingsFAQHelp => '영어로만 제공되며 브라우저에서 열립니다.';

  @override
  String get settingsLanguage => '언어';

  @override
  String get settingsLockscreen => '잠금 화면';

  @override
  String get settingsLockscreenHelp => 'Require authenticiation on app startup';

  @override
  String get settingsLockscreenInitial => '잠금 화면을 활성화하려면 인증을 해주세요.';

  @override
  String get settingsNLAppAccount => '기본 계정';

  @override
  String get settingsNLAppAccountDynamic => '<Dynamic>';

  @override
  String get settingsNLAppAdd => 'App 추가';

  @override
  String get settingsNLAppAddHelp => '클릭하여 추출할 앱을 추가합니다. 적격한 앱만 목록에 표시됩니다.';

  @override
  String get settingsNLAppAddInfo =>
      '이 목록에 앱을 추가하기 위해 폰 알림을 받는 거래를 몇 가지 하세요. 앱이 여전히 표시되지 않으면 app@vogt.pw로 알려주십시요.';

  @override
  String get settingsNLAutoAdd => '상호작용 없이 거래 생성';

  @override
  String get settingsNLDescription =>
      '이 서비스를 사용하면 수신 푸시 알림에서 거래 세부 정보를 가져올 수 있습니다. 또한 거래를 할당할 기본 계정을 선택할 수 있습니다. 값이 설정되지 않은 경우 알림에서 계정을 추출하려고 시도합니다.';

  @override
  String get settingsNLEmptyNote => 'Keep note field empty';

  @override
  String get settingsNLPermissionGrant => '권한을 부여하려면 탭하세요.';

  @override
  String get settingsNLPermissionNotGranted => '권한이 부여되지 않음.';

  @override
  String get settingsNLPermissionRemove => '권한 제거?';

  @override
  String get settingsNLPermissionRemoveHelp =>
      '이 서비스를 비활성화하려면 앱을 클릭하고 다음 화면에서 권한을 제거하세요.';

  @override
  String get settingsNLPrefillTXTitle => '알림 제목으로 거래 제목을 미리 채워주세요';

  @override
  String get settingsNLServiceChecking => '상태 확인 중…';

  @override
  String settingsNLServiceCheckingError(String error) {
    return '오류 검사 상태: $error';
  }

  @override
  String get settingsNLServiceRunning => '서비스가 실행 중입니다.';

  @override
  String get settingsNLServiceStatus => '서비스 상태';

  @override
  String get settingsNLServiceStopped => '서비스가 중단됨.';

  @override
  String get settingsNotificationListener => '알림 리스너 서비스';

  @override
  String get settingsTheme => '테마변경';

  @override
  String get settingsThemeDynamicColors => '다이나믹 컬러';

  @override
  String settingsThemeValue(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'dark': 'Dark Mode',
      'light': 'Light Mode',
      'other': 'System Default',
    });
    return '$_temp0';
  }

  @override
  String get settingsUseServerTimezone => '서버 시간대 사용';

  @override
  String get settingsUseServerTimezoneHelp =>
      '서버 시간대의 모든 시간을 표시합니다. 이는 웹 인터페이스의 동작을 모방합니다.';

  @override
  String get settingsVersion => 'App 버전';

  @override
  String get settingsVersionChecking => '확인 중…';

  @override
  String get transactionAttachments => '첨부 파일';

  @override
  String get transactionDeleteConfirm => '이 거래내역을 정말로 삭제할까요?';

  @override
  String get transactionDialogAttachmentsDelete => '첨부파일 삭제';

  @override
  String get transactionDialogAttachmentsDeleteConfirm => '첨부파일을 삭제하시겠습니까?';

  @override
  String get transactionDialogAttachmentsErrorDownload => '파일을 다운로드할 수 없습니다.';

  @override
  String transactionDialogAttachmentsErrorOpen(String error) {
    return '파일을 다운로드할 수 없음: $error';
  }

  @override
  String transactionDialogAttachmentsErrorUpload(String error) {
    return '파일을 업로드할 수 없음: $error';
  }

  @override
  String get transactionDialogAttachmentsTitle => '첨부 파일';

  @override
  String get transactionDialogBillNoBill => '구독 없음';

  @override
  String get transactionDialogBillTitle => '구독 링크';

  @override
  String get transactionDialogCurrencyTitle => '통화 선택';

  @override
  String get transactionDialogPiggyNoPiggy => 'No Piggy Bank';

  @override
  String get transactionDialogPiggyTitle => 'Link to Piggy Bank';

  @override
  String get transactionDialogTagsAdd => '태그 추가';

  @override
  String get transactionDialogTagsHint => 'Search/Add Tag';

  @override
  String get transactionDialogTagsTitle => '태그 선택';

  @override
  String get transactionDuplicate => '복제';

  @override
  String get transactionErrorInvalidAccount => '잘못된 계정';

  @override
  String get transactionErrorInvalidBudget => '잘못된 예산';

  @override
  String get transactionErrorNoAccounts => '먼저 계정을 입력해 주세요.';

  @override
  String get transactionErrorNoAssetAccount => '자산 계정을 선택해 주세요.';

  @override
  String get transactionErrorTitle => '제목을 입력하세요.';

  @override
  String get transactionFormLabelAccountDestination => '대상 계정';

  @override
  String get transactionFormLabelAccountForeign => 'Foreign account';

  @override
  String get transactionFormLabelAccountOwn => 'Own account';

  @override
  String get transactionFormLabelAccountSource => '소스 계정';

  @override
  String get transactionFormLabelNotes => '메모';

  @override
  String get transactionFormLabelTags => '태그';

  @override
  String get transactionFormLabelTitle => '적요';

  @override
  String get transactionSplitAdd => 'Add split transaction';

  @override
  String get transactionSplitChangeCurrency => 'Change Split Currency';

  @override
  String get transactionSplitChangeDestinationAccount =>
      'Change Split Destination Account';

  @override
  String get transactionSplitChangeSourceAccount =>
      'Change Split Source Account';

  @override
  String get transactionSplitChangeTarget => 'Change Split Target Account';

  @override
  String get transactionSplitDelete => '분할 삭제';

  @override
  String get transactionTitleAdd => '거래 추가';

  @override
  String get transactionTitleDelete => '거래 내역 삭제';

  @override
  String get transactionTitleEdit => '거래내역 편집';

  @override
  String get transactionTypeDeposit => 'Deposit';

  @override
  String get transactionTypeTransfer => '이체';

  @override
  String get transactionTypeWithdrawal => '출금';
}
