import 'package:test/test.dart';

import 'package:waterflyiii/auth.dart';

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
}
