import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_empty_state.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';

class RuleEditorSection extends StatelessWidget {
  const RuleEditorSection({
    super.key,
    required this.title,
    required this.description,
    required this.content,
    this.action,
  });

  final String title;
  final String description;
  final Widget content;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final Widget? action = this.action;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: context.notificationSectionTitle),
        const SizedBox(height: 4),
        Text(description, style: context.notificationSectionDescription),
        const SizedBox(height: 12),
        content,
        if (action != null) ...<Widget>[const SizedBox(height: 8), action],
      ],
    );
  }
}

class RuleEditorEmptyState extends StatelessWidget {
  const RuleEditorEmptyState(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) =>
      NotificationInlineEmptyState(message: text);
}
