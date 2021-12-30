// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'user_bookmarks_novel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBookmarksNovel _$UserBookmarksNovelFromJson(Map<String, dynamic> json) {
  return UserBookmarksNovel(
    (json['novels'] as List<dynamic>)
        .map((e) => Novels.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$UserBookmarksNovelToJson(UserBookmarksNovel instance) =>
    <String, dynamic>{
      'novels': instance.novels,
    };

Novels _$NovelsFromJson(Map<String, dynamic> json) {
  return Novels(
    json['id'] as int,
    json['title'] as String,
    json['caption'] as String,
    json['restrict'] as int,
    json['x_restrict'] as int,
    json['is_original'] as bool,
    Image_urls.fromJson(json['image_urls'] as Map<String, dynamic>),
    json['create_date'] as String,
    (json['tags'] as List<dynamic>)
        .map((e) => Tags.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['page_count'] as int,
    json['text_length'] as int,
    User.fromJson(json['user'] as Map<String, dynamic>),
    Series.fromJson(json['series'] as Map<String, dynamic>),
    json['is_bookmarked'] as bool,
    json['total_bookmarks'] as int,
    json['total_view'] as int,
    json['visible'] as bool,
    json['total_comments'] as int,
    json['is_muted'] as bool,
    json['is_mypixiv_only'] as bool,
    json['is_x_restricted'] as bool,
  );
}

Map<String, dynamic> _$NovelsToJson(Novels instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'caption': instance.caption,
      'restrict': instance.restrict,
      'x_restrict': instance.xRestrict,
      'is_original': instance.isOriginal,
      'image_urls': instance.imageUrls,
      'create_date': instance.createDate,
      'tags': instance.tags,
      'page_count': instance.pageCount,
      'text_length': instance.textLength,
      'user': instance.user,
      'series': instance.series,
      'is_bookmarked': instance.isBookmarked,
      'total_bookmarks': instance.totalBookmarks,
      'total_view': instance.totalView,
      'visible': instance.visible,
      'total_comments': instance.totalComments,
      'is_muted': instance.isMuted,
      'is_mypixiv_only': instance.isMypixivOnly,
      'is_x_restricted': instance.isXRestricted,
    };

Image_urls _$Image_urlsFromJson(Map<String, dynamic> json) {
  return Image_urls(
    json['square_medium'] as String,
    json['medium'] as String,
    json['large'] as String,
  );
}

Map<String, dynamic> _$Image_urlsToJson(Image_urls instance) =>
    <String, dynamic>{
      'square_medium': instance.squareMedium,
      'medium': instance.medium,
      'large': instance.large,
    };

Tags _$TagsFromJson(Map<String, dynamic> json) {
  return Tags(
    json['name'] as String,
    json['translated_name'] as String,
    json['added_by_uploaded_user'] as bool,
  );
}

Map<String, dynamic> _$TagsToJson(Tags instance) => <String, dynamic>{
      'name': instance.name,
      'translated_name': instance.translatedName,
      'added_by_uploaded_user': instance.addedByUploadedUser,
    };

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['id'] as int,
    json['name'] as String,
    json['account'] as String,
    Profile_image_urls.fromJson(
        json['profile_image_urls'] as Map<String, dynamic>),
    json['is_followed'] as bool,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'account': instance.account,
      'profile_image_urls': instance.profileImageUrls,
      'is_followed': instance.isFollowed,
    };

Profile_image_urls _$Profile_image_urlsFromJson(Map<String, dynamic> json) {
  return Profile_image_urls(
    json['medium'] as String,
  );
}

Map<String, dynamic> _$Profile_image_urlsToJson(Profile_image_urls instance) =>
    <String, dynamic>{
      'medium': instance.medium,
    };

Series _$SeriesFromJson(Map<String, dynamic> json) {
  return Series();
}

Map<String, dynamic> _$SeriesToJson(Series instance) => <String, dynamic>{};
