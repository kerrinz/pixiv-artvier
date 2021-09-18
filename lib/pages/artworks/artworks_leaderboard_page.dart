import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/config/ranking_mode_constants.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/pages/artworks/illusts_gird_page.dart';
import 'package:pixgem/request/api_illusts.dart';
import 'package:provider/provider.dart';

class ArtworksLeaderboardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ArtworksLeaderboardPageState();
}

class ArtworksLeaderboardPageState extends State<ArtworksLeaderboardPage> with TickerProviderStateMixin {
  bool _isLoadingMore = false; // 是否正在加载更多数据（防止重复获取）
  _Provider _provider = _Provider();
  ScrollController _scrollController = ScrollController();
  late TabController _tabController;
  String _date = "2021-07-16";

  // tab分页的对应模式与字段
  Map<String, String> _tabsMap = {
    RankingModeConstants.illust_day: "每日",
    RankingModeConstants.illust_week: "每周",
    RankingModeConstants.illust_month: "每月",
    RankingModeConstants.illust_day_male: "男性向",
    RankingModeConstants.illust_day_female: "女性向",
    RankingModeConstants.illust_week_original: "原创",
    RankingModeConstants.illust_week_rookie: "新人",
    RankingModeConstants.illust_day_r18: "每日R18",
    RankingModeConstants.illust_week_r18: "每周R18",
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: _tabsMap.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => _provider,
      child: Scaffold(
        body: NestedScrollView(
          // controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            List<Widget> tabs = [];
            this._tabsMap.forEach((key, value) {
              tabs.add(Tab(text: value));
            });
            return [
              SliverAppBar(
                pinned: true,
                snap: true,
                floating: true,
                title: Text("排行榜"),
                bottom: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  controller: _tabController,
                  isScrollable: true,
                  tabs: tabs,
                ),
              ),
            ];
          },
          body: Selector(
            builder: (context, var rankingMap, Widget? child) {
              List<Widget> pages = [];
              this._tabsMap.forEach((mode, text) {
                pages.add(IllustGirdTabPage(
                  onRefresh: () async {
                    await refreshData(mode).catchError((onError) {
                      Fluttertoast.showToast(msg: "获取排行失败$onError", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
                    });
                  },
                  onLazyLoad: () async {
                    await getNext(mode);
                  },
                  illustList: _provider.rankingMap[mode],
                ));
              });
              return TabBarView(
                controller: _tabController,
                children: pages,
              );
            },
            selector: (context, _Provider provider) {
              return provider.rankingMap;
            },
          ),
        ),
      ),
    );
  }

  // 刷新或获取数据
  Future refreshData(String mode) async {
    var data = await ApiIllusts().getIllustRanking(mode: mode);
    _provider.setMapData(mode: mode, rankingList: data.illusts, nextUrl: data.nextUrl);
    Fluttertoast.showToast(msg: "获取成功", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
    this.setState(() {});
  }

  // 加载下一页数据
  Future getNext(String mode) async {
    String? nextUrl = _provider.nextUrlMap[mode];
    if (nextUrl == null) return Future.error("NextUrl is null!");
    var data = await ApiIllusts().getNextIllustRanking(nextUrl);
    // 添加新数据到provider
    _provider.addNextData(mode: mode, rankingList: data.illusts, nextUrl: data.nextUrl);
    this.setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _scrollController.dispose();
  }
}

class _Provider with ChangeNotifier {
  Map<String, List<CommonIllust>> rankingMap = Map(); // 排行榜
  Map<String, String> nextUrlMap = Map(); // 下一页

  bool isLoading = true; // 是否正在加载中

  void setMapData({required String mode, required List<CommonIllust> rankingList, required String nextUrl}) {
    this.rankingMap[mode] = rankingList;
    this.nextUrlMap[mode] = nextUrl;
    notifyListeners();
  }

  void addNextData({required String mode, required List<CommonIllust> rankingList, required String nextUrl}) {
    var oldRanking = this.rankingMap[mode];
    if (oldRanking != null) {
      this.rankingMap[mode] = [...oldRanking, ...rankingList];
    }
    this.nextUrlMap[mode] = nextUrl;
    notifyListeners();
  }
}
