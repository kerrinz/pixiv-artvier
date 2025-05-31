import 'dart:async';

import 'package:artvier/base/base_provider/novel_list_notifier.dart';
import 'package:artvier/model_response/novels/common_novel.dart';
import 'package:artvier/pages/user/recommend/provider/recommend_users_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/api_app/api_newest.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/base/base_provider/illust_list_notifier.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';

// 页面状态
final followedNewestPageStateProvider = AutoDisposeStateProvider<PageState>((ref) {
  final recommend = ref.watch(recommendUsersProvider);
  if (recommend.hasValue && recommend.value != null) {
    return PageState.complete;
  }
  return PageState.loading;
});

final followedNewestWorksTypeProvider = StateProvider<WorksType>((ref) {
  return WorksType.illust;
});

/// 关注用户最新作品的筛选条件
final followedNewestRestrictAllProvider = StateProvider<RestrictAll>((ref) {
  return RestrictAll.all;
});

/// 关注用户的最新美术作品
class FollowedNewestArtworksNotifier extends BaseAsyncNotifier<List<CommonIllust>> with IllustListAsyncNotifierMixin {
  late RestrictAll restrictFilter;

  @override
  FutureOr<List<CommonIllust>> build() async {
    handleDispose(ref);
    handleCollectState(ref);
    return fetch();
  }

  /// 初始化数据
  @override
  Future<List<CommonIllust>> fetch() async {
    restrictFilter = ref.read(followedNewestRestrictAllProvider);
    var result = await ApiNewArtWork(requester).followedNewestArtworks(restrictFilter, cancelToken: cancelToken);
    nextUrl = result.nextUrl;
    return result.illusts;
  }
}

/// 关注用户的最新小说
class FollowedNewestNovelsNotifier extends BaseAsyncNotifier<List<CommonNovel>> with NovelListAsyncNotifierMixin {
  late RestrictAll restrictFilter;

  @override
  FutureOr<List<CommonNovel>> build() async {
    handleDispose(ref);
    handleCollectState(ref);
    return fetch();
  }

  /// 初始化数据
  @override
  Future<List<CommonNovel>> fetch() async {
    restrictFilter = ref.read(followedNewestRestrictAllProvider);
    var result = await ApiNewArtWork(requester).followedNewestNovels(restrictFilter, cancelToken: cancelToken);
    nextUrl = result.nextUrl;
    return result.novels;
  }
}
