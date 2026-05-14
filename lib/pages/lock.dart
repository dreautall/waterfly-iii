import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:logging/logging.dart';
import 'package:waterflyiii/widgets/logo.dart';

final Logger log = Logger("Pages.Lock");

class LockPage extends StatefulWidget {
  const LockPage({super.key, required this.onSuccess});

  final VoidCallback onSuccess;

  @override
  State<LockPage> createState() => _LockPageState();
}

class _LockPageState extends State<LockPage> {
  @override
  void initState() {
    super.initState();

    _authenticate();
  }

  Future<void> _authenticate() async {
    final LocalAuthentication auth = LocalAuthentication();
    try {
      final bool success = await auth.authenticate(
        localizedReason: "Waterfly III",
        persistAcrossBackgrounding: true,
      );
      if (success) {
        widget.onSuccess();
      }
    } on Exception catch (e, _) {
      log.shout(() => "Authentication failed: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .center,
            children: <Widget>[
              const AppLogo(size: 256),
              const SizedBox(height: 48),
              IconButton(
                iconSize: 128,
                icon: Icon(
                  Icons.fingerprint,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  _authenticate();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
