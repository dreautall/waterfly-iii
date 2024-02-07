import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart' show Response, StripStringExtension;
import 'package:logging/logging.dart';
import 'package:version/version.dart';
import 'package:waterflyiii/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii_v2.swagger.dart';
import 'package:waterflyiii/stock.dart';
import 'package:waterflyiii/timezonehandler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FireflyService with ChangeNotifier {
  AuthUser? _currentUser;
  AuthUser? get user => _currentUser;
  bool _signedIn = false;
  bool get signedIn => _signedIn;
  String? _lastTriedHost;
  String? get lastTriedHost => _lastTriedHost;
  Object? _storageSignInException;
  Object? get storageSignInException => _storageSignInException;
  Version? _apiVersion;
  Version? get apiVersion => _apiVersion;

  TransStock? _transStock;
  TransStock? get transStock => _transStock;

  bool get hasApi => (_currentUser?.api != null) ? true : false;
  FireflyIii get api {
    if (_currentUser?.api == null) {
      signOut();
      throw Exception("API unavailable");
    }
    return _currentUser!.api;
  }

  FireflyIiiV2 get apiV2 {
    if (_currentUser?.apiV2 == null) {
      signOut();
      throw Exception("API unavailable");
    }
    return _currentUser!.apiV2;
  }

  late CurrencyRead defaultCurrency;
  late TimeZoneHandler tzHandler;

  final FlutterSecureStorage storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  final Logger log = Logger("Auth.FireflyService");

  FireflyService() {
    log.finest(() => "new FireflyService");
  }

  /// Sign in the user using the stored credentials.
  Future<bool> signInFromStorage() async {
    _storageSignInException = null;
    String? apiHost = await storage.read(key: 'api_host');
    String? apiKey = await storage.read(key: 'api_key');
    String? cert = await storage.read(key: 'api_cert');

    log.config(
        "storage: $apiHost, apiKey ${apiKey?.isEmpty ?? true ? "unset" : "set"}, cert ${cert?.isEmpty ?? true ? "unset" : "set"}");

    if (apiHost == null || apiKey == null) {
      return false;
    }

    try {
      return await signIn(apiHost, apiKey, cert);
    } catch (e) {
      _storageSignInException = e;
      log.finest(() => "notify FireflyService->signInFromStorage");
      notifyListeners();
      return false;
    }
  }

  /// Sign out the current user and clear all stored data.
  Future<void> signOut() async {
    log.config("FireflyService->signOut()");
    _currentUser = null;
    _signedIn = false;
    _storageSignInException = null;
    await storage.deleteAll();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    log.finest(() => "notify FireflyService->signOut");
    notifyListeners();
  }

  /// Sign in the user using the given credentials.
  Future<bool> signIn(String host, String apiKey, [String? cert]) async {
    log.config("FireflyService->signIn($host)");
    host = host.strip().rightStrip('/');
    apiKey = apiKey.strip();

    if (cert != null && cert.isNotEmpty) {
      HttpOverrides.global = SSLHttpOverride(cert);
    } else {
      HttpOverrides.global = null;
    }

    _lastTriedHost = host;
    _currentUser = await AuthUser.create(host, apiKey);
    if (_currentUser == null || !hasApi) return false;

    Response<CurrencySingle> currencyInfo = await api.v1CurrenciesDefaultGet();
    defaultCurrency = currencyInfo.body!.data;

    Response<SystemInfo> about = await api.v1AboutGet();
    try {
      _apiVersion = Version.parse(about.body?.data?.apiVersion ?? "");
    } on FormatException {
      throw const AuthErrorVersionInvalid();
    }
    log.info(() => "Firefly API version $_apiVersion");
    if (apiVersion == null || apiVersion! < minApiVersion) {
      throw AuthErrorVersionTooLow(minApiVersion);
    }

    // Manual API query as the Swagger type doesn't resolve in Flutter :(
    final HttpClient client = HttpClient();
    Uri tzUri = user!.host.replace(pathSegments: <String>[
      ...user!.host.pathSegments,
      "v1",
      "configuration",
      ConfigValueFilter.appTimezone.value!
    ]);
    try {
      HttpClientRequest request = await client.getUrl(tzUri);
      user!.headers().forEach(
            (String key, String value) => request.headers.add(key, value),
          );
      HttpClientResponse response = await request.close();
      final String stringData = await response.transform(utf8.decoder).join();
      final APITZReply reply = APITZReply.fromJson(json.decode(stringData));
      tzHandler = TimeZoneHandler(reply.data.value);
    } finally {
      client.close();
    }

    _signedIn = true;
    _transStock = TransStock(api);
    log.finest(() => "notify FireflyService->signIn");
    notifyListeners();

    storage.write(key: 'api_host', value: host);
    storage.write(key: 'api_key', value: apiKey);
    storage.write(key: 'api_cert', value: cert);

    return true;
  }

  ///handle Errors in the response
  ///We check if context is mounted in the method, so asnyc gap is no problem
  static void handleResponseError(
      Response<dynamic> response, BuildContext context) {
    if (!response.isSuccessful || response.body == null) {
      if (context.mounted) {
        throw Exception(
          S
              .of(context)
              .errorAPIInvalidResponse(response.error?.toString() ?? ""),
        );
      } else {
        throw Exception(
          "[nocontext] Invalid API response: ${response.error}",
        );
      }
    }
  }
}
