// ignore_for_file: camel_case_types

import 'package:json_annotation/json_annotation.dart';

part 'common_illust.g.dart';


@JsonSerializable()
class CommonIllust extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'image_urls')
  Image_urls imageUrls;

  @JsonKey(name: 'caption')
  String caption;

  @JsonKey(name: 'restrict')
  int restrict;

  @JsonKey(name: 'user')
  User user;

  @JsonKey(name: 'tags')
  List<Tags> tags;

  @JsonKey(name: 'tools')
  List<dynamic> tools;

  @JsonKey(name: 'create_date')
  String createDate;

  @JsonKey(name: 'page_count')
  int pageCount;

  @JsonKey(name: 'width')
  int width;

  @JsonKey(name: 'height')
  int height;

  @JsonKey(name: 'sanity_level')
  int sanityLevel;

  @JsonKey(name: 'x_restrict')
  int xRestrict;

  @JsonKey(name: 'meta_single_page')
  Meta_single_page metaSinglePage;

  @JsonKey(name: 'meta_pages')
  List<MetaPages> metaPages;

  @JsonKey(name: 'total_view')
  int totalView;

  @JsonKey(name: 'total_bookmarks')
  int totalBookmarks;

  @JsonKey(name: 'is_bookmarked')
  bool isBookmarked;

  @JsonKey(name: 'visible')
  bool visible;

  @JsonKey(name: 'is_muted')
  bool isMuted;

  CommonIllust(this.id,this.title,this.type,this.imageUrls,this.caption,this.restrict,this.user,this.tags,this.tools,this.createDate,this.pageCount,this.width,this.height,this.sanityLevel,this.xRestrict,this.metaSinglePage,this.metaPages,this.totalView,this.totalBookmarks,this.isBookmarked,this.visible,this.isMuted,);

  factory CommonIllust.fromJson(Map<String, dynamic> srcJson) => _$CommonIllustFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommonIllustToJson(this);

}


@JsonSerializable()
class Image_urls extends Object {

  @JsonKey(name: 'square_medium')
  String squareMedium;

  @JsonKey(name: 'medium')
  String medium;

  @JsonKey(name: 'large')
  String large;

  @JsonKey(name: 'original')
  String? original;

  Image_urls(this.squareMedium,this.medium,this.large,this.original);

  factory Image_urls.fromJson(Map<String, dynamic> srcJson) => _$Image_urlsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Image_urlsToJson(this);

}


@JsonSerializable()
class User extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'account')
  String account;

  @JsonKey(name: 'profile_image_urls')
  Profile_image_urls profileImageUrls;

  /// 已删除或不公开的图片会不存在此字段
  @JsonKey(name: 'is_followed')
  bool? isFollowed;

  User(this.id,this.name,this.account,this.profileImageUrls,this.isFollowed,);

  factory User.fromJson(Map<String, dynamic> srcJson) => _$UserFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserToJson(this);

}


@JsonSerializable()
class Profile_image_urls extends Object {

  @JsonKey(name: 'medium')
  String medium;

  Profile_image_urls(this.medium,);

  factory Profile_image_urls.fromJson(Map<String, dynamic> srcJson) => _$Profile_image_urlsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Profile_image_urlsToJson(this);

}


@JsonSerializable()
class Tags extends Object {

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'translated_name')
  String? translatedName;

  Tags(this.name,this.translatedName,);

  factory Tags.fromJson(Map<String, dynamic> srcJson) => _$TagsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TagsToJson(this);

}


@JsonSerializable()
class Meta_single_page extends Object {

  @JsonKey(name: 'original_image_url')
  String? originalImageUrl;

  Meta_single_page(this.originalImageUrl,);

  factory Meta_single_page.fromJson(Map<String, dynamic> srcJson) => _$Meta_single_pageFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Meta_single_pageToJson(this);

}

@JsonSerializable()
class MetaPages extends Object {

  @JsonKey(name: 'image_urls')
  Image_urls imageUrls;

  MetaPages(this.imageUrls,);

  factory MetaPages.fromJson(Map<String, dynamic> srcJson) => _$MetaPagesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MetaPagesToJson(this);

}
