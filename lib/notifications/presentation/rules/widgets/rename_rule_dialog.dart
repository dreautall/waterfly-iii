import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_rename_field.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_input_decoration.dart';

class RenameRuleDialog extends StatefulWidget {
  const RenameRuleDialog({
    super.key,
    required this.name,
    this.title,
    this.description,
    this.nameLabel,
  });

  final String name;
  final String? title;
  final String? description;
  final String? nameLabel;

  @override
  State<RenameRuleDialog> createState() => _RenameRuleDialogState();
}

class RuleDetailsUpdate {
  const RuleDetailsUpdate({required this.name, required this.description});

  final String name;
  final String description;
}

class EditRuleDetailsDialog extends StatefulWidget {
  const EditRuleDetailsDialog({
    super.key,
    required this.name,
    required this.description,
    required this.onSave,
  });

  final String name;
  final String description;
  final ValueChanged<RuleDetailsUpdate> onSave;

  @override
  State<EditRuleDetailsDialog> createState() => _EditRuleDetailsDialogState();
}

class _EditRuleDetailsDialogState extends State<EditRuleDetailsDialog> {
  late final TextEditingController _nameController = TextEditingController(
    text: widget.name,
  );
  late final TextEditingController _descriptionController =
      TextEditingController(text: widget.description);

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(S.of(context).notificationsRuleEditDetailsTitle),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          S.of(context).notificationsRuleEditDetailsDescription,
          style: context.notificationSectionDescription,
        ),
        const SizedBox(height: 16),
        NotificationRenameField(
          controller: _nameController,
          label: S.of(context).notificationsRuleName,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _descriptionController,
          minLines: 2,
          maxLines: 4,
          textCapitalization: TextCapitalization.sentences,
          decoration: notificationInputDecoration(
            context,
            labelText: S.of(context).notificationsDescriptionOptional,
            alignLabelWithHint: true,
          ),
        ),
      ],
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
      ),
      ValueListenableBuilder<TextEditingValue>(
        valueListenable: _nameController,
        builder: (BuildContext context, TextEditingValue value, Widget? _) =>
            FilledButton(
              onPressed: value.text.trim().isEmpty
                  ? null
                  : () {
                      widget.onSave(
                        RuleDetailsUpdate(
                          name: _nameController.text.trim(),
                          description: _descriptionController.text.trim(),
                        ),
                      );
                      Navigator.of(context, rootNavigator: true).pop<void>();
                    },
              child: Text(S.of(context).notificationsExtractorSave),
            ),
      ),
    ],
  );
}

class _RenameRuleDialogState extends State<RenameRuleDialog> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.name,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.title ?? S.of(context).notificationsRuleRenameTitle),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.description ??
              S.of(context).notificationsRuleRenameDescription,
          style: context.notificationSectionDescription,
        ),
        const SizedBox(height: 16),
        NotificationRenameField(
          controller: _controller,
          label: widget.nameLabel ?? S.of(context).notificationsRuleName,
        ),
      ],
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
      ),
      FilledButton(
        onPressed: () => Navigator.of(context).pop(_controller.text.trim()),
        child: Text(S.of(context).notificationsExtractorSave),
      ),
    ],
  );
}
