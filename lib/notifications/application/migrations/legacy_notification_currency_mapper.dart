import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/currency_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';

class LegacyResolvedCurrency {
  const LegacyResolvedCurrency({required this.token, required this.resourceId});

  final String token;
  final String resourceId;
}

class LegacyCurrencyCapture {
  const LegacyCurrencyCapture({
    required this.captureName,
    required this.token,
    required this.matchIndex,
  });

  final String captureName;
  final String token;
  final int matchIndex;
}

class LegacyNotificationCurrencyMapper {
  const LegacyNotificationCurrencyMapper();

  LegacyCurrencyCapture? currencyCapture(
    List<RegExpDefinition> extractors,
    NotificationContext context,
  ) => preferredCurrencyCapture(currencyCaptures(extractors, context));

  List<LegacyCurrencyCapture> currencyCaptures(
    List<RegExpDefinition> extractors,
    NotificationContext context,
  ) {
    final RegExpDefinition amountExtractor = extractors.firstWhere(
      (RegExpDefinition extractor) =>
          extractor.predefinedType == PredefinedRegExpDefinition.amount,
    );
    if (amountExtractor.evaluate(context).matches.length != 1) {
      return const <LegacyCurrencyCapture>[];
    }
    return _currencyCaptures(
      extractors.firstWhere(
        (RegExpDefinition extractor) =>
            extractor.predefinedType == PredefinedRegExpDefinition.currency,
      ),
      context,
    );
  }

  LegacyCurrencyCapture? preferredCurrencyCapture(
    List<LegacyCurrencyCapture> captures,
  ) {
    if (captures.length == 1) return captures.single;
    final List<LegacyCurrencyCapture> isoCodes = captures
        .where(
          (LegacyCurrencyCapture capture) =>
              RegExp(r'^[A-Za-z]{3}$').hasMatch(capture.token),
        )
        .toList(growable: false);
    return isoCodes.length == 1 ? isoCodes.single : null;
  }

  SetTransactionFieldAction currencyAction(
    RegExpDefinition extractor,
    LegacyCurrencyCapture currency,
    LegacyResolvedCurrency? resolvedCurrency,
  ) {
    final RegExpCaptureValueSource capture = RegExpCaptureValueSource(
      extractorId: extractor.id,
      captureName: currency.captureName,
      matchIndex: currency.matchIndex,
    );
    return SetTransactionFieldAction(
      target: TransactionField.currency,
      valueSource: resolvedCurrency == null
          ? capture
          : CurrencyCaptureValueSource(
              capture: capture,
              resourceId: resolvedCurrency.resourceId,
              expectedValue: currency.token,
            ),
    );
  }

  List<LegacyCurrencyCapture> _currencyCaptures(
    RegExpDefinition extractor,
    NotificationContext context,
  ) {
    final List<RegExpMatch> matches = extractor.evaluate(context).matches;
    if (matches.length != 1) return const <LegacyCurrencyCapture>[];
    final RegExpMatch match = matches.single;
    final String? preCurrency = match.namedGroup('preCurrency');
    final String? postCurrency = match.namedGroup('postCurrency');
    return <LegacyCurrencyCapture>[
      if (preCurrency?.trim().isNotEmpty ?? false)
        LegacyCurrencyCapture(
          captureName: 'preCurrency',
          token: preCurrency!.trim(),
          matchIndex: 0,
        ),
      if (postCurrency?.trim().isNotEmpty ?? false)
        LegacyCurrencyCapture(
          captureName: 'postCurrency',
          token: postCurrency!.trim(),
          matchIndex: 0,
        ),
    ];
  }
}
