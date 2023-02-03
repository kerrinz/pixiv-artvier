import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/api_app/api_newest.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/base/base_provider/illust_list_notifier.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';

/// 关注用户最新作品的筛选条件
final followedNewestRestrictAllProvider = StateProvider.autoDispose<RestrictAll>((ref) {
  return RestrictAll.all;
});

/// 关注用户的最新美术作品（插画 + 漫画）
final followedNewestArtworksProvider =
    AutoDisposeAsyncNotifierProvider<FollowedNewestArtworksNotifier, List<CommonIllust>>(() {
  return FollowedNewestArtworksNotifier();
});

/// 关注用户的最新美术作品
class FollowedNewestArtworksNotifier extends BaseAutoDisposeAsyncNotifier<List<CommonIllust>>
    with IllustListAsyncNotifierMixin {
  late RestrictAll restrictFilter;

  @override
  FutureOr<List<CommonIllust>> build() async {
    restrictFilter = ref.watch(followedNewestRestrictAllProvider);
    handleDispose(ref);
    handleCollectState(ref);
    return fetch();
  }

  /// 初始化数据
  @override
  Future<List<CommonIllust>> fetch() async {
    var result = await ApiNewArtWork(requester).followedNewestArtworks(restrictFilter, cancelToken: cancelToken);
    nextUrl = result.nextUrl;
    return result.illusts;
  }
}
