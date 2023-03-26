import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:chopper/chopper.dart'
    show Request, Response, StripStringExtension;

import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';

class AuthError implements Exception {
  const AuthError(this.cause);

  final String cause;
}

class AuthErrorHost extends AuthError {
  const AuthErrorHost(this.host) : super("Invalid host");

  final String host;
}

class AuthErrorApiKey extends AuthError {
  const AuthErrorApiKey() : super("Invalid API key");
}

class AuthErrorStatusCode extends AuthError {
  const AuthErrorStatusCode(this.code) : super("Unexpected HTTP status code");

  final int code;
}

class AuthErrorNoInstance extends AuthError {
  const AuthErrorNoInstance(this.host)
      : super("Not a valid Firefly III instance");

  final String host;
}

class AuthUser {
  late Uri _host;
  late String _apiKey;
  late FireflyIii _api;

  Uri get host => _host;
  FireflyIii get api => _api;

  AuthUser._create(Uri host, String apiKey) {
    _apiKey = apiKey;

    List<String> path = <String>[...host.pathSegments, "api"];
    _host = host.replace(pathSegments: path);

    _api = FireflyIii.create(
      baseUrl: _host,
      interceptors: <dynamic>[
        (Request request) async {
          debugPrint("API query to ${request.url}");
          request.followRedirects = false;
          request.maxRedirects = 0;
          return request.copyWith(headers: <String, String>{
            ...request.headers,
            ...headers(),
          });
        },
        (Response<dynamic> response) async {
          return response;
        },
      ],
    );
  }

  Map<String, String> headers() {
    return <String, String>{
      HttpHeaders.authorizationHeader: "Bearer $_apiKey",
      HttpHeaders.acceptHeader: "application/json",
    };
  }

  static Future<AuthUser> create(String host, String apiKey) async {
    debugPrint("AuthUser->create()");

    // This call is on purpose not using the Swagger API
    final HttpClient client = HttpClient();
    Uri uri;

    try {
      uri = Uri.parse("$host/api/v1/about");
    } on FormatException {
      throw AuthErrorHost(host);
    }

    try {
      HttpClientRequest request = await client.getUrl(uri);
      request.headers.add(HttpHeaders.authorizationHeader, "Bearer $apiKey");
      request.followRedirects = false;
      HttpClientResponse response = await request.close();

      if (response.isRedirect) {
        throw const AuthErrorApiKey();
      }
      if (response.statusCode != 200) {
        throw AuthErrorStatusCode(response.statusCode);
      }

      final String stringData = await response.transform(utf8.decoder).join();

      try {
        SystemInfo.fromJson(json.decode(stringData));
      } on FormatException {
        throw AuthErrorNoInstance(host);
      }
    } finally {
      client.close();
    }

    return AuthUser._create(Uri(host: uri.host, scheme: uri.scheme), apiKey);
  }
}

class FireflyService with ChangeNotifier {
  AuthUser? _currentUser;
  AuthUser? get user => _currentUser;
  bool _signedIn = false;
  bool get signedIn => _signedIn;
  String? _lastTriedHost;
  String? get lastTriedHost => _lastTriedHost;
  Object? _storageSignInException;
  Object? get storageSignInException => _storageSignInException;

  bool get hasApi => (_currentUser?.api != null) ? true : false;
  FireflyIii get api {
    if (_currentUser?.api == null) {
      signOut();
      throw Exception("API unavailable");
    }
    return _currentUser!.api;
  }

  late CurrencyRead defaultCurrency;

  final FlutterSecureStorage storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  FireflyService() {
    debugPrint("new FireflyService");
  }

  Future<bool> signInFromStorage() async {
    _storageSignInException = null;
    String? apiHost = await storage.read(key: 'api_host');
    String? apiKey = await storage.read(key: 'api_key');

    debugPrint("storage: $apiHost, $apiKey");

    if (apiHost == null || apiKey == null) {
      return false;
    }

    try {
      final bool success = await signIn(apiHost, apiKey);
      return success;
    } catch (e) {
      _storageSignInException = e;
      debugPrint("notify FireflyService->signInFromStorage");
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    debugPrint("FireflyService->signOut()");
    _currentUser = null;
    _signedIn = false;
    _storageSignInException = null;
    await storage.deleteAll();

    debugPrint("notify FireflyService->signOut");
    notifyListeners();
  }

  Future<bool> signIn(String host, String apiKey) async {
    debugPrint("FireflyService->signIn($host)");
    host = host.strip().rightStrip('/');
    apiKey = apiKey.strip();

    _lastTriedHost = host;
    _currentUser = await AuthUser.create(host, apiKey);
    if (_currentUser == null || !hasApi) return false;

    Response<CurrencySingle> currencyInfo = await api.v1CurrenciesDefaultGet();
    defaultCurrency = currencyInfo.body!.data;

    _signedIn = true;
    debugPrint("notify FireflyService->signIn");
    notifyListeners();

    storage.write(key: 'api_host', value: host);
    storage.write(key: 'api_key', value: apiKey);

    return true;
  }
}
