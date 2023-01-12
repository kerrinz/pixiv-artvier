import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/api_app/api_illusts.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/model_response/illusts/common_illust_list.dart';

final illustRelatedProvider =
    StateNotifierProvider.autoDispose.family<RelatedArtworksNotifier, List<CommonIllust>, String>((ref, worksId) {
  return RelatedArtworksNotifier([], worksId: worksId);
});

/// 相关作品
class RelatedArtworksNotifier extends StateNotifier<List<CommonIllust>> {
  RelatedArtworksNotifier(super.state, {required this.worksId});

  final String worksId;

  String? nextUrl;

  /// 初始化相关作品列表
  Future init() async {
    CommonIllustList res = await ApiIllusts().getRelatedIllust(worksId);
    state = res.illusts;
    nextUrl = res.nextUrl;
  }

  /// 加载下一页
  Future nextPage() async {
    if (nextUrl == null) {
      return;
    }
    CommonIllustList res = await ApiIllusts().getNextIllusts(nextUrl!);
    state = [...state, ...res.illusts];
    nextUrl = res.nextUrl;
  }
}
