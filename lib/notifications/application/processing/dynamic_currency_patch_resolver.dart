import 'package:waterflyiii/notifications/application/resources/firefly_currency_resolver.dart';
import 'package:waterflyiii/notifications/domain/transactions/firefly_resource_reference.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_patch.dart';

class DynamicCurrencyPatchResolver {
  const DynamicCurrencyPatchResolver(this._currencyResolver);

  final FireflyCurrencyResolver _currencyResolver;

  Future<TransactionPatch> resolve(TransactionPatch patch) async {
    final String? token =
        patch.dynamicCurrencyValues[TransactionField.currency];
    final String? currencyId = patch.values[TransactionField.currency];
    if (token == null && currencyId == null) return patch;
    if (token == null &&
        patch.currencyCodes.containsKey(TransactionField.currency)) {
      return patch;
    }

    final FireflyCurrency? currency = token == null
        ? await _currencyResolver.resolveById(currencyId!)
        : await _currencyResolver.resolveUnique(token);
    if (currency == null && token != null) {
      throw NotificationCurrencyResolutionException(
        'Could not uniquely match "$token" to an enabled Firefly currency. '
        'Use a currency code such as EUR, or configure a fixed currency.',
      );
    }
    final FireflyCurrency resolvedCurrency = currency!;

    return TransactionPatch(
      <TransactionField, String>{
        ...patch.values,
        TransactionField.currency: resolvedCurrency.id,
      },
      tags: patch.tags,
      displayValues: <TransactionField, String>{
        ...patch.displayValues,
        TransactionField.currency: resolvedCurrency.name,
      },
      currencyCodes: <TransactionField, String>{
        ...patch.currencyCodes,
        TransactionField.currency: resolvedCurrency.code,
      },
      resourceReferences: <TransactionField, FireflyResourceReference>{
        ...patch.resourceReferences,
        TransactionField.currency: FireflyResourceReference(
          kind: FireflyResourceKind.currency,
          id: resolvedCurrency.id,
        ),
      },
      dynamicCurrencyValues: <TransactionField, String>{
        ...patch.dynamicCurrencyValues,
      }..remove(TransactionField.currency),
    );
  }
}

class NotificationCurrencyResolutionException implements Exception {
  const NotificationCurrencyResolutionException(this.message);

  final String message;

  @override
  String toString() => message;
}
