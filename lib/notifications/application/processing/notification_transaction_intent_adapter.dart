import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_intent.dart';
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
    final num? parsedAmount = num.tryParse(amount.replaceAll(',', '.'));
    if (parsedAmount == null || !parsedAmount.isFinite || parsedAmount <= 0) {
      throw const FormatException(
        'Automatic transaction creation requires a positive amount.',
      );
    }
    final String description = _requiredValue(patch, TransactionField.title);
    final String? sourceId = patch.values[TransactionField.sourceAccount];
    final String? destinationId =
        patch.values[TransactionField.destinationAccount];
    final TransactionTypeProperty type = transactionTypeFor(
      sourceId: sourceId,
      destinationId: destinationId,
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
          destinationId: destinationId,
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
  }) {
    final bool hasSource = sourceId?.trim().isNotEmpty ?? false;
    final bool hasDestination = destinationId?.trim().isNotEmpty ?? false;
    if (hasSource && hasDestination) return TransactionTypeProperty.transfer;
    if (hasSource) return TransactionTypeProperty.withdrawal;
    if (hasDestination) return TransactionTypeProperty.deposit;
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
        fallbackDate.second,
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
      int.parse(match.group(3) ?? '0'),
    );
  }

  static String _requiredValue(TransactionPatch patch, TransactionField field) {
    final String? value = patch.values[field];
    if (value?.trim().isNotEmpty ?? false) return value!.trim();
    throw FormatException(
      'Automatic transaction creation requires ${field.name}.',
    );
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
