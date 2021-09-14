import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/model_response/user/perload_user_least_info.dart';
import 'package:pixgem/model_store/account_profile.dart';
import 'package:pixgem/store/account_store.dart';
import 'package:pixgem/store/global.dart';
import 'package:provider/provider.dart';

class MineTabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MineTabPageState();
}

class MineTabPageState extends State<MineTabPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed("account_manage");
            },
            icon: Icon(Icons.switch_account_outlined),
            tooltip: "多帐号管理",
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.color_lens),
            tooltip: "主题",
          ),
        ],
      ),
      body: Column(
        children: [
          _buildUserCard(context),
          Text("CNM"),
        ],
      ),
    );
  }

  // 用户简卡
  Widget _buildUserCard(BuildContext context) {
    return InkWell(
      onTap: () {
        var user = PreloadUserLeastInfo(int.parse(GlobalStore.currentAccount!.user.id),
            GlobalStore.currentAccount!.user.name, GlobalStore.currentAccount!.user.profileImageUrls!.px170x170);
        Navigator.of(context).pushNamed("user_detail", arguments: user);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              // 用户简卡
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 头像
                  ClipOval(
                    child: Container(
                      width: 64,
                      height: 64,
                      child: Selector(
                        selector: (BuildContext context, GlobalProvider provider) {
                          return provider.currentAccount;
                        },
                        builder: (BuildContext context, AccountProfile? profile, Widget? child) {
                          // 未登录或者原本就无头像用户
                          if (profile == null || profile.user.profileImageUrls == null) {
                            return Image(image: AssetImage("assets/images/default_avatar.png"));
                          }
                          return CachedNetworkImage(imageUrl: profile.user.profileImageUrls!.px170x170);
                        },
                      ),
                    ),
                  ),
                  // 昵称、帐号
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Selector(selector: (BuildContext context, GlobalProvider provider) {
                      return provider.currentAccount;
                    }, builder: (BuildContext context, AccountProfile? profile, Widget? child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile == null ? "..." : profile.user.name,
                            style: TextStyle(
                              fontSize: 20,
                              height: 1.4,
                            ),
                          ),
                          Text(
                            profile == null ? "..." : profile.user.mailAddress,
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.6,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
            Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    readProfile();
  }

  // 读取配置数据
  void readProfile() {
    AccountStore.getCurrentAccountProfile()
        .then((value) => GlobalStore.globalProvider.setCurrentAccount(value!))
        .catchError(
            (onError) => Fluttertoast.showToast(msg: "加载失败!$onError", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0));
  }
}
