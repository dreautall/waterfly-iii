import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';

import 'package:chopper/chopper.dart' show Request, Response;

import 'package:version/version.dart';

import 'package:waterflyiii/generated/swagger_fireflyiii_api/client_index.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';

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

class AuthUser {
  late Uri _host;
  late String _apiKey;
  late FireflyIii _api;
  late FireflyIiiV2 _apiV2;

  Uri get host => _host;
  FireflyIii get api => _api;
  FireflyIiiV2 get apiV2 => _apiV2;

  final Logger log = Logger("Auth.AuthUser");

  AuthUser._create(Uri host, String apiKey) {
    log.config("AuthUser->_create($host)");
    _apiKey = apiKey;

    _host = host.replace(pathSegments: <String>[...host.pathSegments, "api"]);

    _api = FireflyIii.create(
      baseUrl: _host,
      interceptors: <dynamic>[
        (Request request) async {
          log.finest(() => "API query to ${request.url}");
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

    _apiV2 = FireflyIiiV2.create(
      baseUrl: _host,
      interceptors: <dynamic>[
        (Request request) async {
          log.finest(() => "APIv2 query to ${request.url}");
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
    final Logger log = Logger("Auth.AuthUser");
    log.config("AuthUser->create($host)");

    // This call is on purpose not using the Swagger API
    final HttpClient client = HttpClient();
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
      HttpClientRequest request = await client.getUrl(aboutUri);
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

    return AuthUser._create(uri, apiKey);
  }
}
