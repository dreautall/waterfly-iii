import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/planning/automatic_transaction_readiness.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/rules/notification_rule_processing_mode.dart';
import 'package:waterflyiii/notifications/presentation/definitions/widgets/automatic_transaction_readiness_display.dart';
import 'package:waterflyiii/notifications/presentation/shared/message_status_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_choice_setting_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';

class RuleOptionsSection extends StatelessWidget {
  const RuleOptionsSection({
    super.key,
    required this.processingMode,
    required this.applicationMode,
    required this.automaticReadiness,
    required this.onChanged,
  });

  final NotificationRuleProcessingMode processingMode;
  final TransactionCreationMode applicationMode;
  final AutomaticTransactionReadiness automaticReadiness;
  final ValueChanged<NotificationRuleProcessingMode> onChanged;

  @override
  Widget build(BuildContext context) {
    final bool ignored = processingMode.ignoresNotification;
    return Column(
      key: const Key('rule-options-section'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          S.of(context).notificationsRuleOptionsHeading,
          style: context.notificationSectionTitle,
        ),
        const SizedBox(height: 4),
        Text(
          S.of(context).notificationsRuleOptionsDescription,
          style: context.notificationSectionDescription,
        ),
        const SizedBox(height: 12),
        NotificationChoiceSettingCard<NotificationRuleProcessingMode>(
          leading: const Icon(Icons.rule_outlined),
          title: S.of(context).notificationsRuleOutcome,
          subtitle: _selectedDescription(context),
          dialogTitle: S.of(context).notificationsRuleOutcome,
          value: processingMode,
          options: <NotificationChoiceOption<NotificationRuleProcessingMode>>[
            NotificationChoiceOption<NotificationRuleProcessingMode>(
              value: NotificationRuleProcessingMode.inherit,
              label: S.of(context).notificationsRuleModeUseApplication,
              description: S
                  .of(context)
                  .notificationsRuleModeUseApplicationDescription(
                    _applicationModeLabel(context),
                  ),
            ),
            NotificationChoiceOption<NotificationRuleProcessingMode>(
              value: NotificationRuleProcessingMode.prompt,
              label: S.of(context).notificationsRuleModePrompt,
              description: S.of(context).notificationsRuleModePromptDescription,
            ),
            NotificationChoiceOption<NotificationRuleProcessingMode>(
              value: NotificationRuleProcessingMode.automatic,
              label: S.of(context).notificationsRuleModeAutomatic,
              description: S
                  .of(context)
                  .notificationsRuleModeAutomaticDescription,
            ),
            NotificationChoiceOption<NotificationRuleProcessingMode>(
              value: NotificationRuleProcessingMode.ignore,
              label: S.of(context).notificationsRuleModeIgnore,
              description: S.of(context).notificationsRuleModeIgnoreDescription,
            ),
          ],
          onChanged: onChanged,
        ),
        if (ignored) ...<Widget>[
          const SizedBox(height: 12),
          MessageStatusCard(
            key: const Key('rule-ignored-status'),
            status: MessageStatus.informational,
            title: S.of(context).notificationsRuleIgnoredTitle,
            message: S.of(context).notificationsRuleIgnoredMessage,
          ),
        ] else if (processingMode ==
            NotificationRuleProcessingMode.automatic) ...<Widget>[
          const SizedBox(height: 12),
          MessageStatusCard(
            key: const Key('rule-automatic-status'),
            status: automaticReadiness.isReady
                ? MessageStatus.informational
                : MessageStatus.review,
            title: automaticReadiness.isReady
                ? S.of(context).notificationsRuleAutomaticReadyTitle
                : S.of(context).notificationsRuleAutomaticIncompleteTitle,
            message: automaticReadiness.isReady
                ? S.of(context).notificationsRuleAutomaticReadyMessage
                : automaticReadiness.message(context),
          ),
        ],
      ],
    );
  }

  String _selectedDescription(BuildContext context) => switch (processingMode) {
    NotificationRuleProcessingMode.inherit =>
      S
          .of(context)
          .notificationsRuleModeUseApplicationDescription(
            _applicationModeLabel(context),
          ),
    NotificationRuleProcessingMode.prompt =>
      S.of(context).notificationsRuleModePromptDescription,
    NotificationRuleProcessingMode.automatic =>
      S.of(context).notificationsRuleModeAutomaticDescription,
    NotificationRuleProcessingMode.ignore =>
      S.of(context).notificationsRuleModeIgnoreDescription,
  };

  String _applicationModeLabel(BuildContext context) =>
      switch (applicationMode) {
        TransactionCreationMode.prompt =>
          S.of(context).notificationsRuleModePrompt,
        TransactionCreationMode.automatic =>
          S.of(context).notificationsRuleModeAutomatic,
      };
}
