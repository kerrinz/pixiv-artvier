import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pixgem/api_app/api_illusts.dart';
import 'package:pixgem/api_app/api_novels.dart';
import 'package:pixgem/api_app/api_user.dart';
import 'package:pixgem/common_provider/lazyload_status_provider.dart';
import 'package:pixgem/common_provider/loading_request_provider.dart';
import 'package:pixgem/common_provider/works_provider.dart';
import 'package:pixgem/component/filter/stateful_flow_filter.dart';
import 'package:pixgem/component/loading/request_loading.dart';
import 'package:pixgem/component/scroll_list/illust_waterfall_grid.dart';
import 'package:pixgem/component/sliver_delegates/widget_delegate.dart';
import 'package:pixgem/component/scroll_list/novel_list.dart';
import 'package:pixgem/l10n/localization_intl.dart';
import 'package:pixgem/model_response/illusts/common_illust_list.dart';
import 'package:pixgem/model_response/novels/common_novel_list.dart';
import 'package:provider/provider.dart';

class WorksTabPage extends StatefulWidget {
  final String userId;

  const WorksTabPage({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => WorksTabPageState();
}

class WorksTabPageState extends State<WorksTabPage> with AutomaticKeepAliveClientMixin {
  /// 列表数据统一管理
  final WorksProvider _worksProvider = WorksProvider();

  /// 管理懒加载的状态
  final LazyloadStatusProvider _lazyloadProvider = LazyloadStatusProvider();

  String? nextUrl; // 下一页的地址

  /// 用于取消当前还未完成的请求（当然，同时只能存在一个请求）
  CancelToken _cancelToken = CancelToken();

  /// 是否已经在懒加载请求中（用于避免重复请求同个懒加载数据）
  bool isLazyloadRequesting = false;

  @override
  void initState() {
    super.initState();
    requestIllusts(WorksType.illust).then((value) {
      _worksProvider.resetIllust(value.illusts);
      setNextUrl(value.nextUrl);
    }).catchError((error) {
      // 非取消才能显示Failed
      if (error is DioError && error.type == DioErrorType.cancel) return;
      _worksProvider.setLoadingStatus(LoadingStatus.failed);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        switch (_worksProvider.currentWorksType) {
          case WorksType.illust:
            CommonIllustList value = await requestIllusts(WorksType.illust);
            _worksProvider.resetIllust(value.illusts);
            nextUrl = value.nextUrl;
            break;
          case WorksType.manga:
            CommonIllustList value = await requestIllusts(WorksType.manga);
            _worksProvider.resetManga(value.illusts);
            nextUrl = value.nextUrl;
            break;
          case WorksType.novel:
            CommonNovelList value = await requestNovels();
            _worksProvider.resetNovel(value.novels);
            nextUrl = value.nextUrl;
            break;
          case WorksType.mangaSeries:
        }
      },
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            floating: true,
            delegate: SliverWidgetPersistentHeaderDelegate(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: StatefulTextFlowFilter(
                  filterMode: FilterMode.single,
                  selectedBackground: Theme.of(context).colorScheme.secondary,
                  unselectedBackground: Theme.of(context).colorScheme.surface,
                  selectedTextStyle: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSecondary),
                  unselectedTextStyle: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.secondary),
                  textPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  textBorderRadius: const BorderRadius.all(Radius.circular(20)),
                  spacing: 8,
                  onTap: (bool isChanged, int tapIndex, Set<int> afterIndexes) {
                    if (isChanged) {
                      if (!_cancelToken.isCancelled) _cancelToken.cancel();
                      _worksProvider.setLoadingStatus(LoadingStatus.loading);
                      switch (tapIndex) {
                        case 0:
                          _worksProvider.setCurrentWorksType(WorksType.illust);
                          requestIllusts(WorksType.illust).then((value) {
                            _worksProvider.resetIllust(value.illusts);
                            setNextUrl(value.nextUrl);
                          }).catchError((error) {
                            // 非取消才能显示Failed
                            if (error is DioError && error.type == DioErrorType.cancel) return;
                            _worksProvider.setLoadingStatus(LoadingStatus.failed);
                          });
                          break;
                        case 1:
                          _worksProvider.setCurrentWorksType(WorksType.manga);
                          requestIllusts(WorksType.manga).then((value) {
                            _worksProvider.resetManga(value.illusts);
                            setNextUrl(value.nextUrl);
                          }).catchError((error) {
                            // 非取消才能显示Failed
                            if (error is DioError && error.type == DioErrorType.cancel) return;
                            _worksProvider.setLoadingStatus(LoadingStatus.failed);
                          });
                          break;
                        case 2:
                          _worksProvider.setCurrentWorksType(WorksType.novel);
                          requestNovels().then((value) {
                            _worksProvider.resetNovel(value.novels);
                            setNextUrl(value.nextUrl);
                          }).catchError((error) {
                            // 非取消才能显示Failed
                            if (error is DioError && error.type == DioErrorType.cancel) return;
                            _worksProvider.setLoadingStatus(LoadingStatus.failed);
                          });
                      }
                      _lazyloadProvider.setLazyloadStatus(LazyloadStatus.loading);
                    }
                  },
                  texts: [
                    LocalizationIntl.of(context).illust,
                    LocalizationIntl.of(context).manga,
                    LocalizationIntl.of(context).novels
                  ],
                ),
              ),
              maxHeight: 46,
              minHeight: 46,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            sliver: MultiProvider(
              providers: [
                ChangeNotifierProvider<WorksProvider>.value(value: _worksProvider),
                ChangeNotifierProvider<LazyloadStatusProvider>.value(value: _lazyloadProvider),
              ],
              child: Consumer<WorksProvider>(
                builder: (BuildContext context, WorksProvider provider, Widget? child) {
                  if (provider.loadingStatus == LoadingStatus.loading) {
                    return const SliverToBoxAdapter(child: RequestLoading());
                  } else if (provider.loadingStatus == LoadingStatus.failed) {
                    return SliverToBoxAdapter(
                      child: RequestLoadingFailed(onRetry: () {
                        _worksProvider.setLoadingStatus(LoadingStatus.loading);
                        requestIllusts(WorksType.illust).then((value) {
                          _worksProvider.resetIllust(value.illusts);
                          setNextUrl(value.nextUrl);
                        }).catchError((error) {
                          // 非取消才能显示Failed
                          if (error is DioError && error.type == DioErrorType.cancel) return;
                          _worksProvider.setLoadingStatus(LoadingStatus.failed);
                        });
                      }),
                    );
                  }
                  // LoadingStatus.succeed
                  switch (provider.currentWorksType) {
                    case WorksType.illust:
                      if (provider.illustList.isEmpty) return _buildEmptyPrompt(context);
                      return IllustWaterfallGrid.sliver(
                        artworkList: provider.illustList,
                        hasMore: nextUrl != null,
                        onLazyLoad: () async {
                          if (isLazyloadRequesting) return; // 已经在请求了，不要重复请求
                          if (nextUrl != null) defaultIllustLazyload(WorksType.illust);
                        },
                      );
                    case WorksType.mangaSeries:
                    case WorksType.manga:
                      if (provider.mangaList.isEmpty) return _buildEmptyPrompt(context);
                      return IllustWaterfallGrid.sliver(
                        artworkList: provider.mangaList,
                        hasMore: nextUrl != null,
                        onLazyLoad: () {
                          if (isLazyloadRequesting) return; // 已经在请求了，不要重复请求
                          if (nextUrl != null) defaultIllustLazyload(WorksType.manga);
                        },
                      );
                    case WorksType.novel:
                      if (provider.novelList.isEmpty) return _buildEmptyPrompt(context);
                      return NovelList.sliver(
                        novelList: provider.novelList,
                        hasMore: nextUrl != null,
                        onLazyLoad: () {
                          if (isLazyloadRequesting) return; // 已经在请求了，不要重复请求
                          if (nextUrl != null) defaultNovelLazyload();
                        },
                      );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 列表为空时的显示内容
  Widget _buildEmptyPrompt(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Text(
          LocalizationIntl.of(context).emptyWorksPlaceholder,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  /// 默认的懒加载（插画与漫画通用），确保nextUrl不为空再调用！
  void defaultIllustLazyload(WorksType worksType) {
    assert(worksType == WorksType.illust || worksType == WorksType.manga);
    isLazyloadRequesting = true; // 标记正在懒加载中
    _lazyloadProvider.setLazyloadStatus(LazyloadStatus.loading);
    _cancelToken = CancelToken();
    ApiIllusts().getNextIllusts(nextUrl!, cancelToken: _cancelToken).then((value) {
      worksType == WorksType.illust
          ? _worksProvider.appendIllusts(value.illusts)
          : _worksProvider.appendManga(value.illusts);
      setNextUrl(value.nextUrl);
    }).catchError((_) {
      if (!_cancelToken.isCancelled) {
        // 非取消才能显示Failed
        _lazyloadProvider.setLazyloadStatus(LazyloadStatus.failed);
      }
    }).whenComplete(() => isLazyloadRequesting = false); // 最后取消标记懒加载中
  }

  /// 默认的懒加载（小说），确保nextUrl不为空再调用！
  void defaultNovelLazyload() async {
    _cancelToken = CancelToken();
    isLazyloadRequesting = true; // 标记正在懒加载中
    _lazyloadProvider.setLazyloadStatus(LazyloadStatus.loading);
    _cancelToken = CancelToken();
    ApiNovels().getNextNovels(nextUrl!, cancelToken: _cancelToken).then((value) {
      _worksProvider.appendNovels(value.novels);
      setNextUrl(value.nextUrl);
    }).catchError((_) {
      if (!_cancelToken.isCancelled) {
        // 非取消才能显示Failed
        _lazyloadProvider.setLazyloadStatus(LazyloadStatus.failed);
      }
    }).whenComplete(() => isLazyloadRequesting = false); // 最后取消标记懒加载中
  }

  /// 加载插画数据（漫画也适用），成功和失败的后续操作需另行处理
  Future<CommonIllustList> requestIllusts(WorksType worksType) async {
    assert(worksType == WorksType.illust || worksType == WorksType.manga);
    resetLazyload();
    _cancelToken = CancelToken();
    return await ApiUser().getUserIllusts(
      userId: widget.userId,
      worksType: _worksProvider.currentWorksType,
      cancelToken: _cancelToken,
    );
  }

  /// 加载小说数据，成功和失败的后续操作需另行处理
  Future<CommonNovelList> requestNovels() async {
    resetLazyload();
    _cancelToken = CancelToken();
    return await ApiUser().getUserNovels(
      userId: widget.userId,
      cancelToken: _cancelToken,
    );
  }

  /// 预置下一页的地址，同时更新[LazyloadStatusProvider]
  void setNextUrl(String? url) {
    nextUrl = url;
    // 没有更多了
    // if (url == null) _lazyloadProvider.setLazyloadStatus(LazyloadStatus.noMore);
  }

  /// 重置懒加载的相关数据
  void resetLazyload() {
    if (!_cancelToken.isCancelled) _cancelToken.cancel();
    isLazyloadRequesting = false;
    _lazyloadProvider.setLazyloadStatus(LazyloadStatus.loading);
  }

  @override
  void deactivate() {
    if (!_cancelToken.isCancelled) _cancelToken.cancel();
    super.deactivate();
  }

  @override
  bool get wantKeepAlive => true;
}
