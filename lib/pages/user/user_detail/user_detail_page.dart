import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/component/buttons/blur_button.dart';
import 'package:pixgem/component/buttons/follow_button.dart';
import 'package:pixgem/component/illusts_grid_tabpage.dart';
import 'package:pixgem/component/loading/request_loading.dart';
import 'package:pixgem/component/sliver_delegates/tab_bar_delegate.dart';
import 'package:pixgem/component/text/collapsible_text.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/l10n/localization_intl.dart';
import 'package:pixgem/model_response/illusts/common_illust_list.dart';
import 'package:pixgem/model_response/user/preload_user_least_info.dart';
import 'package:pixgem/model_response/user/user_detail.dart';
import 'package:pixgem/api_app/api_base.dart';
import 'package:pixgem/api_app/api_user.dart';
import 'package:pixgem/pages/user/user_detail/works_tabpage.dart';
import 'package:pixgem/routes.dart';
import 'package:provider/provider.dart';

import 'user_detail_provider.dart';

class UserDetailPage extends StatefulWidget {
  late final PreloadUserLeastInfo leastInfo;

  UserDetailPage(Object arguments, {Key? key}) : super(key: key) {
    leastInfo = arguments as PreloadUserLeastInfo;
  }

  @override
  State<StatefulWidget> createState() {
    return _UserDetailState();
  }
}

class _UserDetailState extends State<UserDetailPage> with TickerProviderStateMixin {
  final UserDetailProvider _provider = UserDetailProvider();

  late TabController _tabController;

  late ScrollController _scrollController;

  bool _hasMountedListener = false; // 是否已经挂载了监听事件

  static List<Tab> _tabs(BuildContext context) => [
        Tab(text: LocalizationIntl.of(context).works),
        Tab(text: LocalizationIntl.of(context).collections),
        Tab(text: LocalizationIntl.of(context).more),
      ];

  final _tabsLength = 3; // [_tabs]的Tab数量

  static double bannerHeight = 150; // 背景封面图的高度

  static double avatarDiameter = 80; // 头像的直径

  static const double kTabBarHeight = 46;

  late double _appBarHeight; // AppBar加上状态栏的高度

  late double _appBarColorOffset0; // AppBar背景色透明度在0时的偏移量 [_scrollController.offset]

  late double _appBarColorOffset1; // AppBar背景色透明度在1时的偏移量

  late double _appbarColorOffsetDelta; // AppBar背景色透明度从0-1的偏移量的增量

  late double _appBarTitleOffset0; // AppBar标题透明度在0时的偏移量

  late double _appBarTitleOffset1; // AppBar标题透明度在1时的偏移量 (固定为20增量)

  double _bannerOffset = 0; // 背景图的偏移量

  double _appBarColorOpacity = 0.0;

  double _appBarTitleOpacity = 0.0;

  double _dropTopOpacity = 0.0;

  late StateSetter _appBarSetState;

  late StateSetter _bannerSetState;

  late StateSetter _dropTopSetState;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: _tabsLength, vsync: this);
    refreshUserData().then((detail) {}).catchError((onError) {
      Fluttertoast.showToast(msg: "获取用户数据失败！$onError", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
      _provider.setLoadingStatus(LoadingStatus.failed);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasMountedListener) {
      _scrollController = PrimaryScrollController.of(context) ?? ScrollController();
      _scrollController.addListener(_handleScroll);
      _hasMountedListener = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    _calc(context);
    return Scaffold(
      body: ChangeNotifierProvider.value(
        value: _provider,
        child: Stack(
          children: [
            // 底部背景图
            StatefulBuilder(builder: (context, setState) {
              _bannerSetState = setState;
              return Transform.translate(
                offset: Offset(0, _bannerOffset),
                child: SizedBox(
                  width: double.infinity,
                  height: bannerHeight,
                  child: Selector(
                    selector: (context, UserDetailProvider provider) {
                      return provider.userDetail;
                    },
                    builder: (BuildContext context, UserDetail? userDetail, Widget? child) {
                      if (userDetail?.profile.backgroundImageUrl == null) {
                        return ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                          child: CachedNetworkImage(
                            width: double.infinity,
                            imageUrl: widget.leastInfo.avatar,
                            httpHeaders: const {"Referer": CONSTANTS.referer},
                            fit: BoxFit.cover,
                            color: const Color(0x33000000), // 等同于black.opacity(0.2)
                            colorBlendMode: BlendMode.multiply,
                          ),
                        );
                      }
                      return CachedNetworkImage(
                        width: double.infinity,
                        imageUrl: userDetail!.profile.backgroundImageUrl!,
                        httpHeaders: const {"Referer": CONSTANTS.referer},
                        fit: BoxFit.cover,
                        color: const Color(0x33000000),
                        colorBlendMode: BlendMode.multiply,
                      );
                    },
                  ),
                ),
              );
            }),
            // 内容
            ExtendedNestedScrollView(
              onlyOneScrollInBody: true,
              controller: _scrollController,
              pinnedHeaderSliverHeightBuilder: () {
                return _appBarHeight + kTabBarHeight;
              },
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: bannerHeight - 12),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(12.0),
                            topLeft: Radius.circular(12.0),
                          ),
                        ),
                        child: _buildUserInformation(context),
                      ),
                    ),
                  ),
                  // TabBar 分页栏
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: SliverTabBarPersistentHeaderDelegate(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
                      child: TabBar(
                        labelColor: Theme.of(context).primaryColor,
                        indicatorColor: Theme.of(context).primaryColor,
                        unselectedLabelColor: Theme.of(context).colorScheme.onSurface,
                        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        unselectedLabelStyle: const TextStyle(fontSize: 14),
                        labelPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                        indicatorSize: TabBarIndicatorSize.label,
                        controller: _tabController,
                        isScrollable: false,
                        tabs: _tabs(context),
                      ),
                      maxHeight: kTabBarHeight,
                      minHeight: kTabBarHeight,
                    ),
                  ),
                ];
              },
              // 分页页面
              body: Selector(selector: (context, UserDetailProvider provider) {
                return provider.loadingStatus;
              }, builder: (BuildContext context, LoadingStatus status, Widget? child) {
                switch (status) {
                  case LoadingStatus.loading:
                    return const RequestLoading();
                  case LoadingStatus.failed:
                    return Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          Center(
                            child: RequestLoadingFailed(
                              onRetry: () {
                                refreshUserData().catchError((_) {
                                  _provider.setLoadingStatus(LoadingStatus.failed);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  default:
                    break;
                }
                UserDetail detail = _provider.userDetail!;
                return Container(
                  color: Theme.of(context).colorScheme.background,
                  child: TabBarView(
                    physics: const ClampingScrollPhysics(),
                    controller: _tabController,
                    children: [
                      // 作品列表
                      WorksTabPage(userId: widget.leastInfo.id.toString()),
                      // 收藏列表
                      IllustGridTabPage(
                        onLazyLoad: (String nextUrl) async {
                          var result = await ApiBase().getNextUrlData(nextUrl: nextUrl);
                          return CommonIllustList.fromJson(result);
                        },
                        onRefresh: () async {
                          // 获取收藏列表
                          return await ApiUser()
                              .getUserBookmarksIllust(userId: widget.leastInfo.id)
                              .catchError((onError) {
                            Fluttertoast.showToast(
                                msg: "获取用户数据失败！$onError", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
                          });
                        },
                      ),
                      // tab——其他信息
                      Builder(
                        builder: (BuildContext context) {
                          LocalizationIntl intl = LocalizationIntl.of(context);
                          String age = "";
                          if (detail.profile.birthYear != 0 && detail.profile.birth != "") {
                            DateTime? birth = DateTime.tryParse(detail.profile.birth);
                            DateTime now = DateTime.now();
                            if (birth != null) {
                              int rectify =
                                  (now.month < birth.month || (now.month == birth.month && now.day < birth.day))
                                      ? -1
                                      : 0;
                              age = (now.year - birth.year + rectify).toString();
                            }
                          }
                          return SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Column(
                                children: [
                                  _buildMoreInfomationCard(
                                    context: context,
                                    title: '基本资料',
                                    leftRows: [
                                      intl.nickname,
                                      intl.age,
                                      intl.birthday,
                                      intl.location,
                                      intl.occupation,
                                      intl.pixivPremium,
                                    ],
                                    rightRows: [
                                      detail.user.name,
                                      age,
                                      detail.profile.birthDay,
                                      detail.profile.region,
                                      detail.profile.job,
                                      detail.profile.isPremium ? intl.yes : intl.not,
                                    ],
                                  ),
                                  _buildMoreInfomationCard(
                                    context: context,
                                    title: intl.socialMedia,
                                    leftRows: [
                                      intl.website,
                                      "twitter",
                                      "twitter_url",
                                      "pawoo_url",
                                    ],
                                    rightRows: [
                                      detail.profile.webpage ?? "",
                                      detail.profile.twitterAccount,
                                      detail.profile.twitterUrl ?? "",
                                      detail.profile.pawooUrl ?? "",
                                    ],
                                  ),
                                  _buildMoreInfomationCard(
                                    context: context,
                                    title: intl.workspace,
                                    leftRows: [
                                      intl.computer,
                                      intl.monitor,
                                      intl.softwareUsed,
                                      intl.scanner,
                                      intl.tablet,
                                      intl.mouse,
                                      intl.printer,
                                      intl.onYourDesk,
                                      intl.backgroundMusic,
                                      intl.table,
                                      intl.chair,
                                      intl.other,
                                    ],
                                    rightRows: [
                                      detail.workspace.pc,
                                      detail.workspace.monitor,
                                      detail.workspace.tool,
                                      detail.workspace.scanner,
                                      detail.workspace.tablet,
                                      detail.workspace.mouse,
                                      detail.workspace.printer,
                                      detail.workspace.desktop,
                                      detail.workspace.music,
                                      detail.workspace.desk,
                                      detail.workspace.chair,
                                      detail.workspace.comment,
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }),
            ),
            // 固定位置的AppBar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  _appBarSetState = setState;
                  return _buildAppBar(context);
                },
              ),
            ),
            // 底部的回到顶部按钮
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                top: false,
                bottom: true,
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    _dropTopSetState = setState;
                    return GestureDetector(
                      onTap: () => _scrollController.animateTo(
                        0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.decelerate,
                      ),
                      child: Opacity(
                        opacity: _dropTopOpacity,
                        child: Icon(Icons.keyboard_arrow_up, color: Theme.of(context).colorScheme.onBackground),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // AppBar
  Widget _buildAppBar(BuildContext context) {
    double reverseOpacity = 1 - _appBarColorOpacity;
    Color buttonBackground = const Color(0x55000000).withAlpha((85 * reverseOpacity).toInt());
    int c = (255 * reverseOpacity).toInt();
    Color buttonForeground = Color.fromARGB(255, c, c, c);
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(_appBarColorOpacity),
      leading: BlurButton(
        onPressed: () {
          Navigator.of(context).pop(-1);
        },
        borderRadius: const BorderRadius.all(Radius.circular(18.0)),
        padding: const EdgeInsets.all(6.0),
        background: buttonBackground,
        child: Icon(Icons.arrow_back_ios_rounded, size: 20, color: buttonForeground),
      ),
      titleSpacing: 0,
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      title: Opacity(
        opacity: _appBarTitleOpacity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 头像
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.5), width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(80)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.none,
                  image: CachedNetworkImageProvider(
                    widget.leastInfo.avatar,
                    headers: const {"Referer": CONSTANTS.referer},
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  widget.leastInfo.name,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        BlurButton(
          onPressed: () {},
          borderRadius: BorderRadius.circular(20.0),
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          background: buttonBackground,
          child: Icon(Icons.more_horiz_rounded, color: buttonForeground),
        ),
      ],
    );
  }

  // 用户资料卡
  Widget _buildUserInformation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // 头像
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Container(
                  width: avatarDiameter,
                  height: avatarDiameter,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(80)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        widget.leastInfo.avatar,
                        headers: {"Referer": CONSTANTS.referer},
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 关注、好P友等的统计信息
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Text(LocalizationIntl.of(context).gender,
                                    style: Theme.of(context).textTheme.labelSmall),
                                Consumer(builder: (context, UserDetailProvider provider, child) {
                                  switch (provider.userDetail?.profile.gender ?? "") {
                                    case "male":
                                      return const Icon(
                                        Icons.male,
                                        color: Colors.blue,
                                        size: 22,
                                      );
                                    case "female":
                                      return Icon(
                                        Icons.female,
                                        color: Colors.pink.shade300.withOpacity(0.75),
                                        size: 22,
                                      );
                                    case "unknown":
                                      return Icon(
                                        Icons.transgender_outlined,
                                        color: Colors.blueGrey.withOpacity(0.75),
                                        size: 22,
                                      );
                                    default:
                                      return Text(
                                        provider.userDetail != null ? "-" : "...",
                                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      );
                                  }
                                }),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () => Navigator.of(context)
                                  .pushNamed(RouteNames.userFollowing.name, arguments: widget.leastInfo.id.toString()),
                              child: Column(
                                children: [
                                  Text(LocalizationIntl.of(context).following,
                                      style: Theme.of(context).textTheme.labelSmall),
                                  Consumer(builder: (context, UserDetailProvider provider, child) {
                                    const TextStyle numberTextStyle =
                                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
                                    return Text(provider.userDetail?.profile.totalFollowUsers.toString() ?? "...",
                                        style: numberTextStyle);
                                  }),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Text(LocalizationIntl.of(context).friends,
                                    style: Theme.of(context).textTheme.labelSmall),
                                Consumer(builder: (context, UserDetailProvider provider, child) {
                                  const TextStyle numberTextStyle =
                                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
                                  return Text(provider.userDetail?.profile.totalMypixivUsers.toString() ?? "...",
                                      style: numberTextStyle);
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Selector(
                                  builder: (BuildContext context, bool? isFollowed, Widget? child) {
                                    if (isFollowed == null) {
                                      return Container(
                                        alignment: Alignment.center,
                                        color: Theme.of(context).colorScheme.surfaceVariant,
                                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                                        child: Text("...", style: TextStyle(color: Theme.of(context).primaryColor)),
                                      );
                                    }
                                    return FollowButton(
                                      isFollowed: isFollowed,
                                      userId: widget.leastInfo.id.toString(),
                                    );
                                  },
                                  selector: (context, UserDetailProvider provider) {
                                    return provider.isFollowedAuthor;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // 用户名
          Builder(builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(left: 2.0, right: 2.0, top: 8.0, bottom: 2.0),
              child: SelectableText(
                widget.leastInfo.name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            );
          }),
          // UID
          GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: widget.leastInfo.id.toString())).then(
                (value) => Fluttertoast.showToast(
                  msg: LocalizationIntl.of(context).copiedToClipboard,
                  toastLength: Toast.LENGTH_SHORT,
                  fontSize: 16.0,
                ),
              );
            },
            child: Row(
              children: [
                Text(
                  "UID: ${widget.leastInfo.id.toString()}",
                  style: const TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
                  child: Icon(Icons.copy, size: 12),
                ),
              ],
            ),
          ),
          // 个人介绍
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
            child: Selector(
              builder: (BuildContext context, String? comment, Widget? child) {
                const textStyle = TextStyle(fontSize: 14);
                if (comment == null) {
                  return const Text(
                    "...",
                    style: textStyle,
                    overflow: TextOverflow.ellipsis,
                  );
                }
                return CollapsibleText(
                  text: comment,
                  style: textStyle,
                  collapsedMaxLine: 3,
                  isCollapsedInitially: true,
                  isSelectable: true,
                  buttonAxisAlignment: MainAxisAlignment.end,
                );
              },
              selector: (context, UserDetailProvider provider) {
                return provider.userDetail?.user.comment;
              },
            ),
          ),
        ],
      ),
    );
  }

  // 更多资料卡
  Widget _buildMoreInfomationCard({
    required BuildContext context,
    required String title,
    required List<String> leftRows,
    required List<String> rightRows,
  }) {
    Color color = Theme.of(context).colorScheme.onSurface;
    TextStyle titleTextStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color);
    TextStyle leftTextStyle = TextStyle(fontSize: 14, color: color.withAlpha(200));
    TextStyle rightTextStyle = TextStyle(fontSize: 14, color: color);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(title, style: titleTextStyle),
        ),
        for (int i = 0; i < leftRows.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(flex: 1, child: Text(leftRows[i], style: leftTextStyle)),
                Expanded(flex: 2, child: Text(rightRows[i], style: rightTextStyle)),
              ],
            ),
          ),
      ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _provider.dispose();
  }

  /// 计算各类参数
  void _calc(BuildContext context) {
    bannerHeight = MediaQuery.of(context).size.width * 0.48;
    if (bannerHeight > 200) bannerHeight = 200;
    _appBarHeight = kToolbarHeight + MediaQuery.of(context).padding.top;
    _appBarColorOffset0 = bannerHeight - _appBarHeight - 12;
    _appBarColorOffset1 = _appBarColorOffset0 + _appBarHeight / 2;
    _appbarColorOffsetDelta = _appBarColorOffset1 - _appBarColorOffset0;
    _appBarTitleOffset0 = _appBarColorOffset0 + avatarDiameter;
    _appBarTitleOffset1 = _appBarTitleOffset0 + 20;
  }

  // 滚动触发事件
  void _handleScroll() {
    if (_scrollController.offset > _appBarTitleOffset1) {
      if (_appBarColorOpacity != 1 || _appBarTitleOpacity != 1 || _dropTopOpacity != 1) {
        _dropTopSetState(() => _dropTopOpacity = 1);
        _appBarSetState(() {
          _appBarColorOpacity = 1;
          _appBarTitleOpacity = 1;
        });
      }
    } else if (_scrollController.offset > _appBarColorOffset0 && _scrollController.offset < _appBarTitleOffset1) {
      // 直接大范围同时处理多个
      double oc = (_scrollController.offset - _appBarColorOffset0) / _appbarColorOffsetDelta;
      double ot = (_scrollController.offset - _appBarTitleOffset0) / _appbarColorOffsetDelta;
      oc >= 0 && oc <= 1
          ? _appBarSetState(() => _appBarColorOpacity = oc)
          : _appBarSetState(() => _appBarColorOpacity = _scrollController.offset > _appBarColorOffset0 ? 1 : 0);
      ot >= 0 && ot <= 1
          ? _appBarSetState(() => _appBarTitleOpacity = ot)
          : _appBarSetState(() => _appBarTitleOpacity = _scrollController.offset > _appBarTitleOffset1 ? 1 : 0);
    } else {
      if (_appBarColorOpacity != 0 || _appBarTitleOpacity != 0 || _dropTopOpacity != 0) {
        _dropTopSetState(() => _dropTopOpacity = 0);
        _appBarSetState(() {
          _appBarColorOpacity = 0;
          _appBarTitleOpacity = 0;
        });
      }
    }
    // TODO: 滚动计算的性能调优中
    // // AppBar透明度变化
    // if (_scrollController.offset < _appBarColorOffset0 && _appBarColorOpacity != 0 ||
    //     _scrollController.offset > _appBarColorOffset0 && _appBarColorOpacity != 1) {
    //   double o = (_scrollController.offset - _appBarColorOffset0) / 20;
    //   o >= 0 && o <= 1
    //       ? _appBarSetState(() => _appBarColorOpacity = o)
    //       : _appBarSetState(() => _appBarColorOpacity = _scrollController.offset > _appBarColorOffset0 ? 1 : 0);
    // }
    // // AppBar Title透明度变化
    // if (_scrollController.offset < _appBarTitleOffset1 && _appBarTitleOpacity != 0 ||
    //     _scrollController.offset > _appBarTitleOffset0 && _appBarTitleOpacity != 1) {
    //   double o = (_scrollController.offset - _appBarTitleOffset0) / 20;
    //   o >= 0 && o <= 1
    //       ? _appBarSetState(() => _appBarTitleOpacity = o)
    //       : _appBarSetState(() => _appBarTitleOpacity = _scrollController.offset > _appBarTitleOffset1 ? 1 : 0);
    // }
    // // banner
    if (_appBarColorOpacity < 1) {
      _bannerOffset = -_scrollController.offset;
      _bannerSetState(() {});
    }
    // // DropTop
    // if (_scrollController.offset > _appBarTitleOffset1) {
    //   if (_dropTopOpacity != 1) _dropTopSetState(() => _dropTopOpacity = 1);
    // } else {
    //   if (_dropTopOpacity != 0) _dropTopSetState(() => _dropTopOpacity = 0);
    // }
  }

  // 获取or刷新用户信息
  Future<UserDetail> refreshUserData() async {
    if (_provider.loadingStatus == LoadingStatus.failed) _provider.setLoadingStatus(LoadingStatus.loading);
    UserDetail detail = await ApiUser().getUserDetail(userId: widget.leastInfo.id);
    _provider.setUserDetail(detail);
    _provider.setFollowed(detail.user.isFollowed);
    _provider.setLoadingStatus(LoadingStatus.success);
    return detail;
  }
}
