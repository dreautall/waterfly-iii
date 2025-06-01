import 'package:animations/animations.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:local_auth/local_auth.dart';
import 'package:logging/logging.dart';
import 'package:material_color_utilities/material_color_utilities.dart'
    show CorePalette;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notificationlistener.dart';
import 'package:waterflyiii/pages/settings/debug.dart';
import 'package:waterflyiii/pages/settings/notifications.dart';
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
          subtitle: Text(
            LocaleNames.of(context)!.nameOf(S.of(context).localeName) ??
                "Unknown locale",
          ),
          leading: const CircleAvatar(child: Icon(Icons.language)),
          onTap: () {
            showDialog<Locale?>(
              context: context,
              builder:
                  (BuildContext context) =>
                      const LanguageDialog(localeFormatMode: false),
            ).then((Locale? locale) async {
              if (locale == null) {
                return;
              }
              await settings.setLocale(locale);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                const QuickActions().setShortcutItems(<ShortcutItem>[
                  ShortcutItem(
                    type: "action_transaction_add",
                    localizedTitle: S.of(context).transactionTitleAdd,
                    icon: "action_icon_add",
                  ),
                ]);
              });
            });
          },
        ),
        ListTile(
          title: Text(S.of(context).settingsLocaleFormat),
          subtitle: Text(
            LocaleNames.of(context)!.nameOf(
                  context.read<SettingsProvider>().localeFormat?.languageCode ??
                      "",
                ) ??
                "Unknown locale",
          ),
          leading: const CircleAvatar(child: Icon(Icons.date_range)),
          onTap: () {
            showDialog<Locale?>(
              context: context,
              builder:
                  (BuildContext context) =>
                      const LanguageDialog(localeFormatMode: true),
            ).then((Locale? localeFormat) async {
              if (localeFormat == null) {
                return;
              }
              await settings.setLocaleFormat(localeFormat);
              setState(() {});
            });
          },
        ),
        FutureBuilder<CorePalette?>(
          future: DynamicColorPlugin.getCorePalette(),
          builder: (
            BuildContext context,
            AsyncSnapshot<CorePalette?> snapshot,
          ) {
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
              leading: const CircleAvatar(child: Icon(Icons.format_paint)),
              onTap: () {
                showDialog<ThemeMode?>(
                  context: context,
                  builder:
                      (BuildContext context) => ThemeDialog(
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
            await context.read<FireflyService>().tzHandler.setUseServerTime(
              value,
            );
            settings.useServerTime = value;
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
            final ScaffoldMessengerState msg = ScaffoldMessenger.of(context);
            if (value == true) {
              final LocalAuthentication auth = LocalAuthentication();
              final bool canAuth =
                  await auth.isDeviceSupported() ||
                  await auth.canCheckBiometrics;
              if (!canAuth) {
                log.warning("no auth method supported");
                return;
              }
              log.finest("trying authentication");
              late bool authed;
              try {
                authed = await auth.authenticate(
                  localizedReason: l10n.settingsLockscreenInitial,
                );
              } catch (e, stackTrace) {
                log.severe("auth failed", e, stackTrace);
                msg.showSnackBar(
                  SnackBar(
                    content: Text(l10n.errorUnknown),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                return;
              }

              if (!authed) {
                log.warning("authentication was cancelled");
                return;
              }
            }
            settings.lock = value;
          },
        ),
        const Divider(),
        FutureBuilder<NotificationListenerStatus>(
          future: nlStatus(),
          builder: (
            BuildContext context,
            AsyncSnapshot<NotificationListenerStatus> snapshot,
          ) {
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
              log.severe(
                "error getting nlStatus",
                snapshot.error,
                snapshot.stackTrace,
              );
              subtitle = S
                  .of(context)
                  .settingsNLServiceCheckingError(snapshot.error.toString());
            } else {
              subtitle = S.of(context).settingsNLServiceChecking;
            }
            return OpenContainer(
              openBuilder:
                  (BuildContext context, Function closedContainer) =>
                      const SettingsNotifications(),
              openColor: Theme.of(context).cardColor,
              closedColor: Theme.of(context).cardColor,
              closedElevation: 0,
              closedBuilder:
                  (BuildContext context, Function openContainer) => ListTile(
                    title: Text(S.of(context).settingsNotificationListener),
                    subtitle: Text(subtitle, maxLines: 2),
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
        ListTile(
          title: Text(S.of(context).settingsFAQ),
          subtitle: Text(S.of(context).settingsFAQHelp),
          leading: const CircleAvatar(child: Icon(Icons.question_answer)),
          onTap: () async {
            final Uri uri = Uri.parse(
              "https://github.com/dreautall/waterfly-iii/blob/master/FAQ.md",
            );
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            } else {
              throw Exception("Could not open URL");
            }
          },
        ),
        FutureBuilder<PackageInfo>(
          future: PackageInfo.fromPlatform(),
          builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
            return ListTile(
              title: Text(S.of(context).settingsVersion),
              subtitle: Text(
                (snapshot.data != null)
                    ? "${snapshot.data!.appName}, ${snapshot.data!.version}+${snapshot.data!.buildNumber}"
                    : S.of(context).settingsVersionChecking,
              ),
              leading: const CircleAvatar(
                child: Icon(Icons.info_outline_rounded),
              ),
              onTap:
                  () => showDialog(
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
  final bool localeFormatMode;

  const LanguageDialog({super.key, required this.localeFormatMode});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        localeFormatMode
            ? S.of(context).settingsDialogLocaleFormatTitle
            : S.of(context).settingsDialogLanguageTitle,
      ),
      children: <Widget>[
        ...S.supportedLocales.map(
          (Locale locale) => RadioListTile<String>(
            value: locale.languageCode,
            title: Text(
              LocaleNamesLocalizationsDelegate.nativeLocaleNames[locale
                      .toLanguageTag()] ??
                  "Unknown locale",
            ),
            groupValue:
                localeFormatMode
                    ? context
                        .read<SettingsProvider>()
                        .localeFormat
                        ?.languageCode
                    : S.of(context).localeName,
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
  const ThemeDialog({super.key, required this.dynamicColorAvailable});

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
              onChanged: (bool value) => settings.dynamicColors = value,
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
