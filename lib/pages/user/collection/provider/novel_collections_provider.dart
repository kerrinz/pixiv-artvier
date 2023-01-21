import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/api_app/api_novels.dart';
import 'package:pixgem/api_app/api_user.dart';
import 'package:pixgem/base/base_provider.dart';
import 'package:pixgem/global/logger.dart';
import 'package:pixgem/global/provider/current_account_provider.dart';
import 'package:pixgem/model_response/novels/common_novel.dart';
import 'package:pixgem/pages/user/collection/model/collections_filter_model.dart';
import 'package:pixgem/pages/user/collection/provider/filter_provider.dart';
import 'package:pixgem/pages/user/collection/state/collections_state.dart';

/// 收藏页面（美术作品）的加载状态
final myNovelCollectionsStateProvider =
    StateNotifierProvider.autoDispose<_MyNovelCollectionsStateNotifier, NovelCollectionsState>((ref) {
  String? userId = ref.watch(globalCurrentAccountProvider)?.user.id;
  CollectionsFilterModel filterModel = ref.watch(collectionsFilterProvider);

  return _MyNovelCollectionsStateNotifier(
    const NovelCollectionsState.loading(),
    ref: ref,
    userId: userId!,
    filterModel: filterModel,
  )..request();
});

class _MyNovelCollectionsStateNotifier extends BaseStateNotifier<NovelCollectionsState> {
  _MyNovelCollectionsStateNotifier(
    super.state, {
    required super.ref,
    required this.userId,
    required this.filterModel,
  });

  final String userId;

  final CollectionsFilterModel filterModel;

  final List<CommonNovel> novels = [];

  String? nextUrl;

  bool get hasMore => nextUrl != null;

  CancelToken cancelToken = CancelToken();

  @override
  void dispose() {
    if (!cancelToken.isCancelled) cancelToken.cancel();
    super.dispose();
  }

  /// 首次获取数据
  Future<void> request() async {
    try {
      var res = await ApiUser(requester).novelCollections(
        userId: userId,
        tag: filterModel.tag?.isEmpty ?? false ? "未分類" : filterModel.tag,
        restrict: filterModel.restrict,
        cancelToken: cancelToken,
      );
      nextUrl = res.nextUrl;
      novels.clear();
      if (res.novels.isEmpty) {
        state = const NovelCollectionsState.empty();
      } else {
        novels.addAll(res.novels);
        state = NovelCollectionsState.data(novels);
      }
    } catch (e) {
      logger.e(e);
      state = NovelCollectionsState.error(e.toString());
    }
  }

  /// 获取下一页
  Future<bool> next() async {
    if (!hasMore) return false;
    var res = await ApiNovels(requester).nextNovels(nextUrl!, cancelToken: cancelToken);
    nextUrl = res.nextUrl;
    novels.addAll(res.novels);

    /// 更新页面状态
    state = NovelCollectionsState.data(novels);
    return nextUrl != null;
  }

  /// 重新加载或重试
  Future<void> reload() async {
    state = const NovelCollectionsState.loading();
    await request();
  }
}
