// To parse this JSON data, do
//
//     final novelSeriesDetailResponse = novelSeriesDetailResponseFromJson(jsonString);

import 'package:artvier/config/enums.dart';
import 'package:artvier/model_response/novels/common_novel.dart';
import 'package:artvier/model_response/user/common_user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'novel_series_detail.freezed.dart';
part 'novel_series_detail.g.dart';

NovelSeriesDetailResponse novelSeriesDetailResponseFromJson(String str) =>
    NovelSeriesDetailResponse.fromJson(json.decode(str));

String novelSeriesDetailResponseToJson(NovelSeriesDetailResponse data) => json.encode(data.toJson());

@freezed
class NovelSeriesDetailResponse with _$NovelSeriesDetailResponse {
  const factory NovelSeriesDetailResponse({
    @JsonKey(name: "novel_series_detail") required NovelSeriesDetail novelSeriesDetail,
    @JsonKey(name: "novel_series_first_novel") required CommonNovel novelSeriesFirstNovel,
    @JsonKey(name: "novel_series_latest_novel") required CommonNovel novelSeriesLatestNovel,
    @JsonKey(name: "novels") required List<CommonNovel> novels,
    @JsonKey(name: "next_url") String? nextUrl,
  }) = _NovelSeriesDetailResponse;

  factory NovelSeriesDetailResponse.fromJson(Map<String, dynamic> json) => _$NovelSeriesDetailResponseFromJson(json);
}

@freezed
class NovelSeriesDetail with _$NovelSeriesDetail {
  const factory NovelSeriesDetail({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "title") required String title,
    @JsonKey(name: "caption") required String caption,
    @JsonKey(name: "is_original") required bool isOriginal,
    @JsonKey(name: "is_concluded") required bool isConcluded,
    @JsonKey(name: "content_count") required int contentCount,
    @JsonKey(name: "total_character_count") required int totalCharacterCount,
    @JsonKey(name: "user") required CommonUser user,
    @JsonKey(name: "display_text") required String displayText,
    @JsonKey(name: "novel_ai_type") required int novelAiType,
    @JsonKey(name: "watchlist_added") required bool watchlistAdded,
    SeriesState? seriesWatchState,
  }) = _NovelSeriesDetail;

  factory NovelSeriesDetail.fromJson(Map<String, dynamic> json) => _$NovelSeriesDetailFromJson(json);
}

@freezed
class ImageUrls with _$ImageUrls {
  const factory ImageUrls({
    @JsonKey(name: "square_medium") required String squareMedium,
    @JsonKey(name: "medium") required String medium,
    @JsonKey(name: "large") required String large,
  }) = _ImageUrls;

  factory ImageUrls.fromJson(Map<String, dynamic> json) => _$ImageUrlsFromJson(json);
}
