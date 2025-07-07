// To parse this JSON data, do
//
//     final markedNovelsResponse = markedNovelsResponseFromJson(jsonString);

import 'package:artvier/model_response/novels/common_novel.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'marker_novel.freezed.dart';
part 'marker_novel.g.dart';

MarkedNovelsResponse markedNovelsResponseFromJson(String str) => MarkedNovelsResponse.fromJson(json.decode(str));

String markedNovelsResponseToJson(MarkedNovelsResponse data) => json.encode(data.toJson());

@freezed
class MarkedNovelsResponse with _$MarkedNovelsResponse {
  const factory MarkedNovelsResponse({
    @JsonKey(name: "marked_novels") required List<MarkedNovel> markedNovels,
    @JsonKey(name: "next_url") required dynamic nextUrl,
  }) = _MarkedNovelsResponse;

  factory MarkedNovelsResponse.fromJson(Map<String, dynamic> json) => _$MarkedNovelsResponseFromJson(json);
}

@freezed
class MarkedNovel with _$MarkedNovel {
  const factory MarkedNovel({
    @JsonKey(name: "novel") required CommonNovel novel,
    @JsonKey(name: "novel_marker") required NovelMarker novelMarker,
  }) = _MarkedNovel;

  factory MarkedNovel.fromJson(Map<String, dynamic> json) => _$MarkedNovelFromJson(json);
}

@freezed
class NovelMarker with _$NovelMarker {
  const factory NovelMarker({
    @JsonKey(name: "page") required int page,
  }) = _NovelMarker;

  factory NovelMarker.fromJson(Map<String, dynamic> json) => _$NovelMarkerFromJson(json);
}
