// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'illust_trending_tags.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IllustTrendingTags _$IllustTrendingTagsFromJson(Map<String, dynamic> json) =>
    IllustTrendingTags(
      (json['trend_tags'] as List<dynamic>)
          .map((e) => TrendTags.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$IllustTrendingTagsToJson(IllustTrendingTags instance) =>
    <String, dynamic>{
      'trend_tags': instance.trendTags,
    };

TrendTags _$TrendTagsFromJson(Map<String, dynamic> json) => TrendTags(
      json['tag'] as String,
      json['translated_name'] as String?,
      CommonIllust.fromJson(json['illust'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TrendTagsToJson(TrendTags instance) => <String, dynamic>{
      'tag': instance.tag,
      'translated_name': instance.translatedName,
      'illust': instance.illust,
    };
