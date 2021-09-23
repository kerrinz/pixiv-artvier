import 'dart:ui';

import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/request/api_illusts.dart';
import 'package:pixgem/widgets/illust_waterfall_gird_sliver.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State with AutomaticKeepAliveClientMixin {
  int size = 20;
  bool _isLoadingMore = false; // 是否正在加载更多数据（防止重复获取）
  _ListProvider _listProvider = _ListProvider();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    refreshAndSetData().catchError((onError) {
      Fluttertoast.showToast(msg: "Error！获取作品失败", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
      print(onError);
    }).whenComplete(() => _listProvider.setLoading(false));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => _listProvider,
      child: ExtendedNestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: false,
              floating: true,
              snap: true,
              title: Text(
                "Pixgem",
                style: TextStyle(fontSize: 18),
              ),
              // 状态栏亮度，对应影响到字体颜色（dark为白色字体）
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.sort),
                  onPressed: () {},
                  tooltip: "排列布局",
                ),
                IconButton(
                  icon: Icon(Icons.keyboard_arrow_up),
                  onPressed: () {},
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
              print(onError);
            }).whenComplete(() => _listProvider.setLoading(false));
            // await saveAccount();
          },
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              // 排行榜头部
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(left: 12, top: 4),
                  child: Flex(
                    direction: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
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
                          Navigator.of(context).pushNamed("artworks_leaderboard");
                        },
                        // style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.black)),
                        child: Row(
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
              Selector(
                builder: (BuildContext context, List<CommonIllust> rankingList, Widget? child) {
                  return buildLeaderboardCardList(context, rankingList);
                },
                selector: (context, _ListProvider provider) {
                  return provider.rankingList;
                },
              ),
              // 推荐头部
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(left: 12, top: 4),
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
                      TextButton(
                        onPressed: () {},
                        // style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.black)),
                        child: Row(
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
              // 推荐列表
              Selector(
                builder: (BuildContext context, List<CommonIllust> artworkList, Widget? child) {
                  return IllustWaterfallGirdSliver(
                    // 普通网格布局（图片）
                    artworkList: artworkList,
                    onLazyLoad: () {
                      // 不在加载中才能获取下一页的数据，以防重复获取同页数据
                      if (!this._isLoadingMore) {
                        this._isLoadingMore = true;
                        requestNextIllusts().catchError((onError) {
                          Fluttertoast.showToast(msg: "获取更多作品失败！", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
                        }).whenComplete(() => this._isLoadingMore = false);
                      }
                    },
                  );
                },
                selector: (context, _ListProvider provider) {
                  return provider.artworkList;
                },
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }

  // 构建排行榜卡片列表（横向
  Widget buildLeaderboardCardList(BuildContext context, List<CommonIllust> rankingList) {
    if (rankingList.isNotEmpty)
      return SliverToBoxAdapter(
        child: Container(
          height: 200,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.only(left: 10),
                elevation: 2.0,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    Image.network(
                      rankingList[index].imageUrls.squareMedium,
                      headers: {"referer": CONSTANTS.referer_artworks_base},
                    ),
                    // 阴影
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color(0x0),
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
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // 作者头像
                                ClipOval(
                                  child: Image.network(
                                    rankingList[index].user.profileImageUrls.medium,
                                    headers: {"Referer": CONSTANTS.referer},
                                    fit: BoxFit.cover,
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Text(
                                    rankingList[index].user.name,
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
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
                            Navigator.of(context).pushNamed("artworks_detail", arguments: rankingList[index]);
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
    return SliverToBoxAdapter(
      child: Container(
        height: 200,
        alignment: Alignment.center,
        child: CircularProgressIndicator(strokeWidth: 1.0, color: Theme.of(context).accentColor),
      ),
    );
  }

  // 请求并设置数据，返回Future
  Future refreshAndSetData() async {
    var artworks = await ApiIllusts().getFirstRecommendedIllust();
    _listProvider.setData(
        artworkList: artworks.illusts,
        rankingList: artworks.rankingIllusts, // 排行榜
        isLoading: false, // 停止加载
        nextUrl: artworks.nextUrl); // 下一组作品数据的访问地址
  }

  // 获取更多作品
  Future requestNextIllusts() async {
    // 获取更多作品
    var artworks = await ApiIllusts().getNextRecommendedIllust(nextUrl: _listProvider.nextUrl);
    _listProvider.addNextArtworks(list: artworks.illusts); // 添加作品list
    _listProvider.setNextUrl(artworks.nextUrl); // 更新nextUrl
  }

  @override
  bool get wantKeepAlive => true;
}

class _ListProvider with ChangeNotifier {
  List<CommonIllust> artworkList = []; // 作品列表
  List<CommonIllust> rankingList = []; // 排行榜列表

  late String nextUrl; // 加载更多的访问地址
  bool isLoading = true; // 是否正在加载中

  void setData(
      {required List<CommonIllust> artworkList,
      required List<CommonIllust> rankingList,
      bool isLoading = false,
      required String nextUrl}) {
    this.artworkList = artworkList;
    this.rankingList = rankingList;
    this.isLoading = isLoading;
    this.nextUrl = nextUrl;
    notifyListeners();
  }

  void setRankingList({required List<CommonIllust> list}) {
    rankingList = list;
    notifyListeners();
  }

  void setArtworkList({required List<CommonIllust> list}) {
    artworkList = list;
    notifyListeners();
  }

  void addNextArtworks({required List<CommonIllust> list}) {
    artworkList = [...artworkList, ...list];
    notifyListeners();
  }

  void setNextUrl(String url) {
    this.nextUrl = url;
    notifyListeners();
  }

  void setLoading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  void clearArtworks() {
    artworkList.clear();
    notifyListeners();
  }
}
