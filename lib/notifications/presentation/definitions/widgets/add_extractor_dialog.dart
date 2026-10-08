import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/presentation/shared/dialog_selector_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_input_decoration.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';

class ExtractorCreation {
  const ExtractorCreation.predefined(this.predefinedType)
    : customName = null,
      description = '';
  const ExtractorCreation.custom(this.customName, this.description)
    : predefinedType = null;

  final PredefinedRegExpDefinition? predefinedType;
  final String? customName;
  final String description;
}

class AddExtractorDialog extends StatefulWidget {
  const AddExtractorDialog({
    super.key,
    required this.unavailablePredefinedTypes,
  });

  final Set<PredefinedRegExpDefinition> unavailablePredefinedTypes;

  @override
  State<AddExtractorDialog> createState() => _AddExtractorDialogState();
}

class _AddExtractorDialogState extends State<AddExtractorDialog> {
  RegExpDefinitionType? _type;
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
        Icon(_type == null ? Icons.add_circle_outline : Icons.tune_outlined),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            _type == null
                ? S.of(context).notificationsDefinitionAddExtractor
                : _type == RegExpDefinitionType.predefined
                ? S.of(context).notificationsDefinitionSelectPredefinedExtractor
                : S.of(context).notificationsDefinitionNameCustomExtractor,
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
            _type == null
                ? S.of(context).notificationsDefinitionChooseExtractorType
                : _type == RegExpDefinitionType.predefined
                ? S.of(context).notificationsDefinitionSelectNotificationField
                : S.of(context).notificationsDefinitionNameExtractorDescription,
            style: context.notificationSectionDescription,
          ),
          const SizedBox(height: 16),
          Flexible(
            fit: FlexFit.loose,
            child: ClipRect(
              child: AnimatedSize(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeInOut,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  layoutBuilder:
                      (Widget? currentChild, List<Widget> previousChildren) =>
                          Stack(
                            alignment: Alignment.topLeft,
                            children: <Widget>[
                              ...previousChildren.map(
                                (Widget child) => Positioned.fill(child: child),
                              ),
                              ?currentChild,
                            ],
                          ),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                        final bool isTypePicker =
                            child.key ==
                            const ValueKey<String>('extractor-types');
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: isTypePicker
                                ? const Offset(-1, 0)
                                : const Offset(1, 0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                  child: _type == null ? _typePicker() : _configurationStep(),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    actions: <Widget>[
      if (_type != null)
        TextButton(
          onPressed: () => setState(() => _type = null),
          child: Text(S.of(context).notificationsBack),
        ),
      if (_type == RegExpDefinitionType.custom)
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _nameController,
          builder: (BuildContext context, TextEditingValue value, Widget? _) =>
              FilledButton(
                autofocus: true,
                onPressed: value.text.trim().isEmpty
                    ? null
                    : () => Navigator.of(context).pop(
                        ExtractorCreation.custom(
                          _nameController.text.trim(),
                          _descriptionController.text.trim(),
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

  Widget _typePicker() => ListView(
    key: const ValueKey<String>('extractor-types'),
    shrinkWrap: true,
    physics: const ClampingScrollPhysics(),
    padding: const EdgeInsets.all(4),
    children: <Widget>[
      _typeOption(
        RegExpDefinitionType.predefined,
        Icons.auto_awesome_outlined,
        S.of(context).notificationsPredefined,
        S.of(context).notificationsDefinitionPredefinedExtractorDescription,
      ),
      const SizedBox(height: 8),
      _typeOption(
        RegExpDefinitionType.custom,
        Icons.tune,
        S.of(context).notificationsDefinitionRegularExpressionExtractor,
        S.of(context).notificationsDefinitionCustomExtractorDescription,
      ),
    ],
  );

  Widget _typeOption(
    RegExpDefinitionType type,
    IconData icon,
    String title,
    String subtitle,
  ) => DialogSelectorCard(
    onTap: () => setState(() => _type = type),
    leading: Icon(icon),
    title: Text(title),
    subtitle: Text(subtitle, style: context.notificationSupportingText),
    trailing: const Icon(Icons.chevron_right),
  );

  Widget _configurationStep() => _type == RegExpDefinitionType.predefined
      ? ListView.separated(
          key: const ValueKey<String>('predefined-extractors'),
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.all(4),
          itemCount: PredefinedRegExpDefinition.values.length,
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 8),
          itemBuilder: (BuildContext context, int index) =>
              _predefinedOption(PredefinedRegExpDefinition.values[index]),
        )
      : Column(
          key: const ValueKey<String>('custom-extractor-name'),
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: TextField(
                controller: _nameController,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                decoration: notificationInputDecoration(
                  context,
                  labelText: S.of(context).notificationsExtractorName,
                ),
              ),
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
        );

  Widget _predefinedOption(PredefinedRegExpDefinition extractor) =>
      DialogSelectorCard(
        onTap: widget.unavailablePredefinedTypes.contains(extractor)
            ? null
            : () => Navigator.of(
                context,
              ).pop(ExtractorCreation.predefined(extractor)),
        leading: Icon(_iconFor(extractor)),
        title: Text(extractor.displayName),
        subtitle: Text(
          widget.unavailablePredefinedTypes.contains(extractor)
              ? S.of(context).notificationsDefinitionAlreadyAdded
              : _descriptionFor(extractor),
          style: context.notificationSupportingText,
        ),
        trailing: widget.unavailablePredefinedTypes.contains(extractor)
            ? null
            : const Icon(Icons.chevron_right),
      );

  IconData _iconFor(PredefinedRegExpDefinition extractor) =>
      switch (extractor) {
        PredefinedRegExpDefinition.notificationTitle => Icons.title,
        PredefinedRegExpDefinition.notificationMessage =>
          Icons.message_outlined,
        PredefinedRegExpDefinition.notificationDate =>
          Icons.calendar_today_outlined,
        PredefinedRegExpDefinition.amount => Icons.payments_outlined,
        PredefinedRegExpDefinition.currency => Icons.currency_exchange,
      };

  String _descriptionFor(PredefinedRegExpDefinition extractor) =>
      switch (extractor) {
        PredefinedRegExpDefinition.notificationTitle =>
          S.of(context).notificationsDefinitionCaptureNotificationTitle,
        PredefinedRegExpDefinition.notificationMessage =>
          S.of(context).notificationsDefinitionCaptureNotificationMessage,
        PredefinedRegExpDefinition.notificationDate =>
          S.of(context).notificationsDefinitionCaptureNotificationDate,
        PredefinedRegExpDefinition.amount =>
          S.of(context).notificationsDefinitionCaptureAmount,
        PredefinedRegExpDefinition.currency =>
          S.of(context).notificationsDefinitionCaptureCurrency,
      };
}
