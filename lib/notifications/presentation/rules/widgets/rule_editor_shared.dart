import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_dialog.dart';

const AnimationStyle ruleEditorMessageAnimation = AnimationStyle(
  duration: Duration(milliseconds: 250),
  reverseDuration: Duration(milliseconds: 250),
);

Future<bool> showRuleRemovalConfirmation(
  BuildContext context, {
  required String title,
  required String content,
}) async =>
    await showNotificationDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            autofocus: true,
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: Text(S.of(context).notificationsRuleRemove),
          ),
        ],
      ),
    ) ??
    false;
