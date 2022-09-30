import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/component/buttons/blur_button.dart';
import 'package:pixgem/component/follow_button.dart';
import 'package:pixgem/component/illusts_grid_tabpage.dart';
import 'package:pixgem/component/sliver_delegates/tab_bar_delegate.dart';
import 'package:pixgem/component/sliver_delegates/widget_delegate.dart';
import 'package:pixgem/component/text/collapsible_text.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/l10n/localization_intl.dart';
import 'package:pixgem/model_response/illusts/common_illust_list.dart';
import 'package:pixgem/model_response/user/preload_user_least_info.dart';
import 'package:pixgem/model_response/user/user_detail.dart';
import 'package:pixgem/api_app/api_base.dart';
import 'package:pixgem/api_app/api_user.dart';
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

  final ScrollController _scrollController = ScrollController();

  static const List<Tab> _tabs = [
    Tab(text: "作品"),
    Tab(text: "收藏"),
    Tab(text: "其他信息"),
  ];

  static double bannerHeight = 150; // 背景封面图的高度

  static double avatarDiameter = 80; // 头像的直径

  late double _appBarHeight; // AppBar加上状态栏的高度

  late double _appBarColorOffset0; // AppBar背景色透明度在0时的偏移量 [_scrollController.offset]

  late double _appBarColorOffset1; // AppBar背景色透明度在1时的偏移量

  late double _appbarColorOffsetDelta; // AppBar背景色透明度从0-1的偏移量的增量

  late double _appBarTitleOffset0; // AppBar标题透明度在0时的偏移量

  late double _appBarTitleOffset1; // AppBar标题透明度在1时的偏移量 (固定为20增量)

  double _appBarColorOpacity = 0.0;

  double _appBarTitleOpacity = 0.0;

  late StateSetter _appBarSetState;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: _tabs.length, vsync: this);
    refreshUserData().catchError((onError) {
      Fluttertoast.showToast(msg: "获取用户数据失败！$onError", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
    }).whenComplete(() {
      _provider.setIsLoading(false);
    });
    _scrollController.addListener(() {
      // AppBar透明度变化
      if (_scrollController.offset > _appBarColorOffset0 && _scrollController.offset < _appBarColorOffset1) {
        double o = (_scrollController.offset - _appBarColorOffset0) / _appbarColorOffsetDelta;
        if (o >= 0 && o <= 1) _appBarSetState(() => _appBarColorOpacity = o);
      } else if (_appBarColorOpacity != 0 || _appBarColorOpacity != 1) {
        _appBarSetState(() => _appBarColorOpacity = _scrollController.offset > _appBarColorOffset1 ? 1 : 0);
      }
      // AppBar Title透明度变化
      if (_scrollController.offset > _appBarTitleOffset0 && _scrollController.offset < _appBarTitleOffset1) {
        double o = (_scrollController.offset - _appBarTitleOffset0) / 20;
        if (o >= 0 && o <= 1) _appBarSetState(() => _appBarTitleOpacity = o);
      } else if (_appBarTitleOpacity != 0 || _appBarTitleOpacity != 1) {
        _appBarSetState(() => _appBarTitleOpacity = _scrollController.offset > _appBarTitleOffset1 ? 1 : 0);
      }
    });
  }

  /// 计算各类参数
  void _calc(BuildContext context) {
    bannerHeight = MediaQuery.of(context).size.width / 2;
    if (bannerHeight > 200) bannerHeight = 200;
    _appBarHeight = kToolbarHeight + MediaQuery.of(context).padding.top;
    _appBarColorOffset0 = bannerHeight - _appBarHeight - 12;
    _appBarColorOffset1 = _appBarColorOffset0 + _appBarHeight / 2;
    _appbarColorOffsetDelta = _appBarColorOffset1 - _appBarColorOffset0;
    _appBarTitleOffset0 = _appBarColorOffset0 + avatarDiameter;
    _appBarTitleOffset1 = _appBarTitleOffset0 + 20;
  }

  @override
  Widget build(BuildContext context) {
    _calc(context);
    return ChangeNotifierProvider(
      create: (BuildContext context) => _provider,
      child: Scaffold(
        body: Stack(
          children: [
            // 底部背景图
            SizedBox(
              width: double.infinity,
              height: bannerHeight,
              child: Selector(
                selector: (context, UserDetailProvider provider) {
                  return provider.userDetail;
                },
                builder: (BuildContext context, UserDetail? userDetail, Widget? child) {
                  if (userDetail?.profile.backgroundImageUrl == null) {
                    return Container(height: bannerHeight, color: Colors.blueGrey);
                  }
                  return CachedNetworkImage(
                    width: double.infinity,
                    imageUrl: userDetail!.profile.backgroundImageUrl!,
                    httpHeaders: const {"Referer": CONSTANTS.referer},
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            // 内容
            ExtendedNestedScrollView(
              onlyOneScrollInBody: true,
              controller: _scrollController,
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverPersistentHeader(
                    pinned: true,
                    floating: true,
                    delegate: SliverWidgetPersistentHeaderDelegate(
                      child: Container(),
                      maxHeight: _appBarHeight,
                      minHeight: _appBarHeight,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: bannerHeight - _appBarHeight - 12),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(12.0),
                            topLeft: Radius.circular(12.0),
                          ),
                        ),
                        child: _buildUserInfomation(context),
                      ),
                    ),
                  ),
                  // TabBar 分页栏
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: SliverTabBarPersistentHeaderDelegate(
                      child: TabBar(
                        labelColor: Theme.of(context).primaryColor,
                        indicatorColor: Theme.of(context).primaryColor,
                        unselectedLabelColor: Theme.of(context).colorScheme.onSurface,
                        controller: _tabController,
                        indicatorSize: TabBarIndicatorSize.label,
                        isScrollable: false,
                        tabs: _tabs,
                      ),
                    ),
                  ),
                ];
              },
              // 分页页面
              body: Container(
                color: Theme.of(context).colorScheme.background,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // 作品列表
                    IllustGridTabPage(
                      physics: const BouncingScrollPhysics(),
                      onLazyLoad: (String nextUrl) async {
                        var result = await ApiBase().getNextUrlData(nextUrl: nextUrl);
                        return CommonIllustList.fromJson(result);
                      },
                      onRefresh: () async {
                        // 获取作品列表
                        return await ApiUser().getUserIllusts(userId: widget.leastInfo.id).catchError((onError) {
                          Fluttertoast.showToast(
                              msg: "获取用户数据失败！$onError", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
                        });
                      },
                    ),
                    // 收藏列表
                    IllustGridTabPage(
                      physics: const BouncingScrollPhysics(),
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
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 16.0, top: 16, right: 16, bottom: 8),
                            child: Text(
                              "个人介绍",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Card(
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(8.0),
                                child: Selector(
                                  builder: (BuildContext context, UserDetail? detail, Widget? child) {
                                    if (detail == null) {
                                      return _buildLoading(context);
                                    }
                                    return Text.rich(
                                      TextSpan(
                                        text: detail.user.comment,
                                      ),
                                      textAlign: TextAlign.left,
                                    );
                                  },
                                  selector: (context, UserDetailProvider provider) {
                                    return provider.userDetail;
                                  },
                                ),
                              ),
                            ),
                          ),
                          // 用户信息，图标列表
                          Selector(
                            builder: (BuildContext context, UserDetail? detail, Widget? child) {
                              if (detail == null) {
                                return Container();
                              }
                              Map<IconData, String> map = {
                                Icons.transgender: detail.profile.gender == "" ? "unknown" : detail.profile.gender,
                                Icons.home_filled: detail.profile.webpage ?? "unknown",
                                Icons.location_on: detail.profile.region == "" ? "unknown" : detail.profile.region,
                                Icons.comment: detail.profile.twitterUrl ?? "unknown",
                              };
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var iconKey = map.keys.elementAt(index);
                                  return Row(
                                    children: [
                                      Padding(padding: const EdgeInsets.all(16.0), child: Icon(iconKey)),
                                      Expanded(flex: 1, child: Text(map[iconKey] ?? "unknown")),
                                    ],
                                  );
                                },
                                itemCount: map.length,
                              );
                            },
                            selector: (context, UserDetailProvider provider) {
                              return provider.userDetail;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
          ],
        ),
      ),
    );
  }

  // AppBar
  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(_appBarColorOpacity),
      leading: BlurButton.leadingBack(
        onPressed: () {
          Navigator.of(context).pop(-1);
        },
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
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                widget.leastInfo.name,
              ),
            ),
          ],
        ),
      ),
      actions: [
        BlurButton(
          onPressed: () {
            _scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.decelerate,
            );
          },
          borderRadius: BorderRadius.circular(20.0),
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: const Icon(Icons.keyboard_arrow_up),
        ),
        BlurButton(
          onPressed: () {},
          borderRadius: BorderRadius.circular(20.0),
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: const Icon(Icons.more_horiz_rounded),
        ),
      ],
    );
  }

  // 用户资料卡
  Widget _buildUserInfomation(BuildContext context) {
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
                      Row(
                        // 关注、好P友等的统计信息
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Text(LocalizationIntl.of(context).friends,
                                    style: Theme.of(context).textTheme.labelSmall),
                                Consumer(builder: (context, UserDetailProvider provider, child) {
                                  TextStyle numberTextStyle =
                                      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
                                  return Text(provider.userDetail?.profile.totalMypixivUsers.toString() ?? "...",
                                      style: numberTextStyle);
                                }),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Text(LocalizationIntl.of(context).following,
                                    style: Theme.of(context).textTheme.labelSmall),
                                Consumer(builder: (context, UserDetailProvider provider, child) {
                                  TextStyle numberTextStyle =
                                      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
                                  return Text(provider.userDetail?.profile.totalFollowUsers.toString() ?? "...",
                                      style: numberTextStyle);
                                }),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Text(LocalizationIntl.of(context).friends,
                                    style: Theme.of(context).textTheme.labelSmall),
                                Consumer(builder: (context, UserDetailProvider provider, child) {
                                  TextStyle numberTextStyle =
                                      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
            child: Text(
              "UID: ${widget.leastInfo.id.toString()}",
              style: const TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
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

  // 构建循环加载动画
  Widget _buildLoading(BuildContext context) {
    return Container(
      // width: 24.0,
      // height: 24.0,
      alignment: Alignment.center,
      child: CircularProgressIndicator(strokeWidth: 2.0, color: Theme.of(context).colorScheme.secondary),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  // 获取or刷新用户信息
  Future refreshUserData() async {
    UserDetail userDetail = await ApiUser().getUserDetail(userId: widget.leastInfo.id);
    _provider.setUserDetail(userDetail);
    _provider.setFollowed(userDetail.user.isFollowed);
  }
}
