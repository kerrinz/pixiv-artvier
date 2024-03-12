import 'package:json_annotation/json_annotation.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';

part 'illust_detail.g.dart';

@JsonSerializable()

/// - 与漫画通用
class IllustDetail extends Object {
  @JsonKey(name: 'illust')
  CommonIllust illust;

  IllustDetail(this.illust);

  factory IllustDetail.fromJson(Map<String, dynamic> srcJson) => _$IllustDetailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$IllustDetailToJson(this);
}
