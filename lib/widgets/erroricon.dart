import 'package:flutter/material.dart';

class ErrorIcon extends StatelessWidget {
  const ErrorIcon(this._isError, {Key? key}) : super(key: key);

  final bool _isError;

  bool get isError => _isError;

  @override
  Widget build(BuildContext context) {
    Widget out;

    debugPrint("Rebuilding ErrorWidget with $_isError");
    _isError
        ? out = Icon(
            Icons.error,
            color: Theme.of(context).colorScheme.error,
          )
        : out = const Icon(null);

    return out;
  }
}
