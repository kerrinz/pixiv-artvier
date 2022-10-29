import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pixgem/common_provider/lazyload_status_provider.dart';
import 'package:pixgem/common_provider/loading_request_provider.dart';
import 'package:pixgem/component/bottom_sheet/bottom_sheets.dart';
import 'package:pixgem/component/filter/stateless_flow_filter.dart';
import 'package:pixgem/component/loading/request_loading.dart';
import 'package:pixgem/component/scroll_list/illust_waterfall_grid.dart';
import 'package:pixgem/component/scroll_list/novel_list.dart';
import 'package:pixgem/component/scroll_list/user_list_vertical.dart';
import 'package:pixgem/component/sliver_delegates/widget_delegate.dart';
import 'package:pixgem/l10n/localization_intl.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/model_response/illusts/illusts_search_result.dart';
import 'package:pixgem/api_app/api_serach.dart';
import 'package:pixgem/model_response/novels/common_novel.dart';
import 'package:pixgem/model_response/novels/common_novel_list.dart';
import 'package:pixgem/model_response/user/common_user_previews_list.dart';
import 'package:pixgem/model_response/user/common_user_previews.dart';
import 'package:pixgem/pages/search/result/seach_filter_arguments.dart';
import 'package:pixgem/pages/search/result/seach_filter_bottom_sheet.dart';
import 'package:pixgem/pages/search/result/search_result_provider.dart';
import 'package:provider/provider.dart';

class SearchResultPage extends StatefulWidget {
  late final String label; // 搜索文本内容

  SearchResultPage(Object arguments, {Key? key}) : super(key: key) {
    label = arguments as String;
  }

  @override
  State<StatefulWidget> createState() => SearchResultPageState();
}

class SearchResultPageState extends State<SearchResultPage> {
  late TextEditingController _textController;

  final FocusNode _focusNode = FocusNode();

  final LazyloadStatusProvider _lazyloadProvider = LazyloadStatusProvider();

  final SearchResultProvider _resultProvider = SearchResultProvider();

  CancelToken _cancelToken = CancelToken();

  /// 是否已经在请求懒加载中，防止重复请求
  bool _isLazyloading = false;

  /// 筛选条件
  SearchFilterArguments _filterAguments = SearchFilterArguments();

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.label);
    onSearch();
  }

  @override
  Widget build(BuildContext context) {
    LocalizationIntl intl = LocalizationIntl.of(context);
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _resultProvider),
        ChangeNotifierProvider.value(value: _lazyloadProvider),
      ],
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: Container(
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.15), borderRadius: const BorderRadius.all(Radius.circular(8.0))),
            child: TextField(
              controller: _textController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              autofocus: false,
              focusNode: _focusNode,
              style: const TextStyle(fontSize: 14),
              decoration: const InputDecoration(
                hintText: "搜索...",
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isCollapsed: true, // 高度包裹，不会存在默认高度
              ),
              onSubmitted: (value) async {
                _resultProvider.setLoadingStatus(LoadingStatus.loading);
                // 提交搜索
                await onSearch();
              },
            ),
          ),
          actions: [
            Center(
              child: Selector(
                selector: ((_, SearchResultProvider provider) {
                  return provider.searchType;
                }),
                builder: ((_, SearchType type, __) {
                  return IconButton(
                    icon: const Icon(Icons.filter_alt_outlined),
                    onPressed: type == SearchType.users
                        ? null
                        : () async {
                            _focusNode.unfocus();
                            SearchFilterArguments? args =
                                await BottomSheets.showCustomBottomSheet<SearchFilterArguments?>(
                              context: context,
                              child: SearchFilterBottomSheetWidget(arguments: _filterAguments),
                            );
                            if (args == null) return;
                            _filterAguments = args;
                            _resultProvider.setLoadingStatus(LoadingStatus.loading);
                            onSearch(
                              label: args.minCollectCount == null
                                  ? _textController.text
                                  : "${_textController.text} ${args.minCollectCount!}users入り",
                            );
                          },
                    tooltip: "more",
                  );
                }),
              ),
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: SliverWidgetPersistentHeaderDelegate(
                maxHeight: 50,
                minHeight: 50,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  color: colorScheme.surface,
                  child: Builder(builder: (filterContext) {
                    List<SearchType> types = [SearchType.artworks, SearchType.novels, SearchType.users];
                    return StatelessTextFlowFilter(
                      initialIndexes: {types.indexOf(_resultProvider.searchType)},
                      alignment: WrapAlignment.spaceAround,
                      selectedDecoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                      ),
                      texts: [
                        "${LocalizationIntl.of(context).illust}/${LocalizationIntl.of(context).manga}",
                        intl.novels,
                        intl.users,
                      ],
                      onTap: (int tapIndex) {
                        handleChangeSearchType(types[tapIndex]);
                        (filterContext as Element).markNeedsBuild();
                      },
                    );
                  }),
                ),
              ),
            ),
            Consumer(
              builder: (BuildContext context, SearchResultProvider provider, Widget? child) {
                switch (provider.loadingStatus) {
                  case LoadingStatus.loading:
                    return const SliverFillRemaining(hasScrollBody: false, child: Center(child: RequestLoading()));
                  case LoadingStatus.failed:
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: RequestLoadingFailed(
                        onRetry: () {
                          onSearch();
                        },
                      ),
                    );
                  case LoadingStatus.success:
                }
                if (_resultProvider.isEmpty) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text("搜索结果为空", style: TextStyle(fontSize: 18)),
                    ),
                  );
                }
                switch (provider.searchType) {
                  case SearchType.artworks:
                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      sliver: IllustWaterfallGrid.sliver(
                        artworkList: _resultProvider.artworkList,
                        hasMore: _resultProvider.nextUrl != null,
                        onLazyLoad: () => onLazyload(),
                      ),
                    );
                  case SearchType.novels:
                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      sliver: NovelList.sliver(
                        novelList: _resultProvider.novelList,
                        hasMore: _resultProvider.nextUrl != null,
                        onLazyLoad: () => onLazyload(),
                      ),
                    );
                  case SearchType.users:
                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      sliver: UserVerticalList.sliver(
                        userList: _resultProvider.userList,
                        mainAxisSpacing: 12,
                        hasMore: _resultProvider.nextUrl != null,
                        onLazyLoad: () => onLazyload(),
                      ),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  onSearch({String? label}) {
    _resultProvider.setLoadingStatus(LoadingStatus.loading);
    requestSearch(_resultProvider.searchType, label: label)
        .then((value) => _resultProvider.setLoadingStatus(LoadingStatus.success))
        .catchError((err) {
      if (err is DioError && err.type == DioErrorType.cancel) return;
      _resultProvider.setLoadingStatus(LoadingStatus.failed);
    });
  }

  /// 懒加载事件
  void onLazyload() {
    if (_isLazyloading || _resultProvider.nextUrl == null) return;
    _isLazyloading = true;
    if (!_cancelToken.isCancelled) _cancelToken.cancel();
    _cancelToken = CancelToken();
    requestLazyload(_resultProvider.searchType).catchError((err) {
      if (err is DioError && err.type == DioErrorType.cancel) _lazyloadProvider.setLazyloadStatus(LazyloadStatus.failed);
    }).whenComplete(() => _isLazyloading = false);
  }

  /// 获取插画·漫画作品
  Future requestSearch(SearchType type, {String? label}) async {
    if (!_cancelToken.isCancelled) _cancelToken.cancel();
    _cancelToken = CancelToken();
    switch (type) {
      case SearchType.artworks:
        var result = await ApiSearch().searchArtworks(label ?? _textController.value.text, cancelToken: _cancelToken);
        _resultProvider.resetList<CommonIllust>(result.illusts, result.nextUrl);
        break;
      case SearchType.novels:
        var result = await ApiSearch().searcNovels(label ?? _textController.value.text, cancelToken: _cancelToken);
        _resultProvider.resetList<CommonNovel>(result.novels, result.nextUrl);
        break;
      case SearchType.users:
        var result = await ApiSearch().searchUsers(label ?? _textController.value.text, cancelToken: _cancelToken);
        _resultProvider.resetList<CommonUserPreviews>(result.users, result.nextUrl);
        break;
    }
  }

  /// 请求懒加载
  Future requestLazyload(SearchType type) async {
    Map<String, dynamic> res =
        await ApiSearch().getNextUrlData(nextUrl: _resultProvider.nextUrl!, cancelToken: _cancelToken);
    switch (type) {
      case SearchType.artworks:
        IllustsSearchResult result = IllustsSearchResult.fromJson(res);
        _resultProvider.appendList<CommonIllust>(result.illusts, result.nextUrl);
        break;
      case SearchType.novels:
        CommonNovelList result = CommonNovelList.fromJson(res);
        _resultProvider.appendList<CommonNovel>(result.novels, result.nextUrl);
        break;
      case SearchType.users:
        CommonUserPreviewsList result = CommonUserPreviewsList.fromJson(res);
        _resultProvider.appendList<CommonUserPreviews>(result.users, result.nextUrl);
    }
  }

  /// 更换搜索类型
  void handleChangeSearchType(SearchType type) {
    _resultProvider.searchType = type;
    onSearch();
  }

  @override
  void dispose() {
    if (!_cancelToken.isCancelled) _cancelToken.cancel();
    _textController.dispose();
    super.dispose();
  }
}
