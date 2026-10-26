import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/application/shared/json_equality.dart';

class NotificationExtractorDraft {
  NotificationExtractorDraft.fromExtractor(this._original)
    : name = _original.definitionName,
      description = _original.description,
      source = _original.regExpSource;

  RegExpDefinition _original;
  String name;
  String description;
  String source;

  RegExpDefinition build() =>
      _original.copyWith(name: name, description: description, source: source);

  bool get isDirty =>
      !jsonStructuresEqual(build().toJson(), _original.toJson());

  void acceptChanges() {
    _original = build();
  }
}
