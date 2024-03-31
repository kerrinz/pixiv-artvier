import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/base/base_page.dart';
import 'package:artvier/pages/artwork/ranking/logic.dart';
import 'package:artvier/pages/artwork/ranking/artworks_tabpage.dart';
import 'package:artvier/config/ranking_mode_constants.dart';

class ArtworksRankingPage extends BaseStatefulPage {
  const ArtworksRankingPage({super.key});

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
  late Map<String, String> _tabsMap;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 13, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    _scrollController = PrimaryScrollController.of(context);
    _tabsMap = {
      IllustRankingMode.daily: i10n.rankingDaily,
      IllustRankingMode.weekly: i10n.rankingWeekly,
      IllustRankingMode.monthly: i10n.rankingMonthly,
      IllustRankingMode.dailyMale: i10n.rankingMale,
      IllustRankingMode.dailyFemale: i10n.rankingFemale,
      IllustRankingMode.weeklyOriginal: i10n.rankingOriginal,
      IllustRankingMode.weeklyRookie: i10n.rankingRookie,
      IllustRankingMode.dayAi: i10n.rankingAiGenerated,
      IllustRankingMode.dailyR18: i10n.rankingR18Daily,
      IllustRankingMode.weeklyR18: i10n.rankingR18Weekly,
      IllustRankingMode.dailyR18Ai: i10n.rankingR18AiGenerated,
      IllustRankingMode.dailyMaleR18: i10n.rankingR18Male,
      IllustRankingMode.dailyFemaleR18: i10n.rankingR18Female,
    };
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
