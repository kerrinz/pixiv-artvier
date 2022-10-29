import 'package:pixgem/common_provider/base_provider.dart';

class FollowingProvider extends BaseProvider {
  bool? isFollowing;

  void setIsFollowing(bool isFollowing) {
    this.isFollowing = isFollowing;
    notifyListeners();
  }
}
