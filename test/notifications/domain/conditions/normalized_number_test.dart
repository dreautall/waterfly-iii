import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/domain/conditions/normalized_number.dart';

void main() {
  group('normalizeTransactionAmount', () {
    test('preserves a single separator as a decimal separator', () {
      expect(normalizeTransactionAmount('0.001'), '0.001');
      expect(normalizeTransactionAmount('1.234'), '1.234');
      expect(normalizeTransactionAmount('12,345'), '12.345');
    });

    test('normalizes unambiguous grouped numbers', () {
      expect(normalizeTransactionAmount('1.000,00'), '1000.00');
      expect(normalizeTransactionAmount('1,234.56'), '1234.56');
      expect(normalizeTransactionAmount('1,000,000'), '1000000');
      expect(normalizeTransactionAmount("1'000.00"), '1000.00');
      expect(normalizeTransactionAmount('1 000,00'), '1000.00');
    });
  });
}
