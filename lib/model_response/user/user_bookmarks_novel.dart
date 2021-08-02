import 'package:json_annotation/json_annotation.dart';

part 'user_bookmarks_novel.g.dart';


@JsonSerializable()
class UserBookmarksNovel extends Object {

  @JsonKey(name: 'novels')
  List<Novels> novels;

  UserBookmarksNovel(this.novels,);

  factory UserBookmarksNovel.fromJson(Map<String, dynamic> srcJson) => _$UserBookmarksNovelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserBookmarksNovelToJson(this);

}


@JsonSerializable()
class Novels extends Object {

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
  String createDate;

  @JsonKey(name: 'tags')
  List<Tags> tags;

  @JsonKey(name: 'page_count')
  int pageCount;

  @JsonKey(name: 'text_length')
  int textLength;

  @JsonKey(name: 'user')
  User user;

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

  Novels(this.id,this.title,this.caption,this.restrict,this.xRestrict,this.isOriginal,this.imageUrls,this.createDate,this.tags,this.pageCount,this.textLength,this.user,this.series,this.isBookmarked,this.totalBookmarks,this.totalView,this.visible,this.totalComments,this.isMuted,this.isMypixivOnly,this.isXRestricted,);

  factory Novels.fromJson(Map<String, dynamic> srcJson) => _$NovelsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NovelsToJson(this);

}


@JsonSerializable()
class Image_urls extends Object {

  @JsonKey(name: 'square_medium')
  String squareMedium;

  @JsonKey(name: 'medium')
  String medium;

  @JsonKey(name: 'large')
  String large;

  Image_urls(this.squareMedium,this.medium,this.large,);

  factory Image_urls.fromJson(Map<String, dynamic> srcJson) => _$Image_urlsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Image_urlsToJson(this);

}


@JsonSerializable()
class Tags extends Object {

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'translated_name')
  String translatedName;

  @JsonKey(name: 'added_by_uploaded_user')
  bool addedByUploadedUser;

  Tags(this.name,this.translatedName,this.addedByUploadedUser,);

  factory Tags.fromJson(Map<String, dynamic> srcJson) => _$TagsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TagsToJson(this);

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

  @JsonKey(name: 'is_followed')
  bool isFollowed;

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
class Series extends Object {

  Series();

  factory Series.fromJson(Map<String, dynamic> srcJson) => _$SeriesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SeriesToJson(this);

}


