import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_dialog.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_input_decoration.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';

class RuleCreation {
  const RuleCreation({
    required this.name,
    this.description = '',
    this.templateRuleId,
  });

  final String name;
  final String description;
  final String? templateRuleId;
}

class AddRuleDialog extends StatefulWidget {
  const AddRuleDialog({
    super.key,
    this.title,
    this.description,
    this.nameLabel,
    this.includeDescription = true,
    this.templateRules = const <NotificationRule>[],
  });

  final String? title;
  final String? description;
  final String? nameLabel;
  final bool includeDescription;
  final List<NotificationRule> templateRules;

  @override
  State<AddRuleDialog> createState() => _AddRuleDialogState();
}

class _AddRuleDialogState extends State<AddRuleDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _templateRuleId;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: NotificationDialogTitle(
      icon: Icons.tune_outlined,
      title: widget.title ?? S.of(context).notificationsDefinitionAddRule,
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
          if (widget.templateRules.isNotEmpty) ...<Widget>[
            const SizedBox(height: 20),
            const Divider(height: 1),
            const SizedBox(height: 16),
            _templateSection(),
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
                        templateRuleId: _templateRuleId,
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

  NotificationRule? get _templateRule => widget.templateRules
      .where((NotificationRule rule) => rule.id == _templateRuleId)
      .firstOrNull;

  Widget _templateSection() {
    final S strings = S.of(context);
    final NotificationRule? template = _templateRule;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          strings.notificationsRuleStartFrom,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 4),
        Text(
          template == null
              ? strings.notificationsRuleStartFromBlankDescription
              : strings.notificationsRuleStartFromRuleDescription(
                  template.name,
                ),
          style: context.notificationSectionDescription,
        ),
        const SizedBox(height: 12),
        _templateSelector(),
      ],
    );
  }

  Widget _templateSelector() => SizedBox(
    width: double.infinity,
    child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => MenuAnchor(
        animated: true,
        crossAxisUnconstrained: false,
        style: MenuStyle(
          fixedSize: WidgetStatePropertyAll<Size>(
            Size.fromWidth(constraints.maxWidth),
          ),
        ),
        menuChildren: <Widget>[
          _templateMenuItem(
            id: null,
            label: S.of(context).notificationsRuleBlank,
          ),
          for (final NotificationRule rule in widget.templateRules)
            _templateMenuItem(id: rule.id, label: rule.name),
        ],
        builder:
            (BuildContext context, MenuController controller, Widget? child) =>
                Material(
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                  shape: notificationControlShape(context),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    key: const Key('rule-template'),
                    onTap: () => _openTemplateMenu(controller),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              _templateRule?.name ??
                                  S.of(context).notificationsRuleBlank,
                            ),
                          ),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                ),
      ),
    ),
  );

  Widget _templateMenuItem({required String? id, required String label}) =>
      MenuItemButton(
        onPressed: () => setState(() => _templateRuleId = id),
        trailingIcon: _templateRuleId == id ? const Icon(Icons.check) : null,
        child: Text(label),
      );

  Future<void> _openTemplateMenu(MenuController controller) async {
    FocusScope.of(context).unfocus();
    await Future<void>.delayed(const Duration(milliseconds: 220));
    if (!mounted) return;
    controller.open();
  }
}
