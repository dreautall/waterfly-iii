import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart' show TestWidgetsFlutterBinding;
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:chopper/chopper.dart' show Response;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:version/version.dart';

import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii_v2.swagger.dart';

@GenerateNiceMocks(<MockSpec<dynamic>>[
  MockSpec<HttpClient>(),
  MockSpec<HttpClientRequest>(),
  MockSpec<HttpClientResponse>(),
  MockSpec<HttpHeaders>(),
])
import 'auth_test.mocks.dart';

final MockHttpClient mockHttpClient = MockHttpClient();

class MockBuildContext extends Mock implements BuildContext {
  @override
  final bool mounted = false;
}

class MockHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return mockHttpClient;
  }
}

class MockCallbackFunction extends Mock {
  void call();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("AuthError", () {
    test("AuthErrorHost", () {
      const AuthError err = AuthErrorHost("test.host");
      expect(err, isException);
      expect(err.cause, "Invalid host");
    });
    test("AuthErrorApiKey", () {
      const AuthError err = AuthErrorApiKey();
      expect(err, isException);
      expect(err.cause, "Invalid API key");
    });
    test("AuthErrorVersionInvalid", () {
      const AuthError err = AuthErrorVersionInvalid();
      expect(err, isException);
      expect(err.cause, "Invalid Firefly API version");
    });
    test("AuthErrorVersionTooLow", () {
      final AuthError err = AuthErrorVersionTooLow(Version(0, 1, 2));
      expect(err, isException);
      expect(err.cause, "Firefly API version too low");
    });
    test("AuthErrorStatusCode", () {
      const AuthError err = AuthErrorStatusCode(500);
      expect(err, isException);
      expect(err.cause, "Unexpected HTTP status code");
    });
    test("AuthErrorNoInstance", () {
      const AuthError err = AuthErrorNoInstance("test.host");
      expect(err, isException);
      expect(err.cause, "Not a valid Firefly III instance");
    });
  });

  group("AuthUser", () {
    setUpAll(() {
      HttpOverrides.global = MockHttpOverrides();

      when(mockHttpClient.getUrl(any)).thenAnswer((Invocation invocation) {
        final Uri url = invocation.positionalArguments[0] as Uri;
        late String body;
        int code = HttpStatus.ok;
        // RESPONSES START
        if (url.host.startsWith("invalid")) {
          body = "INVALID";
        } else if (url.host.startsWith("error400")) {
          code = HttpStatus.badRequest;
          body = "HTTP 400";
        } else if (url.path.endsWith("/api/v1/about")) {
          body =
              '{"data": {"version": "6.0.9","api_version": "2.0.1","php_version": "8.2.5","os": "Linux","driver": "mysql"}}';
        } else {
          body = "404";
        }
        // RESPONSES END
        final MockHttpClientRequest request = MockHttpClientRequest();
        final MockHttpClientResponse response = MockHttpClientResponse();
        final MockHttpHeaders requestHeaders = MockHttpHeaders();
        when(request.close())
            .thenAnswer((_) => Future<HttpClientResponse>.value(response));
        when(request.addStream(any)).thenAnswer((_) async => null);
        when(request.headers).thenReturn(requestHeaders);

        when(requestHeaders.add(any, any)).thenAnswer((Invocation invocation) {
          if (invocation.positionalArguments[0] ==
              HttpHeaders.authorizationHeader) {
            final String apiKey = invocation.positionalArguments[1];
            if (apiKey.startsWith("Bearer invalid-")) {
              when(response.statusCode).thenReturn(HttpStatus.movedPermanently);
              when(response.isRedirect).thenReturn(true);
            }
          }

          return MockHttpHeaders().add(invocation.positionalArguments[0],
              invocation.positionalArguments[1]);
        });

        when(response.headers).thenReturn(MockHttpHeaders());
        when(response.handleError(any, test: anyNamed("test")))
            .thenAnswer((_) => Stream<List<int>>.value(utf8.encode(body)));
        when(response.statusCode).thenReturn(code);
        when(response.reasonPhrase).thenReturn("OK");
        when(response.contentLength).thenReturn(body.length);
        when(response.isRedirect).thenReturn(false);
        when(response.persistentConnection).thenReturn(false);
        when(response.transform(any)).thenAnswer((Invocation invocation) {
          final StreamTransformer<List<int>, String> decoder =
              invocation.positionalArguments[0];
          return Stream<List<int>>.fromFuture(
                  Future<List<int>>.value(utf8.encode(body)))
              .transform(decoder);
        });
        return Future<HttpClientRequest>.value(request);
      });
    });
    group("create", () {
      group("success", () {
        test("TLD", () async {
          final AuthUser user =
              await AuthUser.create("mock://fake.host", "api-key");
          expect(user.host, equals(Uri.parse("mock://fake.host/api")));
          expect(user.api, isA<FireflyIii>());
          expect(user.apiV2, isA<FireflyIiiV2>());
          expect(
            user.headers(),
            containsPair(HttpHeaders.authorizationHeader, "Bearer api-key"),
          );
          expect(
            user.headers(),
            containsPair(HttpHeaders.acceptHeader, "application/json"),
          );
        });
        test("subdomain", () async {
          final AuthUser user =
              await AuthUser.create("mock://sub.fake.host", "api-key");
          expect(user.host, equals(Uri.parse("mock://sub.fake.host/api")));
          expect(user.api, isA<FireflyIii>());
          expect(user.apiV2, isA<FireflyIiiV2>());
          expect(
            user.headers(),
            containsPair(HttpHeaders.authorizationHeader, "Bearer api-key"),
          );
          expect(
            user.headers(),
            containsPair(HttpHeaders.acceptHeader, "application/json"),
          );
        });
        test("custom port", () async {
          final AuthUser user =
              await AuthUser.create("mock://fake.host:1234", "api-key");
          expect(user.host, equals(Uri.parse("mock://fake.host:1234/api")));
          expect(user.api, isA<FireflyIii>());
          expect(user.apiV2, isA<FireflyIiiV2>());
          expect(
            user.headers(),
            containsPair(HttpHeaders.authorizationHeader, "Bearer api-key"),
          );
          expect(
            user.headers(),
            containsPair(HttpHeaders.acceptHeader, "application/json"),
          );
        });
        test("custom path", () async {
          final AuthUser user =
              await AuthUser.create("mock://fake.host/sub/path", "api-key");
          expect(user.host, equals(Uri.parse("mock://fake.host/sub/path/api")));
          expect(user.api, isA<FireflyIii>());
          expect(user.apiV2, isA<FireflyIiiV2>());
          expect(
            user.headers(),
            containsPair(HttpHeaders.authorizationHeader, "Bearer api-key"),
          );
          expect(
            user.headers(),
            containsPair(HttpHeaders.acceptHeader, "application/json"),
          );
        });
        test("port + path", () async {
          final AuthUser user = await AuthUser.create(
              "mock://sub.fake.host:1234/sub/path", "api-key");
          expect(user.host,
              equals(Uri.parse("mock://sub.fake.host:1234/sub/path/api")));
          expect(user.api, isA<FireflyIii>());
          expect(user.apiV2, isA<FireflyIiiV2>());
          expect(
            user.headers(),
            containsPair(HttpHeaders.authorizationHeader, "Bearer api-key"),
          );
          expect(
            user.headers(),
            containsPair(HttpHeaders.acceptHeader, "application/json"),
          );
        });
      });
      test("invalid host", () async {
        await expectLater(
          AuthUser.create("::INVALID-HOST::", "api-key"),
          throwsA(isA<AuthErrorHost>()),
        );
      });
      test("no firefly instance", () async {
        await expectLater(
          AuthUser.create("mock://invalid.host", "api-key"),
          throwsA(isA<AuthErrorNoInstance>()),
        );
      });
      test("http response 400", () async {
        await expectLater(
          AuthUser.create("mock://error400.host", "api-key"),
          throwsA(isA<AuthErrorStatusCode>()),
        );
      });
      test("invalid api key", () async {
        await expectLater(
          AuthUser.create("mock://fake.host", "invalid-api-key"),
          throwsA(isA<AuthErrorApiKey>()),
        );
      });
    });
    test("headers", () async {
      final AuthUser user =
          await AuthUser.create("mock://fake.host", "api-key");
      expect(
        user.headers(),
        containsPair(HttpHeaders.authorizationHeader, "Bearer api-key"),
      );
      expect(
        user.headers(),
        containsPair(HttpHeaders.acceptHeader, "application/json"),
      );
    });
  });

  group("FireflyService", () {
    final MockCallbackFunction notifyListenerCallback = MockCallbackFunction();
    late FireflyService service;

    setUpAll(() {
      tz_data.initializeTimeZones();
      HttpOverrides.global = MockHttpOverrides();

      when(mockHttpClient.openUrl(any, any))
          .thenAnswer((Invocation invocation) {
        if (invocation.positionalArguments[0] == "GET") {
          return mockHttpClient.getUrl(invocation.positionalArguments[1]);
        }
        return mockHttpClient.postUrl(invocation.positionalArguments[1]);
      });
      when(mockHttpClient.getUrl(any)).thenAnswer((Invocation invocation) {
        final Uri url = invocation.positionalArguments[0] as Uri;
        late String body;
        int code = HttpStatus.ok;
        // RESPONSES START
        if (url.host.startsWith("invalid")) {
          body = "INVALID";
        } else if (url.host.startsWith("error400")) {
          code = HttpStatus.badRequest;
          body = "HTTP 400";
        } else if (url.path.endsWith("/api/v1/about")) {
          String apiVersion = "9.9.9";
          if (url.host.endsWith("low")) {
            apiVersion = "1.0.0";
          }
          body =
              '{"data": {"version": "6.0.9","api_version": "$apiVersion","php_version": "8.2.5","os": "Linux","driver": "mysql"}}';
        } else if (url.path.endsWith("/api/v1/currencies/default")) {
          body =
              '{"data": {"type": "currencies","id": "1","attributes": {"created_at": "2023-05-01T14:04:19+02:00","updated_at": "2023-05-01T14:04:19+02:00","default": true,"enabled": true,"name": "Euro","code": "EUR","symbol": "€","decimal_places": 2},"links": {"0": {"rel": "self","uri": "/currencies/1"},"self": "https://demo.firefly-iii.org/api/v1/currencies/1"}}}';
        } else if (url.path.endsWith("/api/v1/configuration/app.timezone")) {
          body =
              '{"data":{"title":"app.timezone","value":"Europe/Amsterdam","editable":false}}';
        } else {
          body = "404";
        }
        // RESPONSES END
        final MockHttpClientRequest request = MockHttpClientRequest();
        final MockHttpClientResponse response = MockHttpClientResponse();
        final MockHttpHeaders requestHeaders = MockHttpHeaders();
        when(request.close())
            .thenAnswer((_) => Future<HttpClientResponse>.value(response));
        when(request.addStream(any)).thenAnswer((_) async => null);
        when(request.headers).thenReturn(requestHeaders);

        when(requestHeaders.add(any, any)).thenAnswer((Invocation invocation) {
          if (invocation.positionalArguments[0] ==
              HttpHeaders.authorizationHeader) {
            final String apiKey = invocation.positionalArguments[1];
            if (apiKey.startsWith("Bearer invalid-")) {
              when(response.statusCode).thenReturn(HttpStatus.movedPermanently);
              when(response.isRedirect).thenReturn(true);
            }
          }

          return MockHttpHeaders().add(invocation.positionalArguments[0],
              invocation.positionalArguments[1]);
        });

        when(response.headers).thenReturn(MockHttpHeaders());
        when(response.handleError(any, test: anyNamed("test")))
            .thenAnswer((_) => Stream<List<int>>.value(utf8.encode(body)));
        when(response.statusCode).thenReturn(code);
        when(response.reasonPhrase).thenReturn("OK");
        when(response.contentLength).thenReturn(body.length);
        when(response.isRedirect).thenReturn(false);
        when(response.persistentConnection).thenReturn(false);
        when(response.transform(any)).thenAnswer((Invocation invocation) {
          final StreamTransformer<List<int>, String> decoder =
              invocation.positionalArguments[0];
          return Stream<List<int>>.fromFuture(
                  Future<List<int>>.value(utf8.encode(body)))
              .transform(decoder);
        });
        return Future<HttpClientRequest>.value(request);
      });

      SharedPreferences.setMockInitialValues(const <String, Object>{});
      FlutterSecureStorage.setMockInitialValues(<String, String>{});
      service = FireflyService()..addListener(notifyListenerCallback.call);
      reset(notifyListenerCallback);
    });
    group("signIn(FromStorage)", () {
      test("no credentials", () async {
        expect(service.signedIn, false);
        await expectLater(service.signInFromStorage(), completion(isFalse));
        expect(service.signedIn, false);
        verifyNever(notifyListenerCallback());
      });
      test("invalid credentials", () async {
        FlutterSecureStorage.setMockInitialValues(<String, String>{
          "api_host": "mock://fake.host",
          "api_key": "invalid-api-key"
        });
        await expectLater(service.signInFromStorage(), completion(isFalse));
        expect(service.storageSignInException, isA<AuthErrorApiKey>());
        expect(service.lastTriedHost, equals("mock://fake.host"));
        expect(service.signedIn, false);
        expect(service.hasApi, false);
        verify(notifyListenerCallback()).called(1);
      });

      test("api version too low", () async {
        FlutterSecureStorage.setMockInitialValues(<String, String>{
          "api_host": "mock://fake.host.apilow",
          "api_key": "api-key"
        });
        await expectLater(service.signInFromStorage(), completion(isFalse));
        expect(service.storageSignInException, isA<AuthErrorVersionTooLow>());
        expect(service.lastTriedHost, equals("mock://fake.host.apilow"));
        expect(service.signedIn, false);
        expect(service.hasApi, false);
        verify(notifyListenerCallback()).called(1);
      });
      test("success", () async {
        FlutterSecureStorage.setMockInitialValues(<String, String>{
          "api_host": "mock://fake.host",
          "api_key": "api-key"
        });
        await expectLater(service.signInFromStorage(), completion(isTrue));
        expect(service.signedIn, isTrue);
        expect(service.hasApi, isTrue);
        expect(service.user, isNotNull);
        expect(service.user!.host, equals(Uri.parse("mock://fake.host/api")));
        expect(service.api, isNotNull);
        expect(service.apiV2, isNotNull);
        verify(notifyListenerCallback()).called(1);
      });
    });
    group("signOut", () {
      test("result", () async {
        await service.signOut();
        expect(service.signedIn, isFalse);
        expect(service.hasApi, isFalse);
        expect(service.user, isNull);
        expect(service.storageSignInException, isNull);
        verify(notifyListenerCallback()).called(1);
        expect(() => service.api, throwsA(isA<Exception>()));
        expect(() => service.apiV2, throwsA(isA<Exception>()));
      });
    });
  });

  group("apiThrowErrorIfEmpty", () {
    late MockBuildContext context;
    setUp(() {
      context = MockBuildContext();
    });

    test("successful response", () {
      final Response<String> r = Response<String>(
        http.Response("string", HttpStatus.ok),
        "string",
        error: null,
      );
      expect(() => apiThrowErrorIfEmpty(r, context), isA<void>());
    });

    test("body == null", () {
      final Response<String?> r = Response<String?>(
        http.Response("", HttpStatus.ok),
        null,
        error: null,
      );
      expect(() => apiThrowErrorIfEmpty(r, context), throwsA(isA<Exception>()));
    });

    test("status == 500", () {
      final Response<String> r = Response<String>(
        http.Response("string", HttpStatus.internalServerError),
        "string",
        error: null,
      );
      expect(() => apiThrowErrorIfEmpty(r, context), throwsA(isA<Exception>()));
    });
  });
}
