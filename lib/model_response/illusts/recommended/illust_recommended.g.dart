// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

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
      json['next_url'] as String?,
    );

Map<String, dynamic> _$IllustRecommendedToJson(IllustRecommended instance) =>
    <String, dynamic>{
      'illusts': instance.illusts,
      'ranking_illusts': instance.rankingIllusts,
      'contest_exists': instance.contestExists,
      'privacy_policy': instance.privacyPolicy,
      'next_url': instance.nextUrl,
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
