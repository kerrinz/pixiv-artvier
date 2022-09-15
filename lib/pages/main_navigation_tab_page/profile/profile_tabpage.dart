import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/common_provider/global_provider.dart';
import 'package:pixgem/component/perference/preferences_navigator_item.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/l10n/localization_intl.dart';
import 'package:pixgem/model_response/user/preload_user_least_info.dart';
import 'package:pixgem/model_store/account_profile.dart';
import 'package:pixgem/pages/main_navigation_tab_page/profile/models.dart';
import 'package:pixgem/routes.dart';
import 'package:pixgem/store/account_store.dart';
import 'package:pixgem/store/global.dart';
import 'package:provider/provider.dart';

class ProfileTabPage extends StatelessWidget {
  const ProfileTabPage({Key? key}) : super(key: key);

  static final List<IconButtonModelBuilder> _iconButtonBuilders = [
    (context) => IconButtonModel(
          LocalizationIntl.of(context).history,
          Icon(Icons.history_rounded, color: Theme.of(context).colorScheme.primary),
          RouteNames.mainNavigation.name,
          null,
        ),
    (context) => IconButtonModel(
          LocalizationIntl.of(context).downloads,
          Icon(Icons.download, color: Theme.of(context).colorScheme.primary),
          RouteNames.downloadManage.name,
          null,
        ),
    (context) => IconButtonModel(
          LocalizationIntl.of(context).artworks,
          Icon(Icons.card_giftcard_rounded, color: Theme.of(context).colorScheme.primary),
          "",
          null,
        ),
    (context) => IconButtonModel(
          LocalizationIntl.of(context).collections,
          Icon(Icons.favorite, color: Theme.of(context).colorScheme.primary),
          RouteNames.myBookmarks.name,
          null,
        ),
    (context) => IconButtonModel(
          LocalizationIntl.of(context).following,
          Icon(Icons.star, color: Theme.of(context).colorScheme.primary),
          RouteNames.userFollowing.name,
          null,
        ),
  ];

  @override
  Widget build(BuildContext context) {
    readProfile();
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
            tooltip: "切换账号",
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
                          title: Text(LocalizationIntl.of(context).promptTitle),
                          content: Text(LocalizationIntl.of(context).themeModePromptContent),
                          actions: <Widget>[
                            TextButton(
                                child: Text(LocalizationIntl.of(context).promptCancel),
                                onPressed: () => Navigator.pop(context)),
                            TextButton(
                              child: Text(LocalizationIntl.of(context).promptConform),
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
              // 我的信息栏
              Container(child: _buildUserInfoContainer(context)),
              // 功能卡片
              Container(
                color: Theme.of(context).colorScheme.surface,
                margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                child: GridView.builder(
                  controller: ScrollController(keepScrollOffset: false),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    IconButtonModelBuilder builder = _iconButtonBuilders[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, builder(context).routeName, arguments: builder(context).argument);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: builder(context).icon,
                          ),
                          Text(
                            builder(context).text,
                            style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.primary),
                          ),
                        ],
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

  // 我的信息栏
  Widget _buildUserInfoContainer(BuildContext context) {
    Color secondTextColor = Theme.of(context).colorScheme.primaryContainer;
    return GestureDetector(
      onTap: () {
        var user = PreloadUserLeastInfo(int.parse(GlobalStore.currentAccount!.user.id),
            GlobalStore.currentAccount!.user.name, GlobalStore.currentAccount!.user.profileImageUrls!.px170x170);
        Navigator.of(context).pushNamed(RouteNames.userDetail.name, arguments: user);
      },
      child: Container(
        color: Theme.of(context).colorScheme.primary,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 头像
                      ClipOval(
                        child: SizedBox(
                          width: 55,
                          height: 55,
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
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                              Text(
                                profile == null ? "..." : profile.user.mailAddress,
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 1.6,
                                  color: secondTextColor,
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                Text("空间", style: TextStyle(color: secondTextColor)),
                Icon(Icons.keyboard_arrow_right, size: 16, color: Theme.of(context).colorScheme.primaryContainer),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Text("0", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
                        Text(
                          LocalizationIntl.of(context).following,
                          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Text("0", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
                      Text(
                        LocalizationIntl.of(context).followers,
                        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Text("0", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
                      Text(
                        LocalizationIntl.of(context).friends,
                        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
