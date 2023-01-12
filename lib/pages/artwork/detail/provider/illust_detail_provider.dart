import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/api_app/api_illusts.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';

/// 插画详细信息
/// - 若页面已经传递了详细信息，则不会通过这里获取
final illustDetailProvider =
    StateNotifierProvider.autoDispose.family<IllustDetailNotifier, CommonIllust?, String>((ref, illustId) {
  return IllustDetailNotifier(null, illustId: illustId);
});

/// 插画详细信息
///
class IllustDetailNotifier extends StateNotifier<CommonIllust?> {
  IllustDetailNotifier(
    super.state, {
    this.illustId,
  }) : assert(illustId != null || state != null);

  String? illustId;

  /// 直接设置插画详细信息
  void setIllustInfo(CommonIllust illust) {
    state = illust;
  }

  /// 通过网络请求插画详细信息
  Future request() async {
    String id = illustId ?? state!.id.toString();
    var res = await ApiIllusts().getIllustDetail(id);
    state = res;
  }
}
