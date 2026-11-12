import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_patch.dart';

void main() {
  group('TransactionFieldSpec.validateValue', () {
    test('accepts finite amounts, ISO dates, and 24-hour times', () {
      expect(
        TransactionFieldSpec.validateValue(
          '12,50',
          TransactionFieldValueType.amount,
        ),
        isNull,
      );
      expect(
        TransactionFieldSpec.validateValue(
          '2026-08-31',
          TransactionFieldValueType.date,
        ),
        isNull,
      );
      expect(
        TransactionFieldSpec.validateValue(
          '14:30:45',
          TransactionFieldValueType.time,
        ),
        isNull,
      );
    });

    test('rejects non-finite amounts and malformed temporal values', () {
      expect(
        TransactionFieldSpec.validateValue(
          'Infinity',
          TransactionFieldValueType.amount,
        ),
        TransactionFieldValidationError.invalidAmount,
      );
      expect(
        TransactionFieldSpec.validateValue(
          '31/08/2026',
          TransactionFieldValueType.date,
        ),
        TransactionFieldValidationError.invalidDate,
      );
      expect(
        TransactionFieldSpec.validateValue(
          '25:00',
          TransactionFieldValueType.time,
        ),
        TransactionFieldValidationError.invalidTime,
      );
    });
  });

  test('reports whether a transaction patch contains field updates', () {
    expect(
      const TransactionPatch(<TransactionField, String>{}).isEmpty,
      isTrue,
    );
    expect(
      const TransactionPatch(<TransactionField, String>{
        TransactionField.amount: '12.50',
      }).isEmpty,
      isFalse,
    );
  });
}
