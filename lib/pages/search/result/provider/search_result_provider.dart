import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/api_app/api_serach.dart';
import 'package:artvier/api_app/api_user.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/base/base_provider/illust_list_notifier.dart';
import 'package:artvier/base/base_provider/list_notifier.dart';
import 'package:artvier/base/base_provider/novel_list_notifier.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';
import 'package:artvier/model_response/novels/common_novel.dart';
import 'package:artvier/model_response/user/common_user_previews.dart';
import 'package:artvier/pages/search/result/provider/search_filters_provider.dart';

class SearchArtworksNotifier extends BaseAsyncNotifier<List<CommonIllust>> with IllustListAsyncNotifierMixin {
  SearchArtworksNotifier({required this.searchWord});

  late String searchWord;

  @override
  FutureOr<List<CommonIllust>> build() {
    handleDispose(ref);
    handleCollectState(ref);
    return fetch();
  }

  /// 初始化数据
  @override
  Future<List<CommonIllust>> fetch() async {
    var filterArgs = ref.read(searchFilterProvider);
    // 搜索关键词，再叠加收藏数（非会员）
    final finalSearchWord = (filterArgs.bookmarkCountNotPremium == null && filterArgs.bookmarkCountNotPremium != '')
        ? searchWord
        : "$searchWord ${filterArgs.bookmarkCountNotPremium!}";
    var result = await ApiSearch(requester).searchArtworks(
      // 搜索关键词，再叠加收藏数（非会员）
      finalSearchWord,
      sort: filterArgs.sort,
      match: filterArgs.match,
      searchAiType: filterArgs.searchAiType,
      startDate: filterArgs.startDate,
      endDate: filterArgs.endDate,
      cancelToken: cancelToken,
    );
    nextUrl = result.nextUrl;
    return result.illusts;
  }

  /// 使用新关键词搜索
  Future<void> search(String searchWord) async {
    state = const AsyncValue.loading();
    this.searchWord = searchWord;
    state = await AsyncValue.guard(() async {
      return fetch();
    });
  }
}

class SearchNovelsNotifier extends BaseAsyncNotifier<List<CommonNovel>> with NovelListAsyncNotifierMixin {
  SearchNovelsNotifier({required this.searchWord});

  late String searchWord;

  @override
  FutureOr<List<CommonNovel>> build() {
    beforeBuild(ref);
    handleCollectState(ref);
    return fetch();
  }

  /// 初始化数据
  @override
  Future<List<CommonNovel>> fetch() async {
    var filterArgs = ref.read(searchFilterProvider);
    // 搜索关键词，再叠加收藏数（非会员）
    final finalSearchWord = (filterArgs.bookmarkCountNotPremium == null && filterArgs.bookmarkCountNotPremium != '')
        ? searchWord
        : "$searchWord ${filterArgs.bookmarkCountNotPremium!}";
    var result = await ApiSearch(requester).searchNovels(
      finalSearchWord,
      sort: filterArgs.sort,
      match: filterArgs.match,
      searchAiType: filterArgs.searchAiType,
      startDate: filterArgs.startDate,
      endDate: filterArgs.endDate,
      cancelToken: cancelToken,
    );
    nextUrl = result.nextUrl;
    return result.novels;
  }

  /// 使用新关键词搜索
  Future<void> search(String searchWord) async {
    state = const AsyncValue.loading();
    this.searchWord = searchWord;
    state = await AsyncValue.guard(() async {
      return fetch();
    });
  }
}

class SearchUsersNotifier extends BaseAsyncNotifier<List<CommonUserPreviews>>
    with ListAsyncNotifierMixin<List<CommonUserPreviews>> {
  SearchUsersNotifier({required this.searchWord});
  late final String searchWord;

  final CancelToken cancelToken = CancelToken();

  @override
  FutureOr<List<CommonUserPreviews>> build() {
    ref.onDispose(() {
      if (!cancelToken.isCancelled) cancelToken.cancel();
    });
    return fetch();
  }

  /// 初始化数据
  @override
  Future<List<CommonUserPreviews>> fetch() async {
    var result = await ApiSearch(requester).searchUsers(
      searchWord,
      cancelToken: cancelToken,
    );
    nextUrl = result.nextUrl;
    return result.users;
  }

  /// 下一页
  @override
  Future<bool> next() async {
    if (nextUrl == null) return false;

    var result = await ApiUser(requester).nextPreviewUsers(nextUrl!);
    nextUrl = result.nextUrl;
    update((p0) => p0..addAll(result.users));

    return nextUrl != null;
  }

  /// 使用新关键词搜索
  Future<void> search(String searchWord) async {
    state = const AsyncValue.loading();
    this.searchWord = searchWord;
    state = await AsyncValue.guard(() async {
      return fetch();
    });
  }
}
