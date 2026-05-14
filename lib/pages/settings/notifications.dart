import 'package:animations/animations.dart';
import 'package:appcheck/appcheck.dart';
import 'package:chopper/chopper.dart' show Response;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logging/logging.dart';
import 'package:notifications_listener_service/notifications_listener_service.dart';
import 'package:provider/provider.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/notificationlistener.dart';
import 'package:waterflyiii/pages/settings/notifications/history.dart';
import 'package:waterflyiii/settings.dart';
import 'package:waterflyiii/widgets/erroricon.dart';

class SettingsNotifications extends StatefulWidget {
  const SettingsNotifications({super.key});

  @override
  State<SettingsNotifications> createState() => _SettingsNotificationsState();
}

class _SettingsNotificationsState extends State<SettingsNotifications> {
  NotificationListenerStatus? status;
  final Logger log = Logger("Notifications.Settings");

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
      appBar: AppBar(title: Text(S.of(context).settingsNotificationListener)),
      body: ListView(
        padding: const .symmetric(horizontal: 24),
        primary: false,
        children: <Widget>[
          Padding(
            padding: const .symmetric(horizontal: 12),
            child: Text(S.of(context).settingsNLDescription),
          ),
          const Divider(),
          FutureBuilder<NotificationListenerStatus>(
            future: updateStatus(),
            builder:
                (
                  BuildContext context,
                  AsyncSnapshot<NotificationListenerStatus> snapshot,
                ) {
                  final S l10n = S.of(context);
                  final ScaffoldMessengerState msg = ScaffoldMessenger.of(
                    context,
                  );

                  late String subtitle;
                  late Function clickFn;
                  if (snapshot.connectionState == .done && snapshot.hasData) {
                    if (!snapshot.data!.servicePermission) {
                      subtitle = l10n.settingsNLPermissionGrant;
                      clickFn = () async {
                        final bool granted =
                            await FlutterLocalNotificationsPlugin()
                                .resolvePlatformSpecificImplementation<
                                  AndroidFlutterLocalNotificationsPlugin
                                >()!
                                .requestNotificationsPermission() ??
                            false;
                        if (!granted) {
                          msg.showSnackBar(
                            SnackBar(
                              content: Text(
                                l10n.settingsNLPermissionNotGranted,
                              ),
                              behavior: .floating,
                            ),
                          );
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
                              AndroidFlutterLocalNotificationsPlugin
                            >()!
                            .requestNotificationsPermission();
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
                            title: Text(
                              S.of(context).settingsNLPermissionRemove,
                            ),
                            clipBehavior: .hardEdge,
                            actions: <Widget>[
                              TextButton(
                                child: Text(
                                  MaterialLocalizations.of(
                                    context,
                                  ).cancelButtonLabel,
                                ),
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
                            content: Text(
                              S.of(context).settingsNLPermissionRemoveHelp,
                            ),
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
                    log.severe(
                      "error updating status",
                      snapshot.error,
                      snapshot.stackTrace,
                    );
                    subtitle = S
                        .of(context)
                        .settingsNLServiceCheckingError(
                          snapshot.error.toString(),
                        );
                  } else {
                    subtitle = S.of(context).settingsNLServiceChecking;
                  }
                  return ListTile(
                    title: Text(S.of(context).settingsNLServiceStatus),
                    leading: CircleAvatar(
                      child: (snapshot.data?.serviceRunning ?? false)
                          ? const Icon(Icons.check)
                          : const Icon(Icons.close),
                    ),
                    subtitle: Text(subtitle, maxLines: 1),
                    onTap: () async {
                      await clickFn();
                      setState(() {});
                    },
                  );
                },
          ),
          if (status != null &&
              status!.serviceRunning &&
              status!.notificationPermission) ...<Widget>[
            const Divider(),
            OpenContainer(
              openBuilder: (BuildContext context, Function closedContainer) =>
                  const NotificationHistory(),
              openColor: Theme.of(context).cardColor,
              closedColor: Theme.of(context).cardColor,
              closedElevation: 0,
              closedBuilder: (BuildContext context, Function openContainer) =>
                  ListTile(
                    title: Text(S.of(context).settingsNLHistory),
                    leading: const CircleAvatar(child: Icon(Icons.history)),
                    subtitle: Text(
                      S.of(context).settingsNLHistoryShortDescription,
                      maxLines: 1,
                    ),
                    isThreeLine: false,
                    onTap: () => openContainer(),
                  ),
            ),
            const Divider(),
            ListTile(
              title: Text(S.of(context).settingsNLAppAdd),
              leading: const CircleAvatar(child: Icon(Icons.add)),
              subtitle: Text(S.of(context).settingsNLAppAddHelp, maxLines: 2),
              isThreeLine: true,
              onTap: () async {
                final SettingsProvider settings = context
                    .read<SettingsProvider>();
                final AppInfo? app = await showDialog<AppInfo>(
                  context: context,
                  builder: (BuildContext context) => const AppDialog(),
                );
                if (app == null || app.appName == null) {
                  return;
                }

                await settings.notificationAddUsedApp(app.packageName);
                await settings.notificationSetAppSettings(
                  app.packageName,
                  NotificationAppSettings(app.appName!),
                );
                setState(() {});
              },
            ),
            const Divider(),
            const NotificationApps(),
          ],
        ],
      ),
    );
  }
}

class NotificationApps extends StatelessWidget {
  const NotificationApps({super.key});

  Future<AccountArray> _getAccounts(BuildContext context) async {
    final FireflyIii api = context.read<FireflyService>().api;

    // Accounts
    final Response<AccountArray> respAccounts = await api.v1AccountsGet(
      type: .assetAccount,
    );
    apiThrowErrorIfEmpty(respAccounts, context.mounted ? context : null);

    return respAccounts.body!;
  }

  @override
  Widget build(BuildContext context) {
    final Logger log = Logger("Notifications.Apps");

    return FutureBuilder<AccountArray>(
      future: _getAccounts(context),
      builder: (BuildContext context, AsyncSnapshot<AccountArray> snapshot) {
        if (snapshot.connectionState == .done && snapshot.hasData) {
          return Column(
            crossAxisAlignment: .stretch,
            children: <Widget>[
              ...context.watch<SettingsProvider>().notificationApps.map((
                String app,
              ) {
                return FutureBuilder<NotificationAppSettings>(
                  future: context
                      .read<SettingsProvider>()
                      .notificationGetAppSettings(app),
                  builder:
                      (
                        BuildContext context,
                        AsyncSnapshot<NotificationAppSettings> snap,
                      ) {
                        if (snap.connectionState == .done && snap.hasData) {
                          debugPrint("trying to make AppCard for $app");
                          return AppCard(
                            app: app,
                            accounts: snapshot.data!,
                            settings: snap.data!,
                          );
                        } else if (snap.hasError) {
                          debugPrint("erroring out");
                          log.severe(
                            "error getting app settings",
                            snapshot.error,
                            snapshot.stackTrace,
                          );
                          return const SizedBox.shrink();
                        } else {
                          debugPrint("waiting");
                          return const CircularProgressIndicator.adaptive();
                        }
                      },
                );
              }),
            ],
          );
        } else if (snapshot.hasError) {
          log.severe(
            "error getting accounts",
            snapshot.error,
            snapshot.stackTrace,
          );
          return Text(
            S
                .of(context)
                .settingsNLServiceCheckingError(snapshot.error.toString()),
          );
        } else {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }
}

class AppCard extends StatefulWidget {
  const AppCard({
    super.key,
    required this.app,
    required this.accounts,
    required this.settings,
  });

  final String app;
  final AccountArray accounts;
  final NotificationAppSettings settings;

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  final TextEditingController accountTextController = TextEditingController();
  final FocusNode accountFocusNode = FocusNode();
  ErrorIcon _regexErrorIcon = const ErrorIcon(false);

  String? appAccountId;

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<AccountRead>> accountOptions =
        <DropdownMenuEntry<AccountRead>>[
          DropdownMenuEntry<AccountRead>(
            value: AccountRead(
              id: "0",
              type: "dummy",
              attributes: AccountProperties(
                name: S.of(context).settingsNLAppAccountDynamic,
                type: .swaggerGeneratedUnknown,
              ),
            ),
            label: S.of(context).settingsNLAppAccountDynamic,
          ),
        ];
    AccountRead? currentAccount = accountOptions.first.value;
    for (AccountRead e in widget.accounts.data) {
      accountOptions.add(
        DropdownMenuEntry<AccountRead>(value: e, label: e.attributes.name),
      );
      if (widget.settings.defaultAccountId == e.id) {
        currentAccount = e;
      }
    }
    return Card(
      clipBehavior: .hardEdge,
      child: Padding(
        padding: const .all(12),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: <Widget>[
                  Text(
                    widget.settings.appName,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  DropdownMenu<AccountRead>(
                    initialSelection: currentAccount,
                    leadingIcon: const Icon(Icons.account_balance),
                    label: Text(S.of(context).settingsNLAppAccount),
                    dropdownMenuEntries: accountOptions,
                    width: MediaQuery.of(context).size.width - 128,
                    onSelected: (AccountRead? account) async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      setState(() {
                        if ((account?.id ?? "0") == "0") {
                          widget.settings.defaultAccountId = null;
                          widget.settings.autoAdd = false;
                        } else {
                          widget.settings.defaultAccountId = account!.id;
                        }
                      });
                      await context
                          .read<SettingsProvider>()
                          .notificationSetAppSettings(
                            widget.app,
                            widget.settings,
                          );
                    },
                  ),
                  const SizedBox(height: 16),
                  CheckboxListTile.adaptive(
                    title: Text(S.of(context).settingsNLPrefillTXTitle),
                    isThreeLine: false,
                    value: widget.settings.includeTitle,
                    enabled: !widget.settings.autoAdd,
                    onChanged: (bool? value) async {
                      setState(() {
                        widget.settings.includeTitle = value ?? true;
                      });
                      await context
                          .read<SettingsProvider>()
                          .notificationSetAppSettings(
                            widget.app,
                            widget.settings,
                          );
                    },
                  ),
                  CheckboxListTile.adaptive(
                    title: Text(S.of(context).settingsNLAutoAdd),
                    isThreeLine: false,
                    value: widget.settings.autoAdd,
                    enabled: widget.settings.defaultAccountId != null,
                    onChanged: (bool? value) async {
                      setState(() {
                        widget.settings.autoAdd = value ?? false;
                        widget.settings.includeTitle = true;
                      });
                      await context
                          .read<SettingsProvider>()
                          .notificationSetAppSettings(
                            widget.app,
                            widget.settings,
                          );
                    },
                  ),
                  CheckboxListTile.adaptive(
                    title: Text(S.of(context).settingsNLEmptyNote),
                    isThreeLine: false,
                    value: widget.settings.emptyNote,
                    onChanged: (bool? value) async {
                      setState(() {
                        widget.settings.emptyNote = value ?? false;
                      });
                      await context
                          .read<SettingsProvider>()
                          .notificationSetAppSettings(
                            widget.app,
                            widget.settings,
                          );
                    },
                  ),
                  const SizedBox(height: 16),
                  // Regex field
                  TextFormField(
                    decoration: InputDecoration(
                      label: Text(S.of(context).settingsNLRegularExpression),
                      icon: const Icon(Icons.code),
                      border: const OutlineInputBorder(),
                      suffixIcon: _regexErrorIcon,
                      errorText: _regexErrorIcon.isError
                          ? S.of(context).settingsNLRegularExpressionInvalid
                          : null,
                    ),
                    initialValue: widget.settings.regex?.pattern,
                    onChanged: (String value) async {
                      value = value.trim();
                      if (value.isEmpty) {
                        setState(() {
                          widget.settings.regex = null;
                          _regexErrorIcon = const ErrorIcon(false);
                        });
                        await context
                            .read<SettingsProvider>()
                            .notificationSetAppSettings(
                              widget.app,
                              widget.settings,
                            );
                        return;
                      }
                      try {
                        debugPrint("trying");
                        final RegExp validRegex = RegExp(
                          value,
                          caseSensitive: false,
                        );
                        setState(() {
                          widget.settings.regex = validRegex;
                          _regexErrorIcon = const ErrorIcon(false);
                        });

                        await context
                            .read<SettingsProvider>()
                            .notificationSetAppSettings(
                              widget.app,
                              widget.settings,
                            );
                        debugPrint("settings updated with $value");
                      } on FormatException catch (_) {
                        debugPrint("showing error");
                        setState(() {
                          _regexErrorIcon = const ErrorIcon(true);
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 48,
              child: Align(
                alignment: .centerRight,
                child: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    context.read<SettingsProvider>().notificationRemoveUsedApp(
                      widget.app,
                    );
                  },
                  tooltip: S.of(context).transactionSplitDelete,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppDialog extends StatelessWidget {
  const AppDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final Logger log = Logger("Notifications.AppDialog");

    return SimpleDialog(
      title: Text(S.of(context).settingsNLAppAdd),
      clipBehavior: .hardEdge,
      children: <Widget>[
        FutureBuilder<List<String>>(
          future: context.read<SettingsProvider>().notificationKnownApps(
            filterUsed: true,
          ),
          builder:
              (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                if (snapshot.hasData) {
                  final List<Widget> child = <Widget>[];
                  child.add(
                    Padding(
                      padding: const .symmetric(horizontal: 24),
                      child: Text(S.of(context).settingsNLAppAddInfo),
                    ),
                  );
                  for (String app in snapshot.data!) {
                    child.add(AppDialogEntry(app: app));
                  }
                  return Column(crossAxisAlignment: .start, children: child);
                } else if (snapshot.hasError) {
                  log.severe(
                    "error getting app settings",
                    snapshot.error,
                    snapshot.stackTrace,
                  );
                  Navigator.pop(context);
                  return const SizedBox.shrink();
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
              },
        ),
      ],
    );
  }
}

class AppDialogEntry extends StatelessWidget {
  const AppDialogEntry({super.key, required this.app});

  final String app;

  @override
  Widget build(BuildContext context) {
    final Logger log = Logger("Notifications.AppDialog.Entry");

    return FutureBuilder<AppInfo?>(
      future: AppCheck().checkAvailability(app),
      builder: (BuildContext context, AsyncSnapshot<AppInfo?> snapshot) {
        if (snapshot.connectionState == .done) {
          if (snapshot.data == null || snapshot.data!.appName == null) {
            return const SizedBox.shrink();
          }
          late Widget leading;
          try {
            if (snapshot.data!.icon == null) {
              throw Exception(); // will be caught below
            }
            leading = Image.memory(snapshot.data!.icon!);
          } catch (e) {
            leading = const Icon(Icons.api);
          }
          return ListTile(
            leading: CircleAvatar(child: leading),
            title: Text(snapshot.data!.appName!),
            subtitle: Text(app),
            onTap: () {
              Navigator.pop(context, snapshot.data);
            },
          );
        } else if (snapshot.hasError) {
          log.severe(
            "error getting app details",
            snapshot.error,
            snapshot.stackTrace,
          );
          return const SizedBox.shrink();
        } else {
          return const CircularProgressIndicator.adaptive();
        }
      },
    );
  }
}
