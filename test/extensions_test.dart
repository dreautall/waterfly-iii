import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';

import 'package:waterflyiii/extensions.dart';

void main() {
  group("AlwaysDisabledFocusNode", () {
    late FocusNode focusNode;

    setUp(() => focusNode = AlwaysDisabledFocusNode());
    test("hasFocus", () {
      expect(focusNode.hasFocus, isFalse);
    });
    test("canGetFocus", () {
      focusNode.requestFocus();
      expect(focusNode.hasFocus, isFalse);
    });
  });
  group("CurrencyFormat", () {
    late CurrencyRead currency;

    setUp(() {
      currency = const CurrencyRead(
        id: "1234",
        type: "TEST TYPE",
        attributes: Currency(
          code: "TEST",
          name: "TEST CURRENCY",
          symbol: "TST",
          decimalPlaces: 3,
        ),
      );
    });
    group("fmt", () {
      test("locale = en", () {
        expect(currency.fmt(1234, locale: "en"), "TST1,234.000");
        expect(currency.fmt(1234.5678, locale: "en"), "TST1,234.568");
        expect(currency.fmt(1234.5678, locale: "en", decimalDigits: 1),
            "TST1,234.6");
        expect(currency.fmt(1234.5678, locale: "en", decimalDigits: 0),
            "TST1,235");
        expect(currency.fmt(1234.5678, locale: "en", forceCode: true),
            "TEST1,234.568");
      });
      test("locale = de", () {
        expect(currency.fmt(1234, locale: "de"), "1.234,000\u{00A0}TST");
        expect(currency.fmt(1234.5678, locale: "de"), "1.234,568\u{00A0}TST");
        expect(currency.fmt(1234.5678, locale: "de", decimalDigits: 1),
            "1.234,6\u{00A0}TST");
        expect(currency.fmt(1234.5678, locale: "de", decimalDigits: 0),
            "1.235\u{00A0}TST");
        expect(currency.fmt(1234.5678, locale: "de", forceCode: true),
            "1.234,568\u{00A0}TEST");
      });
    });
    test("zero", () {
      expect(currency.zero(locale: "en"), "0.000");
      expect(currency.zero(locale: "de"), "0,000");
    });
  });

  group("TransactionType", () {
    test("color", () {
      expect(TransactionTypeProperty.deposit.color, Colors.green);
      expect(
          TransactionTypeProperty.swaggerGeneratedUnknown.color, Colors.black);
    });
    test("icon", () {
      expect(TransactionTypeProperty.withdrawal.icon, Icons.arrow_back);
      expect(TransactionTypeProperty.swaggerGeneratedUnknown.icon,
          Icons.question_mark);
    });
  });

  group("DateTimeExtension", () {
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
    test("setTimeOfDay", () {
      expect(TimeOfDay.fromDateTime(dt1.setTimeOfDay(tod1)), tod1);
      expect(TimeOfDay.fromDateTime(dt2.setTimeOfDay(tod2)), tod2);
    });
    test("setTime", () {
      expect(TimeOfDay.fromDateTime(dt1.setTime(hours: 1, minutes: 2)), tod1);
      expect(TimeOfDay.fromDateTime(dt2.setTime(hours: 23, minutes: 59)), tod2);
    });
    test("clearTime", () {
      expect(TimeOfDay.fromDateTime(dt1.clearTime()),
          const TimeOfDay(hour: 0, minute: 0));
    });
    test("getTimeOfDay", () {
      expect(dt1.setTimeOfDay(tod1).getTimeOfDay(), tod1);
      expect(dt2.setTimeOfDay(tod2).getTimeOfDay(), tod2);
    });
  });

  group("TZDateTimeExtension", () {
    late tz.TZDateTime dt1;
    late tz.TZDateTime dt2;
    late TimeOfDay tod1;
    late TimeOfDay tod2;

    setUp(() {
      tz_data.initializeTimeZones();

      dt1 = tz.TZDateTime(
          tz.getLocation("America/Detroit"), 2017, 9, 7, 17, 30, 15, 20, 25);
      dt2 = tz.TZDateTime(tz.getLocation("Europe/Paris"), 2017, 9, 7);
      tod1 = const TimeOfDay(hour: 1, minute: 2);
      tod2 = const TimeOfDay(hour: 23, minute: 59);
    });
    test("setTimeOfDay", () {
      expect(TimeOfDay.fromDateTime(dt1.setTimeOfDay(tod1)), tod1);
      expect(TimeOfDay.fromDateTime(dt2.setTimeOfDay(tod2)), tod2);
    });
    test("setTime", () {
      expect(TimeOfDay.fromDateTime(dt1.setTime(hours: 1, minutes: 2)), tod1);
      expect(TimeOfDay.fromDateTime(dt2.setTime(hours: 23, minutes: 59)), tod2);
    });
    test("clearTime", () {
      expect(TimeOfDay.fromDateTime(dt1.clearTime()),
          const TimeOfDay(hour: 0, minute: 0));
    });
    test("getTimeOfDay", () {
      expect(dt1.setTimeOfDay(tod1).getTimeOfDay(), tod1);
      expect(dt2.setTimeOfDay(tod2).getTimeOfDay(), tod2);
    });
  });

  group("ListStringIgnoreCase", () {
    late List<String> l;

    setUp(() {
      l = <String>["aa", "BB", "cC"];
    });

    test("containsIgnoreCase", () {
      expect(l.containsIgnoreCase("aa"), isTrue);
      expect(l.containsIgnoreCase("AA"), isTrue);
      expect(l.containsIgnoreCase("Aa"), isTrue);
      expect(l.containsIgnoreCase("aA"), isTrue);
      expect(l.containsIgnoreCase("bb"), isTrue);
      expect(l.containsIgnoreCase("BB"), isTrue);
      expect(l.containsIgnoreCase("Bb"), isTrue);
      expect(l.containsIgnoreCase("bB"), isTrue);
      expect(l.containsIgnoreCase("cc"), isTrue);
      expect(l.containsIgnoreCase("CC"), isTrue);
      expect(l.containsIgnoreCase("Cc"), isTrue);
      expect(l.containsIgnoreCase("cC"), isTrue);
      expect(l.containsIgnoreCase("a"), isFalse);
      expect(l.containsIgnoreCase("A"), isFalse);
    });
  });

  group("StringIgnoreCase", () {
    late String s;

    setUp(() {
      s = "aBc";
    });

    test("containsIgnoreCase", () {
      expect(s.containsIgnoreCase("a"), isTrue);
      expect(s.containsIgnoreCase("A"), isTrue);
      expect(s.containsIgnoreCase("b"), isTrue);
      expect(s.containsIgnoreCase("B"), isTrue);
      expect(s.containsIgnoreCase("c"), isTrue);
      expect(s.containsIgnoreCase("C"), isTrue);
      expect(s.containsIgnoreCase("d"), isFalse);
      expect(s.containsIgnoreCase("D"), isFalse);
    });
  });

  group("AccountTypeFilterIcon", () {
    test("icon", () {
      expect(AccountTypeFilter.asset.icon, Icons.money_outlined);
      expect(
          AccountTypeFilter.swaggerGeneratedUnknown.icon, Icons.question_mark);
    });
  });

  group("BillAmountAvg", () {
    late Bill b1, b2, b3, b4, b5;

    setUp(() {
      b1 = Bill(
        name: "TEST",
        date: DateTime(2017, 9, 7, 17, 30, 15, 20, 25),
        repeatFreq: BillRepeatFrequency.swaggerGeneratedUnknown,
        amountMin: "10",
        amountMax: "20",
      );
      b2 = b1.copyWith(amountMin: "0", amountMax: "10");
      b3 = b1.copyWith(amountMin: "10", amountMax: "0");
      b4 = b1.copyWith(amountMin: "asdf", amountMax: "-10");
      b5 = b1.copyWith(amountMin: "1", amountMax: "2");
    });
    test("avgAmount", () {
      expect(b1.avgAmount, 15);
      expect(b2.avgAmount, 10);
      expect(b3.avgAmount, 10);
      expect(b4.avgAmount, 10);
      expect(b5.avgAmount, 1.5);
    });
  });
}
