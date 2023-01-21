import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/api_app/api_illusts.dart';
import 'package:pixgem/base/base_provider.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/model_response/illusts/common_illust_list.dart';

final illustRelatedProvider =
    StateNotifierProvider.autoDispose.family<RelatedArtworksNotifier, List<CommonIllust>, String>((ref, worksId) {
  return RelatedArtworksNotifier([], ref: ref, worksId: worksId);
});

/// 相关作品
class RelatedArtworksNotifier extends BaseStateNotifier<List<CommonIllust>> {
  RelatedArtworksNotifier(super.state, {required super.ref, required this.worksId});

  final String worksId;

  String? nextUrl;

  /// 初始化相关作品列表
  Future init() async {
    CommonIllustList res = await ApiIllusts(requester).getRelatedIllust(worksId);
    state = res.illusts;
    nextUrl = res.nextUrl;
  }

  /// 加载下一页
  Future<bool> nextPage() async {
    if (nextUrl == null) return false;
    CommonIllustList res = await ApiIllusts(requester).getNextIllusts(nextUrl!);
    state = [...state, ...res.illusts];
    nextUrl = res.nextUrl;

    return nextUrl != null;
  }
}
