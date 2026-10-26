import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/transactions/firefly_resource_reference.dart';

class TransactionPatch {
  const TransactionPatch(
    this.values, {
    this.tags = const <String>[],
    this.displayValues = const <TransactionField, String>{},
    this.currencyCodes = const <TransactionField, String>{},
    this.resourceReferences =
        const <TransactionField, FireflyResourceReference>{},
  });

  final Map<TransactionField, String> values;
  final List<String> tags;
  final Map<TransactionField, String> displayValues;
  final Map<TransactionField, String> currencyCodes;
  final Map<TransactionField, FireflyResourceReference> resourceReferences;

  factory TransactionPatch.fromJson(
    Map<String, dynamic> json,
  ) => TransactionPatch(
    (json['values'] as Map<String, dynamic>).map(
      (String key, dynamic value) => MapEntry<TransactionField, String>(
        TransactionField.values.byName(key),
        value as String,
      ),
    ),
    tags: (json['tags'] as List<dynamic>? ?? <dynamic>[]).cast<String>(),
    displayValues:
        (json['displayValues'] as Map<String, dynamic>? ?? <String, dynamic>{})
            .map(
              (String key, dynamic value) => MapEntry<TransactionField, String>(
                TransactionField.values.byName(key),
                value as String,
              ),
            ),
    currencyCodes:
        (json['currencyCodes'] as Map<String, dynamic>? ?? <String, dynamic>{})
            .map(
              (String key, dynamic value) => MapEntry<TransactionField, String>(
                TransactionField.values.byName(key),
                value as String,
              ),
            ),
    resourceReferences:
        (json['resourceReferences'] as Map<String, dynamic>? ??
                <String, dynamic>{})
            .map(
              (String key, dynamic value) =>
                  MapEntry<TransactionField, FireflyResourceReference>(
                    TransactionField.values.byName(key),
                    FireflyResourceReference.fromJson(
                      value as Map<String, dynamic>,
                    ),
                  ),
            ),
  );

  bool get isEmpty => values.isEmpty && tags.isEmpty;

  String displayValue(TransactionField field) =>
      displayValues[field] ?? values[field] ?? '';

  factory TransactionPatch.merge(Iterable<TransactionPatch?> patches) {
    final Map<TransactionField, String> values = <TransactionField, String>{};
    final Map<TransactionField, String> displayValues =
        <TransactionField, String>{};
    final Map<TransactionField, String> currencyCodes =
        <TransactionField, String>{};
    final Map<TransactionField, FireflyResourceReference> resourceReferences =
        <TransactionField, FireflyResourceReference>{};
    final List<String> tags = <String>[];
    for (final TransactionPatch? patch in patches) {
      if (patch == null) continue;
      for (final TransactionField field in patch.values.keys) {
        displayValues.remove(field);
        currencyCodes.remove(field);
        resourceReferences.remove(field);
      }
      values.addAll(patch.values);
      displayValues.addAll(patch.displayValues);
      currencyCodes.addAll(patch.currencyCodes);
      resourceReferences.addAll(patch.resourceReferences);
      for (final String tag in patch.tags) {
        if (!tags.any(
          (String existing) => existing.toLowerCase() == tag.toLowerCase(),
        )) {
          tags.add(tag);
        }
      }
    }
    return TransactionPatch(
      values,
      tags: tags,
      displayValues: displayValues,
      currencyCodes: currencyCodes,
      resourceReferences: resourceReferences,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'values': values.map(
      (TransactionField field, String value) =>
          MapEntry<String, String>(field.name, value),
    ),
    'tags': tags,
    'displayValues': displayValues.map(
      (TransactionField field, String value) =>
          MapEntry<String, String>(field.name, value),
    ),
    'currencyCodes': currencyCodes.map(
      (TransactionField field, String value) =>
          MapEntry<String, String>(field.name, value),
    ),
    'resourceReferences': resourceReferences.map(
      (TransactionField field, FireflyResourceReference reference) =>
          MapEntry<String, Map<String, dynamic>>(
            field.name,
            reference.toJson(),
          ),
    ),
  };
}
