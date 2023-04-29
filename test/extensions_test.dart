import 'package:flutter/material.dart';
import 'package:test/test.dart';

import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';

import 'package:waterflyiii/extensions.dart';

void main() {
  group('AlwaysDisabledFocusNode', () {
    late FocusNode focusNode;
    setUp(() => focusNode = AlwaysDisabledFocusNode());
    test('hasFocus', () {
      expect(focusNode.hasFocus, isFalse);
    });
    test('canGetFocus', () {
      focusNode.requestFocus();
      expect(focusNode.hasFocus, isFalse);
    });
  });
  group('CurrencyFormat', () {
    late CurrencyRead currency;
    setUp(() {
      currency = CurrencyRead(
        id: '1234',
        type: 'TEST TYPE',
        attributes: Currency(
          code: 'TEST',
          name: 'TEST CURRENCY',
          symbol: 'TST',
          decimalPlaces: 3,
        ),
      );
    });
    test('zero', () {
      expect(currency.zero(locale: 'en'), '0.000');
      expect(currency.zero(locale: 'de'), '0,000');
    });
    test('fmt locale = en', () {
      expect(currency.fmt(1234, locale: 'en'), 'TST1,234.000');
      expect(currency.fmt(1234.5678, locale: 'en'), 'TST1,234.568');
      expect(currency.fmt(1234.5678, locale: 'en', decimalDigits: 1),
          'TST1,234.6');
      expect(
          currency.fmt(1234.5678, locale: 'en', decimalDigits: 0), 'TST1,235');
      expect(currency.fmt(1234.5678, locale: 'en', forceCode: true),
          'TEST1,234.568');
    });
    test('fmt locale = de', () {
      expect(currency.fmt(1234, locale: 'de'), '1.234,000\u{00A0}TST');
      expect(currency.fmt(1234.5678, locale: 'de'), '1.234,568\u{00A0}TST');
      expect(currency.fmt(1234.5678, locale: 'de', decimalDigits: 1),
          '1.234,6\u{00A0}TST');
      expect(currency.fmt(1234.5678, locale: 'de', decimalDigits: 0),
          '1.235\u{00A0}TST');
      expect(currency.fmt(1234.5678, locale: 'de', forceCode: true),
          '1.234,568\u{00A0}TEST');
    });
  });
}
