// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'illust_recommended.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IllustRecommended _$IllustRecommendedFromJson(Map<String, dynamic> json) =>
    IllustRecommended(
      (json['illusts'] as List<dynamic>)
          .map((e) => CommonIllust.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['ranking_illusts'] as List<dynamic>)
          .map((e) => CommonIllust.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['contest_exists'] as bool,
      Privacy_policy.fromJson(json['privacy_policy'] as Map<String, dynamic>),
      json['next_url'] as String,
    );

Map<String, dynamic> _$IllustRecommendedToJson(IllustRecommended instance) =>
    <String, dynamic>{
      'illusts': instance.illusts,
      'ranking_illusts': instance.rankingIllusts,
      'contest_exists': instance.contestExists,
      'privacy_policy': instance.privacyPolicy,
      'next_url': instance.nextUrl,
    };

Image_urls _$Image_urlsFromJson(Map<String, dynamic> json) => Image_urls(
      json['square_medium'] as String,
      json['medium'] as String,
      json['large'] as String,
    );

Map<String, dynamic> _$Image_urlsToJson(Image_urls instance) =>
    <String, dynamic>{
      'square_medium': instance.squareMedium,
      'medium': instance.medium,
      'large': instance.large,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['id'] as int,
      json['name'] as String,
      json['account'] as String,
      Profile_image_urls.fromJson(
          json['profile_image_urls'] as Map<String, dynamic>),
      json['is_followed'] as bool,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'account': instance.account,
      'profile_image_urls': instance.profileImageUrls,
      'is_followed': instance.isFollowed,
    };

Profile_image_urls _$Profile_image_urlsFromJson(Map<String, dynamic> json) =>
    Profile_image_urls(
      json['medium'] as String,
    );

Map<String, dynamic> _$Profile_image_urlsToJson(Profile_image_urls instance) =>
    <String, dynamic>{
      'medium': instance.medium,
    };

Tags _$TagsFromJson(Map<String, dynamic> json) => Tags(
      json['name'] as String,
    );

Map<String, dynamic> _$TagsToJson(Tags instance) => <String, dynamic>{
      'name': instance.name,
    };

Meta_single_page _$Meta_single_pageFromJson(Map<String, dynamic> json) =>
    Meta_single_page(
      json['original_image_url'] as String?,
    );

Map<String, dynamic> _$Meta_single_pageToJson(Meta_single_page instance) =>
    <String, dynamic>{
      'original_image_url': instance.originalImageUrl,
    };

Privacy_policy _$Privacy_policyFromJson(Map<String, dynamic> json) =>
    Privacy_policy(
      json['version'] as String?,
      json['message'] as String?,
      json['url'] as String?,
    );

Map<String, dynamic> _$Privacy_policyToJson(Privacy_policy instance) =>
    <String, dynamic>{
      'version': instance.version,
      'message': instance.message,
      'url': instance.url,
    };
