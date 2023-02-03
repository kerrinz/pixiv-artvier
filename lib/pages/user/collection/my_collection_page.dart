import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/base/base_page.dart';
import 'package:artvier/pages/user/collection/provider/filter_provider.dart';
import 'package:artvier/pages/user/collection/logic.dart';
import 'package:artvier/pages/user/collection/tabpage/artworks_tabpage.dart';
import 'package:artvier/pages/user/collection/tabpage/novels_tabpage.dart';

class MyBookmarksPage extends BaseStatefulPage {
  final String userId;

  const MyBookmarksPage(Object arguments, {Key? key})
      : userId = arguments as String,
        super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyCollectionsState();
}

class _MyCollectionsState extends BasePageState<MyBookmarksPage> with TickerProviderStateMixin, MyCollectionPageLogic {
  late TabController _tabController;

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    _tabController.addListener(() {
      //
    });
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
          TabBar tabBar = TabBar(
            labelPadding: const EdgeInsets.symmetric(horizontal: 12.0),
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            controller: _tabController,
            isScrollable: true,
            tabs: [
              Tab(
                child: Text("${i10n.illust} • ${i10n.manga}"),
              ),
              Tab(text: i10n.novels),
            ],
          );
          return [
            SliverAppBar(
              pinned: true,
              floating: true,
              title: const Text('我的收藏'),
              toolbarHeight: Theme.of(context).appBarTheme.toolbarHeight ?? kToolbarHeight,
              bottom: PreferredSize(
                preferredSize: tabBar.preferredSize,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: tabBar,
                    ),
                    // 筛选按钮
                    Consumer(builder: (_, ref, __) {
                      var filter = ref.watch(collectionsFilterProvider);
                      return CupertinoButton(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        minSize: tabBar.preferredSize.height,
                        onPressed: () => handlePressedFilter(),
                        child: Row(
                          children: [
                            Text(
                              filter.restrict == Restrict.public ? i10n.public : i10n.private,
                              style: const TextStyle(fontSize: 14),
                            ),
                            const Icon(Icons.filter_alt_outlined, size: 18),
                          ],
                        ),
                      );
                    })
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: const [
            MyCollectArtworksTabPage(),
            MyCollectNovelsTabPage(),
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
