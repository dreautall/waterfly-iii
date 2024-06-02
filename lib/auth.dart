import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:logging/logging.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:version/version.dart';

import 'package:waterflyiii/generated/api/v1/export.dart';
import 'package:waterflyiii/generated/api/v2/export.dart';
import 'package:waterflyiii/stock.dart';
import 'package:waterflyiii/timezonehandler.dart';

final Logger log = Logger("Auth");
final Version minApiVersion = Version(2, 0, 0);

class APITZReply {
  APITZReply(this.data);
  APITZReplyData data;

  factory APITZReply.fromJson(dynamic json) {
    return APITZReply(APITZReplyData.fromJson(json['data']));
  }
}

class APITZReplyData {
  APITZReplyData(this.title, this.value, this.editable);
  String title;
  String value;
  bool editable;

  factory APITZReplyData.fromJson(dynamic json) {
    return APITZReplyData(
      json['title'] as String,
      json['value'] as String,
      json['editable'] as bool,
    );
  }
}

class SSLHttpOverride extends HttpOverrides {
  SSLHttpOverride(this.validCert);
  final String validCert;

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    // Needed for issue #75
    //context ??= SecurityContext.defaultContext;
    //context.useCertificateChainBytes(chainBytes);
    //context.usePrivateKeyBytes(keyBytes);
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, _, __) {
        log.fine("Using SSLHttpOverride");
        return cert.pem.replaceAll("\r", "").trim() ==
            validCert.replaceAll("\r", "").trim();
      };
  }
}

// :TODO: translate strings. cause returns just an identifier for the translation.
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

class AuthErrorVersionInvalid extends AuthError {
  const AuthErrorVersionInvalid() : super("Invalid Firefly API version");
}

class AuthErrorVersionTooLow extends AuthError {
  const AuthErrorVersionTooLow(this.requiredVersion)
      : super("Firefly API version too low");

  final Version requiredVersion;
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

http.Client get httpClient => IOClient(HttpClient());

/*
class APIRequestInterceptor implements Interceptor {
  APIRequestInterceptor(this.headerFunc);

  final Function() headerFunc;

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
      Chain<BodyType> chain) async {
    log.finest(() => "API query to ${chain.request.url}");
    final Request request =
        applyHeaders(chain.request, headerFunc(), override: true);
    request.followRedirects = false;
    request.maxRedirects = 0;
    return chain.proceed(request);
  }
}

*/

class AuthUser {
  late Uri _host;
  late String _apiKey;
  late APIv1 _api;
  late APIv2 _apiV2;

  Uri get host => _host;
  APIv1 get api => _api;
  APIv2 get apiV2 => _apiV2;

  final Logger log = Logger("Auth.AuthUser");

  AuthUser._create(Uri host, String apiKey) {
    log.config("AuthUser->_create($host)");
    _apiKey = apiKey;

    _host = host.replace(pathSegments: <String>[...host.pathSegments, "api"]);

    final Dio dio = Dio(
      BaseOptions(
        headers: headers(),
      ),
    );

    /* Consider https://pub.dev/packages/native_dio_adapter
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: httpClient,
    )
    */

    _api = APIv1(
      dio,
      baseUrl: _host.toString(),
    );

    _apiV2 = APIv2(
      dio,
      baseUrl: _host.toString(),
    );
  }

  Map<String, String> headers() {
    return <String, String>{
      HttpHeaders.authorizationHeader: "Bearer $_apiKey",
      HttpHeaders.acceptHeader: "application/json",
    };
  }

  static Future<AuthUser> create(String host, String apiKey) async {
    final Logger log = Logger("Auth.AuthUser");
    log.config("AuthUser->create($host)");

    // This call is on purpose not using the Swagger API
    final http.Client client = httpClient;
    late Uri uri;

    try {
      uri = Uri.parse(host);
    } on FormatException {
      throw AuthErrorHost(host);
    }

    Uri aboutUri = uri.replace(pathSegments: <String>[
      ...uri.pathSegments,
      "api",
      "v1",
      "about",
    ]);

    try {
      final http.Request request = http.Request("GET", aboutUri);
      request.headers[HttpHeaders.authorizationHeader] = "Bearer $apiKey";
      request.followRedirects = false;
      final http.StreamedResponse response = await request.send();

      if (response.isRedirect) {
        throw const AuthErrorApiKey();
      }
      if (response.statusCode != 200) {
        throw AuthErrorStatusCode(response.statusCode);
      }

      final String stringData = await response.stream.bytesToString();

      try {
        SystemInfo.fromJson(json.decode(stringData));
      } on FormatException {
        throw AuthErrorNoInstance(host);
      }
    } finally {
      client.close();
    }

    return AuthUser._create(uri, apiKey);
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
  Version? _apiVersion;
  Version? get apiVersion => _apiVersion;

  TransStock? _transStock;
  TransStock? get transStock => _transStock;

  bool get hasApi => (_currentUser?.api != null) ? true : false;
  APIv1 get api {
    if (_currentUser?.api == null) {
      signOut();
      throw Exception("API unavailable");
    }
    return _currentUser!.api;
  }

  APIv2 get apiV2 {
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

  Future<bool> signIn(String host, String apiKey, [String? cert]) async {
    log.config("FireflyService->signIn($host)");
    host = host.trim();
    if (host.endsWith("/")) {
      host = host.substring(0, host.length - 1);
    }
    apiKey = apiKey.trim();

    if (cert != null && cert.isNotEmpty) {
      HttpOverrides.global = SSLHttpOverride(cert);
    } else {
      HttpOverrides.global = null;
    }

    _lastTriedHost = host;
    _currentUser = await AuthUser.create(host, apiKey);
    if (_currentUser == null || !hasApi) return false;

    CurrencySingle currencyInfo = await api.currencies.getDefaultCurrency();
    defaultCurrency = currencyInfo.data;

    SystemInfo about = await api.about.getAbout();
    try {
      _apiVersion = Version.parse(about.data.apiVersion);
    } on FormatException {
      throw const AuthErrorVersionInvalid();
    }
    log.info(() => "Firefly API version $_apiVersion");
    if (apiVersion == null || apiVersion! < minApiVersion) {
      throw AuthErrorVersionTooLow(minApiVersion);
    }

    // Manual API query as the Swagger type doesn't resolve in Flutter :(
    final http.Client client = httpClient;
    Uri tzUri = user!.host.replace(pathSegments: <String>[
      ...user!.host.pathSegments,
      "v1",
      "configuration",
      ConfigValueFilter.undefined14.name
    ]);
    try {
      final http.Response response = await client.get(
        tzUri,
        headers: user!.headers(),
      );
      final APITZReply reply = APITZReply.fromJson(json.decode(response.body));
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
}

void apiThrowErrorIfEmpty(Response<dynamic> response, BuildContext? context) {
  if (response.statusCode == HttpStatus.ok && response.data != null) {
    return;
  }
  log.severe("Invalid API response", response.statusMessage);
  if (context?.mounted ?? false) {
    throw Exception(
      S
          .of(context!)
          .errorAPIInvalidResponse(response.statusMessage?.toString() ?? ""),
    );
  } else {
    throw Exception(
      "[nocontext] Invalid API response: ${response.statusMessage}",
    );
  }
}
