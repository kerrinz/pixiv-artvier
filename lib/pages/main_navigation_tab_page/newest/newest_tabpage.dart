import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:pixgem/component/illusts_grid_tabpage.dart';
import 'package:pixgem/model_response/illusts/common_illust_list.dart';
import 'package:pixgem/api_app/api_base.dart';
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
    return ExtendedNestedScrollView(
      onlyOneScrollInBody: true,
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            pinned: false,
            floating: true,
            snap: true,
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
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: [
          // 关注的新作
          IllustGridTabPage(
            physics: const BouncingScrollPhysics(),
            onRefresh: () async {
              return await ApiNewArtWork().getFollowsNewIllusts(ApiNewArtWork.restrict_all);
            },
            onLazyLoad: (String nextUrl) async {
              var result = await ApiBase().getNextUrlData(nextUrl: nextUrl);
              return CommonIllustList.fromJson(result);
            },
          ),
          // 大家的新作
          IllustGridTabPage(
            physics: const BouncingScrollPhysics(),
            onRefresh: () async {
              return await ApiNewArtWork().getEveryOnesNewIllusts(ApiNewArtWork.type_illust);
            },
            onLazyLoad: (String nextUrl) async {
              var result = await ApiBase().getNextUrlData(nextUrl: nextUrl);
              return CommonIllustList.fromJson(result);
            },
          ),
          // 好P友的新作
          IllustGridTabPage(
            physics: const BouncingScrollPhysics(),
            onRefresh: () async {
              return await ApiNewArtWork().getPFriendsIllusts(ApiNewArtWork.restrict_all);
            },
            onLazyLoad: (String nextUrl) async {
              var result = await ApiBase().getNextUrlData(nextUrl: nextUrl);
              return CommonIllustList.fromJson(result);
            },
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
