import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

extension CurrencyFormat on CurrencyRead {
  String fmt(
    num amount, {
    String? locale,
    bool forceCode = false,
    int? decimalDigits,
  }) => NumberFormat.currency(
    locale: locale ?? Intl.defaultLocale,
    name: attributes.code,
    decimalDigits: decimalDigits ?? attributes.decimalPlaces,
    symbol: forceCode ? null : attributes.symbol,
  ).format(amount);

  String zero({String? locale}) => NumberFormat.currency(
    locale: locale ?? Intl.defaultLocale,
    name: "",
    symbol: "",
    decimalDigits: attributes.decimalPlaces,
  ).format(0);
}

extension AccountRole on AccountRoleProperty {
  String friendlyName(BuildContext context) {
    switch (this) {
      case .cashwalletasset:
        return S.of(context).accountRoleAssetCashWallet;
      case .ccasset:
        return S.of(context).accountRoleAssetCC;
      case .defaultasset:
        return S.of(context).accountRoleAssetDefault;
      case .savingasset:
        return S.of(context).accountRoleAssetSavings;
      case .sharedasset:
        return S.of(context).accountRoleAssetShared;
      default:
        return S.of(context).generalUnknown;
    }
  }
}

extension TransactionType on TransactionTypeProperty {
  Color get color {
    switch (this) {
      case .deposit:
        return Colors.green;
      case .withdrawal:
        return Colors.red;
      case .transfer:
        return Colors.blue;
      // reconciliation
      // openingBalance
      default:
        return Colors.grey;
    }
  }

  IconData get icon {
    switch (this) {
      case .deposit:
        return Icons.arrow_forward;
      case .withdrawal:
        return Icons.arrow_back;
      case .transfer:
        return Icons.swap_horiz;
      case .reconciliation:
        return Icons.calculate_outlined;
      case .openingBalance:
        return Icons.star_outline;
      default:
        return Icons.question_mark;
    }
  }

  IconData get verticalIcon {
    switch (this) {
      case .deposit:
        return Icons.arrow_downward;
      case .withdrawal:
        return Icons.arrow_downward;
      case .transfer:
        return Icons.swap_vert;
      // reconciliation
      // openingBalance
      default:
        return Icons.question_mark;
    }
  }

  String friendlyName(BuildContext context) {
    switch (this) {
      case .deposit:
        return S.of(context).transactionTypeDeposit;
      case .withdrawal:
        return S.of(context).transactionTypeWithdrawal;
      case .transfer:
        return S.of(context).transactionTypeTransfer;
      // reconciliation
      // openingBalance
      default:
        return S.of(context).generalUnknown;
    }
  }

  // Taken from config/firefly.php
  List<AccountTypeFilter> expectedSourceTypes(bool isSource) {
    if (isSource) {
      switch (this) {
        case .withdrawal:
          return <AccountTypeFilter>[.assetAccount, .loan, .debt, .mortgage];
        case .deposit:
          return <AccountTypeFilter>[
            .loan,
            .debt,
            .mortgage,
            .revenueAccount,
            .cashAccount,
          ];
        case .transfer:
          return <AccountTypeFilter>[.assetAccount, .loan, .debt, .mortgage];
        case .openingBalance:
          return <AccountTypeFilter>[
            .initialBalanceAccount,
            .assetAccount,
            .loan,
            .debt,
            .mortgage,
          ];
        case .reconciliation:
          return <AccountTypeFilter>[.reconciliationAccount, .assetAccount];
        /*case .liabilityCredit:
        return <AccountTypeFilter>[
          .liabilityCreditAccount,
          .loan,
          .debt,
          .mortgage,
        ];*/

        default:
          return <AccountTypeFilter>[
            .assetAccount,
            .expenseAccount,
            .revenueAccount,
            .loan,
            .debt,
            .mortgage,
          ];
      }
    } else {
      switch (this) {
        case .withdrawal:
          return <AccountTypeFilter>[
            .loan,
            .debt,
            .mortgage,
            .expenseAccount,
            .cashAccount,
          ];
        case .deposit:
          return <AccountTypeFilter>[.assetAccount, .loan, .debt, .mortgage];
        case .transfer:
          return <AccountTypeFilter>[.assetAccount, .loan, .debt, .mortgage];
        case .openingBalance:
          return <AccountTypeFilter>[
            .initialBalanceAccount,
            .assetAccount,
            .loan,
            .debt,
            .mortgage,
          ];
        case .reconciliation:
          return <AccountTypeFilter>[.reconciliationAccount, .assetAccount];
        /*case .liabilityCredit:
        return <AccountTypeFilter>[
          .liabilityCreditAccount,
          .loan,
          .debt,
          .mortgage,
        ];*/

        default:
          return <AccountTypeFilter>[
            .assetAccount,
            .expenseAccount,
            .revenueAccount,
            .loan,
            .debt,
            .mortgage,
          ];
      }
    }
  }

  List<AccountTypeFilter> allowedSourceDests(AccountTypeFilter sourceAccount) {
    switch (this) {
      case .withdrawal:
        switch (sourceAccount) {
          case .assetAccount:
            return <AccountTypeFilter>[
              .expenseAccount,
              .loan,
              .debt,
              .mortgage,
              .cashAccount,
            ];
          case .loan:
          case .debt:
          case .mortgage:
            return <AccountTypeFilter>[.expenseAccount, .cashAccount];
          default:
            return <AccountTypeFilter>[];
        }
      case .deposit:
        switch (sourceAccount) {
          case .revenueAccount:
          case .cashAccount:
            return <AccountTypeFilter>[.assetAccount, .loan, .debt, .mortgage];
          case .loan:
          case .debt:
          case .mortgage:
            return <AccountTypeFilter>[.assetAccount];
          default:
            return <AccountTypeFilter>[];
        }
      case TransactionTypeProperty.transfer:
        switch (sourceAccount) {
          case .assetAccount:
            return <AccountTypeFilter>[.assetAccount];
          case .loan:
          case .debt:
          case .mortgage:
            return <AccountTypeFilter>[.loan, .debt, .mortgage];
          default:
            return <AccountTypeFilter>[];
        }
      case .openingBalance:
        switch (sourceAccount) {
          case .assetAccount:
          case .loan:
          case .debt:
          case .mortgage:
            return <AccountTypeFilter>[.initialBalanceAccount];
          case .initialBalanceAccount:
            return <AccountTypeFilter>[.assetAccount, .loan, .debt, .mortgage];
          default:
            return <AccountTypeFilter>[];
        }
      case .reconciliation:
        switch (sourceAccount) {
          case .reconciliationAccount:
            return <AccountTypeFilter>[.assetAccount];
          case .assetAccount:
            return <AccountTypeFilter>[.reconciliationAccount];
          default:
            return <AccountTypeFilter>[];
        }
      /*case .liabilityCredit:
        switch (sourceAccount) {
          case .assetAccount:
          case .loan:
          case .debt:
          case .mortgage:
            return <AccountTypeFilter>[
              .liabilityCreditAccount,
            ];
          case .liabilityCreditAccount:
            return <AccountTypeFilter>[
              .loan,
              .debt,
              .mortgage,
            ];
          default:
            return <AccountTypeFilter>[];
        }*/

      default:
        return <AccountTypeFilter>[.all];
    }
  }
}

extension DateTimeExtension on DateTime {
  DateTime setTimeOfDay(TimeOfDay time) =>
      DateTime(year, month, day, time.hour, time.minute);

  DateTime setTime({
    int hours = 0,
    int minutes = 0,
    int seconds = 0,
    int milliSeconds = 0,
    int microSeconds = 0,
  }) => DateTime(
    year,
    month,
    day,
    hours,
    minutes,
    seconds,
    milliSeconds,
    microSeconds,
  );

  DateTime clearTime() => DateTime(year, month, day, 0, 0, 0, 0, 0);

  TimeOfDay getTimeOfDay() => TimeOfDay.fromDateTime(this);
}

extension TZDateTimeExtension on tz.TZDateTime {
  tz.TZDateTime setTimeOfDay(TimeOfDay time) =>
      tz.TZDateTime(location, year, month, day, time.hour, time.minute);

  tz.TZDateTime setTime({
    int hours = 0,
    int minutes = 0,
    int seconds = 0,
    int milliSeconds = 0,
    int microSeconds = 0,
  }) => tz.TZDateTime(
    location,
    year,
    month,
    day,
    hours,
    minutes,
    seconds,
    milliSeconds,
    microSeconds,
  );

  tz.TZDateTime clearTime() =>
      tz.TZDateTime(location, year, month, day, 0, 0, 0, 0, 0);

  TimeOfDay getTimeOfDay() => TimeOfDay.fromDateTime(this);
}

extension ListStringIgnoreCase on List<String> {
  bool containsIgnoreCase(String? element) {
    for (String e in this) {
      if (e.toLowerCase() == element?.toLowerCase()) return true;
    }
    return false;
  }
}

extension StringIgnoreCase on String {
  bool containsIgnoreCase(String? a) =>
      a == null || toLowerCase().contains(a.toLowerCase());
}

extension AccountTypeIcon on AccountTypeFilter {
  IconData icon() {
    switch (this) {
      case .asset:
        return Icons.money_outlined;
      case .expense:
        return Icons.shopping_cart;
      case .revenue:
        return Icons.download;
      case .liabilities:
        return Icons.payment_outlined;
      default:
        return Icons.question_mark;
    }
  }

  String friendlyName(BuildContext context) {
    switch (this) {
      case .asset:
        return S.of(context).accountsLabelAsset;
      case .expense:
        return S.of(context).accountsLabelExpense;
      case .revenue:
        return S.of(context).accountsLabelRevenue;
      case .liabilities:
        return S.of(context).accountsLabelLiabilities;
      default:
        return S.of(context).generalAccount;
    }
  }
}

extension AccountType on AccountTypeProperty {
  // Taken from config/firefly.php
  List<AccountTypeFilter> allowedOpposingTypes(bool isSource) {
    if (isSource) {
      switch (this) {
        case .assetAccount:
          return <AccountTypeFilter>[
            .assetAccount,
            .cashAccount,
            .debt,
            .expenseAccount,
            .initialBalanceAccount,
            .loan,
            .reconciliationAccount,
            .mortgage,
          ];
        case .cashAccount:
          return <AccountTypeFilter>[.assetAccount];
        case .debt:
          return <AccountTypeFilter>[
            .assetAccount,
            .debt,
            .expenseAccount,
            .initialBalanceAccount,
            .loan,
            .mortgage,
            .liability,
          ];
        case .expenseAccount:
          return <AccountTypeFilter>[];
        case .initialBalanceAccount:
          return <AccountTypeFilter>[.assetAccount, .debt, .loan, .mortgage];
        case .loan:
        case .mortgage:
          return <AccountTypeFilter>[
            .assetAccount,
            .debt,
            .expenseAccount,
            .initialBalanceAccount,
            .loan,
            .mortgage,
            .liability,
          ];
        case .reconciliationAccount:
          return <AccountTypeFilter>[.assetAccount];
        case .revenueAccount:
          return <AccountTypeFilter>[.assetAccount, .debt, .loan, .mortgage];
        /*case .liability:
          return <AccountTypeFilter>[
            .debt,
            .loan,
            .mortgage,
          ];*/
        default:
          return <AccountTypeFilter>[
            .assetAccount,
            .expenseAccount,
            .debt,
            .loan,
            .mortgage,
          ];
      }
    } else {
      switch (this) {
        case .assetAccount:
          return <AccountTypeFilter>[
            .assetAccount,
            .cashAccount,
            .debt,
            .initialBalanceAccount,
            .loan,
            .mortgage,
            .reconciliationAccount,
            .revenueAccount,
          ];
        case .cashAccount:
          return <AccountTypeFilter>[.assetAccount];
        case .debt:
          return <AccountTypeFilter>[
            .assetAccount,
            .debt,
            .initialBalanceAccount,
            .loan,
            .mortgage,
            .revenueAccount,
          ];
        case .expenseAccount:
        case .initialBalanceAccount:
          return <AccountTypeFilter>[.assetAccount, .debt, .loan, .mortgage];
        case .loan:
        case .mortgage:
          return <AccountTypeFilter>[
            .assetAccount,
            .debt,
            .initialBalanceAccount,
            .loan,
            .mortgage,
            .revenueAccount,
          ];
        case .reconciliationAccount:
          return <AccountTypeFilter>[.assetAccount];
        case .revenueAccount:
        /*case .liability:
          return <AccountTypeFilter>[];*/
        default:
          return <AccountTypeFilter>[
            .assetAccount,
            .revenueAccount,
            .debt,
            .loan,
            .mortgage,
          ];
      }
    }
  }

  List<TransactionTypeProperty> allowedTransactionTypes(bool isSource) {
    if (isSource) {
      switch (this) {
        case .assetAccount:
          return <TransactionTypeProperty>[
            .withdrawal,
            .transfer,
            .openingBalance,
            .reconciliation,
          ];
        case .expenseAccount:
          return <TransactionTypeProperty>[];
        case .revenueAccount:
          return <TransactionTypeProperty>[.deposit];
        case .loan:
        case .debt:
        case .mortgage:
          return <TransactionTypeProperty>[
            .withdrawal,
            .deposit,
            .transfer,
            .openingBalance,
            //.liabilityCredit,
          ];
        case .initialBalanceAccount:
          return <TransactionTypeProperty>[.openingBalance];
        case .reconciliationAccount:
          return <TransactionTypeProperty>[.reconciliation];
        /*case .liability:
          return <TransactionTypeProperty>[
            .liabilityCredit,
          ];*/
        default:
          return <TransactionTypeProperty>[];
      }
    } else {
      switch (this) {
        case .assetAccount:
          return <TransactionTypeProperty>[
            .deposit,
            .transfer,
            .openingBalance,
            .reconciliation,
          ];
        case .expenseAccount:
          return <TransactionTypeProperty>[.withdrawal];
        case .revenueAccount:
          return <TransactionTypeProperty>[];
        case .loan:
        case .debt:
        case .mortgage:
          return <TransactionTypeProperty>[
            .withdrawal,
            .deposit,
            .transfer,
            .openingBalance,
          ];
        case .initialBalanceAccount:
          return <TransactionTypeProperty>[.openingBalance];
        case .reconciliationAccount:
          return <TransactionTypeProperty>[.reconciliation];
        //case .liability:
        default:
          return <TransactionTypeProperty>[];
      }
    }
  }
}

TransactionTypeProperty accountsToTransaction(
  AccountTypeProperty source,
  AccountTypeProperty destination,
) {
  final Map<
    AccountTypeProperty,
    Map<AccountTypeProperty, TransactionTypeProperty>
  >
  map =
      <AccountTypeProperty, Map<AccountTypeProperty, TransactionTypeProperty>>{
        .assetAccount: <AccountTypeProperty, TransactionTypeProperty>{
          .assetAccount: .transfer,
          .cashAccount: .withdrawal,
          .debt: .withdrawal,
          .expenseAccount: .withdrawal,
          .initialBalanceAccount: .openingBalance,
          .loan: .withdrawal,
          .mortgage: .withdrawal,
          .reconciliationAccount: .reconciliation,
        },
        .cashAccount: <AccountTypeProperty, TransactionTypeProperty>{
          .assetAccount: .deposit,
          .loan: .deposit,
          .debt: .deposit,
          .mortgage: .deposit,
        },
        .debt: <AccountTypeProperty, TransactionTypeProperty>{
          .assetAccount: .deposit,
          .debt: .transfer,
          .expenseAccount: .withdrawal,
          .initialBalanceAccount: .openingBalance,
          .loan: .transfer,
          .mortgage: .transfer,
        },
        .initialBalanceAccount: <AccountTypeProperty, TransactionTypeProperty>{
          .assetAccount: .openingBalance,
          .debt: .openingBalance,
          .loan: .openingBalance,
          .mortgage: .openingBalance,
        },
        .loan: <AccountTypeProperty, TransactionTypeProperty>{
          .assetAccount: .deposit,
          .debt: .transfer,
          .expenseAccount: .withdrawal,
          .initialBalanceAccount: .openingBalance,
          .loan: .transfer,
          .mortgage: .transfer,
        },
        .mortgage: <AccountTypeProperty, TransactionTypeProperty>{
          .assetAccount: .deposit,
          .debt: .transfer,
          .expenseAccount: .withdrawal,
          .initialBalanceAccount: .openingBalance,
          .loan: .transfer,
          .mortgage: .transfer,
        },
        .reconciliationAccount: <AccountTypeProperty, TransactionTypeProperty>{
          .assetAccount: .reconciliation,
        },
        .revenueAccount: <AccountTypeProperty, TransactionTypeProperty>{
          .assetAccount: .deposit,
          .debt: .deposit,
          .loan: .deposit,
          .mortgage: .deposit,
        },
        /*.liabilityCredit: {
      .debt: .liabilityCredit,
      .loan: .liabilityCredit,
      .mortgage: .liabilityCredit,
    },*/
      };

  return map[source]?[destination] ??
      TransactionTypeProperty.swaggerGeneratedUnknown;
}

extension BillAmountAvg on BillProperties {
  double avgAmount() {
    final double amountMax = (double.tryParse(this.amountMax!) ?? 0).abs();
    final double amountMin = (double.tryParse(this.amountMin!) ?? 0).abs();
    if (amountMax == 0) {
      return amountMin;
    }
    if (amountMin == 0) {
      return amountMax;
    }

    // Same as Firefly Source Code
    return (amountMin + amountMax) / 2;
  }
}

class CategoryWithSum extends CategoryProperties {
  CategoryWithSum({
    super.createdAt,
    super.updatedAt,
    required super.name,
    super.notes,
    super.spent,
    super.earned,
  });

  double sumSpent = 0;
  double sumEarned = 0;
}

extension LocaleExt on Locale {
  static Locale fromLanguageTag(String tag) {
    String? langCode;
    String? regionCode;
    final int regionCodeIndex = tag.indexOf(RegExp(r'[A-Z]{2}'));
    if (regionCodeIndex == -1) {
      langCode = tag;
    } else {
      langCode = tag.substring(0, regionCodeIndex - 1);
      regionCode = tag.substring(regionCodeIndex);
    }
    return Locale(langCode, regionCode);
  }
}
