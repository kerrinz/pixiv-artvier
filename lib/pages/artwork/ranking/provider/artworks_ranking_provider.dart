import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/api_app/api_illusts.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/base/base_provider/illust_list_notifier.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';

/// 美术作品（插画或漫画）排行
/// arg: mode
final artworksRankingProvier =
    AsyncNotifierProvider.autoDispose.family<ArtworksRankingNotifier, List<CommonIllust>, String>(
  () => ArtworksRankingNotifier(),
);

class ArtworksRankingNotifier extends BaseAutoDisposeFamilyAsyncNotifier<List<CommonIllust>, String>
    with IllustListAsyncNotifierMixin {
  late String mode;

  @override
  FutureOr<List<CommonIllust>> build(String arg) async {
    mode = arg;
    beforeBuild(ref);
    return fetch();
  }

  /// 初始化数据
  @override
  Future<List<CommonIllust>> fetch() async {
    var result = await ApiIllusts(requester).getIllustRanking(mode: mode, cancelToken: cancelToken);
    nextUrl = result.nextUrl;
    return result.illusts;
  }

}
