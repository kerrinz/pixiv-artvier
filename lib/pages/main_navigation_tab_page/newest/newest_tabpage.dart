import 'package:artvier/base/base_page.dart';
import 'package:artvier/pages/main_navigation_tab_page/newest/sub_tabpage/followed_series_tabpage.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:artvier/pages/main_navigation_tab_page/newest/sub_tabpage/everybody_newest_tabpage.dart';
import 'package:artvier/pages/main_navigation_tab_page/newest/sub_tabpage/followed_newest_tabpage.dart';
import 'package:artvier/pages/main_navigation_tab_page/newest/sub_tabpage/friends_newest_tabpage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewArtworksTabPage extends BaseStatefulPage {
  const NewArtworksTabPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => NewArtworksTabPageState();
}

class NewArtworksTabPageState extends BasePageState<NewArtworksTabPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;
  final List<Tab> _tabs = [
    const Tab(text: "关注"),
    const Tab(text: "追更列表"),
    const Tab(text: "全站"),
    const Tab(text: "好P友"),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ExtendedNestedScrollView(
      onlyOneScrollInBody: true,
      floatHeaderSlivers: true,
      headerSliverBuilder: (_, __) => [],
      body: Column(
        children: [
          Container(
            color: colorScheme.surface,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Container(
              width: double.infinity,
              height: Theme.of(context).appBarTheme.toolbarHeight ?? kToolbarHeight,
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                padding: EdgeInsets.zero,
                tabs: _tabs,
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                FollowedNewestTabPage(),
                FollowedSeriesTabPage(),
                EverybodyNewestTabPage(),
                FriendsNewestTabPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: _tabs.length, vsync: this);
  }

  @override
  bool get wantKeepAlive => true;
}
