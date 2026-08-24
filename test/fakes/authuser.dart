import 'package:waterflyiii/auth.dart';

class FakeAuthUser implements AuthUser {
  @override
  Map<String, String> headers() => <String, String>{
    'Authorization': 'Bearer test',
  };

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
