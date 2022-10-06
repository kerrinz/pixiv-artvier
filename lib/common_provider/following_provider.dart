import 'package:flutter/material.dart';

class FollowingProvider extends ChangeNotifier {
  bool? isFollowing;

  void setIsFollowing(bool isFollowing) {
    this.isFollowing = isFollowing;
    notifyListeners();
  }
}
