import 'dart:io';
import 'dart:typed_data';

import 'package:appcheck/appcheck.dart';
import 'package:material_ui/material_ui.dart';

typedef NotificationAppInfoLoader =
    Future<AppInfo?> Function(String applicationId);

class NotificationAppIcon extends StatefulWidget {
  const NotificationAppIcon({
    super.key,
    required this.applicationId,
    this.appInfoLoader,
  });

  final String applicationId;
  final NotificationAppInfoLoader? appInfoLoader;

  @override
  State<NotificationAppIcon> createState() => _NotificationAppIconState();
}

class _NotificationAppIconState extends State<NotificationAppIcon> {
  Future<AppInfo?>? _application;

  @override
  void initState() {
    super.initState();
    _loadApplication();
  }

  @override
  void didUpdateWidget(covariant NotificationAppIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.applicationId != widget.applicationId ||
        oldWidget.appInfoLoader != widget.appInfoLoader) {
      _loadApplication();
    }
  }

  void _loadApplication() {
    final NotificationAppInfoLoader? loader = widget.appInfoLoader;
    _application = loader != null
        ? loader(widget.applicationId)
        : Platform.isAndroid
        ? AppCheck().checkAvailability(widget.applicationId)
        : null;
  }

  @override
  Widget build(BuildContext context) {
    final Future<AppInfo?>? application = _application;
    if (application == null) return const _FallbackAppIcon();
    return FutureBuilder<AppInfo?>(
      future: application,
      builder: (BuildContext context, AsyncSnapshot<AppInfo?> snapshot) {
        final Uint8List? image = snapshot.data?.icon;
        if (image == null) {
          return const _FallbackAppIcon();
        }
        return CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Image.memory(
            image,
            width: 40,
            height: 40,
            fit: BoxFit.contain,
            errorBuilder: (_, _, _) => const Icon(Icons.apps_outlined),
          ),
        );
      },
    );
  }
}

class _FallbackAppIcon extends StatelessWidget {
  const _FallbackAppIcon();

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(child: Icon(Icons.apps_outlined));
  }
}
