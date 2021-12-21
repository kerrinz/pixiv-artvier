import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/model_response/illusts/common_illust_list.dart';
import 'package:pixgem/pages/artworks/illusts_grid_page.dart';
import 'package:pixgem/request/api_base.dart';
import 'package:pixgem/request/api_user.dart';

class MyBookmarksPage extends StatefulWidget {
  late final String? userId;

  MyBookmarksPage(Object? arguments, {Key? key}) : super(key: key) {
    userId = arguments as String?;
  }

  @override
  State<StatefulWidget> createState() {
    return _MyBookmarksState();
  }
}

class _MyBookmarksState extends State<MyBookmarksPage> with TickerProviderStateMixin {
  late TabController _tabController;
  final List<Tab> _tabs = [
    const Tab(text: "插画、漫画"),
    const Tab(text: "小说"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExtendedNestedScrollView(
        floatHeaderSlivers: true,
        onlyOneScrollInBody: true,
        body: TabBarView(
          controller: _tabController,
          children: [
            IllustGridTabPage(
              physics: const BouncingScrollPhysics(),
              onRefresh: () async {
                return await ApiUser().getUserBookmarksIllust(userId: widget.userId!).catchError((onError) {
                  Fluttertoast.showToast(msg: "获取数据失败$onError", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
                });
              },
              onLazyLoad: (String nextUrl) async {
                var result = await ApiBase().getNextUrlData(nextUrl: nextUrl);
                return CommonIllustList.fromJson(result);
              },
            ),
            Container(
              child: const Text("小说"),
              alignment: Alignment.center,
            ),
          ],
        ),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: const Text('我的收藏'),
              pinned: false,
              floating: true,
              snap: true,
              bottom: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                controller: _tabController,
                isScrollable: false,
                tabs: _tabs,
              ),
            ),
          ];
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // 未登录拦截
    if (widget.userId == null) {
      Navigator.pushNamed(context, "login_wizard");
    }
    _tabController = TabController(initialIndex: 0, length: _tabs.length, vsync: this);
  }
}

