import 'dart:ui';

import 'package:artvier/request/http_host_overrides.dart';
import 'package:extended_image/extended_image.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/base/base_page.dart';
import 'package:artvier/business_component/page_layout/banner_appbar_page_layout.dart';
import 'package:artvier/component/image/enhance_network_image.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/component/sliver_persistent_header/tab_bar_delegate.dart';
import 'package:artvier/config/constants.dart';
import 'package:artvier/model_response/user/preload_user_least_info.dart';
import 'package:artvier/pages/user/detail/tabpage/collections_tabpage.dart';
import 'package:artvier/pages/user/detail/logic.dart';
import 'package:artvier/pages/user/detail/provider/user_detail_provider.dart';
import 'package:artvier/pages/user/detail/tabpage/more_information_tabpage.dart';
import 'package:artvier/pages/user/detail/tabpage/works_tabpage.dart';
import 'package:artvier/pages/user/detail/widget/appbar.dart';
import 'package:artvier/pages/user/detail/widget/user_panel_widget.dart';

class UserDetailPage extends BaseStatefulPage {
  /// 用户信息（精简版）
  final PreloadUserLeastInfo leastInfo;

  const UserDetailPage(Object arguments, {super.key}) : leastInfo = arguments as PreloadUserLeastInfo;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _UserDetailState();
  }
}

class _UserDetailState extends BasePageState<UserDetailPage> with TickerProviderStateMixin, UserDetailPageLogic {
  late TabController _tabController;

  late ScrollController _scrollController;

  final double kToolbarHeight = 50;

  /// 背景封面图的高度（动态计算）
  late double _bannerHeight;

  /// 头像的直径
  final double _avatarDiameter = 80;

  /// 主体内容的R角
  final double _radius = 12;

  /// 是否已经挂载了监听事件
  bool _hasMountedListener = false;

  // AppBar背景色变化的终止时，所处滚动位置
  late double _endAppBarBackgroundOffset;

  // AppBar背景色变化的起始时，所处滚动位置
  late double _startAppBarBackgroundOffset;

  late double _deltaAppBarBackgroundOffset;

  // AppBar标题变化的终止时，所处滚动位置
  late double _endAppBarTitleOffset;

  // AppBar标题变化的起始时，所处滚动位置
  late double _startAppBarTitleOffset;

  late double _deltaAppBarTitleOffset;

  @override
  String get userId => widget.leastInfo.id;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasMountedListener) {
      _scrollController = PrimaryScrollController.of(context);
      _scrollController.addListener(_handleScroll);
      _hasMountedListener = true;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// 计算各类参数
  void _calc(BuildContext context) {
    _bannerHeight = MediaQuery.of(context).size.width * 0.48;
    // 限制banner的最大高度
    if (_bannerHeight > 200) _bannerHeight = 200;

    // AppBar背景色变化的终止和起始时，所处滚动位置
    _endAppBarBackgroundOffset = _bannerHeight - kToolbarHeight - MediaQuery.of(context).padding.top;
    _deltaAppBarBackgroundOffset = 20;
    _startAppBarBackgroundOffset = _endAppBarBackgroundOffset - _deltaAppBarBackgroundOffset;

    // AppBar标题变化的起始和终止时，所处滚动位置
    _startAppBarTitleOffset = _endAppBarBackgroundOffset + _avatarDiameter - _radius;
    _deltaAppBarTitleOffset = 30;
    _endAppBarTitleOffset = _startAppBarTitleOffset + _deltaAppBarTitleOffset;
  }

  // 滚动触发事件
  void _handleScroll() {}

  @override
  Widget build(BuildContext context) {
    _calc(context);
    return Scaffold(
      body: BannerAppBarPageLayout(
        bannerHeight: _bannerHeight,
        appBarStartBuilderOffset: _startAppBarBackgroundOffset,
        appBarEndBuilderOffset: _endAppBarTitleOffset,
        appBarBuilder: (double offset) => _buildAppBar(offset),
        bannerWidget: _bannerWidget(),
        body: ExtendedNestedScrollView(
          onlyOneScrollInBody: true,
          controller: _scrollController,
          pinnedHeaderSliverHeightBuilder: () {
            return MediaQuery.of(context).padding.top + kToolbarHeight + kTabBarHeight;
          },
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  // 加顶部padding，让banner不被遮挡
                  padding: EdgeInsets.only(top: _bannerHeight - _radius),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius:
                          const BorderRadius.only(topRight: Radius.circular(12.0), topLeft: Radius.circular(12.0)),
                    ),
                    // 用户面板（简要的资料信息）
                    child: UserDetailPageUserPanelWidget(
                      userId: userId,
                      userName: widget.leastInfo.name,
                      avatarUrl: widget.leastInfo.avatar,
                      avatarDiameter: _avatarDiameter,
                    ),
                  ),
                ),
              ),
              // TabBar 分页栏
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverTabBarPersistentHeaderDelegate(
                  backgroundColor: colorScheme.surface,
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
                  child: TabBar(
                    labelPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                    controller: _tabController,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    tabs: [
                      Tab(text: i10n.works),
                      Tab(text: i10n.collections),
                      Tab(text: i10n.more),
                    ],
                  ),
                ),
              ),
            ];
          },
          // 分页页面
          body: Consumer(builder: (_, ref, __) {
            return ref.watch(userDetailProvider(userId)).when(
                  data: (detail) {
                    return Container(
                      color: colorScheme.background,
                      child: TabBarView(
                        physics: const ClampingScrollPhysics(),
                        controller: _tabController,
                        children: [
                          // 作品列表页面
                          UserWorksTabPage(
                            userId: widget.leastInfo.id.toString(),
                          ),
                          // 收藏列表页面
                          UserCollectionsTabPage(
                            userId: widget.leastInfo.id.toString(),
                          ),
                          // 用户详情页面
                          UserMoreInformationTabPage(detail: detail),
                        ],
                      ),
                    );
                  },
                  error: (_, __) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          Center(
                            child: RequestLoadingFailed(
                              onRetry: () => ref.read(userDetailProvider(userId).notifier).reload(),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  loading: () => const RequestLoading(),
                );
          }),
        ),
      ),
    );
  }

  /// 顶部封面图
  Widget _bannerWidget() {
    return Consumer(
      builder: (_, ref, __) {
        String? bg = ref.watch(userDetailProvider(userId)).value?.profile.backgroundImageUrl;
        if (bg == null) {
          // 未加载用户详情，或者用户没有设置封面图，则使用用户头像作为封面图
          return ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: EnhanceNetworkImage(
              image: ExtendedNetworkImageProvider(
                HttpHostOverrides().pxImgUrl(widget.leastInfo.avatar),
                headers: const {"Referer": CONSTANTS.referer},
              ),
              width: double.infinity,
              fit: BoxFit.cover,
              color: const Color(0x33000000), // 等同于black.opacity(0.2)
              colorBlendMode: BlendMode.multiply,
            ),
          );
        }
        // 正常的封面图
        return EnhanceNetworkImage(
          image: ExtendedNetworkImageProvider(HttpHostOverrides().pxImgUrl(bg),
              headers: const {"Referer": CONSTANTS.referer}),
          width: double.infinity,
          fit: BoxFit.cover,
          color: const Color(0x33000000),
          colorBlendMode: BlendMode.multiply,
        );
      },
    );
  }

  // AppBar
  Widget _buildAppBar(double offset) {
    double bgOpacity;
    double titleOpacity;
    // 首次加载时offset是0
    if (offset == 0) {
      bgOpacity = 0;
    } else if (offset <= _endAppBarBackgroundOffset) {
      bgOpacity = (offset - _startAppBarBackgroundOffset) / _deltaAppBarBackgroundOffset;
    } else {
      bgOpacity = 1;
    }

    if (offset >= _startAppBarTitleOffset) {
      titleOpacity = (offset - _startAppBarTitleOffset) / _deltaAppBarTitleOffset;
    } else {
      titleOpacity = 0;
    }
    return UserDetailPageAppBarWidget(
      userId: userId,
      name: widget.leastInfo.name,
      avatarUrl: widget.leastInfo.avatar,
      backgroundOpacity: bgOpacity,
      titleOpacity: titleOpacity,
    );
  }
}
