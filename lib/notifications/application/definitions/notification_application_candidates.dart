abstract interface class NotificationManifestPackageSource {
  Future<Iterable<String>> loadPackageIds();
}

abstract interface class NotificationHistoryPackageSource {
  Future<Iterable<String>> loadPackageIds();
}

class NotificationApplicationCandidates {
  NotificationApplicationCandidates({
    required NotificationManifestPackageSource manifestPackageSource,
    required NotificationHistoryPackageSource historyPackageSource,
  }) : _manifestPackageSource = manifestPackageSource,
       _historyPackageSource = historyPackageSource;

  final NotificationManifestPackageSource _manifestPackageSource;
  final NotificationHistoryPackageSource _historyPackageSource;

  Future<Set<String>> loadPackageIds() async {
    final Set<String> packageIds = <String>{};
    try {
      packageIds.addAll(await _manifestPackageSource.loadPackageIds());
    } catch (_) {
      // Recent notification history remains a useful source when the native
      // manifest query list cannot be loaded.
    }
    try {
      packageIds.addAll(await _historyPackageSource.loadPackageIds());
    } catch (_) {
      // History availability must not prevent adding an installed app.
    }
    return packageIds;
  }

  List<T> filterInstalled<T>(
    Iterable<T> installedApplications,
    String Function(T application) packageId,
    Set<String> eligiblePackageIds,
  ) {
    return installedApplications
        .where(
          (T application) =>
              eligiblePackageIds.contains(packageId(application)),
        )
        .toList();
  }
}
