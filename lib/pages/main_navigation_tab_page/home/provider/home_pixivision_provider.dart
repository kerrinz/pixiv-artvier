import 'dart:async';

import 'package:artvier/api_app/api_illusts.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/base/base_provider/list_notifier.dart';
import 'package:artvier/model_response/illusts/pixivision/spotlight_articles.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 首页亮点
final homePixivisionProvider =
    AsyncNotifierProvider<PixivisionNotifier, List<SpotlightArticle>>(() => PixivisionNotifier());

class PixivisionNotifier extends BaseAsyncNotifier<List<SpotlightArticle>>
    with ListAsyncNotifierMixin<List<SpotlightArticle>> {
  final CancelToken cancelToken = CancelToken();

  @override
  FutureOr<List<SpotlightArticle>> build() {
    // ref.onDispose(() {
    //   if (!cancelToken.isCancelled) cancelToken.cancel();
    // });
    return fetch();
  }

  /// 初始化数据
  @override
  Future<List<SpotlightArticle>> fetch() async {
    var result = await ApiIllusts(requester).illustPixivision(
      cancelToken: cancelToken,
    );
    nextUrl = result.nextUrl;
    return result.spotlightArticles;
  }

  /// 下一页
  @override
  Future<bool> next() async {
    if (nextUrl == null) return false;

    var result = await ApiIllusts(requester).nextIllustPixivision(nextUrl!);
    nextUrl = result.nextUrl;
    update((p0) => p0..addAll(result.spotlightArticles));

    return nextUrl != null;
  }
}
