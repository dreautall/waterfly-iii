import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/pages/home/transactions.dart';

Widget accountRowBuilder(BuildContext context, AccountRead account, int index) {
  late double currentAmount;
  if (account.attributes.type == ShortAccountTypeProperty.liability) {
    currentAmount = double.tryParse(account.attributes.currentDebt ?? "") ?? 0;
  } else {
    currentAmount =
        double.tryParse(account.attributes.currentBalance ?? "") ?? 0;
  }
  final CurrencyRead currency = CurrencyRead(
    id: account.attributes.currencyId ?? "0",
    type: "currencies",
    attributes: Currency(
      code: account.attributes.currencyCode ?? "",
      name: "",
      symbol: account.attributes.currencySymbol ?? "",
      decimalPlaces: account.attributes.currencyDecimalPlaces,
    ),
  );

  late String subtitle;
  switch (account.attributes.type) {
    case ShortAccountTypeProperty.asset:
      subtitle = account.attributes.accountRole?.friendlyName(context) ??
          S.of(context).generalUnknown;
      if (account.attributes.iban != null) {
        subtitle += "\nIBAN: ${account.attributes.iban!}";
      }
      break;
    case ShortAccountTypeProperty.expense:
      subtitle = account.attributes.iban ?? "";
      // Switch sign, see #96
      if (currentAmount != 0) {
        currentAmount *= -1;
      }
      break;
    case ShortAccountTypeProperty.revenue:
      subtitle = account.attributes.iban ?? "";
      // Switch sign, see #96
      if (currentAmount != 0) {
        currentAmount *= -1;
      }
      break;
    case ShortAccountTypeProperty.liabilities:
      switch (account.attributes.liabilityType) {
        case LiabilityTypeProperty.debt:
          subtitle = S.of(context).liabilityTypeDebt;
          break;
        case LiabilityTypeProperty.loan:
          subtitle = S.of(context).liabilityTypeLoan;
          break;
        case LiabilityTypeProperty.mortgage:
          subtitle = S.of(context).liabilityTypeMortgage;
          break;
        default:
          subtitle = S.of(context).generalUnknown;
      }
      subtitle += "; ";
      switch (account.attributes.liabilityDirection) {
        case LiabilityDirectionProperty.credit:
          subtitle += S.of(context).liabilityDirectionCredit;
          break;
        case LiabilityDirectionProperty.debit:
          subtitle += S.of(context).liabilityDirectionDebit;
          break;
        default:
          subtitle = S.of(context).generalUnknown;
      }

      if (account.attributes.interest != null &&
          account.attributes.interestPeriod != null) {
        subtitle += "; ";
        subtitle += S.of(context).accountsLiabilitiesInterest(
              double.tryParse(
                    account.attributes.interest!,
                  ) ??
                  0,
              account.attributes.interestPeriod!.value?.replaceAll('-', '') ??
                  "",
            );
      }
      break;
    default:
      subtitle = S.of(context).generalUnknown;
  }
  return OpenContainer(
    openBuilder: (BuildContext context, Function closedContainer) => Scaffold(
      appBar: AppBar(
        title: Text(account.attributes.name),
      ),
      body: HomeTransactions(accountId: account.id),
    ),
    openColor: Theme.of(context).cardColor,
    closedColor: Theme.of(context).cardColor,
    closedShape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        bottomLeft: Radius.circular(16),
      ),
    ),
    closedElevation: 0,
    closedBuilder: (BuildContext context, Function openContainer) => ListTile(
      title: Text(
        account.attributes.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        subtitle,
        maxLines: account.attributes.type == ShortAccountTypeProperty.asset ||
                account.attributes.type == ShortAccountTypeProperty.liabilities
            ? 2
            : 1,
      ),
      isThreeLine: account.attributes.type == ShortAccountTypeProperty.asset ||
          account.attributes.type == ShortAccountTypeProperty.liabilities,
      trailing: RichText(
        textAlign: TextAlign.end,
        maxLines: 2,
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: <InlineSpan>[
            TextSpan(
              text: currency.fmt(currentAmount),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: (currentAmount < 0) ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
                fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
              ),
            ),
            const TextSpan(text: "\n"),
            TextSpan(
              text: account.attributes.currentBalanceDate != null
                  ? DateFormat.yMd()
                      .add_Hms()
                      .format(account.attributes.currentBalanceDate!.toLocal())
                  : S.of(context).generalNever,
            ),
          ],
        ),
      ),
      enabled: account.attributes.active ?? true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
      ),
      onTap: () => openContainer(),
    ),
  );
}
