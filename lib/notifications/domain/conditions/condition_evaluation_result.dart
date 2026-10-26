class ConditionEvaluationResult {
  const ConditionEvaluationResult({
    required this.matches,
    this.failureReason,
    this.isDiagnosticFailure = false,
  });

  final bool matches;
  final String? failureReason;
  final bool isDiagnosticFailure;
}
