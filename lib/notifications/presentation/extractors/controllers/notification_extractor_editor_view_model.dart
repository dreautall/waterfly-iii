import 'package:flutter/foundation.dart';
import 'package:waterflyiii/notifications/application/extractors/notification_extractor_draft.dart';
import 'package:waterflyiii/notifications/application/shared/json_equality.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_sample.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_evaluation_result.dart';

class NotificationExtractorEditorViewModel extends ChangeNotifier {
  NotificationExtractorEditorViewModel({
    required RegExpDefinition extractor,
    required this.notificationContext,
    required this.isAdvancedMode,
    NotificationSample? sampleOverride,
    NotificationSample? definitionSample,
  }) : _extractor = extractor,
       _draft = NotificationExtractorDraft.fromExtractor(extractor),
       _sampleOverride = sampleOverride,
       _originalSampleOverride = definitionSample;

  final RegExpDefinition _extractor;
  final NotificationExtractorDraft _draft;
  final NotificationContext notificationContext;
  final bool isAdvancedMode;
  NotificationSample? _originalSampleOverride;
  NotificationSample? _sampleOverride;

  RegExpEvaluationResult? evaluation;
  String? _evaluatedSource;
  String? validationError;

  bool get isPropertyExtractor => switch (_extractor.predefinedType) {
    PredefinedRegExpDefinition.notificationTitle ||
    PredefinedRegExpDefinition.notificationMessage ||
    PredefinedRegExpDefinition.notificationDate => true,
    _ => false,
  };

  NotificationSample? get sampleOverride => _sampleOverride;
  NotificationSample get sample =>
      _sampleOverride ??
      NotificationSample(
        title: notificationContext.title,
        body: notificationContext.body,
        receivedAt: notificationContext.receivedAt,
      );

  bool get isDirty =>
      _draft.isDirty || !_sameSample(_sampleOverride, _originalSampleOverride);

  RegExpDefinition get currentExtractor => _draft.build();

  void updateSample(NotificationSample sample) {
    _sampleOverride = sample;
    evaluate();
  }

  void clearSampleOverride() {
    _sampleOverride = null;
    evaluate();
  }

  void evaluate() {
    evaluation = currentExtractor.evaluate(_evaluationContext);
    _evaluatedSource = _draft.source;
    notifyListeners();
  }

  void update({
    required String name,
    required String source,
    String? description,
  }) {
    _draft.name = name.trim();
    if (description != null) {
      _draft.description = description.trim();
    }
    if (_extractor.type == RegExpDefinitionType.custom) {
      _draft.source = source;
    }
    validationError = null;
    if (isAdvancedMode && !isPropertyExtractor) {
      evaluation = currentExtractor.evaluate(_evaluationContext);
      _evaluatedSource = _draft.source;
    } else if (_draft.source != _evaluatedSource) {
      evaluation = null;
    }
    notifyListeners();
  }

  RegExpDefinition? save() {
    if (_draft.name.isEmpty) {
      validationError = 'An extractor name is required.';
      notifyListeners();
      return null;
    }
    return _sampleOverride == null
        ? currentExtractor.withoutSampleOverride()
        : currentExtractor.copyWith(sampleOverride: _sampleOverride);
  }

  void acceptChanges() {
    _draft.acceptChanges();
    _originalSampleOverride = _sampleOverride;
    notifyListeners();
  }

  NotificationContext get _evaluationContext => NotificationContext(
    applicationId: notificationContext.applicationId,
    applicationName: notificationContext.applicationName,
    title: sample.title,
    body: sample.body,
    receivedAt: sample.receivedAt,
  );

  bool _sameSample(NotificationSample? left, NotificationSample? right) =>
      jsonStructuresEqual(left?.toJson(), right?.toJson());
}
