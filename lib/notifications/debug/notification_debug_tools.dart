import 'package:flutter/widgets.dart';
import 'package:waterflyiii/notifications/notification_feature_scope.dart';

typedef NotificationDebugToolsFactory =
    NotificationDebugTools Function(NotificationFeatureScope scope);

abstract interface class NotificationDebugTools {
  Widget buildTestLabPage();
}
