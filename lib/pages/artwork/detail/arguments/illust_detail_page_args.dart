import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'illust_detail_page_args.freezed.dart';

/// 插画详情页面的传递参数
@Freezed()
class IllustDetailPageArguments with _$IllustDetailPageArguments {
  const factory IllustDetailPageArguments({
    required String illustId,
    required CommonIllust? detail,
  }) = _IllustDetailPageArguments;
}
