import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/domain/conditions/not_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/values_equal_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/values_greater_than_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/values_numerically_equal_condition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/value_sources/literal_value_source.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/conditions/condition_builder_controller.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/conditions/condition_value_type.dart';

void main() {
  final NotificationContext context = NotificationContext(
    title: 'Payment',
    body: 'Paid 12.50',
    receivedAt: DateTime(2026, 9, 23),
  );

  test('parses and validates comparison value types', () {
    expect(ConditionValueType.parse('12,50'), ConditionValueType.number);
    expect(
      ConditionValueType.parse('2026-09-23T10:30:00'),
      ConditionValueType.dateTime,
    );
    expect(ConditionValueType.parse('2026-09-23'), ConditionValueType.date);
    expect(ConditionValueType.parse('10:30'), ConditionValueType.time);
    expect(ConditionValueType.time.isValid('25:00'), isFalse);
  });

  test('owns negation and binary condition transitions', () {
    final ConditionBuilderController controller = ConditionBuilderController(
      extractors: const <RegExpDefinition>[],
      notificationContext: context,
    );

    expect(controller.draft.step, ConditionBuilderStep.category);
    controller.selectCategory(ConditionKindCategory.group);
    expect(controller.selectKind(ConditionKind.not), isNull);
    expect(controller.draft.notDepth, 1);
    expect(controller.draft.step, ConditionBuilderStep.category);
    controller.selectCategory(ConditionKindCategory.value);
    expect(controller.selectKind(ConditionKind.greaterThan), isNull);
    expect(controller.draft.step, ConditionBuilderStep.source);

    expect(
      controller.selectSource(
        const LiteralValueSource('10'),
        capturedType: ConditionValueType.number,
      ),
      isNull,
    );
    final Object? result = controller.selectSource(
      const LiteralValueSource('5'),
    );

    expect(result, isA<NotCondition>());
    expect(
      (result! as NotCondition).condition,
      isA<ValuesGreaterThanCondition>(),
    );
    controller.dispose();
  });

  test('builds exact and numeric equality as distinct condition types', () {
    final ConditionBuilderController exact = ConditionBuilderController(
      extractors: const <RegExpDefinition>[],
      notificationContext: context,
    );
    exact.selectCategory(ConditionKindCategory.value);
    exact.selectKind(ConditionKind.equals);
    expect(exact.draft.step, ConditionBuilderStep.equalityMode);
    exact.selectEqualityMode(ConditionEqualityMode.exact);
    expect(exact.selectedLeftType, ConditionValueType.text);
    exact.selectSource(
      const LiteralValueSource('10.40'),
      capturedType: ConditionValueType.number,
    );
    expect(
      exact.selectSource(const LiteralValueSource('10,40')),
      isA<ValuesEqualCondition>(),
    );

    final ConditionBuilderController numeric = ConditionBuilderController(
      extractors: const <RegExpDefinition>[],
      notificationContext: context,
    );
    numeric.selectCategory(ConditionKindCategory.value);
    numeric.selectKind(ConditionKind.equals);
    numeric.selectEqualityMode(ConditionEqualityMode.numeric);
    expect(numeric.selectedLeftType, ConditionValueType.number);
    numeric.selectSource(
      const LiteralValueSource('10.40'),
      capturedType: ConditionValueType.number,
    );
    expect(
      numeric.selectSource(const LiteralValueSource('10,40')),
      isA<ValuesNumericallyEqualCondition>(),
    );
    exact.dispose();
    numeric.dispose();
  });

  test('restores the equality mode while editing persisted conditions', () {
    final ConditionBuilderController exact = ConditionBuilderController(
      extractors: const <RegExpDefinition>[],
      notificationContext: context,
      existingCondition: const ValuesEqualCondition(
        left: LiteralValueSource('10.40'),
        right: LiteralValueSource('10,40'),
      ),
    );
    final ConditionBuilderController numeric = ConditionBuilderController(
      extractors: const <RegExpDefinition>[],
      notificationContext: context,
      existingCondition: const ValuesNumericallyEqualCondition(
        left: LiteralValueSource('10.40'),
        right: LiteralValueSource('10,40'),
      ),
    );

    expect(exact.draft.equalityMode, ConditionEqualityMode.exact);
    expect(numeric.draft.equalityMode, ConditionEqualityMode.numeric);
    expect(exact.draft.step, ConditionBuilderStep.overview);
    expect(numeric.draft.step, ConditionBuilderStep.overview);
    exact.dispose();
    numeric.dispose();
  });

  test('editing draft tracks operand changes and saves literal', () {
    final ConditionBuilderController controller = ConditionBuilderController(
      extractors: const <RegExpDefinition>[],
      notificationContext: context,
      existingCondition: const ValuesGreaterThanCondition(
        left: LiteralValueSource('10'),
        right: LiteralValueSource('5'),
      ),
    );

    expect(controller.draft.step, ConditionBuilderStep.overview);
    expect(controller.hasChangedOperands, isFalse);
    controller.beginEdit(
      ConditionEditedValue.right,
      ConditionSourceMode.literal,
    );
    expect(controller.pendingLiteralDiffers('5'), isFalse);
    final ValuesGreaterThanCondition result =
        controller.saveEditedLiteral('4') as ValuesGreaterThanCondition;
    expect((result.right as LiteralValueSource).value, '4');
    controller.dispose();
  });
}
