import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_tags_action.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_evaluation_result.dart';

void main() {
  final EvaluationContext context = EvaluationContext(
    notification: NotificationContext(
      title: 'Card payment',
      body: 'Paid 12.50 CAD',
      receivedAt: DateTime(2026, 9, 7),
    ),
    extractionResults: <String, RegExpEvaluationResult>{},
  );

  test('produces an ordered, case-insensitively unique tag patch', () {
    const SetTransactionTagsAction action = SetTransactionTagsAction(<String>[
      'Groceries',
      'work',
      ' groceries ',
      '',
    ]);

    final List<String>? tags = action.evaluate(context).patch?.tags;

    expect(tags, <String>['Groceries', 'work']);
  });

  test('requires at least one nonblank tag', () {
    const SetTransactionTagsAction action = SetTransactionTagsAction(<String>[
      '  ',
    ]);

    expect(action.evaluate(context).succeeded, isFalse);
    expect(
      action.evaluate(context).failureReason,
      'Select at least one transaction tag.',
    );
  });

  test('round-trips tag actions through notification action JSON', () {
    const SetTransactionTagsAction action = SetTransactionTagsAction(<String>[
      'Groceries',
      'Travel',
    ]);

    final NotificationAction restored = NotificationAction.fromJson(
      jsonDecode(jsonEncode(action)) as Map<String, dynamic>,
    );

    expect(restored, isA<SetTransactionTagsAction>());
    expect((restored as SetTransactionTagsAction).tags, action.tags);
  });
}
