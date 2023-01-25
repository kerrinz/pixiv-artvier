import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/api_app/api_serach.dart';
import 'package:pixgem/base/base_provider.dart';
import 'package:pixgem/global/logger.dart';
import 'package:pixgem/model_response/illusts/illust_trending_tags.dart';

/// 趋势（插画+漫画）
final artworkTrendTagsProvider =
    AutoDisposeAsyncNotifierProvider<ArtworkTrendTagsNotifier, List<TrendTags>>(ArtworkTrendTagsNotifier.new);

/// 趋势（小说）
final novelTrendTagsProvider =
    AutoDisposeAsyncNotifierProvider<ArtworkTrendTagsNotifier, List<TrendTags>>(ArtworkTrendTagsNotifier.new);

class ArtworkTrendTagsNotifier extends BaseAutoDisposeAsyncNotifier<List<TrendTags>> {
  @override
  FutureOr<List<TrendTags>> build() async {
    return fetch();
  }

  /// 初始化数据
  Future<List<TrendTags>> fetch() async {
    try {
      var result = await ApiSearch(requester).artworksTrendingTags();
      return result.trendTags;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  /// 重载
  Future<void> reload() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await fetch();
    });
  }

  /// 刷新
  Future<void> refresh() async {
    state = await AsyncValue.guard(() async {
      return await fetch();
    });
  }
}

class NovelTrendTagsNotifier extends BaseAutoDisposeAsyncNotifier<List<TrendTags>> implements ArtworkTrendTagsNotifier {
  @override
  FutureOr<List<TrendTags>> build() async {
    return fetch();
  }

  @override
  Future<List<TrendTags>> fetch() async {
    var result = await ApiSearch(requester).novelsTrendingTags();
    return result.trendTags;
  }

  /// 重新载入
  @override
  Future<void> reload() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await fetch();
    });
  }

  /// 刷新
  @override
  Future<void> refresh() async {
    state = await AsyncValue.guard(() async {
      return await fetch();
    });
  }
}
