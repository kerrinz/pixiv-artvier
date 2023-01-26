import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/api_app/api_illusts.dart';
import 'package:pixgem/api_app/api_novels.dart';
import 'package:pixgem/api_app/api_user.dart';
import 'package:pixgem/base/base_provider.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/model_response/novels/common_novel.dart';

/// 其他用户发布的作品（插画漫画）
class UserIllustWorksNotifier extends BaseAutoDisposeAsyncNotifier<List<CommonIllust>> {
  UserIllustWorksNotifier({required this.userId});

  final String userId;

  String? nextUrl;

  final CancelToken _cancelToken = CancelToken();

  @override
  FutureOr<List<CommonIllust>> build() async {
    ref.onCancel(() {
      if (!_cancelToken.isCancelled) _cancelToken.cancel();
    });
    return fetch();
  }

  /// 初始化数据
  Future<List<CommonIllust>> fetch() async {
    var result = await ApiUser(requester).illustWorks(userId: userId, cancelToken: _cancelToken);
    nextUrl = result.nextUrl;
    return result.illusts;
  }

  ///重载
  Future<void> reload() async {
    // Set loading
    state = const AsyncValue.loading();
    // Reload
    state = await AsyncValue.guard(() async {
      return fetch();
    });
  }

  /// 下一页
  Future<bool> next() async {
    if (nextUrl == null) return false;

    var result = await ApiIllusts(requester).getNextIllusts(nextUrl!, cancelToken: _cancelToken);
    nextUrl = result.nextUrl;
    update((p0) => p0..addAll(result.illusts));

    return nextUrl != null;
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(() async {
      return fetch();
    });
  }
}

class UserMangaWorksNotifier extends UserIllustWorksNotifier {
  UserMangaWorksNotifier({required super.userId});

  /// 初始化数据
  @override
  Future<List<CommonIllust>> fetch() async {
    var result = await ApiUser(requester).mangaWorks(userId: userId, cancelToken: _cancelToken);
    nextUrl = result.nextUrl;
    return result.illusts;
  }
}

/// 其他用户发布的作品（小说）
class UserNovelWorksNotifier extends BaseAutoDisposeAsyncNotifier<List<CommonNovel>> {
  UserNovelWorksNotifier({required this.userId});

  final String userId;

  String? nextUrl;

  final CancelToken _cancelToken = CancelToken();

  @override
  FutureOr<List<CommonNovel>> build() async {
    ref.onCancel(() {
      if (!_cancelToken.isCancelled) _cancelToken.cancel();
    });
    return fetch();
  }

  /// 初始化数据
  Future<List<CommonNovel>> fetch() async {
    var result = await ApiUser(requester).novelWorks(userId: userId, cancelToken: _cancelToken);
    nextUrl = result.nextUrl;
    return result.novels;
  }

  ///重载
  Future<void> reload() async {
    // Set loading
    state = const AsyncValue.loading();
    // Reload
    state = await AsyncValue.guard(() async {
      return fetch();
    });
  }

  /// 下一页
  Future<bool> next() async {
    if (nextUrl == null) return false;

    var result = await ApiNovels(requester).nextNovels(nextUrl!, cancelToken: _cancelToken);
    nextUrl = result.nextUrl;
    update((p0) => p0..addAll(result.novels));

    return nextUrl != null;
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(() async {
      return fetch();
    });
  }
}
