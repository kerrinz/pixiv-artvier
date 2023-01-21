import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/api_app/api_illusts.dart';
import 'package:pixgem/base/base_provider.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';

/// 美术作品（插画或漫画）排行
/// arg: mode
final artworksRankingProvier = AsyncNotifierProviderFamily<ArtworksRankingNotifier, List<CommonIllust>, String>(
  () => ArtworksRankingNotifier(),
);

class ArtworksRankingNotifier extends BaseFamilyAsyncNotifier<List<CommonIllust>, String> {
  late String mode;

  String? nextUrl;

  @override
  FutureOr<List<CommonIllust>> build(String arg) async {
    mode = arg;
    return fetch();
  }

  /// 初始化数据
  Future<List<CommonIllust>> fetch() async {
    var result = await ApiIllusts(requester).getIllustRanking(mode: mode);
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

  Future<void> refresh() async {
    // Set loading
    state = const AsyncValue.loading();
    // Reload
    state = await AsyncValue.guard(() async {
      return fetch();
    });
  }
}
