import 'dart:math';

import 'package:artvier/business_component/input/search_box.dart';
import 'package:artvier/business_component/page_layout/banner_appbar_page_layout.dart';
import 'package:artvier/component/image/enhance_network_image.dart';
import 'package:artvier/pages/main_navigation_tab_page/home/widgets/pixivision_carousel.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/base/base_page.dart';
import 'package:artvier/business_component/listview/illust_listview/illust_waterfall_gridview.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/config/constants.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';
import 'package:artvier/pages/artwork/detail/arguments/illust_detail_page_args.dart';
import 'package:artvier/pages/main_navigation_tab_page/home/provider/home_provider.dart';
import 'package:artvier/routes.dart';

class HomePage extends BaseStatefulPage {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => HomePageState();
}

class HomePageState extends BasePageState with AutomaticKeepAliveClientMixin {
  int size = 20;

  late ScrollController _scrollController;

  /// 是否已经挂载了 ScrollController
  bool _hasMountedScroll = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasMountedScroll) {
      _scrollController = ScrollController();
      _hasMountedScroll = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BannerAppBarPageLayout(
      appBarStartBuilderOffset: 0,
      appBarEndBuilderOffset: 200,
      appBarBuilder: _buildAppBar,
      scrollController: _scrollController,
      body: RefreshIndicator(
        onRefresh: () async => ref.read(homeStateProvider.notifier).refresh(),
        child: Consumer(builder: (_, ref, __) {
          PageState pageState = ref.watch(homeStateProvider);
          switch (pageState) {
            case PageState.loading:
              return const RequestLoading();
            case PageState.error:
              return RequestLoadingFailed(onRetry: () async => ref.read(homeStateProvider.notifier).init());
            case PageState.refreshing:
            case PageState.complete:
            case PageState.empty:
          }
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
            slivers: [
              // 轮播图
              SliverToBoxAdapter(
                child: SizedBox(
                  height: toolBarFullHeight + 160,
                  child: const PixivsionCarousel(),
                ),
              ),
              // 排行榜头部
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, top: 4),
                  child: Flex(
                    direction: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        flex: 1,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.leaderboard_rounded,
                              color: Colors.amber,
                              size: 24,
                            ),
                            Text(
                              " 插画排行榜",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(RouteNames.ranking.name);
                        },
                        // style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.black)),
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("更多"),
                            Icon(Icons.chevron_right),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // 排行榜卡片列表
              Consumer(
                builder: (context, ref, child) {
                  var data = ref.watch(homeIllustRankingProvider);
                  return buildRankingCardList(ref.context, data);
                },
              ),
              // 推荐头部
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(left: 12, top: 16, bottom: 8),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite_rounded,
                              color: Colors.deepOrange,
                              size: 24,
                            ),
                            Text(
                              " 为你推荐",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // 推荐列表
              Consumer(
                builder: (context, ref, child) {
                  var data = ref.watch(homeIllustRecommendedProvider);
                  return SliverIllustWaterfallGridView(
                    artworkList: data,
                    onLazyload: ref.read(homeIllustRecommendedProvider.notifier).next,
                  );
                },
              ),
            ],
          );
        }),
      ),
    );
  }

  /// 根据滚动偏移，渲染 AppBar
  Widget _buildAppBar(double offset) {
    double bgOpacity = 0.0;
    Color inputBackgroundColor = Colors.black12;
    if (offset >= 100) {
      bgOpacity = (offset - 100) / 100;
      inputBackgroundColor = Colors.grey.withOpacity(0.15);
    } else {
      bgOpacity = 0;
    }
    Color textColor = Colors.white;
    if (colorScheme.brightness == Brightness.light && bgOpacity > 0.5) {
      textColor = Colors.black;
    }
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10, bottom: 10, left: 10, right: 10),
      height: (Theme.of(context).appBarTheme.toolbarHeight ?? kToolbarHeight) + MediaQuery.of(context).padding.top,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(bgOpacity),
      ),
      child: SearchBox(
        textColor: textColor,
        backgroundColor: inputBackgroundColor,
      ),
    );
  }

  // 构建排行榜卡片列表（横向
  Widget buildRankingCardList(BuildContext context, List<CommonIllust> rankingList) {
    double height = min(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height) / 2.5;
    return SliverToBoxAdapter(
      child: SizedBox(
        height: height,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 8, right: 8),
          itemBuilder: (context, index) {
            return SizedBox(
              width: height,
              height: height,
              child: Card(
                elevation: 0,
                shadowColor: Colors.transparent,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                color: colorScheme.surface,
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    EnhanceNetworkImage(
                      image: ExtendedNetworkImageProvider(
                        HttpHostOverrides().pxImgUrl(rankingList[index].imageUrls.squareMedium),
                        headers: const {"referer": CONSTANTS.referer_artworks_base},
                      ),
                    ),
                    // 阴影
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 60,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color(0x00000000),
                            Color(0x33000000),
                            Color(0x6C000000),
                          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                        ),
                      ),
                    ),
                    // 描述信息
                    Positioned(
                      bottom: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 作品标题
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text(
                                rankingList[index].title,
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // 作者头像
                                ClipOval(
                                  child: EnhanceNetworkImage(
                                    image: ExtendedNetworkImageProvider(
                                      HttpHostOverrides().pxImgUrl(rankingList[index].user.profileImageUrls.medium),
                                      headers: const {"Referer": CONSTANTS.referer},
                                    ),
                                    fit: BoxFit.cover,
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Text(
                                    rankingList[index].user.name,
                                    style:
                                        const TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.black12.withOpacity(0.15),
                          highlightColor: Colors.black12.withOpacity(0.1),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              RouteNames.artworkDetail.name,
                              arguments: IllustDetailPageArguments(
                                illustId: rankingList[index].id.toString(),
                                detail: rankingList[index],
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
          },
          itemCount: rankingList.length,
        ),
      ),
    );
  }
}
