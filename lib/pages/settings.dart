import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:waterflyiii/settings.dart';
import 'package:waterflyiii/notificationlistener.dart';

import 'package:notification_listener_service/notification_listener_service.dart';

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
          title: const Text("Notification Listener Service"),
          subtitle: FutureBuilder<bool>(
            future: NotificationListenerService.isPermissionGranted(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Text("Enabled? ${snapshot.data!}");
              } else if (snapshot.hasError) {
                return Text("Error checking: ${snapshot.error}");
              } else {
                return const Text("Checking if enabled...");
              }
            },
          ),
          leading: const CircleAvatar(
            child: Icon(Icons.notifications),
          ),
          onTap: () async {
            final bool granted =
                await NotificationListenerService.requestPermission();
            debugPrint("granted? $granted");
            if (!granted) {
              return;
            }
            setState(() {});
          },
        ),
        const Divider(),
        ListTile(
          title: const Text("Background Service Debug Start"),
          leading: const CircleAvatar(
            child: Icon(Icons.start),
          ),
          onTap: () async {
            bgsvcStart();
          },
        ),
        ListTile(
          title: const Text("Background Service Debug Stop"),
          leading: const CircleAvatar(
            child: Icon(Icons.start),
          ),
          onTap: () async {
            bgsvcStop();
          },
        ),
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
                InitializationSettings(android: initializationSettingsAndroid);
            await flutterLocalNotificationsPlugin
                .initialize(initializationSettings);

            flutterLocalNotificationsPlugin.show(
              0,
              "TestTitle",
              "TestSubtitle",
              const NotificationDetails(
                android: AndroidNotificationDetails(
                  'waterflyiii_debug',
                  'Debug Notificiations',
                  channelDescription: 'Debugging stuff',
                  importance: Importance.max,
                  priority: Priority.high,
                  ticker: 'ticker',
                ),
              ),
              payload: "TestPayload",
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
