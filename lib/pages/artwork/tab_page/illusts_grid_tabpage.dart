import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/api_app/api_illusts.dart';
import 'package:pixgem/common_provider/illusts_provider.dart';
import 'package:pixgem/common_provider/lazyload_status_provider.dart';
import 'package:pixgem/common_provider/loading_request_provider.dart';
import 'package:pixgem/component/loading/request_loading.dart';
import 'package:pixgem/component/scroll_list/illust_waterfall_grid.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/l10n/localization_intl.dart';
import 'package:pixgem/model_response/illusts/common_illust_list.dart';
import 'package:provider/provider.dart';

typedef IllustRequestCallback = Future<CommonIllustList> Function(CancelToken cancelToken);
typedef IllustLazyLoadCallback = Future<CommonIllustList> Function(String? nextUrl, CancelToken cancelToken);

/// 适用于放在TabView里的插画（或漫画）列表页面
///
/// 示例：
/// IllustGridTabPage(
///   illustsProvider: _illustsProvider,
///   onRequest: (CancelToken cancelToken) async {
///     return await ApiUser().getUserBookmarksIllust(
///       userId: widget.userId!,
///       restrict: illustFilterModel.restrict,
///       cancelToken: cancelToken,
///     );
///   },
/// ),
///
class IllustGridTabPage extends StatefulWidget {
  /// 首次请求数据的回调函数（刷新也需要该函数）
  final IllustRequestCallback onRequest;

  /// 懒加载回调函数，已内置了处理，可为空
  final IllustLazyLoadCallback? onLazyLoad;

  /// 列表为空时的展示组件
  final Widget? withoutIllustWidget;

  /// 滚动控制器
  final ScrollController? scrollController;

  /// 滚动物理效果
  final ScrollPhysics? physics;

  final EdgeInsets? padding;

  /// 列表数据管理，为空则由内部进行实例化
  final IllustListProvider? illustsProvider;

  /// 懒加载状态管理，为空则由内部进行实例化
  final LazyloadStatusProvider? lazyloadProvider;

  @override
  State<StatefulWidget> createState() => IllustGridTabPageState();

  /// 适用于放在TabView里的插画列表页面
  const IllustGridTabPage({
    Key? key,
    required this.onRequest,
    this.onLazyLoad,
    this.withoutIllustWidget,
    this.scrollController,
    this.physics,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    this.illustsProvider,
    this.lazyloadProvider,
  }) : super(key: key);
}

class IllustGridTabPageState extends State<IllustGridTabPage> with AutomaticKeepAliveClientMixin {
  /// 列表数据管理
  late final IllustListProvider _illustsProvider;

  /// 懒加载状态管理
  late final LazyloadStatusProvider _lazyloadProvider;

  /// 用于取消当前还未完成的请求
  CancelToken _cancelToken = CancelToken();

  /// 是否已经在懒加载请求中（用于避免重复请求同个懒加载数据）
  bool isLazyloadRequesting = false;

  @override
  void initState() {
    super.initState();
    _illustsProvider = widget.illustsProvider ?? IllustListProvider();
    _lazyloadProvider = widget.lazyloadProvider ?? LazyloadStatusProvider();
    widget.onRequest(_cancelToken).then((value) {
      _illustsProvider.resetIllusts(value.illusts, value.nextUrl);
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
          CommonIllustList value = await requestIllusts(CONSTANTS.restrict_public).catchError((_) {
            Fluttertoast.showToast(
              msg: "Request failed!",
              toastLength: Toast.LENGTH_SHORT,
              fontSize: 14.0,
            );
          });
          _illustsProvider.resetIllusts(value.illusts, value.nextUrl);
        },
        child: Consumer(
          builder: (context, IllustListProvider provider, Widget? child) {
            switch (provider.loadingStatus) {
              case LoadingStatus.loading:
                return const RequestLoading();
              case LoadingStatus.failed:
                return RequestLoadingFailed(
                  onRetry: () {
                    requestIllusts(CONSTANTS.restrict_public).then((value) {
                      _illustsProvider.resetIllusts(value.illusts, value.nextUrl);
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
              return widget.withoutIllustWidget ?? _buildEmptyPrompt(context);
            }
            return IllustWaterfallGrid(
              physics: widget.physics,
              padding: widget.padding,
              artworkList: provider.list,
              hasMore: provider.nextUrl != null,
              onLazyLoad: () async {
                if (_illustsProvider.nextUrl == null) return;
                if (widget.onLazyLoad != null) {
                  // 自定义的懒加载
                  isLazyloadRequesting = true;
                  _lazyloadProvider.setLazyloadStatus(LazyloadStatus.loading);
                  _cancelToken = CancelToken();
                  CommonIllustList value = await widget.onLazyLoad!(provider.nextUrl, _cancelToken).catchError((err) {
                    if (!(err is DioError && err.type == DioErrorType.cancel)) {
                      _lazyloadProvider.setLazyloadStatus(LazyloadStatus.failed);
                    }
                  }).whenComplete(() => isLazyloadRequesting = false);
                  _illustsProvider.resetIllusts(value.illusts, value.nextUrl);
                } else {
                  // 默认的懒加载
                  defaultIllustLazyload();
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

  @override
  void dispose() {
    if (!_cancelToken.isCancelled) _cancelToken.cancel();
    _cancelToken = CancelToken();
    super.dispose();
  }

  /// 默认的懒加载（插画与漫画通用），确保nextUrl不为空再调用！
  void defaultIllustLazyload() {
    if (isLazyloadRequesting) return;
    isLazyloadRequesting = true; // 标记正在懒加载中
    _lazyloadProvider.setLazyloadStatus(LazyloadStatus.loading);
    if (!_cancelToken.isCancelled) _cancelToken.cancel();
    _cancelToken = CancelToken();
    ApiIllusts().getNextIllusts(_illustsProvider.nextUrl!, cancelToken: _cancelToken).then((value) {
      _illustsProvider.appendIllusts(value.illusts, value.nextUrl);
    }).catchError((err) {
      if (err is DioError && err.type == DioErrorType.cancel) return;
      _lazyloadProvider.setLazyloadStatus(LazyloadStatus.failed);
    }).whenComplete(() => isLazyloadRequesting = false); // 最后取消标记懒加载中
  }

  /// 加载插画或漫画数据，成功和失败的后续操作需另行处理
  /// - [restrict] 过滤规则，参考[CONSTANTS.restrict_public]
  Future<CommonIllustList> requestIllusts(String restrict) async {
    resetLazyload();
    _cancelToken = CancelToken();
    return widget.onRequest(_cancelToken);
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
