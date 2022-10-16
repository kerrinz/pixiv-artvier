import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/api_app/api_novels.dart';
import 'package:pixgem/common_provider/lazyload_status_provider.dart';
import 'package:pixgem/common_provider/loading_request_provider.dart';
import 'package:pixgem/common_provider/novels_provider.dart';
import 'package:pixgem/component/loading/request_loading.dart';
import 'package:pixgem/component/scroll_list/novel_list.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/l10n/localization_intl.dart';
import 'package:pixgem/model_response/novels/common_novel_list.dart';
import 'package:provider/provider.dart';

typedef NovelRequestCallback = Future<CommonNovelList> Function(CancelToken cancelToken);
typedef NovelLazyLoadCallback = Future<CommonNovelList> Function(String? nextUrl, CancelToken cancelToken);

/// 适用于放在TabView里的插画（或漫画）列表页面
///
/// 示例：
///  NovelListTabPage(
///    onRefresh: () async {
///      return await ApiNewArtWork().getFollowsNewNovels(ApiNewArtWork.restrict_all);
///    },
///  ),
///
class NovelListTabPage extends StatefulWidget {
  /// 首次请求数据的回调函数（刷新也需要该函数）
  final NovelRequestCallback onRequest;

  /// 懒加载回调函数，已内置了处理，可为空
  final NovelLazyLoadCallback? onLazyLoad;

  /// 列表为空时的展示组件
  final Widget? withoutNovelWidget;

  /// 滚动控制器
  final ScrollController? scrollController;

  /// 滚动物理效果
  final ScrollPhysics? physics;

  final EdgeInsets? padding;

  @override
  State<StatefulWidget> createState() => NovelListTabPageState();

  /// 适用于放在TabView里的插画列表页面
  const NovelListTabPage({
    Key? key,
    required this.onRequest,
    this.onLazyLoad,
    this.withoutNovelWidget,
    this.scrollController,
    this.physics,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
  }) : super(key: key);
}

class NovelListTabPageState extends State<NovelListTabPage> with AutomaticKeepAliveClientMixin {
  /// 列表数据管理
  final NovelListProvider _illustsProvider = NovelListProvider();

  /// 懒加载状态管理
  final LazyloadStatusProvider _lazyloadProvider = LazyloadStatusProvider();

  /// 下一页的地址
  String? nextUrl;

  /// 用于取消当前还未完成的请求
  CancelToken _cancelToken = CancelToken();

  /// 是否已经在懒加载请求中（用于避免重复请求同个懒加载数据）
  bool isLazyloadRequesting = false;

  @override
  void initState() {
    super.initState();
    widget.onRequest(_cancelToken).then((value) {
      _illustsProvider.resetNovels(value.novels);
      setNextUrl(value.nextUrl);
    }).catchError((error) {
      if (error is DioError && error.type == DioErrorType.cancel) return;
      _illustsProvider.setLoadingStatus(LoadingStatus.failed);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _illustsProvider),
        ChangeNotifierProvider.value(value: _lazyloadProvider),
      ],
      child: RefreshIndicator(
        onRefresh: () async {
          CommonNovelList value = await requestNovels(CONSTANTS.restrict_public).catchError((_) {
            Fluttertoast.showToast(
              msg: "Request failed!",
              toastLength: Toast.LENGTH_SHORT,
              fontSize: 14.0,
            );
          });
          _illustsProvider.resetNovels(value.novels);
          setNextUrl(value.nextUrl);
        },
        child: Consumer(
          builder: (context, NovelListProvider provider, Widget? child) {
            switch (provider.loadingStatus) {
              case LoadingStatus.loading:
                return const RequestLoading();
              case LoadingStatus.failed:
                return RequestLoadingFailed(
                  onRetry: () {
                    requestNovels(CONSTANTS.restrict_public).then((value) {
                      _illustsProvider.resetNovels(value.novels);
                      setNextUrl(value.nextUrl);
                    }).catchError((error) {
                      if (error is DioError && error.type == DioErrorType.cancel) return;
                      _illustsProvider.setLoadingStatus(LoadingStatus.failed);
                    });
                  },
                );
              default:
            }
            if (provider.list.isEmpty) {
              // 列表为空时展示
              return widget.withoutNovelWidget ?? _buildEmptyPrompt(context);
            }
            return NovelList(
              physics: widget.physics,
              padding: widget.padding,
              novelList: provider.list,
              onLazyLoad: () async {
                if (nextUrl == null) return;
                if (widget.onLazyLoad != null) {
                  // 自定义的懒加载
                  isLazyloadRequesting = true;
                  _lazyloadProvider.setLazyloadStatus(LazyloadStatus.loading);
                  _cancelToken = CancelToken();
                  CommonNovelList value = await widget.onLazyLoad!(nextUrl, _cancelToken).catchError((error) {
                    if (!_cancelToken.isCancelled) _lazyloadProvider.setLazyloadStatus(LazyloadStatus.failed);
                  }).whenComplete(() => isLazyloadRequesting = false);
                  _illustsProvider.resetNovels(value.novels);
                  setNextUrl(value.nextUrl);
                } else {
                  // 默认的懒加载
                  defaultNovelLazyload();
                }
              },
              scrollController: widget.scrollController,
            );
          },
        ),
      ),
    );
  }

  /// 列表为空时的显示内容
  Widget _buildEmptyPrompt(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Text(
              LocalizationIntl.of(context).emptyWorksPlaceholder,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }

  /// 默认的懒加载（插画与漫画通用），确保nextUrl不为空再调用！
  void defaultNovelLazyload() {
    isLazyloadRequesting = true; // 标记正在懒加载中
    _lazyloadProvider.setLazyloadStatus(LazyloadStatus.loading);
    _cancelToken = CancelToken();
    ApiNovels().getNextNovels(nextUrl!, cancelToken: _cancelToken).then((value) {
      _illustsProvider.appendNovels(value.novels);
      setNextUrl(value.nextUrl);
    }).catchError((_) {
      if (!_cancelToken.isCancelled) {
        // 非取消才能显示Failed
        _lazyloadProvider.setLazyloadStatus(LazyloadStatus.failed);
      }
    }).whenComplete(() => isLazyloadRequesting = false); // 最后取消标记懒加载中
  }

  /// 加载插画或漫画数据，成功和失败的后续操作需另行处理
  /// - [restrict] 过滤规则，参考[CONSTANTS.restrict_public]
  Future<CommonNovelList> requestNovels(String restrict) async {
    resetLazyload();
    _cancelToken = CancelToken();
    return widget.onRequest(_cancelToken);
  }

  /// 预置下一页的地址，同时更新[LazyloadStatusProvider]
  void setNextUrl(String? url) {
    nextUrl = url;
    // 没有更多了
    if (url == null) _lazyloadProvider.setLazyloadStatus(LazyloadStatus.noMore);
  }

  /// 重置懒加载的相关数据
  void resetLazyload() {
    if (!_cancelToken.isCancelled) _cancelToken.cancel();
    isLazyloadRequesting = false;
    _lazyloadProvider.setLazyloadStatus(LazyloadStatus.loading);
  }

  @override
  bool get wantKeepAlive => true;
}
