import 'package:flutter/widgets.dart';

class IsBookmarkedProvider with ChangeNotifier {
  late bool isBookmarked; // 是否已经收藏

  void setBookmarked(bool value) {
    isBookmarked = value;
    notifyListeners();
  }
}