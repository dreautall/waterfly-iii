import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'package:package_info_plus/package_info_plus.dart';

import 'package:waterflyiii/notificationlistener.dart';
import 'package:waterflyiii/pages/settings/notifications.dart';
import 'package:waterflyiii/settings.dart';

final Logger log = Logger("Pages.Settings");

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage>
    with SingleTickerProviderStateMixin {
  final Logger log = Logger("Pages.Settings.Page");

  @override
  Widget build(BuildContext context) {
    log.finest(() => "build()");

    final SettingsProvider settings = context.read<SettingsProvider>();

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      primary: false,
      children: <Widget>[
        ListTile(
          title: Text(S.of(context).settingsLanguage),
          subtitle: Text(S.of(context).localeName),
          leading: const CircleAvatar(
            child: Icon(Icons.language),
          ),
          onTap: () {
            showDialog<Locale?>(
              context: context,
              builder: (BuildContext context) => const LanguageDialog(),
            ).then((Locale? locale) {
              if (locale == null) {
                return;
              }
              settings.setLocale(locale);
            });
          },
        ),
        ListTile(
          title: Text(S.of(context).settingsTheme),
          subtitle: Text(
            S.of(context).settingsThemeValue(
                  context
                      .select((SettingsProvider s) => s.getTheme)
                      .toString()
                      .split('.')
                      .last,
                ),
          ),
          leading: const CircleAvatar(
            child: Icon(Icons.format_paint),
          ),
          onTap: () {
            showDialog<ThemeMode?>(
              context: context,
              builder: (BuildContext context) => const ThemeDialog(),
            ).then((ThemeMode? theme) {
              if (theme == null) {
                return;
              }
              settings.setTheme(theme);
            });
          },
        ),
        const Divider(),
        FutureBuilder<NotificationListenerStatus>(
          future: nlStatus(),
          builder: (BuildContext context,
              AsyncSnapshot<NotificationListenerStatus> snapshot) {
            final S l10n = S.of(context);

            late String subtitle;
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              if (!snapshot.data!.servicePermission ||
                  !snapshot.data!.notificationPermission) {
                subtitle = l10n.settingsNLPermissionNotGranted;
              } else if (!snapshot.data!.serviceRunning) {
                subtitle = l10n.settingsNLServiceStopped;
              } else {
                subtitle = l10n.settingsNLServiceRunning;
              }
            } else if (snapshot.hasError) {
              subtitle = S
                  .of(context)
                  .settingsNLServiceCheckingError(snapshot.error.toString());
            } else {
              subtitle = S.of(context).settingsNLServiceChecking;
            }
            return OpenContainer(
              openBuilder: (BuildContext context, Function closedContainer) =>
                  const SettingsNotifications(),
              openColor: Theme.of(context).cardColor,
              closedColor: Theme.of(context).cardColor,
              closedElevation: 0,
              closedBuilder: (BuildContext context, Function openContainer) =>
                  ListTile(
                title: Text(S.of(context).settingsNotificationListener),
                subtitle: Text(
                  subtitle,
                  maxLines: 2,
                ),
                leading: const CircleAvatar(
                  child: Icon(Icons.notifications),
                ),
                onTap: () => openContainer(),
              ),
              onClosed: (_) => setState(() {}),
            );
          },
        ),
        const Divider(),
        FutureBuilder<PackageInfo>(
          future: PackageInfo.fromPlatform(),
          builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
            return ListTile(
              title: Text(S.of(context).settingsVersion),
              subtitle: Text((snapshot.data != null)
                  ? "${snapshot.data!.appName}, ${snapshot.data!.version}+${snapshot.data!.buildNumber}"
                  : S.of(context).settingsVersionChecking),
              leading: const CircleAvatar(
                child: Icon(Icons.info_outline_rounded),
              ),
            );
          },
        ),
      ],
    );
  }
}

class LanguageDialog extends StatelessWidget {
  const LanguageDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(S.of(context).settingsDialogLanguageTitle),
      children: <Widget>[
        ...S.supportedLocales.map(
          (Locale locale) => RadioListTile<String>(
            value: locale.languageCode,
            title: Text(locale.toLanguageTag()),
            groupValue: S.of(context).localeName,
            onChanged: (_) {
              Navigator.pop(context, locale);
            },
          ),
        ),
      ],
    );
  }
}

class ThemeDialog extends StatelessWidget {
  const ThemeDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final SettingsProvider settings = context.read<SettingsProvider>();
    return SimpleDialog(
      title: Text(S.of(context).settingsDialogThemeTitle),
      children: <Widget>[
        ...ThemeMode.values.map(
          (ThemeMode theme) => RadioListTile<ThemeMode>(
            value: theme,
            title: Text(
              S
                  .of(context)
                  .settingsThemeValue(theme.toString().split('.').last),
            ),
            groupValue: settings.getTheme,
            onChanged: (_) {
              Navigator.pop(context, theme);
            },
          ),
        ),
      ],
    );
  }
}
