import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/model_response/user/user_detail.dart';
import 'package:pixgem/request/api_app.dart';
import 'package:provider/provider.dart';

class UserDetailPage extends StatefulWidget {
  late final String userId;

  UserDetailPage(Object arguments, {Key? key}) : super(key: key) {
    userId = arguments as String;
  }

  @override
  State<StatefulWidget> createState() {
    return _UserDetailState();
  }
}

class _UserDetailState extends State<UserDetailPage> {
  _UserDetailProvider _userDetailProvider = new _UserDetailProvider();

  @override
  void initState() {
    super.initState();
    refreshData().catchError((onError) {
      Fluttertoast.showToast(msg: "获取用户数据失败！", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
    }).whenComplete(() {
      _userDetailProvider.setIsLoading(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => _userDetailProvider,
      child: Scaffold(
        appBar: AppBar(
          title: Consumer(builder: (BuildContext context, _UserDetailProvider provider, Widget? child) {
            if (provider.isLoading) return Text("loading...");
            return Text(
              provider.userDetail.user.name,
              style: TextStyle(fontSize: 18),
            );
          }),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          brightness: Brightness.dark,
          // 状态栏亮度，对应影响到字体颜色（dark为白色字体）
          leading: Builder(builder: (context) {
            return IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          }),
        ),
        body: Container(),
      ),
    );
  }

  Future refreshData() async {
    var userDetail = await ApiApp().getUserDetail(userId: widget.userId);
    _userDetailProvider.setUserDetail(userDetail);
  }
}

/* Provider: IllustDetail
 */
class _UserDetailProvider with ChangeNotifier {
  late UserDetail userDetail;
  bool isLoading = true; // 是否正在加载
  bool isFollowedAuthor = false; // 是否已经关注作者

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
