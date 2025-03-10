// ignore_for_file: camel_case_types

import 'package:json_annotation/json_annotation.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';

part 'illust_recommended.g.dart';


@JsonSerializable()
class IllustRecommended extends Object {

  @JsonKey(name: 'illusts')
  List<CommonIllust> illusts;

  @JsonKey(name: 'ranking_illusts')
  List<CommonIllust> rankingIllusts;

  @JsonKey(name: 'contest_exists')
  bool contestExists;

  @JsonKey(name: 'privacy_policy')
  Privacy_policy privacyPolicy;

  @JsonKey(name: 'next_url')
  String? nextUrl;

  IllustRecommended(this.illusts,this.rankingIllusts,this.contestExists,this.privacyPolicy,this.nextUrl,);

  factory IllustRecommended.fromJson(Map<String, dynamic> srcJson) => _$IllustRecommendedFromJson(srcJson);

  Map<String, dynamic> toJson() => _$IllustRecommendedToJson(this);

}

@JsonSerializable()
class Privacy_policy extends Object {

  @JsonKey(name: 'version')
  String? version;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'url')
  String? url;

  Privacy_policy(this.version,this.message,this.url,);

  factory Privacy_policy.fromJson(Map<String, dynamic> srcJson) => _$Privacy_policyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Privacy_policyToJson(this);

}


