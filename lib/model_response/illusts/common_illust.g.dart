// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'common_illust.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonIllust _$CommonIllustFromJson(Map<String, dynamic> json) => CommonIllust(
      (json['id'] as num).toInt(),
      json['title'] as String,
      json['type'] as String,
      Image_urls.fromJson(json['image_urls'] as Map<String, dynamic>),
      json['caption'] as String,
      (json['restrict'] as num).toInt(),
      CommonUser.fromJson(json['user'] as Map<String, dynamic>),
      (json['tags'] as List<dynamic>)
          .map((e) => Tags.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['tools'] as List<dynamic>,
      DateTime.parse(json['create_date'] as String),
      (json['page_count'] as num).toInt(),
      (json['width'] as num).toInt(),
      (json['height'] as num).toInt(),
      (json['sanity_level'] as num).toInt(),
      (json['x_restrict'] as num).toInt(),
      Meta_single_page.fromJson(
          json['meta_single_page'] as Map<String, dynamic>),
      (json['meta_pages'] as List<dynamic>)
          .map((e) => MetaPages.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['total_view'] as num).toInt(),
      (json['total_bookmarks'] as num).toInt(),
      json['is_bookmarked'] as bool,
      json['visible'] as bool,
      json['is_muted'] as bool,
      $enumDecodeNullable(_$CollectStateEnumMap, json['collectState']),
    )..series = json['series'] == null
        ? null
        : Series.fromJson(json['series'] as Map<String, dynamic>);

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
      'create_date': instance.createDate.toIso8601String(),
      'page_count': instance.pageCount,
      'width': instance.width,
      'height': instance.height,
      'sanity_level': instance.sanityLevel,
      'x_restrict': instance.xRestrict,
      'series': instance.series,
      'meta_single_page': instance.metaSinglePage,
      'meta_pages': instance.metaPages,
      'total_view': instance.totalView,
      'total_bookmarks': instance.totalBookmarks,
      'is_bookmarked': instance.isBookmarked,
      'collectState': _$CollectStateEnumMap[instance.collectState],
      'visible': instance.visible,
      'is_muted': instance.isMuted,
    };

const _$CollectStateEnumMap = {
  CollectState.collecting: 'collecting',
  CollectState.uncollecting: 'uncollecting',
  CollectState.collected: 'collected',
  CollectState.notCollect: 'notCollect',
};

Image_urls _$Image_urlsFromJson(Map<String, dynamic> json) => Image_urls(
      json['square_medium'] as String,
      json['medium'] as String,
      json['large'] as String,
    );

Map<String, dynamic> _$Image_urlsToJson(Image_urls instance) =>
    <String, dynamic>{
      'square_medium': instance.squareMedium,
      'medium': instance.medium,
      'large': instance.large,
    };

Series _$SeriesFromJson(Map<String, dynamic> json) => Series(
      (json['id'] as num).toInt(),
      json['title'] as String,
    );

Map<String, dynamic> _$SeriesToJson(Series instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };

Meta_Multiple_Image_urls _$Meta_Multiple_Image_urlsFromJson(
        Map<String, dynamic> json) =>
    Meta_Multiple_Image_urls(
      json['square_medium'] as String,
      json['medium'] as String,
      json['large'] as String,
      json['original'] as String,
    );

Map<String, dynamic> _$Meta_Multiple_Image_urlsToJson(
        Meta_Multiple_Image_urls instance) =>
    <String, dynamic>{
      'square_medium': instance.squareMedium,
      'medium': instance.medium,
      'large': instance.large,
      'original': instance.original,
    };

Profile_image_urls _$Profile_image_urlsFromJson(Map<String, dynamic> json) =>
    Profile_image_urls(
      json['medium'] as String,
    );

Map<String, dynamic> _$Profile_image_urlsToJson(Profile_image_urls instance) =>
    <String, dynamic>{
      'medium': instance.medium,
    };

Tags _$TagsFromJson(Map<String, dynamic> json) => Tags(
      json['name'] as String,
      json['translated_name'] as String?,
    );

Map<String, dynamic> _$TagsToJson(Tags instance) => <String, dynamic>{
      'name': instance.name,
      'translated_name': instance.translatedName,
    };

Meta_single_page _$Meta_single_pageFromJson(Map<String, dynamic> json) =>
    Meta_single_page(
      json['original_image_url'] as String?,
    );

Map<String, dynamic> _$Meta_single_pageToJson(Meta_single_page instance) =>
    <String, dynamic>{
      'original_image_url': instance.originalImageUrl,
    };

MetaPages _$MetaPagesFromJson(Map<String, dynamic> json) => MetaPages(
      Meta_Multiple_Image_urls.fromJson(
          json['image_urls'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MetaPagesToJson(MetaPages instance) => <String, dynamic>{
      'image_urls': instance.imageUrls,
    };
