// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'novels_recommended.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NovelsRecommended _$NovelsRecommendedFromJson(Map<String, dynamic> json) =>
    NovelsRecommended(
      (json['novels'] as List<dynamic>)
          .map((e) => CommonNovel.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['ranking_novels'] as List<dynamic>)
          .map((e) => CommonNovel.fromJson(e as Map<String, dynamic>))
          .toList(),
      Privacy_policy.fromJson(json['privacy_policy'] as Map<String, dynamic>),
      json['next_url'] as String?,
    );

Map<String, dynamic> _$NovelsRecommendedToJson(NovelsRecommended instance) =>
    <String, dynamic>{
      'novels': instance.novels,
      'ranking_novels': instance.rankingNovels,
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
