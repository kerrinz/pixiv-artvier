import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/component/scroll_list/illust_waterfall_grid.dart';
import 'package:pixgem/component/loading/request_loading.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/pages/illust/illust_detail/illust_detail_page.dart';
import 'package:pixgem/api_app/api_illusts.dart';
import 'package:pixgem/pages/main_navigation_tab_page/home/list_provider.dart';
import 'package:pixgem/routes.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State with AutomaticKeepAliveClientMixin {
  int size = 20;
  bool _isLoadingMore = false; // 是否正在加载更多数据（防止重复获取）
  final HomeTabPageIllustProvider _illustProvider = HomeTabPageIllustProvider();
  ScrollController controller = ScrollController();
  String? nextUrl; // 下一页的地址

  @override
  void initState() {
    super.initState();
    refreshAndSetData().catchError((onError) {
      Fluttertoast.showToast(msg: "获取作品失败$onError", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
      _illustProvider.setLoadingStatus(LoadingStatus.failed);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider<HomeTabPageIllustProvider>.value(
      value: _illustProvider,
      child: ExtendedNestedScrollView(
        controller: controller,
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: false,
              floating: true,
              snap: true,
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
          // 下拉刷新
          onRefresh: () async {
            await refreshAndSetData().then((value) {
              Fluttertoast.showToast(msg: "刷新成功", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
            }).catchError((onError) {
              Fluttertoast.showToast(msg: "Error！刷新失败", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
            });
            // await saveAccount();
          },
          child: CustomScrollView(
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
                          Navigator.of(context).pushNamed(RouteNames.leaderboard.name);
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
              Selector(
                builder: (BuildContext context, LoadingStatus loadingStatus, Widget? child) {
                  switch (loadingStatus) {
                    case LoadingStatus.loading:
                    case LoadingStatus.failed:
                      return _buildRankingUnsuccess(context, loadingStatus);
                    default:
                      return buildLeaderboardCardList(context, _illustProvider.rankingList);
                  }
                  // if (_illustProvider.loadingStatus == LoadingStatus.success &&
                  //     _illustProvider.rankingList.isNotEmpty) {
                  //   return buildLeaderboardCardList(context, _illustProvider.rankingList);
                  // }
                },
                selector: (context, HomeTabPageIllustProvider provider) {
                  return provider.loadingStatus;
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
                builder: (BuildContext context, HomeTabPageIllustProvider provider, Widget? child) {
                  switch (provider.loadingStatus) {
                    case LoadingStatus.loading:
                    case LoadingStatus.failed:
                      return SliverToBoxAdapter(
                        child: Container(),
                      );
                    default:
                  }
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    sliver: IllustWaterfallGrid.sliver(
                      // 普通网格布局（图片）
                      artworkList: provider.recomendlist,
                      onLazyLoad: () {
                        // 不在加载中才能获取下一页的数据，以防重复获取同页数据
                        if (!_isLoadingMore) {
                          _isLoadingMore = true;
                          requestNextIllusts().catchError((onError) {
                            Fluttertoast.showToast(msg: "获取更多作品失败！", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
                          }).whenComplete(() => _isLoadingMore = false);
                        }
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 构建排行榜加载中与加载失败显示的样式
  Widget _buildRankingUnsuccess(BuildContext context, LoadingStatus status) {
    Widget loadingWidget = const RequestLoading();
    Widget failedWidget = RequestLoadingFailed(onRetry: () {
          _illustProvider.setLoadingStatus(LoadingStatus.loading);
          refreshAndSetData().catchError((_) {
            _illustProvider.setLoadingStatus(LoadingStatus.failed);
          });
        });
    return SliverToBoxAdapter(
      child: Container(
        height: 200,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: status == LoadingStatus.loading ? loadingWidget : failedWidget,
      ),
    );
  }

  // 构建排行榜卡片列表（横向
  Widget buildLeaderboardCardList(BuildContext context, List<CommonIllust> rankingList) {
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
                          Navigator.of(context).pushNamed(RouteNames.artworkDetail.name,
                              arguments: ArtworkDetailModel(
                                  list: rankingList,
                                  index: index,
                                  callback: (int index, bool isBookmarked) {
                                    _illustProvider.rankingList[index].isBookmarked = isBookmarked;
                                    // (context as Element).markNeedsBuild(); 非当前页面触发，无需刷新
                                  }));
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

  // 请求并设置数据，返回Future
  Future refreshAndSetData() async {
    var body = await ApiIllusts().getFirstRecommendedIllust();
    nextUrl = body.nextUrl;
    _illustProvider.resetAll(body.rankingIllusts, body.illusts, LoadingStatus.success);
  }

  // 获取更多作品
  Future requestNextIllusts() async {
    // 获取更多作品
    if (nextUrl != null) {
      var result = await ApiIllusts().getNextRecommendedIllust(nextUrl: nextUrl!);
      _illustProvider.addAllToRecomendList(result.illusts); // 添加更多作品
      nextUrl = result.nextUrl; // 更新nextUrl
    }
  }

  @override
  bool get wantKeepAlive => true;
}
