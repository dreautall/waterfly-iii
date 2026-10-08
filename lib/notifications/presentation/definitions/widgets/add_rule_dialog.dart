import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_input_decoration.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';

class RuleCreation {
  const RuleCreation({required this.name, this.description = ''});

  final String name;
  final String description;
}

class AddRuleDialog extends StatefulWidget {
  const AddRuleDialog({
    super.key,
    this.title,
    this.description,
    this.nameLabel,
    this.includeDescription = true,
  });

  final String? title;
  final String? description;
  final String? nameLabel;
  final bool includeDescription;

  @override
  State<AddRuleDialog> createState() => _AddRuleDialogState();
}

class _AddRuleDialogState extends State<AddRuleDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Row(
      children: <Widget>[
        const Icon(Icons.tune_outlined),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            widget.title ?? S.of(context).notificationsDefinitionAddRule,
          ),
        ),
      ],
    ),
    content: SizedBox(
      width: 420,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.description ??
                S.of(context).notificationsDefinitionNameRuleDescription,
            style: context.notificationSectionDescription,
          ),
          const SizedBox(height: 16),
          _nameStep(),
          if (widget.includeDescription) ...<Widget>[
            const SizedBox(height: 12),
            _descriptionField(),
          ],
        ],
      ),
    ),
    actions: <Widget>[
      ValueListenableBuilder<TextEditingValue>(
        valueListenable: _nameController,
        builder: (BuildContext context, TextEditingValue value, Widget? _) =>
            FilledButton(
              autofocus: true,
              onPressed: value.text.trim().isEmpty
                  ? null
                  : () => Navigator.of(context).pop(
                      RuleCreation(
                        name: _nameController.text.trim(),
                        description: _descriptionController.text.trim(),
                      ),
                    ),
              child: Text(S.of(context).notificationsAdd),
            ),
      ),
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
      ),
    ],
  );

  Widget _nameStep() => Padding(
    padding: const EdgeInsets.only(top: 8),
    child: TextField(
      controller: _nameController,
      autofocus: true,
      textCapitalization: TextCapitalization.words,
      decoration: notificationInputDecoration(
        context,
        labelText: widget.nameLabel ?? S.of(context).notificationsRuleName,
      ),
    ),
  );

  Widget _descriptionField() => TextField(
    controller: _descriptionController,
    minLines: 2,
    maxLines: 4,
    textCapitalization: TextCapitalization.sentences,
    decoration: notificationInputDecoration(
      context,
      labelText: S.of(context).notificationsDescriptionOptional,
      alignLabelWithHint: true,
    ),
  );
}
