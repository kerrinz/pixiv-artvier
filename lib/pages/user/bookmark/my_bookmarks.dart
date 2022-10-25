import 'package:dio/dio.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pixgem/common_provider/illusts_provider.dart';
import 'package:pixgem/common_provider/loading_request_provider.dart';
import 'package:pixgem/common_provider/novels_provider.dart';
import 'package:pixgem/common_provider/works_provider.dart';
import 'package:pixgem/component/base_provider_widget.dart';
import 'package:pixgem/component/bottom_sheet/bottom_sheets.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/pages/artwork/tab_page/illusts_grid_tabpage.dart';
import 'package:pixgem/l10n/localization_intl.dart';
import 'package:pixgem/api_app/api_user.dart';
import 'package:pixgem/pages/novel/novel_list_tabpage.dart';
import 'package:pixgem/pages/user/bookmark/bookmark_filter_model.dart';
import 'package:pixgem/pages/user/bookmark/bookmark_filter_sheets.dart';
import 'package:pixgem/pages/user/bookmark/bookmark_tags_provider.dart';
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

  /// 插画列表数据管理
  final IllustListProvider illustsProvider = IllustListProvider();

  /// 小说列表数据管理
  final NovelListProvider novelsProvider = NovelListProvider();

  /// 标签的状态管理
  final BookmarkTagsProvider _tagsProvider = BookmarkTagsProvider();

  /// 插画（与漫画）的筛选条件
  final FilterModel illustFilterModel = FilterModel(CONSTANTS.restrict_public, null);

  /// 小说的筛选条件
  final FilterModel novelFilterModel = FilterModel(CONSTANTS.restrict_public, null);

  /// 列表请求所用
  CancelToken _cancelToken = CancelToken();

  /// 筛选条件获取Tag所用
  CancelToken _tagsCancelToken = CancelToken();

  /// 当前页面所处的作品类型
  WorksType get currentWorkType => _tabController.index == 0 ? WorksType.illust : WorksType.novel;

  /// 当前作品类型的FilterModel
  FilterModel get currentFilterModel => currentWorkType == WorksType.illust ? illustFilterModel : novelFilterModel;

  /// 另一个作品类型的FilterModel
  FilterModel get anotherFilterModel => currentWorkType == WorksType.illust ? novelFilterModel : illustFilterModel;

  /// 跟踪当前是否正在显示筛选弹窗
  bool isShowFilter = false;

  @override
  void initState() {
    super.initState();
    // 未登录拦截
    if (widget.userId == null) {
      Navigator.pushNamed(context, RouteNames.wizard.name);
    } else {
      _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
      _tabController.addListener(() {
        _tagsProvider.setWorksType(currentWorkType);
        // 由于当前显示了筛选弹窗，为它更新数据。视图上的restrict还是另一边的，故继续使用另一边的model.restrict
        if (isShowFilter) {
          requestBookmarkTags(currentWorkType, anotherFilterModel.restrict);
        }
      });
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
              Tab(
                child: Text("${LocalizationIntl.of(context).illustrations} • ${LocalizationIntl.of(context).manga}"),
              ),
              Tab(text: LocalizationIntl.of(context).novels),
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
                    ProviderWidget<BookmarkTagsProvider>(
                      model: _tagsProvider,
                      builder: (buttonContext, provider, child) {
                        return CupertinoButton(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          minSize: tabBar.preferredSize.height,
                          onPressed: () async {
                            requestBookmarkTags(currentWorkType, currentFilterModel.restrict);
                            isShowFilter = true;
                            FilterModel? model = await BottomSheets.showCustomBottomSheet<FilterModel>(
                              context: context,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              exitOnClickModal: false,
                              child: BookmarkFilterSheet(
                                cacheModel: currentFilterModel.copyWith(),
                                currentWorkType: currentWorkType,
                                requestBookmarkTags: (WorksType worksType, String restrict) {
                                  requestBookmarkTags(worksType, restrict);
                                },
                                tagsProvider: _tagsProvider,
                              ),
                            );
                            isShowFilter = false;
                            // 取消掉标签请求
                            if (!_tagsCancelToken.isCancelled) _tagsCancelToken.cancel();
                            if (model != null) {
                              // 确定筛选后触发
                              changeFilter(currentWorkType, model);
                              (context as Element).markNeedsBuild();
                            }
                          },
                          child: Row(
                            children: [
                              Text(
                                  currentFilterModel.restrict == CONSTANTS.restrict_public
                                      ? LocalizationIntl.of(context).public
                                      : LocalizationIntl.of(context).private,
                                  style: const TextStyle(fontSize: 14)),
                              const Icon(Icons.filter_alt_outlined, size: 18),
                            ],
                          ),
                        );
                      },
                    ),
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
                return await ApiUser().getUserBookmarksIllust(
                  userId: widget.userId!,
                  restrict: illustFilterModel.restrict,
                  tag: illustFilterModel.tag,
                  cancelToken: cancelToken,
                );
              },
            ),
            NovelListTabPage(
              novelsProvider: novelsProvider,
              onRequest: (CancelToken cancelToken) async {
                return await ApiUser().getUserBookmarksNovel(
                  userId: widget.userId!,
                  restrict: novelFilterModel.restrict,
                  tag: novelFilterModel.tag,
                  cancelToken: cancelToken,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// 获取收藏标签
  void requestBookmarkTags(WorksType worksType, String restrict) {
    assert(worksType == WorksType.illust || worksType == WorksType.novel);
    assert(restrict == CONSTANTS.restrict_public || restrict == CONSTANTS.restrict_private);
    _tagsProvider.seLoadStatus(LoadingStatus.loading);
    if (!_tagsCancelToken.isCancelled) _tagsCancelToken.cancel();
    _tagsCancelToken = CancelToken();
    switch (worksType) {
      case WorksType.illust:
        ApiUser().getBookmarkTags(WorksType.illust, restrict: restrict, cancelToken: _tagsCancelToken).then((value) {
          _tagsProvider.resetIllustTags(value.bookmarkTags ?? [], value.nextUrl);
        }).catchError((error) {
          if (error is DioError && error.type == DioErrorType.cancel) return;
          _tagsProvider.seLoadStatus(LoadingStatus.failed);
        });
        break;
      case WorksType.novel:
      default:
        ApiUser().getBookmarkTags(WorksType.novel, restrict: restrict, cancelToken: _tagsCancelToken).then((value) {
          _tagsProvider.resetNovelTags(value.bookmarkTags ?? [], value.nextUrl);
        }).catchError((error) {
          if (error is DioError && error.type == DioErrorType.cancel) return;
          _tagsProvider.seLoadStatus(LoadingStatus.failed);
        });
    }
  }

  /// 在筛选弹窗中点击确定后触发
  void changeFilter(WorksType worksType, FilterModel model) {
    assert(worksType == WorksType.illust || worksType == WorksType.novel);
    if (!_cancelToken.isCancelled) _cancelToken.cancel();
    _cancelToken = CancelToken();
    switch (worksType) {
      case WorksType.illust:
        illustsProvider.setLoadingStatus(LoadingStatus.loading);
        illustFilterModel.update(model.restrict, model.tag);
        ApiUser()
            .getUserBookmarksIllust(
              userId: widget.userId!,
              restrict: model.restrict,
              tag: model.tag,
              cancelToken: _cancelToken,
            )
            .then((value) => illustsProvider.resetIllusts(value.illusts, value.nextUrl))
            .catchError((error) {
          if (error is DioError && error.type == DioErrorType.cancel) return;
          illustsProvider.setLoadingStatus(LoadingStatus.failed);
        });
        break;
      case WorksType.novel:
      default:
        novelsProvider.setLoadingStatus(LoadingStatus.loading);
        novelFilterModel.update(model.restrict, model.tag);
        ApiUser()
            .getUserBookmarksNovel(
              userId: widget.userId!,
              restrict: model.restrict,
              tag: model.tag,
              cancelToken: _cancelToken,
            )
            .then((value) => novelsProvider.resetNovels(value.novels, value.nextUrl))
            .catchError((error) {
          if (error is DioError && error.type == DioErrorType.cancel) return;
          novelsProvider.setLoadingStatus(LoadingStatus.failed);
        });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    if (!_cancelToken.isCancelled) _cancelToken.cancel();
    if (!_tagsCancelToken.isCancelled) _cancelToken.cancel();
    super.dispose();
  }
}
