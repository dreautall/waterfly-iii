import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';

@GenerateNiceMocks(<MockSpec<dynamic>>[
  MockSpec<HttpClient>(),
  MockSpec<HttpClientRequest>(),
  MockSpec<HttpClientResponse>(),
  MockSpec<HttpHeaders>(),
])
import 'auth_test.mocks.dart';

final MockHttpClient mockHttpClient = MockHttpClient();

class MockHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return mockHttpClient;
  }
}

void main() {
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
      test("success", () async {
        final AuthUser user =
            await AuthUser.create("mock://fake.host", "api-key");
        expect(user.host, equals(Uri.parse("mock://fake.host/api")));
        expect(user.api, isA<FireflyIii>());
        expect(
          user.headers(),
          containsPair(HttpHeaders.authorizationHeader, "Bearer api-key"),
        );
        expect(
          user.headers(),
          containsPair(HttpHeaders.acceptHeader, "application/json"),
        );
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
    late FireflyService service;
    setUpAll(() {
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
          body =
              '{"data": {"version": "6.0.9","api_version": "2.0.1","php_version": "8.2.5","os": "Linux","driver": "mysql"}}';
        } else if (url.path.endsWith("/api/v1/currencies/default")) {
          body =
              '{"data": {"type": "currencies","id": "1","attributes": {"created_at": "2023-05-01T14:04:19+02:00","updated_at": "2023-05-01T14:04:19+02:00","default": true,"enabled": true,"name": "Euro","code": "EUR","symbol": "€","decimal_places": 2},"links": {"0": {"rel": "self","uri": "/currencies/1"},"self": "https://demo.firefly-iii.org/api/v1/currencies/1"}}}';
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
      service = FireflyService();
    });
    group("signIn(FromStorage)", () {
      test("no credentials", () {
        expect(service.signedIn, false);
        expectLater(service.signInFromStorage(), completion(isFalse));
        expect(service.signedIn, false);
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
      });
      test("valid login", () async {
        FlutterSecureStorage.setMockInitialValues(<String, String>{
          "api_host": "mock://fake.host",
          "api_key": "api-key"
        });
        await expectLater(service.signInFromStorage(), completion(isTrue));
        expect(service.signedIn, isTrue);
        expect(service.hasApi, isTrue);
        expect(service.user, isNotNull);
        expect(service.user!.host, equals(Uri.parse("mock://fake.host/api")));
      });
    });
    group("signOut", () {
      test("result", () async {
        await service.signOut();
        expect(service.signedIn, isFalse);
        expect(service.hasApi, isFalse);
        expect(service.user, isNull);
        expect(service.storageSignInException, isNull);
      });
    });
  });
}
