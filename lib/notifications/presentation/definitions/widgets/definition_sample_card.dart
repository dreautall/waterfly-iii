import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/presentation/shared/sample_notification_card.dart';

class DefinitionSampleCard extends StatelessWidget {
  const DefinitionSampleCard({
    super.key,
    required this.applicationId,
    required this.title,
    required this.body,
    required this.receivedAt,
    required this.onEdit,
  });

  final String applicationId;
  final String title;
  final String body;
  final DateTime? receivedAt;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final bool hasSample = title.trim().isNotEmpty && body.trim().isNotEmpty;
    return SampleNotificationCard(
      applicationId: applicationId,
      title: hasSample
          ? title
          : S.of(context).notificationsDefinitionSampleNotification,
      body: hasSample
          ? body
          : S.of(context).notificationsDefinitionSampleRequired,
      receivedAt: hasSample ? receivedAt : null,
      onTap: onEdit,
      trailing: IconButton(
        tooltip: S.of(context).notificationsDefinitionEditSample,
        onPressed: onEdit,
        icon: const Icon(Icons.edit_outlined),
        iconSize: 18,
      ),
    );
  }
}
