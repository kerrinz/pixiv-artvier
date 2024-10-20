// To parse this JSON data, do
//
//     final NovelSeries = NovelSeriesFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'novel_series_list.freezed.dart';
part 'novel_series_list.g.dart';

NovelSeriesListResponse novelSeriesListResponseFromJson(String str) =>
    NovelSeriesListResponse.fromJson(json.decode(str));

String novelSeriesListResponseToJson(NovelSeriesListResponse data) => json.encode(data.toJson());

NovelSeries novelSeriesFromJson(String str) => NovelSeries.fromJson(json.decode(str));

String novelSeriesToJson(NovelSeries data) => json.encode(data.toJson());

@freezed
class NovelSeriesListResponse with _$NovelSeriesListResponse {
  const factory NovelSeriesListResponse({
    @JsonKey(name: "series") required List<NovelSeries> series,
    @JsonKey(name: "next_url") required String? nextUrl,
  }) = _NovelSeriesListResponse;

  factory NovelSeriesListResponse.fromJson(Map<String, dynamic> json) => _$NovelSeriesListResponseFromJson(json);
}

@freezed
class NovelSeries with _$NovelSeries {
  const factory NovelSeries({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "title") required String title,
    @JsonKey(name: "url") required String url,
    @JsonKey(name: "mask_text") required dynamic maskText,
    @JsonKey(name: "published_content_count") required int publishedContentCount,
    @JsonKey(name: "last_published_content_datetime") required DateTime lastPublishedContentDatetime,
    @JsonKey(name: "latest_content_id") required int latestContentId,
    @JsonKey(name: "user") required User user,
  }) = _NovelSeries;

  factory NovelSeries.fromJson(Map<String, dynamic> json) => _$NovelSeriesFromJson(json);
}

@freezed
class User with _$User {
  const factory User({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "name") required String name,
    @JsonKey(name: "account") required String account,
    @JsonKey(name: "profile_image_urls") required ProfileImageUrls profileImageUrls,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class ProfileImageUrls with _$ProfileImageUrls {
  const factory ProfileImageUrls({
    @JsonKey(name: "medium") required String medium,
  }) = _ProfileImageUrls;

  factory ProfileImageUrls.fromJson(Map<String, dynamic> json) => _$ProfileImageUrlsFromJson(json);
}
