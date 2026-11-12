import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/presentation/shared/message_status_card.dart';

extension NotificationDefinitionStatusDisplay on NotificationDefinitionStatus {
  String label(BuildContext context) => switch (this) {
    NotificationDefinitionStatus.notConfigured =>
      S.of(context).notificationsDefinitionNotConfigured,
    NotificationDefinitionStatus.needsSetup =>
      S.of(context).notificationsDefinitionNeedsSetup,
    NotificationDefinitionStatus.needsReview =>
      S.of(context).notificationsDefinitionNeedsReview,
    NotificationDefinitionStatus.ready =>
      S.of(context).notificationsDefinitionReady,
  };

  String message(BuildContext context) => switch (this) {
    NotificationDefinitionStatus.notConfigured =>
      S.of(context).notificationsDefinitionNotConfiguredMessage,
    NotificationDefinitionStatus.needsSetup =>
      S.of(context).notificationsDefinitionNeedsSetupMessage,
    NotificationDefinitionStatus.needsReview =>
      S.of(context).notificationsDefinitionNeedsReviewMessage,
    NotificationDefinitionStatus.ready => '',
  };

  MessageStatus get messageStatus => switch (this) {
    NotificationDefinitionStatus.notConfigured => MessageStatus.informational,
    NotificationDefinitionStatus.needsSetup => MessageStatus.error,
    NotificationDefinitionStatus.needsReview => MessageStatus.review,
    NotificationDefinitionStatus.ready => MessageStatus.success,
  };
}
