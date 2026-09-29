import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_app_icon.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_input_decoration.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';

class RuleTestSample {
  const RuleTestSample({required this.title, required this.body});

  final String title;
  final String body;
}

class RuleTestSampleDialog extends StatefulWidget {
  const RuleTestSampleDialog({
    super.key,
    required this.applicationId,
    required this.applicationName,
    required this.title,
    required this.body,
  });

  final String applicationId;
  final String applicationName;
  final String title;
  final String body;

  @override
  State<RuleTestSampleDialog> createState() => _RuleTestSampleDialogState();
}

class _RuleTestSampleDialogState extends State<RuleTestSampleDialog> {
  late final TextEditingController _titleController = TextEditingController(
    text: widget.title,
  );
  late final TextEditingController _bodyController = TextEditingController(
    text: widget.body,
  );

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);
    return AlertDialog(
      title: Row(
        children: <Widget>[
          const Icon(Icons.notifications_outlined),
          const SizedBox(width: 12),
          Text(strings.notificationsRuleEditTestNotification),
        ],
      ),
      content: SizedBox(
        width: 420,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              strings.notificationsRuleTestSampleDescription,
              style: context.notificationSectionDescription,
            ),
            const SizedBox(height: 24),
            DecoratedBox(
              decoration: notificationControlDecoration(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: <Widget>[
                    NotificationAppIcon(applicationId: widget.applicationId),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.applicationName,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            strings.notificationsSampleSource,
                            style: context.notificationMetadataText,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _titleController,
              autofocus: true,
              textCapitalization: TextCapitalization.sentences,
              decoration: notificationInputDecoration(
                context,
                labelText: strings.notificationsExtractorNotificationTitle,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _bodyController,
              minLines: 3,
              maxLines: 6,
              textCapitalization: TextCapitalization.sentences,
              decoration: notificationInputDecoration(
                context,
                labelText: strings.notificationsExtractorNotificationMessage,
                alignLabelWithHint: true,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(
            RuleTestSample(
              title: _titleController.text,
              body: _bodyController.text,
            ),
          ),
          child: Text(strings.notificationsApply),
        ),
      ],
    );
  }
}
