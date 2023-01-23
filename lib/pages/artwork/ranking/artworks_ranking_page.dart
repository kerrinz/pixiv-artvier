import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/base/base_page.dart';
import 'package:pixgem/pages/artwork/ranking/logic.dart';
import 'package:pixgem/pages/artwork/ranking/artworks_tabpage.dart';
import 'package:pixgem/config/ranking_mode_constants.dart';

class ArtworksRankingPage extends BaseStatefulPage {
  const ArtworksRankingPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ArtworksRankingPageState();
}

class ArtworksRankingPageState extends BasePageState<ArtworksRankingPage>
    with TickerProviderStateMixin, ArtworksRankingPageLogic {
  late final TabController _tabController;

  late final ScrollController _scrollController;

  @override
  ScrollController get scrollController => _scrollController;

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
    _scrollController = PrimaryScrollController.of(context) ?? ScrollController();
    return Scaffold(
      body: ExtendedNestedScrollView(
        floatHeaderSlivers: true,
        onlyOneScrollInBody: true,
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              snap: true,
              floating: true,
              title: const Text("排行榜"),
              toolbarHeight: Theme.of(context).appBarTheme.toolbarHeight ?? kToolbarHeight,
              bottom: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                controller: _tabController,
                isScrollable: true,
                tabs: [
                  for (String name in _tabsMap.values) Tab(text: name),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.keyboard_arrow_up),
                  onPressed: handlePressedToTop,
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
                  ArtworksRankingTabPage(
                    mode: mode,
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
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
