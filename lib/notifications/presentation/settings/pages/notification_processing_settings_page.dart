import 'dart:typed_data';

import 'package:flutter/services.dart'
    show MissingPluginException, PlatformException;
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/application/listeners/notification_access_settings_launcher.dart';
import 'package:waterflyiii/notifications/application/settings/notification_processing_configuration_service.dart';
import 'package:waterflyiii/notifications/application/settings/notification_backup_file_gateway.dart';
import 'package:waterflyiii/notifications/application/settings/notification_processing_settings.dart';
import 'package:waterflyiii/notifications/application/stores/notification_alert_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_definition_store.dart';
import 'package:waterflyiii/notifications/application/stores/notification_history_store.dart';
import 'package:waterflyiii/notifications/presentation/settings/controllers/notification_processing_settings_view_model.dart';
import 'package:waterflyiii/notifications/presentation/shared/message_status_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_dialog.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_page_header.dart';
import 'package:waterflyiii/notifications/presentation/settings/widgets/notification_processing_settings_sections.dart';

class NotificationProcessingSettingsPage extends StatefulWidget {
  const NotificationProcessingSettingsPage({
    super.key,
    required this.definitionStore,
    required this.historyStore,
    required this.alertStore,
    required this.settingsStore,
    this.accessSettingsLauncher =
        const UnavailableNotificationAccessSettingsLauncher(),
    this.backupFileGateway = const UnavailableNotificationBackupFileGateway(),
  });

  final NotificationDefinitionStore definitionStore;
  final NotificationHistoryStore historyStore;
  final NotificationAlertStore alertStore;
  final NotificationProcessingSettingsStore settingsStore;
  final NotificationAccessSettingsLauncher accessSettingsLauncher;
  final NotificationBackupFileGateway backupFileGateway;

  @override
  State<NotificationProcessingSettingsPage> createState() =>
      _NotificationProcessingSettingsPageState();
}

class _NotificationProcessingSettingsPageState
    extends State<NotificationProcessingSettingsPage> {
  static final Logger _log = Logger('Notifications.ProcessingSettings');
  final ScrollController _scrollController = ScrollController();
  late final NotificationProcessingSettingsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = NotificationProcessingSettingsViewModel(
      definitionStore: widget.definitionStore,
      historyStore: widget.historyStore,
      alertStore: widget.alertStore,
      settingsStore: widget.settingsStore,
    );
    _viewModel.addListener(_onViewModelChanged);
    _viewModel.load();
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelChanged);
    _viewModel.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onViewModelChanged() {
    if (mounted) setState(() {});
  }

  Future<void> _updateSettings(NotificationProcessingSettings settings) async {
    final bool saved = await _viewModel.updateSettings(settings);
    if (!saved && mounted) {
      _showSnackBar(S.of(context).notificationsProcessingSettingsSaveFailure);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    extendBodyBehindAppBar: true,
    appBar: NotificationPageHeader(
      scrollController: _scrollController,
      title: Text(S.of(context).notificationsProcessingSettingsTitle),
    ),
    body: _body(context),
  );

  Widget _body(BuildContext context) {
    if (_viewModel.isLoading) {
      return Padding(
        padding: EdgeInsets.only(
          top: NotificationPageHeader.bodyTopInset(context),
        ),
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    if (_viewModel.loadError != null) {
      return Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          NotificationPageHeader.bodyTopInset(context),
          16,
          0,
        ),
        child: MessageStatusCard(
          status: MessageStatus.error,
          message: S.of(context).notificationsProcessingSettingsLoadFailure,
          actionLabel: MaterialLocalizations.of(
            context,
          ).refreshIndicatorSemanticLabel,
          onAction: _viewModel.load,
        ),
      );
    }
    final NotificationProcessingSettings settings = _viewModel.settings!;
    return ListView(
      controller: _scrollController,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        16,
        NotificationPageHeader.bodyTopInset(context),
        16,
        NotificationPageHeader.bodyBottomInset(context),
      ),
      children: <Widget>[
        NotificationSettingsSection(
          title: S.of(context).notificationsProcessingConfigurationTitle,
          description: S
              .of(context)
              .notificationsProcessingConfigurationDescription,
          children: <Widget>[
            NotificationSettingsActionCard(
              icon: Icons.backup_outlined,
              title: S.of(context).notificationsProcessingCreateBackup,
              subtitle: _viewModel.hasDefinitions
                  ? S.of(context).notificationsProcessingCreateBackupDescription
                  : S
                        .of(context)
                        .notificationsProcessingCreateBackupDisabledDescription,
              onTap: _viewModel.isBusy || !_viewModel.hasDefinitions
                  ? null
                  : _createBackup,
            ),
            NotificationSettingsActionCard(
              icon: Icons.restore_outlined,
              title: S.of(context).notificationsProcessingRestoreBackup,
              subtitle: S
                  .of(context)
                  .notificationsProcessingRestoreBackupDescription,
              onTap: _viewModel.isBusy ? null : _restoreBackup,
            ),
          ],
        ),
        const SizedBox(height: 24),
        NotificationSettingsSection(
          title: S.of(context).notificationsProcessingStoredDataTitle,
          description: S
              .of(context)
              .notificationsProcessingStoredDataDescription,
          children: <Widget>[
            NotificationStorageModeCard(
              value: settings.historyStorageMode,
              onChanged: (NotificationHistoryStorageMode value) =>
                  _updateSettings(settings.copyWith(historyStorageMode: value)),
            ),
            NotificationRetentionCard(
              value: settings.historyRetention,
              enabled:
                  settings.historyStorageMode !=
                  NotificationHistoryStorageMode.disabled,
              onChanged: (NotificationHistoryRetention value) =>
                  _updateSettings(settings.copyWith(historyRetention: value)),
            ),
            NotificationDangerActionGroup(
              title: S.of(context).notificationsProcessingClearStoredDataTitle,
              children: <Widget>[
                NotificationSettingsActionCard(
                  icon: Icons.history_toggle_off_outlined,
                  title: S.of(context).notificationsProcessingClearHistory,
                  subtitle: S
                      .of(context)
                      .notificationsProcessingClearHistoryDescription,
                  onTap: _viewModel.isBusy || !_viewModel.hasHistory
                      ? null
                      : _clearHistory,
                  destructive: true,
                ),
                NotificationSettingsActionCard(
                  icon: Icons.delete_sweep_outlined,
                  title: S.of(context).notificationsProcessingClearAlerts,
                  subtitle: S
                      .of(context)
                      .notificationsProcessingClearAlertsDescription,
                  onTap: _viewModel.isBusy || !_viewModel.hasAlerts
                      ? null
                      : _clearAlerts,
                  destructive: true,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),
        NotificationSettingsSection(
          title: S.of(context).notificationsProcessingOffboardingTitle,
          description: S
              .of(context)
              .notificationsProcessingOffboardingDescription,
          children: <Widget>[
            NotificationSettingsActionCard(
              icon: Icons.notifications_off_outlined,
              title: S.of(context).notificationsProcessingOpenAccessSettings,
              subtitle: S
                  .of(context)
                  .notificationsProcessingOpenAccessSettingsDescription,
              onTap: _viewModel.isBusy ? null : _openNotificationAccessSettings,
            ),
            NotificationDangerActionGroup(
              title: S.of(context).notificationsProcessingRemoveSetupGroupTitle,
              children: <Widget>[
                NotificationSettingsActionCard(
                  icon: Icons.app_registration_outlined,
                  title: S
                      .of(context)
                      .notificationsProcessingDeleteRegistrations,
                  subtitle: S
                      .of(context)
                      .notificationsProcessingDeleteRegistrationsDescription,
                  onTap: _viewModel.isBusy || !_viewModel.hasDefinitions
                      ? null
                      : _deleteAllRegistrations,
                  destructive: true,
                ),
                NotificationSettingsActionCard(
                  icon: Icons.delete_forever_outlined,
                  title: S.of(context).notificationsProcessingRemoveSetup,
                  subtitle: S
                      .of(context)
                      .notificationsProcessingRemoveSetupDescription,
                  onTap: _viewModel.isBusy || !_viewModel.hasSetupOrStoredData
                      ? null
                      : _removeNotificationSetup,
                  destructive: true,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _createBackup() async {
    await _performAction(() async {
      final bool saved = await _saveBackupArchive(
        defaultFileName: _fileName(
          'waterfly-notification-processing-backup',
          'zip',
        ),
        bytes: await _viewModel.createBackup(exportedAt: DateTime.now()),
      );
      if (!mounted) return;
      _showSnackBar(
        saved
            ? S.of(context).notificationsProcessingBackupComplete
            : S.of(context).notificationsProcessingExportCancelled,
      );
    });
  }

  Future<void> _restoreBackup() async {
    await _performAction(() async {
      final Uint8List? data = await widget.backupFileGateway.pickArchive();
      if (data == null) return;
      final NotificationProcessingBackup backup = _viewModel.readBackup(data);
      if (!mounted) return;
      final bool confirmed = await _confirm(
        title: S.of(context).notificationsProcessingRestoreBackupTitle,
        message: S
            .of(context)
            .notificationsProcessingRestoreBackupConfirm(
              backup.definitions.length,
            ),
        confirmLabel: S.of(context).notificationsProcessingRestoreBackup,
      );
      if (!confirmed) return;
      await _viewModel.restoreBackup(backup);
      if (!mounted) return;
      _showSnackBar(S.of(context).notificationsProcessingRestoreBackupComplete);
    });
  }

  Future<void> _clearHistory() async {
    await _performAction(() async {
      final bool confirmed = await _confirmDestructive(
        title: S.of(context).notificationsProcessingClearHistoryTitle,
        message: S.of(context).notificationsProcessingClearHistoryConfirm,
        confirmLabel: S.of(context).notificationsProcessingClearHistory,
      );
      if (!confirmed) return;
      await _viewModel.clearHistory();
      if (mounted) {
        _showSnackBar(S.of(context).notificationsProcessingHistoryCleared);
      }
    });
  }

  Future<void> _clearAlerts() async {
    await _performAction(() async {
      final bool confirmed = await _confirmDestructive(
        title: S.of(context).notificationsProcessingClearAlertsTitle,
        message: S.of(context).notificationsProcessingClearAlertsConfirm,
        confirmLabel: S.of(context).notificationsProcessingClearAlerts,
      );
      if (!confirmed) return;
      await _viewModel.clearAlerts();
      if (mounted) {
        _showSnackBar(S.of(context).notificationsProcessingAlertsCleared);
      }
    });
  }

  Future<void> _openNotificationAccessSettings() async {
    await _performAction(() async {
      final bool opened = await widget.accessSettingsLauncher
          .openNotificationAccessSettings();
      if (!mounted) return;
      _showSnackBar(
        opened
            ? S.of(context).notificationsProcessingAccessSettingsOpened
            : S.of(context).notificationsProcessingAccessSettingsOpenFailure,
      );
    });
  }

  Future<void> _deleteAllRegistrations() async {
    final int definitionCount = _viewModel.definitionCount;
    await _performAction(() async {
      final bool confirmed = await _confirmDestructive(
        title: S
            .of(context)
            .notificationsProcessingDeleteRegistrationsTitle(definitionCount),
        message: S
            .of(context)
            .notificationsProcessingDeleteRegistrationsConfirm,
        confirmLabel: S.of(context).notificationsProcessingDeleteRegistrations,
      );
      if (!confirmed) return;
      final DeleteNotificationDefinitionsResult result = await _viewModel
          .deleteAllDefinitions();
      if (mounted) {
        _showSnackBar(
          result.cleanupSucceeded
              ? S
                    .of(context)
                    .notificationsProcessingRegistrationsDeleted(
                      definitionCount,
                    )
              : S
                    .of(context)
                    .notificationsProcessingRegistrationsDeletedCleanupFailure(
                      definitionCount,
                    ),
        );
      }
    });
  }

  Future<void> _removeNotificationSetup() async {
    bool removed = false;
    await _performAction(() async {
      final bool confirmed = await _confirmDestructive(
        title: S.of(context).notificationsProcessingRemoveSetupTitle,
        message: S.of(context).notificationsProcessingRemoveSetupConfirm,
        confirmLabel: S.of(context).notificationsProcessingRemoveSetup,
      );
      if (!confirmed) return;
      await _viewModel.resetAll();
      removed = true;
    });
    if (!mounted || !removed) return;
    final bool opened = await _openNotificationAccessSettingsAfterRemoval();
    if (!mounted) return;
    _showSnackBar(
      opened
          ? S.of(context).notificationsProcessingRemoveSetupComplete
          : S.of(context).notificationsProcessingRemoveSetupCompleteNoSettings,
    );
  }

  Future<bool> _openNotificationAccessSettingsAfterRemoval() async {
    try {
      return await widget.accessSettingsLauncher
          .openNotificationAccessSettings();
    } on PlatformException {
      return false;
    } on MissingPluginException {
      return false;
    }
  }

  Future<void> _performAction(Future<void> Function() action) async {
    try {
      await action();
    } catch (error, stackTrace) {
      _log.warning(
        'Notification processing settings action failed.',
        error,
        stackTrace,
      );
      if (mounted) {
        _showSnackBar(S.of(context).notificationsProcessingActionFailure);
      }
    }
  }

  Future<bool> _saveBackupArchive({
    required String defaultFileName,
    required Uint8List bytes,
  }) => widget.backupFileGateway.saveArchive(
    dialogTitle: S.of(context).notificationsProcessingSaveFileTitle,
    suggestedName: defaultFileName,
    bytes: bytes,
  );

  String _fileName(String prefix, String extension) =>
      '$prefix-${DateFormat('yyyyMMdd-HHmmss').format(DateTime.now())}'
      '.$extension';

  Future<bool> _confirm({
    required String title,
    required String message,
    required String confirmLabel,
  }) async =>
      await showNotificationDialog<bool>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(confirmLabel),
            ),
          ],
        ),
      ) ??
      false;

  Future<bool> _confirmDestructive({
    required String title,
    required String message,
    required String confirmLabel,
  }) async =>
      await showNotificationDialog<bool>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Theme.of(context).colorScheme.onError,
              ),
              child: Text(confirmLabel),
            ),
          ],
        ),
      ) ??
      false;

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
