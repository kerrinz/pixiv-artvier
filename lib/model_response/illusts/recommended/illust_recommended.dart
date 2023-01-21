// ignore_for_file: camel_case_types

import 'package:json_annotation/json_annotation.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';

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
  String nextUrl;

  IllustRecommended(this.illusts,this.rankingIllusts,this.contestExists,this.privacyPolicy,this.nextUrl,);

  factory IllustRecommended.fromJson(Map<String, dynamic> srcJson) => _$IllustRecommendedFromJson(srcJson);

  Map<String, dynamic> toJson() => _$IllustRecommendedToJson(this);

}

@JsonSerializable()
class Image_urls extends Object {

  @JsonKey(name: 'square_medium')
  String squareMedium;

  @JsonKey(name: 'medium')
  String medium;

  @JsonKey(name: 'large')
  String large;

  Image_urls(this.squareMedium,this.medium,this.large,);

  factory Image_urls.fromJson(Map<String, dynamic> srcJson) => _$Image_urlsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Image_urlsToJson(this);

}


@JsonSerializable()
class User extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'account')
  String account;

  @JsonKey(name: 'profile_image_urls')
  Profile_image_urls profileImageUrls;

  @JsonKey(name: 'is_followed')
  bool isFollowed;

  User(this.id,this.name,this.account,this.profileImageUrls,this.isFollowed,);

  factory User.fromJson(Map<String, dynamic> srcJson) => _$UserFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserToJson(this);

}


@JsonSerializable()
class Profile_image_urls extends Object {

  @JsonKey(name: 'medium')
  String medium;

  Profile_image_urls(this.medium,);

  factory Profile_image_urls.fromJson(Map<String, dynamic> srcJson) => _$Profile_image_urlsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Profile_image_urlsToJson(this);

}


@JsonSerializable()
class Tags extends Object {

  @JsonKey(name: 'name')
  String name;

  Tags(this.name,);

  factory Tags.fromJson(Map<String, dynamic> srcJson) => _$TagsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TagsToJson(this);

}


@JsonSerializable()
class Meta_single_page extends Object {

  @JsonKey(name: 'original_image_url')
  String? originalImageUrl;

  Meta_single_page(this.originalImageUrl,);

  factory Meta_single_page.fromJson(Map<String, dynamic> srcJson) => _$Meta_single_pageFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Meta_single_pageToJson(this);

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


