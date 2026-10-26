import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notificationlistener.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_intent.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_patch.dart';

void main() {
  test('prompt payload round-trips an evaluated transaction intent', () {
    final NotificationTransaction payload = NotificationTransaction(
      'com.example.bank',
      'Card purchase',
      'Paid 12.50',
      DateTime(2026, 4, 10),
      historyEntryId: 'delivery-42',
      intent: const TransactionIntent(
        mode: TransactionCreationMode.prompt,
        patch: TransactionPatch(<TransactionField, String>{
          TransactionField.amount: '12.50',
        }),
      ),
    );

    final NotificationTransaction restored = NotificationTransaction.fromJson(
      jsonDecode(jsonEncode(payload)) as Map<String, dynamic>,
    );

    expect(restored.intent.mode, TransactionCreationMode.prompt);
    expect(restored.intent.patch.values[TransactionField.amount], '12.50');
    expect(restored.historyEntryId, 'delivery-42');
  });

  test('accepts prompt payloads created before history links were added', () {
    final NotificationTransaction restored = NotificationTransaction.fromJson(
      <String, dynamic>{
        'appName': 'com.example.bank',
        'title': 'Card purchase',
        'body': 'Paid 12.50',
        'date': '2026-04-10T08:15:00.000',
        'intent': const TransactionIntent(
          mode: TransactionCreationMode.prompt,
          patch: TransactionPatch(<TransactionField, String>{
            TransactionField.amount: '12.50',
          }),
        ).toJson(),
      },
    );

    expect(restored.historyEntryId, isNull);
  });

  test('restores legacy prompt payloads without an intent', () {
    final NotificationTransaction restored =
        NotificationTransaction.fromJson(<String, dynamic>{
          'appName': 'com.example.bank',
          'title': 'Card purchase',
          'body': 'Paid 12.50',
          'date': '2026-04-10T08:15:00.000',
        });

    expect(restored.intent.mode, TransactionCreationMode.prompt);
    expect(restored.intent.patch.values, <TransactionField, String>{
      TransactionField.title: 'Card purchase',
      TransactionField.notes: 'Paid 12.50',
    });
    expect(restored.date, DateTime(2026, 4, 10, 8, 15));
    expect(restored.historyEntryId, isNull);
  });
}
