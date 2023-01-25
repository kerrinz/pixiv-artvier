import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/api_app/api_illusts.dart';
import 'package:pixgem/api_app/api_novels.dart';
import 'package:pixgem/api_app/api_serach.dart';
import 'package:pixgem/api_app/api_user.dart';
import 'package:pixgem/base/base_provider.dart';
import 'package:pixgem/global/logger.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/model_response/novels/common_novel.dart';
import 'package:pixgem/model_response/user/common_user_previews.dart';
import 'package:pixgem/pages/search/result/provider/search_filters_provider.dart';

class SearchArtworksNotifier extends BaseAutoDisposeAsyncNotifier<List<CommonIllust>>
    with _SearchResultProviderMixin<List<CommonIllust>> {
  SearchArtworksNotifier({required String searchWord}) {
    this.searchWord = searchWord;
  }

  /// 初始化数据
  @override
  Future<List<CommonIllust>> fetch() async {
    var filterArgs = ref.watch(searchFilterProvider);
    try {
      var result = await ApiSearch(requester).searchArtworks(
        // 搜索关键词，再叠加收藏数
        filterArgs.minCollectCount == null ? searchWord : "$searchWord ${filterArgs.minCollectCount.toString()}users入り",
        sort: filterArgs.sort,
        match: filterArgs.match,
        startDate: filterArgs.startDate,
        endDate: filterArgs.endDate,
        cancelToken: _cancelToken,
      );
      nextUrl = result.nextUrl;
      return result.illusts;
    } catch (e) {
      if (!(e is DioError && e.type == DioErrorType.cancel)) logger.e(e);
      rethrow;
    }
  }

  /// 下一页
  @override
  Future<bool> next() async {
    if (nextUrl == null) return false;

    var result = await ApiIllusts(requester).getNextIllusts(nextUrl!);
    nextUrl = result.nextUrl;
    update((p0) => p0..addAll(result.illusts));

    return nextUrl != null;
  }
}

class SearchNovelsNotifier extends BaseAutoDisposeAsyncNotifier<List<CommonNovel>>
    with _SearchResultProviderMixin<List<CommonNovel>> {
  SearchNovelsNotifier({required String searchWord}) {
    this.searchWord = searchWord;
  }

  /// 初始化数据
  @override
  Future<List<CommonNovel>> fetch() async {
    var filterArgs = ref.watch(searchFilterProvider);
    var result = await ApiSearch(requester).searchNovels(
      searchWord,
      sort: filterArgs.sort,
      match: filterArgs.match,
      startDate: filterArgs.startDate,
      endDate: filterArgs.endDate,
      cancelToken: _cancelToken,
    );
    nextUrl = result.nextUrl;
    return result.novels;
  }

  /// 下一页
  @override
  Future<bool> next() async {
    if (nextUrl == null) return false;

    var result = await ApiNovels(requester).nextNovels(nextUrl!);
    nextUrl = result.nextUrl;
    update((p0) => p0..addAll(result.novels));

    return nextUrl != null;
  }
}

class SearchUsersNotifier extends BaseAutoDisposeAsyncNotifier<List<CommonUserPreviews>>
    with _SearchResultProviderMixin<List<CommonUserPreviews>> {
  SearchUsersNotifier({required String searchWord}) {
    this.searchWord = searchWord;
  }

  /// 初始化数据
  @override
  Future<List<CommonUserPreviews>> fetch() async {
    var result = await ApiSearch(requester).searchUsers(
      searchWord,
      cancelToken: _cancelToken,
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
}

mixin _SearchResultProviderMixin<State> on BaseAutoDisposeAsyncNotifier<State> {
  late String searchWord;

  String? nextUrl;

  final CancelToken _cancelToken = CancelToken();

  @override
  FutureOr<State> build() async {
    ref.onCancel(() {
      if (!_cancelToken.isCancelled) _cancelToken.cancel();
    });
    return fetch();
  }

  /// 初始化数据
  Future<State> fetch();

  /// 下一页
  Future<bool> next();

  /// 下拉刷新
  Future<void> refresh() async {
    state = await AsyncValue.guard(() async {
      return fetch();
    });
  }

  /// 失败后的重试，或者用于重新加载
  Future<void> reload() async {
    // Set loading
    state = const AsyncValue.loading();
    // Reload
    state = await AsyncValue.guard(() async {
      return fetch();
    });
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
