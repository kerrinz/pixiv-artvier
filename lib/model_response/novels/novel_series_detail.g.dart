// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'novel_series_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NovelSeriesDetailResponseImpl _$$NovelSeriesDetailResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$NovelSeriesDetailResponseImpl(
      novelSeriesDetail: NovelSeriesDetail.fromJson(
          json['novel_series_detail'] as Map<String, dynamic>),
      novelSeriesFirstNovel: CommonNovel.fromJson(
          json['novel_series_first_novel'] as Map<String, dynamic>),
      novelSeriesLatestNovel: CommonNovel.fromJson(
          json['novel_series_latest_novel'] as Map<String, dynamic>),
      novels: (json['novels'] as List<dynamic>)
          .map((e) => CommonNovel.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextUrl: json['next_url'] as String?,
    );

Map<String, dynamic> _$$NovelSeriesDetailResponseImplToJson(
        _$NovelSeriesDetailResponseImpl instance) =>
    <String, dynamic>{
      'novel_series_detail': instance.novelSeriesDetail,
      'novel_series_first_novel': instance.novelSeriesFirstNovel,
      'novel_series_latest_novel': instance.novelSeriesLatestNovel,
      'novels': instance.novels,
      'next_url': instance.nextUrl,
    };

_$NovelSeriesDetailImpl _$$NovelSeriesDetailImplFromJson(
        Map<String, dynamic> json) =>
    _$NovelSeriesDetailImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      caption: json['caption'] as String,
      isOriginal: json['is_original'] as bool,
      isConcluded: json['is_concluded'] as bool,
      contentCount: (json['content_count'] as num).toInt(),
      totalCharacterCount: (json['total_character_count'] as num).toInt(),
      user: CommonUser.fromJson(json['user'] as Map<String, dynamic>),
      displayText: json['display_text'] as String,
      novelAiType: (json['novel_ai_type'] as num).toInt(),
      watchlistAdded: json['watchlist_added'] as bool,
    );

Map<String, dynamic> _$$NovelSeriesDetailImplToJson(
        _$NovelSeriesDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'caption': instance.caption,
      'is_original': instance.isOriginal,
      'is_concluded': instance.isConcluded,
      'content_count': instance.contentCount,
      'total_character_count': instance.totalCharacterCount,
      'user': instance.user,
      'display_text': instance.displayText,
      'novel_ai_type': instance.novelAiType,
      'watchlist_added': instance.watchlistAdded,
    };

_$ImageUrlsImpl _$$ImageUrlsImplFromJson(Map<String, dynamic> json) =>
    _$ImageUrlsImpl(
      squareMedium: json['square_medium'] as String,
      medium: json['medium'] as String,
      large: json['large'] as String,
    );

Map<String, dynamic> _$$ImageUrlsImplToJson(_$ImageUrlsImpl instance) =>
    <String, dynamic>{
      'square_medium': instance.squareMedium,
      'medium': instance.medium,
      'large': instance.large,
    };
