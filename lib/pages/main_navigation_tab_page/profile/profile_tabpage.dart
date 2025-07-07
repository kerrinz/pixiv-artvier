import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/badge.dart';
import 'package:artvier/component/perference/perference_group.dart';
import 'package:artvier/component/perference/perference_item.dart';
import 'package:artvier/global/provider/current_account_provider.dart';
import 'package:artvier/global/provider/version_and_update_provider.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/component/bottom_sheet/bottom_sheets.dart';
import 'package:artvier/component/image/enhance_network_image.dart';
import 'package:artvier/component/perference/preferences_navigator_item.dart';
import 'package:artvier/global/provider/current_user_detail.dart';
import 'package:artvier/l10n/localization_intl.dart';
import 'package:artvier/pages/main_navigation_tab_page/profile/logic.dart';
import 'package:artvier/pages/main_navigation_tab_page/profile/models.dart';
import 'package:artvier/pages/main_navigation_tab_page/profile/quick_settings/proxy/proxy_bottom_sheet.dart';
import 'package:artvier/pages/main_navigation_tab_page/profile/quick_settings/theme/theme_bottom_sheet.dart';
import 'package:artvier/routes.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileTabPage extends ConsumerStatefulWidget {
  const ProfileTabPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ProfileTabPageState();
}

class ProfileTabPageState extends BasePageState<ProfileTabPage>
    with AutomaticKeepAliveClientMixin, ProfileTabPageLogic {
  /// TODO: 早期烂代码，待整理
  /// 功能项列表的模型
  List<IconButtonModelBuilder> get _functionItemBuilders => [
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
              Icon(Icons.inventory_2_outlined, color: Theme.of(context).primaryColor.withOpacity(0.5), size: 26),
              "",
              ref.watch(globalCurrentAccountProvider)?.user.id,
            ),
        (context) => IconButtonModel(
              LocalizationIntl.of(context).collections,
              Icon(Icons.favorite_outline_rounded, color: Theme.of(context).primaryColor, size: 26),
              RouteNames.myBookmarks.name,
              ref.watch(globalCurrentAccountProvider)?.user.id,
            ),
        (context) => IconButtonModel(
              LocalizationIntl.of(context).markers,
              Icon(Icons.bookmark_border_rounded, color: Theme.of(context).primaryColor, size: 26),
              RouteNames.userMarked.name,
              ref.watch(globalCurrentAccountProvider)?.user.id,
            ),
      ];

  /// 设置项列表的模型
  List<PerferenceBottomSheetBuilder> get _perferenceItemBuilders => [
        (context) => PerferenceBottomSheetModel(
              LocalizationIntl.of(context).themeSettings,
              Icon(Icons.color_lens_outlined, color: Theme.of(context).primaryColor),
              const ThemeSettingsBottomSheet(),
              null,
            ),
        (context) => PerferenceBottomSheetModel(
              LocalizationIntl.of(context).networkSettings,
              Icon(Icons.lan_outlined, color: Theme.of(context).primaryColor),
              const ProxyOriginSettingsBottomSheet(),
              ref.watch(globalCurrentAccountProvider)?.user.id,
            ),
      ];

  bool get _isLightMode => Theme.of(context).colorScheme.brightness == Brightness.light;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // 顶部区域背景色
    Color topBackgroundColor = _isLightMode
        ? HSLColor.fromColor(Theme.of(context).colorScheme.primary).withLightness(0.60).toColor()
        : HSVColor.fromColor(Theme.of(context).colorScheme.primary).withValue(0.25).toColor();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Stack(
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
                        Theme.of(context).colorScheme.background,
                        Theme.of(context).colorScheme.background,
                      ],
                      stops: const [0, 0.6, 0.6, 1],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: _buildFunctionCardContianer(context),
                ),
                _buildPreferenceSettings(context),
                _otherSettings(context),
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
                    tooltip: l10n.switchAccount,
                  ),
                ),
                Center(
                  child: Builder(
                    builder: (BuildContext context) {
                      // 当前所处的主题模式
                      bool isDarkMode = Theme.of(context).colorScheme.brightness == Brightness.dark;
                      return IconButton(
                        padding: const EdgeInsets.all(8.0),
                        onPressed: () => handleTapThemeMode(isDarkMode),
                        color: Colors.white,
                        icon: Icon(isDarkMode ? Icons.mode_night : Icons.light_mode),
                        tooltip: isDarkMode ? l10n.lightBrightness : l10n.dartBrightness,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 用户信息
  Widget _buildUserInfoContainer(BuildContext context) {
    Color textColor = _isLightMode ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurface;
    Color secondTextColor = _isLightMode
        ? Theme.of(context).colorScheme.onPrimary.withAlpha(200)
        : Theme.of(context).colorScheme.onSurface.withAlpha(150);
    return Column(
      children: [
        GestureDetector(
          onTap: handleTapUser,
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
                          child: Consumer(
                            builder: (_, ref, __) {
                              // 先从登录帐号的鉴权信息里获取
                              var account = ref.watch(globalCurrentAccountProvider);
                              // 最终值以网络请求的详细信息为准
                              var detail = ref.watch(globalCurrentUserDetailProvider);

                              String? avatar =
                                  detail?.user.profileImageUrls.medium ?? account?.user.profileImageUrls?.px170x170;
                              return avatar == null
                                  // 未登录或者原本就无头像用户
                                  ? const Image(image: AssetImage("assets/image/default_avatar.png"))
                                  // 正常头像
                                  : EnhanceNetworkImage(
                                      image: ExtendedNetworkImageProvider(
                                      HttpHostOverrides().pxImgUrl(avatar),
                                      headers: HttpHostOverrides().pximgHeaders,
                                    ));
                            },
                          ),
                        ),
                      ),
                      // 昵称、帐号
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Consumer(builder: (_, ref, __) {
                          // 先从登录帐号的鉴权信息里获取
                          var account = ref.watch(globalCurrentAccountProvider);
                          // 最终值以网络请求的详细信息为准
                          var detail = ref.watch(globalCurrentUserDetailProvider);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (detail?.user.name) ?? (account?.user.name) ?? "...",
                                style: TextStyle(
                                  fontSize: 20,
                                  height: 1.4,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                (account?.user.mailAddress) ?? "...",
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
        // 关注、好P友的统计
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 4, bottom: 8),
          child: Consumer(builder: ((context, ref, child) {
            TextStyle numTextStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: textColor);
            TextStyle secondTextStyle = TextStyle(fontSize: 12, height: 1.6, color: secondTextColor);
            var detail = ref.watch(globalCurrentUserDetailProvider);
            return Row(
              children: [
                // 好P友数
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(context, RouteNames.userFriends.name,
                        arguments: ref.read(globalCurrentAccountProvider)!.user.id),
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Column(
                        children: [
                          Text(detail?.profile.totalMypixivUsers.toString() ?? "...",
                              style: numTextStyle.copyWith(fontWeight: FontWeight.normal)),
                          Text(LocalizationIntl.of(context).friends, style: secondTextStyle),
                        ],
                      ),
                    ),
                  ),
                ),
                // 关注数
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(context, RouteNames.userFollowing.name,
                        arguments: ref.read(globalCurrentAccountProvider)!.user.id),
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Column(
                        children: [
                          Text(detail?.profile.totalFollowUsers.toString() ?? "...", style: numTextStyle),
                          Text(LocalizationIntl.of(context).following, style: secondTextStyle),
                        ],
                      ),
                    ),
                  ),
                ),
                // 粉丝（API不支持）
                // Expanded(
                //   flex: 1,
                //   child: Container(
                //     color: Colors.transparent,
                //     padding: const EdgeInsets.symmetric(vertical: 4.0),
                //     child: Column(
                //       children: [
                //         Text("All >", style: numTextStyle),
                //         Text(LocalizationIntl.of(context).followers, style: secondTextStyle),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            );
          })),
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
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _functionItemBuilders.length,
        ),
        itemCount: _functionItemBuilders.length,
        itemBuilder: (BuildContext context, int index) {
          IconButtonModelBuilder builder = _functionItemBuilders[index];
          return GestureDetector(
            onTap: () {
              if (builder(context).routeName == "") {
                Fluttertoast.showToast(msg: "暂未支持，等待后续更新");
              } else {
                Navigator.pushNamed(context, builder(context).routeName, arguments: builder(context).argument);
              }
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
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
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

  Widget _otherSettings(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: PerferenceGroup(items: [
        PerferenceItem(
          onTap: () => Navigator.of(context).pushNamed(RouteNames.allSettings.name),
          icon: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Icon(Icons.settings, color: colorScheme.primary),
          ),
          text: Text(
            l10n.settings,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          value: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Consumer(builder: (context, ref, child) {
                final currentVersion =
                    ref.watch(packageInfoProvider).whenOrNull(data: (data) => data.version.split('-').first);
                final release = ref.watch(globalLastVersionProvider).whenOrNull(data: (data) => data);
                if (currentVersion != null && release != null && release.tagName != currentVersion) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: MyBadge(
                      color: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: Text("NEW", style: textTheme.labelSmall?.copyWith(color: Colors.white)),
                    ),
                  );
                }
                return const SizedBox();
              }),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5),
                size: 12,
              ),
            ],
          ),
        ),
      ]),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
