import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/samples/sample_notification_editor_context.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_date_time_formatter.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_input_decoration.dart';
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
  });

  final String title;
  final String body;
  final DateTime receivedAt;
  final SampleNotificationEditorContext editorContext;

  @override
  State<SampleNotificationEditorDialog> createState() =>
      _SampleNotificationEditorDialogState();
}

class _SampleNotificationEditorDialogState
    extends State<SampleNotificationEditorDialog> {
  late final TextEditingController _titleController = TextEditingController(
    text: widget.title,
  );
  late final TextEditingController _bodyController = TextEditingController(
    text: widget.body,
  );
  late DateTime _receivedAt = widget.receivedAt;

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final bool hasExistingSample =
        widget.title.trim().isNotEmpty && widget.body.trim().isNotEmpty;
    final bool isComplete =
        _titleController.text.trim().isNotEmpty &&
        _bodyController.text.trim().isNotEmpty;
    return AlertDialog(
      title: Row(
        children: <Widget>[
          const Icon(Icons.notifications_outlined),
          const SizedBox(width: 12),
          Text(
            hasExistingSample
                ? S.of(context).notificationsSampleChangeTitle
                : S.of(context).notificationsSampleAddTitle,
          ),
        ],
      ),
      content: SizedBox(
        width: 420,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                _description(S.of(context)),
                style: context.notificationSectionDescription,
              ),
              const SizedBox(height: 24),
              TextField(
                key: const Key('sample-notification-title'),
                controller: _titleController,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (_) => setState(() {}),
                decoration: notificationInputDecoration(
                  context,
                  labelText: S
                      .of(context)
                      .notificationsExtractorNotificationTitle,
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
                    backgroundColor: colors.surfaceContainerLow,
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
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
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
