import 'package:json_annotation/json_annotation.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';

part 'common_illust_list.g.dart';


@JsonSerializable()
/// - 与漫画通用
class CommonIllustList extends Object {

  @JsonKey(name: 'illusts')
  List<CommonIllust> illusts;

  @JsonKey(name: 'next_url')
  String? nextUrl;

  CommonIllustList(this.illusts, this.nextUrl);

  factory CommonIllustList.fromJson(Map<String, dynamic> srcJson) => _$CommonIllustListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommonIllustListToJson(this);

}
