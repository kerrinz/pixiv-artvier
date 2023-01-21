import 'package:pixgem/config/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'collections_filter_model.freezed.dart';

/// 收藏作品的筛选
@Freezed(
  copyWith: true,
)
class CollectionsFilterModel with _$CollectionsFilterModel {
  const factory CollectionsFilterModel({
    /// 隐私
    @Default(Restrict.public) Restrict restrict,

    /// 根据tag筛选，当null时不根据tag筛选，当值为""即Empty String时，表示”未分類“
    String? tag,

    /// 作品类型
    required WorksType worksType,
  }) = _CollectionsFilterModel;
}
