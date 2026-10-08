import 'package:waterflyiii/notifications/domain/actions/action_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/domain/evaluation/evaluation_context.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/transactions/firefly_resource_reference.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_patch.dart';
import 'package:waterflyiii/notifications/domain/value_sources/currency_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/composed_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/date_time_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/firefly_resource_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/literal_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/normalized_amount_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/value_source.dart';

class SetTransactionFieldAction implements NotificationAction {
  const SetTransactionFieldAction({
    required this.target,
    required this.valueSource,
  });

  static const String type = 'setTransactionField';

  final TransactionField target;
  final ValueSource valueSource;

  @override
  ActionEvaluationResult evaluate(EvaluationContext context) {
    final TransactionFieldSpec spec = TransactionFieldSpec.values[target]!;
    final ValueSource source = valueSource;
    if (!spec.allowedSources.contains(_sourceKind(source))) {
      return ActionEvaluationResult.failure(
        '${target.name} cannot be set from this value source.',
      );
    }
    if (source is ComposedValueSource &&
        target != TransactionField.title &&
        target != TransactionField.notes) {
      return const ActionEvaluationResult.failure(
        'Built text can only set the title or notes field.',
      );
    }
    if (source is CurrencyCaptureValueSource &&
        target != TransactionField.currency) {
      return const ActionEvaluationResult.failure(
        'A mapped currency capture can only set the currency field.',
      );
    }
    if (target == TransactionField.currency &&
        source is! CurrencyCaptureValueSource) {
      return const ActionEvaluationResult.failure(
        'Currency must be mapped to a Firefly currency.',
      );
    }
    if (source is DateTimeCaptureValueSource && source.field != target) {
      return const ActionEvaluationResult.failure(
        'A normalized date or time capture can only set its matching field.',
      );
    }
    if (source is NormalizedAmountCaptureValueSource &&
        target != TransactionField.amount) {
      return const ActionEvaluationResult.failure(
        'A normalized amount capture can only set the amount field.',
      );
    }
    if (source is FireflyResourceValueSource) {
      final FireflyResourceKind resourceKind = source.resourceKind;
      if (spec.resourceKind != resourceKind) {
        return ActionEvaluationResult.failure(
          '${target.name} requires a ${spec.resourceKind!.name} selection.',
        );
      }
    }
    final ValueSource resolutionSource =
        source is RegExpCaptureValueSource &&
            source.textFormat == null &&
            spec.valueType == TransactionFieldValueType.text &&
            context.dateTimeExtractorIds.contains(source.extractorId)
        ? source.withDateTimeTextFormat()
        : source;
    final String? value = resolutionSource.resolve(context);
    if (value == null) {
      return ActionEvaluationResult.failure(
        _unresolvedValueSourceMessage(source, context),
      );
    }

    final TransactionFieldValidationError? validationError =
        TransactionFieldSpec.validateValue(value, spec.valueType);
    if (validationError != null) {
      return ActionEvaluationResult.failure(validationError.name);
    }

    final FireflyResourceReference? resourceReference = switch (source) {
      final FireflyResourceValueSource resource => FireflyResourceReference(
        kind: resource.resourceKind,
        id: resource.resourceId,
      ),
      final CurrencyCaptureValueSource currency => FireflyResourceReference(
        kind: FireflyResourceKind.currency,
        id: currency.resourceId,
      ),
      _ => null,
    };
    return ActionEvaluationResult.success(
      TransactionPatch(
        <TransactionField, String>{target: value},
        resourceReferences: resourceReference == null
            ? const <TransactionField, FireflyResourceReference>{}
            : <TransactionField, FireflyResourceReference>{
                target: resourceReference,
              },
      ),
    );
  }

  String _unresolvedValueSourceMessage(
    ValueSource source,
    EvaluationContext context,
  ) {
    final RegExpCaptureValueSource? capture = switch (source) {
      RegExpCaptureValueSource() => source,
      CurrencyCaptureValueSource(:final RegExpCaptureValueSource capture) =>
        capture,
      DateTimeCaptureValueSource(:final RegExpCaptureValueSource capture) =>
        capture,
      NormalizedAmountCaptureValueSource(
        :final RegExpCaptureValueSource capture,
      ) =>
        capture,
      _ => null,
    };
    if (source is ComposedValueSource) {
      final RegExpCaptureValueSource? unresolved = source.parts
          .whereType<RegExpCaptureValueSource>()
          .where(
            (RegExpCaptureValueSource part) => part.resolve(context) == null,
          )
          .firstOrNull;
      if (unresolved != null) {
        return _unresolvedValueSourceMessage(unresolved, context);
      }
    }
    if (capture == null) {
      return 'Could not set ${target.name}: the value source did not resolve.';
    }
    final String match = capture.matchIndex == null
        ? ''
        : ' in match #${capture.matchIndex! + 1}';
    final String extractorName =
        context.extractorNames[capture.extractorId] ?? capture.extractorId;
    return 'Could not set ${target.name}: capture "${capture.captureName}" '
        'from extractor "$extractorName"$match did not resolve.';
  }

  TransactionFieldSourceKind _sourceKind(ValueSource source) {
    if (source is LiteralValueSource) {
      return TransactionFieldSourceKind.literal;
    }
    if (source is ComposedValueSource) {
      return TransactionFieldSourceKind.literal;
    }
    if (source is RegExpCaptureValueSource) {
      return TransactionFieldSourceKind.extractorCapture;
    }
    if (source is CurrencyCaptureValueSource) {
      return TransactionFieldSourceKind.extractorCapture;
    }
    if (source is DateTimeCaptureValueSource) {
      return TransactionFieldSourceKind.extractorCapture;
    }
    if (source is NormalizedAmountCaptureValueSource) {
      return TransactionFieldSourceKind.extractorCapture;
    }
    if (source is FireflyResourceValueSource) {
      return TransactionFieldSourceKind.fireflyResource;
    }
    return TransactionFieldSourceKind.literal;
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'type': type,
    'target': target.name,
    'valueSource': valueSource.toJson(),
  };

  factory SetTransactionFieldAction.fromJson(Map<String, dynamic> json) {
    return SetTransactionFieldAction(
      target: TransactionField.values.byName(json['target'] as String),
      valueSource: ValueSource.fromJson(
        json['valueSource'] as Map<String, dynamic>,
      ),
    );
  }
}
