// To parse this JSON data, do
//
//     final mangaSeriesDetailResponse = mangaSeriesDetailResponseFromJson(jsonString);

import 'package:artvier/model_response/illusts/common_illust.dart';
import 'package:artvier/model_response/user/common_user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'manga_series_detail.freezed.dart';
part 'manga_series_detail.g.dart';

MangaSeriesDetailResponse mangaSeriesDetailResponseFromJson(String str) =>
    MangaSeriesDetailResponse.fromJson(json.decode(str));

String mangaSeriesDetailResponseToJson(MangaSeriesDetailResponse data) => json.encode(data.toJson());

@freezed
class MangaSeriesDetailResponse with _$MangaSeriesDetailResponse {
  const factory MangaSeriesDetailResponse({
    @JsonKey(name: "illust_series_detail") required IllustSeriesDetail illustSeriesDetail,
    @JsonKey(name: "illust_series_first_illust") required CommonIllust illustSeriesFirstIllust,
    @JsonKey(name: "illusts") required List<CommonIllust> illusts,
    @JsonKey(name: "next_url") required dynamic nextUrl,
  }) = _MangaSeriesDetailResponse;

  factory MangaSeriesDetailResponse.fromJson(Map<String, dynamic> json) => _$MangaSeriesDetailResponseFromJson(json);
}

@freezed
class IllustSeriesDetail with _$IllustSeriesDetail {
  const factory IllustSeriesDetail({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "title") required String title,
    @JsonKey(name: "caption") required String caption,
    @JsonKey(name: "cover_image_urls") required ImageUrls coverImageUrls,
    @JsonKey(name: "series_work_count") required int seriesWorkCount,
    @JsonKey(name: "create_date") required DateTime createDate,
    @JsonKey(name: "width") required int width,
    @JsonKey(name: "height") required int height,
    @JsonKey(name: "user") required CommonUser user,
    @JsonKey(name: "watchlist_added") required bool watchlistAdded,
  }) = _IllustSeriesDetail;

  factory IllustSeriesDetail.fromJson(Map<String, dynamic> json) => _$IllustSeriesDetailFromJson(json);
}

@freezed
class ImageUrls with _$ImageUrls {
  const factory ImageUrls({
    @JsonKey(name: "medium") required String medium,
  }) = _ImageUrls;

  factory ImageUrls.fromJson(Map<String, dynamic> json) => _$ImageUrlsFromJson(json);
}
