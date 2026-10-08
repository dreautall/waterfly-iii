import 'dart:io';

import 'package:appcheck/appcheck.dart';
import 'package:waterflyiii/notifications/application/resources/application_name_resolver.dart';

class InstalledApplicationNameResolver implements ApplicationNameResolver {
  const InstalledApplicationNameResolver();

  @override
  Future<String?> resolve(String applicationId) async {
    if (!Platform.isAndroid) return null;
    final AppInfo? application = await AppCheck().checkAvailability(
      applicationId,
    );
    final String? name = application?.appName?.trim();
    return name?.isNotEmpty ?? false ? name : null;
  }
}
