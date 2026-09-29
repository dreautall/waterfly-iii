import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/actions/notification_action.dart';
import 'package:waterflyiii/notifications/presentation/shared/definition_detail_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';
import 'package:waterflyiii/notifications/domain/planning/automatic_transaction_readiness.dart';
import 'package:waterflyiii/notifications/presentation/definitions/widgets/automatic_transaction_readiness_display.dart';

class DefinitionSharedActionsSection extends StatelessWidget {
  const DefinitionSharedActionsSection({
    super.key,
    required this.actions,
    required this.isBasicMode,
    required this.needsSetup,
    required this.needsReview,
    required this.automaticReadiness,
    required this.createAutomatically,
    required this.onEdit,
  });

  final List<NotificationAction> actions;
  final bool isBasicMode;
  final bool needsSetup;
  final bool needsReview;
  final AutomaticTransactionReadiness automaticReadiness;
  final bool createAutomatically;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final S strings = S.of(context);
    final bool automaticIncomplete =
        createAutomatically && !automaticReadiness.isReady;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          isBasicMode
              ? strings.notificationsRuleActionsTitle
              : strings.notificationsDefinitionSharedActionsTitle,
          style: context.notificationSectionTitle,
        ),
        const SizedBox(height: 4),
        Text(
          isBasicMode
              ? strings.notificationsDefinitionBasicActionsDescription
              : strings.notificationsDefinitionSharedActionsDescription,
          style: context.notificationSectionDescription,
        ),
        const SizedBox(height: 12),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          child: DefinitionDetailCard(
            onTap: onEdit,
            centerAffordances: true,
            leading: Icon(
              automaticIncomplete
                  ? Icons.error_outline
                  : needsSetup
                  ? Icons.error_outline
                  : needsReview
                  ? Icons.error_outline
                  : Icons.layers_outlined,
              color: automaticIncomplete
                  ? colors.tertiary
                  : needsSetup
                  ? colors.error
                  : needsReview
                  ? colors.tertiary
                  : null,
            ),
            title: Text(
              isBasicMode
                  ? strings.notificationsDefinitionSetTransactionFields
                  : strings.notificationsDefinitionSharedTransactionFields,
            ),
            subtitle: AnimatedSwitcher(
              duration: const Duration(milliseconds: 140),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              layoutBuilder: (Widget? current, List<Widget> previous) => Stack(
                alignment: Alignment.centerLeft,
                children: <Widget>[...previous, ?current],
              ),
              child: Text(
                key: ValueKey<bool>(automaticIncomplete),
                automaticIncomplete
                    ? automaticReadiness.message(context)
                    : needsSetup
                    ? isBasicMode
                          ? strings.notificationsDefinitionNoTransactionFields
                          : strings.notificationsDefinitionNoSharedFields
                    : needsReview
                    ? strings.notificationsRuleNeedsReview
                    : strings.notificationsRuleActionCount(actions.length),
                style: automaticIncomplete
                    ? TextStyle(color: colors.tertiary)
                    : needsSetup
                    ? TextStyle(color: colors.error)
                    : needsReview
                    ? TextStyle(color: colors.tertiary)
                    : context.notificationSupportingText,
              ),
            ),
            trailing: const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(Icons.chevron_right),
            ),
          ),
        ),
      ],
    );
  }
}
