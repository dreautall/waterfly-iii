import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

final Logger log = Logger("Layout");

// https://m3.material.io/foundations/layout/applying-layout/window-size-classes
enum ScreenSize { compact, medium, expanded }

class LayoutProvider with ChangeNotifier {
  late ScreenSize _currentSize;
  ScreenSize get currentSize => _currentSize;

  LayoutProvider(BuildContext context) {
    _currentSize = fromContext(context);
    log.finest(() => "init done, currentSize: $_currentSize");
  }

  ScreenSize getSize(double width) {
    if (width < 600) {
      return ScreenSize.compact;
    } else if (width < 840) {
      return ScreenSize.medium;
    } else {
      return ScreenSize.expanded;
    }
  }

  ScreenSize fromContext(BuildContext context) =>
      getSize(MediaQuery.sizeOf(context).width);

  void updateSize(BuildContext context) {
    final ScreenSize newSize = fromContext(context);
    if (newSize == _currentSize) return;
    log.finest(() => "size updating, old: $_currentSize, new: $newSize");
    _currentSize = newSize;
    notifyListeners();
  }
}
