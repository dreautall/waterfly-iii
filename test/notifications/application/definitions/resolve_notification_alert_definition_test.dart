import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/definitions/resolve_notification_alert_definition.dart';
import 'package:waterflyiii/notifications/application/stores/notification_definition_store.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import '../../support/in_memory_notification_stores.dart';

void main() {
  const NotificationDefinition first = NotificationDefinition(
    id: 'first',
    applicationId: 'com.example.bank',
    name: 'First',
    extractors: <RegExpDefinition>[],
    rules: <NotificationRule>[],
  );
  const NotificationDefinition second = NotificationDefinition(
    id: 'second',
    applicationId: 'com.example.bank',
    name: 'Second',
    extractors: <RegExpDefinition>[],
    rules: <NotificationRule>[],
  );

  test('prefers an exact definition id', () async {
    final ResolveNotificationAlertDefinitionResult result =
        await ResolveNotificationAlertDefinition(
          InMemoryNotificationDefinitionStore(<NotificationDefinition>[
            first,
            second,
          ]),
        )(_alert(definitionId: second.id, applicationId: first.applicationId));

    expect(result.status, ResolveNotificationAlertDefinitionStatus.resolved);
    expect(result.definition, same(second));
  });

  test('falls back to a unique application definition', () async {
    final ResolveNotificationAlertDefinitionResult result =
        await ResolveNotificationAlertDefinition(
          InMemoryNotificationDefinitionStore(<NotificationDefinition>[first]),
        )(_alert(applicationId: first.applicationId));

    expect(result.status, ResolveNotificationAlertDefinitionStatus.resolved);
    expect(result.definition, same(first));
  });

  test('reports ambiguous application definitions', () async {
    final ResolveNotificationAlertDefinitionResult result =
        await ResolveNotificationAlertDefinition(
          InMemoryNotificationDefinitionStore(<NotificationDefinition>[
            first,
            second,
          ]),
        )(_alert(applicationId: first.applicationId));

    expect(result.status, ResolveNotificationAlertDefinitionStatus.ambiguous);
    expect(result.definition, isNull);
  });

  test('preserves definition load failures', () async {
    final ResolveNotificationAlertDefinitionResult result =
        await ResolveNotificationAlertDefinition(_FailingDefinitionStore())(
          _alert(applicationId: first.applicationId),
        );

    expect(result.status, ResolveNotificationAlertDefinitionStatus.failed);
    expect(result.error, isA<StateError>());
    expect(result.stackTrace, isNotNull);
  });
}

NotificationAlert _alert({String? definitionId, String? applicationId}) =>
    NotificationAlert.failure(
      kind: NotificationAlertKind.definitionInvalid,
      operation: 'Resolve definition',
      message: 'Failure',
      definitionId: definitionId,
      applicationId: applicationId,
    );

class _FailingDefinitionStore implements NotificationDefinitionStore {
  @override
  Future<List<NotificationDefinition>> load() =>
      Future<List<NotificationDefinition>>.error(
        StateError('Could not load definitions'),
      );

  @override
  Future<void> save(List<NotificationDefinition> definitions) async {}
}
