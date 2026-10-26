import 'dart:async';

import 'package:logging/logging.dart';
import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_sample.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/samples/sample_notification_editor_context.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_card_theme.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_date_time_formatter.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_dialog.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_input_decoration.dart';
import 'package:waterflyiii/notifications/presentation/shared/sample_notification_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';

class SampleNotificationInput {
  const SampleNotificationInput({
    required this.title,
    required this.body,
    required this.receivedAt,
  });

  final String title;
  final String body;
  final DateTime receivedAt;
}

class SampleNotificationEditorDialog extends StatefulWidget {
  const SampleNotificationEditorDialog({
    super.key,
    required this.title,
    required this.body,
    required this.receivedAt,
    required this.editorContext,
    this.hasExistingSample,
    this.recentSamplesLoader,
  });

  final String title;
  final String body;
  final DateTime receivedAt;
  final SampleNotificationEditorContext editorContext;
  final bool? hasExistingSample;
  final Future<List<NotificationSample>> Function()? recentSamplesLoader;

  @override
  State<SampleNotificationEditorDialog> createState() =>
      _SampleNotificationEditorDialogState();
}

class _SampleNotificationEditorDialogState
    extends State<SampleNotificationEditorDialog> {
  static final Logger _log = Logger('Notifications.SampleEditor');
  late final TextEditingController _titleController = TextEditingController(
    text: widget.title,
  );
  late final TextEditingController _bodyController = TextEditingController(
    text: widget.body,
  );
  late DateTime _receivedAt = widget.receivedAt;
  bool _showRecentSamples = false;
  bool _isLoadingRecentSamples = false;
  Object? _recentSamplesError;
  List<NotificationSample> _recentSamples = <NotificationSample>[];

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasExistingSample =
        widget.hasExistingSample ??
        (widget.title.trim().isNotEmpty && widget.body.trim().isNotEmpty);
    final bool isComplete =
        _titleController.text.trim().isNotEmpty &&
        _bodyController.text.trim().isNotEmpty;
    return AlertDialog(
      title: _paneTransition(
        child: NotificationDialogTitle(
          key: ValueKey<bool>(_showRecentSamples),
          icon: _showRecentSamples
              ? Icons.history_outlined
              : Icons.notifications_outlined,
          title: _showRecentSamples
              ? S.of(context).notificationsDefinitionRecentSamplesTitle
              : hasExistingSample
              ? S.of(context).notificationsSampleChangeTitle
              : S.of(context).notificationsSampleAddTitle,
        ),
      ),
      content: SizedBox(
        width: 420,
        child: AnimatedSize(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          child: _paneTransition(
            child: _showRecentSamples
                ? _recentSamplesPane(context)
                : _editorPane(context),
          ),
        ),
      ),
      actions: <Widget>[
        SizedBox(
          width: double.infinity,
          child: _paneTransition(
            child: _showRecentSamples
                ? Row(
                    key: const ValueKey<String>('recent-sample-actions'),
                    children: <Widget>[
                      TextButton.icon(
                        key: const Key('back-to-sample-fields'),
                        onPressed: () =>
                            setState(() => _showRecentSamples = false),
                        icon: const Icon(Icons.arrow_back),
                        label: Text(
                          MaterialLocalizations.of(context).backButtonTooltip,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          MaterialLocalizations.of(context).cancelButtonLabel,
                        ),
                      ),
                    ],
                  )
                : Row(
                    key: const ValueKey<String>('sample-editor-actions'),
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          MaterialLocalizations.of(context).cancelButtonLabel,
                        ),
                      ),
                      const SizedBox(width: 8),
                      FilledButton(
                        onPressed: isComplete
                            ? () => Navigator.of(context).pop(
                                SampleNotificationInput(
                                  title: _titleController.text.trim(),
                                  body: _bodyController.text.trim(),
                                  receivedAt: _receivedAt,
                                ),
                              )
                            : null,
                        child: Text(
                          hasExistingSample
                              ? S.of(context).notificationsApply
                              : S.of(context).notificationsContinue,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  Widget _paneTransition({required Widget child}) {
    final Key? currentKey = child.key;
    return ClipRect(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        layoutBuilder: (Widget? current, List<Widget> previous) => Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[...previous, ?current],
        ),
        transitionBuilder:
            (Widget transitionChild, Animation<double> animation) {
              final bool entering = transitionChild.key == currentKey;
              final double direction = entering == _showRecentSamples ? 1 : -1;
              return AnimatedBuilder(
                animation: animation,
                child: transitionChild,
                builder: (BuildContext context, Widget? child) => IgnorePointer(
                  ignoring: animation.value != 1,
                  child: FractionalTranslation(
                    transformHitTests: false,
                    translation: Offset(direction * (1 - animation.value), 0),
                    child: FadeTransition(opacity: animation, child: child),
                  ),
                ),
              );
            },
        child: child,
      ),
    );
  }

  Widget _editorPane(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final Color controlSurface =
        notificationDialogSurfaceColor(context) ?? colors.surfaceContainerLow;
    return SingleChildScrollView(
      key: const ValueKey<String>('sample-editor-pane'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            _description(S.of(context)),
            style: context.notificationSectionDescription,
          ),
          if (widget.recentSamplesLoader != null) ...<Widget>[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                key: const Key('pick-recent-notification-sample'),
                onPressed: _showRecentSamplesPane,
                style: OutlinedButton.styleFrom(
                  backgroundColor: controlSurface,
                  foregroundColor: colors.onSurface,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  side: notificationControlBorder(context),
                  shape: const RoundedRectangleBorder(
                    borderRadius: notificationControlRadius,
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.history_outlined),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        S.of(context).notificationsDefinitionPickRecentSamples,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(height: 24),
          TextField(
            key: const Key('sample-notification-title'),
            controller: _titleController,
            textCapitalization: TextCapitalization.sentences,
            onChanged: (_) => setState(() {}),
            decoration: notificationInputDecoration(
              context,
              labelText: S.of(context).notificationsExtractorNotificationTitle,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            key: const Key('sample-notification-body'),
            controller: _bodyController,
            minLines: 3,
            maxLines: 6,
            textCapitalization: TextCapitalization.sentences,
            onChanged: (_) => setState(() {}),
            decoration: notificationInputDecoration(
              context,
              labelText: S
                  .of(context)
                  .notificationsExtractorNotificationMessage,
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: _editReceivedAt,
              style: OutlinedButton.styleFrom(
                backgroundColor: controlSurface,
                foregroundColor: colors.onSurface,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                side: notificationControlBorder(context),
                shape: const RoundedRectangleBorder(
                  borderRadius: notificationControlRadius,
                ),
              ),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.schedule_outlined),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          S.of(context).notificationsSampleTimestamp,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          formatNotificationDateTime(context, _receivedAt),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.edit_outlined, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _recentSamplesPane(BuildContext context) {
    final double height = (MediaQuery.sizeOf(context).height - 300)
        .clamp(220, 360)
        .toDouble();
    return SizedBox(
      key: const ValueKey<String>('recent-samples-pane'),
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            S.of(context).notificationsDefinitionRecentSamplesDescription,
            style: context.notificationSectionDescription,
          ),
          const SizedBox(height: 12),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              child: _recentSamplesContent(context),
            ),
          ),
        ],
      ),
    );
  }

  String _description(S strings) => switch (widget.editorContext) {
    SampleNotificationEditorContext.definition =>
      strings.notificationsSampleDescription,
    SampleNotificationEditorContext.extractor =>
      strings.notificationsSampleExtractorDescription,
    SampleNotificationEditorContext.rule =>
      strings.notificationsSampleRuleDescription,
    SampleNotificationEditorContext.conditionalAction =>
      strings.notificationsSampleConditionalActionDescription,
  };

  Widget _recentSamplesContent(BuildContext context) {
    if (_isLoadingRecentSamples) {
      return const Center(
        key: Key('recent-samples-loading'),
        child: CircularProgressIndicator(),
      );
    }
    if (_recentSamplesError != null) {
      return Center(
        key: const Key('recent-samples-error'),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              S.of(context).notificationsDefinitionLatestSampleLoadFailure,
              style: context.notificationSectionDescription,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            TextButton(
              onPressed: _loadRecentSamples,
              child: Text(
                S.of(context).notificationsDefinitionRecentSamplesRetry,
              ),
            ),
          ],
        ),
      );
    }
    if (_recentSamples.isEmpty) {
      return Center(
        key: const Key('recent-samples-empty'),
        child: Text(
          S.of(context).notificationsDefinitionLatestSampleUnavailable,
          style: context.notificationSectionDescription,
          textAlign: TextAlign.center,
        ),
      );
    }
    final Color surface =
        notificationDialogSurfaceColor(context) ??
        Theme.of(context).colorScheme.surfaceContainerLow;
    return ListView.separated(
      key: const Key('recent-samples-list'),
      padding: EdgeInsets.zero,
      physics: const ClampingScrollPhysics(),
      itemCount: _recentSamples.length,
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 8),
      itemBuilder: (BuildContext context, int index) {
        final NotificationSample sample = _recentSamples[index];
        return SampleNotificationCard(
          key: ValueKey<String>('recent-sample-$index'),
          applicationId: '',
          title: sample.title,
          body: sample.body,
          receivedAt: sample.receivedAt,
          showApplicationIcon: false,
          surfaceColor: surface,
          shape: notificationControlShape(context),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          onTap: () => _selectRecentSample(sample),
        );
      },
    );
  }

  void _showRecentSamplesPane() {
    setState(() => _showRecentSamples = true);
    unawaited(_loadRecentSamples());
  }

  Future<void> _loadRecentSamples() async {
    final Future<List<NotificationSample>> Function()? loader =
        widget.recentSamplesLoader;
    if (loader == null || _isLoadingRecentSamples) return;
    setState(() {
      _isLoadingRecentSamples = true;
      _recentSamplesError = null;
    });
    try {
      final List<NotificationSample> samples = await loader();
      if (mounted) setState(() => _recentSamples = samples);
    } catch (error, stackTrace) {
      _log.warning(
        'Could not load recent notification samples.',
        error,
        stackTrace,
      );
      if (mounted) setState(() => _recentSamplesError = error);
    } finally {
      if (mounted) setState(() => _isLoadingRecentSamples = false);
    }
  }

  void _selectRecentSample(NotificationSample sample) {
    _titleController.text = sample.title;
    _bodyController.text = sample.body;
    setState(() {
      _receivedAt = sample.receivedAt;
      _showRecentSamples = false;
    });
  }

  Future<void> _editReceivedAt() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: _receivedAt,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date == null || !mounted) return;
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_receivedAt),
    );
    if (time == null || !mounted) return;
    setState(() {
      _receivedAt = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }
}
