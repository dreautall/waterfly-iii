// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class SId extends S {
  SId([String locale = 'id']) : super(locale);

  @override
  String get accountRoleAssetCashWallet => 'Dompet Kas';

  @override
  String get accountRoleAssetCC => 'Kartu kredit';

  @override
  String get accountRoleAssetDefault => 'Akun aset standar';

  @override
  String get accountRoleAssetSavings => 'Akun tabungan';

  @override
  String get accountRoleAssetShared => 'Akun aset bersama';

  @override
  String get accountsLabelAsset => 'Akun Aset';

  @override
  String get accountsLabelExpense => 'Akun Pengeluaran';

  @override
  String get accountsLabelLiabilities => 'Kewajiban';

  @override
  String get accountsLabelRevenue => 'Akun Pendapatan';

  @override
  String accountsLiabilitiesInterest(double interest, String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'minggu',
      'monthly': 'bulan',
      'quarterly': 'perempat',
      'halfyear': 'setengah-tahun',
      'yearly': 'tahun',
      'other': 'tidak-diketahui',
    });
    return '$interest% bunga per $_temp0';
  }

  @override
  String billsAmountAndFrequency(
    String minValue,
    String maxvalue,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'mingguan',
      'monthly': 'bulanan',
      'quarterly': 'triwulanan',
      'halfyear': 'setengah tahunan',
      'yearly': 'tahunan',
      'other': 'tidak diketahui',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', melewati $skip',
    );
    return 'Langganan cocok dengan transaksi antara $minValue dan $maxvalue. Berulang $_temp0$_temp1.';
  }

  @override
  String get billsChangeLayoutTooltip => 'Ubah tata letak';

  @override
  String get billsChangeSortOrderTooltip => 'Ubah urutan penyortiran';

  @override
  String get billsErrorLoading => 'Terjadi kesalahan saat memuat langganan.';

  @override
  String billsExactAmountAndFrequency(
    String value,
    String frequency,
    num skip,
  ) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'mingguan',
      'monthly': 'bulanan',
      'quarterly': 'triwulanan',
      'halfyear': 'setengah tahunan',
      'yearly': 'tahunan',
      'other': 'tidak diketahui',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', melewati $skip',
    );
    return 'Langganan cocok dengan transaksi sebesar $value. Berulang $_temp0$_temp1.';
  }

  @override
  String billsExpectedOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Diharapkan $dateString';
  }

  @override
  String billsFrequency(String frequency) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Mingguan',
      'monthly': 'Bulanan',
      'quarterly': 'Triwulanan',
      'halfyear': 'Setengah tahunan',
      'yearly': 'Tahunan',
      'other': 'Tidak diketahui',
    });
    return '$_temp0';
  }

  @override
  String billsFrequencySkip(String frequency, num skip) {
    String _temp0 = intl.Intl.selectLogic(frequency, {
      'weekly': 'Mingguan',
      'monthly': 'Bulanan',
      'quarterly': 'Triwulanan',
      'halfyear': 'Setengah tahunan',
      'yearly': 'Tahunan',
      'other': 'Tidak diketahui',
    });
    String _temp1 = intl.Intl.pluralLogic(
      skip,
      locale: localeName,
      other: ', melewati $skip',
    );
    return '$_temp0$_temp1';
  }

  @override
  String get billsInactive => 'Tidak aktif';

  @override
  String get billsIsActive => 'Langganan aktif';

  @override
  String get billsLayoutGroupSubtitle =>
      'Langganan ditampilkan dalam grup yang telah ditetapkan.';

  @override
  String get billsLayoutGroupTitle => 'Grup';

  @override
  String get billsLayoutListSubtitle =>
      'Langganan ditampilkan dalam daftar yang diurutkan berdasarkan kriteria tertentu.';

  @override
  String get billsLayoutListTitle => 'Daftar';

  @override
  String get billsListEmpty => 'Daftar saat ini kosong.';

  @override
  String get billsNextExpectedMatch => 'Kecocokan yang diharapkan berikutnya';

  @override
  String get billsNotActive => 'Langganan tidak aktif';

  @override
  String get billsNotExpected => 'Tidak diharapkan dalam periode ini';

  @override
  String get billsNoTransactions => 'Tidak ada transaksi ditemukan.';

  @override
  String billsPaidOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Dibayar $dateString';
  }

  @override
  String get billsSortAlphabetical => 'Menurut Abjad';

  @override
  String get billsSortByTimePeriod => 'Berdasarkan periode waktu';

  @override
  String get billsSortFrequency => 'Frekuensi';

  @override
  String get billsSortName => 'Nama';

  @override
  String get billsUngrouped => 'Tidak Terkelompok';

  @override
  String get billsSettingsShowOnlyActive => 'Tampilkan yang aktif saja';

  @override
  String get billsSettingsShowOnlyActiveDesc =>
      'Menampilkan langganan yang aktif saja.';

  @override
  String get billsSettingsShowOnlyExpected => 'Tampilkan yang diharapkan saja';

  @override
  String get billsSettingsShowOnlyExpectedDesc =>
      'Menampilkan langganan yang diharapkan (atau dibayar) bulan ini saja.';

  @override
  String get categoryDeleteConfirm =>
      'Apakah Anda yakin ingin menghapus kategori ini? Transaksi tidak akan dihapus, tetapi tidak akan memiliki kategori lagi.';

  @override
  String get categoryErrorLoading => 'Gagal memuat kategori.';

  @override
  String get categoryFormLabelIncludeInSum => 'Sertakan dalam jumlah bulanan';

  @override
  String get categoryFormLabelName => 'Nama Kategori';

  @override
  String get categoryMonthNext => 'Bulan Berikutnya';

  @override
  String get categoryMonthPrev => 'Bulan Sebelumnya';

  @override
  String get categorySumExcluded => 'dikecualikan';

  @override
  String get categoryTitleAdd => 'Tambah Kategori';

  @override
  String get categoryTitleDelete => 'Hapus Kategori';

  @override
  String get categoryTitleEdit => 'Edit Kategori';

  @override
  String get catNone => '<tanpa kategori>';

  @override
  String get catOther => 'Lainnya';

  @override
  String errorAPIInvalidResponse(String message) {
    return 'Respons dari API tidak Valid: $message';
  }

  @override
  String get errorAPIUnavailable => 'API tidak tersedia';

  @override
  String get errorFieldRequired => 'Kolom ini diperlukan.';

  @override
  String get errorInvalidURL => 'URL tidak Valid';

  @override
  String errorMinAPIVersion(String requiredVersion) {
    return 'Versi Firefly API Minimum v$requiredVersion diperlukan. Mohon tingkatkan.';
  }

  @override
  String errorStatusCode(int code) {
    return 'Kode Status: $code';
  }

  @override
  String get errorUnknown => 'Kesalahan tidak diketahui.';

  @override
  String get formButtonHelp => 'Bantuan';

  @override
  String get formButtonLogin => 'Masuk';

  @override
  String get formButtonLogout => 'Keluar';

  @override
  String get formButtonRemove => 'Hapus';

  @override
  String get formButtonResetLogin => 'Setel ulang masuk';

  @override
  String get formButtonTransactionAdd => 'Tambah Transaksi';

  @override
  String get formButtonTryAgain => 'Coba lagi';

  @override
  String get generalAccount => 'Akun';

  @override
  String get generalAssets => 'Aset';

  @override
  String get generalBalance => 'Saldo';

  @override
  String generalBalanceOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Saldo pada tanggal $dateString';
  }

  @override
  String get generalBill => 'Tagihan';

  @override
  String get generalBudget => 'Anggaran';

  @override
  String get generalCategory => 'Kategori';

  @override
  String get generalCurrency => 'Mata Uang';

  @override
  String get generalDateRangeCurrentMonth => 'Bulan Ini';

  @override
  String get generalDateRangeLast30Days => '30 hari terakhir';

  @override
  String get generalDateRangeCurrentYear => 'Tahun Ini';

  @override
  String get generalDateRangeLastYear => 'Tahun lalu';

  @override
  String get generalDateRangeAll => 'Semua';

  @override
  String get generalDefault => 'bawaan';

  @override
  String get generalDestinationAccount => 'Akun Tujuan';

  @override
  String get generalDismiss => 'Tutup';

  @override
  String get generalEarned => 'Didapatkan';

  @override
  String get generalError => 'Kesalahan';

  @override
  String get generalExpenses => 'Pengeluaran';

  @override
  String get generalIncome => 'Pendapatan';

  @override
  String get generalLiabilities => 'Kewajiban';

  @override
  String get generalMultiple => 'beberapa';

  @override
  String get generalNever => 'tidak pernah';

  @override
  String get generalReconcile => 'Terekonsiliasi';

  @override
  String get generalReset => 'Setel ulang';

  @override
  String get generalSourceAccount => 'Akun Sumber';

  @override
  String get generalSpent => 'Dihabiskan';

  @override
  String get generalSum => 'Jumlah';

  @override
  String get generalTarget => 'Target';

  @override
  String get generalUnknown => 'Tidak Diketahui';

  @override
  String homeMainBillsInterval(String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'weekly': 'mingguan',
      'monthly': 'bulanan',
      'quarterly': 'triwulanan',
      'halfyear': 'setengah tahunan',
      'yearly': 'tahunan',
      'other': 'tidak diketahui',
    });
    return ' ($_temp0)';
  }

  @override
  String get homeMainBillsTitle => 'Langganan untuk minggu depan';

  @override
  String homeMainBudgetInterval(DateTime from, DateTime to, String period) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return ' ($fromString ke $toString, $period)';
  }

  @override
  String homeMainBudgetIntervalSingle(DateTime from, DateTime to) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.MMMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.MMMd(localeName);
    final String toString = toDateFormat.format(to);

    return ' ($fromString sampai $toString)';
  }

  @override
  String homeMainBudgetSum(String current, String status, String available) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'over': 'di atas',
      'other': 'sisa dari',
    });
    return '$current$_temp0$available';
  }

  @override
  String get homeMainBudgetTitle => 'Anggaran bulan berjalan';

  @override
  String get homeMainChartAccountsTitle => 'Ringkasan Akun';

  @override
  String get homeMainChartCategoriesTitle =>
      'Ringkasan Kategori bulan berjalan';

  @override
  String get homeMainChartDailyAvg => 'Rata-rata 7 hari';

  @override
  String get homeMainChartDailyTitle => 'Ringkasan Harian';

  @override
  String get homeMainChartNetEarningsTitle => 'Pendapatan Bersih';

  @override
  String get homeMainChartNetWorthTitle => 'Kekayaan Bersih';

  @override
  String get homeMainChartTagsTitle => 'Ringkasan Tag untuk bulan ini';

  @override
  String get homePiggyAdjustDialogTitle => 'Simpan/Belanjakan Uang';

  @override
  String homePiggyDateStart(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Tanggal mulai: $dateString';
  }

  @override
  String homePiggyDateTarget(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Tanggal target: $dateString';
  }

  @override
  String get homeMainDialogSettingsTitle => 'Sesuaikan Dasbor';

  @override
  String homePiggyLinked(String account) {
    return 'Tautkan ke $account';
  }

  @override
  String get homePiggyNoAccounts => 'Tidak ada celengan yang tersiapkan.';

  @override
  String get homePiggyNoAccountsSubtitle => 'Buat beberapa pada antarmuka web!';

  @override
  String homePiggyRemaining(String amount) {
    return 'Tersisa untuk ditabung: $amount';
  }

  @override
  String homePiggySaved(String amount) {
    return 'Tertabung sejauh ini: $amount';
  }

  @override
  String get homePiggySavedMultiple => 'Tersimpan sejauh ini:';

  @override
  String homePiggyTarget(String amount) {
    return 'Jumlah target: $amount';
  }

  @override
  String get homePiggyAccountStatus => 'Status Akun';

  @override
  String get homePiggyAvailableAmounts => 'Jumlah Tersedia';

  @override
  String homePiggyAvailable(String amount) {
    return 'Tersedia: $amount';
  }

  @override
  String homePiggyInPiggyBanks(String amount) {
    return 'Di celengan: $amount';
  }

  @override
  String get homeTabLabelBalance => 'Neraca Keuangan';

  @override
  String get homeTabLabelMain => 'Utama';

  @override
  String get homeTabLabelPiggybanks => 'Celengan';

  @override
  String get homeTabLabelTransactions => 'Transaksi';

  @override
  String get homeTransactionsActionFilter => 'Filter Daftar';

  @override
  String get homeTransactionsDialogFilterAccountsAll => '<Semua Akun>';

  @override
  String get homeTransactionsDialogFilterBillsAll => '<Semua Tagihan>';

  @override
  String get homeTransactionsDialogFilterBillUnset =>
      '<Tidak ada Tagihan tersetel>';

  @override
  String get homeTransactionsDialogFilterBudgetsAll => '<Semua Anggaran>';

  @override
  String get homeTransactionsDialogFilterBudgetUnset =>
      '<Tidak ada Anggaran tersetel>';

  @override
  String get homeTransactionsDialogFilterCategoriesAll => '<Semua Kategori>';

  @override
  String get homeTransactionsDialogFilterCategoryUnset =>
      '<Tidak ada Kategori tersetel>';

  @override
  String get homeTransactionsDialogFilterCurrenciesAll => '<Semua Mata Uang>';

  @override
  String get homeTransactionsDialogFilterDateRange => 'Rentang Tanggal';

  @override
  String get homeTransactionsDialogFilterFutureTransactions =>
      'Tampilkan transaksi mendatang';

  @override
  String get homeTransactionsDialogFilterSearch => 'Istilah Pencarian';

  @override
  String get homeTransactionsDialogFilterTitle => 'Pilih filter';

  @override
  String get homeTransactionsEmpty => 'Transaksi tidak ditemukan.';

  @override
  String homeTransactionsMultipleCategories(int num) {
    return '$num kategori';
  }

  @override
  String get homeTransactionsSettingsShowTags =>
      'Tampilkan tag di daftar transaksi';

  @override
  String get liabilityDirectionCredit => 'Saya pemberi hutang ini';

  @override
  String get liabilityDirectionDebit => 'Saya berhutang hutang ini';

  @override
  String get liabilityTypeDebt => 'Hutang';

  @override
  String get liabilityTypeLoan => 'Pinjaman';

  @override
  String get liabilityTypeMortgage => 'Hipotek';

  @override
  String get loginAbout =>
      'Untuk menggunakan Waterfly III secara produktif anda memerlukan server sendiri dengan instansi Firefly III atau tambahan Firefly III untuk Home Assistant.\n\nSilahkan masukkan URL penuh serta token akses pribadi (Pengaturan -> Profil -> OAuth -> Token Akses Pribadi) di bawah.';

  @override
  String get loginFormLabelAPIKey => 'Kunci API Valid';

  @override
  String get loginFormLabelHost => 'URL Host';

  @override
  String get loginWelcome => 'Selamat Datang di Waterfly III';

  @override
  String get logoutConfirmation => 'Yakin ingin keluar?';

  @override
  String get navigationAccounts => 'Akun';

  @override
  String get navigationBills => 'Langganan';

  @override
  String get navigationCategories => 'Kategori';

  @override
  String get navigationMain => 'Dasbor Utama';

  @override
  String get generalSettings => 'Pengaturan';

  @override
  String get no => 'Tidak';

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

    return '$percString dari $of';
  }

  @override
  String get settingsDialogDebugInfo =>
      'Anda dapat mengaktifkan & mengirim log debug di sini. Akan berdampak buruk pada kinerja, mohon jangan diaktifkan kecuali anda disarankan. Menonaktifkan logging akan menghapus log yang tersimpan.';

  @override
  String get settingsDialogDebugMailCreate => 'Buat Surat';

  @override
  String get settingsDialogDebugMailDisclaimer =>
      'PERHATIAN: Draf surat akan terbuka dengan file log terlampir (dalam format teks). Log mungkin berisi informasi sensitif, seperti nama host instansi Firefly anda (walaupun saya mencoba menghindari pencatatan rahasia apapun, seperti kunci API). Harap baca log dengan cermat dan sensor informasi yang tidak ingin anda bagikan dan/atau tidak relevan dengan masalah yang ingin dilaporkan.\n\nMohon jangan mengirimkan log tanpa persetujuan awal via email/GitHub. Saya akan menghapus semua log yang dikirimkan tanpa konteks untuk alasan privasi. Jangan unggah log tanpa sensor ke GitHub atau manapun.';

  @override
  String get settingsDialogDebugSendButton => 'Kirim Log via Surat';

  @override
  String get settingsDialogDebugTitle => 'Log Debug';

  @override
  String get settingsDialogLanguageTitle => 'Pilih Bahasa';

  @override
  String get settingsDialogThemeTitle => 'Pilih Tema';

  @override
  String get settingsFAQ => 'FAQ';

  @override
  String get settingsFAQHelp =>
      'Dibuka di Peramban. Hanya tersedia dalam Bahasa Inggris.';

  @override
  String get settingsLanguage => 'Bahasa';

  @override
  String get settingsLockscreen => 'Layar Kunci';

  @override
  String get settingsLockscreenHelp =>
      'Memerlukan autentikasi saat memulai aplikasi';

  @override
  String get settingsLockscreenInitial =>
      'Mohon autentikasi untuk mengaktifkan layar kunci.';

  @override
  String get settingsNLAppAccount => 'Akun Bawaan';

  @override
  String get settingsNLAppAccountDynamic => '<Dinamik>';

  @override
  String get settingsNLAppAdd => 'Tambahkan Aplikasi';

  @override
  String get settingsNLAppAddHelp =>
      'Klik untuk menambahkan aplikasi untuk didengarkan. Hanya aplikasi memenuhi syarat yang akan ditampilkan di daftar.';

  @override
  String get settingsNLAppAddInfo =>
      'Jadikan beberapa transaksi dimana anda menerima notifikasi untuk menambahkan aplikasi ke daftar ini. Jika aplikasi tidak muncul, silahkan laporkan ke app@vogt.pw.';

  @override
  String get settingsNLAutoAdd => 'Buat transaksi tanpa interaksi';

  @override
  String get settingsNLDescription =>
      'Layanan ini memungkinkan anda untuk mengambil detail transaksi dari notifikasi push yang masuk. Selain itu, anda dapat memilih akun bawaan dimana transaksi harus ditugaskan kepada - jika tidak ada nilai yang ditetapkan, akan mencoba untuk mengekstrak akun dari notifikasi.';

  @override
  String get settingsNLEmptyNote => 'Biarkan kolom catatan kosong';

  @override
  String get settingsNLPermissionGrant => 'Ketuk untuk memberikan izin.';

  @override
  String get settingsNLPermissionNotGranted => 'Izin tidak diberikan.';

  @override
  String get settingsNLPermissionRemove => 'Hapus izin?';

  @override
  String get settingsNLPermissionRemoveHelp =>
      'Untuk menonaktifkan layanan ini, klik pada aplikasi dan hapus izin di layar berikutnya.';

  @override
  String get settingsNLPrefillTXTitle =>
      'Isi otomatis judul transaksi dengan judul notifikasi';

  @override
  String get settingsNLServiceChecking => 'Memeriksa status…';

  @override
  String settingsNLServiceCheckingError(String error) {
    return 'Kesalahan saat memeriksa status: $error';
  }

  @override
  String get settingsNLServiceRunning => 'Layanan sedang berjalan.';

  @override
  String get settingsNLServiceStatus => 'Status Layanan';

  @override
  String get settingsNLServiceStopped => 'Layanan diberhentikan.';

  @override
  String get settingsNotificationListener => 'Layanan Pendengar Notifikasi';

  @override
  String get settingsTheme => 'Tema Aplikasi';

  @override
  String get settingsThemeDynamicColors => 'Warna Dinamis';

  @override
  String settingsThemeValue(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'dark': 'Mode Gelap',
      'light': 'Mode Terang',
      'other': 'Bawaan Sistem',
    });
    return '$_temp0';
  }

  @override
  String get settingsUseServerTimezone => 'Gunakan zona waktu server';

  @override
  String get settingsUseServerTimezoneHelp =>
      'Tampilkan semua waktu dalam zona waktu server. Ini meniru perilaku antarmuka web.';

  @override
  String get settingsVersion => 'Versi Aplikasi';

  @override
  String get settingsVersionChecking => 'memeriksa…';

  @override
  String get transactionAttachments => 'Lampiran';

  @override
  String get transactionDeleteConfirm => 'Yakin ingin menghapus transaksi ini?';

  @override
  String get transactionDialogAttachmentsDelete => 'Hapus Lampiran';

  @override
  String get transactionDialogAttachmentsDeleteConfirm =>
      'Yakin ingin menghapus lampiran ini?';

  @override
  String get transactionDialogAttachmentsErrorDownload =>
      'Tidak dapat mengunduh file.';

  @override
  String transactionDialogAttachmentsErrorOpen(String error) {
    return 'Tidak dapat membuka file: $error';
  }

  @override
  String transactionDialogAttachmentsErrorUpload(String error) {
    return 'Tidak dapat mengunggah file: $error';
  }

  @override
  String get transactionDialogAttachmentsTitle => 'Lampiran';

  @override
  String get transactionDialogBillNoBill => 'Tidak ada tagihan';

  @override
  String get transactionDialogBillTitle => 'Tautkan ke Tagihan';

  @override
  String get transactionDialogCurrencyTitle => 'Pilih mata uang';

  @override
  String get transactionDialogPiggyNoPiggy => 'No Piggy Bank';

  @override
  String get transactionDialogPiggyTitle => 'Link to Piggy Bank';

  @override
  String get transactionDialogTagsAdd => 'Tambahkan Label';

  @override
  String get transactionDialogTagsHint => 'Cari/Tambahkan Label';

  @override
  String get transactionDialogTagsTitle => 'Pilih label';

  @override
  String get transactionDuplicate => 'Duplikat';

  @override
  String get transactionErrorInvalidAccount => 'Akun tidak Valid';

  @override
  String get transactionErrorInvalidBudget => 'Anggaran tidak Valid';

  @override
  String get transactionErrorNoAccounts => 'Harap isi akun terlebih dahulu.';

  @override
  String get transactionErrorNoAssetAccount => 'Harap pilih akun aset.';

  @override
  String get transactionErrorTitle => 'Harap berikan judul.';

  @override
  String get transactionFormLabelAccountDestination => 'Akun tujuan';

  @override
  String get transactionFormLabelAccountForeign => 'Akun asing';

  @override
  String get transactionFormLabelAccountOwn => 'Akun sendiri';

  @override
  String get transactionFormLabelAccountSource => 'Akun asal';

  @override
  String get transactionFormLabelNotes => 'Catatan';

  @override
  String get transactionFormLabelTags => 'Label';

  @override
  String get transactionFormLabelTitle => 'Judul Transaksi';

  @override
  String get transactionSplitAdd => 'Tambah transaksi terpisah';

  @override
  String get transactionSplitChangeCurrency => 'Ubah Mata Uang Terpisah';

  @override
  String get transactionSplitChangeDestinationAccount =>
      'Ubah Akun Tujuan Pembagian';

  @override
  String get transactionSplitChangeSourceAccount =>
      'Ubah Akun Sumber Pembagian';

  @override
  String get transactionSplitChangeTarget =>
      'Ubah Akun Target Transaksi Terpisah';

  @override
  String get transactionSplitDelete => 'Hapus transaksi terpisah';

  @override
  String get transactionTitleAdd => 'Tambah Transaksi';

  @override
  String get transactionTitleDelete => 'Hapus Transaksi';

  @override
  String get transactionTitleEdit => 'Ubah Transaksi';

  @override
  String get transactionTypeDeposit => 'Setoran';

  @override
  String get transactionTypeTransfer => 'Transfer';

  @override
  String get transactionTypeWithdrawal => 'Penarikan';
}
