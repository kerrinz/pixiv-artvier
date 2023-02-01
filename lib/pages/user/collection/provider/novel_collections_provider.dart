import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/api_app/api_user.dart';
import 'package:pixgem/base/base_provider/base_notifier.dart';
import 'package:pixgem/base/base_provider/novel_list_notifier.dart';
import 'package:pixgem/global/provider/current_account_provider.dart';
import 'package:pixgem/model_response/novels/common_novel.dart';
import 'package:pixgem/pages/user/collection/model/collections_filter_model.dart';
import 'package:pixgem/pages/user/collection/provider/filter_provider.dart';

/// 收藏页面（美术作品）的加载状态
final myNovelCollectionsStateProvider =
    AsyncNotifierProvider.autoDispose<_MyNovelCollectionsStateNotifier, List<CommonNovel>>(
        _MyNovelCollectionsStateNotifier.new);

class _MyNovelCollectionsStateNotifier extends BaseAutoDisposeAsyncNotifier<List<CommonNovel>>
    with NovelListAsyncNotifierMixin {
  late String userId;

  late CollectionsFilterModel filterModel;

  @override
  FutureOr<List<CommonNovel>> build() {
    beforeBuild(ref);
    userId = ref.watch(globalCurrentAccountProvider)!.user.id;
    filterModel = ref.watch(collectionsFilterProvider);
    return fetch();
  }

  /// 首次获取数据
  @override
  Future<List<CommonNovel>> fetch() async {
    var res = await ApiUser(requester).novelCollections(
      userId: userId,
      tag: filterModel.tag?.isEmpty ?? false ? "未分類" : filterModel.tag,
      restrict: filterModel.restrict,
      cancelToken: cancelToken,
    );
    nextUrl = res.nextUrl;
    return res.novels;
  }
}
