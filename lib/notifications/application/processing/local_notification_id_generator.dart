typedef CurrentMilliseconds = int Function();

class LocalNotificationIdGenerator {
  LocalNotificationIdGenerator({
    CurrentMilliseconds currentMilliseconds = _defaultCurrentMilliseconds,
  }) : _nextId = _normalize(currentMilliseconds());

  static const int minimumId = 1000000;
  static const int maximumId = 0x7fffffff;
  static const int _idRange = maximumId - minimumId + 1;

  int _nextId;

  int next() {
    final int id = _nextId;
    _nextId = id == maximumId ? minimumId : id + 1;
    return id;
  }

  static int _normalize(int milliseconds) =>
      minimumId + (milliseconds % _idRange);

  static int _defaultCurrentMilliseconds() =>
      DateTime.now().millisecondsSinceEpoch;
}
