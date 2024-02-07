import 'package:animations/animations.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logging/logging.dart';
import 'package:material_color_utilities/material_color_utilities.dart'
    show CorePalette;
import 'package:provider/provider.dart';

import 'package:local_auth/local_auth.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:quick_actions/quick_actions.dart';

import 'package:waterflyiii/notificationlistener.dart';
import 'package:waterflyiii/pages/settings/debug.dart';
import 'package:waterflyiii/pages/settings/notifications.dart';
import 'package:waterflyiii/services/firefly_api_service.dart';
import 'package:waterflyiii/settings.dart';

final Logger log = Logger("Pages.Settings");

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

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
            ).then((Locale? locale) async {
              if (locale == null) {
                return;
              }
              await settings.setLocale(locale);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                const QuickActions().setShortcutItems(
                  <ShortcutItem>[
                    ShortcutItem(
                      type: "action_transaction_add",
                      localizedTitle: S.of(context).transactionTitleAdd,
                      icon: "action_icon_add",
                    ),
                  ],
                );
              });
            });
          },
        ),
        FutureBuilder<CorePalette?>(
          future: DynamicColorPlugin.getCorePalette(),
          builder:
              (BuildContext context, AsyncSnapshot<CorePalette?> snapshot) {
            String dynamicColor = "";
            bool dynamicColorAvailable = false;
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData &&
                snapshot.data != null) {
              // Dynamic color support available
              dynamicColorAvailable = true;
              if (context.select((SettingsProvider s) => s.dynamicColors)) {
                dynamicColor = " - ${S.of(context).settingsThemeDynamicColors}";
              }
            }
            return ListTile(
              title: Text(S.of(context).settingsTheme),
              subtitle: Text(
                "${S.of(context).settingsThemeValue(context.select((SettingsProvider s) => s.theme).toString().split('.').last)}$dynamicColor",
              ),
              leading: const CircleAvatar(
                child: Icon(Icons.format_paint),
              ),
              onTap: () {
                showDialog<ThemeMode?>(
                  context: context,
                  builder: (BuildContext context) => ThemeDialog(
                    dynamicColorAvailable: dynamicColorAvailable,
                  ),
                ).then((ThemeMode? theme) {
                  if (theme == null) {
                    return;
                  }
                  settings.setTheme(theme);
                });
              },
            );
          },
        ),
        SwitchListTile(
          title: Text(S.of(context).settingsUseServerTimezone),
          subtitle: Text(S.of(context).settingsUseServerTimezoneHelp),
          value: context.select((SettingsProvider s) => s.useServerTime),
          secondary: CircleAvatar(
            child: Icon(
              context.select((SettingsProvider s) => s.useServerTime)
                  ? Icons.schedule
                  : Icons.schedule_outlined,
            ),
          ),
          onChanged: (bool value) async {
            await context
                .read<FireflyService>()
                .tzHandler
                .setUseServerTime(value);
            await settings.setUseServerTime(value);
          },
        ),
        const Divider(),
        SwitchListTile(
          title: Text(S.of(context).settingsLockscreen),
          subtitle: Text(S.of(context).settingsLockscreenHelp),
          value: context.select((SettingsProvider s) => s.lock),
          secondary: CircleAvatar(
            child: Icon(
              context.select((SettingsProvider s) => s.lock)
                  ? Icons.lock
                  : Icons.lock_outline,
            ),
          ),
          onChanged: (bool value) async {
            final S l10n = S.of(context);
            if (value == true) {
              final LocalAuthentication auth = LocalAuthentication();
              final bool canAuth = await auth.isDeviceSupported() ||
                  await auth.canCheckBiometrics;
              if (!canAuth) {
                log.warning("no auth method supported");
                return;
              }
              log.finest("trying authentication");
              final bool authed = await auth.authenticate(
                localizedReason:
                    l10n.settingsLockscreenInitial, // :TODO: translate
              );
              if (!authed) {
                log.warning("authentication was cancelled");
                return;
              }
            }
            settings.setLock(value);
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
              log.severe("error getting nlStatus", snapshot.error,
                  snapshot.stackTrace);
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
                child: Icon(
                  Icons.info_outline_rounded,
                ),
              ),
              onTap: () => showDialog(
                context: context,
                builder: (BuildContext context) => const DebugDialog(),
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
    required this.dynamicColorAvailable,
  });

  final bool dynamicColorAvailable;

  @override
  Widget build(BuildContext context) {
    final SettingsProvider settings = context.read<SettingsProvider>();
    return SimpleDialog(
      title: Text(S.of(context).settingsDialogThemeTitle),
      children: <Widget>[
        dynamicColorAvailable
            ? SwitchListTile(
                title: Text(S.of(context).settingsThemeDynamicColors),
                value: context.select((SettingsProvider s) => s.dynamicColors),
                isThreeLine: false,
                onChanged: (bool value) async {
                  settings.setDynamicColors(value);
                },
              )
            : const SizedBox.shrink(),
        ...ThemeMode.values.map(
          (ThemeMode theme) => RadioListTile<ThemeMode>(
            value: theme,
            title: Text(
              S
                  .of(context)
                  .settingsThemeValue(theme.toString().split('.').last),
            ),
            groupValue: settings.theme,
            onChanged: (_) {
              Navigator.pop(context, theme);
            },
          ),
        ),
      ],
    );
  }
}
