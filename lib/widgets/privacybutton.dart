import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/settings.dart';

class PrivacyButton extends StatelessWidget {
  const PrivacyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingsProvider>.value(
      value: context.read<SettingsProvider>(),
      builder: (BuildContext context, _) => IconButton(
        icon: const Icon(Icons.visibility),
        selectedIcon: const Icon(Icons.visibility_off),
        isSelected: context.watch<SettingsProvider>().privacyMode,
        tooltip: S.of(context).homeMainActionPrivacyMode,
        onPressed: () {
          context.read<SettingsProvider>().setPrivacyMode(
            !SettingsProvider.isPrivacyMode,
          );
        },
      ),
    );
  }
}
