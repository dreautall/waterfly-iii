import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_input_decoration.dart';

class NotificationRenameField extends StatelessWidget {
  const NotificationRenameField({
    super.key,
    required this.controller,
    required this.label,
  });

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) =>
      ValueListenableBuilder<TextEditingValue>(
        valueListenable: controller,
        builder:
            (BuildContext context, TextEditingValue value, Widget? child) =>
                TextField(
                  controller: controller,
                  autofocus: true,
                  textCapitalization: TextCapitalization.words,
                  decoration: notificationInputDecoration(
                    context,
                    labelText: label,
                    suffixIcon: value.text.isEmpty
                        ? null
                        : IconButton(
                            tooltip: S.of(context).notificationsClearText,
                            onPressed: controller.clear,
                            icon: const Icon(Icons.close),
                          ),
                  ),
                ),
      );
}
