import 'package:dio/dio.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:pixgem/common_provider/illusts_provider.dart';
import 'package:pixgem/common_provider/novels_provider.dart';
import 'package:pixgem/common_provider/works_provider.dart';
import 'package:pixgem/pages/artwork/tab_page/illusts_grid_tabpage.dart';
import 'package:pixgem/l10n/localization_intl.dart';
import 'package:pixgem/api_app/api_user.dart';
import 'package:pixgem/pages/novel/novel_list_tabpage.dart';
import 'package:pixgem/routes.dart';
import 'package:pixgem/store/global.dart';

class MyWorksPage extends StatefulWidget {
  const MyWorksPage(Object? arguments, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyBookmarksState();
}

class _MyBookmarksState extends State<MyWorksPage> with TickerProviderStateMixin {
  String? get userId => GlobalStore.currentAccount?.user.id;

  late TabController _tabController;

  late ScrollController _scrollController;

  /// 插画列表数据管理
  final IllustListProvider illustsProvider = IllustListProvider();

  /// 插画列表数据管理
  final IllustListProvider mangaProvider = IllustListProvider();

  /// 小说列表数据管理
  final NovelListProvider novelsProvider = NovelListProvider();

  /// 列表请求所用
  late final List<CancelToken> _cancelTokens;

  /// 当前页面所处的作品类型
  WorksType get currentWorkType => _tabController.index == 0 ? WorksType.illust : WorksType.novel;

  @override
  void initState() {
    super.initState();
    // 未登录拦截
    if (userId == null) {
      Navigator.pushNamed(context, RouteNames.wizard.name);
    } else {
      _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
       _cancelTokens = [CancelToken(), CancelToken(), CancelToken()];
    }
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
              Tab(text: LocalizationIntl.of(context).illustrations),
              Tab(text: LocalizationIntl.of(context).manga),
              Tab(text: LocalizationIntl.of(context).novels),
            ],
          );
          return [
            SliverAppBar(
              pinned: true,
              floating: true,
              title: const Text('我的作品'),
              bottom: PreferredSize(
                preferredSize: tabBar.preferredSize,
                child: Row(
                  children: [
                    tabBar,
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
              illustsProvider: illustsProvider,
              onRequest: (CancelToken cancelToken) async {
                return await ApiUser().getUserIllusts(
                  userId: userId!,
                  worksType: WorksType.illust,
                  cancelToken: cancelToken,
                );
              },
            ),
            IllustGridTabPage(
              illustsProvider: mangaProvider,
              onRequest: (CancelToken cancelToken) async {
                return await ApiUser().getUserIllusts(
                  userId: userId!,
                  worksType: WorksType.manga,
                  cancelToken: cancelToken,
                );
              },
            ),
            NovelListTabPage(
              novelsProvider: novelsProvider,
              onRequest: (CancelToken cancelToken) async {
                return await ApiUser().getUserNovels(
                  userId: userId!,
                  cancelToken: cancelToken,
                );
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
    for (var element in _cancelTokens) { 
      if (!element.isCancelled) element.cancel();
    }
    super.dispose();
  }
}
