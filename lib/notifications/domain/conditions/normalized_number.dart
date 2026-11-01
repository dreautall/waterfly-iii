String? normalizeNumber(String value) {
  String normalized = value.trim().replaceAll(RegExp(r"[\s\u00a0\u202f']"), '');
  if (!RegExp(r'^[+-]?(?:\d+(?:[.,]\d+)*|[.,]\d+)$').hasMatch(normalized)) {
    return null;
  }

  String sign = '';
  if (normalized.startsWith('+') || normalized.startsWith('-')) {
    sign = normalized[0];
    normalized = normalized.substring(1);
  }

  final int lastComma = normalized.lastIndexOf(',');
  final int lastPeriod = normalized.lastIndexOf('.');
  if (lastComma != -1 && lastPeriod != -1) {
    final int decimalSeparator = lastComma > lastPeriod
        ? lastComma
        : lastPeriod;
    final String integer = normalized
        .substring(0, decimalSeparator)
        .replaceAll(RegExp(r'[.,]'), '');
    final String fraction = normalized.substring(decimalSeparator + 1);
    normalized = '$integer.$fraction';
  } else {
    final String separator = lastComma != -1 ? ',' : '.';
    if (lastComma != -1 || lastPeriod != -1) {
      final List<String> groups = normalized.split(separator);
      final bool usesGrouping =
          groups.length > 1 &&
          groups.first.isNotEmpty &&
          groups.skip(1).every((String group) => group.length == 3);
      if (usesGrouping) {
        normalized = groups.join();
      } else {
        normalized = '${groups.take(groups.length - 1).join()}.${groups.last}';
      }
    }
  }

  final String canonical = '$sign$normalized';
  final num? parsed = num.tryParse(canonical);
  return parsed == null || !parsed.isFinite ? null : canonical;
}

num? parseNormalizedNumber(String value) {
  final String? normalized = normalizeNumber(value);
  return normalized == null ? null : num.tryParse(normalized);
}
