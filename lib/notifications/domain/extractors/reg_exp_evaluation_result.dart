enum RegExpEvaluationFailure { invalidPattern, inputTooLong }

class RegExpEvaluationResult {
  const RegExpEvaluationResult({
    required this.hasMatches,
    required this.namedCaptures,
    this.positionalCaptures = const <int, List<String>>{},
    this.matches = const <RegExpMatch>[],
    this.error,
    this.failure,
  });

  final bool hasMatches;
  final Map<String, List<String>> namedCaptures;
  final Map<int, List<String>> positionalCaptures;
  final List<RegExpMatch> matches;
  final String? error;
  final RegExpEvaluationFailure? failure;

  bool get isPatternValid => failure != RegExpEvaluationFailure.invalidPattern;

  bool get hasEvaluationFailure => failure != null;

  List<String> capturesFor(String name) =>
      namedCaptures[name] ?? const <String>[];

  List<String> capturesForIndex(int index) =>
      positionalCaptures[index] ?? const <String>[];
}
