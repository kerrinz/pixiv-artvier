import 'package:flutter/widgets.dart';

class ProfileProvider with ChangeNotifier {
  int followers = 0; 
  int following = 0; 

  set setFollowers(int n) {
    followers = n;
    notifyListeners();
  }

  set setFollowing(int n) {
    following = n;
    notifyListeners();
  }
}
