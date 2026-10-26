import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/planning/automatic_transaction_readiness.dart';

extension AutomaticTransactionReadinessDisplay
    on AutomaticTransactionReadiness {
  String message(BuildContext context) {
    final S strings = S.of(context);
    final List<String> requirements = <String>[
      for (final AutomaticTransactionRequirement requirement
          in AutomaticTransactionRequirement.values)
        if (missingRequirements.contains(requirement))
          switch (requirement) {
            AutomaticTransactionRequirement.title =>
              strings.notificationsDefinitionAutomaticRequirementTitle,
            AutomaticTransactionRequirement.positiveAmount =>
              strings.notificationsDefinitionAutomaticRequirementAmount,
            AutomaticTransactionRequirement.account =>
              strings.notificationsDefinitionAutomaticRequirementAccount,
          },
    ];
    return strings.notificationsDefinitionAutomaticIncomplete(
      requirements.join(', '),
    );
  }
}
