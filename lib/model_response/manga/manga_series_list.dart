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
  const MangaSeries._();

  const factory MangaSeries({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "title", fromJson: _stringOrEmpty) @Default('') String title,
    /// 系列封面。屏蔽或下架时为 null。
    @JsonKey(name: "url") String? url,
    @JsonKey(name: "mask_text") String? maskText,
    @JsonKey(name: "published_content_count", fromJson: _intOrZero) @Default(0) int publishedContentCount,
    /// 最近更新时间。没有更新记录时为 null。
    @JsonKey(name: "last_published_content_datetime", fromJson: _dateTimeOrNull) DateTime? lastPublishedContentDatetime,
    /// 最新一话的作品 id。没有可打开的话数时为 null。
    @JsonKey(name: "latest_content_id", fromJson: _intOrNull) int? latestContentId,
    @JsonKey(name: "user") User? user,
  }) = _MangaSeries;

  factory MangaSeries.fromJson(Map<String, dynamic> json) => _$MangaSeriesFromJson(json);

  /// 被屏蔽或下架的占位条目：服务端只给 [maskText]，封面为空。
  bool get isMasked => (maskText?.isNotEmpty ?? false) && (url == null || url!.isEmpty);
}

@freezed
class User with _$User {
  const factory User({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "name", fromJson: _stringOrEmpty) @Default('') String name,
    @JsonKey(name: "account") String? account,
    @JsonKey(name: "profile_image_urls") ProfileImageUrls? profileImageUrls,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class ProfileImageUrls with _$ProfileImageUrls {
  const factory ProfileImageUrls({
    @JsonKey(name: "medium") String? medium,
  }) = _ProfileImageUrls;

  factory ProfileImageUrls.fromJson(Map<String, dynamic> json) => _$ProfileImageUrlsFromJson(json);
}

String _stringOrEmpty(Object? value) => value is String ? value : '';

int _intOrZero(Object? value) => value is num ? value.toInt() : 0;

int? _intOrNull(Object? value) => value is num ? value.toInt() : null;

DateTime? _dateTimeOrNull(Object? value) {
  if (value is! String || value.isEmpty) return null;
  return DateTime.tryParse(value);
}
