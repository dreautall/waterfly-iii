import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

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
  }) =>
      NumberFormat.currency(
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
      case AccountRoleProperty.cashwalletasset:
        return S.of(context).accountRoleAssetCashWallet;
      case AccountRoleProperty.ccasset:
        return S.of(context).accountRoleAssetCC;
      case AccountRoleProperty.defaultasset:
        return S.of(context).accountRoleAssetDefault;
      case AccountRoleProperty.savingasset:
        return S.of(context).accountRoleAssetSavings;
      case AccountRoleProperty.sharedasset:
        return S.of(context).accountRoleAssetShared;
      default:
        return S.of(context).generalUnknown;
    }
  }
}

extension TransactionType on TransactionTypeProperty {
  Color get color {
    switch (this) {
      case TransactionTypeProperty.deposit:
        return Colors.green;

      case TransactionTypeProperty.withdrawal:
        return Colors.red;

      case TransactionTypeProperty.transfer:
        return Colors.blue;
      // reconciliation
      // openingBalance
      default:
        return Colors.black;
    }
  }

  IconData get icon {
    switch (this) {
      case TransactionTypeProperty.deposit:
        return Icons.arrow_forward;

      case TransactionTypeProperty.withdrawal:
        return Icons.arrow_back;

      case TransactionTypeProperty.transfer:
        return Icons.swap_horiz;
      // reconciliation
      // openingBalance
      default:
        return Icons.question_mark;
    }
  }

  // Taken from config/firefly.php
  List<AccountTypeFilter> expectedSourceTypes(bool isSource) {
    if (isSource) {
      switch (this) {
        case TransactionTypeProperty.withdrawal:
          return <AccountTypeFilter>[
            AccountTypeFilter.assetAccount,
            AccountTypeFilter.loan,
            AccountTypeFilter.debt,
            AccountTypeFilter.mortgage,
          ];
        case TransactionTypeProperty.deposit:
          return <AccountTypeFilter>[
            AccountTypeFilter.loan,
            AccountTypeFilter.debt,
            AccountTypeFilter.mortgage,
            AccountTypeFilter.revenueAccount,
            AccountTypeFilter.cashAccount,
          ];
        case TransactionTypeProperty.transfer:
          return <AccountTypeFilter>[
            AccountTypeFilter.assetAccount,
            AccountTypeFilter.loan,
            AccountTypeFilter.debt,
            AccountTypeFilter.mortgage,
          ];
        case TransactionTypeProperty.openingBalance:
          return <AccountTypeFilter>[
            AccountTypeFilter.initialBalanceAccount,
            AccountTypeFilter.assetAccount,
            AccountTypeFilter.loan,
            AccountTypeFilter.debt,
            AccountTypeFilter.mortgage,
          ];
        case TransactionTypeProperty.reconciliation:
          return <AccountTypeFilter>[
            AccountTypeFilter.reconciliationAccount,
            AccountTypeFilter.assetAccount,
          ];
        /*case TransactionTypeProperty.liabilityCredit:
        return <AccountTypeFilter>[
          AccountTypeFilter.liabilityCreditAccount,
          AccountTypeFilter.loan,
          AccountTypeFilter.debt,
          AccountTypeFilter.mortgage,
        ];*/

        default:
          return <AccountTypeFilter>[
            AccountTypeFilter.assetAccount,
            AccountTypeFilter.expenseAccount,
            AccountTypeFilter.revenueAccount,
            AccountTypeFilter.loan,
            AccountTypeFilter.debt,
            AccountTypeFilter.mortgage,
          ];
      }
    } else {
      switch (this) {
        case TransactionTypeProperty.withdrawal:
          return <AccountTypeFilter>[
            AccountTypeFilter.loan,
            AccountTypeFilter.debt,
            AccountTypeFilter.mortgage,
            AccountTypeFilter.expenseAccount,
            AccountTypeFilter.cashAccount,
          ];
        case TransactionTypeProperty.deposit:
          return <AccountTypeFilter>[
            AccountTypeFilter.assetAccount,
            AccountTypeFilter.loan,
            AccountTypeFilter.debt,
            AccountTypeFilter.mortgage,
          ];
        case TransactionTypeProperty.transfer:
          return <AccountTypeFilter>[
            AccountTypeFilter.assetAccount,
            AccountTypeFilter.loan,
            AccountTypeFilter.debt,
            AccountTypeFilter.mortgage,
          ];
        case TransactionTypeProperty.openingBalance:
          return <AccountTypeFilter>[
            AccountTypeFilter.initialBalanceAccount,
            AccountTypeFilter.assetAccount,
            AccountTypeFilter.loan,
            AccountTypeFilter.debt,
            AccountTypeFilter.mortgage,
          ];
        case TransactionTypeProperty.reconciliation:
          return <AccountTypeFilter>[
            AccountTypeFilter.reconciliationAccount,
            AccountTypeFilter.assetAccount,
          ];
        /*case TransactionTypeProperty.liabilityCredit:
        return <AccountTypeFilter>[
          AccountTypeFilter.liabilityCreditAccount,
          AccountTypeFilter.loan,
          AccountTypeFilter.debt,
          AccountTypeFilter.mortgage,
        ];*/

        default:
          return <AccountTypeFilter>[
            AccountTypeFilter.assetAccount,
            AccountTypeFilter.expenseAccount,
            AccountTypeFilter.revenueAccount,
            AccountTypeFilter.loan,
            AccountTypeFilter.debt,
            AccountTypeFilter.mortgage,
          ];
      }
    }
  }

  List<AccountTypeFilter> allowedSourceDests(AccountTypeFilter sourceAccount) {
    switch (this) {
      case TransactionTypeProperty.withdrawal:
        switch (sourceAccount) {
          case AccountTypeFilter.assetAccount:
            return <AccountTypeFilter>[
              AccountTypeFilter.expenseAccount,
              AccountTypeFilter.loan,
              AccountTypeFilter.debt,
              AccountTypeFilter.mortgage,
              AccountTypeFilter.cashAccount
            ];
          case AccountTypeFilter.loan:
          case AccountTypeFilter.debt:
          case AccountTypeFilter.mortgage:
            return <AccountTypeFilter>[
              AccountTypeFilter.expenseAccount,
              AccountTypeFilter.cashAccount,
            ];
          default:
            return <AccountTypeFilter>[];
        }
      case TransactionTypeProperty.deposit:
        switch (sourceAccount) {
          case AccountTypeFilter.revenueAccount:
          case AccountTypeFilter.cashAccount:
            return <AccountTypeFilter>[
              AccountTypeFilter.assetAccount,
              AccountTypeFilter.loan,
              AccountTypeFilter.debt,
              AccountTypeFilter.mortgage,
            ];
          case AccountTypeFilter.loan:
          case AccountTypeFilter.debt:
          case AccountTypeFilter.mortgage:
            return <AccountTypeFilter>[
              AccountTypeFilter.assetAccount,
            ];
          default:
            return <AccountTypeFilter>[];
        }
      case TransactionTypeProperty.transfer:
        switch (sourceAccount) {
          case AccountTypeFilter.assetAccount:
            return <AccountTypeFilter>[AccountTypeFilter.assetAccount];
          case AccountTypeFilter.loan:
          case AccountTypeFilter.debt:
          case AccountTypeFilter.mortgage:
            return <AccountTypeFilter>[
              AccountTypeFilter.loan,
              AccountTypeFilter.debt,
              AccountTypeFilter.mortgage,
            ];
          default:
            return <AccountTypeFilter>[];
        }
      case TransactionTypeProperty.openingBalance:
        switch (sourceAccount) {
          case AccountTypeFilter.assetAccount:
          case AccountTypeFilter.loan:
          case AccountTypeFilter.debt:
          case AccountTypeFilter.mortgage:
            return <AccountTypeFilter>[AccountTypeFilter.initialBalanceAccount];
          case AccountTypeFilter.initialBalanceAccount:
            return <AccountTypeFilter>[
              AccountTypeFilter.assetAccount,
              AccountTypeFilter.loan,
              AccountTypeFilter.debt,
              AccountTypeFilter.mortgage,
            ];
          default:
            return <AccountTypeFilter>[];
        }
      case TransactionTypeProperty.reconciliation:
        switch (sourceAccount) {
          case AccountTypeFilter.reconciliationAccount:
            return <AccountTypeFilter>[AccountTypeFilter.assetAccount];
          case AccountTypeFilter.assetAccount:
            return <AccountTypeFilter>[
              AccountTypeFilter.reconciliationAccount,
            ];
          default:
            return <AccountTypeFilter>[];
        }
      /*case TransactionTypeProperty.liabilityCredit:
        switch (sourceAccount) {
          case AccountTypeFilter.assetAccount:
          case AccountTypeFilter.loan:
          case AccountTypeFilter.debt:
          case AccountTypeFilter.mortgage:
            return <AccountTypeFilter>[
              AccountTypeFilter.liabilityCreditAccount,
            ];
          case AccountTypeFilter.liabilityCreditAccount:
            return <AccountTypeFilter>[
              AccountTypeFilter.loan,
              AccountTypeFilter.debt,
              AccountTypeFilter.mortgage,
            ];
          default:
            return <AccountTypeFilter>[];
        }*/

      default:
        return <AccountTypeFilter>[
          AccountTypeFilter.all,
        ];
    }
  }
}

extension DateTimeExtension on DateTime {
  DateTime setTimeOfDay(TimeOfDay time) => DateTime(
        year,
        month,
        day,
        time.hour,
        time.minute,
      );

  DateTime setTime({
    int hours = 0,
    int minutes = 0,
    int seconds = 0,
    int milliSeconds = 0,
    int microSeconds = 0,
  }) =>
      DateTime(
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
  tz.TZDateTime setTimeOfDay(TimeOfDay time) => tz.TZDateTime(
        location,
        year,
        month,
        day,
        time.hour,
        time.minute,
      );

  tz.TZDateTime setTime({
    int hours = 0,
    int minutes = 0,
    int seconds = 0,
    int milliSeconds = 0,
    int microSeconds = 0,
  }) =>
      tz.TZDateTime(
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

extension AccountType on AccountTypeFilter {
  // Taken from config/firefly.php
  List<AccountTypeFilter> allowedOpposingTypes(bool isSource) {
    if (isSource) {
      switch (this) {
        case AccountTypeFilter.asset:
          return <AccountTypeFilter>[
            AccountTypeFilter.assetAccount,
            AccountTypeFilter.cash,
            AccountTypeFilter.debt,
            AccountTypeFilter.expense,
            AccountTypeFilter.initialBalanceAccount,
            AccountTypeFilter.loan,
            AccountTypeFilter.reconciliationAccount,
            AccountTypeFilter.mortgage,
          ];
        case AccountTypeFilter.cash:
          return <AccountTypeFilter>[
            AccountTypeFilter.assetAccount,
          ];
        case AccountTypeFilter.debt:
          return <AccountTypeFilter>[
            AccountTypeFilter.assetAccount,
            AccountTypeFilter.debt,
            AccountTypeFilter.expense,
            AccountTypeFilter.initialBalanceAccount,
            AccountTypeFilter.loan,
            AccountTypeFilter.mortgage,
            AccountTypeFilter.liability,
          ];
        case AccountTypeFilter.expense:
          return <AccountTypeFilter>[];
        case AccountTypeFilter.initialBalanceAccount:
          return <AccountTypeFilter>[
            AccountTypeFilter.assetAccount,
            AccountTypeFilter.debt,
            AccountTypeFilter.loan,
            AccountTypeFilter.mortgage,
          ];
        case AccountTypeFilter.loan:
        case AccountTypeFilter.mortgage:
          return <AccountTypeFilter>[
            AccountTypeFilter.assetAccount,
            AccountTypeFilter.debt,
            AccountTypeFilter.expense,
            AccountTypeFilter.initialBalanceAccount,
            AccountTypeFilter.loan,
            AccountTypeFilter.mortgage,
            AccountTypeFilter.liability,
          ];
        case AccountTypeFilter.reconciliationAccount:
          return <AccountTypeFilter>[
            AccountTypeFilter.assetAccount,
          ];
        case AccountTypeFilter.revenueAccount:
          return <AccountTypeFilter>[
            AccountTypeFilter.assetAccount,
            AccountTypeFilter.debt,
            AccountTypeFilter.loan,
            AccountTypeFilter.mortgage,
          ];
        case AccountTypeFilter.liability:
          return <AccountTypeFilter>[
            AccountTypeFilter.debt,
            AccountTypeFilter.loan,
            AccountTypeFilter.mortgage,
          ];
        default:
          return <AccountTypeFilter>[];
      }
    } else {
      switch (this) {
        case AccountTypeFilter.asset:
          return <AccountTypeFilter>[
            AccountTypeFilter.assetAccount,
            AccountTypeFilter.cash,
            AccountTypeFilter.debt,
            AccountTypeFilter.initialBalanceAccount,
            AccountTypeFilter.loan,
            AccountTypeFilter.mortgage,
            AccountTypeFilter.reconciliationAccount,
            AccountTypeFilter.revenueAccount,
          ];
        case AccountTypeFilter.cash:
          return <AccountTypeFilter>[
            AccountTypeFilter.assetAccount,
          ];
        case AccountTypeFilter.debt:
          return <AccountTypeFilter>[
            AccountTypeFilter.assetAccount,
            AccountTypeFilter.debt,
            AccountTypeFilter.initialBalanceAccount,
            AccountTypeFilter.loan,
            AccountTypeFilter.mortgage,
            AccountTypeFilter.revenueAccount,
          ];
        case AccountTypeFilter.expense:
        case AccountTypeFilter.initialBalanceAccount:
          return <AccountTypeFilter>[
            AccountTypeFilter.assetAccount,
            AccountTypeFilter.debt,
            AccountTypeFilter.loan,
            AccountTypeFilter.mortgage,
          ];
        case AccountTypeFilter.loan:
        case AccountTypeFilter.mortgage:
          return <AccountTypeFilter>[
            AccountTypeFilter.assetAccount,
            AccountTypeFilter.debt,
            AccountTypeFilter.initialBalanceAccount,
            AccountTypeFilter.loan,
            AccountTypeFilter.mortgage,
            AccountTypeFilter.revenueAccount,
          ];
        case AccountTypeFilter.reconciliationAccount:
          return <AccountTypeFilter>[
            AccountTypeFilter.assetAccount,
          ];
        case AccountTypeFilter.revenueAccount:
        case AccountTypeFilter.liability:
        default:
          return <AccountTypeFilter>[];
      }
    }
  }

  List<TransactionTypeProperty> allowedTransactionTypes(bool isSource) {
    if (isSource) {
      switch (this) {
        case AccountTypeFilter.asset:
          return <TransactionTypeProperty>[
            TransactionTypeProperty.withdrawal,
            TransactionTypeProperty.transfer,
            TransactionTypeProperty.openingBalance,
            TransactionTypeProperty.reconciliation,
          ];
        case AccountTypeFilter.expense:
          return <TransactionTypeProperty>[];
        case AccountTypeFilter.revenue:
          return <TransactionTypeProperty>[
            TransactionTypeProperty.deposit,
          ];
        case AccountTypeFilter.loan:
        case AccountTypeFilter.debt:
        case AccountTypeFilter.mortgage:
          return <TransactionTypeProperty>[
            TransactionTypeProperty.withdrawal,
            TransactionTypeProperty.deposit,
            TransactionTypeProperty.transfer,
            TransactionTypeProperty.openingBalance,
            //TransactionTypeProperty.liabilityCredit,
          ];
        case AccountTypeFilter.initialBalanceAccount:
          return <TransactionTypeProperty>[
            TransactionTypeProperty.openingBalance,
          ];
        case AccountTypeFilter.reconciliationAccount:
          return <TransactionTypeProperty>[
            TransactionTypeProperty.reconciliation,
          ];
        case AccountTypeFilter.liability:
          return <TransactionTypeProperty>[
            //TransactionTypeFilter.liabilityCredit,
          ];
        default:
          return <TransactionTypeProperty>[];
      }
    } else {
      switch (this) {
        case AccountTypeFilter.asset:
          return <TransactionTypeProperty>[
            TransactionTypeProperty.deposit,
            TransactionTypeProperty.transfer,
            TransactionTypeProperty.openingBalance,
            TransactionTypeProperty.reconciliation,
          ];
        case AccountTypeFilter.expense:
          return <TransactionTypeProperty>[
            TransactionTypeProperty.withdrawal,
          ];
        case AccountTypeFilter.revenue:
          return <TransactionTypeProperty>[];
        case AccountTypeFilter.loan:
        case AccountTypeFilter.debt:
        case AccountTypeFilter.mortgage:
          return <TransactionTypeProperty>[
            TransactionTypeProperty.withdrawal,
            TransactionTypeProperty.deposit,
            TransactionTypeProperty.transfer,
            TransactionTypeProperty.openingBalance,
          ];
        case AccountTypeFilter.initialBalanceAccount:
          return <TransactionTypeProperty>[
            TransactionTypeProperty.openingBalance,
          ];
        case AccountTypeFilter.reconciliationAccount:
          return <TransactionTypeProperty>[
            TransactionTypeProperty.reconciliation,
          ];
        case AccountTypeFilter.liability:
        default:
          return <TransactionTypeProperty>[];
      }
    }
  }

  IconData icon() {
    switch (this) {
      case AccountTypeFilter.asset:
        return Icons.money_outlined;
      case AccountTypeFilter.expense:
        return Icons.shopping_cart;
      case AccountTypeFilter.revenue:
        return Icons.download;
      case AccountTypeFilter.liabilities:
        return Icons.payment_outlined;
      default:
        return Icons.question_mark;
    }
  }

  String friendlyName(BuildContext context) {
    switch (this) {
      case AccountTypeFilter.asset:
        return S.of(context).accountsLabelAsset;
      case AccountTypeFilter.expense:
        return S.of(context).accountsLabelExpense;
      case AccountTypeFilter.revenue:
        return S.of(context).accountsLabelRevenue;
      case AccountTypeFilter.liabilities:
        return S.of(context).accountsLabelLiabilities;
      default:
        return S.of(context).generalAccount;
    }
  }
}

TransactionTypeProperty accountsToTransaction(
    AccountTypeProperty source, AccountTypeProperty destination) {
  Map<AccountTypeProperty, Map<AccountTypeProperty, TransactionTypeProperty>>
      map =
      <AccountTypeProperty, Map<AccountTypeProperty, TransactionTypeProperty>>{
    AccountTypeProperty.assetAccount:
        <AccountTypeProperty, TransactionTypeProperty>{
      AccountTypeProperty.assetAccount: TransactionTypeProperty.transfer,
      AccountTypeProperty.cashAccount: TransactionTypeProperty.withdrawal,
      AccountTypeProperty.debt: TransactionTypeProperty.withdrawal,
      AccountTypeProperty.expenseAccount: TransactionTypeProperty.withdrawal,
      AccountTypeProperty.initialBalanceAccount:
          TransactionTypeProperty.openingBalance,
      AccountTypeProperty.loan: TransactionTypeProperty.withdrawal,
      AccountTypeProperty.mortgage: TransactionTypeProperty.withdrawal,
      AccountTypeProperty.reconciliationAccount:
          TransactionTypeProperty.reconciliation,
    },
    AccountTypeProperty.cashAccount:
        <AccountTypeProperty, TransactionTypeProperty>{
      AccountTypeProperty.assetAccount: TransactionTypeProperty.deposit,
      AccountTypeProperty.loan: TransactionTypeProperty.deposit,
      AccountTypeProperty.debt: TransactionTypeProperty.deposit,
      AccountTypeProperty.mortgage: TransactionTypeProperty.deposit,
    },
    AccountTypeProperty.debt: <AccountTypeProperty, TransactionTypeProperty>{
      AccountTypeProperty.assetAccount: TransactionTypeProperty.deposit,
      AccountTypeProperty.debt: TransactionTypeProperty.transfer,
      AccountTypeProperty.expenseAccount: TransactionTypeProperty.withdrawal,
      AccountTypeProperty.initialBalanceAccount:
          TransactionTypeProperty.openingBalance,
      AccountTypeProperty.loan: TransactionTypeProperty.transfer,
      AccountTypeProperty.mortgage: TransactionTypeProperty.transfer,
    },
    AccountTypeProperty.initialBalanceAccount:
        <AccountTypeProperty, TransactionTypeProperty>{
      AccountTypeProperty.assetAccount: TransactionTypeProperty.openingBalance,
      AccountTypeProperty.debt: TransactionTypeProperty.openingBalance,
      AccountTypeProperty.loan: TransactionTypeProperty.openingBalance,
      AccountTypeProperty.mortgage: TransactionTypeProperty.openingBalance,
    },
    AccountTypeProperty.loan: <AccountTypeProperty, TransactionTypeProperty>{
      AccountTypeProperty.assetAccount: TransactionTypeProperty.deposit,
      AccountTypeProperty.debt: TransactionTypeProperty.transfer,
      AccountTypeProperty.expenseAccount: TransactionTypeProperty.withdrawal,
      AccountTypeProperty.initialBalanceAccount:
          TransactionTypeProperty.openingBalance,
      AccountTypeProperty.loan: TransactionTypeProperty.transfer,
      AccountTypeProperty.mortgage: TransactionTypeProperty.transfer,
    },
    AccountTypeProperty.mortgage:
        <AccountTypeProperty, TransactionTypeProperty>{
      AccountTypeProperty.assetAccount: TransactionTypeProperty.deposit,
      AccountTypeProperty.debt: TransactionTypeProperty.transfer,
      AccountTypeProperty.expenseAccount: TransactionTypeProperty.withdrawal,
      AccountTypeProperty.initialBalanceAccount:
          TransactionTypeProperty.openingBalance,
      AccountTypeProperty.loan: TransactionTypeProperty.transfer,
      AccountTypeProperty.mortgage: TransactionTypeProperty.transfer,
    },
    AccountTypeProperty.reconciliationAccount:
        <AccountTypeProperty, TransactionTypeProperty>{
      AccountTypeProperty.assetAccount: TransactionTypeProperty.reconciliation,
    },
    AccountTypeProperty.revenueAccount:
        <AccountTypeProperty, TransactionTypeProperty>{
      AccountTypeProperty.assetAccount: TransactionTypeProperty.deposit,
      AccountTypeProperty.debt: TransactionTypeProperty.deposit,
      AccountTypeProperty.loan: TransactionTypeProperty.deposit,
      AccountTypeProperty.mortgage: TransactionTypeProperty.deposit,
    },
    /*AccountTypeProperty.liabilityCredit: {
      AccountTypeProperty.debt: TransactionTypeProperty.liabilityCredit,
      AccountTypeProperty.loan: TransactionTypeProperty.liabilityCredit,
      AccountTypeProperty.mortgage: TransactionTypeProperty.liabilityCredit,
    },*/
  };

  return map[source]?[destination] ??
      TransactionTypeProperty.swaggerGeneratedUnknown;
}

extension BillAmountAvg on Bill {
  double avgAmount() {
    final double amountMax = (double.tryParse(this.amountMax) ?? 0).abs();
    final double amountMin = (double.tryParse(this.amountMin) ?? 0).abs();
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

class CategoryWithSum extends Category {
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
