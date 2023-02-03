import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/api_app/api_user.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/base/base_provider/illust_list_notifier.dart';
import 'package:artvier/global/provider/current_account_provider.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';
import 'package:artvier/pages/user/collection/model/collections_filter_model.dart';
import 'package:artvier/pages/user/collection/provider/filter_provider.dart';

/// 收藏页面（美术作品）的加载状态
final myArtworkCollectionsStateProvider =
    AsyncNotifierProvider.autoDispose<_MyArtworkCollectionsStateNotifier, List<CommonIllust>>(
        _MyArtworkCollectionsStateNotifier.new);

class _MyArtworkCollectionsStateNotifier extends BaseAutoDisposeAsyncNotifier<List<CommonIllust>>
    with IllustListAsyncNotifierMixin {
  late String userId;

  late CollectionsFilterModel filterModel;

  @override
  FutureOr<List<CommonIllust>> build() {
    handleCancel(ref);
    handleCollectState(ref);
    userId = ref.watch(globalCurrentAccountProvider)!.user.id;
    filterModel = ref.watch(collectionsFilterProvider);
    return fetch();
  }

  /// 首次获取数据
  @override
  Future<List<CommonIllust>> fetch() async {
    var res = await ApiUser(requester).artworkCollections(
      userId: userId,
      tag: filterModel.tag?.isEmpty ?? false ? "未分類" : filterModel.tag,
      restrict: filterModel.restrict,
      cancelToken: cancelToken,
    );
    nextUrl = res.nextUrl;
    return res.illusts;
  }
}
