import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_sample.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/samples/sample_notification_editor_context.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/samples/sample_notification_editor_dialog.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_dialog.dart';

export 'package:waterflyiii/notifications/presentation/dialogs/samples/sample_notification_editor_context.dart';

Future<bool> showDiscardChangesDialog(BuildContext context) async =>
    await showNotificationDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(S.of(context).notificationsDiscardChangesTitle),
        content: Text(S.of(context).notificationsDiscardChangesDescription),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(S.of(context).notificationsDiscard),
          ),
          FilledButton(
            autofocus: true,
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
        ],
      ),
    ) ??
    false;

Future<bool> showCancelConditionTransferDialog(
  BuildContext context, {
  required bool isMove,
  required bool hasUnsavedChanges,
}) async =>
    await showNotificationDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        final S strings = S.of(context);
        return AlertDialog(
          title: Text(
            isMove
                ? strings.notificationsRuleLeaveMovingConditionTitle
                : strings.notificationsRuleLeaveCopyingConditionTitle,
          ),
          content: Text(
            isMove
                ? hasUnsavedChanges
                      ? strings.notificationsRuleLeaveMovingConditionDirty
                      : strings.notificationsRuleLeaveMovingConditionDescription
                : hasUnsavedChanges
                ? strings.notificationsRuleLeaveCopyingConditionDirty
                : strings.notificationsRuleLeaveCopyingConditionDescription,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: hasUnsavedChanges
                  ? TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.error,
                    )
                  : null,
              child: Text(strings.notificationsRuleLeavePage),
            ),
            FilledButton(
              autofocus: true,
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(strings.notificationsRuleStayHere),
            ),
          ],
        );
      },
    ) ??
    false;

Future<NotificationSample?> showSampleNotificationEditor({
  required BuildContext context,
  required NotificationSample sample,
  required SampleNotificationEditorContext editorContext,
}) async {
  final SampleNotificationInput? result =
      await showNotificationDialog<SampleNotificationInput>(
        context: context,
        builder: (BuildContext context) => SampleNotificationEditorDialog(
          title: sample.title,
          body: sample.body,
          receivedAt: sample.receivedAt,
          editorContext: editorContext,
        ),
      );
  if (result == null) return null;
  return NotificationSample(
    title: result.title,
    body: result.body,
    receivedAt: result.receivedAt,
  );
}
