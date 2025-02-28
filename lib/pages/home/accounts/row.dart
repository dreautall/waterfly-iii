import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/pages/home/transactions.dart';
import 'package:waterflyiii/pages/home/transactions/filter.dart';
import 'package:waterflyiii/widgets/fabs.dart';

Widget accountRowBuilder(
  BuildContext context,
  AccountRead account,
  int index,
  void Function() pagingResetFunc,
) {
  String name = account.attributes.name;
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
      subtitle =
          account.attributes.accountRole?.friendlyName(context) ??
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
        subtitle += S
            .of(context)
            .accountsLiabilitiesInterest(
              double.tryParse(account.attributes.interest!) ?? 0,
              account.attributes.interestPeriod!.value?.replaceAll('-', '') ??
                  "",
            );
      }
      break;
    default:
      subtitle = S.of(context).generalUnknown;
  }
  return OpenContainer(
    openBuilder:
        (BuildContext context, Function closedContainer) => AccountTXpage(
          account: account,
          nameUpdateFunc: (_) => pagingResetFunc(),
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
    closedBuilder:
        (BuildContext context, Function openContainer) => ListTile(
          title: Text(name, maxLines: 1, overflow: TextOverflow.ellipsis),
          subtitle: Text(
            subtitle,
            maxLines:
                account.attributes.type == ShortAccountTypeProperty.asset ||
                        account.attributes.type ==
                            ShortAccountTypeProperty.liabilities
                    ? 2
                    : 1,
          ),
          isThreeLine:
              account.attributes.type == ShortAccountTypeProperty.asset ||
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
                    fontFeatures: const <FontFeature>[
                      FontFeature.tabularFigures(),
                    ],
                  ),
                ),
                const TextSpan(text: "\n"),
                TextSpan(
                  text:
                      account.attributes.currentBalanceDate != null
                          ? DateFormat.yMd().add_Hms().format(
                            account.attributes.currentBalanceDate!.toLocal(),
                          )
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

class AccountTXpage extends StatefulWidget {
  const AccountTXpage({
    super.key,
    required this.account,
    required this.nameUpdateFunc,
  });

  final AccountRead account;
  final Function(String) nameUpdateFunc;

  @override
  State<AccountTXpage> createState() => _AccountTXpageState();
}

class _AccountTXpageState extends State<AccountTXpage> {
  final Logger log = Logger("Pages.Accounts.Row.Page");

  late String _name;
  late Widget _titleWidget;
  late Widget _editIcon;

  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _name = widget.account.attributes.name;
    _titleWidget = Text(_name);
    _editIcon = IconButton(icon: Icon(Icons.edit), onPressed: showTextfield);
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  void showTextfield() {
    log.finest(() => "showing edit field");
    setState(() {
      _textController.text = widget.account.attributes.name;
      _titleWidget = TextField(
        controller: _textController,
        focusNode: _focusNode,
        onEditingComplete: submitTextfield,
      );
      _editIcon = IconButton(
        icon: Icon(Icons.check),
        onPressed: submitTextfield,
      );

      _focusNode.requestFocus();
    });
  }

  void submitTextfield() async {
    log.finest(() => "submitting edit field");
    final ScaffoldMessengerState msg = ScaffoldMessenger.of(context);

    if (_textController.text.isNotEmpty &&
        _textController.text != widget.account.attributes.name) {
      try {
        final FireflyIii api = context.read<FireflyService>().api;
        final Response<AccountSingle> response = await api.v1AccountsIdPut(
          id: widget.account.id,
          body: AccountUpdate(name: _textController.text),
        );
        if (!response.isSuccessful || response.body == null) {
          log.severe("Error while submitting new name to API");
          String error;
          try {
            ValidationErrorResponse valError = ValidationErrorResponse.fromJson(
              json.decode(response.error.toString()),
            );
            error =
                valError.message ??
                // ignore: use_build_context_synchronously
                (context.mounted
                    // ignore: use_build_context_synchronously
                    ? S.of(context).errorUnknown
                    : "[nocontext] Unknown error.");
          } catch (_) {
            // ignore: use_build_context_synchronously
            error =
                context.mounted
                    // ignore: use_build_context_synchronously
                    ? S.of(context).errorUnknown
                    : "[nocontext] Unknown error.";
          }

          msg.showSnackBar(
            SnackBar(content: Text(error), behavior: SnackBarBehavior.floating),
          );
          return;
        }

        _name = response.body!.data.attributes.name;
        widget.nameUpdateFunc(_name);
      } catch (e, stackTrace) {
        log.severe("Error while submitting new name to API", e, stackTrace);
      }
    }

    log.finest(() => "switching back to text field");
    setState(() {
      _titleWidget = Text(_name);
      _editIcon = IconButton(icon: Icon(Icons.edit), onPressed: showTextfield);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: _titleWidget, actions: <Widget>[_editIcon]),
      floatingActionButton:
          widget.account.attributes.type == ShortAccountTypeProperty.asset
              ? NewTransactionFab(
                context: context,
                accountId: widget.account.id,
              )
              : null,
      body: HomeTransactions(
        filters: TransactionFilters(account: widget.account),
      ),
    );
  }
}
