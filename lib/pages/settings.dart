import 'package:animations/animations.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 24),
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

class SettingsNotifications extends StatefulWidget {
  const SettingsNotifications({
    super.key,
  });

  @override
  State<SettingsNotifications> createState() => _SettingsNotificationsState();
}

class _SettingsNotificationsState extends State<SettingsNotifications> {
  NotificationListenerStatus? status;

  @override
  void initState() {
    super.initState();
  }

  Future<NotificationListenerStatus> updateStatus() async {
    status = await nlStatus();
    return status!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification Service"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(S.of(context).settingsNLDescription),
          ),
          const Divider(),
          FutureBuilder<NotificationListenerStatus>(
            future: updateStatus(),
            builder: (BuildContext context,
                AsyncSnapshot<NotificationListenerStatus> snapshot) {
              final S l10n = S.of(context);
              final ScaffoldMessengerState msg = ScaffoldMessenger.of(context);

              late String subtitle;
              late Function clickFn;
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                if (!snapshot.data!.servicePermission) {
                  subtitle = l10n.settingsNLPermissionGrant;
                  clickFn = () async {
                    bool granted = await FlutterLocalNotificationsPlugin()
                            .resolvePlatformSpecificImplementation<
                                AndroidFlutterLocalNotificationsPlugin>()!
                            .requestPermission() ??
                        false;
                    if (!granted) {
                      msg.showSnackBar(SnackBar(
                        content: Text(l10n.settingsNLPermissionNotGranted),
                        behavior: SnackBarBehavior.floating,
                      ));
                      return;
                    }
                    await NotificationServicePlugin.instance
                        .requestPermissionsIfDenied();
                    await nlInit();
                  };
                } else if (!snapshot.data!.notificationPermission) {
                  subtitle = l10n.settingsNLPermissionGrant;
                  clickFn = () async {
                    await FlutterLocalNotificationsPlugin()
                        .resolvePlatformSpecificImplementation<
                            AndroidFlutterLocalNotificationsPlugin>()!
                        .requestPermission();
                  };
                } else if (!snapshot.data!.serviceRunning) {
                  subtitle = l10n.settingsNLServiceStopped;
                  clickFn = () async {
                    await NotificationServicePlugin.instance.startService();
                  };
                } else {
                  subtitle = l10n.settingsNLServiceRunning;
                  clickFn = () async {
                    final bool? ok = await showDialog<bool>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        icon: const Icon(Icons.remove_done),
                        title: Text(S.of(context).settingsNLPermissionRemove),
                        clipBehavior: Clip.hardEdge,
                        actions: <Widget>[
                          TextButton(
                            child: Text(S.of(context).formButtonCancel),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          FilledButton(
                            child: Text(S.of(context).formButtonRemove),
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                          ),
                        ],
                        content:
                            Text(S.of(context).settingsNLPermissionRemoveHelp),
                      ),
                    );
                    if (!(ok ?? false)) {
                      return;
                    }
                    await NotificationServicePlugin.instance
                        .requestServicePermission();
                  };
                }
              } else if (snapshot.hasError) {
                subtitle = S
                    .of(context)
                    .settingsNLServiceCheckingError(snapshot.error.toString());
              } else {
                subtitle = S.of(context).settingsNLServiceChecking;
              }
              return ListTile(
                title: const Text("Service Status"),
                subtitle: Text(
                  subtitle,
                  maxLines: 2,
                ),
                onTap: () async {
                  await clickFn();
                  setState(() {});
                },
                trailing: snapshot.data != null
                    ? Switch(
                        thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return const Icon(Icons.check);
                            }
                            return const Icon(Icons.close);
                          },
                        ),
                        value: snapshot.data!.serviceRunning,
                        onChanged: snapshot.data!.servicePermission
                            ? (_) async {
                                await clickFn();
                                setState(() {});
                              }
                            : null,
                      )
                    : null,
              );
            },
          ),
          const Divider(),
          FutureBuilder<List<String>>(
            future:
                Provider.of<SettingsProvider>(context).notificationKnownApps(),
            builder:
                (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ...snapshot.data!.map(
                      (String e) {
                        return Card(
                          clipBehavior: Clip.hardEdge,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(e),
                          ),
                        );
                      },
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text(S
                    .of(context)
                    .settingsNLServiceCheckingError(snapshot.error.toString()));
              } else {
                return Text(S.of(context).settingsNLServiceChecking);
              }
            },
          ),
          const Divider(),
          if (status != null &&
              status!.serviceRunning &&
              status!.notificationPermission) ...<Widget>[
            const Divider(),
            const Text("yay"),
          ],
        ],
      ),
    );
  }
}
