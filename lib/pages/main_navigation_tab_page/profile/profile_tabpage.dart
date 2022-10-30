import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pixgem/api_app/api_user.dart';
import 'package:pixgem/common_provider/global_provider.dart';
import 'package:pixgem/component/base_provider_widget.dart';
import 'package:pixgem/component/bottom_sheet/bottom_sheets.dart';
import 'package:pixgem/component/perference/preferences_navigator_item.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/l10n/localization_intl.dart';
import 'package:pixgem/model_response/user/preload_user_least_info.dart';
import 'package:pixgem/model_response/user/user_detail.dart';
import 'package:pixgem/model_store/account_profile.dart';
import 'package:pixgem/pages/main_navigation_tab_page/profile/models.dart';
import 'package:pixgem/pages/main_navigation_tab_page/profile/user_profile_provider.dart';
import 'package:pixgem/pages/main_navigation_tab_page/profile/quick_settings/proxy_and_origin.dart';
import 'package:pixgem/pages/main_navigation_tab_page/profile/quick_settings/theme.dart';
import 'package:pixgem/routes.dart';
import 'package:pixgem/store/account_store.dart';
import 'package:pixgem/store/global.dart';
import 'package:provider/provider.dart';

class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProfileTabPageState();
}

class ProfileTabPageState extends State<ProfileTabPage> {
  // 功能项列表的模型
  final List<IconButtonModelBuilder> _functionItemBuilders = [
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
          RouteNames.myWorks.name,
          GlobalStore.currentAccount?.user.id,
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
  final List<PerferenceBottomSheetBuilder> _perferenceItemBuilders = [
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

  bool _isLightMode(context) => Theme.of(context).colorScheme.brightness == Brightness.light;

  final UserProfileProvider _profileProvider = UserProfileProvider();

  @override
  void initState() {
    requestCounts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    readProfile();
    // 顶部区域背景色
    Color topBackgroundColor = _isLightMode(context)
        ? HSLColor.fromColor(Theme.of(context).colorScheme.primary).withLightness(0.66).toColor()
        : HSVColor.fromColor(Theme.of(context).colorScheme.primary).withValue(0.25).toColor();
    return Stack(
      children: [
        Container(
          color: Theme.of(context).colorScheme.background,
          child: Column(
            children: [
              // 我的信息栏
              Container(
                color: topBackgroundColor,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top +
                        (Theme.of(context).appBarTheme.toolbarHeight ?? kToolbarHeight)),
                child: _buildUserInfoContainer(context),
              ),
              // 功能卡片
              Container(
                transform: Matrix4.translationValues(0, -4, 0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      topBackgroundColor,
                      topBackgroundColor,
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
        // Toolbar（Appbar）
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: Colors.transparent,
            actionsIconTheme: const IconThemeData(size: 20, color: Colors.white),
            actions: [
              Center(
                child: IconButton(
                  padding: const EdgeInsets.all(8.0),
                  onPressed: () {
                    Navigator.of(context).pushNamed(RouteNames.accountManage.name);
                  },
                  color: Colors.white,
                  icon: const Icon(Icons.switch_account_outlined),
                  tooltip: "切换账号",
                ),
              ),
              Center(
                child: Builder(
                  builder: (BuildContext context) {
                    // 当前所处的主题模式
                    bool isDarkMode = Theme.of(context).colorScheme.brightness == Brightness.dark;
                    return IconButton(
                      padding: const EdgeInsets.all(8.0),
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
                      color: Colors.white,
                      icon: Icon(isDarkMode ? Icons.mode_night : Icons.light_mode),
                      tooltip: "切换主题模式",
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 用户信息
  Widget _buildUserInfoContainer(BuildContext context) {
    Color textColor =
        _isLightMode(context) ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurface;
    Color secondTextColor = _isLightMode(context)
        ? Theme.of(context).colorScheme.onPrimary.withAlpha(200)
        : Theme.of(context).colorScheme.onSurface.withAlpha(150);
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            var user = PreloadUserLeastInfo(int.parse(GlobalStore.currentAccount!.user.id),
                GlobalStore.currentAccount!.user.name, GlobalStore.currentAccount!.user.profileImageUrls!.px170x170);
            Navigator.of(context).pushNamed(RouteNames.userDetail.name, arguments: user);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
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
                                  color: textColor,
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
                Icon(Icons.keyboard_arrow_right, size: 16, color: secondTextColor),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 4, bottom: 8),
          child: ProviderWidget<UserProfileProvider>(
            model: _profileProvider,
            builder: (BuildContext context, UserProfileProvider provider, Widget? child) {
              TextStyle numTextStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: textColor);
              TextStyle secondTextStyle = TextStyle(fontSize: 12, height: 1.6, color: secondTextColor);
              return Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Column(
                        children: [
                          Text(provider.friends?.toString() ?? "...",
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
                            Text(provider.following?.toString() ?? "...", style: numTextStyle),
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
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
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

  /// 读取账户配置
  void readProfile() {
    var profile = AccountStore.getCurrentAccountProfile();
    if (profile != null) {
      GlobalStore.changeCurrentAccount(profile);
    }
  }

  /// 获取相关用户统计
  Future requestCounts() async {
    if (GlobalStore.currentAccount == null) return;
    UserDetail detail = await ApiUser().getUserDetail(userId: GlobalStore.currentAccount!.user.id.toString());
    _profileProvider.setAll(0, detail.profile.totalFollowUsers, detail.profile.totalMypixivUsers);
  }
}
