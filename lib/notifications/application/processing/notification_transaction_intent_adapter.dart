import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_intent.dart';
import 'package:waterflyiii/notifications/domain/conditions/normalized_number.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_patch.dart';

class NotificationTransactionIntentAdapter {
  const NotificationTransactionIntentAdapter._();

  static TransactionStore toStore(
    TransactionIntent intent, {
    required DateTime fallbackDate,
    DateTime Function(DateTime date)? transformDate,
  }) {
    final TransactionPatch patch = intent.patch;
    final String amount = _requiredValue(patch, TransactionField.amount);
    final num? parsedAmount = parseNormalizedTransactionAmount(amount);
    if (parsedAmount == null || !parsedAmount.isFinite || parsedAmount <= 0) {
      throw const FormatException(
        'Automatic transaction creation requires a positive amount.',
      );
    }
    final String description = _requiredValue(patch, TransactionField.title);
    final String? sourceId = _resourceId(patch, TransactionField.sourceAccount);
    final String? sourceName = sourceId == null
        ? patch.values[TransactionField.sourceAccount]
        : null;
    final String? destinationId = _resourceId(
      patch,
      TransactionField.destinationAccount,
    );
    final String? destinationName = destinationId == null
        ? patch.values[TransactionField.destinationAccount]
        : null;
    final TransactionTypeProperty type = transactionTypeFor(
      sourceId: sourceId,
      destinationId: destinationId,
      sourceName: sourceName,
      destinationName: destinationName,
      sourceIsDynamic: patch.dynamicAccountValues.containsKey(
        TransactionField.sourceAccount,
      ),
      destinationIsDynamic: patch.dynamicAccountValues.containsKey(
        TransactionField.destinationAccount,
      ),
    );
    final String? piggyBankId = patch.values[TransactionField.piggyBank];
    final DateTime date = transactionDate(patch, fallbackDate: fallbackDate);

    return TransactionStore(
      groupTitle: null,
      transactions: <TransactionSplitStore>[
        TransactionSplitStore(
          type: type,
          date: transformDate?.call(date) ?? date,
          amount: parsedAmount.toString(),
          description: description,
          order: 0,
          currencyId: patch.values[TransactionField.currency],
          categoryId: patch.values[TransactionField.category],
          sourceId: sourceId,
          sourceName: sourceName,
          destinationId: destinationId,
          destinationName: destinationName,
          piggyBankId: piggyBankId == null
              ? null
              : int.tryParse(piggyBankId) ??
                    (throw const FormatException(
                      'The configured piggy bank identifier is invalid.',
                    )),
          billId: patch.values[TransactionField.subscription],
          tags: _tagsFor(patch),
          notes: patch.values[TransactionField.notes],
        ),
      ],
      applyRules: true,
      fireWebhooks: true,
      errorIfDuplicateHash: true,
    );
  }

  static TransactionTypeProperty transactionTypeFor({
    required String? sourceId,
    required String? destinationId,
    String? sourceName,
    String? destinationName,
    bool sourceIsDynamic = false,
    bool destinationIsDynamic = false,
  }) {
    final bool hasSourceId = sourceId?.trim().isNotEmpty ?? false;
    final bool hasSourceName = sourceName?.trim().isNotEmpty ?? false;
    final bool hasDestinationId = destinationId?.trim().isNotEmpty ?? false;
    final bool hasDestinationName = destinationName?.trim().isNotEmpty ?? false;
    if (destinationIsDynamic && !sourceIsDynamic) {
      return TransactionTypeProperty.withdrawal;
    }
    if (sourceIsDynamic && !destinationIsDynamic) {
      return TransactionTypeProperty.deposit;
    }
    if ((hasSourceId || hasSourceName) &&
        (hasDestinationId || hasDestinationName)) {
      return TransactionTypeProperty.transfer;
    }
    if (hasSourceId || hasSourceName) {
      return TransactionTypeProperty.withdrawal;
    }
    if (hasDestinationId || hasDestinationName) {
      return TransactionTypeProperty.deposit;
    }
    throw const FormatException(
      'Automatic transaction creation requires a source or destination account.',
    );
  }

  static DateTime transactionDate(
    TransactionPatch patch, {
    required DateTime fallbackDate,
  }) {
    final String? date = patch.values[TransactionField.date];
    final String? time = patch.values[TransactionField.time];
    final DateTime baseDate = date == null
        ? fallbackDate
        : DateTime.tryParse(date) ??
              (throw const FormatException(
                'The configured transaction date is invalid.',
              ));
    if (time == null) {
      return DateTime(
        baseDate.year,
        baseDate.month,
        baseDate.day,
        fallbackDate.hour,
        fallbackDate.minute,
      );
    }
    final RegExpMatch? match = RegExp(
      r'^([01]\d|2[0-3]):([0-5]\d)(?::([0-5]\d))?$',
    ).firstMatch(time);
    if (match == null) {
      throw const FormatException(
        'The configured transaction time is invalid.',
      );
    }
    return DateTime(
      baseDate.year,
      baseDate.month,
      baseDate.day,
      int.parse(match.group(1)!),
      int.parse(match.group(2)!),
    );
  }

  static String _requiredValue(TransactionPatch patch, TransactionField field) {
    final String? value = patch.values[field];
    if (value?.trim().isNotEmpty ?? false) return value!.trim();
    throw FormatException(
      'Automatic transaction creation requires ${field.name}.',
    );
  }

  static String? _resourceId(TransactionPatch patch, TransactionField field) {
    final String? id = patch.resourceReferences[field]?.id;
    return id?.trim().isEmpty ?? true ? null : id;
  }

  static List<String> _tagsFor(TransactionPatch patch) {
    final List<String> tags = <String>[...patch.tags];
    final String fieldTag = patch.displayValue(TransactionField.tag).trim();
    if (fieldTag.isNotEmpty &&
        !tags.any(
          (String tag) => tag.toLowerCase() == fieldTag.toLowerCase(),
        )) {
      tags.add(fieldTag);
    }
    return tags;
  }
}
