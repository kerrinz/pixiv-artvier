import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:pixgem/model_response/illusts/common_illust_list.dart';
import 'package:pixgem/pages/artworks/illusts_gird_page.dart';
import 'package:pixgem/request/api_base.dart';
import 'package:pixgem/request/api_new_artworks.dart';

class NewArtworksTabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewArtworksTabPageState();
}

class NewArtworksTabPageState extends State<NewArtworksTabPage> with TickerProviderStateMixin {
  late TabController _tabController;
  List<Tab> _tabs = [
    Tab(text: "关注的新作"),
    Tab(text: "大家的新作"),
    Tab(text: "好P友的新作"),
  ];

  @override
  Widget build(BuildContext context) {
    return ExtendedNestedScrollView(
      onlyOneScrollInBody: true,
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            pinned: false,
            floating: true,
            snap: true,
            title: Container(
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
                icon: Text("?"),
                onPressed: () {},
                tooltip: "?",
              ),
            ],
          ),
        ];
      },
      body: Container(
        child: TabBarView(
          controller: _tabController,
          children: [
            // 关注的新作
            IllustGirdTabPage(
              physics: BouncingScrollPhysics(),
              onRefresh: () async {
                return await ApiNewArtWork().getFollowsNewIllusts(ApiNewArtWork.restrict_all);
              },
              onLazyLoad: (String nextUrl) async {
                var result = await ApiBase().getNextUrlData(nextUrl: nextUrl);
                return CommonIllustList.fromJson(result);
              },
            ),
            // 大家的新作
            IllustGirdTabPage(
              physics: BouncingScrollPhysics(),
              onRefresh: () async {
                return await ApiNewArtWork().getEveryOnesNewIllusts(ApiNewArtWork.type_illust);
              },
              onLazyLoad: (String nextUrl) async {
                var result = await ApiBase().getNextUrlData(nextUrl: nextUrl);
                return CommonIllustList.fromJson(result);
              },
            ),
            // 好P友的新作
            IllustGirdTabPage(
              physics: BouncingScrollPhysics(),
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
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: _tabs.length, vsync: this);
  }
}
