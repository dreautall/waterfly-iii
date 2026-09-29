abstract interface class ApplicationNameResolver {
  Future<String?> resolve(String applicationId);
}
