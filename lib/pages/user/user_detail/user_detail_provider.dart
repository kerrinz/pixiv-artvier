import 'package:flutter/widgets.dart';
import 'package:pixgem/common_provider/loading_request_provider.dart';
import 'package:pixgem/model_response/user/user_detail.dart';

class UserDetailProvider with ChangeNotifier {
  UserDetail? userDetail;
  LoadingStatus loadingStatus = LoadingStatus.loading; // 加载状态
  bool? isFollowedAuthor; // 是否已经关注作者

  void setUserDetail(UserDetail newData) {
    userDetail = newData;
    notifyListeners();
  }

  void setLoadingStatus(LoadingStatus status) {
    loadingStatus = status;
    notifyListeners();
  }

  void setFollowed(bool value) {
    isFollowedAuthor = value;
    notifyListeners();
  }
}
