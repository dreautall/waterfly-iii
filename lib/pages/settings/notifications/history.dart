import 'package:appcheck/appcheck.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notificationlistener.dart';
import 'package:waterflyiii/pages/transaction.dart';
import 'package:waterflyiii/settings.dart';

class NotificationHistory extends StatefulWidget {
  const NotificationHistory({super.key});

  @override
  State<NotificationHistory> createState() => _NotificationHistoryState();
}

class _NotificationHistoryState extends State<NotificationHistory> {
  final Logger log = Logger("Notifications.History");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).settingsNLHistory)),
      body: ListView(
        padding: const .symmetric(horizontal: 24),
        primary: true,
        children: <Widget>[
          Padding(
            padding: const .symmetric(horizontal: 12),
            child: Text(
              S
                  .of(context)
                  .settingsNLHistoryLongDescription(
                    SettingsProvider.settingNLHistoryLength,
                  ),
            ),
          ),
          const Divider(),
          FutureBuilder<List<PastNotification>>(
            future: context.read<SettingsProvider>().notificationHistoryGet(),
            builder:
                (
                  BuildContext context,
                  AsyncSnapshot<List<PastNotification>> snapshot,
                ) {
                  if (snapshot.connectionState != .done || !snapshot.hasData) {
                    if (snapshot.hasError) {
                      log.severe(
                        "error getting past notifications",
                        snapshot.error,
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }

                  final List<Widget> childs = <Widget>[];

                  for (PastNotification n in snapshot.data!.reversed) {
                    debugPrint(n.toJson().toString());
                    final Widget child = FutureBuilder<AppInfo?>(
                      future: AppCheck().checkAvailability(n.appName),
                      builder: (BuildContext context, AsyncSnapshot<AppInfo?> snapshot) {
                        if (snapshot.connectionState == .done) {
                          if (snapshot.data == null ||
                              snapshot.data!.appName == null) {
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
                          return Card(
                            margin: const .only(bottom: 8),
                            child: InkWell(
                              onTap: n.reason == null
                                  ? () => showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          TransactionPage(
                                            notification:
                                                NotificationTransaction(
                                                  n.appName,
                                                  n.title,
                                                  n.body,
                                                  n.time,
                                                ),
                                          ),
                                    )
                                  : null,
                              child: Padding(
                                padding: const .all(12),
                                child: Row(
                                  crossAxisAlignment: .start,
                                  children: <Widget>[
                                    CircleAvatar(child: leading),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: .start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: .spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                "${snapshot.data!.appName}・${DateFormat.yMd().add_Hms().format(n.time)}",
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.bodySmall,
                                              ),
                                              n.reason == null
                                                  ? Icon(
                                                      Icons.touch_app_outlined,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .outlineVariant,
                                                    )
                                                  : const SizedBox.shrink(),
                                            ],
                                          ),
                                          Text(
                                            n.title,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.labelLarge,
                                          ),
                                          Text(n.body),
                                          const SizedBox(height: 6),
                                          n.reason != null
                                              ? Text(
                                                  S
                                                      .of(context)
                                                      .settingsNLHistoryRejectedReason(
                                                        n.reason.toString(),
                                                      ),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium!
                                                      .copyWith(
                                                        fontWeight: .normal,
                                                        fontStyle: .italic,
                                                      ),
                                                )
                                              : const SizedBox.shrink(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
                    childs.add(child);
                  }

                  if (childs.isEmpty) {
                    return Center(
                      child: Column(
                        crossAxisAlignment: .center,
                        mainAxisAlignment: .center,
                        children: <Widget>[
                          const Padding(padding: .only(top: 36)),
                          const Icon(
                            Icons.notifications_off_outlined,
                            size: 200,
                          ),
                          Text(
                            S.of(context).settingsNLHistoryEmpty,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    );
                  }

                  childs.add(const Padding(padding: .only(bottom: 18)));
                  return Column(children: childs);
                },
          ),
        ],
      ),
    );
  }
}
