import 'package:flutter/foundation.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/date_time_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/literal_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';

enum TransactionActionSourceMode { capture, literal, firefly }

enum TransactionActionStep { field, source, buildText, tags, currencyMatch }

@immutable
class TransactionActionDraft {
  const TransactionActionDraft({
    this.field,
    this.sourceMode,
    this.step = TransactionActionStep.field,
    this.isAdvancing = true,
    this.capture,
    this.extractedValue,
  });

  final TransactionField? field;
  final TransactionActionSourceMode? sourceMode;
  final TransactionActionStep step;
  final bool isAdvancing;
  final RegExpCaptureValueSource? capture;
  final String? extractedValue;

  TransactionActionDraft copyWith({
    TransactionField? field,
    TransactionActionSourceMode? sourceMode,
    TransactionActionStep? step,
    bool? isAdvancing,
    RegExpCaptureValueSource? capture,
    String? extractedValue,
    bool clearField = false,
    bool clearSourceMode = false,
    bool clearCapture = false,
  }) => TransactionActionDraft(
    field: clearField ? null : field ?? this.field,
    sourceMode: clearSourceMode ? null : sourceMode ?? this.sourceMode,
    step: step ?? this.step,
    isAdvancing: isAdvancing ?? this.isAdvancing,
    capture: clearCapture ? null : capture ?? this.capture,
    extractedValue: clearCapture ? null : extractedValue ?? this.extractedValue,
  );
}

class TransactionActionController extends ChangeNotifier {
  TransactionActionController({
    TransactionField? fixedField,
    required this.captureOnly,
  }) : fixedField = fixedField,
       _draft = TransactionActionDraft(
         field: fixedField,
         step: switch (fixedField) {
           null => TransactionActionStep.field,
           TransactionField.tag => TransactionActionStep.tags,
           _ => TransactionActionStep.source,
         },
         sourceMode: fixedField == TransactionField.currency && captureOnly
             ? TransactionActionSourceMode.capture
             : null,
       );

  final TransactionField? fixedField;
  final bool captureOnly;
  TransactionActionDraft _draft;

  TransactionActionDraft get draft => _draft;

  void _set(TransactionActionDraft value) {
    _draft = value;
    notifyListeners();
  }

  void selectField(TransactionField field) => _set(
    _draft.copyWith(
      field: field,
      step: field == TransactionField.tag
          ? TransactionActionStep.tags
          : TransactionActionStep.source,
      isAdvancing: true,
      clearSourceMode: true,
    ),
  );

  void setSourceMode(TransactionActionSourceMode? mode) =>
      _set(_draft.copyWith(sourceMode: mode, clearSourceMode: mode == null));

  void selectCapture(RegExpCaptureValueSource capture, String value) {
    assert(_draft.field == TransactionField.currency);
    _set(
      _draft.copyWith(
        capture: capture,
        extractedValue: value,
        step: TransactionActionStep.currencyMatch,
        isAdvancing: true,
      ),
    );
  }

  void selectBuildText() => _set(
    _draft.copyWith(
      step: TransactionActionStep.buildText,
      isAdvancing: true,
      clearSourceMode: true,
    ),
  );

  void back() {
    switch (_draft.step) {
      case TransactionActionStep.currencyMatch:
        _set(
          _draft.copyWith(
            step: TransactionActionStep.source,
            isAdvancing: false,
            clearCapture: true,
          ),
        );
      case TransactionActionStep.buildText:
        _set(
          _draft.copyWith(
            step: TransactionActionStep.source,
            isAdvancing: false,
            clearSourceMode: true,
          ),
        );
      case TransactionActionStep.tags when fixedField == null:
        _set(
          _draft.copyWith(
            step: TransactionActionStep.field,
            isAdvancing: false,
            clearField: true,
            clearSourceMode: true,
          ),
        );
      case TransactionActionStep.source when fixedField == null:
        _set(
          _draft.copyWith(
            step: TransactionActionStep.field,
            isAdvancing: false,
            clearField: true,
            clearSourceMode: true,
          ),
        );
      case TransactionActionStep.field ||
          TransactionActionStep.source ||
          TransactionActionStep.tags:
        return;
    }
  }

  TransactionFieldValidationError? validateLiteral(String value) =>
      TransactionFieldSpec.validateValue(
        value.trim(),
        TransactionFieldSpec.values[_draft.field]!.valueType,
      );

  NotificationAction buildLiteral(String value) => SetTransactionFieldAction(
    target: _draft.field!,
    valueSource: LiteralValueSource(value.trim()),
  );

  NotificationAction buildDerivedDateTimeCapture(
    RegExpCaptureValueSource capture,
  ) => SetTransactionFieldAction(
    target: _draft.field!,
    valueSource: DateTimeCaptureValueSource(
      capture: capture,
      field: _draft.field!,
      normalizedValue: '',
      deriveFromCapture: true,
    ),
  );

  static String? timeFromCaptureValue(String value) => RegExp(
    r'(?:T|\s)((?:[01]\d|2[0-3]):[0-5]\d(?::[0-5]\d)?)',
  ).firstMatch(value)?.group(1);

  static bool isCaptureCompatible(
    RegExpDefinition extractor,
    String captureName,
    String captureValue,
    TransactionField field,
  ) => switch (field) {
    TransactionField.amount => isAmountCaptureValue(captureValue),
    TransactionField.currency => isCurrencyCaptureValue(captureValue),
    TransactionField.date => DateTime.tryParse(captureValue.trim()) != null,
    TransactionField.time =>
      TransactionFieldSpec.validateValue(
                captureValue.trim(),
                TransactionFieldValueType.time,
              ) ==
              null ||
          timeFromCaptureValue(captureValue.trim()) != null,
    _ => true,
  };

  static bool isAmountCaptureValue(String value) =>
      TransactionFieldSpec.validateValue(
        value.trim(),
        TransactionFieldValueType.amount,
      ) ==
      null;

  static bool isCurrencyCaptureValue(String value) {
    final String normalized = value.trim();
    return RegExp(r'^[A-Za-z]{3}$').hasMatch(normalized) ||
        RegExp(r'^[^A-Za-z0-9\s]+$').hasMatch(normalized);
  }
}
