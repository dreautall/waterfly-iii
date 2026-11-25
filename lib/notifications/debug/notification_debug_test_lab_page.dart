import 'package:appcheck/appcheck.dart';
import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/notificationlistener.dart';
import 'package:waterflyiii/notifications/debug/notification_debug_seed_service.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/notification_id.dart';
import 'package:waterflyiii/notifications/notification_feature_scope.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/applications/notification_application_selector_dialog.dart';
import 'package:waterflyiii/notifications/presentation/settings/widgets/notification_processing_settings_sections.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_input_decoration.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_menu_theme.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_page_header.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';

enum _NotificationPreset {
  validPurchase('Valid CAD purchase', 'Card payment', 'Paid 12.50 CAD'),
  noAmount(
    'No monetary value',
    'Card settings',
    'Your card settings were updated.',
  ),
  ambiguousAmount(
    'Multiple monetary values',
    'Card payment',
    'Balance CAD 2,000.00. Purchase CAD 12.50.',
  ),
  expressionMatch(
    'Advanced expression match',
    'Card payment',
    'Paid 12.50 CAD',
  ),
  expressionMismatch(
    'Advanced expression mismatch',
    'Card payment',
    'Card purchase for 12.50 CAD',
  ),
  emptyTitle('Empty title', '', 'Paid 12.50 CAD'),
  emptyBody('Empty body', 'Card payment', ''),
  dbsBodyOnly(
    'DBS body-only transaction',
    '',
    'A card txn of 12.50 SGD from DBS/POSB card ending 1234 to Market on 24 Nov 14:30 (SGT) was completed.',
  ),
  groupingTitleOnly(
    'Grouping title-only notification',
    'DBS transaction notifications',
    '',
  ),
  metadataOnly('Metadata-only notification', '', '');

  const _NotificationPreset(this.label, this.title, this.body);

  final String label;
  final String title;
  final String body;
}

class NotificationDebugTestLabPage extends StatefulWidget {
  const NotificationDebugTestLabPage({
    super.key,
    required this.scope,
    required this.seedService,
  });

  final NotificationFeatureScope scope;
  final NotificationDebugSeedService seedService;

  @override
  State<NotificationDebugTestLabPage> createState() =>
      _NotificationDebugTestLabPageState();
}

class _NotificationDebugTestLabPageState
    extends State<NotificationDebugTestLabPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _titleController = TextEditingController(
    text: 'Card payment',
  );
  final TextEditingController _bodyController = TextEditingController(
    text: 'Paid 12.50 CAD',
  );
  final TextEditingController _unknownPackageController = TextEditingController(
    text: 'debug.migration.unknown',
  );
  AppInfo? _application;
  String? _seededDefinitionId;
  NotificationDebugSeedScenario _scenario =
      NotificationDebugSeedScenario.sampleMissing;
  _NotificationPreset _notificationPreset = _NotificationPreset.validPurchase;
  bool _isBusy = false;

  @override
  void dispose() {
    _scrollController.dispose();
    _titleController.dispose();
    _bodyController.dispose();
    _unknownPackageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => NotificationMenuTheme(
    child: Scaffold(
      extendBodyBehindAppBar: true,
      appBar: NotificationPageHeader(
        scrollController: _scrollController,
        title: const Text('Notification migration test lab'),
      ),
      body: ListView(
        controller: _scrollController,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(
          16,
          NotificationPageHeader.bodyTopInset(context),
          16,
          NotificationPageHeader.bodyBottomInset(context),
        ),
        children: <Widget>[
          Text(
            'These tools are only available through the debug entry point. '
            'Seeding replaces the selected app registration and clears its '
            'debug history and alerts.',
            style: context.notificationSectionDescription,
          ),
          const SizedBox(height: 24),
          NotificationSettingsSection(
            title: 'Target application',
            description:
                'Choose an installed app whose real notifications you can trigger.',
            children: <Widget>[
              NotificationSettingsActionCard(
                icon: Icons.apps_outlined,
                title: _application?.appName ?? 'Choose installed application',
                subtitle:
                    _application?.packageName ??
                    'The package ID is used by both seeded and real notifications.',
                onTap: _isBusy ? null : _chooseApplication,
              ),
            ],
          ),
          const SizedBox(height: 24),
          NotificationSettingsSection(
            title: 'Seed migration state',
            description:
                'Create a deterministic imported configuration for the selected app.',
            children: <Widget>[
              DropdownButtonFormField<NotificationDebugSeedScenario>(
                initialValue: _scenario,
                decoration: notificationInputDecoration(
                  context,
                  labelText: 'Scenario',
                ),
                items: <DropdownMenuItem<NotificationDebugSeedScenario>>[
                  for (final NotificationDebugSeedScenario scenario
                      in NotificationDebugSeedScenario.values)
                    DropdownMenuItem<NotificationDebugSeedScenario>(
                      value: scenario,
                      child: Text(scenario.label),
                    ),
                ],
                onChanged: _isBusy
                    ? null
                    : (NotificationDebugSeedScenario? value) {
                        if (value != null) setState(() => _scenario = value);
                      },
              ),
              Text(
                _scenario.description,
                style: context.notificationSupportingText,
              ),
              if (_scenario ==
                  NotificationDebugSeedScenario.unknownApplication) ...<Widget>[
                TextField(
                  controller: _unknownPackageController,
                  enabled: !_isBusy,
                  decoration: notificationInputDecoration(
                    context,
                    labelText: 'Unknown package ID',
                    hintText: 'debug.migration.unknown',
                  ),
                ),
                Text(
                  'This non-installed ID keeps the registration unknown. '
                  'Open it from Registered applications and manually rebind it '
                  'to ${_application?.appName ?? 'the selected app'}.',
                  style: context.notificationSupportingText,
                ),
              ],
              FilledButton.icon(
                onPressed:
                    _isBusy ||
                        _application == null ||
                        (_scenario ==
                                NotificationDebugSeedScenario
                                    .unknownApplication &&
                            _unknownPackageController.text.trim().isEmpty)
                    ? null
                    : _seed,
                icon: const Icon(Icons.science_outlined),
                label: const Text('Seed selected scenario'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          NotificationSettingsSection(
            title: 'Deliver synthetic notification',
            description:
                'Runs the same processing orchestrator as the Android listener. '
                'Seeded scenarios use Prompt mode and cannot create a transaction automatically.',
            children: <Widget>[
              DropdownButtonFormField<_NotificationPreset>(
                initialValue: _notificationPreset,
                decoration: notificationInputDecoration(
                  context,
                  labelText: 'Message preset',
                ),
                items: <DropdownMenuItem<_NotificationPreset>>[
                  for (final _NotificationPreset preset
                      in _NotificationPreset.values)
                    DropdownMenuItem<_NotificationPreset>(
                      value: preset,
                      child: Text(preset.label),
                    ),
                ],
                onChanged: _isBusy
                    ? null
                    : (_NotificationPreset? value) {
                        if (value == null) return;
                        setState(() {
                          _notificationPreset = value;
                          _titleController.text = value.title;
                          _bodyController.text = value.body;
                        });
                      },
              ),
              TextField(
                controller: _titleController,
                enabled: !_isBusy,
                decoration: notificationInputDecoration(
                  context,
                  labelText: 'Notification title',
                ),
              ),
              TextField(
                controller: _bodyController,
                enabled: !_isBusy,
                minLines: 2,
                maxLines: 4,
                decoration: notificationInputDecoration(
                  context,
                  labelText: 'Notification body',
                  alignLabelWithHint: true,
                ),
              ),
              FilledButton.icon(
                onPressed: _isBusy || _application == null ? null : _deliver,
                icon: const Icon(Icons.send_outlined),
                label: const Text('Deliver synthetic notification'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          NotificationSettingsSection(
            title: 'Cleanup',
            description:
                'Cleanup only removes definitions created by this test lab.',
            children: <Widget>[
              NotificationSettingsActionCard(
                icon: Icons.delete_outline,
                title: 'Remove latest app seed',
                subtitle:
                    'Also clears alerts and history for the package ID that was seeded.',
                onTap: _isBusy || _seededDefinitionId == null
                    ? null
                    : _resetApplication,
                destructive: true,
              ),
              NotificationSettingsActionCard(
                icon: Icons.delete_sweep_outlined,
                title: 'Remove all test-lab seeds',
                subtitle:
                    'Removes every definition whose ID starts with debug:migration:.',
                onTap: _isBusy ? null : _resetAll,
                destructive: true,
              ),
            ],
          ),
        ],
      ),
    ),
  );

  Future<void> _chooseApplication() async {
    final AppInfo? application = await showDialog<AppInfo>(
      context: context,
      builder: (BuildContext context) => NotificationApplicationSelectorDialog(
        historyStore: widget.scope.historyStore,
        mode: NotificationApplicationSelectionMode.recover,
      ),
    );
    if (application != null && mounted) {
      setState(() => _application = application);
    }
  }

  Future<void> _seed() => _run(
    successMessage: 'Seeded ${_scenario.label}.',
    action: () async {
      final AppInfo application = _application!;
      final String seededApplicationId =
          _scenario == NotificationDebugSeedScenario.unknownApplication
          ? _unknownPackageController.text.trim()
          : application.packageName;
      final NotificationDefinition definition = await widget.seedService.seed(
        scenario: _scenario,
        applicationId: seededApplicationId,
        applicationName: application.appName ?? application.packageName,
        replacedApplicationId: seededApplicationId == application.packageName
            ? null
            : application.packageName,
      );
      _seededDefinitionId = definition.id;
      await _refreshNotificationPages();
    },
  );

  Future<void> _deliver() {
    return _run(
      successMessage: 'Synthetic notification delivered.',
      action: () async {
        final AppInfo application = _application!;
        await processDebugNotification(
          NotificationContext(
            applicationId: application.packageName,
            applicationName: application.appName,
            deliveryId: 'debug:${newNotificationId()}',
            title: _titleController.text.trim(),
            body: _bodyController.text.trim(),
            receivedAt: DateTime.now(),
          ),
        );
        await _refreshNotificationPages();
      },
    );
  }

  Future<void> _resetApplication() => _run(
    successMessage: 'Removed the latest app seed.',
    action: () async {
      await widget.seedService.resetDefinition(_seededDefinitionId!);
      _seededDefinitionId = null;
      await _refreshNotificationPages();
    },
  );

  Future<void> _resetAll() => _run(
    successMessage: 'Removed all test-lab seeds.',
    action: () async {
      await widget.seedService.resetAllSeeded();
      await _refreshNotificationPages();
    },
  );

  Future<void> _refreshNotificationPages() async {
    await (
      widget.scope.definitionsViewModel.load(),
      widget.scope.recentNotificationsViewModel.load(),
      widget.scope.alertsViewModel.load(),
    ).wait;
  }

  Future<void> _run({
    required String successMessage,
    required Future<void> Function() action,
  }) async {
    setState(() => _isBusy = true);
    try {
      await action();
      if (mounted) _showMessage(successMessage);
    } catch (error) {
      if (mounted) _showMessage('Debug action failed: $error');
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
