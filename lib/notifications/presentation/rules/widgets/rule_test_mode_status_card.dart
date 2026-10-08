import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/presentation/shared/message_status_card.dart';

class RuleTestModeStatusCard extends StatelessWidget {
  const RuleTestModeStatusCard({super.key});

  @override
  Widget build(BuildContext context) => MessageStatusCard(
    status: MessageStatus.informational,
    title: S.of(context).notificationsRuleTestMode,
    message: S.of(context).notificationsRuleTestModeMessage,
  );
}
