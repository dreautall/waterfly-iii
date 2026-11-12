import 'package:material_ui/material_ui.dart';

Future<void> runNotificationListenerHealthAction({
  required BuildContext context,
  required Future<bool> Function() action,
  required String failureMessage,
}) async {
  final bool succeeded = await action();
  if (!context.mounted || succeeded) return;
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(failureMessage)));
}
