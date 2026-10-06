import 'package:waterflyiii/notifications/application/resources/firefly_currency_resolver.dart';
import 'package:waterflyiii/notifications/application/resources/firefly_resource_label_resolver.dart';
import 'package:waterflyiii/notifications/domain/transactions/firefly_resource_reference.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_patch.dart';

class PromptedTransactionResources {
  const PromptedTransactionResources({
    required this.patch,
    required this.currency,
  });

  final TransactionPatch patch;
  final FireflyCurrency? currency;
}

class PromptedTransactionResourceHydrator {
  const PromptedTransactionResourceHydrator({
    required FireflyResourceLabelResolver labelResolver,
    required FireflyCurrencyResolver currencyResolver,
  }) : _labelResolver = labelResolver,
       _currencyResolver = currencyResolver;

  final FireflyResourceLabelResolver _labelResolver;
  final FireflyCurrencyResolver _currencyResolver;

  Future<PromptedTransactionResources> hydrate(TransactionPatch patch) async {
    final Map<TransactionField, String> displayValues =
        <TransactionField, String>{...patch.displayValues};
    final Map<TransactionField, String> currencyCodes =
        <TransactionField, String>{...patch.currencyCodes};
    FireflyCurrency? currency;

    for (final MapEntry<TransactionField, FireflyResourceReference> entry
        in patch.resourceReferences.entries) {
      switch (entry.value.kind) {
        case FireflyResourceKind.account:
          continue;
        case FireflyResourceKind.currency:
          currency = await _currencyResolver.resolveById(entry.value.id);
          displayValues[entry.key] = currency.name;
          currencyCodes[entry.key] = currency.code;
        case FireflyResourceKind.category ||
            FireflyResourceKind.tag ||
            FireflyResourceKind.subscription ||
            FireflyResourceKind.piggyBank:
          displayValues[entry.key] = await _labelResolver.resolve(
            entry.value.kind,
            entry.value.id,
          );
      }
    }

    return PromptedTransactionResources(
      patch: TransactionPatch(
        patch.values,
        tags: patch.tags,
        displayValues: displayValues,
        currencyCodes: currencyCodes,
        resourceReferences: patch.resourceReferences,
      ),
      currency: currency,
    );
  }
}
