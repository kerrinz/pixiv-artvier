import 'package:flutter/widgets.dart';

class BaseProvider with ChangeNotifier {
  late Function notify;

  static bool isDisposed = false;

  BaseProvider() {
    notify = notifyListeners;
    isDisposed = false;
  }

  @override
  void notifyListeners() {
    if (isDisposed) return;
    super.notifyListeners();
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}
