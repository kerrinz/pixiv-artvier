import 'package:pixgem/model_response/illusts/common_illust.dart';

/// 插画（或漫画）详情页面的传递参数
/// - 两种情景：
/// 1. 已知详情数据：即预渲染部分内容，需要传递[detail]，可选[callback]作回调
/// 2. 只知道作品id：只需要传递[illustId]
/// - 注：[artworkId] 与 [detail] 至少且至多赋值其中一个
class ArkworkDetailPageArguments {
  /// 画作的详情
  CommonIllust? detail;

  /// 执行回调，提供变更后的收藏状态
  Function(String id, bool isBookmarked)? callback;

  /// 画作的id
  String? artworkId;

  ArkworkDetailPageArguments({
    this.detail,
    this.callback,
    this.artworkId,
  }) : assert(
          (artworkId == null && detail != null) || (artworkId != null && detail == null),
          "[artworkId] and [detail] must be assigned at least one and most one",
        );
}
