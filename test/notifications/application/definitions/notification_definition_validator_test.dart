import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/definitions/notification_definition_validator.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/composed_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/literal_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/value_source.dart';

void main() {
  test('counts actions that reference missing extractors', () {
    const NotificationDefinition definition = NotificationDefinition(
      id: 'definition',
      applicationId: 'app',
      name: 'App',
      extractors: <RegExpDefinition>[],
      rules: <NotificationRule>[
        NotificationRule(
          id: 'rule',
          name: 'Rule',
          conditions: <NotificationCondition>[],
          actions: <NotificationAction>[
            SetTransactionFieldAction(
              target: TransactionField.amount,
              valueSource: RegExpCaptureValueSource(
                extractorId: 'missing',
                captureName: 'amount',
              ),
            ),
          ],
        ),
      ],
    );

    expect(
      const NotificationDefinitionValidator().danglingActionCount(definition),
      1,
    );
  });

  test('finds missing extractors inside built text', () {
    final NotificationDefinition definition = NotificationDefinition(
      id: 'definition',
      applicationId: 'app',
      name: 'App',
      extractors: const <RegExpDefinition>[],
      rules: <NotificationRule>[
        NotificationRule(
          id: 'rule',
          name: 'Rule',
          conditions: const <NotificationCondition>[],
          actions: <NotificationAction>[
            SetTransactionFieldAction(
              target: TransactionField.notes,
              valueSource: ComposedValueSource(const <ValueSource>[
                LiteralValueSource('Reference: '),
                RegExpCaptureValueSource(
                  extractorId: 'missing',
                  captureName: 'reference',
                ),
              ]),
            ),
          ],
        ),
      ],
    );

    expect(
      const NotificationDefinitionValidator().danglingActionCount(definition),
      1,
    );
  });
}
