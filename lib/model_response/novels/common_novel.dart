// ignore_for_file: camel_case_types

import 'package:json_annotation/json_annotation.dart';
import 'package:artvier/model_response/user/common_user.dart';

part 'common_novel.g.dart';

@JsonSerializable()
class CommonNovel extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'caption')
  String caption;

  @JsonKey(name: 'restrict')
  int restrict;

  @JsonKey(name: 'x_restrict')
  int xRestrict;

  @JsonKey(name: 'is_original')
  bool isOriginal;

  @JsonKey(name: 'image_urls')
  Image_urls imageUrls;

  @JsonKey(name: 'create_date')
  DateTime createDate;

  @JsonKey(name: 'tags')
  List<Tags> tags;

  @JsonKey(name: 'page_count')
  int pageCount;

  @JsonKey(name: 'text_length')
  int textLength;

  @JsonKey(name: 'user')
  CommonUser user;

  @JsonKey(name: 'series')
  Series series;

  @JsonKey(name: 'is_bookmarked')
  bool isBookmarked;

  @JsonKey(name: 'total_bookmarks')
  int totalBookmarks;

  @JsonKey(name: 'total_view')
  int totalView;

  @JsonKey(name: 'visible')
  bool visible;

  @JsonKey(name: 'total_comments')
  int totalComments;

  @JsonKey(name: 'is_muted')
  bool isMuted;

  @JsonKey(name: 'is_mypixiv_only')
  bool isMypixivOnly;

  @JsonKey(name: 'is_x_restricted')
  bool isXRestricted;

  @JsonKey(name: "novel_ai_type")
  int novelAiType;

  CommonNovel(
    this.id,
    this.title,
    this.caption,
    this.restrict,
    this.xRestrict,
    this.isOriginal,
    this.imageUrls,
    this.createDate,
    this.tags,
    this.pageCount,
    this.textLength,
    this.user,
    this.series,
    this.isBookmarked,
    this.totalBookmarks,
    this.totalView,
    this.visible,
    this.totalComments,
    this.isMuted,
    this.isMypixivOnly,
    this.isXRestricted,
    this.novelAiType,
  );

  factory CommonNovel.fromJson(Map<String, dynamic> srcJson) => _$CommonNovelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommonNovelToJson(this);
}

@JsonSerializable()
class Image_urls extends Object {
  @JsonKey(name: 'square_medium')
  String squareMedium;

  @JsonKey(name: 'medium')
  String medium;

  @JsonKey(name: 'large')
  String large;

  Image_urls(
    this.squareMedium,
    this.medium,
    this.large,
  );

  factory Image_urls.fromJson(Map<String, dynamic> srcJson) => _$Image_urlsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Image_urlsToJson(this);
}

@JsonSerializable()
class Tags extends Object {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'translated_name')
  String? translatedName;

  @JsonKey(name: 'added_by_uploaded_user')
  bool addedByUploadedUser;

  Tags(
    this.name,
    this.translatedName,
    this.addedByUploadedUser,
  );

  factory Tags.fromJson(Map<String, dynamic> srcJson) => _$TagsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TagsToJson(this);
}

@JsonSerializable()
class Series extends Object {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'title')
  String? title;

  Series(this.id, this.title);

  factory Series.fromJson(Map<String, dynamic> srcJson) => _$SeriesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SeriesToJson(this);
}
