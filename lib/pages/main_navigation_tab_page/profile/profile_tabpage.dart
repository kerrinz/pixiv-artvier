import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/api_app/api_user.dart';
import 'package:pixgem/common_provider/global_provider.dart';
import 'package:pixgem/component/base_provider_widget.dart';
import 'package:pixgem/component/bottom_sheet/bottom_sheets.dart';
import 'package:pixgem/component/perference/preferences_navigator_item.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/l10n/localization_intl.dart';
import 'package:pixgem/model_response/user/preload_user_least_info.dart';
import 'package:pixgem/model_store/account_profile.dart';
import 'package:pixgem/pages/main_navigation_tab_page/profile/models.dart';
import 'package:pixgem/pages/main_navigation_tab_page/profile/provider.dart';
import 'package:pixgem/pages/main_navigation_tab_page/profile/quick_settings/proxy_and_origin.dart';
import 'package:pixgem/pages/main_navigation_tab_page/profile/quick_settings/theme.dart';
import 'package:pixgem/routes.dart';
import 'package:pixgem/store/account_store.dart';
import 'package:pixgem/store/global.dart';
import 'package:provider/provider.dart';

class ProfileTabPage extends StatelessWidget {
  const ProfileTabPage({Key? key}) : super(key: key);

  // 功能项列表的模型
  static final List<IconButtonModelBuilder> _functionItemBuilders = [
    (context) => IconButtonModel(
          LocalizationIntl.of(context).history,
          Icon(Icons.history_rounded, color: Theme.of(context).primaryColor, size: 26),
          RouteNames.history.name,
          null,
        ),
    (context) => IconButtonModel(
          LocalizationIntl.of(context).downloads,
          Icon(Icons.file_download_outlined, color: Theme.of(context).primaryColor, size: 26),
          RouteNames.downloadManage.name,
          null,
        ),
    (context) => IconButtonModel(
          LocalizationIntl.of(context).works,
          Icon(Icons.inventory_2_outlined, color: Theme.of(context).primaryColor, size: 26),
          "",
          null,
        ),
    (context) => IconButtonModel(
          LocalizationIntl.of(context).collections,
          Icon(Icons.favorite_outline_rounded, color: Theme.of(context).primaryColor, size: 26),
          RouteNames.myBookmarks.name,
          GlobalStore.currentAccount?.user.id,
        ),
    (context) => IconButtonModel(
          LocalizationIntl.of(context).markers,
          Icon(Icons.bookmark_border_rounded, color: Theme.of(context).primaryColor, size: 26),
          "",
          GlobalStore.currentAccount?.user.id,
        ),
  ];

  // 设置项列表的模型
  static final List<PerferenceBottomSheetBuilder> _perferenceItemBuilders = [
    (context) => PerferenceBottomSheetModel(
          LocalizationIntl.of(context).themeSettings,
          Icon(Icons.color_lens_outlined, color: Theme.of(context).primaryColor),
          const ThemeSettingsBottomSheetContent(),
          null,
        ),
    (context) => PerferenceBottomSheetModel(
          LocalizationIntl.of(context).proxyAndOrigin,
          Icon(Icons.lan_outlined, color: Theme.of(context).primaryColor),
          const ProxyOriginSettingsBottomSheet(),
          GlobalStore.currentAccount?.user.id,
        ),
  ];

  @override
  Widget build(BuildContext context) {
    readProfile();
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
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
        physics: const NeverScrollableScrollPhysics(parent: BouncingScrollPhysics()),
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
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor,
                      Theme.of(context).backgroundColor,
                      Theme.of(context).backgroundColor,
                    ],
                    stops: const [0, 0.6, 0.6, 1],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: _buildFunctionCardContianer(context),
              ),
              _buildPreferenceSettings(context),
            ],
          ),
        ),
      ),
    );
  }

  // 用户信息
  Widget _buildUserInfoContainer(BuildContext context) {
    Color secondTextColor = Theme.of(context).colorScheme.primaryContainer;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            var user = PreloadUserLeastInfo(int.parse(GlobalStore.currentAccount!.user.id),
                GlobalStore.currentAccount!.user.name, GlobalStore.currentAccount!.user.profileImageUrls!.px170x170);
            Navigator.of(context).pushNamed(RouteNames.userDetail.name, arguments: user);
          },
          child: Container(
            color: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Row(
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
                Text(LocalizationIntl.of(context).space, style: TextStyle(color: secondTextColor)),
                Icon(Icons.keyboard_arrow_right, size: 16, color: Theme.of(context).colorScheme.primaryContainer),
              ],
            ),
          ),
        ),
        Container(
          color: Theme.of(context).colorScheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: ProviderWidget<ProfileProvider>(
            builder: (BuildContext context, ProfileProvider provider, Widget? child) {
              TextStyle numTextStyle = TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onPrimary);
              TextStyle secondTextStyle =
                  TextStyle(fontSize: 12, height: 1.6, color: Theme.of(context).colorScheme.primaryContainer);
              return Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Column(
                        children: [
                          Text(provider.friends.toString(),
                              style: numTextStyle.copyWith(fontWeight: FontWeight.normal)),
                          Text(LocalizationIntl.of(context).friends, style: secondTextStyle),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, RouteNames.userFollowing.name,
                          arguments: GlobalStore.currentAccount?.user.id),
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Column(
                          children: [
                            Text(provider.following.toString(), style: numTextStyle),
                            Text(LocalizationIntl.of(context).following, style: secondTextStyle),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Column(
                        children: [
                          Text("All >", style: numTextStyle),
                          Text(LocalizationIntl.of(context).followers, style: secondTextStyle),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
            model: ProfileProvider(),
          ),
        ),
      ],
    );
  }

  // 功能卡片
  Widget _buildFunctionCardContianer(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.surface,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
      child: GridView.builder(
        controller: ScrollController(keepScrollOffset: false),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
        ),
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          IconButtonModelBuilder builder = _functionItemBuilders[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, builder(context).routeName, arguments: builder(context).argument);
            },
            child: Container(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  builder(context).icon,
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      builder(context).text,
                      style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // 快捷设置
  Widget _buildPreferenceSettings(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, top: 16, bottom: 10),
                  child: Text(
                    LocalizationIntl.of(context).quickSettingsTitle,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
          for (PerferenceBottomSheetBuilder builder in _perferenceItemBuilders)
            PreferencesNavigatorItem(
              icon: builder(context).icon,
              text: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  builder(context).text,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              onTap: () {
                BottomSheets.showCustomBottomSheet(
                  context: context,
                  child: builder(context).widget ?? Container(),
                );
                // builder(context).routeName,
              },
              padding: const EdgeInsets.only(left: 20, right: 12, top: 14, bottom: 14),
            ),
        ],
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
    ApiUser().getUserDetail(userId: profile?.user.id).then((value) => null);
  }
}
