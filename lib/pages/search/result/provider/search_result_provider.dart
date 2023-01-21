import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/api_app/api_illusts.dart';
import 'package:pixgem/api_app/api_novels.dart';
import 'package:pixgem/api_app/api_serach.dart';
import 'package:pixgem/api_app/api_user.dart';
import 'package:pixgem/base/base_provider.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/model_response/novels/common_novel.dart';
import 'package:pixgem/model_response/user/common_user_previews.dart';
import 'package:pixgem/pages/search/result/provider/search_filters_provider.dart';

/// 搜索插画+漫画
final searchArtworksProvider =
    AutoDisposeAsyncNotifierProvider<SearchArtworksNotifier, List<CommonIllust>>(SearchArtworksNotifier.new);

/// 搜索小说
final searchNovelsProvider =
    AutoDisposeAsyncNotifierProvider<SearchNovelsNotifier, List<CommonNovel>>(SearchNovelsNotifier.new);

/// 搜索用户
final searchUsersProvider =
    AutoDisposeAsyncNotifierProvider<SearchUsersNotifier, List<CommonUserPreviews>>(SearchUsersNotifier.new);

class SearchArtworksNotifier extends BaseAutoDisposeAsyncNotifier<List<CommonIllust>> {
  String? nextUrl;

  @override
  FutureOr<List<CommonIllust>> build() async {
    return fetch();
  }

  /// 初始化数据
  Future<List<CommonIllust>> fetch() async {
    var filterArgs = ref.read(searchFilterProvider);
    var result = await ApiSearch(requester).searchArtworks(
      ref.read(searchResultInputProvider),
      sort: filterArgs.sort,
      match: filterArgs.match,
      startDate: filterArgs.startDate,
      endDate: filterArgs.endDate,
    );
    nextUrl = result.nextUrl;
    return result.illusts;
  }

  /// 下一页
  Future<bool> next() async {
    if (nextUrl == null) return false;

    var result = await ApiIllusts(requester).getNextIllusts(nextUrl!);
    nextUrl = result.nextUrl;
    state = AsyncValue.data(result.illusts);

    return nextUrl != null;
  }

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
}

class SearchNovelsNotifier extends BaseAutoDisposeAsyncNotifier<List<CommonNovel>> {
  String? nextUrl;

  @override
  FutureOr<List<CommonNovel>> build() async {
    return fetch();
  }

  /// 初始化数据
  Future<List<CommonNovel>> fetch() async {
    var filterArgs = ref.read(searchFilterProvider);
    var result = await ApiSearch(requester).searchNovels(
      ref.read(searchResultInputProvider),
      sort: filterArgs.sort,
      match: filterArgs.match,
      startDate: filterArgs.startDate,
      endDate: filterArgs.endDate,
    );
    nextUrl = result.nextUrl;
    return result.novels;
  }

  /// 下一页
  Future<bool> next() async {
    if (nextUrl == null) return false;

    var result = await ApiNovels(requester).nextNovels(nextUrl!);
    nextUrl = result.nextUrl;
    state = AsyncValue.data(result.novels);

    return nextUrl != null;
  }

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
}

class SearchUsersNotifier extends BaseAutoDisposeAsyncNotifier<List<CommonUserPreviews>> {
  String? nextUrl;

  @override
  FutureOr<List<CommonUserPreviews>> build() async {
    return fetch();
  }

  /// 初始化数据
  Future<List<CommonUserPreviews>> fetch() async {
    var result = await ApiSearch(requester).searchUsers(ref.read(searchResultInputProvider));
    nextUrl = result.nextUrl;
    return result.users;
  }

  /// 下一页
  Future<bool> next() async {
    if (nextUrl == null) return false;

    var result = await ApiUser(requester).nextPreviewUsers(nextUrl!);
    nextUrl = result.nextUrl;
    state = AsyncValue.data(result.users);

    return nextUrl != null;
  }

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
}
