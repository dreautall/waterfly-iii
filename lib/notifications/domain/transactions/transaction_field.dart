enum TransactionField {
  title,
  amount,
  date,
  time,
  sourceAccount,
  destinationAccount,
  category,
  tag,
  notes,
  subscription,
  currency,
  piggyBank,
}

enum TransactionFieldValueType {
  text,
  amount,
  date,
  time,
  reference,
  references,
}

enum TransactionFieldValidationError { invalidAmount, invalidDate, invalidTime }

enum TransactionFieldSourceKind { literal, extractorCapture, fireflyResource }

enum FireflyResourceKind {
  account,
  category,
  tag,
  subscription,
  currency,
  piggyBank,
}

class TransactionFieldSpec {
  const TransactionFieldSpec({
    required this.valueType,
    required this.allowedSources,
    this.resourceKind,
  });

  final TransactionFieldValueType valueType;
  final Set<TransactionFieldSourceKind> allowedSources;
  final FireflyResourceKind? resourceKind;

  static TransactionFieldValidationError? validateValue(
    String value,
    TransactionFieldValueType type,
  ) {
    switch (type) {
      case TransactionFieldValueType.amount:
        final num? amount = num.tryParse(value.trim().replaceAll(',', '.'));
        return amount == null || !amount.isFinite
            ? TransactionFieldValidationError.invalidAmount
            : null;
      case TransactionFieldValueType.date:
        return DateTime.tryParse(value.trim()) == null
            ? TransactionFieldValidationError.invalidDate
            : null;
      case TransactionFieldValueType.time:
        return RegExp(
              r'^([01]\d|2[0-3]):[0-5]\d(?::[0-5]\d)?$',
            ).hasMatch(value.trim())
            ? null
            : TransactionFieldValidationError.invalidTime;
      case TransactionFieldValueType.text:
      case TransactionFieldValueType.reference:
      case TransactionFieldValueType.references:
        return null;
    }
  }

  static const Set<TransactionFieldSourceKind> _literalOrCapture =
      <TransactionFieldSourceKind>{
        TransactionFieldSourceKind.literal,
        TransactionFieldSourceKind.extractorCapture,
      };
  static const Set<TransactionFieldSourceKind> _literalOrResource =
      <TransactionFieldSourceKind>{
        TransactionFieldSourceKind.literal,
        TransactionFieldSourceKind.fireflyResource,
      };
  static const Set<TransactionFieldSourceKind> _resourceOnly =
      <TransactionFieldSourceKind>{TransactionFieldSourceKind.fireflyResource};
  static const Set<TransactionFieldSourceKind> _resourceOrCapture =
      <TransactionFieldSourceKind>{
        TransactionFieldSourceKind.extractorCapture,
        TransactionFieldSourceKind.fireflyResource,
      };

  static const Map<TransactionField, TransactionFieldSpec> values =
      <TransactionField, TransactionFieldSpec>{
        TransactionField.title: TransactionFieldSpec(
          valueType: TransactionFieldValueType.text,
          allowedSources: _literalOrCapture,
        ),
        TransactionField.amount: TransactionFieldSpec(
          valueType: TransactionFieldValueType.amount,
          allowedSources: _literalOrCapture,
        ),
        TransactionField.date: TransactionFieldSpec(
          valueType: TransactionFieldValueType.date,
          allowedSources: _literalOrCapture,
        ),
        TransactionField.time: TransactionFieldSpec(
          valueType: TransactionFieldValueType.time,
          allowedSources: _literalOrCapture,
        ),
        TransactionField.sourceAccount: TransactionFieldSpec(
          valueType: TransactionFieldValueType.reference,
          allowedSources: _literalOrResource,
          resourceKind: FireflyResourceKind.account,
        ),
        TransactionField.destinationAccount: TransactionFieldSpec(
          valueType: TransactionFieldValueType.reference,
          allowedSources: _literalOrResource,
          resourceKind: FireflyResourceKind.account,
        ),
        TransactionField.category: TransactionFieldSpec(
          valueType: TransactionFieldValueType.reference,
          allowedSources: _literalOrResource,
          resourceKind: FireflyResourceKind.category,
        ),
        TransactionField.tag: TransactionFieldSpec(
          valueType: TransactionFieldValueType.references,
          allowedSources: _literalOrResource,
          resourceKind: FireflyResourceKind.tag,
        ),
        TransactionField.notes: TransactionFieldSpec(
          valueType: TransactionFieldValueType.text,
          allowedSources: _literalOrCapture,
        ),
        TransactionField.subscription: TransactionFieldSpec(
          valueType: TransactionFieldValueType.reference,
          allowedSources: _resourceOnly,
          resourceKind: FireflyResourceKind.subscription,
        ),
        TransactionField.currency: TransactionFieldSpec(
          valueType: TransactionFieldValueType.reference,
          allowedSources: _resourceOrCapture,
          resourceKind: FireflyResourceKind.currency,
        ),
        TransactionField.piggyBank: TransactionFieldSpec(
          valueType: TransactionFieldValueType.reference,
          allowedSources: _resourceOnly,
          resourceKind: FireflyResourceKind.piggyBank,
        ),
      };
}
