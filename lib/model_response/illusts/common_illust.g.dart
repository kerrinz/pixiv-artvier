// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_illust.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonIllust _$CommonIllustFromJson(Map<String, dynamic> json) {
  return CommonIllust(
    json['id'] as int,
    json['title'] as String,
    json['type'] as String,
    Image_urls.fromJson(json['image_urls'] as Map<String, dynamic>),
    json['caption'] as String,
    json['restrict'] as int,
    User.fromJson(json['user'] as Map<String, dynamic>),
    (json['tags'] as List<dynamic>)
        .map((e) => Tags.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['tools'] as List<dynamic>,
    json['create_date'] as String,
    json['page_count'] as int,
    json['width'] as int,
    json['height'] as int,
    json['sanity_level'] as int,
    json['x_restrict'] as int,
    Meta_single_page.fromJson(json['meta_single_page'] as Map<String, dynamic>),
    (json['meta_pages'] as List<dynamic>)
        .map((e) => MetaPages.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['total_view'] as int,
    json['total_bookmarks'] as int,
    json['is_bookmarked'] as bool,
    json['visible'] as bool,
    json['is_muted'] as bool,
  );
}

Map<String, dynamic> _$CommonIllustToJson(CommonIllust instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': instance.type,
      'image_urls': instance.imageUrls,
      'caption': instance.caption,
      'restrict': instance.restrict,
      'user': instance.user,
      'tags': instance.tags,
      'tools': instance.tools,
      'create_date': instance.createDate,
      'page_count': instance.pageCount,
      'width': instance.width,
      'height': instance.height,
      'sanity_level': instance.sanityLevel,
      'x_restrict': instance.xRestrict,
      'meta_single_page': instance.metaSinglePage,
      'meta_pages': instance.metaPages,
      'total_view': instance.totalView,
      'total_bookmarks': instance.totalBookmarks,
      'is_bookmarked': instance.isBookmarked,
      'visible': instance.visible,
      'is_muted': instance.isMuted,
    };

Image_urls _$Image_urlsFromJson(Map<String, dynamic> json) {
  return Image_urls(
    json['square_medium'] as String,
    json['medium'] as String,
    json['large'] as String,
    json['original'] as String?,
  );
}

Map<String, dynamic> _$Image_urlsToJson(Image_urls instance) =>
    <String, dynamic>{
      'square_medium': instance.squareMedium,
      'medium': instance.medium,
      'large': instance.large,
      'original': instance.original,
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

Tags _$TagsFromJson(Map<String, dynamic> json) {
  return Tags(
    json['name'] as String,
    json['translated_name'] as String?,
  );
}

Map<String, dynamic> _$TagsToJson(Tags instance) => <String, dynamic>{
      'name': instance.name,
      'translated_name': instance.translatedName,
    };

Meta_single_page _$Meta_single_pageFromJson(Map<String, dynamic> json) {
  return Meta_single_page(
    json['original_image_url'] as String?,
  );
}

Map<String, dynamic> _$Meta_single_pageToJson(Meta_single_page instance) =>
    <String, dynamic>{
      'original_image_url': instance.originalImageUrl,
    };

MetaPages _$MetaPagesFromJson(Map<String, dynamic> json) {
  return MetaPages(
    Image_urls.fromJson(json['image_urls'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MetaPagesToJson(MetaPages instance) => <String, dynamic>{
      'image_urls': instance.imageUrls,
    };
