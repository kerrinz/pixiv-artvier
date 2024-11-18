// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'novel_series_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NovelSeriesListResponseImpl _$$NovelSeriesListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$NovelSeriesListResponseImpl(
      series: (json['series'] as List<dynamic>)
          .map((e) => NovelSeries.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextUrl: json['next_url'] as String?,
    );

Map<String, dynamic> _$$NovelSeriesListResponseImplToJson(
        _$NovelSeriesListResponseImpl instance) =>
    <String, dynamic>{
      'series': instance.series,
      'next_url': instance.nextUrl,
    };

_$NovelSeriesImpl _$$NovelSeriesImplFromJson(Map<String, dynamic> json) =>
    _$NovelSeriesImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      url: json['url'] as String,
      maskText: json['mask_text'],
      publishedContentCount: (json['published_content_count'] as num).toInt(),
      lastPublishedContentDatetime:
          DateTime.parse(json['last_published_content_datetime'] as String),
      latestContentId: (json['latest_content_id'] as num).toInt(),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$NovelSeriesImplToJson(_$NovelSeriesImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'url': instance.url,
      'mask_text': instance.maskText,
      'published_content_count': instance.publishedContentCount,
      'last_published_content_datetime':
          instance.lastPublishedContentDatetime.toIso8601String(),
      'latest_content_id': instance.latestContentId,
      'user': instance.user,
    };

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      account: json['account'] as String,
      profileImageUrls: ProfileImageUrls.fromJson(
          json['profile_image_urls'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'account': instance.account,
      'profile_image_urls': instance.profileImageUrls,
    };

_$ProfileImageUrlsImpl _$$ProfileImageUrlsImplFromJson(
        Map<String, dynamic> json) =>
    _$ProfileImageUrlsImpl(
      medium: json['medium'] as String,
    );

Map<String, dynamic> _$$ProfileImageUrlsImplToJson(
        _$ProfileImageUrlsImpl instance) =>
    <String, dynamic>{
      'medium': instance.medium,
    };
