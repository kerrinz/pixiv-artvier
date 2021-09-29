import 'package:json_annotation/json_annotation.dart';
import 'package:pixgem/model_response/novels/common_novel.dart'; 
  
part 'novels_recommended.g.dart';


@JsonSerializable()
  class Novels_recommended extends Object {

  @JsonKey(name: 'novels')
  List<CommonNovel> novels;

  @JsonKey(name: 'ranking_novels')
  List<CommonNovel> rankingNovels;

  @JsonKey(name: 'privacy_policy')
  Privacy_policy privacyPolicy;

  @JsonKey(name: 'next_url')
  String? nextUrl;

  Novels_recommended(this.novels,this.rankingNovels,this.privacyPolicy,this.nextUrl,);

  factory Novels_recommended.fromJson(Map<String, dynamic> srcJson) => _$Novels_recommendedFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Novels_recommendedToJson(this);

}
  
@JsonSerializable()
  class Privacy_policy extends Object {

  @JsonKey(name: 'version')
  String version;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'url')
  String url;

  Privacy_policy(this.version,this.message,this.url,);

  factory Privacy_policy.fromJson(Map<String, dynamic> srcJson) => _$Privacy_policyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Privacy_policyToJson(this);

}