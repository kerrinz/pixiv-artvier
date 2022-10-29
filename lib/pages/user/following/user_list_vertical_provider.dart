import 'package:pixgem/common_provider/base_provider.dart';
import 'package:pixgem/common_provider/loading_request_provider.dart';
import 'package:pixgem/model_response/user/common_user_previews.dart';

class UserListVerticalProvider extends BaseProvider {
  UserListVerticalProvider({
    this.loadingStatus = LoadingStatus.loading,
  });

  /// 用户列表
  List<CommonUserPreviews> userList = [];

  LoadingStatus loadingStatus;

  String? nextUrl;

  resetList(List<CommonUserPreviews> list, String? nextUrl, {LoadingStatus status = LoadingStatus.success}) {
    userList.clear();
    userList.addAll(list);
    this.nextUrl = nextUrl;
    loadingStatus = status;
    notifyListeners();
  }

  appendList(List<CommonUserPreviews> list, String? nextUrl, {LoadingStatus status = LoadingStatus.success}) {
    userList.addAll(list);
    this.nextUrl = nextUrl;
    loadingStatus = status;
    notifyListeners();
  }

  setNextUrl(String? nextUrl) {
    this.nextUrl = nextUrl;
    notifyListeners();
  }

  setLoadingStatus(LoadingStatus status) {
    loadingStatus = status;
    notifyListeners();
  }
}
