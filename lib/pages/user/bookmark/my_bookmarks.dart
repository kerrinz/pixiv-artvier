import 'package:dio/dio.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:pixgem/pages/illust/tab_page/illusts_grid_tabpage.dart';
import 'package:pixgem/component/sliver_delegates/tab_bar_delegate.dart';
import 'package:pixgem/l10n/localization_intl.dart';
import 'package:pixgem/api_app/api_user.dart';
import 'package:pixgem/pages/novel/novel_list_tabpage.dart';
import 'package:pixgem/routes.dart';

class MyBookmarksPage extends StatefulWidget {
  late final String? userId;

  MyBookmarksPage(Object? arguments, {Key? key}) : super(key: key) {
    userId = arguments as String?;
  }

  @override
  State<StatefulWidget> createState() => _MyBookmarksState();
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
        pinnedHeaderSliverHeightBuilder: () {
          return MediaQuery.of(context).padding.top + 48;
        },
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: true,
              title: const Text('我的收藏'),
              backgroundColor: Theme.of(context).colorScheme.primary,
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
                  unselectedLabelStyle: const TextStyle(fontSize: 13),
                  labelPadding: const EdgeInsets.symmetric(horizontal: 13.0),
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
            IllustGridTabPage(
              onRequest: (CancelToken cancelToken) async {
                return await ApiUser().getUserBookmarksIllust(userId: widget.userId!, cancelToken: cancelToken);
              },
            ),
            NovelListTabPage(
              onRequest: (CancelToken cancelToken) async {
                return await ApiUser().getUserBookmarksNovel(userId: widget.userId!, cancelToken: cancelToken);
              },
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
