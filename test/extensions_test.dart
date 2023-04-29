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

  group('DateTimeExtension', () {
    late DateTime dt1;
    late DateTime dt2;
    late TimeOfDay tod1;
    late TimeOfDay tod2;
    setUp(() {
      dt1 = DateTime(2017, 9, 7, 17, 30, 15, 20, 25);
      dt2 = DateTime(2017, 9, 7);
      tod1 = const TimeOfDay(hour: 1, minute: 2);
      tod2 = const TimeOfDay(hour: 23, minute: 59);
    });
    test('setTimeOfDay', () {
      expect(TimeOfDay.fromDateTime(dt1.setTimeOfDay(tod1)), tod1);
      expect(TimeOfDay.fromDateTime(dt2.setTimeOfDay(tod2)), tod2);
    });
    test('setTime', () {
      expect(TimeOfDay.fromDateTime(dt1.setTime(hours: 1, minutes: 2)), tod1);
      expect(TimeOfDay.fromDateTime(dt2.setTime(hours: 23, minutes: 59)), tod2);
    });
    test('clearTime', () {
      expect(TimeOfDay.fromDateTime(dt1.clearTime()),
          const TimeOfDay(hour: 0, minute: 0));
    });
    test('getTimeOfDay', () {
      expect(dt1.setTimeOfDay(tod1).getTimeOfDay(), tod1);
      expect(dt2.setTimeOfDay(tod2).getTimeOfDay(), tod2);
    });
  });
}
