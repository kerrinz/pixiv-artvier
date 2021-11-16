import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/model_response/user/preload_user_least_info.dart';
import 'package:pixgem/model_store/account_profile.dart';
import 'package:pixgem/store/account_store.dart';
import 'package:pixgem/store/global.dart';
import 'package:pixgem/store/theme_store.dart';
import 'package:pixgem/widgets/preferences_navigator_item.dart';
import 'package:provider/provider.dart';

class MineTabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MineTabPageState();
}

class MineTabPageState extends State<MineTabPage> with AutomaticKeepAliveClientMixin {
  List<FunctionCardModel> _cards = [
    FunctionCardModel("流览历史", Icons.history, "", null),
    FunctionCardModel("我的收藏", Icons.favorite, "my_bookmarks", GlobalStore.currentAccount?.user.id),
    FunctionCardModel("我的关注", Icons.star, "user_following", GlobalStore.currentAccount?.user.id),
    FunctionCardModel("下载记录", Icons.download, "", null),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
          Selector(
            selector: (BuildContext context, GlobalProvider provider) {
              return provider.themeMode;
            },
            builder: (BuildContext context, ThemeMode themeMode, Widget? child) {
              int mode = ThemeStore.transferByThemeMode(themeMode);
              mode = (mode + 1) % 3; // 下一个主题模式
              return IconButton(
                onPressed: () {
                  GlobalStore.globalProvider.setThemeMode(ThemeStore.transferToThemeMode(mode));
                },
                icon: Icon(themeMode == ThemeMode.light
                    ? Icons.light_mode
                    : (themeMode == ThemeMode.dark ? Icons.mode_night : Icons.brightness_auto)),
                tooltip: "切换主题模式，A为自动",
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        child: Container(
          // 这样解决了内容不足以支撑全屏时，滑动回弹不会回到原位的问题
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  kToolbarHeight -
                  MediaQuery.of(context).padding.top -
                  kBottomNavigationBarHeight),
          child: Column(
            children: [
              // 用户简卡
              Container(child: _buildUserCard(context)),
              // 功能卡片
              Card(
                elevation: 1.5,
                margin: const EdgeInsets.all(8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                clipBehavior: Clip.antiAlias,
                child: GridView.builder(
                  controller: ScrollController(keepScrollOffset: false),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemCount: _cards.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Material(
                      color: Theme.of(context).cardColor,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, _cards[index].navigatorName, arguments: _cards[index].argument);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(_cards[index].assetsImageUrl, size: 22),
                            ),
                            Text(_cards[index].text, style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              // 设置项列表
              Builder(builder: (context) {
                List<PreferencesNavigatorItem> preferencesItems = [
                  PreferencesNavigatorItem(icon: Icon(Icons.color_lens), text: "主题模式和配色", routeName: "setting_theme"),
                  PreferencesNavigatorItem(icon: Icon(Icons.settings), text: "下载与保存", routeName: "setting_download"),
                  PreferencesNavigatorItem(icon: Icon(Icons.settings), text: "设置", routeName: "routeName"),
                ];
                return Column(
                  children: preferencesItems,
                );
              }),
            ],
          ),
        ),
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
                          return CachedNetworkImage(
                            imageUrl: profile.user.profileImageUrls!.px170x170,
                            httpHeaders: {"Referer": CONSTANTS.referer},
                          );
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
          (onError) => Fluttertoast.showToast(msg: "加载失败!$onError", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0),
        );
  }
}

// 功能卡片的数据模型
class FunctionCardModel {
  String text;
  IconData assetsImageUrl;
  String navigatorName;
  Object? argument;

  FunctionCardModel(this.text, this.assetsImageUrl, this.navigatorName, this.argument);
}
