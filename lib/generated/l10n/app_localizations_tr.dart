// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class STr extends S {
  STr([String locale = 'tr']) : super(locale);

  @override
  String get accountRoleAssetCashWallet => 'Nakit Cüzdan';

  @override
  String get accountRoleAssetCC => 'Kredi Kartı';

  @override
  String get accountRoleAssetDefault => 'Varsayılan Varlık Hesabı';

  @override
  String get accountRoleAssetSavings => 'Birikim Hesabı';

  @override
  String get accountRoleAssetShared => 'Paylaşılan varlık hesabı';

  @override
  String get accountsLabelAsset => 'Varlık Hesapları';

  @override
  String get accountsLabelExpense => 'Harcama Hesabı';

  @override
  String get accountsLabelLiabilities => 'Yükümlülükler';

  @override
  String get accountsLabelRevenue => 'Gelir Hesabı';

  @override
  String accountsLiabilitiesInterest(double interest, String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'haftada',
      'monthly': 'ayda',
      'quarterly': 'çeyrekte',
      'halfyear': 'yarım yılda',
      'yearly': 'yılda',
      'other': 'bilinmeyen periyotta',
    });
    return '$interest% faiz (her $_temp0)';
  }

  @override
  String billsAmountAndFrequency(
    String minValue,
    String maxvalue,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Haftalık',
      'monthly': 'Aylık',
      'quarterly': 'Üç aylık',
      'halfyear': 'Altı aylık',
      'yearly': 'Yıllık',
      'other': 'Bilinmeyen',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', $skip defa atlar',
      zero: '',
    );
    return 'Abonelik, $minValue ve $maxvalue arasındaki işlemleri eşleştirir. $_temp0 tekrarlanır$_temp1.';
  }

  @override
  String get billsChangeLayoutTooltip => 'Düzeni değiştir';

  @override
  String get billsChangeSortOrderTooltip => 'Sıralama düzenini değiştir';

  @override
  String get billsErrorLoading => 'Abonelikler yüklenirken hata oluştu.';

  @override
  String billsExactAmountAndFrequency(
    String value,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Haftalık',
      'monthly': 'Aylık',
      'quarterly': 'Üç aylık',
      'halfyear': 'Altı aylık',
      'yearly': 'Yıllık',
      'other': 'Bilinmeyen',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', $skip defa atlar',
      zero: '',
    );
    return 'Abonelik, $value tutarındaki işlemleri eşleştirir. $_temp0 tekrarlanır$_temp1.';
  }

  @override
  String billsExpectedOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString tarihinde bekleniyor';
  }

  @override
  String billsFrequency(String frequency) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Haftalık',
      'monthly': 'Aylık',
      'quarterly': 'Üç aylık',
      'halfyear': 'Altı aylık',
      'yearly': 'Yıllık',
      'other': 'Bilinmeyen',
    });
    return '$_temp0';
  }

  @override
  String billsFrequencySkip(String frequency, num skip) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Haftalık',
      'monthly': 'Aylık',
      'quarterly': 'Üç aylık',
      'halfyear': 'Altı aylık',
      'yearly': 'Yıllık',
      'other': 'Bilinmeyen',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', $skip defa atlar',
      zero: '',
    );
    return '$_temp0$_temp1';
  }

  @override
  String get billsInactive => 'Pasif';

  @override
  String get billsIsActive => 'Abonelik aktif';

  @override
  String get billsLayoutGroupSubtitle =>
      'Abonelikler atanan gruplarına göre görüntülenir.';

  @override
  String get billsLayoutGroupTitle => 'Grup';

  @override
  String get billsLayoutListSubtitle =>
      'Abonelikler belirli kriterlere göre sıralanmış bir liste halinde görüntülenir.';

  @override
  String get billsLayoutListTitle => 'Liste';

  @override
  String get billsListEmpty => 'Liste şu anda boş.';

  @override
  String get billsNextExpectedMatch => 'Bir sonraki beklenen eşleşme';

  @override
  String get billsNotActive => 'Abonelik etkin değil';

  @override
  String get billsNotExpected => 'Bu dönem için beklenmiyor';

  @override
  String get billsNoTransactions => 'İşlem bulunamadı.';

  @override
  String billsPaidOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Ödenme tarihi: $dateString';
  }

  @override
  String get billsSortAlphabetical => 'Alfabetik';

  @override
  String get billsSortByTimePeriod => 'Zaman dönemine göre';

  @override
  String get billsSortFrequency => 'Sıklık';

  @override
  String get billsSortName => 'İsim';

  @override
  String get billsUngrouped => 'Gruplandırılmamış';

  @override
  String get billsSettingsShowOnlyActive => 'Sadece aktif olanları göster';

  @override
  String get billsSettingsShowOnlyActiveDesc =>
      'Sadece aktif abonelikleri gösterir.';

  @override
  String get billsSettingsShowOnlyExpected => 'Sadece beklenenleri göster';

  @override
  String get billsSettingsShowOnlyExpectedDesc =>
      'Sadece bu ay beklenen (veya ödenmiş) abonelikleri gösterir.';

  @override
  String get categoryDeleteConfirm =>
      'Bu kategoriyi silmek istediğinize emin misiniz? İşlemler silinmeyecek, ancak artık bir kategorileri olmayacak.';

  @override
  String get categoryErrorLoading => 'Kategoriler yüklenirken hata oluştu.';

  @override
  String get categoryFormLabelIncludeInSum => 'Aylık toplama dahil et';

  @override
  String get categoryFormLabelName => 'Kategori Adı';

  @override
  String get categoryMonthNext => 'Gelecek Ay';

  @override
  String get categoryMonthPrev => 'Önceki Ay';

  @override
  String get categorySumExcluded => 'hariç';

  @override
  String get categoryTitleAdd => 'Kategori Ekle';

  @override
  String get categoryTitleDelete => 'Kategoriyi Sil';

  @override
  String get categoryTitleEdit => 'Kategoriyi Düzenle';

  @override
  String get catNone => '<kategori yok>';

  @override
  String get catOther => 'Diğer';

  @override
  String errorAPIInvalidResponse(String message) {
    return 'API\'den geçersiz yanıt: $message';
  }

  @override
  String get errorAPIUnavailable => 'API kullanılamıyor';

  @override
  String get errorFieldRequired => 'Bu alan zorunludur.';

  @override
  String get errorInvalidURL => 'Geçersiz URL';

  @override
  String errorMinAPIVersion(String requiredVersion) {
    return 'Minimum Firefly API Sürümü v$requiredVersion gereklidir. Lütfen güncelleyin.';
  }

  @override
  String errorStatusCode(int code) {
    return 'Durum Kodu: $code';
  }

  @override
  String get errorUnknown => 'Bilinmeyen hata.';

  @override
  String get formButtonHelp => 'Yardım';

  @override
  String get formButtonLogin => 'Giriş yap';

  @override
  String get formButtonLogout => 'Çıkış yap';

  @override
  String get formButtonRemove => 'Kaldır';

  @override
  String get formButtonResetLogin => 'Girişi sıfırla';

  @override
  String get formButtonTransactionAdd => 'İşlem Ekle';

  @override
  String get formButtonTryAgain => 'Tekrar dene';

  @override
  String get generalAccount => 'Hesap';

  @override
  String get generalAssets => 'Varlıklar';

  @override
  String get generalBalance => 'Bakiye';

  @override
  String generalBalanceOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString tarihindeki bakiye';
  }

  @override
  String get generalBill => 'Abonelik';

  @override
  String get generalBudget => 'Bütçe';

  @override
  String get generalCategory => 'Kategori';

  @override
  String get generalCurrency => 'Para Birimi';

  @override
  String get generalDateRangeCurrentMonth => 'Bu Ay';

  @override
  String get generalDateRangeLast30Days => 'Son 30 gün';

  @override
  String get generalDateRangeCurrentYear => 'Bu Yıl';

  @override
  String get generalDateRangeLastYear => 'Geçen Yıl';

  @override
  String get generalDateRangeAll => 'Tümü';

  @override
  String get generalDefault => 'varsayılan';

  @override
  String get generalDestinationAccount => 'Hedef Hesap';

  @override
  String get generalDismiss => 'Kapat';

  @override
  String get generalEarned => 'Kazanılan';

  @override
  String get generalError => 'Hata';

  @override
  String get generalExpenses => 'Giderler';

  @override
  String get generalIncome => 'Gelir';

  @override
  String get generalLiabilities => 'Yükümlülükler';

  @override
  String get generalMultiple => 'birden fazla';

  @override
  String get generalNever => 'asla';

  @override
  String get generalReconcile => 'Mutabık kalındı';

  @override
  String get generalReset => 'Sıfırla';

  @override
  String get generalSourceAccount => 'Kaynak Hesap';

  @override
  String get generalSpent => 'Harcanan';

  @override
  String get generalSum => 'Toplam';

  @override
  String get generalTarget => 'Hedef';

  @override
  String get generalUnknown => 'Bilinmiyor';

  @override
  String homeMainBillsInterval(String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'haftalık',
      'monthly': 'aylık',
      'quarterly': 'üç aylık',
      'halfyear': 'altı aylık',
      'yearly': 'yıllık',
      'other': 'bilinmiyor',
    });
    return ' ($_temp0)';
  }

  @override
  String get homeMainBillsTitle => 'Önümüzdeki hafta için abonelikler';

  @override
  String homeMainBudgetInterval(DateTime from, DateTime to, String period) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return ' ($fromString - $toString, $period)';
  }

  @override
  String homeMainBudgetIntervalSingle(DateTime from, DateTime to) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return ' ($fromString - $toString)';
  }

  @override
  String homeMainBudgetSum(String current, String status, String available) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'over': 'aşıldı, toplam bütçe:',
      'other': 'kalan bütçe:',
    });
    return '$current $_temp0 $available';
  }

  @override
  String get homeMainBudgetTitle => 'Cari ay için bütçeler';

  @override
  String get homeMainChartAccountsTitle => 'Hesap Özeti';

  @override
  String get homeMainChartCategoriesTitle => 'Cari ay için kategori özeti';

  @override
  String get homeMainChartDailyAvg => '7 günlük ortalama';

  @override
  String get homeMainChartDailyTitle => 'Günlük Özet';

  @override
  String get homeMainChartNetEarningsTitle => 'Net Kazanç';

  @override
  String get homeMainChartNetWorthTitle => 'Net Değer';

  @override
  String get homeMainChartTagsTitle => 'Cari ay için etiket özeti';

  @override
  String get homePiggyAdjustDialogTitle => 'Para Ekle/Çıkar';

  @override
  String homePiggyDateStart(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Başlangıç tarihi: $dateString';
  }

  @override
  String homePiggyDateTarget(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Hedef tarih: $dateString';
  }

  @override
  String get homeMainDialogSettingsTitle => 'Paneli Özelleştir';

  @override
  String homePiggyLinked(String account) {
    return '$account hesabına bağlı';
  }

  @override
  String get homePiggyNoAccounts => 'Hiç kumbara oluşturulmamış.';

  @override
  String get homePiggyNoAccountsSubtitle =>
      'Web arayüzünden birkaç tane oluşturun!';

  @override
  String homePiggyRemaining(String amount) {
    return 'Biriktirilmesi gereken: $amount';
  }

  @override
  String homePiggySaved(String amount) {
    return 'Şu ana kadar biriken: $amount';
  }

  @override
  String get homePiggySavedMultiple => 'Şu ana kadar biriken:';

  @override
  String homePiggyTarget(String amount) {
    return 'Hedef tutar: $amount';
  }

  @override
  String get homePiggyAccountStatus => 'Hesap Durumu';

  @override
  String get homePiggyAvailableAmounts => 'Kullanılabilir Miktarlar';

  @override
  String homePiggyAvailable(String amount) {
    return 'Kullanılabilir: $amount';
  }

  @override
  String homePiggyInPiggyBanks(String amount) {
    return 'Kumbaralarda: $amount';
  }

  @override
  String get homeTabLabelBalance => 'Bilanço';

  @override
  String get homeTabLabelMain => 'Ana Sayfa';

  @override
  String get homeTabLabelPiggybanks => 'Kumbaralar';

  @override
  String get homeTabLabelTransactions => 'İşlemler';

  @override
  String get homeTransactionsActionFilter => 'Listeyi Filtrele';

  @override
  String get homeTransactionsDialogFilterAccountsAll => '<Tüm Hesaplar>';

  @override
  String get homeTransactionsDialogFilterBillsAll => '<Tüm Abonelikler>';

  @override
  String get homeTransactionsDialogFilterBillUnset => '<Abonelik atanmamış>';

  @override
  String get homeTransactionsDialogFilterBudgetsAll => '<Tüm Bütçeler>';

  @override
  String get homeTransactionsDialogFilterBudgetUnset => '<Bütçe atanmamış>';

  @override
  String get homeTransactionsDialogFilterCategoriesAll => '<Tüm Kategoriler>';

  @override
  String get homeTransactionsDialogFilterCategoryUnset =>
      '<Kategori atanmamış>';

  @override
  String get homeTransactionsDialogFilterCurrenciesAll =>
      '<Tüm Para Birimleri>';

  @override
  String get homeTransactionsDialogFilterDateRange => 'Tarih Aralığı';

  @override
  String get homeTransactionsDialogFilterFutureTransactions =>
      'Gelecek işlemleri göster';

  @override
  String get homeTransactionsDialogFilterSearch => 'Arama Terimi';

  @override
  String get homeTransactionsDialogFilterTitle => 'Filtreleri seç';

  @override
  String get homeTransactionsEmpty => 'İşlem bulunamadı.';

  @override
  String homeTransactionsMultipleCategories(int num) {
    String _temp0 = intl.Intl.pluralLogic(
      num,
      locale: localeName,
      other: '$num kategori',
      one: '$num kategori',
    );
    return '$_temp0';
  }

  @override
  String get homeTransactionsSettingsShowTags =>
      'İşlem listesinde etiketleri göster';

  @override
  String get liabilityDirectionCredit => 'Bu borç bana ödenmeli';

  @override
  String get liabilityDirectionDebit => 'Bu borcu ben ödemeliyim';

  @override
  String get liabilityTypeDebt => 'Borç';

  @override
  String get liabilityTypeLoan => 'Kredi';

  @override
  String get liabilityTypeMortgage => 'İpotek';

  @override
  String get loginAbout =>
      'Waterfly III\'ü verimli kullanabilmek için kendi Firefly III sunucunuza veya Home Assistant için Firefly III eklentisine ihtiyacınız var.\n\nLütfen aşağıya tam URL adresini ve kişisel erişim jetonunu (Ayarlar -> Profil -> OAuth -> Personal Access Token) girin.';

  @override
  String get loginFormButtonHideHeaders => 'Başlıkları Gizle';

  @override
  String get loginFormButtonShowHeaders => 'Özel Başlıklar';

  @override
  String get loginFormLabelAPIKey => 'Geçerli API Anahtarı';

  @override
  String get loginFormLabelHeaders => 'Özel Başlıklar (isteğe bağlı)';

  @override
  String get loginFormLabelHeadersHelp =>
      'Her satıra bir tane, biçim: HeaderName: değer';

  @override
  String get loginFormLabelHost => 'Sunucu URL\'si';

  @override
  String get loginWelcome => 'Waterfly III\'e Hoş Geldiniz';

  @override
  String get logoutConfirmation => 'Çıkış yapmak istediğinizden emin misiniz?';

  @override
  String get navigationAccounts => 'Hesaplar';

  @override
  String get navigationBills => 'Abonelikler';

  @override
  String get navigationCategories => 'Kategoriler';

  @override
  String get navigationMain => 'Kontrol Paneli';

  @override
  String get generalSettings => 'Ayarlar';

  @override
  String get no => 'Hayır';

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

    return '$percString / $of';
  }

  @override
  String get settingsDialogDebugInfo =>
      'Hata ayıklama günlüklerini buradan etkinleştirebilir ve gönderebilirsiniz. Bunların performans üzerinde olumsuz bir etkisi vardır, bu nedenle tavsiye edilmedikçe etkinleştirmeyin. Günlüğe kaydı devre dışı bırakmak, kayıtlı günlükleri silecektir.';

  @override
  String get settingsDialogDebugMailCreate => 'E-posta Oluştur';

  @override
  String get settingsDialogDebugMailDisclaimer =>
      'UYARI: Günlük dosyası eklenmiş (metin formatında) bir e-posta taslağı açılacaktır. Günlükler, Firefly örneğinizin ana bilgisayar adı gibi hassas bilgiler içerebilir (api anahtarı gibi sırların kaydedilmemesine özen gösterilse de). Lütfen günlüğü dikkatlice okuyun ve paylaşmak istemediğiniz ve/veya bildirmek istediğiniz sorunla ilgili olmayan bilgileri karartın.\n\nLütfen önceden e-posta/GitHub yoluyla mutabakat sağlamadan günlük göndermeyin. Bağlamı olmayan günlükleri gizlilik nedenleriyle sileceğim. Günlüğü asla sansürsüz olarak GitHub\'a veya başka bir yere yüklemeyin.';

  @override
  String get settingsDialogDebugSendButton => 'Günlükleri E-posta ile Gönder';

  @override
  String get settingsDialogDebugTitle => 'Hata Ayıklama Günlükleri';

  @override
  String get settingsDialogLanguageTitle => 'Dil Seçin';

  @override
  String get settingsDialogThemeTitle => 'Tema Seçin';

  @override
  String get settingsFAQ => 'SSS';

  @override
  String get settingsFAQHelp =>
      'Tarayıcıda açılır. Sadece İngilizce mevcuttur.';

  @override
  String get settingsLanguage => 'Dil';

  @override
  String get settingsLockscreen => 'Kilit Ekranı';

  @override
  String get settingsLockscreenHelp =>
      'Uygulama başlatılırken kimlik doğrulaması iste';

  @override
  String get settingsLockscreenInitial =>
      'Kilit ekranını etkinleştirmek için lütfen kimlik doğrulaması yapın.';

  @override
  String get settingsNLAppAccount => 'Varsayılan Hesap';

  @override
  String get settingsNLAppAccountDynamic => '<Dinamik>';

  @override
  String get settingsNLAppAdd => 'Uygulama Ekle';

  @override
  String get settingsNLAppAddHelp =>
      'Dinlenecek bir uygulama eklemek için tıklayın. Sadece uygun uygulamalar listede görünecektir.';

  @override
  String get settingsNLAppAddInfo =>
      'Listeye uygulama eklemek için telefonunuza bildirim gelen bazı işlemler yapın. Uygulama hala görünmüyorsa, lütfen app@vogt.pw adresine bildirin.';

  @override
  String get settingsNLAutoAdd => 'İşlemi etkileşim olmadan oluştur';

  @override
  String get settingsNLDescription =>
      'Bu servis, gelen bildirimlerden işlem detaylarını almanızı sağlar. Ek olarak, işleme atanacak varsayılan bir hesap seçebilirsiniz - eğer hiçbir değer ayarlanmazsa, bildirimden bir hesap çıkarmaya çalışır.';

  @override
  String get settingsNLEmptyNote => 'Not alanını boş bırak';

  @override
  String get settingsNLHistory => 'Bildirim Geçmişi';

  @override
  String get settingsNLHistoryEmpty => 'Henüz hiçbir bildirim kaydedilmedi.';

  @override
  String settingsNLHistoryLongDescription(int notificationHistorySize) {
    return 'Bu, uygulama tarafından alınan son $notificationHistorySize bildirimin geçmişidir. Ayrıca (geçerli) bildirimlerden işlemler oluşturabilir veya bir bildirimin neden işlenemediğini görebilirsiniz.';
  }

  @override
  String settingsNLHistoryRejectedReason(String reason) {
    String _temp0 = intl.Intl.selectLogic(reason, {
      'noMoney': 'Parasal değer bulunamadı',
      'noCurrency': 'Para birimi bulunamadı',
      'appNotUsed': 'Uygulama dinlenmiyor',
      'other': 'Bilinmeyen neden',
    });
    return 'Bildirim atlandı: $_temp0.';
  }

  @override
  String get settingsNLHistoryShortDescription => 'Önceki bildirimleri listele';

  @override
  String get settingsNLPermissionGrant => 'İzin vermek için dokunun.';

  @override
  String get settingsNLPermissionNotGranted => 'İzin verilmedi.';

  @override
  String get settingsNLPermissionRemove => 'İzin kaldırılsın mı?';

  @override
  String get settingsNLPermissionRemoveHelp =>
      'Bu hizmeti devre dışı bırakmak için uygulamaya tıklayın ve bir sonraki ekranda izinleri kaldırın.';

  @override
  String get settingsNLPrefillTXTitle =>
      'İşlem başlığını bildirim başlığı ile önceden doldur';

  @override
  String get settingsNLRegularExpression => 'Düzenli İfade (isteğe bağlı)';

  @override
  String get settingsNLRegularExpressionInvalid => 'Geçersiz Düzenli İfade';

  @override
  String get settingsNLServiceChecking => 'Durum kontrol ediliyor…';

  @override
  String settingsNLServiceCheckingError(String error) {
    return 'Durum kontrol edilirken hata oluştu: $error';
  }

  @override
  String get settingsNLServiceRunning => 'Hizmet çalışıyor.';

  @override
  String get settingsNLServiceStatus => 'Hizmet Durumu';

  @override
  String get settingsNLServiceStopped => 'Hizmet durduruldu.';

  @override
  String get settingsNotificationListener => 'Bildirim Dinleyici Hizmeti';

  @override
  String get settingsServerConnection => 'Sunucu Bağlantısı';

  @override
  String get settingsServerConnectionUpdated =>
      'Bağlantı ayarları güncellendi.';

  @override
  String get settingsTheme => 'Uygulama Teması';

  @override
  String get settingsThemeDynamicColors => 'Dinamik Renkler';

  @override
  String settingsThemeValue(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'dark': 'Koyu Mod',
      'light': 'Açık Mod',
      'other': 'Sistem Varsayılanı',
    });
    return '$_temp0';
  }

  @override
  String get settingsUseServerTimezone => 'Sunucu saat dilimini kullan';

  @override
  String get settingsUseServerTimezoneHelp =>
      'Tüm zamanları sunucu saat diliminde göster. Bu, web arayüzünün davranışını taklit eder.';

  @override
  String get settingsVersion => 'Uygulama Sürümü';

  @override
  String get settingsVersionChecking => 'kontrol ediliyor…';

  @override
  String get transactionAttachments => 'Ekler';

  @override
  String get transactionDeleteConfirm =>
      'Bu işlemi silmek istediğinizden emin misiniz?';

  @override
  String get transactionDialogAttachmentsDelete => 'Eki Sil';

  @override
  String get transactionDialogAttachmentsDeleteConfirm =>
      'Bu eki silmek istediğinizden emin misiniz?';

  @override
  String get transactionDialogAttachmentsErrorDownload => 'Dosya indirilemedi.';

  @override
  String transactionDialogAttachmentsErrorOpen(String error) {
    return 'Dosya açılamadı: $error';
  }

  @override
  String transactionDialogAttachmentsErrorUpload(String error) {
    return 'Dosya yüklenemedi: $error';
  }

  @override
  String get transactionDialogAttachmentsTitle => 'Ekler';

  @override
  String get transactionDialogBillNoBill => 'Abonelik yok';

  @override
  String get transactionDialogBillTitle => 'Aboneliğe Bağla';

  @override
  String get transactionDialogCurrencyTitle => 'Para birimi seç';

  @override
  String get transactionDialogPiggyNoPiggy => 'Kumbarası yok';

  @override
  String get transactionDialogPiggyTitle => 'Kumbaraya Bağla';

  @override
  String get transactionDialogTagsAdd => 'Etiket Ekle';

  @override
  String get transactionDialogTagsHint => 'Etiket Ara/Ekle';

  @override
  String get transactionDialogTagsTitle => 'Etiketleri seç';

  @override
  String get transactionDuplicate => 'Çoğalt';

  @override
  String get transactionErrorInvalidAccount => 'Geçersiz Hesap';

  @override
  String get transactionErrorInvalidBudget => 'Geçersiz Bütçe';

  @override
  String get transactionErrorNoAccounts => 'Lütfen önce hesapları doldurun.';

  @override
  String get transactionErrorNoAssetAccount =>
      'Lütfen bir varlık hesabı seçin.';

  @override
  String get transactionErrorTitle => 'Lütfen bir başlık girin.';

  @override
  String get transactionFormLabelAccountDestination => 'Hedef hesap';

  @override
  String get transactionFormLabelAccountForeign => 'Yabancı hesap';

  @override
  String get transactionFormLabelAccountOwn => 'Kendi hesabım';

  @override
  String get transactionFormLabelAccountSource => 'Kaynak hesap';

  @override
  String get transactionFormLabelNotes => 'Notlar';

  @override
  String get transactionFormLabelTags => 'Etiketler';

  @override
  String get transactionFormLabelTitle => 'İşlem Başlığı';

  @override
  String get transactionSplitAdd => 'Bölünmüş işlem ekle';

  @override
  String get transactionSplitChangeCurrency =>
      'Bölünmüş İşlem Para Birimini Değiştir';

  @override
  String get transactionSplitChangeDestinationAccount =>
      'Bölünmüş İşlem Hedef Hesabını Değiştir';

  @override
  String get transactionSplitChangeSourceAccount =>
      'Bölünmüş İşlem Kaynak Hesabını Değiştir';

  @override
  String get transactionSplitChangeTarget =>
      'Bölünmüş İşlem Hedef Hesabını Değiştir';

  @override
  String get transactionSplitDelete => 'Bölünmüş işlemi sil';

  @override
  String get transactionTitleAdd => 'İşlem Ekle';

  @override
  String get transactionTitleDelete => 'İşlemi Sil';

  @override
  String get transactionTitleEdit => 'İşlemi Düzenle';

  @override
  String get transactionTypeDeposit => 'Para Yatırma';

  @override
  String get transactionTypeTransfer => 'Transfer';

  @override
  String get transactionTypeWithdrawal => 'Para Çekme';
}
