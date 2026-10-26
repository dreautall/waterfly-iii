enum RegExpSafetyIssue { nestedQuantifier, repeatedWildcard }

class RegExpSafety {
  const RegExpSafety._();

  static Set<RegExpSafetyIssue> analyze(String source) {
    final String normalized = _withoutEscapesAndCharacterClasses(source);
    return <RegExpSafetyIssue>{
      if (_hasNestedQuantifier(normalized)) RegExpSafetyIssue.nestedQuantifier,
      if (_hasRepeatedWildcard(normalized)) RegExpSafetyIssue.repeatedWildcard,
    };
  }

  static bool _hasNestedQuantifier(String source) {
    final List<_GroupState> groups = <_GroupState>[];
    for (int index = 0; index < source.length; index++) {
      final String character = source[index];
      if (character == '(') {
        groups.add(const _GroupState());
        continue;
      }
      if (character == ')' && groups.isNotEmpty) {
        final _GroupState group = groups.removeLast();
        final int quantifierIndex = _nextQuantifierIndex(source, index + 1);
        if (group.containsQuantifier && quantifierIndex >= 0) return true;
        if ((group.containsQuantifier || quantifierIndex >= 0) &&
            groups.isNotEmpty) {
          groups[groups.length - 1] = groups.last.withQuantifier();
        }
        continue;
      }
      if (_isQuantifierAt(source, index) && groups.isNotEmpty) {
        groups[groups.length - 1] = groups.last.withQuantifier();
      }
    }
    return false;
  }

  static bool _hasRepeatedWildcard(String source) {
    final RegExp wildcard = RegExp(r'\.(?:\*|\+)[?+]?');
    final List<RegExpMatch> matches = wildcard.allMatches(source).toList();
    for (int index = 1; index < matches.length; index++) {
      final String between = source.substring(
        matches[index - 1].end,
        matches[index].start,
      );
      if (!between.contains('(') &&
          !between.contains(')') &&
          !between.contains('|')) {
        return true;
      }
    }
    return false;
  }

  static int _nextQuantifierIndex(String source, int start) {
    if (start >= source.length) return -1;
    return _isQuantifierAt(source, start) ? start : -1;
  }

  static bool _isQuantifierAt(String source, int index) {
    final String character = source[index];
    return character == '*' ||
        character == '+' ||
        character == '{' ||
        (character == '?' && (index == 0 || source[index - 1] != '('));
  }

  static String _withoutEscapesAndCharacterClasses(String source) {
    final StringBuffer result = StringBuffer();
    bool escaped = false;
    bool inCharacterClass = false;
    for (int index = 0; index < source.length; index++) {
      final String character = source[index];
      if (escaped) {
        result.write('x');
        escaped = false;
        continue;
      }
      if (character == r'\') {
        escaped = true;
        continue;
      }
      if (inCharacterClass) {
        if (character == ']') inCharacterClass = false;
        continue;
      }
      if (character == '[') {
        inCharacterClass = true;
        result.write('x');
        continue;
      }
      result.write(character);
    }
    return result.toString();
  }
}

class _GroupState {
  const _GroupState({this.containsQuantifier = false});

  final bool containsQuantifier;

  _GroupState withQuantifier() => const _GroupState(containsQuantifier: true);
}
