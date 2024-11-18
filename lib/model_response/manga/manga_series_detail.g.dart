// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'manga_series_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MangaSeriesDetailResponseImpl _$$MangaSeriesDetailResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$MangaSeriesDetailResponseImpl(
      illustSeriesDetail: IllustSeriesDetail.fromJson(
          json['illust_series_detail'] as Map<String, dynamic>),
      illustSeriesFirstIllust: CommonIllust.fromJson(
          json['illust_series_first_illust'] as Map<String, dynamic>),
      illusts: (json['illusts'] as List<dynamic>)
          .map((e) => CommonIllust.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextUrl: json['next_url'],
    );

Map<String, dynamic> _$$MangaSeriesDetailResponseImplToJson(
        _$MangaSeriesDetailResponseImpl instance) =>
    <String, dynamic>{
      'illust_series_detail': instance.illustSeriesDetail,
      'illust_series_first_illust': instance.illustSeriesFirstIllust,
      'illusts': instance.illusts,
      'next_url': instance.nextUrl,
    };

_$IllustSeriesDetailImpl _$$IllustSeriesDetailImplFromJson(
        Map<String, dynamic> json) =>
    _$IllustSeriesDetailImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      caption: json['caption'] as String,
      coverImageUrls:
          ImageUrls.fromJson(json['cover_image_urls'] as Map<String, dynamic>),
      seriesWorkCount: (json['series_work_count'] as num).toInt(),
      createDate: DateTime.parse(json['create_date'] as String),
      width: (json['width'] as num).toInt(),
      height: (json['height'] as num).toInt(),
      user: CommonUser.fromJson(json['user'] as Map<String, dynamic>),
      watchlistAdded: json['watchlist_added'] as bool,
    );

Map<String, dynamic> _$$IllustSeriesDetailImplToJson(
        _$IllustSeriesDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'caption': instance.caption,
      'cover_image_urls': instance.coverImageUrls,
      'series_work_count': instance.seriesWorkCount,
      'create_date': instance.createDate.toIso8601String(),
      'width': instance.width,
      'height': instance.height,
      'user': instance.user,
      'watchlist_added': instance.watchlistAdded,
    };

_$ImageUrlsImpl _$$ImageUrlsImplFromJson(Map<String, dynamic> json) =>
    _$ImageUrlsImpl(
      medium: json['medium'] as String,
    );

Map<String, dynamic> _$$ImageUrlsImplToJson(_$ImageUrlsImpl instance) =>
    <String, dynamic>{
      'medium': instance.medium,
    };
