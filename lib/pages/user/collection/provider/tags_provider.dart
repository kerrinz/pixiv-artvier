import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/api_app/api_user.dart';
import 'package:pixgem/base/base_provider.dart';
import 'package:pixgem/model_response/user/bookmark/bookmark_tag.dart';
import 'package:pixgem/pages/user/collection/model/collections_filter_model.dart';
import 'package:pixgem/pages/user/collection/provider/filter_provider.dart';
import 'package:pixgem/pages/user/collection/state/collections_state.dart';

typedef CollectionTagsState = CollectionsState<List<BookmarkTag>>;

/// 收藏作品的标签
final collectionsTagsProvider = StateNotifierProvider.autoDispose<CollectionsTagsNotifier, CollectionTagsState>(
  (ref) {
    var model = ref.watch(collectionsFilterProvider);
    return CollectionsTagsNotifier(
      const CollectionTagsState.loading(),
      ref: ref,
      filterModel: model,
    )..fetch();
  },
);

/// 收藏作品的标签
class CollectionsTagsNotifier extends BaseStateNotifier<CollectionTagsState> {
  CollectionsTagsNotifier(super.state, {required super.ref, required this.filterModel});

  final CollectionsFilterModel filterModel;

  String? nextUrl;

  final CancelToken _cancelToken = CancelToken();

  @override
  void dispose() {
    if (!_cancelToken.isCancelled) _cancelToken.cancel();
    super.dispose();
  }

  /// 初始化数据
  Future<void> fetch() async {
    try {
      var result = await ApiUser(requester).collectionTags(filterModel.worksType, restrict: filterModel.restrict);
      nextUrl = result.nextUrl;
      state = result.bookmarkTags?.isNotEmpty ?? false
          ? CollectionTagsState.data(result.bookmarkTags!)
          : const CollectionTagsState.empty();
    } catch (e) {
      state = CollectionTagsState.error(e.toString());
    }
  }

  /// 下一页
  Future<bool> next() async {
    if (nextUrl == null) return false;

    var result = await ApiUser(requester).nextTags(nextUrl!);
    nextUrl = result.nextUrl;
    state = CollectionTagsState.data(result.bookmarkTags ?? []);

    return nextUrl != null;
  }

  /// 下拉刷新
  Future<void> refresh() async {
    await fetch();
  }

  /// 重试或者重新加载
  Future<void> reload() async {
    // Set loading
    state = const CollectionTagsState.loading();
    // Reload
    await fetch();
  }
}
