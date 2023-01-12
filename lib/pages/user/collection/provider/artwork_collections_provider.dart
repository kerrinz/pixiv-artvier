import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/api_app/api_illusts.dart';
import 'package:pixgem/api_app/api_user.dart';
import 'package:pixgem/global/provider/account_provider.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/pages/user/collection/state/artwork_collections_state.dart';

/// 收藏页面（插画漫画）的加载状态
final myArtworkCollectionsStateProvider =
    StateNotifierProvider.autoDispose<_MyArtworkCollectionsStateNotifier, ArtworkCollectionsState>((ref) {
  String? userId = ref.watch(globalCurrentAccountProvider)?.user.id;
  return _MyArtworkCollectionsStateNotifier(const ArtworkCollectionsState.loading(), ref: ref, userId: userId!)
    ..request();
});

class _MyArtworkCollectionsStateNotifier extends StateNotifier<ArtworkCollectionsState> {
  _MyArtworkCollectionsStateNotifier(
    super.state, {
    required this.ref,
    required this.userId,
  });

  final Ref ref;

  final String userId;

  final List<CommonIllust> artworks = [];

  String? nextUrl;

  bool get hasMore => nextUrl != null;

  /// 首次获取数据
  Future request() async {
    var res = await ApiUser().getUserBookmarksIllust(userId: userId);
    nextUrl = res.nextUrl;
    artworks.clear();
    if (res.illusts.isEmpty) {
      state = const ArtworkCollectionsState.empty();
    } else {
      artworks.addAll(res.illusts);
      state = ArtworkCollectionsState.data(artworks);
    }
  }

  /// 获取下一页
  Future next() async {
    if (!hasMore) return;
    var res = await ApiIllusts().getNextIllusts(nextUrl!);
    nextUrl = res.nextUrl;
    artworks.addAll(res.illusts);

    /// 更新页面状态
    state = ArtworkCollectionsState.data(artworks);
  }
}
