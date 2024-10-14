import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/sliver_persistent_header/tab_bar_delegate.dart';
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
    const Tab(text: "全站"),
    const Tab(text: "好P友"),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          // TabBar 分页栏
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverTabBarPersistentHeaderDelegate(
              backgroundColor: colorScheme.surface,
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 8, bottom: 8),
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                tabs: _tabs,
              ),
              maxHeight: (Theme.of(context).appBarTheme.toolbarHeight ?? kToolbarHeight) +
                  MediaQuery.of(context).padding.top,
              minHeight: (Theme.of(context).appBarTheme.toolbarHeight ?? kToolbarHeight) +
                  MediaQuery.of(context).padding.top,
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: const [
          FollowedNewestTabPage(),
          EverybodyNewestTabPage(),
          FriendsNewestTabPage(),
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
