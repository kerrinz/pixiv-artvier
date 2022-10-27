import 'package:pixgem/model_response/illusts/common_illust.dart';

/// 插画（或漫画）详情页面的传递参数
///
/// 当[detail]存在时，使用[detail]作为预加载（渲染）作品详情，否则将通过[artworkId]获取
/// - 必须：[artworkId]
/// - 可选：[detail], [callback]
class ArkworkDetailPageArguments {
  /// 画作的详情（预加载数据）
  CommonIllust? detail;

  /// 执行回调，[isBookmarked]为事件触发后的收藏状态
  Function(String id, bool isBookmarked)? callback;

  /// 画作的id
  String artworkId;

  ArkworkDetailPageArguments({
    this.detail,
    this.callback,
    required this.artworkId,
  });
}
