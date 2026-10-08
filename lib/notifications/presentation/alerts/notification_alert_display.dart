import 'package:flutter/widgets.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';

extension NotificationAlertKindDisplay on NotificationAlertKind {
  String displayLabel(BuildContext context) => switch (this) {
    NotificationAlertKind.migrationFailed =>
      S.of(context).notificationsAlertsKindMigrationFailed,
    NotificationAlertKind.migrationNeedsReview =>
      S.of(context).notificationsAlertsKindMigrationNeedsReview,
    NotificationAlertKind.definitionInvalid =>
      S.of(context).notificationsAlertsKindDefinitionInvalid,
    NotificationAlertKind.evaluationFailed =>
      S.of(context).notificationsAlertsKindEvaluationFailed,
    NotificationAlertKind.actionFailed =>
      S.of(context).notificationsAlertsKindActionFailed,
  };
}

extension NotificationMigrationIssueDisplay on NotificationMigrationIssue {
  String title(BuildContext context) => switch (this) {
    NotificationMigrationIssue.automaticCreationPaused =>
      S.of(context).notificationsMigrationAutomaticPausedTitle,
    NotificationMigrationIssue.missingAutomaticAccount =>
      S.of(context).notificationsMigrationMissingAccountTitle,
    NotificationMigrationIssue.missingApplicationName =>
      S.of(context).notificationsMigrationMissingApplicationNameTitle,
    NotificationMigrationIssue.missingSettings =>
      S.of(context).notificationsMigrationMissingSettingsTitle,
    NotificationMigrationIssue.invalidRegularExpression =>
      S.of(context).notificationsMigrationInvalidRegexTitle,
    NotificationMigrationIssue.expressionDoesNotMatchSample =>
      S.of(context).notificationsMigrationRegexMismatchTitle,
    NotificationMigrationIssue.ambiguousAmount =>
      S.of(context).notificationsMigrationAmbiguousAmountTitle,
    NotificationMigrationIssue.amountNotFound =>
      S.of(context).notificationsMigrationAmountNotFoundTitle,
    NotificationMigrationIssue.sampleMissing =>
      S.of(context).notificationsMigrationSampleMissingTitle,
    NotificationMigrationIssue.currencyUnresolved =>
      S.of(context).notificationsMigrationCurrencyUnresolvedTitle,
    NotificationMigrationIssue.conversionFailed =>
      S.of(context).notificationsMigrationConversionFailedTitle,
  };

  String message(BuildContext context) => switch (this) {
    NotificationMigrationIssue.automaticCreationPaused =>
      S.of(context).notificationsMigrationAutomaticPausedMessage,
    NotificationMigrationIssue.missingAutomaticAccount =>
      S.of(context).notificationsMigrationMissingAccountMessage,
    NotificationMigrationIssue.missingApplicationName =>
      S.of(context).notificationsMigrationMissingApplicationNameMessage,
    NotificationMigrationIssue.missingSettings =>
      S.of(context).notificationsMigrationMissingSettingsMessage,
    NotificationMigrationIssue.invalidRegularExpression =>
      S.of(context).notificationsMigrationInvalidRegexMessage,
    NotificationMigrationIssue.expressionDoesNotMatchSample =>
      S.of(context).notificationsMigrationRegexMismatchMessage,
    NotificationMigrationIssue.ambiguousAmount =>
      S.of(context).notificationsMigrationAmbiguousAmountMessage,
    NotificationMigrationIssue.amountNotFound =>
      S.of(context).notificationsMigrationAmountNotFoundMessage,
    NotificationMigrationIssue.sampleMissing =>
      S.of(context).notificationsMigrationSampleMissingMessage,
    NotificationMigrationIssue.currencyUnresolved =>
      S.of(context).notificationsMigrationCurrencyUnresolvedMessage,
    NotificationMigrationIssue.conversionFailed =>
      S.of(context).notificationsMigrationConversionFailedMessage,
  };
}
