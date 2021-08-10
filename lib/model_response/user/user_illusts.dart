import 'package:json_annotation/json_annotation.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';

part 'user_illusts.g.dart';


@JsonSerializable()
class UserIllusts extends Object {

  @JsonKey(name: 'illusts')
  List<CommonIllust> illusts;

  @JsonKey(name: 'next_url')
  String? nextUrl;

  UserIllusts(this.illusts, this.nextUrl);

  factory UserIllusts.fromJson(Map<String, dynamic> srcJson) => _$UserIllustsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserIllustsToJson(this);

}
