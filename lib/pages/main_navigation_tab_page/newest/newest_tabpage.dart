import 'package:flutter/material.dart';
import 'package:pixgem/pages/main_navigation_tab_page/newest/sub_tabpage/everybody_newest_tabpage.dart';
import 'package:pixgem/pages/main_navigation_tab_page/newest/sub_tabpage/followed_newest_tabpage.dart';
import 'package:pixgem/pages/main_navigation_tab_page/newest/sub_tabpage/friends_newest_tabpage.dart';

class NewArtworksTabPage extends StatefulWidget {
  const NewArtworksTabPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NewArtworksTabPageState();
}

class NewArtworksTabPageState extends State<NewArtworksTabPage>
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
    return Column(
      children: [
        AppBar(
          title: SizedBox(
            height: 48,
            child: Row(
              children: [
                Expanded(
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    controller: _tabController,
                    isScrollable: true,
                    tabs: _tabs,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Text("?"),
              onPressed: () {},
              tooltip: "?",
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              FollowedNewestTabPage(),
              EverybodyNewestTabPage(),
              FriendsNewestTabPage(),
            ],
          ),
        ),
      ],
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
