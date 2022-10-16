import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pixgem/pages/illust/tab_page/illusts_grid_tabpage.dart';
import 'package:pixgem/api_app/api_new_artworks.dart';

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
            children: [
              // 关注的新作
              IllustGridTabPage(
                physics: const BouncingScrollPhysics(),
                onRequest: (CancelToken cancelToken) async {
                  return await ApiNewArtWork()
                      .getFollowsNewIllusts(ApiNewArtWork.restrict_all, cancelToken: cancelToken);
                },
              ),
              // 大家的新作
              IllustGridTabPage(
                physics: const BouncingScrollPhysics(),
                onRequest: (CancelToken cancelToken) async {
                  return await ApiNewArtWork()
                      .getEveryOnesNewIllusts(ApiNewArtWork.type_illust, cancelToken: cancelToken);
                },
              ),
              // 好P友的新作
              IllustGridTabPage(
                physics: const BouncingScrollPhysics(),
                onRequest: (CancelToken cancelToken) async {
                  return await ApiNewArtWork().getPFriendsIllusts(ApiNewArtWork.restrict_all, cancelToken: cancelToken);
                },
              ),
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
