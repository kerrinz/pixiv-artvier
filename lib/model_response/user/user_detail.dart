// ignore_for_file: camel_case_types

import 'package:json_annotation/json_annotation.dart';
import 'package:pixgem/model_response/user/common_user.dart';

part 'user_detail.g.dart';


@JsonSerializable()
class UserDetail extends Object {

  @JsonKey(name: 'user')
  CommonUser user;

  @JsonKey(name: 'profile')
  Profile profile;

  @JsonKey(name: 'profile_publicity')
  Profile_publicity profilePublicity;

  @JsonKey(name: 'workspace')
  Workspace workspace;

  UserDetail(this.user,this.profile,this.profilePublicity,this.workspace,);

  factory UserDetail.fromJson(Map<String, dynamic> srcJson) => _$UserDetailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserDetailToJson(this);

}

@JsonSerializable()
class Profile extends Object {

  @JsonKey(name: 'webpage')
  String? webpage;

  @JsonKey(name: 'gender')
  String gender;

  @JsonKey(name: 'birth')
  String birth;

  @JsonKey(name: 'birth_day')
  String birthDay;

  @JsonKey(name: 'birth_year')
  int birthYear;

  @JsonKey(name: 'region')
  String region;

  @JsonKey(name: 'address_id')
  int addressId;

  @JsonKey(name: 'country_code')
  String countryCode;

  @JsonKey(name: 'job')
  String job;

  @JsonKey(name: 'job_id')
  int jobId;

  @JsonKey(name: 'total_follow_users')
  int totalFollowUsers;

  @JsonKey(name: 'total_mypixiv_users')
  int totalMypixivUsers;

  @JsonKey(name: 'total_illusts')
  int totalIllusts;

  @JsonKey(name: 'total_manga')
  int totalManga;

  @JsonKey(name: 'total_novels')
  int totalNovels;

  @JsonKey(name: 'total_illust_bookmarks_public')
  int totalIllustBookmarksPublic;

  @JsonKey(name: 'total_illust_series')
  int totalIllustSeries;

  @JsonKey(name: 'total_novel_series')
  int totalNovelSeries;

  @JsonKey(name: 'background_image_url')
  String? backgroundImageUrl;

  @JsonKey(name: 'twitter_account')
  String twitterAccount;

  @JsonKey(name: 'twitter_url')
  String? twitterUrl;

  @JsonKey(name: 'pawoo_url')
  String? pawooUrl;

  @JsonKey(name: 'is_premium')
  bool isPremium;

  @JsonKey(name: 'is_using_custom_profile_image')
  bool isUsingCustomProfileImage;

  Profile(this.webpage,this.gender,this.birth,this.birthDay,this.birthYear,this.region,this.addressId,this.countryCode,this.job,this.jobId,this.totalFollowUsers,this.totalMypixivUsers,this.totalIllusts,this.totalManga,this.totalNovels,this.totalIllustBookmarksPublic,this.totalIllustSeries,this.totalNovelSeries,this.twitterAccount,this.twitterUrl,this.isPremium,this.isUsingCustomProfileImage,);

  factory Profile.fromJson(Map<String, dynamic> srcJson) => _$ProfileFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);

}


@JsonSerializable()
class Profile_publicity extends Object {

  @JsonKey(name: 'gender')
  String gender;

  @JsonKey(name: 'region')
  String region;

  @JsonKey(name: 'birth_day')
  String birthDay;

  @JsonKey(name: 'birth_year')
  String birthYear;

  @JsonKey(name: 'job')
  String job;

  @JsonKey(name: 'pawoo')
  bool pawoo;

  Profile_publicity(this.gender,this.region,this.birthDay,this.birthYear,this.job,this.pawoo,);

  factory Profile_publicity.fromJson(Map<String, dynamic> srcJson) => _$Profile_publicityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Profile_publicityToJson(this);

}


@JsonSerializable()
class Workspace extends Object {

  @JsonKey(name: 'pc')
  String pc;

  @JsonKey(name: 'monitor')
  String monitor;

  @JsonKey(name: 'tool')
  String tool;

  @JsonKey(name: 'scanner')
  String scanner;

  @JsonKey(name: 'tablet')
  String tablet;

  @JsonKey(name: 'mouse')
  String mouse;

  @JsonKey(name: 'printer')
  String printer;

  @JsonKey(name: 'desktop')
  String desktop;

  @JsonKey(name: 'music')
  String music;

  @JsonKey(name: 'desk')
  String desk;

  @JsonKey(name: 'chair')
  String chair;

  @JsonKey(name: 'comment')
  String comment;

  Workspace(this.pc,this.monitor,this.tool,this.scanner,this.tablet,this.mouse,this.printer,this.desktop,this.music,this.desk,this.chair,this.comment,);

  factory Workspace.fromJson(Map<String, dynamic> srcJson) => _$WorkspaceFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WorkspaceToJson(this);

}


