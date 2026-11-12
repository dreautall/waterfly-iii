import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/presentation/shared/dialog_selector_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_empty_state.dart';

class ExtractorCaptureOption {
  const ExtractorCaptureOption({
    required this.extractor,
    required this.subtitle,
    required this.onTap,
  });

  final RegExpDefinition extractor;
  final Widget subtitle;
  final VoidCallback onTap;
}

class ExtractorCaptureOptionList extends StatelessWidget {
  const ExtractorCaptureOptionList({
    super.key,
    required this.options,
    this.listKey,
    this.emptyMessage = 'No matching extractor captures are available.',
  });

  final List<ExtractorCaptureOption> options;
  final Key? listKey;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    if (options.isEmpty) {
      return NotificationInlineEmptyState(message: emptyMessage);
    }
    return Column(
      key: listKey,
      children: options
          .map(
            (ExtractorCaptureOption option) => DialogSelectorCard(
              margin: const EdgeInsets.only(bottom: 8),
              leading: const Icon(Icons.text_fields_outlined),
              title: Text(option.extractor.definitionName),
              subtitle: option.subtitle,
              trailing: const Icon(Icons.chevron_right),
              onTap: option.onTap,
            ),
          )
          .toList(),
    );
  }
}
