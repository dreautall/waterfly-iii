import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/date_time_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/literal_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/actions/transaction_action_controller.dart';

void main() {
  test('owns field and back transitions', () {
    final TransactionActionController controller = TransactionActionController(
      captureOnly: false,
    );

    expect(controller.draft.step, TransactionActionStep.field);
    controller.selectField(TransactionField.amount);
    expect(controller.draft.step, TransactionActionStep.source);
    controller.setSourceMode(TransactionActionSourceMode.literal);
    expect(
      controller.validateLiteral('not an amount'),
      TransactionFieldValidationError.invalidAmount,
    );
    final SetTransactionFieldAction action =
        controller.buildLiteral(' 12.50 ') as SetTransactionFieldAction;
    expect(action.target, TransactionField.amount);
    expect((action.valueSource as LiteralValueSource).value, '12.50');

    controller.back();
    expect(controller.draft.step, TransactionActionStep.field);
    controller.dispose();
  });

  test('moves between field and tag steps', () {
    final TransactionActionController controller = TransactionActionController(
      captureOnly: false,
    );

    controller.selectField(TransactionField.tag);
    expect(controller.draft.step, TransactionActionStep.tags);
    expect(controller.draft.field, TransactionField.tag);

    controller.back();
    expect(controller.draft.step, TransactionActionStep.field);
    expect(controller.draft.field, isNull);
    controller.dispose();
  });

  test('opens a fixed tag field directly on the tag step', () {
    final TransactionActionController controller = TransactionActionController(
      fixedField: TransactionField.tag,
      captureOnly: false,
    );

    expect(controller.draft.step, TransactionActionStep.tags);
    controller.back();
    expect(controller.draft.step, TransactionActionStep.tags);
    controller.dispose();
  });

  test('builds a dynamically derived date-time capture source', () {
    final TransactionActionController controller = TransactionActionController(
      fixedField: TransactionField.time,
      captureOnly: true,
    );
    const RegExpCaptureValueSource capture = RegExpCaptureValueSource(
      extractorId: 'date',
      captureName: 'date',
    );

    final SetTransactionFieldAction action =
        controller.buildDerivedDateTimeCapture(capture)
            as SetTransactionFieldAction;
    final DateTimeCaptureValueSource source =
        action.valueSource as DateTimeCaptureValueSource;
    expect(source.capture, capture);
    expect(source.field, TransactionField.time);
    expect(source.normalizedValue, isEmpty);
    expect(source.deriveFromCapture, isTrue);
    controller.dispose();
  });

  test('validates capture values without relying on capture names', () {
    expect(TransactionActionController.isAmountCaptureValue('9,00'), isTrue);
    expect(
      TransactionActionController.isAmountCaptureValue('not an amount'),
      isFalse,
    );
    expect(TransactionActionController.isCurrencyCaptureValue('CAD'), isTrue);
    expect(TransactionActionController.isCurrencyCaptureValue(r'$'), isTrue);
    expect(TransactionActionController.isCurrencyCaptureValue('9.00'), isFalse);
  });
}
