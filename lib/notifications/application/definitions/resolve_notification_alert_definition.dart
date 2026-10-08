import 'package:waterflyiii/notifications/application/stores/notification_definition_store.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';

enum ResolveNotificationAlertDefinitionStatus {
  resolved,
  notFound,
  ambiguous,
  failed,
}

class ResolveNotificationAlertDefinitionResult {
  const ResolveNotificationAlertDefinitionResult(
    this.status, {
    this.definition,
    this.error,
    this.stackTrace,
  });

  final ResolveNotificationAlertDefinitionStatus status;
  final NotificationDefinition? definition;
  final Object? error;
  final StackTrace? stackTrace;

  bool get succeeded =>
      status == ResolveNotificationAlertDefinitionStatus.resolved;
}

class ResolveNotificationAlertDefinition {
  const ResolveNotificationAlertDefinition(this._store);

  final NotificationDefinitionStore _store;

  Future<ResolveNotificationAlertDefinitionResult> call(
    NotificationAlert alert,
  ) async {
    final List<NotificationDefinition> definitions;
    try {
      definitions = await _store.load();
    } catch (error, stackTrace) {
      return ResolveNotificationAlertDefinitionResult(
        ResolveNotificationAlertDefinitionStatus.failed,
        error: error,
        stackTrace: stackTrace,
      );
    }

    final String? definitionId = alert.definitionId;
    if (definitionId != null) {
      final NotificationDefinition? definition = definitions
          .cast<NotificationDefinition?>()
          .firstWhere(
            (NotificationDefinition? candidate) =>
                candidate?.id == definitionId,
            orElse: () => null,
          );
      if (definition != null) {
        return ResolveNotificationAlertDefinitionResult(
          ResolveNotificationAlertDefinitionStatus.resolved,
          definition: definition,
        );
      }
    }

    final String? applicationId = alert.applicationId;
    if (applicationId == null) {
      return const ResolveNotificationAlertDefinitionResult(
        ResolveNotificationAlertDefinitionStatus.notFound,
      );
    }
    final List<NotificationDefinition> candidates = definitions
        .where(
          (NotificationDefinition definition) =>
              definition.applicationId == applicationId,
        )
        .toList();
    if (candidates.isEmpty) {
      return const ResolveNotificationAlertDefinitionResult(
        ResolveNotificationAlertDefinitionStatus.notFound,
      );
    }
    if (candidates.length > 1) {
      return const ResolveNotificationAlertDefinitionResult(
        ResolveNotificationAlertDefinitionStatus.ambiguous,
      );
    }
    return ResolveNotificationAlertDefinitionResult(
      ResolveNotificationAlertDefinitionStatus.resolved,
      definition: candidates.single,
    );
  }
}
