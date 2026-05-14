import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';

class ConnectionDialog extends StatefulWidget {
  const ConnectionDialog({super.key});

  @override
  State<ConnectionDialog> createState() => _ConnectionDialogState();
}

class _ConnectionDialogState extends State<ConnectionDialog> {
  final TextEditingController _hostTextController = TextEditingController();
  final TextEditingController _keyTextController = TextEditingController();
  final TextEditingController _customHeadersTextController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _loading = true;
  bool _saving = false;
  bool _showCustomHeadersField = false;
  Object? _submitError;

  @override
  void initState() {
    super.initState();

    _loadCredentials();
  }

  @override
  void dispose() {
    _hostTextController.dispose();
    _keyTextController.dispose();
    _customHeadersTextController.dispose();

    super.dispose();
  }

  static bool _hostValid(String value) {
    final Uri? uri = Uri.tryParse(value);
    if (uri == null || uri.host.isEmpty) {
      return false;
    }
    return uri.scheme == "https" || uri.scheme == "http";
  }

  Future<void> _loadCredentials() async {
    final FireflyService ff = context.read<FireflyService>();
    final AuthCredentials creds = await ff.readStoredCredentials();

    if (!mounted) {
      return;
    }

    _hostTextController.text = creds.host ?? "";
    _keyTextController.text = creds.apiKey ?? "";
    _customHeadersTextController.text = creds.customHeadersRaw ?? "";

    setState(() {
      _showCustomHeadersField = _customHeadersTextController.text.isNotEmpty;
      _loading = false;
    });
  }

  String _errorDescription(Object error, BuildContext context) {
    String errorDescription = "";
    String errorDetails = "";
    if (error is AuthErrorStatusCode) {
      final AuthErrorStatusCode errorType = error;
      errorDetails += "\n";
      errorDetails += S.of(context).errorStatusCode(errorType.code);
      errorDescription = errorType.cause;
    } else if (error is AuthErrorVersionTooLow) {
      final AuthErrorVersionTooLow errorType = error;
      errorDetails += "\n";
      errorDetails += S
          .of(context)
          .errorMinAPIVersion(errorType.requiredVersion.toString());
      errorDescription = errorType.cause;
    } else if (error is AuthError) {
      final AuthError errorType = error;
      errorDescription = errorType.cause;
    } else {
      errorDetails += "\n$error";
    }
    return errorDescription.isNotEmpty
        ? errorDescription
        : errorDetails.strip();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _saving = true;
      _submitError = null;
      if (!_showCustomHeadersField) {
        _customHeadersTextController.text = "";
      }
    });

    try {
      await context.read<FireflyService>().signIn(
        _hostTextController.text,
        _keyTextController.text,
        customHeadersRaw: _customHeadersTextController.text,
      );
      if (!mounted) {
        return;
      }
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).settingsServerConnectionUpdated),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (error, stackTrace) {
      log.warning("failed to update server credentials", error, stackTrace);
      if (!mounted) {
        return;
      }
      setState(() {
        _submitError = error;
        _saving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).settingsServerConnection),
      content: AnimatedSwitcher(
        duration: animDurationStandardDecelerate,
        child: _loading
            ? const SizedBox(
                height: 96,
                child: Center(child: CircularProgressIndicator.adaptive()),
              )
            : Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        controller: _hostTextController,
                        decoration: InputDecoration(
                          filled: true,
                          labelText: S.of(context).loginFormLabelHost,
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).errorFieldRequired;
                          }
                          if (!_hostValid(value)) {
                            return S.of(context).errorInvalidURL;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _keyTextController,
                        decoration: InputDecoration(
                          filled: true,
                          labelText: S.of(context).loginFormLabelAPIKey,
                        ),
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).errorFieldRequired;
                          }
                          return null;
                        },
                      ),
                      AnimatedHeight(
                        child: (_showCustomHeadersField)
                            ? const SizedBox(height: 12)
                            : const SizedBox.shrink(),
                      ),
                      AnimatedHeight(
                        child: (_showCustomHeadersField)
                            ? TextFormField(
                                controller: _customHeadersTextController,
                                decoration: InputDecoration(
                                  filled: true,
                                  labelText: S
                                      .of(context)
                                      .loginFormLabelHeaders,
                                  helperText: S
                                      .of(context)
                                      .loginFormLabelHeadersHelp,
                                ),
                                minLines: 2,
                                maxLines: 5,
                                autocorrect: false,
                                enableSuggestions: false,
                              )
                            : const SizedBox.shrink(),
                      ),
                      AnimatedHeight(
                        child: (_submitError != null)
                            ? const SizedBox(height: 12)
                            : const SizedBox.shrink(),
                      ),
                      AnimatedHeight(
                        child: (_submitError != null)
                            ? Card(
                                color: Theme.of(
                                  context,
                                ).colorScheme.errorContainer,
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(
                                    _errorDescription(_submitError!, context),
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.error,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: _saving ? null : () => Navigator.pop(context),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        OutlinedButton(
          onPressed: _loading || _saving
              ? null
              : () {
                  setState(() {
                    _showCustomHeadersField = !_showCustomHeadersField;
                  });
                },
          child: Text(
            _showCustomHeadersField
                ? S.of(context).loginFormButtonHideHeaders
                : S.of(context).loginFormButtonShowHeaders,
          ),
        ),
        FilledButton(
          onPressed: _loading || _saving ? null : _save,
          child: _saving
              ? const SizedBox.square(
                  dimension: 16,
                  child: CircularProgressIndicator(strokeWidth: 3),
                )
              : Text(MaterialLocalizations.of(context).saveButtonLabel),
        ),
      ],
    );
  }
}
