import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/base/base_page.dart';
import 'package:pixgem/business_component/listview/illust_listview/illust_waterfall_gridview.dart';
import 'package:pixgem/component/loading/request_loading.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/config/enums.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/pages/artwork/detail/arguments/illust_detail_page_args.dart';
import 'package:pixgem/pages/main_navigation_tab_page/home/provider/home_provider.dart';
import 'package:pixgem/routes.dart';

class HomePage extends BaseStatefulPage {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => HomePageState();
}

class HomePageState extends BasePageState with AutomaticKeepAliveClientMixin {
  int size = 20;

  ScrollController controller = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ExtendedNestedScrollView(
      controller: controller,
      floatHeaderSlivers: true,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            pinned: true,
            toolbarHeight: Theme.of(context).appBarTheme.toolbarHeight ?? kToolbarHeight,
            title: const Text(
              "Pixgem",
            ),
            // 状态栏亮度，对应影响到字体颜色（dark为白色字体）
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.keyboard_arrow_up),
                onPressed: () {
                  controller.animateTo(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.decelerate,
                  );
                },
                tooltip: "回到顶部",
              ),
            ],
          )
        ];
      },
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
            slivers: [
              // 排行榜头部
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, top: 4),
                  child: Flex(
                    direction: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
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
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, top: 16, bottom: 8),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
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

  // 构建排行榜卡片列表（横向
  Widget buildRankingCardList(BuildContext context, List<CommonIllust> rankingList) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.only(left: 10),
              elevation: 2.0,
              shadowColor: Colors.black,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Image.network(
                    rankingList[index].imageUrls.squareMedium,
                    headers: const {"referer": CONSTANTS.referer_artworks_base},
                  ),
                  // 阴影
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 80,
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
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Text(
                              rankingList[index].title,
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // 作者头像
                              ClipOval(
                                child: Image.network(
                                  rankingList[index].user.profileImageUrls.medium,
                                  headers: const {"Referer": CONSTANTS.referer},
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
                                      const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
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
            );
          },
          itemCount: rankingList.length,
        ),
      ),
    );
  }
}
