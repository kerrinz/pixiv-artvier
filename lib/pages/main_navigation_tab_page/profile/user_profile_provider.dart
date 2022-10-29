
import 'package:pixgem/common_provider/base_provider.dart';

class UserProfileProvider extends BaseProvider {
  int? followers;
  int? following;
  int? friends;

  void setAll(int followers, int following, int friends) {
    this.followers = followers;
    this.following = following;
    this.friends = friends;
    notifyListeners();
  }

  set setFollowers(int n) {
    followers = n;
    notifyListeners();
  }

  set setFollowing(int n) {
    following = n;
    notifyListeners();
  }

  set setFriends(int n) {
    friends = n;
    notifyListeners();
  }
}
