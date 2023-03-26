import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        locale: locale,
        name: attributes.code,
        decimalDigits: decimalDigits ?? attributes.decimalPlaces,
        symbol: forceCode ? null : attributes.symbol,
      ).format(amount);

  String zero({String? locale}) => NumberFormat.currency(
        locale: locale,
        name: "",
        symbol: "",
        decimalDigits: attributes.decimalPlaces,
      ).format(0);
}

extension AccountRole on AccountRoleProperty {
  String get friendlyName {
    switch (this) {
      case AccountRoleProperty.cashwalletasset:
        return "Cash wallet";
      case AccountRoleProperty.ccasset:
        return "Credit card";
      case AccountRoleProperty.defaultasset:
        return "Default asset account";
      case AccountRoleProperty.savingasset:
        return "Savings account";
      case AccountRoleProperty.sharedasset:
        return "Shared asset account";
      default:
        return "Unknown";
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

  // Taken from Web Interface
  // Deposit: Asset%20account,Revenue%20account,Loan,Debt,Mortgage
  // Withdrawal: Asset%20account,Loan,Debt,Mortgage
  // Transfer: Asset%20account,Revenue%20account,Loan,Debt,Mortgage
  List<AccountTypeFilter> get sourceAccountTypes {
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
          AccountTypeFilter.revenueAccount,
          AccountTypeFilter.cashAccount,
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

  // Withdrawal: Expense%20account,Cash%20account,Loan,Debt,Mortgage
  // Deposit: Asset%20account,Expense%20account,Loan,Debt,Mortgage
  // Transfer: Asset%20account,Expense%20account,Loan,Debt,Mortgage
  List<AccountTypeFilter> get destinationAccountTypes {
    switch (this) {
      case TransactionTypeProperty.withdrawal:
        return <AccountTypeFilter>[
          AccountTypeFilter.expenseAccount,
          AccountTypeFilter.cashAccount,
          AccountTypeFilter.loan,
          AccountTypeFilter.debt,
          AccountTypeFilter.mortgage,
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
          AccountTypeFilter.all,
        ];
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
            return <AccountTypeFilter>[
              AccountTypeFilter.assetAccount,
              AccountTypeFilter.loan,
              AccountTypeFilter.debt,
              AccountTypeFilter.mortgage,
            ];
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
