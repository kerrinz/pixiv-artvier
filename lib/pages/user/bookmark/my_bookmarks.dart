import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/component/illusts_grid_tabpage.dart';
import 'package:pixgem/component/sliver_delegates/tab_bar_delegate.dart';
import 'package:pixgem/l10n/localization_intl.dart';
import 'package:pixgem/model_response/illusts/common_illust_list.dart';
import 'package:pixgem/api_app/api_base.dart';
import 'package:pixgem/api_app/api_user.dart';
import 'package:pixgem/routes.dart';

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

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    // 未登录拦截
    if (widget.userId == null) {
      Navigator.pushNamed(context, RouteNames.wizard.name);
    }
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
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
              title: const Text('我的收藏'),
              pinned: true,
              floating: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.keyboard_arrow_up),
                  onPressed: () {
                    _scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.decelerate,
                    );
                  },
                  tooltip: "回到顶部",
                ),
              ],
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverTabBarPersistentHeaderDelegate(
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
                child: TabBar(
                  labelColor: Theme.of(context).colorScheme.onPrimary,
                  indicatorColor: Theme.of(context).colorScheme.onPrimary,
                  unselectedLabelColor: Theme.of(context).colorScheme.onPrimary.withAlpha(175),
                  labelStyle: const TextStyle(fontSize: 14),
                  unselectedLabelStyle: const TextStyle(fontSize: 14),
                  labelPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                  indicatorSize: TabBarIndicatorSize.label,
                  controller: _tabController,
                  isScrollable: true,
                  tabs: [
                    Tab(text: "${LocalizationIntl.of(context).illustrations} • ${LocalizationIntl.of(context).manga}"),
                    Tab(text: LocalizationIntl.of(context).novels),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: IllustGridTabPage(
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
            ),
            Container(
              child: const Text("小说"),
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
