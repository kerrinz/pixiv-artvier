import 'package:artvier/model_response/illusts/common_illust.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'illust_detail_page_args.freezed.dart';

/// 插画详情页面的传递参数
@Freezed(
  copyWith: true
)
class IllustDetailPageArguments with _$IllustDetailPageArguments {
  const factory IllustDetailPageArguments({
    // 单个作品 ID
    String? illustId,
    // 单个作品标题
    String? title,

    // 多个作品完整信息
    List<CommonIllust>? illustList,
    // 多个作品中，当前作品的索引
    int? currentIllustListIndex,
  }) = _IllustDetailPageArguments;
}
