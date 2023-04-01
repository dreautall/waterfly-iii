import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notifications_listener_service/notifications_listener_service.dart';

import 'package:waterflyiii/settings.dart';
import 'package:waterflyiii/notificationlistener.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    debugPrint("settings build()");

    final SettingsProvider settings = Provider.of<SettingsProvider>(context);

    return ListView(
      padding: const EdgeInsets.all(24),
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
                  settings.getTheme.toString().split('.').last,
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
            final ScaffoldMessengerState msg = ScaffoldMessenger.of(context);
            final S l10n = S.of(context);

            late String subtitle;
            Function? clickFn;
            bool permissionsGranted = false;
            bool isRunning = false;
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              if (!snapshot.data!.servicePermission) {
                subtitle = l10n.settingsPermissionGrant;
                clickFn = () async {
                  bool granted = await FlutterLocalNotificationsPlugin()
                          .resolvePlatformSpecificImplementation<
                              AndroidFlutterLocalNotificationsPlugin>()!
                          .requestPermission() ??
                      false;
                  if (!granted) {
                    msg.showSnackBar(SnackBar(
                      content: Text(l10n.settingsPermissionNotGranted),
                      behavior: SnackBarBehavior.floating,
                    ));
                    return;
                  }
                  await NotificationServicePlugin.instance
                      .requestPermissionsIfDenied();
                  await nlInit();
                };
              } else if (!snapshot.data!.notificationPermission) {
                subtitle = l10n.settingsPermissionGrant;
                clickFn = FlutterLocalNotificationsPlugin()
                    .resolvePlatformSpecificImplementation<
                        AndroidFlutterLocalNotificationsPlugin>()!
                    .requestPermission;
              } else if (!snapshot.data!.serviceRunning) {
                subtitle = l10n.settingsServiceStopped;
                permissionsGranted = true;
              } else {
                subtitle = l10n.settingsServiceRunning;
                permissionsGranted = true;
                isRunning = true;
              }
            } else if (snapshot.hasError) {
              subtitle = S
                  .of(context)
                  .settingsServiceCheckingError(snapshot.error.toString());
            } else {
              subtitle = S.of(context).settingsServiceChecking;
            }
            return ListTile(
              title: Text(S.of(context).settingsNotificationListener),
              subtitle: Text(
                subtitle,
                maxLines: 2,
              ),
              leading: const CircleAvatar(
                child: Icon(Icons.notifications),
              ),
              onTap: clickFn != null
                  ? () async {
                      await clickFn!();
                      setState(() {});
                    }
                  : null,
              // :TODO: stopService not working currently
              /*trailing: Switch(
                thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return const Icon(Icons.check);
                    }
                    return const Icon(Icons.close);
                  },
                ),
                value: isRunning,
                onChanged: permissionsGranted
                    ? (bool value) async {
                        if (value) {
                          debugPrint("Starting Service");
                          await NotificationServicePlugin.instance
                              .startService();
                        } else {
                          debugPrint("Stopping Service");
                          await NotificationServicePlugin.instance
                              .stopService();
                        }
                        setState(() {});
                      }
                    : null,
              ),*/
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
    final SettingsProvider settings = Provider.of<SettingsProvider>(context);
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
