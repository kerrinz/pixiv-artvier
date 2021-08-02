import 'package:json_annotation/json_annotation.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';

part 'illust_ranking.g.dart';


@JsonSerializable()
class IllustRanking extends Object {

  @JsonKey(name: 'illusts')
  List<CommonIllust> illusts;

  @JsonKey(name: 'next_url')
  String nextUrl;

  IllustRanking(this.illusts,this.nextUrl,);

  factory IllustRanking.fromJson(Map<String, dynamic> srcJson) => _$IllustRankingFromJson(srcJson);

  Map<String, dynamic> toJson() => _$IllustRankingToJson(this);

}