import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/api_app/api_illusts.dart';
import 'package:pixgem/common_provider/bookmark_status_provider_provider.dart';
import 'package:pixgem/common_provider/loading_request_provider.dart';
import 'package:pixgem/component/drag_view/drag_vertical_container.dart';
import 'package:pixgem/l10n/localization_intl.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/pages/artwork/detail/advanced_collect__bottom_sheet.dart';

class ArtWorkDetailPageVM extends ChangeNotifier {
  ArtWorkDetailPageVM(this.artworkId, this.artworkDetail, this.collectStatus, this.callback) {
    /// 已有作品详情可以不显示loading
    pageLoadingStatus = artworkDetail == null ? LoadingStatus.loading : LoadingStatus.success;
  }

  /// 拖拽的最小高度
  final double minRevealHeight = 180;

  /// 作品ID
  final String artworkId;

  /// 作品详情，若不提供则通过网络请求获取详情
  CommonIllust? artworkDetail;

  /// 执行回调，[isBookmarked]为事件触发后的收藏状态
  Function(String id, bool isCollected)? callback;

  late LoadingStatus pageLoadingStatus;

  /// 收藏状态
  BookmarkStatus collectStatus;

  DragController dragController = DragController();

  /// 相关作品
  List<CommonIllust> relatedList = [];

  /// 添加收藏
  Future collect(BuildContext context) async {
    LocalizationIntl intl = LocalizationIntl.of(context);
    collectStatus = BookmarkStatus.bookmarking;
    notifyListeners();
    try {
      bool result = await ApiIllusts().addIllustBookmark(illustId: artworkId);
      if (result) {
        // 操作成功
        // 执行回调
        doCallBack(true);
        Fluttertoast.showToast(msg: intl.addCollectSucceed, toastLength: Toast.LENGTH_LONG);
        collectStatus = BookmarkStatus.bookmarked;
      } else {
        // 操作失败
        Fluttertoast.showToast(
            msg: "${intl.addCollectFailed}, (Maybe already un-collected)", toastLength: Toast.LENGTH_LONG);
        collectStatus = BookmarkStatus.notBookmark;
      }
    } on Exception catch (_) {
      Fluttertoast.showToast(msg: intl.addCollectFailed, toastLength: Toast.LENGTH_LONG);
      collectStatus = BookmarkStatus.notBookmark;
    } finally {
      notifyListeners();
    }
  }

  /// 移除收藏
  Future unCollect(BuildContext context) async {
    LocalizationIntl intl = LocalizationIntl.of(context);
    collectStatus = BookmarkStatus.unBookmarking;
    notifyListeners();
    try {
      bool result = await ApiIllusts().deleteIllustBookmark(illustId: artworkId);
      if (result) {
        // 操作成功
        // 执行回调
        doCallBack(false);
        Fluttertoast.showToast(msg: intl.removeCollectionSucceed, toastLength: Toast.LENGTH_LONG);
        collectStatus = BookmarkStatus.notBookmark;
      } else {
        // 操作失败
        Fluttertoast.showToast(
            msg: "${intl.removeCollectionFailed}, (Maybe already un-collected)", toastLength: Toast.LENGTH_LONG);
        collectStatus = BookmarkStatus.bookmarked;
      }
    } on Exception catch (_) {
      Fluttertoast.showToast(msg: intl.removeCollectionFailed, toastLength: Toast.LENGTH_LONG);
      collectStatus = BookmarkStatus.bookmarked;
    } finally {
      notifyListeners();
    }
  }

  /// 高级收藏
  Future collectByAdvanced(BuildContext context, AdvancedCollectArguments arguments) async {
    LocalizationIntl intl = LocalizationIntl.of(context);
    collectStatus = BookmarkStatus.bookmarking;
    notifyListeners();
    try {
      bool result = await ApiIllusts().addIllustBookmark(
        illustId: artworkId,
        tags: arguments.tags,
        restrict: arguments.restrict,
      );
      if (result) {
        doCallBack(true);
        Fluttertoast.showToast(
            msg: arguments.isCollected ? intl.editCollectionSucceed : intl.addCollectSucceed,
            toastLength: Toast.LENGTH_LONG);
        collectStatus = BookmarkStatus.bookmarked;
        notifyListeners();
      } else {
        Fluttertoast.showToast(
            msg: arguments.isCollected ? intl.editCollectionFailed : intl.addCollectFailed,
            toastLength: Toast.LENGTH_LONG);
      }
    } on Exception catch (_) {
      // if (error is DioError && error.type == DioErrorType.cancel) return;
      Fluttertoast.showToast(
          msg: arguments.isCollected ? intl.editCollectionFailed : intl.addCollectFailed,
          toastLength: Toast.LENGTH_LONG);
      collectStatus = arguments.isCollected ? BookmarkStatus.bookmarked : BookmarkStatus.notBookmark;
      notifyListeners();
    }
  }

  /// 获取作品详情
  Future requestArtworkDetail() async {
    pageLoadingStatus = LoadingStatus.loading;
    // if (!_detailCancelToken.isCancelled) _detailCancelToken.cancel();
    // _detailCancelToken = CancelToken();
    try {
      CommonIllust detail = await ApiIllusts().getIllustDetail(artworkId, cancelToken: null);
      artworkDetail = detail;
      pageLoadingStatus = LoadingStatus.success;
    } on Exception catch (_) {
      // if (error is DioError && error.type == DioErrorType.cancel) return;
      pageLoadingStatus = LoadingStatus.failed;
    } finally {
      notifyListeners();
    }
  }

  /// 执行回调方法，传入操作结果
  void doCallBack(bool isCollected) {
    if (callback != null) {
      // 执行回调
      callback!(artworkId, isCollected);
    }
  }
}
