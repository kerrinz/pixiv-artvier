import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/config/ranking_mode_constants.dart';
import 'package:pixgem/model_response/illusts/common_illust_list.dart';
import 'package:pixgem/pages/artworks/illusts_grid_page.dart';
import 'package:pixgem/request/api_base.dart';
import 'package:pixgem/request/api_illusts.dart';

class ArtworksLeaderboardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ArtworksLeaderboardPageState();
}

class ArtworksLeaderboardPageState extends State<ArtworksLeaderboardPage> with TickerProviderStateMixin {
  late TabController _tabController;

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
    return Scaffold(
      body: ExtendedNestedScrollView(
        floatHeaderSlivers: true,
        onlyOneScrollInBody: true,
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
        body: Container(
          child: Builder(
            builder: (context) {
              List<IllustGridTabPage> pages = [];
              this._tabsMap.forEach((mode, text) {
                pages.add(IllustGridTabPage(
                  physics: BouncingScrollPhysics(),
                  onRefresh: () async {
                    return await ApiIllusts().getIllustRanking(mode: mode).catchError((onError) {
                      Fluttertoast.showToast(msg: "获取排行失败$onError", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
                    });
                  },
                  onLazyLoad: (String nextUrl) async {
                    var result = await ApiBase().getNextUrlData(nextUrl: nextUrl);
                    return CommonIllustList.fromJson(result);
                  },
                ));
              });
              return TabBarView(
                controller: _tabController,
                children: pages,
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
}