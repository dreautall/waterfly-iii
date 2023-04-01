import 'dart:convert';

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
        const Divider(),
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
        ListTile(
          title: const Text("Notification Listener Permission"),
          subtitle: FutureBuilder<bool>(
            future:
                NotificationServicePlugin.instance.isServicePermissionGranted(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Text("Granted? ${snapshot.data}");
              } else if (snapshot.hasError) {
                return Text("Error checking: ${snapshot.error}");
              } else {
                return const Text("Checking if granted...");
              }
            },
          ),
          leading: const CircleAvatar(
            child: Icon(Icons.notifications),
          ),
          onTap: () async {
            FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
                FlutterLocalNotificationsPlugin();
            flutterLocalNotificationsPlugin
                .resolvePlatformSpecificImplementation<
                    AndroidFlutterLocalNotificationsPlugin>()!
                .requestPermission();
            await NotificationServicePlugin.instance.requestServicePermission();
            nlInit();
            setState(() {});
          },
        ),
        ListTile(
          title: const Text("Notification Listener Service"),
          subtitle: FutureBuilder<bool>(
            future: NotificationServicePlugin.instance.isServiceRunning(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Text("Running? ${snapshot.data}");
              } else if (snapshot.hasError) {
                return Text("Error checking: ${snapshot.error}");
              } else {
                return const Text("Checking if running...");
              }
            },
          ),
          leading: const CircleAvatar(
            child: Icon(Icons.notifications),
          ),
          onTap: () async {
            await NotificationServicePlugin.instance.startService();
          },
        ),
        const Divider(),
        ListTile(
          title: const Text("Notification Debug"),
          leading: const CircleAvatar(
            child: Icon(Icons.start),
          ),
          onTap: () async {
            final FlutterLocalNotificationsPlugin
                flutterLocalNotificationsPlugin =
                FlutterLocalNotificationsPlugin();
            const AndroidInitializationSettings initializationSettingsAndroid =
                AndroidInitializationSettings('ic_launcher');
            const InitializationSettings initializationSettings =
                InitializationSettings(
              android: initializationSettingsAndroid,
            );
            await flutterLocalNotificationsPlugin.initialize(
              initializationSettings,
              onDidReceiveNotificationResponse: nlNotificationTap,
              onDidReceiveBackgroundNotificationResponse: nlNotificationTap,
            );

            flutterLocalNotificationsPlugin.show(
              0,
              "Testladen 1234",
              "€12.34 with Barclays",
              const NotificationDetails(
                android: AndroidNotificationDetails(
                  'debug',
                  'Debug Notificiations',
                  channelDescription: 'Debugging stuff',
                  importance: Importance.max,
                  priority: Priority.high,
                ),
              ),
              payload: jsonEncode(NotificationTransaction(
                "com.dummy.pay",
                "Testladen 1234",
                "12.34 USD with Barclays",
                DateTime.now(),
              )),
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
