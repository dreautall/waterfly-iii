import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart' show getTemporaryDirectory;

import 'package:waterflyiii/settings.dart';

class DebugDialog extends StatelessWidget {
  const DebugDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("DEBUG"),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
          child: Text(
              "You can enable & send debug logs here. These have a bad impact on performance, so please don't enable them unless you're advised to do so. Disabling logging will delete the stored log."),
        ),
        SwitchListTile(
          value: context.watch<SettingsProvider>().debug,
          onChanged: (bool value) =>
              context.read<SettingsProvider>().setDebug(value),
          title: Text("Enable Debug Logging"),
          secondary: const Icon(Icons.bug_report),
        ),
        ListTile(
          enabled: context.watch<SettingsProvider>().debug,
          isThreeLine: false,
          leading: const Icon(Icons.send),
          title: Text("Send Logs via Mail"),
          onTap: () async {
            final bool? ok = await showDialog<bool>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                icon: const Icon(Icons.mail),
                title: Text("Send Logs via Mail"),
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
                    child: Text("Create Mail"),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
                content: Text(
                    "WARNING: A mail draft will open with the log file attached (in text format). The logs might contain sensitive information such as the host name of your Firefly instance (though I try to avoid logging of any secrets such as the api key). Please read through the log carefully and censor out any information you don't want to share and/or is not relevant to the problem you want to report.\n\nPlease do not send in logs without prior agreement via mail/GitHub to do so. I will delete any logs sent without context for privacy reasons. Never upload the log uncensored to GitHub or elsewhere."),
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
