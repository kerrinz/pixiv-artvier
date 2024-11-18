// To parse this JSON data, do
//
//     final novelDetailWebView = novelDetailWebViewFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'novel_detail_webview.freezed.dart';
part 'novel_detail_webview.g.dart';

NovelDetailWebView novelDetailWebViewFromJson(String str) => NovelDetailWebView.fromJson(json.decode(str));

String novelDetailWebViewToJson(NovelDetailWebView data) => json.encode(data.toJson());

@freezed
class NovelDetailWebView with _$NovelDetailWebView {
  const factory NovelDetailWebView({
    @JsonKey(name: "id") required String id,
    @JsonKey(name: "title") required String title,
    @JsonKey(name: "seriesId") required dynamic seriesId,
    @JsonKey(name: "seriesTitle") required dynamic seriesTitle,
    @JsonKey(name: "seriesIsWatched") required dynamic seriesIsWatched,
    @JsonKey(name: "userId") required String userId,
    @JsonKey(name: "coverUrl") required String coverUrl,
    @JsonKey(name: "tags") required List<String> tags,
    @JsonKey(name: "caption") required String caption,
    @JsonKey(name: "cdate") required DateTime cdate,
    @JsonKey(name: "rating") required Rating rating,
    @JsonKey(name: "text") required String text,
    @JsonKey(name: "marker") required dynamic marker,
    @JsonKey(name: "illusts") required Map<String, IllustValue> illusts,
    @JsonKey(name: "images") required Map<String, Image> images,
    @JsonKey(name: "seriesNavigation") SeriesNavigation? seriesNavigation,
    @JsonKey(name: "glossaryItems") required dynamic glossaryItems,
    @JsonKey(name: "replaceableItemIds") required dynamic replaceableItemIds,
    @JsonKey(name: "aiType") required int aiType,
    @JsonKey(name: "isOriginal") required bool isOriginal,
  }) = _NovelDetailWebView;

  factory NovelDetailWebView.fromJson(Map<String, dynamic> json) => _$NovelDetailWebViewFromJson(json);
}

@freezed
class IllustValue with _$IllustValue {
  const factory IllustValue({
    @JsonKey(name: "visible") required bool visible,
    @JsonKey(name: "availableMessage") required dynamic availableMessage,
    @JsonKey(name: "illust") required IllustIllust illust,
    @JsonKey(name: "user") required User user,
    @JsonKey(name: "id") required String id,
    @JsonKey(name: "page") required int page,
  }) = _IllustValue;

  factory IllustValue.fromJson(Map<String, dynamic> json) => _$IllustValueFromJson(json);
}

@freezed
class IllustIllust with _$IllustIllust {
  const factory IllustIllust({
    @JsonKey(name: "title") required String title,
    @JsonKey(name: "description") required String description,
    @JsonKey(name: "restrict") required int restrict,
    @JsonKey(name: "xRestrict") required int xRestrict,
    @JsonKey(name: "sl") required int sl,
    @JsonKey(name: "tags") required List<Tag> tags,
    @JsonKey(name: "images") required Images images,
  }) = _IllustIllust;

  factory IllustIllust.fromJson(Map<String, dynamic> json) => _$IllustIllustFromJson(json);
}

@freezed
class Images with _$Images {
  const factory Images({
    @JsonKey(name: "small") required dynamic small,
    @JsonKey(name: "medium") required String medium,
    @JsonKey(name: "original") required dynamic original,
  }) = _Images;

  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);
}

@freezed
class Tag with _$Tag {
  const factory Tag({
    @JsonKey(name: "tag") required String tag,
    @JsonKey(name: "userId") required String userId,
  }) = _Tag;

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
}

@freezed
class User with _$User {
  const factory User({
    @JsonKey(name: "id") required String id,
    @JsonKey(name: "name") required String name,
    @JsonKey(name: "image") required String image,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class Image with _$Image {
  const factory Image({
    @JsonKey(name: "novelImageId") required String novelImageId,
    @JsonKey(name: "sl") required String sl,
    @JsonKey(name: "urls") required Urls urls,
  }) = _Image;

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
}

@freezed
class Urls with _$Urls {
  const factory Urls({
    @JsonKey(name: "240mw") required String the240Mw,
    @JsonKey(name: "480mw") required String the480Mw,
    @JsonKey(name: "1200x1200") required String the1200X1200,
    @JsonKey(name: "128x128") required String the128X128,
    @JsonKey(name: "original") required String original,
  }) = _Urls;

  factory Urls.fromJson(Map<String, dynamic> json) => _$UrlsFromJson(json);
}

@freezed
class Rating with _$Rating {
  const factory Rating({
    @JsonKey(name: "like") required int like,
    @JsonKey(name: "bookmark") required int bookmark,
    @JsonKey(name: "view") required int view,
  }) = _Rating;

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);
}

@freezed
class SeriesNavigation with _$SeriesNavigation {
  const factory SeriesNavigation({
    @JsonKey(name: "nextNovel") PrevNovel? nextNovel,
    @JsonKey(name: "prevNovel") PrevNovel? prevNovel,
  }) = _SeriesNavigation;

  factory SeriesNavigation.fromJson(Map<String, dynamic> json) => _$SeriesNavigationFromJson(json);
}

@freezed
class PrevNovel with _$PrevNovel {
  const factory PrevNovel({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "viewable") required bool viewable,
    @JsonKey(name: "contentOrder") required String contentOrder,
    @JsonKey(name: "title") required String title,
    @JsonKey(name: "coverUrl") required String coverUrl,
    @JsonKey(name: "viewableMessage") required dynamic viewableMessage,
  }) = _PrevNovel;

  factory PrevNovel.fromJson(Map<String, dynamic> json) => _$PrevNovelFromJson(json);
}
