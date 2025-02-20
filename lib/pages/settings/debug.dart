import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart' show getTemporaryDirectory;
import 'package:provider/provider.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/settings.dart';

class DebugDialog extends StatelessWidget {
  const DebugDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(S.of(context).settingsDialogDebugTitle),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
          child: Text(S.of(context).settingsDialogDebugInfo),
        ),
        SwitchListTile(
          value: context.select((SettingsProvider s) => s.debug),
          onChanged: (bool value) async {
            context.read<SettingsProvider>().debug = value;
            PackageInfo appInfo = await PackageInfo.fromPlatform();
            log.info(
                "Enabling debug logs, app ${appInfo.appName}, ${appInfo.version}+${appInfo.buildNumber}");
          },
          title: Text(S.of(context).settingsDialogDebugTitle),
          secondary: const Icon(Icons.bug_report),
        ),
        ListTile(
          enabled: context.select((SettingsProvider s) => s.debug),
          isThreeLine: false,
          leading: const Icon(Icons.send),
          title: Text(S.of(context).settingsDialogDebugSendButton),
          onTap: () async {
            final bool? ok = await showDialog<bool>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                icon: const Icon(Icons.mail),
                title: Text(S.of(context).settingsDialogDebugSendButton),
                clipBehavior: Clip.hardEdge,
                actions: <Widget>[
                  TextButton(
                    child: Text(
                        MaterialLocalizations.of(context).cancelButtonLabel),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FilledButton(
                    child: Text(S.of(context).settingsDialogDebugMailCreate),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
                content: Text(S.of(context).settingsDialogDebugMailDisclaimer),
              ),
            );
            if (!(ok ?? false)) {
              return;
            }

            final PackageInfo appInfo = await PackageInfo.fromPlatform();
            final Directory tmpPath = await getTemporaryDirectory();
            final String logPath = "${tmpPath.path}/debuglog.txt";
            final bool logExists = await File(logPath).exists();
            await FlutterEmailSender.send(
              Email(
                body:
                    "Debug Logs generated from ${appInfo.appName}, ${appInfo.version}+${appInfo.buildNumber}",
                subject: "Waterfly III Debug Logs",
                recipients: <String>["app@vogt.pw"],
                attachmentPaths:
                    logExists ? <String>[logPath] : const <String>[],
                isHTML: false,
              ),
            );
          },
        ),
      ],
    );
  }
}
