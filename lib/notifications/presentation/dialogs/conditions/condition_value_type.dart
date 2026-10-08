enum ConditionValueType {
  text,
  number,
  dateTime,
  date,
  time;

  static ConditionValueType parse(String value) {
    final String normalized = value.trim();
    if (num.tryParse(normalized.replaceAll(',', '.')) != null) return number;
    if (RegExp(r'^\d{4}-\d{2}-\d{2}T').hasMatch(normalized) &&
        DateTime.tryParse(normalized) != null) {
      return dateTime;
    }
    if (RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(normalized)) return date;
    if (RegExp(
      r'^([01]\d|2[0-3]):[0-5]\d(?::[0-5]\d)?$',
    ).hasMatch(normalized)) {
      return time;
    }
    return text;
  }

  bool get isOrdered => this != text;

  bool isValid(String value) => switch (this) {
    text => value.trim().isNotEmpty,
    number =>
      num.tryParse(value.trim().replaceAll(',', '.'))?.isFinite ?? false,
    dateTime =>
      RegExp(r'^\d{4}-\d{2}-\d{2}T').hasMatch(value.trim()) &&
          DateTime.tryParse(value.trim()) != null,
    date =>
      RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value.trim()) &&
          DateTime.tryParse(value.trim()) != null,
    time => RegExp(
      r'^([01]\d|2[0-3]):[0-5]\d(?::[0-5]\d)?$',
    ).hasMatch(value.trim()),
  };
}
