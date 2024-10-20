// To parse this JSON data, do
//
//     final mangaSeries = mangaSeriesFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'manga_series_list.freezed.dart';
part 'manga_series_list.g.dart';

MangaSeriesListResponse mangaSeriesListResponseFromJson(String str) =>
    MangaSeriesListResponse.fromJson(json.decode(str));

String mangaSeriesListResponseToJson(MangaSeriesListResponse data) => json.encode(data.toJson());

MangaSeries mangaSeriesFromJson(String str) => MangaSeries.fromJson(json.decode(str));

String mangaSeriesToJson(MangaSeries data) => json.encode(data.toJson());

@freezed
class MangaSeriesListResponse with _$MangaSeriesListResponse {
  const factory MangaSeriesListResponse({
    @JsonKey(name: "series") required List<MangaSeries> series,
    @JsonKey(name: "next_url") required String? nextUrl,
  }) = _MangaSeriesListResponse;

  factory MangaSeriesListResponse.fromJson(Map<String, dynamic> json) => _$MangaSeriesListResponseFromJson(json);
}

@freezed
class MangaSeries with _$MangaSeries {
  const factory MangaSeries({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "title") required String title,
    @JsonKey(name: "url") required String url,
    @JsonKey(name: "mask_text") required String? maskText,
    @JsonKey(name: "published_content_count") required int publishedContentCount,
    @JsonKey(name: "last_published_content_datetime") required DateTime lastPublishedContentDatetime,
    @JsonKey(name: "latest_content_id") required int latestContentId,
    @JsonKey(name: "user") required User user,
  }) = _MangaSeries;

  factory MangaSeries.fromJson(Map<String, dynamic> json) => _$MangaSeriesFromJson(json);
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
