import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';

part 'home_illust_model.freezed.dart';

/// 插画首页的数据模型
@Freezed(
  copyWith: true,
)
class HomeIllustModel with _$HomeIllustModel {
  const factory HomeIllustModel({
    required List<CommonIllust> ranking,
    required List<CommonIllust> recommended,
  }) = _HomeIllustModel;
}
