import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

final Logger log = Logger("Widgets.ErrorIcon");

class ErrorIcon extends StatelessWidget {
  const ErrorIcon(this._isError, {Key? key}) : super(key: key);

  final bool _isError;
  bool get isError => _isError;

  @override
  Widget build(BuildContext context) {
    log.finest(() => "build(isError: $_isError)");
    return _isError
        ? Icon(
            Icons.error,
            color: Theme.of(context).colorScheme.error,
          )
        : const Icon(null);
  }
}
