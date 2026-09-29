import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:logging/logging.dart';
import 'package:material_ui/material_ui.dart';
import 'package:notifications_listener_service/notifications_listener_service.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:waterflyiii/app.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/data/database/database_provider.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/notifications/application/listeners/notification_listener_health_service.dart';
import 'package:waterflyiii/notifications/application/listeners/notification_listener_orchestrator.dart';
import 'package:waterflyiii/notifications/application/listeners/notification_listener_status.dart';
import 'package:waterflyiii/notifications/application/processing/notification_definition_processor.dart';
import 'package:waterflyiii/notifications/application/processing/notification_history_outcome_recorder.dart';
import 'package:waterflyiii/notifications/application/processing/notification_transaction_intent_adapter.dart';
import 'package:waterflyiii/notifications/application/processing/notification_transaction_intent_executor.dart';
import 'package:waterflyiii/notifications/data/listeners/platform_notification_listener_health_notifier.dart';
import 'package:waterflyiii/notifications/data/migrations/platform_notification_migration_review_notifier.dart';
import 'package:waterflyiii/notifications/data/platform/platform_notification_formatting_preferences.dart';
import 'package:waterflyiii/notifications/data/database/notification_database_provider.dart';
import 'package:waterflyiii/notifications/data/repositories/notification_definition_repository.dart';
import 'package:waterflyiii/notifications/data/repositories/notification_history_repository.dart';
import 'package:waterflyiii/notifications/data/repositories/sqlcipher_notification_alert_store.dart';
import 'package:waterflyiii/notifications/data/repositories/sqlcipher_notification_history_store.dart';
import 'package:waterflyiii/notifications/data/repositories/shared_preferences_notification_listener_health_store.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_formatting_preferences.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/evaluation/notification_rule_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/history/notification_processing_outcome.dart';
import 'package:waterflyiii/notifications/domain/notification_id.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_intent.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_action_group.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_patch.dart';
import 'package:waterflyiii/notifications/presentation/definitions/pages/notification_definitions_page.dart';
import 'package:waterflyiii/pages/transaction.dart';
import 'package:waterflyiii/settings.dart';

final Logger log = Logger("NotificationListener");
final DatabaseProvider<Database> _notificationDatabase =
    NotificationDatabaseProvider.create();

class NotificationTransaction {
  NotificationTransaction(
    this.appName,
    this.title,
    this.body,
    this.date, {
    required this.intent,
    this.historyEntryId,
  });

  final String appName;
  final String title;
  final String body;
  final DateTime date;
  final TransactionIntent intent;
  final String? historyEntryId;

  factory NotificationTransaction.fromJson(Map<String, dynamic> json) {
    final String appName = json['appName'] as String;
    final String title = json['title'] as String;
    final String body = json['body'] as String;
    final Object? rawIntent = json['intent'];
    final TransactionIntent intent = rawIntent == null
        ? TransactionIntent(
            mode: TransactionCreationMode.prompt,
            patch: TransactionPatch(<TransactionField, String>{
              TransactionField.title: title,
              TransactionField.notes: body,
            }),
          )
        : TransactionIntent.fromJson(
            Map<String, dynamic>.from(rawIntent as Map<Object?, Object?>),
          );
    return NotificationTransaction(
      appName,
      title,
      body,
      DateTime.parse(json['date'] as String),
      intent: intent,
      historyEntryId: json['historyEntryId'] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'appName': appName,
    'title': title,
    'body': body,
    'date': date.toIso8601String(),
    'intent': intent.toJson(),
    if (historyEntryId != null) 'historyEntryId': historyEntryId,
  };
}

Future<NotificationListenerStatus> nlStatus() async {
  if (Platform.isAndroid) {
    return NotificationListenerStatus(
      await NotificationServicePlugin.instance.isServicePermissionGranted(),
      await NotificationServicePlugin.instance.isServiceRunning(),
      await FlutterLocalNotificationsPlugin()
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >()!
              .areNotificationsEnabled() ??
          false,
    );
  } else {
    return const NotificationListenerStatus(false, false, false);
  }
}

@pragma('vm:entry-point')
void nlCallback() {
  if (!Platform.isAndroid) {
    return;
  }
  log.finest(() => "nlCallback()");
  NotificationServicePlugin.instance.executeNotificationListener((
    NotificationEvent? evt,
  ) async {
    WidgetsFlutterBinding.ensureInitialized();

    if (evt == null || evt.packageName == null) {
      return;
    }
    if (evt.packageName?.startsWith("com.dreautall.waterflyiii") ?? false) {
      return;
    }
    // if (evt.state == NotificationState.remove) {
    if (evt.state != NotificationState.post) {
      return;
    }
    final String deliveryId = evt.key?.trim().isNotEmpty ?? false
        ? evt.key!.trim()
        : newNotificationId();

    final NotificationContext notification = NotificationContext(
      applicationId: evt.packageName,
      deliveryId: deliveryId,
      title: evt.title ?? '',
      body: evt.text ?? '',
      receivedAt: DateTime.tryParse(evt.postTime ?? '') ?? DateTime.now(),
    );
    if (notification.title.trim().isEmpty || notification.body.trim().isEmpty) {
      log.finer(
        () =>
            'nlCallback(${notification.applicationId}): ignored incomplete notification',
      );
      return;
    }
    log.finer(
      () =>
          'nlCallback(${notification.applicationId}): processing notification',
    );
    await _notificationListenerOrchestrator().process(notification);
  });
}

NotificationListenerOrchestrator
_notificationListenerOrchestrator() => NotificationListenerOrchestrator(
  definitionProcessing: const _ListenerDefinitionProcessing(),
  intentExecutor: NotificationTransactionIntentExecutor(
    automaticHandler: _executeAutomaticTransactionIntent,
    manualHandler: _showCreateTransactionPrompt,
    automaticCompletedHandler: (NotificationContext notification) {
      unawaited(_showCreatedTransactionNotification(notification));
      return Future<void>.value();
    },
    failureHandler: _recordIntentExecutionFailure,
  ),
  outcomeRecorder: NotificationHistoryOutcomeRecorder(
    NotificationHistoryRepository(
      SqlcipherNotificationHistoryStore(_notificationDatabase),
    ),
  ),
  onUnregistered: (NotificationContext notification) => log.finer(
    () =>
        'nlCallback(${notification.applicationId}): no notification definition',
  ),
);

Future<String> _executeAutomaticTransactionIntent(
  NotificationContext notification,
  TransactionIntent intent,
) async {
  final FireflyService fireflyService = FireflyService();
  if (!await fireflyService.signInFromStorage()) {
    throw const FormatException(
      'Automatic transaction creation requires authentication.',
    );
  }
  await fireflyService.tzHandler.setUseServerTime(
    await SettingsProvider.loadUseServerTime(),
  );
  final TransactionStore transaction =
      NotificationTransactionIntentAdapter.toStore(
        intent,
        fallbackDate: notification.receivedAt,
        transformDate: (DateTime date) =>
            fireflyService.tzHandler.notificationTXTime(date).toLocal(),
      );
  final Response<TransactionSingle> response = await fireflyService.api
      .v1TransactionsPost(body: transaction);
  if (!response.isSuccessful || response.body == null) {
    throw Exception(_transactionPostFailure(response));
  }
  log.fine(
    () =>
        'nlCallback(${notification.applicationId}): automatic transaction created',
  );
  return response.body!.data.id;
}

Future<void> _recordIntentExecutionFailure(
  NotificationContext notification,
  NotificationProcessingOutcome outcome,
  Object error,
  StackTrace stackTrace,
) async {
  log.severe(
    'Error executing notification transaction intent',
    error,
    stackTrace,
  );
  await SqlcipherNotificationAlertStore(_notificationDatabase).record(
    NotificationAlert.failure(
      kind: NotificationAlertKind.actionFailed,
      operation: 'Execute notification transaction intent',
      message: error.toString(),
      applicationId: notification.applicationId,
      definitionId: outcome.definition?.id,
      ruleId: outcome.rule?.id,
      ruleName: outcome.rule?.name,
      notification: notification,
    ),
  );
}

Future<void> _showCreatedTransactionNotification(
  NotificationContext notification,
) => FlutterLocalNotificationsPlugin().show(
  id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
  title: 'Transaction created',
  body: 'Transaction created based on notification ${notification.title}',
  notificationDetails: const NotificationDetails(
    android: AndroidNotificationDetails(
      'extract_transaction_created',
      'Transaction from Notification Created',
      channelDescription:
          'Notification that a transaction has been created from another notification.',
      importance: .low,
      priority: .low,
    ),
  ),
  payload: '',
);

Future<void> _showCreateTransactionPrompt(
  NotificationContext notification,
  TransactionIntent intent,
) => FlutterLocalNotificationsPlugin().show(
  id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
  title: 'Create Transaction?',
  body:
      'Click to create a transaction based on the notification ${notification.title}',
  notificationDetails: const NotificationDetails(
    android: AndroidNotificationDetails(
      'extract_transaction',
      'Create Transaction from Notification',
      channelDescription:
          'Notification asking to create a transaction from another notification.',
      importance: .low,
      priority: .low,
    ),
  ),
  payload: jsonEncode(
    NotificationTransaction(
      notification.applicationId!,
      notification.title,
      notification.body,
      notification.receivedAt,
      intent: intent,
      historyEntryId: notification.deliveryId,
    ),
  ),
);

Future<bool> linkNotificationTransactionHistory({
  required String historyEntryId,
  required String transactionId,
}) => NotificationHistoryRepository(
  SqlcipherNotificationHistoryStore(_notificationDatabase),
).linkTransaction(historyEntryId, transactionId);

String _transactionPostFailure(Response<TransactionSingle> response) {
  final String rawError = response.error?.toString() ?? '';
  try {
    final ValidationErrorResponse validationError =
        ValidationErrorResponse.fromJson(
          json.decode(rawError) as Map<String, dynamic>,
        );
    return 'Transaction creation failed: ${validationError.message}';
  } on FormatException {
    return 'Transaction creation failed: $rawError';
  } on TypeError {
    return 'Transaction creation failed: $rawError';
  }
}

Future<NotificationDefinitionProcessingResult> _processNotificationDefinitions(
  NotificationContext notification,
) async {
  final NotificationFormattingPreferences formattingPreferences =
      platformNotificationFormattingPreferences();
  await initializeDateFormatting(formattingPreferences.locale);
  final SqlcipherNotificationAlertStore alertStore =
      SqlcipherNotificationAlertStore(_notificationDatabase);
  final NotificationDefinitionRepository repository =
      NotificationDefinitionRepository.encryptedDatabase(
        _notificationDatabase,
        alertStore: alertStore,
      );
  final List<NotificationDefinition> registeredDefinitions;
  try {
    registeredDefinitions = (await repository.load())
        .where(
          (NotificationDefinition definition) =>
              definition.applicationId == notification.applicationId,
        )
        .toList();
    log.finer(
      () =>
          'nlCallback(${notification.applicationId}): loaded ${registeredDefinitions.length} matching definitions',
    );
  } catch (error, stackTrace) {
    log.severe('Error loading notification definitions', error, stackTrace);
    await _recordDefinitionLoadFailure();
    return const NotificationDefinitionProcessingResult(
      loadFailed: true,
      outcome: NotificationProcessingOutcome(
        status: NotificationProcessingOutcomeStatus.failed,
      ),
    );
  }

  await _recordSuccessfulDefinitionLoad();
  if (registeredDefinitions.isEmpty) {
    return const NotificationDefinitionProcessingResult(
      outcome: NotificationProcessingOutcome(
        status: NotificationProcessingOutcomeStatus.noMatch,
      ),
    );
  }

  try {
    final List<ProcessedNotificationDefinition> definitions =
        await NotificationDefinitionProcessor(
          repository,
          alertStore: alertStore,
          formattingPreferences: formattingPreferences,
        ).process(notification, definitions: registeredDefinitions);

    for (final ProcessedNotificationDefinition definition in definitions) {
      log.finer(
        () =>
            'nlCallback(${notification.applicationId}): evaluated ${definition.definition.id}',
      );
      final TransactionIntent? effectiveIntent =
          definition.evaluation.effectiveTransactionIntent;
      if (effectiveIntent != null) {
        log.finer(
          () =>
              'nlCallback(${notification.applicationId}): planned ${effectiveIntent.mode.name} transaction',
        );
      } else {
        for (final NotificationRuleEvaluationResult rule
            in definition.evaluation.ruleResults.values) {
          final TransactionIntent? intent = rule.transactionIntent;
          if (intent != null) {
            log.finer(
              () =>
                  'nlCallback(${notification.applicationId}): planned ${intent.mode.name} transaction',
            );
          }
        }
      }
    }
    final NotificationAlert? failure = (await alertStore.load())
        .where(
          (NotificationAlert alert) =>
              alert.notification?.deliveryId == notification.deliveryId,
        )
        .firstOrNull;
    final NotificationProcessingOutcome outcome = _recordedProcessingOutcome(
      registeredDefinitions: registeredDefinitions,
      processedDefinitions: definitions,
      failure: failure,
    );
    log.fine(
      () =>
          'nlCallback(${notification.applicationId}): processing completed with ${outcome.status.name}; '
          '${definitions.length} definitions evaluated',
    );
    return NotificationDefinitionProcessingResult(
      isRegistered: true,
      intent: failure == null
          ? definitions.firstOrNull?.evaluation.effectiveTransactionIntent
          : null,
      outcome: outcome,
    );
  } catch (error, stackTrace) {
    log.severe('Error evaluating notification definitions', error, stackTrace);
    return NotificationDefinitionProcessingResult(
      isRegistered: true,
      outcome: NotificationProcessingOutcome(
        status: NotificationProcessingOutcomeStatus.failed,
        failureMessage: error.toString(),
      ),
    );
  }
}

NotificationListenerHealthService _listenerHealthService() =>
    NotificationListenerHealthService(
      store: const SharedPreferencesNotificationListenerHealthStore(),
      definitionStore: NotificationDefinitionRepository.encryptedDatabase(
        _notificationDatabase,
      ),
      notifier: const PlatformNotificationListenerHealthNotifier(),
    );

Future<void> _recordDefinitionLoadFailure() async {
  try {
    await _listenerHealthService().recordFailure(DateTime.now());
  } catch (error, stackTrace) {
    log.severe(
      'Could not persist the notification listener health failure.',
      error,
      stackTrace,
    );
  }
}

Future<void> _recordSuccessfulDefinitionLoad() async {
  try {
    await _listenerHealthService().recordSuccessfulLoad(DateTime.now());
  } catch (error, stackTrace) {
    log.warning(
      'Could not update notification listener recovery state.',
      error,
      stackTrace,
    );
  }
}

NotificationProcessingOutcome _recordedProcessingOutcome({
  required List<NotificationDefinition> registeredDefinitions,
  required List<ProcessedNotificationDefinition> processedDefinitions,
  required NotificationAlert? failure,
}) {
  final NotificationDefinition? failedDefinition = failure?.definitionId == null
      ? null
      : registeredDefinitions
            .where(
              (NotificationDefinition definition) =>
                  definition.id == failure!.definitionId,
            )
            .firstOrNull;
  if (failure != null) {
    return NotificationProcessingOutcome(
      status: NotificationProcessingOutcomeStatus.failed,
      definition: failedDefinition == null
          ? null
          : NotificationHistoryReference(
              id: failedDefinition.id,
              name: failedDefinition.name,
            ),
      rule: failure.ruleId == null
          ? null
          : NotificationHistoryReference(
              id: failure.ruleId!,
              name: failure.ruleName ?? failure.ruleId!,
            ),
      failureMessage: failure.message,
    );
  }
  final ProcessedNotificationDefinition? processed =
      processedDefinitions.firstOrNull;
  final NotificationDefinition? definition =
      processed?.definition ?? registeredDefinitions.firstOrNull;
  if (processed == null || definition == null) {
    return NotificationProcessingOutcome(
      status: NotificationProcessingOutcomeStatus.noMatch,
      definition: definition == null
          ? null
          : NotificationHistoryReference(
              id: definition.id,
              name: definition.name,
            ),
    );
  }
  final String? selectedRuleId = processed.evaluation.selectedRuleId;
  final NotificationRule? rule = selectedRuleId == null
      ? null
      : definition.rules
            .where((NotificationRule rule) => rule.id == selectedRuleId)
            .firstOrNull;
  final NotificationRuleEvaluationResult? ruleEvaluation =
      selectedRuleId == null
      ? null
      : processed.evaluation.ruleResults[selectedRuleId];
  final List<NotificationActionGroup> matchingGroups = rule == null
      ? const <NotificationActionGroup>[]
      : rule.conditionalActionGroups
            .where(
              (NotificationActionGroup group) =>
                  ruleEvaluation?.conditionalGroups[group.id]?.matches ?? false,
            )
            .toList();
  final TransactionIntent? intent =
      processed.evaluation.effectiveTransactionIntent;
  return NotificationProcessingOutcome(
    status: selectedRuleId != null || intent != null
        ? NotificationProcessingOutcomeStatus.matched
        : NotificationProcessingOutcomeStatus.noMatch,
    definition: NotificationHistoryReference(
      id: definition.id,
      name: definition.name,
    ),
    rule: rule == null
        ? null
        : NotificationHistoryReference(id: rule.id, name: rule.name),
    conditionalActionGroups: matchingGroups
        .map(
          (NotificationActionGroup group) =>
              NotificationHistoryReference(id: group.id, name: group.name),
        )
        .toList(),
    transactionCreationMode: intent?.mode,
    hasTransactionIntent: intent != null,
    transactionPatch: intent?.patch,
  );
}

class _ListenerDefinitionProcessing
    implements NotificationDefinitionProcessing {
  const _ListenerDefinitionProcessing();

  @override
  Future<NotificationDefinitionProcessingResult> process(
    NotificationContext notification,
  ) => _processNotificationDefinitions(notification);
}

Future<void> nlNotificationTap(
  NotificationResponse notificationResponse,
) async {
  log.finest(() => "nlNotificationTap()");
  if (notificationResponse.payload?.isEmpty ?? true) {
    return;
  }
  if (notificationResponse.payload == notificationListenerHealthPayload ||
      notificationResponse.payload == notificationMigrationReviewPayload) {
    await navigatorKey.currentState!.push<void>(
      MaterialPageRoute<void>(
        builder: (BuildContext context) =>
            const NotificationDefinitionsPage(showAppBar: true),
      ),
    );
    return;
  }
  await showDialog(
    context: navigatorKey.currentState!.context,
    builder: (BuildContext context) => TransactionPage(
      notification: .fromJson(jsonDecode(notificationResponse.payload!)),
    ),
  );
}
