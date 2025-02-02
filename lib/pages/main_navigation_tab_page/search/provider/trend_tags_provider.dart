import 'dart:async';

import 'package:artvier/config/enums.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/api_app/api_serach.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/global/logger.dart';
import 'package:artvier/model_response/illusts/illust_trending_tags.dart';

// 热门标签的类型切换
final trendTagsWorksTypeProvider = AutoDisposeStateProvider<WorksType>((ref) {
  return WorksType.illust;
});

/// 热门插画+漫画标签
final artworkTrendTagsProvider =
    AsyncNotifierProvider<ArtworkTrendTagsNotifier, List<TrendTags>>(ArtworkTrendTagsNotifier.new);

/// 热门小说标签
final novelTrendTagsProvider =
    AsyncNotifierProvider<NovelTrendTagsNotifier, List<TrendTags>>(NovelTrendTagsNotifier.new);

class ArtworkTrendTagsNotifier extends BaseAsyncNotifier<List<TrendTags>> {
  @override
  FutureOr<List<TrendTags>> build() async {
    return fetch();
  }

  /// 初始化数据
  @override
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

class NovelTrendTagsNotifier extends BaseAsyncNotifier<List<TrendTags>> implements ArtworkTrendTagsNotifier {
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
