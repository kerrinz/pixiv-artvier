import 'package:flutter/widgets.dart';
import 'package:pixgem/model_response/user/user_detail.dart';

class UserDetailProvider with ChangeNotifier {
  UserDetail? userDetail;
  bool isLoading = true; // 是否正在加载
  bool? isFollowedAuthor; // 是否已经关注作者

  void setUserDetail(UserDetail newData) {
    userDetail = newData;
    notifyListeners();
  }

  void setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void setFollowed(bool value) {
    isFollowedAuthor = value;
    notifyListeners();
  }
}
