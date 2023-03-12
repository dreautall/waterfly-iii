import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:waterflyiii/pages/splash.dart';
import 'package:waterflyiii/widgets/logo.dart';
import 'package:waterflyiii/widgets/erroricon.dart';
import 'package:waterflyiii/widgets/animatedheightcard.dart';

class UriScheme {
  static const String https = "https://";
  static const String http = "http://";

  static bool valid(String uri) {
    return uri.startsWith(http) || uri.startsWith(https);
  }

  static bool isHttp(String uri) {
    return uri.startsWith(http);
  }

  static bool isHttps(String uri) {
    return uri.startsWith(https);
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _hostTextController = TextEditingController();
  final _keyTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _uriScheme = UriScheme.https;
  String? _hostError;
  ErrorIcon _hostErrorIcon = const ErrorIcon(false);
  String? _keyError;
  ErrorIcon _keyErrorIcon = const ErrorIcon(false);
  //bool _formSubmitted = false;

  final FocusNode _hostFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _hostTextController.text = _uriScheme;
  }

  @override
  void dispose() {
    _hostTextController.dispose();
    _keyTextController.dispose();
    _hostFocusNode.dispose();

    super.dispose();
  }

  bool _hostValid(String value) {
    if (!UriScheme.valid(value)) return false;

    Uri? uri = Uri.tryParse(value);
    if (uri == null || uri.host.isEmpty) return false;

    return true;
  }

  @override
  Widget build(BuildContext context) {
    print("login build()");
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(24),
            children: <Widget>[
              Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  const AppLogo(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Text(
                      'Welcome to Waterfly III',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 0,
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          "To use Waterfly III productively you need your own server with a Firefly III instance or the Firefly III add-on for Home Assistant.\n\nPlease enter the full URL as well as a personal access token (Settings -> Profile -> OAuth -> Personal Access Token) below.",
                          style: TextStyle(height: 2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SegmentedButton<String>(
                    segments: const <ButtonSegment<String>>[
                      ButtonSegment<String>(
                        value: UriScheme.https,
                        label: Text("HTTPS"),
                        icon: Icon(Icons.lock_outline),
                      ),
                      ButtonSegment<String>(
                        value: UriScheme.http,
                        label: Text("HTTP"),
                        icon: Icon(Icons.lock_open_outlined),
                      ),
                    ],
                    selected: <String>{_uriScheme},
                    onSelectionChanged: /*_formSubmitted
                        ? null
                        : */
                        (Set<String> newSelection) {
                      _hostFocusNode.requestFocus();
                      if (!UriScheme.valid(newSelection.first) ||
                          _uriScheme == newSelection.first) return;
                      var currentUrl = _hostTextController.text;
                      String oldScheme, newScheme;
                      if (UriScheme.isHttp(newSelection.first)) {
                        oldScheme = UriScheme.https;
                        newScheme = UriScheme.http;
                      } else {
                        oldScheme = UriScheme.http;
                        newScheme = UriScheme.https;
                      }
                      if (currentUrl.isEmpty) {
                        _hostTextController.text = newScheme;
                      } else if (currentUrl.startsWith(oldScheme)) {
                        _hostTextController.text =
                            "$newScheme${currentUrl.substring(oldScheme.length)}";
                      } else {
                        _hostTextController.text = "$newScheme$currentUrl";
                      }
                      var error = _hostTextController.text.isNotEmpty &&
                          !_hostValid(_hostTextController.text);
                      setState(() {
                        _uriScheme = newScheme;
                        // Needed here because updating the text does not actually cause onChanged to fire
                        if (error != _hostErrorIcon.isError) {
                          _hostErrorIcon = ErrorIcon(error);
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  AnimatedHeightCard(
                    child: TextFormField(
                      controller: _hostTextController,
                      //readOnly: _formSubmitted,
                      focusNode: _hostFocusNode,
                      decoration: InputDecoration(
                        filled: true,
                        labelText: "Host URL",
                        suffixIcon: _hostErrorIcon,
                        errorText: _hostError,
                      ),
                      onChanged: (String value) {
                        var newUriScheme = _uriScheme;

                        if (!UriScheme.valid(value)) {
                          newUriScheme = "";
                        } else if (UriScheme.isHttp(value)) {
                          newUriScheme = UriScheme.http;
                        } else if (UriScheme.isHttps(value)) {
                          newUriScheme = UriScheme.https;
                        }
                        if (newUriScheme != _uriScheme) {
                          setState(() {
                            _uriScheme = newUriScheme;
                          });
                        }

                        var error = value.isNotEmpty &&
                            (!UriScheme.valid(value) || !_hostValid(value));
                        if (error != _hostErrorIcon.isError ||
                            (_hostError != null &&
                                _hostError!.isNotEmpty &&
                                _hostError != "Invalid URL")) {
                          setState(() {
                            _hostErrorIcon = ErrorIcon(error);
                            _hostError = error ? "Invalid URL" : null;
                          });
                        }
                      },
                      autovalidateMode: AutovalidateMode.disabled,
                      validator: (String? value) {
                        String? error = value == null || value.isEmpty
                            ? "This field is required."
                            : !_hostValid(value)
                                ? "Invalid URL"
                                : null;
                        if (_hostError != error ||
                            _hostErrorIcon.isError != (error != null)) {
                          setState(() {
                            _hostErrorIcon = ErrorIcon(error != null);
                            _hostError = error;
                          });
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  AnimatedHeightCard(
                    child: TextFormField(
                      controller: _keyTextController,
                      //readOnly: _formSubmitted,
                      decoration: InputDecoration(
                        filled: true,
                        labelText: "Valid API Key",
                        suffixIcon: _keyErrorIcon,
                        errorText: _keyError,
                      ),
                      onChanged: (String value) {
                        if (_keyErrorIcon.isError) {
                          setState(() {
                            _keyErrorIcon = const ErrorIcon(false);
                            _keyError = null;
                          });
                        }
                      },
                      autovalidateMode: AutovalidateMode.disabled,
                      validator: (String? value) {
                        String? error = value == null || value.isEmpty
                            ? "This field is required."
                            : null;
                        if (_keyError != error ||
                            _keyErrorIcon.isError != (error != null)) {
                          setState(() {
                            _keyErrorIcon = ErrorIcon(error != null);
                            _keyError = error;
                          });
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  OverflowBar(
                    alignment: MainAxisAlignment.end,
                    children: <Widget>[
                      OutlinedButton(
                        onPressed: () async {
                          const url =
                              "https://docs.firefly-iii.org/firefly-iii/api/#personal-access-token";
                          final uri = Uri.parse(url);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
                          } else {
                            throw "Could not launch $url";
                          }
                        },
                        child: const Text("Help"),
                      ),
                      const SizedBox(width: 12),
                      FilledButton(
                        onPressed: /*_formSubmitted
                            ? null
                            : */
                            () {
                          _formKey.currentState!.validate();
                          if ((_keyError != null && _keyError!.isNotEmpty) ||
                              (_hostError != null && _hostError!.isNotEmpty)) {
                            return;
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SplashPage(
                                host: _hostTextController.text,
                                apiKey: _keyTextController.text,
                              ),
                            ),
                          );
                          /*setState(() {
                                  _formSubmitted = true;
                                });*/
                        },
                        child: const Text("Login"),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
