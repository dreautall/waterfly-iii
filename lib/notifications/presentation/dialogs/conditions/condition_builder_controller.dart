import 'package:flutter/foundation.dart';
import 'package:waterflyiii/notifications/domain/conditions/all_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/any_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/not_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/value_contains_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/value_exists_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/values_equal_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/values_greater_than_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/values_greater_than_or_equal_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/values_less_than_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/values_less_than_or_equal_condition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/value_sources/literal_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/value_source.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/conditions/condition_value_type.dart';

enum ConditionBuilderStep { category, kind, source, overview }

enum ConditionKindCategory { value, group }

enum ConditionEditedValue { left, right }

enum ConditionSourceMode { extractor, literal }

enum ConditionKind {
  all,
  any,
  not,
  exists,
  equals,
  contains,
  greaterThan,
  greaterThanOrEqual,
  lessThan,
  lessThanOrEqual;

  bool get isOrdered =>
      this == greaterThan ||
      this == greaterThanOrEqual ||
      this == lessThan ||
      this == lessThanOrEqual;

  static ConditionKind fromCondition(NotificationCondition condition) =>
      switch (condition) {
        ValueExistsCondition() => exists,
        ValuesEqualCondition() => equals,
        ValueContainsCondition() => contains,
        ValuesGreaterThanCondition() => greaterThan,
        ValuesGreaterThanOrEqualCondition() => greaterThanOrEqual,
        ValuesLessThanCondition() => lessThan,
        ValuesLessThanOrEqualCondition() => lessThanOrEqual,
        _ => throw ArgumentError.value(
          condition,
          'condition',
          'Condition is not configurable.',
        ),
      };
}

@immutable
class ConditionBuilderDraft {
  const ConditionBuilderDraft({
    this.step = ConditionBuilderStep.category,
    this.category,
    this.kind,
    this.left,
    this.right,
    this.originalLeft,
    this.originalRight,
    this.selectedLeftType,
    this.selectingRight = false,
    this.notDepth = 0,
    this.forward = true,
    this.sourceMode,
    this.editedValue,
  });

  final ConditionBuilderStep step;
  final ConditionKindCategory? category;
  final ConditionKind? kind;
  final ValueSource? left;
  final ValueSource? right;
  final ValueSource? originalLeft;
  final ValueSource? originalRight;
  final ConditionValueType? selectedLeftType;
  final bool selectingRight;
  final int notDepth;
  final bool forward;
  final ConditionSourceMode? sourceMode;
  final ConditionEditedValue? editedValue;

  ConditionBuilderDraft copyWith({
    ConditionBuilderStep? step,
    ConditionKindCategory? category,
    ConditionKind? kind,
    ValueSource? left,
    ValueSource? right,
    ConditionValueType? selectedLeftType,
    bool? selectingRight,
    int? notDepth,
    bool? forward,
    ConditionSourceMode? sourceMode,
    ConditionEditedValue? editedValue,
    bool clearSourceMode = false,
    bool clearEditedValue = false,
    bool clearCategory = false,
  }) => ConditionBuilderDraft(
    step: step ?? this.step,
    category: clearCategory ? null : category ?? this.category,
    kind: kind ?? this.kind,
    left: left ?? this.left,
    right: right ?? this.right,
    originalLeft: originalLeft,
    originalRight: originalRight,
    selectedLeftType: selectedLeftType ?? this.selectedLeftType,
    selectingRight: selectingRight ?? this.selectingRight,
    notDepth: notDepth ?? this.notDepth,
    forward: forward ?? this.forward,
    sourceMode: clearSourceMode ? null : sourceMode ?? this.sourceMode,
    editedValue: clearEditedValue ? null : editedValue ?? this.editedValue,
  );
}

class ConditionBuilderController extends ChangeNotifier {
  ConditionBuilderController({
    required this.extractors,
    required this.notificationContext,
    NotificationCondition? existingCondition,
  }) : isEditing = existingCondition != null,
       _draft = _initialDraft(existingCondition);

  final List<RegExpDefinition> extractors;
  final NotificationContext notificationContext;
  final bool isEditing;
  ConditionBuilderDraft _draft;

  ConditionBuilderDraft get draft => _draft;

  static ConditionBuilderDraft _initialDraft(NotificationCondition? condition) {
    if (condition == null) return const ConditionBuilderDraft();
    final ValueSource? left = _leftSource(condition);
    final ValueSource? right = _rightSource(condition);
    return ConditionBuilderDraft(
      step: right == null
          ? ConditionBuilderStep.source
          : ConditionBuilderStep.overview,
      kind: ConditionKind.fromCondition(condition),
      left: left,
      right: right,
      originalLeft: left,
      originalRight: right,
    );
  }

  void _set(ConditionBuilderDraft value) {
    _draft = value;
    notifyListeners();
  }

  void selectCategory(ConditionKindCategory category) => _set(
    _draft.copyWith(
      category: category,
      step: ConditionBuilderStep.kind,
      forward: true,
    ),
  );

  NotificationCondition? selectKind(ConditionKind kind) {
    if (kind == ConditionKind.not) {
      _set(
        _draft.copyWith(
          step: ConditionBuilderStep.category,
          notDepth: _draft.notDepth + 1,
          forward: true,
          clearCategory: true,
        ),
      );
      return null;
    }
    if (kind == ConditionKind.all || kind == ConditionKind.any) {
      return wrapNots(
        kind == ConditionKind.all
            ? const AllCondition(<NotificationCondition>[])
            : const AnyCondition(<NotificationCondition>[]),
      );
    }
    _set(
      _draft.copyWith(
        kind: kind,
        step: ConditionBuilderStep.source,
        selectingRight: false,
        forward: true,
        clearSourceMode: true,
      ),
    );
    return null;
  }

  NotificationCondition? selectSource(
    ValueSource source, {
    ConditionValueType? capturedType,
  }) {
    final ConditionEditedValue? edited = _draft.editedValue;
    if (edited != null) {
      _set(
        _draft.copyWith(
          left: edited == ConditionEditedValue.left ? source : null,
          right: edited == ConditionEditedValue.right ? source : null,
          step: ConditionBuilderStep.overview,
          clearEditedValue: true,
          clearSourceMode: true,
        ),
      );
      return null;
    }
    if (!_draft.selectingRight) {
      if (_draft.kind == ConditionKind.exists) {
        return wrapNots(ValueExistsCondition(source));
      }
      _set(
        _draft.copyWith(
          left: source,
          selectedLeftType: capturedType,
          selectingRight: true,
          step: ConditionBuilderStep.source,
          clearSourceMode: true,
        ),
      );
      return null;
    }
    _set(_draft.copyWith(right: source));
    return wrapNots(buildBinaryCondition());
  }

  void beginEdit(ConditionEditedValue value, ConditionSourceMode? mode) {
    _set(
      _draft.copyWith(
        editedValue: value,
        selectingRight: value == ConditionEditedValue.right,
        sourceMode: mode,
      ),
    );
  }

  void cancelEdit() =>
      _set(_draft.copyWith(clearEditedValue: true, clearSourceMode: true));

  void setSourceMode(ConditionSourceMode? mode) =>
      _set(_draft.copyWith(sourceMode: mode, clearSourceMode: mode == null));

  void back() {
    switch (_draft.step) {
      case ConditionBuilderStep.category:
        if (_draft.notDepth == 0) return;
        _set(
          _draft.copyWith(
            step: ConditionBuilderStep.kind,
            category: ConditionKindCategory.group,
            notDepth: _draft.notDepth - 1,
            forward: false,
          ),
        );
        return;
      case ConditionBuilderStep.kind:
        _set(
          _draft.copyWith(
            step: ConditionBuilderStep.category,
            forward: false,
            clearCategory: true,
          ),
        );
        return;
      case ConditionBuilderStep.source:
        _set(
          _draft.selectingRight
              ? _draft.copyWith(
                  selectingRight: false,
                  forward: false,
                  clearSourceMode: true,
                )
              : _draft.copyWith(
                  step: ConditionBuilderStep.kind,
                  forward: false,
                  clearSourceMode: true,
                ),
        );
        return;
      case ConditionBuilderStep.overview:
        return;
    }
  }

  NotificationCondition saveEditedLiteral(String value) {
    final LiteralValueSource source = LiteralValueSource(value.trim());
    _draft = _draft.copyWith(
      left: _draft.editedValue == ConditionEditedValue.left ? source : null,
      right: _draft.editedValue == ConditionEditedValue.right ? source : null,
    );
    return wrapNots(buildBinaryCondition());
  }

  NotificationCondition buildBinaryCondition() {
    final ValueSource left = _draft.left!;
    final ValueSource right = _draft.right!;
    return switch (_draft.kind!) {
      ConditionKind.equals => ValuesEqualCondition(left: left, right: right),
      ConditionKind.contains => ValueContainsCondition(
        value: left,
        substring: right,
      ),
      ConditionKind.greaterThan => ValuesGreaterThanCondition(
        left: left,
        right: right,
      ),
      ConditionKind.greaterThanOrEqual => ValuesGreaterThanOrEqualCondition(
        left: left,
        right: right,
      ),
      ConditionKind.lessThan => ValuesLessThanCondition(
        left: left,
        right: right,
      ),
      ConditionKind.lessThanOrEqual => ValuesLessThanOrEqualCondition(
        left: left,
        right: right,
      ),
      _ => throw StateError('Condition type does not compare two values.'),
    };
  }

  NotificationCondition wrapNots(NotificationCondition condition) {
    for (int index = 0; index < _draft.notDepth; index += 1) {
      condition = NotCondition(condition);
    }
    return condition;
  }

  ConditionValueType? get selectedLeftType {
    if (_draft.selectedLeftType case final ConditionValueType type) return type;
    final ValueSource? source = _draft.left;
    if (source == null) return null;
    final EvaluationContext context = EvaluationContext(
      notification: notificationContext,
      extractionResults: <String, RegExpEvaluationResult>{
        for (final RegExpDefinition extractor in extractors)
          extractor.id: extractor.evaluate(notificationContext),
      },
    );
    final String? value =
        source.resolve(context) ??
        (source is RegExpCaptureValueSource
            ? _resolvedCaptureValue(source, context)
            : null);
    return value == null ? null : ConditionValueType.parse(value);
  }

  bool captureIsAllowed(
    RegExpDefinition extractor,
    String value, {
    required bool selectingRight,
  }) {
    if (selectingRight &&
        _draft.left is RegExpCaptureValueSource &&
        extractor.id ==
            (_draft.left! as RegExpCaptureValueSource).extractorId) {
      return false;
    }
    final ConditionValueType type = ConditionValueType.parse(value);
    return switch (_draft.kind) {
      ConditionKind.contains => type == ConditionValueType.text,
      ConditionKind.equals => !selectingRight || type == selectedLeftType,
      ConditionKind.greaterThan ||
      ConditionKind.greaterThanOrEqual ||
      ConditionKind.lessThan ||
      ConditionKind.lessThanOrEqual =>
        type.isOrdered && (!selectingRight || type == selectedLeftType),
      _ => true,
    };
  }

  bool get hasChangedOperands =>
      _draft.originalLeft != null &&
      _draft.originalRight != null &&
      _draft.left != null &&
      _draft.right != null &&
      (!_sameValueSource(_draft.left!, _draft.originalLeft!) ||
          !_sameValueSource(_draft.right!, _draft.originalRight!));

  bool pendingLiteralDiffers(String value) {
    final ValueSource? original =
        _draft.editedValue == ConditionEditedValue.left
        ? _draft.originalLeft
        : _draft.originalRight;
    return original is! LiteralValueSource || original.value != value.trim();
  }

  static ValueSource? _leftSource(NotificationCondition condition) =>
      switch (condition) {
        ValueExistsCondition(:final ValueSource valueSource) => valueSource,
        ValuesEqualCondition(:final ValueSource left) => left,
        ValueContainsCondition(:final ValueSource value) => value,
        ValuesGreaterThanCondition(:final ValueSource left) => left,
        ValuesGreaterThanOrEqualCondition(:final ValueSource left) => left,
        ValuesLessThanCondition(:final ValueSource left) => left,
        ValuesLessThanOrEqualCondition(:final ValueSource left) => left,
        _ => null,
      };

  static ValueSource? _rightSource(NotificationCondition condition) =>
      switch (condition) {
        ValuesEqualCondition(:final ValueSource right) => right,
        ValueContainsCondition(:final ValueSource substring) => substring,
        ValuesGreaterThanCondition(:final ValueSource right) => right,
        ValuesGreaterThanOrEqualCondition(:final ValueSource right) => right,
        ValuesLessThanCondition(:final ValueSource right) => right,
        ValuesLessThanOrEqualCondition(:final ValueSource right) => right,
        _ => null,
      };

  static bool _sameValueSource(ValueSource first, ValueSource second) {
    final Map<String, dynamic> firstJson = first.toJson();
    final Map<String, dynamic> secondJson = second.toJson();
    return first.runtimeType == second.runtimeType &&
        firstJson.length == secondJson.length &&
        firstJson.entries.every(
          (MapEntry<String, dynamic> entry) =>
              secondJson[entry.key] == entry.value,
        );
  }

  static String? _resolvedCaptureValue(
    RegExpCaptureValueSource source,
    EvaluationContext context,
  ) {
    final RegExpEvaluationResult? result =
        context.extractionResults[source.extractorId];
    final int index = source.matchIndex ?? 0;
    final List<String>? named = result?.namedCaptures[source.captureName];
    if (named != null && index < named.length) return named[index];
    final int? fallback = source.fallbackCaptureIndex;
    final List<String>? positional = fallback == null
        ? null
        : result?.positionalCaptures[fallback];
    return positional != null && index < positional.length
        ? positional[index]
        : null;
  }
}
