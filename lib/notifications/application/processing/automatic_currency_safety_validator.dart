import 'package:waterflyiii/notifications/application/resources/firefly_account_currency_gateway.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_intent.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';

class AutomaticCurrencySafetyValidator {
  const AutomaticCurrencySafetyValidator(this._gateway);

  final FireflyAccountCurrencyGateway _gateway;

  Future<void> validate(TransactionIntent intent) async {
    if (intent.mode != TransactionCreationMode.automatic) return;
    final String? transactionCurrencyId =
        intent.patch.values[TransactionField.currency];
    final String? transactionCurrencyCode =
        intent.patch.currencyCodes[TransactionField.currency];
    if (transactionCurrencyId == null || transactionCurrencyCode == null) {
      return;
    }

    final Set<String> accountIds = <String>{
      ?intent.patch.values[TransactionField.sourceAccount],
      ?intent.patch.values[TransactionField.destinationAccount],
    };
    for (final String accountId in accountIds) {
      final FireflyAccountCurrency accountCurrency = await _gateway
          .resolveAccountCurrency(accountId);
      if (accountCurrency.id == transactionCurrencyId) continue;
      final bool canConvert = await _gateway.hasExchangeRate(
        fromCode: transactionCurrencyCode,
        toCode: accountCurrency.code,
      );
      if (!canConvert) {
        throw NotificationAutomaticCurrencyException(
          'Automatic transaction creation cannot safely convert '
          '$transactionCurrencyCode to ${accountCurrency.code}. Configure an '
          'exchange rate in Firefly III or use Prompt for creation.',
        );
      }
    }
  }
}

class NotificationAutomaticCurrencyException implements Exception {
  const NotificationAutomaticCurrencyException(this.message);

  final String message;

  @override
  String toString() => message;
}
