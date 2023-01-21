// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'user_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetail _$UserDetailFromJson(Map<String, dynamic> json) => UserDetail(
      CommonUser.fromJson(json['user'] as Map<String, dynamic>),
      Profile.fromJson(json['profile'] as Map<String, dynamic>),
      Profile_publicity.fromJson(
          json['profile_publicity'] as Map<String, dynamic>),
      Workspace.fromJson(json['workspace'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDetailToJson(UserDetail instance) =>
    <String, dynamic>{
      'user': instance.user,
      'profile': instance.profile,
      'profile_publicity': instance.profilePublicity,
      'workspace': instance.workspace,
    };

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      json['webpage'] as String?,
      json['gender'] as String,
      json['birth'] as String,
      json['birth_day'] as String,
      json['birth_year'] as int,
      json['region'] as String,
      json['address_id'] as int,
      json['country_code'] as String,
      json['job'] as String,
      json['job_id'] as int,
      json['total_follow_users'] as int,
      json['total_mypixiv_users'] as int,
      json['total_illusts'] as int,
      json['total_manga'] as int,
      json['total_novels'] as int,
      json['total_illust_bookmarks_public'] as int,
      json['total_illust_series'] as int,
      json['total_novel_series'] as int,
      json['twitter_account'] as String,
      json['twitter_url'] as String?,
      json['is_premium'] as bool,
      json['is_using_custom_profile_image'] as bool,
    )
      ..backgroundImageUrl = json['background_image_url'] as String?
      ..pawooUrl = json['pawoo_url'] as String?;

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'webpage': instance.webpage,
      'gender': instance.gender,
      'birth': instance.birth,
      'birth_day': instance.birthDay,
      'birth_year': instance.birthYear,
      'region': instance.region,
      'address_id': instance.addressId,
      'country_code': instance.countryCode,
      'job': instance.job,
      'job_id': instance.jobId,
      'total_follow_users': instance.totalFollowUsers,
      'total_mypixiv_users': instance.totalMypixivUsers,
      'total_illusts': instance.totalIllusts,
      'total_manga': instance.totalManga,
      'total_novels': instance.totalNovels,
      'total_illust_bookmarks_public': instance.totalIllustBookmarksPublic,
      'total_illust_series': instance.totalIllustSeries,
      'total_novel_series': instance.totalNovelSeries,
      'background_image_url': instance.backgroundImageUrl,
      'twitter_account': instance.twitterAccount,
      'twitter_url': instance.twitterUrl,
      'pawoo_url': instance.pawooUrl,
      'is_premium': instance.isPremium,
      'is_using_custom_profile_image': instance.isUsingCustomProfileImage,
    };

Profile_publicity _$Profile_publicityFromJson(Map<String, dynamic> json) =>
    Profile_publicity(
      json['gender'] as String,
      json['region'] as String,
      json['birth_day'] as String,
      json['birth_year'] as String,
      json['job'] as String,
      json['pawoo'] as bool,
    );

Map<String, dynamic> _$Profile_publicityToJson(Profile_publicity instance) =>
    <String, dynamic>{
      'gender': instance.gender,
      'region': instance.region,
      'birth_day': instance.birthDay,
      'birth_year': instance.birthYear,
      'job': instance.job,
      'pawoo': instance.pawoo,
    };

Workspace _$WorkspaceFromJson(Map<String, dynamic> json) => Workspace(
      json['pc'] as String,
      json['monitor'] as String,
      json['tool'] as String,
      json['scanner'] as String,
      json['tablet'] as String,
      json['mouse'] as String,
      json['printer'] as String,
      json['desktop'] as String,
      json['music'] as String,
      json['desk'] as String,
      json['chair'] as String,
      json['comment'] as String,
    );

Map<String, dynamic> _$WorkspaceToJson(Workspace instance) => <String, dynamic>{
      'pc': instance.pc,
      'monitor': instance.monitor,
      'tool': instance.tool,
      'scanner': instance.scanner,
      'tablet': instance.tablet,
      'mouse': instance.mouse,
      'printer': instance.printer,
      'desktop': instance.desktop,
      'music': instance.music,
      'desk': instance.desk,
      'chair': instance.chair,
      'comment': instance.comment,
    };
