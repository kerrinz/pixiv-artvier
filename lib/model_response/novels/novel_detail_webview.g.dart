// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'novel_detail_webview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NovelDetailWebViewImpl _$$NovelDetailWebViewImplFromJson(
        Map<String, dynamic> json) =>
    _$NovelDetailWebViewImpl(
      novel: NovelWebViewNovel.fromJson(json['novel'] as Map<String, dynamic>),
      authorDetails: NovelWebViewAuthorDetails.fromJson(
          json['authorDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$NovelDetailWebViewImplToJson(
        _$NovelDetailWebViewImpl instance) =>
    <String, dynamic>{
      'novel': instance.novel,
      'authorDetails': instance.authorDetails,
    };

_$NovelWebViewNovelImpl _$$NovelWebViewNovelImplFromJson(
        Map<String, dynamic> json) =>
    _$NovelWebViewNovelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      seriesId: json['seriesId'],
      seriesTitle: json['seriesTitle'],
      seriesIsWatched: json['seriesIsWatched'],
      userId: json['userId'] as String,
      coverUrl: json['coverUrl'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      caption: json['caption'] as String,
      cdate: DateTime.parse(json['cdate'] as String),
      rating: Rating.fromJson(json['rating'] as Map<String, dynamic>),
      text: json['text'] as String,
      marker: json['marker'] == null
          ? null
          : NovelWebViewNovelMarker.fromJson(
              json['marker'] as Map<String, dynamic>),
      illusts: (json['illusts'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, IllustValue.fromJson(e as Map<String, dynamic>)),
      ),
      images: (json['images'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Image.fromJson(e as Map<String, dynamic>)),
      ),
      seriesNavigation: json['seriesNavigation'] == null
          ? null
          : SeriesNavigation.fromJson(
              json['seriesNavigation'] as Map<String, dynamic>),
      glossaryItems: json['glossaryItems'],
      replaceableItemIds: json['replaceableItemIds'],
      aiType: (json['aiType'] as num).toInt(),
      isOriginal: json['isOriginal'] as bool,
    );

Map<String, dynamic> _$$NovelWebViewNovelImplToJson(
        _$NovelWebViewNovelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'seriesId': instance.seriesId,
      'seriesTitle': instance.seriesTitle,
      'seriesIsWatched': instance.seriesIsWatched,
      'userId': instance.userId,
      'coverUrl': instance.coverUrl,
      'tags': instance.tags,
      'caption': instance.caption,
      'cdate': instance.cdate.toIso8601String(),
      'rating': instance.rating,
      'text': instance.text,
      'marker': instance.marker,
      'illusts': instance.illusts,
      'images': instance.images,
      'seriesNavigation': instance.seriesNavigation,
      'glossaryItems': instance.glossaryItems,
      'replaceableItemIds': instance.replaceableItemIds,
      'aiType': instance.aiType,
      'isOriginal': instance.isOriginal,
    };

_$NovelWebViewNovelMarkerImpl _$$NovelWebViewNovelMarkerImplFromJson(
        Map<String, dynamic> json) =>
    _$NovelWebViewNovelMarkerImpl(
      page: (json['page'] as num).toInt(),
    );

Map<String, dynamic> _$$NovelWebViewNovelMarkerImplToJson(
        _$NovelWebViewNovelMarkerImpl instance) =>
    <String, dynamic>{
      'page': instance.page,
    };

_$NovelWebViewAuthorDetailsImpl _$$NovelWebViewAuthorDetailsImplFromJson(
        Map<String, dynamic> json) =>
    _$NovelWebViewAuthorDetailsImpl(
      userId: (json['userId'] as num).toInt(),
      userName: json['userName'] as String,
      isFollowed: json['isFollowed'] as bool,
      isBlocked: json['isBlocked'] as bool,
      profileImg: NovelWebViewAuthorDetailsProfileImg.fromJson(
          json['profileImg'] as Map<String, dynamic>),
      isProfileImgMasked: json['isProfileImgMasked'] as bool,
    );

Map<String, dynamic> _$$NovelWebViewAuthorDetailsImplToJson(
        _$NovelWebViewAuthorDetailsImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'isFollowed': instance.isFollowed,
      'isBlocked': instance.isBlocked,
      'profileImg': instance.profileImg,
      'isProfileImgMasked': instance.isProfileImgMasked,
    };

_$NovelWebViewAuthorDetailsProfileImgImpl
    _$$NovelWebViewAuthorDetailsProfileImgImplFromJson(
            Map<String, dynamic> json) =>
        _$NovelWebViewAuthorDetailsProfileImgImpl(
          url: json['url'] as String,
        );

Map<String, dynamic> _$$NovelWebViewAuthorDetailsProfileImgImplToJson(
        _$NovelWebViewAuthorDetailsProfileImgImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
    };

_$IllustValueImpl _$$IllustValueImplFromJson(Map<String, dynamic> json) =>
    _$IllustValueImpl(
      visible: json['visible'] as bool,
      availableMessage: json['availableMessage'],
      illust: IllustIllust.fromJson(json['illust'] as Map<String, dynamic>),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      id: json['id'] as String,
      page: (json['page'] as num).toInt(),
    );

Map<String, dynamic> _$$IllustValueImplToJson(_$IllustValueImpl instance) =>
    <String, dynamic>{
      'visible': instance.visible,
      'availableMessage': instance.availableMessage,
      'illust': instance.illust,
      'user': instance.user,
      'id': instance.id,
      'page': instance.page,
    };

_$IllustIllustImpl _$$IllustIllustImplFromJson(Map<String, dynamic> json) =>
    _$IllustIllustImpl(
      title: json['title'] as String,
      description: json['description'] as String,
      restrict: (json['restrict'] as num).toInt(),
      xRestrict: (json['xRestrict'] as num).toInt(),
      sl: (json['sl'] as num).toInt(),
      tags: (json['tags'] as List<dynamic>)
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
      images: Images.fromJson(json['images'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$IllustIllustImplToJson(_$IllustIllustImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'restrict': instance.restrict,
      'xRestrict': instance.xRestrict,
      'sl': instance.sl,
      'tags': instance.tags,
      'images': instance.images,
    };

_$ImagesImpl _$$ImagesImplFromJson(Map<String, dynamic> json) => _$ImagesImpl(
      small: json['small'],
      medium: json['medium'] as String,
      original: json['original'],
    );

Map<String, dynamic> _$$ImagesImplToJson(_$ImagesImpl instance) =>
    <String, dynamic>{
      'small': instance.small,
      'medium': instance.medium,
      'original': instance.original,
    };

_$TagImpl _$$TagImplFromJson(Map<String, dynamic> json) => _$TagImpl(
      tag: json['tag'] as String,
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$$TagImplToJson(_$TagImpl instance) => <String, dynamic>{
      'tag': instance.tag,
      'userId': instance.userId,
    };

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
    };

_$ImageImpl _$$ImageImplFromJson(Map<String, dynamic> json) => _$ImageImpl(
      novelImageId: json['novelImageId'] as String,
      sl: json['sl'] as String,
      urls: Urls.fromJson(json['urls'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ImageImplToJson(_$ImageImpl instance) =>
    <String, dynamic>{
      'novelImageId': instance.novelImageId,
      'sl': instance.sl,
      'urls': instance.urls,
    };

_$UrlsImpl _$$UrlsImplFromJson(Map<String, dynamic> json) => _$UrlsImpl(
      the240Mw: json['240mw'] as String,
      the480Mw: json['480mw'] as String,
      the1200X1200: json['1200x1200'] as String,
      the128X128: json['128x128'] as String,
      original: json['original'] as String,
    );

Map<String, dynamic> _$$UrlsImplToJson(_$UrlsImpl instance) =>
    <String, dynamic>{
      '240mw': instance.the240Mw,
      '480mw': instance.the480Mw,
      '1200x1200': instance.the1200X1200,
      '128x128': instance.the128X128,
      'original': instance.original,
    };

_$RatingImpl _$$RatingImplFromJson(Map<String, dynamic> json) => _$RatingImpl(
      like: (json['like'] as num).toInt(),
      bookmark: (json['bookmark'] as num).toInt(),
      view: (json['view'] as num).toInt(),
    );

Map<String, dynamic> _$$RatingImplToJson(_$RatingImpl instance) =>
    <String, dynamic>{
      'like': instance.like,
      'bookmark': instance.bookmark,
      'view': instance.view,
    };

_$SeriesNavigationImpl _$$SeriesNavigationImplFromJson(
        Map<String, dynamic> json) =>
    _$SeriesNavigationImpl(
      nextNovel: json['nextNovel'] == null
          ? null
          : PrevNovel.fromJson(json['nextNovel'] as Map<String, dynamic>),
      prevNovel: json['prevNovel'] == null
          ? null
          : PrevNovel.fromJson(json['prevNovel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SeriesNavigationImplToJson(
        _$SeriesNavigationImpl instance) =>
    <String, dynamic>{
      'nextNovel': instance.nextNovel,
      'prevNovel': instance.prevNovel,
    };

_$PrevNovelImpl _$$PrevNovelImplFromJson(Map<String, dynamic> json) =>
    _$PrevNovelImpl(
      id: (json['id'] as num).toInt(),
      viewable: json['viewable'] as bool,
      contentOrder: json['contentOrder'] as String,
      title: json['title'] as String,
      coverUrl: json['coverUrl'] as String,
      viewableMessage: json['viewableMessage'],
    );

Map<String, dynamic> _$$PrevNovelImplToJson(_$PrevNovelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'viewable': instance.viewable,
      'contentOrder': instance.contentOrder,
      'title': instance.title,
      'coverUrl': instance.coverUrl,
      'viewableMessage': instance.viewableMessage,
    };
