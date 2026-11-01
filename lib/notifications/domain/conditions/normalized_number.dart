num? parseNormalizedNumber(String value) =>
    num.tryParse(value.trim().replaceAll(',', '.'));
