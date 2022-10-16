import 'package:dio/dio.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/pages/illust/tab_page/illusts_grid_tabpage.dart';
import 'package:pixgem/config/ranking_mode_constants.dart';
import 'package:pixgem/api_app/api_illusts.dart';

class ArtworksLeaderboardPage extends StatefulWidget {
  const ArtworksLeaderboardPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ArtworksLeaderboardPageState();
}

class ArtworksLeaderboardPageState extends State<ArtworksLeaderboardPage> with TickerProviderStateMixin {
  late TabController _tabController;
  ScrollController scrollController = ScrollController();
  // tab分页的对应模式与字段
  final Map<String, String> _tabsMap = {
    IllustRankingMode.daily: "每日",
    IllustRankingMode.weekly: "每周",
    IllustRankingMode.monthly: "每月",
    IllustRankingMode.dailyMale: "男性向",
    IllustRankingMode.dailyFemale: "女性向",
    IllustRankingMode.weeklyOriginal: "原创",
    IllustRankingMode.weeklyRookie: "新人",
    IllustRankingMode.dailyR18: "每日R18",
    IllustRankingMode.weeklyR18: "每周R18",
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
        controller: scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              snap: true,
              floating: true,
              title: const Text("排行榜"),
              bottom: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                controller: _tabController,
                isScrollable: true,
                tabs: [
                  for (String name in _tabsMap.values)
                    Tab(
                      text: name,
                    ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.keyboard_arrow_up),
                  onPressed: () {
                    scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.decelerate,
                    );
                  },
                  tooltip: "回到顶部",
                ),
              ],
            ),
          ];
        },
        body: Builder(
          builder: (context) {
            return TabBarView(
              controller: _tabController,
              children: [
                for (String mode in _tabsMap.keys)
                  IllustGridTabPage(
                    physics: const BouncingScrollPhysics(),
                    onRequest: (CancelToken cancelToken) async {
                      return await ApiIllusts().getIllustRanking(mode: mode).catchError((onError) {
                        Fluttertoast.showToast(msg: "获取排行失败$onError", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
                      });
                    },
                  ),
              ],
            );
          },
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
