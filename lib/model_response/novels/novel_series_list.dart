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
  const NovelSeries._();

  const factory NovelSeries({
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
  }) = _NovelSeries;

  factory NovelSeries.fromJson(Map<String, dynamic> json) => _$NovelSeriesFromJson(json);

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
