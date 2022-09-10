import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/common_provider/global_provider.dart';
import 'package:pixgem/component/perference/preferences_navigator_item.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/model_response/user/preload_user_least_info.dart';
import 'package:pixgem/model_store/account_profile.dart';
import 'package:pixgem/routes.dart';
import 'package:pixgem/store/account_store.dart';
import 'package:pixgem/store/global.dart';
import 'package:provider/provider.dart';

class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProfileTabPageState();
}

class ProfileTabPageState extends State<ProfileTabPage> with AutomaticKeepAliveClientMixin {
  final List<FunctionCardModel> _cards = [
    FunctionCardModel("足迹", Icons.history, RouteNames.mainNavigation.name, null),
    FunctionCardModel("下载", Icons.download, RouteNames.downloadManage.name, null),
    // FunctionCardModel("作品", Icons.favorite, RouteNames.myBookmarks.name, GlobalStore.currentAccount?.user.id),
    FunctionCardModel("收藏", Icons.favorite, RouteNames.myBookmarks.name, GlobalStore.currentAccount?.user.id),
    FunctionCardModel("关注", Icons.star, RouteNames.userFollowing.name, GlobalStore.currentAccount?.user.id),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        shadowColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(RouteNames.accountManage.name);
            },
            icon: const Icon(Icons.switch_account_outlined),
            tooltip: "多帐号管理",
          ),
          Builder(
            builder: (BuildContext context) {
              // 当前所处的主题模式
              bool isDarkMode = Theme.of(context).colorScheme.brightness == Brightness.dark;
              return IconButton(
                onPressed: () async {
                  // 如果APP主题正处于跟随系统设置的情况下
                  if (GlobalStore.globalProvider.themeMode == ThemeMode.system) {
                    bool isCancel = true; // 用户是否取消了变更主题的请求
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("提示"),
                          content: const Text("切换模式将会关闭自动跟随系统，可以在主题设置里再次开启"),
                          actions: <Widget>[
                            TextButton(child: const Text("取消"), onPressed: () => Navigator.pop(context)),
                            TextButton(
                              child: const Text("切换"),
                              onPressed: () {
                                isCancel = false;
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                    if (isCancel) return; // 取消则不变更主题模式
                  }
                  // 切换主题模式
                  GlobalStore.globalProvider.setThemeMode(isDarkMode ? ThemeMode.light : ThemeMode.dark, true);
                },
                icon: Icon(isDarkMode ? Icons.mode_night : Icons.light_mode),
                tooltip: "切换${isDarkMode ? '亮色' : '暗黑'}模式",
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
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
              Container(
                color: Theme.of(context).colorScheme.surface,
                margin: const EdgeInsets.symmetric(vertical: 6.0),
                child: GridView.builder(
                  controller: ScrollController(keepScrollOffset: false),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemCount: _cards.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Material(
                      color: Theme.of(context).colorScheme.surface,
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
                              child: Icon(_cards[index].assetsImageUrl,
                                  size: 22, color: Theme.of(context).colorScheme.primary),
                            ),
                            Text(_cards[index].text,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context).colorScheme.primary,
                                )),
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
                  PreferencesNavigatorItem(
                      icon: Icon(Icons.color_lens, color: Theme.of(context).colorScheme.primary),
                      text: "主题模式",
                      routeName: RouteNames.themeSettings.name),
                  PreferencesNavigatorItem(
                      icon: Icon(Icons.download_done, color: Theme.of(context).colorScheme.primary),
                      text: "保存方式",
                      routeName: RouteNames.downloadSettings.name),
                  PreferencesNavigatorItem(
                      icon: Icon(Icons.web_asset_rounded, color: Theme.of(context).colorScheme.primary),
                      text: "网络代理",
                      routeName: RouteNames.networkSettings.name),
                  PreferencesNavigatorItem(
                      icon: Icon(Icons.language, color: Theme.of(context).colorScheme.primary),
                      text: "App语言",
                      routeName: RouteNames.languageSettings.name),
                ];
                return Container(
                  color: Theme.of(context).colorScheme.surface,
                  child: Column(
                    children: preferencesItems,
                  ),
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
        Navigator.of(context).pushNamed(RouteNames.userDetail.name, arguments: user);
      },
      child: Container(
        color: Theme.of(context).colorScheme.surface,
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
                    child: SizedBox(
                      width: 64,
                      height: 64,
                      child: Selector(
                        selector: (BuildContext context, GlobalProvider provider) {
                          return provider.currentAccount;
                        },
                        builder: (BuildContext context, AccountProfile? profile, Widget? child) {
                          // 未登录或者原本就无头像用户
                          if (profile == null || profile.user.profileImageUrls == null) {
                            return const Image(image: AssetImage("assets/images/default_avatar.png"));
                          }
                          return CachedNetworkImage(
                            imageUrl: profile.user.profileImageUrls!.px170x170,
                            httpHeaders: const {"Referer": CONSTANTS.referer},
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
                            style: const TextStyle(
                              fontSize: 20,
                              height: 1.4,
                            ),
                          ),
                          Text(
                            profile == null ? "..." : profile.user.mailAddress,
                            style: const TextStyle(
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
            const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
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
    var profile = AccountStore.getCurrentAccountProfile();
    if (profile != null) {
      GlobalStore.changeCurrentAccount(profile);
    } else {
      Fluttertoast.showToast(msg: "加载失败!", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
    }
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
