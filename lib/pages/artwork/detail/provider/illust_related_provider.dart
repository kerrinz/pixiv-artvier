import 'dart:async';

import 'package:artvier/api_app/api_illusts.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/base/base_provider/illust_list_notifier.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 相关作品
final illustRelatedProvider =
    AutoDisposeAsyncNotifierProvider.family<RelatedArtworksNotifier, List<CommonIllust>, String>(() {
  return RelatedArtworksNotifier();
});

// 相关作品
class RelatedArtworksNotifier extends BaseAutoDisposeFamilyAsyncNotifier<List<CommonIllust>, String>
    with IllustListAsyncNotifierMixin {
  String get worksId => arg;

  @override
  FutureOr<List<CommonIllust>> build(String arg) async {
    handleCancel(ref);
    handleCollectState(ref);
    return fetch();
  }

  /// 初始化数据
  @override
  Future<List<CommonIllust>> fetch() async {
    var result = await ApiIllusts(requester).getRelatedIllust(worksId, cancelToken: cancelToken);
    nextUrl = result.nextUrl;
    return result.illusts;
  }
}
