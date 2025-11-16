import 'package:chopper/chopper.dart' show Response;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';

class CurrencyDialog extends StatelessWidget {
  const CurrencyDialog({super.key, required this.currentCurrency});

  final CurrencyRead currentCurrency;

  Future<List<CurrencyRead>>? _getCurrencies(BuildContext context) async {
    final FireflyIii api = context.read<FireflyService>().api;
    final Response<CurrencyArray> response = await api.v1CurrenciesGet();
    apiThrowErrorIfEmpty(response, context.mounted ? context : null);

    final List<CurrencyRead> currencies = response.body!.data;

    currencies.removeWhere(
      (CurrencyRead currency) => currency.attributes.enabled != true,
    );

    currencies.sort((CurrencyRead a, CurrencyRead b) {
      if (a.id == context.read<FireflyService>().defaultCurrency.id) {
        return -1;
      } else if (b.id == context.read<FireflyService>().defaultCurrency.id) {
        return 1;
      } else {
        return a.attributes.code.toLowerCase().compareTo(
          b.attributes.code.toLowerCase(),
        );
      }
    });
    return currencies;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(S.of(context).transactionDialogCurrencyTitle),
      clipBehavior: Clip.hardEdge,
      children: <Widget>[
        FutureBuilder<List<CurrencyRead>>(
          future: _getCurrencies(context),
          builder: (
            BuildContext context,
            AsyncSnapshot<List<CurrencyRead>> snapshot,
          ) {
            if (snapshot.hasData) {
              final List<Widget> child = <Widget>[];
              for (CurrencyRead currency in snapshot.data!) {
                child.add(
                  CurrencyDialogOption(
                    optionCurrency: currency,
                    currentCurrency: currentCurrency,
                  ),
                );
                child.add(const Divider());
              }
              child.removeLast();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: child,
              );
            } else if (snapshot.hasError) {
              log.severe(
                "error getting currencies",
                snapshot.error,
                snapshot.stackTrace,
              );
              Navigator.pop(context);
              return const CircularProgressIndicator();
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }
}

class CurrencyDialogOption extends StatelessWidget {
  const CurrencyDialogOption({
    super.key,
    required this.optionCurrency,
    required this.currentCurrency,
  });

  final CurrencyRead optionCurrency;
  final CurrencyRead currentCurrency;

  @override
  Widget build(BuildContext context) {
    return /*SimpleDialogOption(
      onPressed: () {
        Navigator.pop(context, currency);
      },
      /*child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            currencyWithSymbol ?? currency.attributes.code,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(currency.attributes.name),
        ],
      ),*/
      padding: EdgeInsets.zero,
      child: */ ListTile(
      leading: CircleAvatar(child: Text(optionCurrency.attributes.symbol)),
      title: Text(optionCurrency.attributes.code),
      subtitle: Text(optionCurrency.attributes.name),
      onTap: () {
        Navigator.pop(context, optionCurrency);
      },
      trailing:
          (optionCurrency.id ==
                  context.read<FireflyService>().defaultCurrency.id)
              ? Text(
                S.of(context).generalDefault,
                style: const TextStyle(fontStyle: FontStyle.italic),
              )
              : null,
      selected: (optionCurrency.id == currentCurrency.id),
    );
  }
}
