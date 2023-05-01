import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
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
  group('AuthError', () {
    test('AuthErrorHost', () {
      const AuthError err = AuthErrorHost('test.host');
      expect(err, isException);
      expect(err.cause, "Invalid host");
    });
    test('AuthErrorApiKey', () {
      const AuthError err = AuthErrorApiKey();
      expect(err, isException);
      expect(err.cause, "Invalid API key");
    });
    test('AuthErrorStatusCode', () {
      const AuthError err = AuthErrorStatusCode(500);
      expect(err, isException);
      expect(err.cause, "Unexpected HTTP status code");
    });
    test('AuthErrorNoInstance', () {
      const AuthError err = AuthErrorNoInstance('test.host');
      expect(err, isException);
      expect(err.cause, "Not a valid Firefly III instance");
    });
  });
  group('AuthUser', () {
    setUpAll(() {
      HttpOverrides.global = MockHttpOverrides();

      when(mockHttpClient.getUrl(any)).thenAnswer((Invocation invocation) {
        final Uri url = invocation.positionalArguments[0] as Uri;
        late String body;
        int code = HttpStatus.ok;
        // RESPONSES START
        if (url.host.startsWith("invalid")) {
          body = 'INVALID';
        } else if (url.host.startsWith("error400")) {
          code = HttpStatus.badRequest;
          body = 'HTTP 400';
        } else if (url.path.endsWith("/api/v1/about")) {
          body =
              '{"data": {"version": "6.0.9","api_version": "2.0.1","php_version": "8.2.5","os": "Linux","driver": "mysql"}}';
        } else {
          body = '404';
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
            if (apiKey.startsWith('Bearer invalid-')) {
              when(response.statusCode).thenReturn(HttpStatus.movedPermanently);
              when(response.isRedirect).thenReturn(true);
            }
          }

          return MockHttpHeaders().add(invocation.positionalArguments[0],
              invocation.positionalArguments[1]);
        });

        when(response.headers).thenReturn(MockHttpHeaders());
        when(response.handleError(any, test: anyNamed('test')))
            .thenAnswer((_) => Stream<List<int>>.value(utf8.encode(body)));
        when(response.statusCode).thenReturn(code);
        when(response.reasonPhrase).thenReturn('OK');
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
    test('create', () async {
      final AuthUser user =
          await AuthUser.create('mock://fake.host', 'api-key');
      expect(user.host, Uri.parse("mock://fake.host/api"));
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
    test('create: invalid host', () async {
      await expectLater(
        AuthUser.create('::INVALID-HOST::', 'api-key'),
        throwsA(isA<AuthErrorHost>()),
      );
    });
    test('create: no firefly instance', () async {
      await expectLater(
        AuthUser.create('mock://invalid.host', 'api-key'),
        throwsA(isA<AuthErrorNoInstance>()),
      );
    });
    test('create: http response 400', () async {
      await expectLater(
        AuthUser.create('mock://error400.host', 'api-key'),
        throwsA(isA<AuthErrorStatusCode>()),
      );
    });
    test('create: invalid api key', () async {
      await expectLater(
        AuthUser.create('mock://fake.host', 'invalid-api-key'),
        throwsA(isA<AuthErrorApiKey>()),
      );
    });
    test('headers', () async {
      final AuthUser user =
          await AuthUser.create('mock://fake.host', 'api-key');
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
}
