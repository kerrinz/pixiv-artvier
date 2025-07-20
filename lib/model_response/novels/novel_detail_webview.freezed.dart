// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'novel_detail_webview.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NovelDetailWebView _$NovelDetailWebViewFromJson(Map<String, dynamic> json) {
  return _NovelDetailWebView.fromJson(json);
}

/// @nodoc
mixin _$NovelDetailWebView {
  @JsonKey(name: "authorDetails")
  NovelWebViewAuthorDetails get authorDetails =>
      throw _privateConstructorUsedError;
  @JsonKey(name: "novel")
  NovelWebViewNovel get novel => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NovelDetailWebViewCopyWith<NovelDetailWebView> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NovelDetailWebViewCopyWith<$Res> {
  factory $NovelDetailWebViewCopyWith(
          NovelDetailWebView value, $Res Function(NovelDetailWebView) then) =
      _$NovelDetailWebViewCopyWithImpl<$Res, NovelDetailWebView>;
  @useResult
  $Res call(
      {@JsonKey(name: "authorDetails") NovelWebViewAuthorDetails authorDetails,
      @JsonKey(name: "novel") NovelWebViewNovel novel});

  $NovelWebViewAuthorDetailsCopyWith<$Res> get authorDetails;
  $NovelWebViewNovelCopyWith<$Res> get novel;
}

/// @nodoc
class _$NovelDetailWebViewCopyWithImpl<$Res, $Val extends NovelDetailWebView>
    implements $NovelDetailWebViewCopyWith<$Res> {
  _$NovelDetailWebViewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authorDetails = null,
    Object? novel = null,
  }) {
    return _then(_value.copyWith(
      authorDetails: null == authorDetails
          ? _value.authorDetails
          : authorDetails // ignore: cast_nullable_to_non_nullable
              as NovelWebViewAuthorDetails,
      novel: null == novel
          ? _value.novel
          : novel // ignore: cast_nullable_to_non_nullable
              as NovelWebViewNovel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NovelWebViewAuthorDetailsCopyWith<$Res> get authorDetails {
    return $NovelWebViewAuthorDetailsCopyWith<$Res>(_value.authorDetails,
        (value) {
      return _then(_value.copyWith(authorDetails: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NovelWebViewNovelCopyWith<$Res> get novel {
    return $NovelWebViewNovelCopyWith<$Res>(_value.novel, (value) {
      return _then(_value.copyWith(novel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NovelDetailWebViewImplCopyWith<$Res>
    implements $NovelDetailWebViewCopyWith<$Res> {
  factory _$$NovelDetailWebViewImplCopyWith(_$NovelDetailWebViewImpl value,
          $Res Function(_$NovelDetailWebViewImpl) then) =
      __$$NovelDetailWebViewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "authorDetails") NovelWebViewAuthorDetails authorDetails,
      @JsonKey(name: "novel") NovelWebViewNovel novel});

  @override
  $NovelWebViewAuthorDetailsCopyWith<$Res> get authorDetails;
  @override
  $NovelWebViewNovelCopyWith<$Res> get novel;
}

/// @nodoc
class __$$NovelDetailWebViewImplCopyWithImpl<$Res>
    extends _$NovelDetailWebViewCopyWithImpl<$Res, _$NovelDetailWebViewImpl>
    implements _$$NovelDetailWebViewImplCopyWith<$Res> {
  __$$NovelDetailWebViewImplCopyWithImpl(_$NovelDetailWebViewImpl _value,
      $Res Function(_$NovelDetailWebViewImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authorDetails = null,
    Object? novel = null,
  }) {
    return _then(_$NovelDetailWebViewImpl(
      authorDetails: null == authorDetails
          ? _value.authorDetails
          : authorDetails // ignore: cast_nullable_to_non_nullable
              as NovelWebViewAuthorDetails,
      novel: null == novel
          ? _value.novel
          : novel // ignore: cast_nullable_to_non_nullable
              as NovelWebViewNovel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NovelDetailWebViewImpl implements _NovelDetailWebView {
  const _$NovelDetailWebViewImpl(
      {@JsonKey(name: "authorDetails") required this.authorDetails,
      @JsonKey(name: "novel") required this.novel});

  factory _$NovelDetailWebViewImpl.fromJson(Map<String, dynamic> json) =>
      _$$NovelDetailWebViewImplFromJson(json);

  @override
  @JsonKey(name: "authorDetails")
  final NovelWebViewAuthorDetails authorDetails;
  @override
  @JsonKey(name: "novel")
  final NovelWebViewNovel novel;

  @override
  String toString() {
    return 'NovelDetailWebView(authorDetails: $authorDetails, novel: $novel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NovelDetailWebViewImpl &&
            (identical(other.authorDetails, authorDetails) ||
                other.authorDetails == authorDetails) &&
            (identical(other.novel, novel) || other.novel == novel));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, authorDetails, novel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NovelDetailWebViewImplCopyWith<_$NovelDetailWebViewImpl> get copyWith =>
      __$$NovelDetailWebViewImplCopyWithImpl<_$NovelDetailWebViewImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NovelDetailWebViewImplToJson(
      this,
    );
  }
}

abstract class _NovelDetailWebView implements NovelDetailWebView {
  const factory _NovelDetailWebView(
          {@JsonKey(name: "authorDetails")
          required final NovelWebViewAuthorDetails authorDetails,
          @JsonKey(name: "novel") required final NovelWebViewNovel novel}) =
      _$NovelDetailWebViewImpl;

  factory _NovelDetailWebView.fromJson(Map<String, dynamic> json) =
      _$NovelDetailWebViewImpl.fromJson;

  @override
  @JsonKey(name: "authorDetails")
  NovelWebViewAuthorDetails get authorDetails;
  @override
  @JsonKey(name: "novel")
  NovelWebViewNovel get novel;
  @override
  @JsonKey(ignore: true)
  _$$NovelDetailWebViewImplCopyWith<_$NovelDetailWebViewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NovelWebViewNovel _$NovelWebViewNovelFromJson(Map<String, dynamic> json) {
  return _NovelWebViewNovel.fromJson(json);
}

/// @nodoc
mixin _$NovelWebViewNovel {
  @JsonKey(name: "id")
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: "title")
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: "seriesId")
  dynamic get seriesId => throw _privateConstructorUsedError;
  @JsonKey(name: "seriesTitle")
  dynamic get seriesTitle => throw _privateConstructorUsedError;
  @JsonKey(name: "seriesIsWatched")
  dynamic get seriesIsWatched => throw _privateConstructorUsedError;
  @JsonKey(name: "userId")
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: "coverUrl")
  String get coverUrl => throw _privateConstructorUsedError;
  @JsonKey(name: "tags")
  List<String> get tags => throw _privateConstructorUsedError;
  @JsonKey(name: "caption")
  String get caption => throw _privateConstructorUsedError;
  @JsonKey(name: "cdate")
  DateTime get cdate => throw _privateConstructorUsedError;
  @JsonKey(name: "rating")
  Rating get rating => throw _privateConstructorUsedError;
  @JsonKey(name: "text")
  String get text => throw _privateConstructorUsedError;
  @JsonKey(name: "marker")
  NovelWebViewNovelMarker? get marker => throw _privateConstructorUsedError;
  @JsonKey(name: "illusts")
  Map<String, IllustValue> get illusts => throw _privateConstructorUsedError;
  @JsonKey(name: "images")
  Map<String, Image> get images => throw _privateConstructorUsedError;
  @JsonKey(name: "seriesNavigation")
  SeriesNavigation? get seriesNavigation => throw _privateConstructorUsedError;
  @JsonKey(name: "glossaryItems")
  dynamic get glossaryItems => throw _privateConstructorUsedError;
  @JsonKey(name: "replaceableItemIds")
  dynamic get replaceableItemIds => throw _privateConstructorUsedError;
  @JsonKey(name: "aiType")
  int get aiType => throw _privateConstructorUsedError;
  @JsonKey(name: "isOriginal")
  bool get isOriginal => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NovelWebViewNovelCopyWith<NovelWebViewNovel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NovelWebViewNovelCopyWith<$Res> {
  factory $NovelWebViewNovelCopyWith(
          NovelWebViewNovel value, $Res Function(NovelWebViewNovel) then) =
      _$NovelWebViewNovelCopyWithImpl<$Res, NovelWebViewNovel>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") String id,
      @JsonKey(name: "title") String title,
      @JsonKey(name: "seriesId") dynamic seriesId,
      @JsonKey(name: "seriesTitle") dynamic seriesTitle,
      @JsonKey(name: "seriesIsWatched") dynamic seriesIsWatched,
      @JsonKey(name: "userId") String userId,
      @JsonKey(name: "coverUrl") String coverUrl,
      @JsonKey(name: "tags") List<String> tags,
      @JsonKey(name: "caption") String caption,
      @JsonKey(name: "cdate") DateTime cdate,
      @JsonKey(name: "rating") Rating rating,
      @JsonKey(name: "text") String text,
      @JsonKey(name: "marker") NovelWebViewNovelMarker? marker,
      @JsonKey(name: "illusts") Map<String, IllustValue> illusts,
      @JsonKey(name: "images") Map<String, Image> images,
      @JsonKey(name: "seriesNavigation") SeriesNavigation? seriesNavigation,
      @JsonKey(name: "glossaryItems") dynamic glossaryItems,
      @JsonKey(name: "replaceableItemIds") dynamic replaceableItemIds,
      @JsonKey(name: "aiType") int aiType,
      @JsonKey(name: "isOriginal") bool isOriginal});

  $RatingCopyWith<$Res> get rating;
  $NovelWebViewNovelMarkerCopyWith<$Res>? get marker;
  $SeriesNavigationCopyWith<$Res>? get seriesNavigation;
}

/// @nodoc
class _$NovelWebViewNovelCopyWithImpl<$Res, $Val extends NovelWebViewNovel>
    implements $NovelWebViewNovelCopyWith<$Res> {
  _$NovelWebViewNovelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? seriesId = freezed,
    Object? seriesTitle = freezed,
    Object? seriesIsWatched = freezed,
    Object? userId = null,
    Object? coverUrl = null,
    Object? tags = null,
    Object? caption = null,
    Object? cdate = null,
    Object? rating = null,
    Object? text = null,
    Object? marker = freezed,
    Object? illusts = null,
    Object? images = null,
    Object? seriesNavigation = freezed,
    Object? glossaryItems = freezed,
    Object? replaceableItemIds = freezed,
    Object? aiType = null,
    Object? isOriginal = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      seriesId: freezed == seriesId
          ? _value.seriesId
          : seriesId // ignore: cast_nullable_to_non_nullable
              as dynamic,
      seriesTitle: freezed == seriesTitle
          ? _value.seriesTitle
          : seriesTitle // ignore: cast_nullable_to_non_nullable
              as dynamic,
      seriesIsWatched: freezed == seriesIsWatched
          ? _value.seriesIsWatched
          : seriesIsWatched // ignore: cast_nullable_to_non_nullable
              as dynamic,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      coverUrl: null == coverUrl
          ? _value.coverUrl
          : coverUrl // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      caption: null == caption
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String,
      cdate: null == cdate
          ? _value.cdate
          : cdate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as Rating,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      marker: freezed == marker
          ? _value.marker
          : marker // ignore: cast_nullable_to_non_nullable
              as NovelWebViewNovelMarker?,
      illusts: null == illusts
          ? _value.illusts
          : illusts // ignore: cast_nullable_to_non_nullable
              as Map<String, IllustValue>,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as Map<String, Image>,
      seriesNavigation: freezed == seriesNavigation
          ? _value.seriesNavigation
          : seriesNavigation // ignore: cast_nullable_to_non_nullable
              as SeriesNavigation?,
      glossaryItems: freezed == glossaryItems
          ? _value.glossaryItems
          : glossaryItems // ignore: cast_nullable_to_non_nullable
              as dynamic,
      replaceableItemIds: freezed == replaceableItemIds
          ? _value.replaceableItemIds
          : replaceableItemIds // ignore: cast_nullable_to_non_nullable
              as dynamic,
      aiType: null == aiType
          ? _value.aiType
          : aiType // ignore: cast_nullable_to_non_nullable
              as int,
      isOriginal: null == isOriginal
          ? _value.isOriginal
          : isOriginal // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RatingCopyWith<$Res> get rating {
    return $RatingCopyWith<$Res>(_value.rating, (value) {
      return _then(_value.copyWith(rating: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NovelWebViewNovelMarkerCopyWith<$Res>? get marker {
    if (_value.marker == null) {
      return null;
    }

    return $NovelWebViewNovelMarkerCopyWith<$Res>(_value.marker!, (value) {
      return _then(_value.copyWith(marker: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SeriesNavigationCopyWith<$Res>? get seriesNavigation {
    if (_value.seriesNavigation == null) {
      return null;
    }

    return $SeriesNavigationCopyWith<$Res>(_value.seriesNavigation!, (value) {
      return _then(_value.copyWith(seriesNavigation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NovelWebViewNovelImplCopyWith<$Res>
    implements $NovelWebViewNovelCopyWith<$Res> {
  factory _$$NovelWebViewNovelImplCopyWith(_$NovelWebViewNovelImpl value,
          $Res Function(_$NovelWebViewNovelImpl) then) =
      __$$NovelWebViewNovelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") String id,
      @JsonKey(name: "title") String title,
      @JsonKey(name: "seriesId") dynamic seriesId,
      @JsonKey(name: "seriesTitle") dynamic seriesTitle,
      @JsonKey(name: "seriesIsWatched") dynamic seriesIsWatched,
      @JsonKey(name: "userId") String userId,
      @JsonKey(name: "coverUrl") String coverUrl,
      @JsonKey(name: "tags") List<String> tags,
      @JsonKey(name: "caption") String caption,
      @JsonKey(name: "cdate") DateTime cdate,
      @JsonKey(name: "rating") Rating rating,
      @JsonKey(name: "text") String text,
      @JsonKey(name: "marker") NovelWebViewNovelMarker? marker,
      @JsonKey(name: "illusts") Map<String, IllustValue> illusts,
      @JsonKey(name: "images") Map<String, Image> images,
      @JsonKey(name: "seriesNavigation") SeriesNavigation? seriesNavigation,
      @JsonKey(name: "glossaryItems") dynamic glossaryItems,
      @JsonKey(name: "replaceableItemIds") dynamic replaceableItemIds,
      @JsonKey(name: "aiType") int aiType,
      @JsonKey(name: "isOriginal") bool isOriginal});

  @override
  $RatingCopyWith<$Res> get rating;
  @override
  $NovelWebViewNovelMarkerCopyWith<$Res>? get marker;
  @override
  $SeriesNavigationCopyWith<$Res>? get seriesNavigation;
}

/// @nodoc
class __$$NovelWebViewNovelImplCopyWithImpl<$Res>
    extends _$NovelWebViewNovelCopyWithImpl<$Res, _$NovelWebViewNovelImpl>
    implements _$$NovelWebViewNovelImplCopyWith<$Res> {
  __$$NovelWebViewNovelImplCopyWithImpl(_$NovelWebViewNovelImpl _value,
      $Res Function(_$NovelWebViewNovelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? seriesId = freezed,
    Object? seriesTitle = freezed,
    Object? seriesIsWatched = freezed,
    Object? userId = null,
    Object? coverUrl = null,
    Object? tags = null,
    Object? caption = null,
    Object? cdate = null,
    Object? rating = null,
    Object? text = null,
    Object? marker = freezed,
    Object? illusts = null,
    Object? images = null,
    Object? seriesNavigation = freezed,
    Object? glossaryItems = freezed,
    Object? replaceableItemIds = freezed,
    Object? aiType = null,
    Object? isOriginal = null,
  }) {
    return _then(_$NovelWebViewNovelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      seriesId: freezed == seriesId
          ? _value.seriesId
          : seriesId // ignore: cast_nullable_to_non_nullable
              as dynamic,
      seriesTitle: freezed == seriesTitle
          ? _value.seriesTitle
          : seriesTitle // ignore: cast_nullable_to_non_nullable
              as dynamic,
      seriesIsWatched: freezed == seriesIsWatched
          ? _value.seriesIsWatched
          : seriesIsWatched // ignore: cast_nullable_to_non_nullable
              as dynamic,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      coverUrl: null == coverUrl
          ? _value.coverUrl
          : coverUrl // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      caption: null == caption
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String,
      cdate: null == cdate
          ? _value.cdate
          : cdate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as Rating,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      marker: freezed == marker
          ? _value.marker
          : marker // ignore: cast_nullable_to_non_nullable
              as NovelWebViewNovelMarker?,
      illusts: null == illusts
          ? _value._illusts
          : illusts // ignore: cast_nullable_to_non_nullable
              as Map<String, IllustValue>,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as Map<String, Image>,
      seriesNavigation: freezed == seriesNavigation
          ? _value.seriesNavigation
          : seriesNavigation // ignore: cast_nullable_to_non_nullable
              as SeriesNavigation?,
      glossaryItems: freezed == glossaryItems
          ? _value.glossaryItems
          : glossaryItems // ignore: cast_nullable_to_non_nullable
              as dynamic,
      replaceableItemIds: freezed == replaceableItemIds
          ? _value.replaceableItemIds
          : replaceableItemIds // ignore: cast_nullable_to_non_nullable
              as dynamic,
      aiType: null == aiType
          ? _value.aiType
          : aiType // ignore: cast_nullable_to_non_nullable
              as int,
      isOriginal: null == isOriginal
          ? _value.isOriginal
          : isOriginal // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NovelWebViewNovelImpl implements _NovelWebViewNovel {
  const _$NovelWebViewNovelImpl(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "title") required this.title,
      @JsonKey(name: "seriesId") required this.seriesId,
      @JsonKey(name: "seriesTitle") required this.seriesTitle,
      @JsonKey(name: "seriesIsWatched") required this.seriesIsWatched,
      @JsonKey(name: "userId") required this.userId,
      @JsonKey(name: "coverUrl") required this.coverUrl,
      @JsonKey(name: "tags") required final List<String> tags,
      @JsonKey(name: "caption") required this.caption,
      @JsonKey(name: "cdate") required this.cdate,
      @JsonKey(name: "rating") required this.rating,
      @JsonKey(name: "text") required this.text,
      @JsonKey(name: "marker") required this.marker,
      @JsonKey(name: "illusts") required final Map<String, IllustValue> illusts,
      @JsonKey(name: "images") required final Map<String, Image> images,
      @JsonKey(name: "seriesNavigation") this.seriesNavigation,
      @JsonKey(name: "glossaryItems") required this.glossaryItems,
      @JsonKey(name: "replaceableItemIds") required this.replaceableItemIds,
      @JsonKey(name: "aiType") required this.aiType,
      @JsonKey(name: "isOriginal") required this.isOriginal})
      : _tags = tags,
        _illusts = illusts,
        _images = images;

  factory _$NovelWebViewNovelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NovelWebViewNovelImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final String id;
  @override
  @JsonKey(name: "title")
  final String title;
  @override
  @JsonKey(name: "seriesId")
  final dynamic seriesId;
  @override
  @JsonKey(name: "seriesTitle")
  final dynamic seriesTitle;
  @override
  @JsonKey(name: "seriesIsWatched")
  final dynamic seriesIsWatched;
  @override
  @JsonKey(name: "userId")
  final String userId;
  @override
  @JsonKey(name: "coverUrl")
  final String coverUrl;
  final List<String> _tags;
  @override
  @JsonKey(name: "tags")
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey(name: "caption")
  final String caption;
  @override
  @JsonKey(name: "cdate")
  final DateTime cdate;
  @override
  @JsonKey(name: "rating")
  final Rating rating;
  @override
  @JsonKey(name: "text")
  final String text;
  @override
  @JsonKey(name: "marker")
  final NovelWebViewNovelMarker? marker;
  final Map<String, IllustValue> _illusts;
  @override
  @JsonKey(name: "illusts")
  Map<String, IllustValue> get illusts {
    if (_illusts is EqualUnmodifiableMapView) return _illusts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_illusts);
  }

  final Map<String, Image> _images;
  @override
  @JsonKey(name: "images")
  Map<String, Image> get images {
    if (_images is EqualUnmodifiableMapView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_images);
  }

  @override
  @JsonKey(name: "seriesNavigation")
  final SeriesNavigation? seriesNavigation;
  @override
  @JsonKey(name: "glossaryItems")
  final dynamic glossaryItems;
  @override
  @JsonKey(name: "replaceableItemIds")
  final dynamic replaceableItemIds;
  @override
  @JsonKey(name: "aiType")
  final int aiType;
  @override
  @JsonKey(name: "isOriginal")
  final bool isOriginal;

  @override
  String toString() {
    return 'NovelWebViewNovel(id: $id, title: $title, seriesId: $seriesId, seriesTitle: $seriesTitle, seriesIsWatched: $seriesIsWatched, userId: $userId, coverUrl: $coverUrl, tags: $tags, caption: $caption, cdate: $cdate, rating: $rating, text: $text, marker: $marker, illusts: $illusts, images: $images, seriesNavigation: $seriesNavigation, glossaryItems: $glossaryItems, replaceableItemIds: $replaceableItemIds, aiType: $aiType, isOriginal: $isOriginal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NovelWebViewNovelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other.seriesId, seriesId) &&
            const DeepCollectionEquality()
                .equals(other.seriesTitle, seriesTitle) &&
            const DeepCollectionEquality()
                .equals(other.seriesIsWatched, seriesIsWatched) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.coverUrl, coverUrl) ||
                other.coverUrl == coverUrl) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.cdate, cdate) || other.cdate == cdate) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.marker, marker) || other.marker == marker) &&
            const DeepCollectionEquality().equals(other._illusts, _illusts) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.seriesNavigation, seriesNavigation) ||
                other.seriesNavigation == seriesNavigation) &&
            const DeepCollectionEquality()
                .equals(other.glossaryItems, glossaryItems) &&
            const DeepCollectionEquality()
                .equals(other.replaceableItemIds, replaceableItemIds) &&
            (identical(other.aiType, aiType) || other.aiType == aiType) &&
            (identical(other.isOriginal, isOriginal) ||
                other.isOriginal == isOriginal));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        title,
        const DeepCollectionEquality().hash(seriesId),
        const DeepCollectionEquality().hash(seriesTitle),
        const DeepCollectionEquality().hash(seriesIsWatched),
        userId,
        coverUrl,
        const DeepCollectionEquality().hash(_tags),
        caption,
        cdate,
        rating,
        text,
        marker,
        const DeepCollectionEquality().hash(_illusts),
        const DeepCollectionEquality().hash(_images),
        seriesNavigation,
        const DeepCollectionEquality().hash(glossaryItems),
        const DeepCollectionEquality().hash(replaceableItemIds),
        aiType,
        isOriginal
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NovelWebViewNovelImplCopyWith<_$NovelWebViewNovelImpl> get copyWith =>
      __$$NovelWebViewNovelImplCopyWithImpl<_$NovelWebViewNovelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NovelWebViewNovelImplToJson(
      this,
    );
  }
}

abstract class _NovelWebViewNovel implements NovelWebViewNovel {
  const factory _NovelWebViewNovel(
      {@JsonKey(name: "id") required final String id,
      @JsonKey(name: "title") required final String title,
      @JsonKey(name: "seriesId") required final dynamic seriesId,
      @JsonKey(name: "seriesTitle") required final dynamic seriesTitle,
      @JsonKey(name: "seriesIsWatched") required final dynamic seriesIsWatched,
      @JsonKey(name: "userId") required final String userId,
      @JsonKey(name: "coverUrl") required final String coverUrl,
      @JsonKey(name: "tags") required final List<String> tags,
      @JsonKey(name: "caption") required final String caption,
      @JsonKey(name: "cdate") required final DateTime cdate,
      @JsonKey(name: "rating") required final Rating rating,
      @JsonKey(name: "text") required final String text,
      @JsonKey(name: "marker") required final NovelWebViewNovelMarker? marker,
      @JsonKey(name: "illusts") required final Map<String, IllustValue> illusts,
      @JsonKey(name: "images") required final Map<String, Image> images,
      @JsonKey(name: "seriesNavigation")
      final SeriesNavigation? seriesNavigation,
      @JsonKey(name: "glossaryItems") required final dynamic glossaryItems,
      @JsonKey(name: "replaceableItemIds")
      required final dynamic replaceableItemIds,
      @JsonKey(name: "aiType") required final int aiType,
      @JsonKey(name: "isOriginal")
      required final bool isOriginal}) = _$NovelWebViewNovelImpl;

  factory _NovelWebViewNovel.fromJson(Map<String, dynamic> json) =
      _$NovelWebViewNovelImpl.fromJson;

  @override
  @JsonKey(name: "id")
  String get id;
  @override
  @JsonKey(name: "title")
  String get title;
  @override
  @JsonKey(name: "seriesId")
  dynamic get seriesId;
  @override
  @JsonKey(name: "seriesTitle")
  dynamic get seriesTitle;
  @override
  @JsonKey(name: "seriesIsWatched")
  dynamic get seriesIsWatched;
  @override
  @JsonKey(name: "userId")
  String get userId;
  @override
  @JsonKey(name: "coverUrl")
  String get coverUrl;
  @override
  @JsonKey(name: "tags")
  List<String> get tags;
  @override
  @JsonKey(name: "caption")
  String get caption;
  @override
  @JsonKey(name: "cdate")
  DateTime get cdate;
  @override
  @JsonKey(name: "rating")
  Rating get rating;
  @override
  @JsonKey(name: "text")
  String get text;
  @override
  @JsonKey(name: "marker")
  NovelWebViewNovelMarker? get marker;
  @override
  @JsonKey(name: "illusts")
  Map<String, IllustValue> get illusts;
  @override
  @JsonKey(name: "images")
  Map<String, Image> get images;
  @override
  @JsonKey(name: "seriesNavigation")
  SeriesNavigation? get seriesNavigation;
  @override
  @JsonKey(name: "glossaryItems")
  dynamic get glossaryItems;
  @override
  @JsonKey(name: "replaceableItemIds")
  dynamic get replaceableItemIds;
  @override
  @JsonKey(name: "aiType")
  int get aiType;
  @override
  @JsonKey(name: "isOriginal")
  bool get isOriginal;
  @override
  @JsonKey(ignore: true)
  _$$NovelWebViewNovelImplCopyWith<_$NovelWebViewNovelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NovelWebViewNovelMarker _$NovelWebViewNovelMarkerFromJson(
    Map<String, dynamic> json) {
  return _NovelWebViewNovelMarker.fromJson(json);
}

/// @nodoc
mixin _$NovelWebViewNovelMarker {
  @JsonKey(name: "page")
  int get page => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NovelWebViewNovelMarkerCopyWith<NovelWebViewNovelMarker> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NovelWebViewNovelMarkerCopyWith<$Res> {
  factory $NovelWebViewNovelMarkerCopyWith(NovelWebViewNovelMarker value,
          $Res Function(NovelWebViewNovelMarker) then) =
      _$NovelWebViewNovelMarkerCopyWithImpl<$Res, NovelWebViewNovelMarker>;
  @useResult
  $Res call({@JsonKey(name: "page") int page});
}

/// @nodoc
class _$NovelWebViewNovelMarkerCopyWithImpl<$Res,
        $Val extends NovelWebViewNovelMarker>
    implements $NovelWebViewNovelMarkerCopyWith<$Res> {
  _$NovelWebViewNovelMarkerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
  }) {
    return _then(_value.copyWith(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NovelWebViewNovelMarkerImplCopyWith<$Res>
    implements $NovelWebViewNovelMarkerCopyWith<$Res> {
  factory _$$NovelWebViewNovelMarkerImplCopyWith(
          _$NovelWebViewNovelMarkerImpl value,
          $Res Function(_$NovelWebViewNovelMarkerImpl) then) =
      __$$NovelWebViewNovelMarkerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: "page") int page});
}

/// @nodoc
class __$$NovelWebViewNovelMarkerImplCopyWithImpl<$Res>
    extends _$NovelWebViewNovelMarkerCopyWithImpl<$Res,
        _$NovelWebViewNovelMarkerImpl>
    implements _$$NovelWebViewNovelMarkerImplCopyWith<$Res> {
  __$$NovelWebViewNovelMarkerImplCopyWithImpl(
      _$NovelWebViewNovelMarkerImpl _value,
      $Res Function(_$NovelWebViewNovelMarkerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
  }) {
    return _then(_$NovelWebViewNovelMarkerImpl(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NovelWebViewNovelMarkerImpl implements _NovelWebViewNovelMarker {
  const _$NovelWebViewNovelMarkerImpl(
      {@JsonKey(name: "page") required this.page});

  factory _$NovelWebViewNovelMarkerImpl.fromJson(Map<String, dynamic> json) =>
      _$$NovelWebViewNovelMarkerImplFromJson(json);

  @override
  @JsonKey(name: "page")
  final int page;

  @override
  String toString() {
    return 'NovelWebViewNovelMarker(page: $page)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NovelWebViewNovelMarkerImpl &&
            (identical(other.page, page) || other.page == page));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, page);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NovelWebViewNovelMarkerImplCopyWith<_$NovelWebViewNovelMarkerImpl>
      get copyWith => __$$NovelWebViewNovelMarkerImplCopyWithImpl<
          _$NovelWebViewNovelMarkerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NovelWebViewNovelMarkerImplToJson(
      this,
    );
  }
}

abstract class _NovelWebViewNovelMarker implements NovelWebViewNovelMarker {
  const factory _NovelWebViewNovelMarker(
          {@JsonKey(name: "page") required final int page}) =
      _$NovelWebViewNovelMarkerImpl;

  factory _NovelWebViewNovelMarker.fromJson(Map<String, dynamic> json) =
      _$NovelWebViewNovelMarkerImpl.fromJson;

  @override
  @JsonKey(name: "page")
  int get page;
  @override
  @JsonKey(ignore: true)
  _$$NovelWebViewNovelMarkerImplCopyWith<_$NovelWebViewNovelMarkerImpl>
      get copyWith => throw _privateConstructorUsedError;
}

NovelWebViewAuthorDetails _$NovelWebViewAuthorDetailsFromJson(
    Map<String, dynamic> json) {
  return _NovelWebViewAuthorDetails.fromJson(json);
}

/// @nodoc
mixin _$NovelWebViewAuthorDetails {
  @JsonKey(name: "userId")
  int get userId => throw _privateConstructorUsedError;
  @JsonKey(name: "userName")
  String get userName => throw _privateConstructorUsedError;
  @JsonKey(name: "isFollowed")
  bool get isFollowed => throw _privateConstructorUsedError;
  @JsonKey(name: "isBlocked")
  bool get isBlocked => throw _privateConstructorUsedError;
  @JsonKey(name: "profileImg")
  NovelWebViewAuthorDetailsProfileImg get profileImg =>
      throw _privateConstructorUsedError;
  @JsonKey(name: "isProfileImgMasked")
  bool get isProfileImgMasked => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NovelWebViewAuthorDetailsCopyWith<NovelWebViewAuthorDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NovelWebViewAuthorDetailsCopyWith<$Res> {
  factory $NovelWebViewAuthorDetailsCopyWith(NovelWebViewAuthorDetails value,
          $Res Function(NovelWebViewAuthorDetails) then) =
      _$NovelWebViewAuthorDetailsCopyWithImpl<$Res, NovelWebViewAuthorDetails>;
  @useResult
  $Res call(
      {@JsonKey(name: "userId") int userId,
      @JsonKey(name: "userName") String userName,
      @JsonKey(name: "isFollowed") bool isFollowed,
      @JsonKey(name: "isBlocked") bool isBlocked,
      @JsonKey(name: "profileImg")
      NovelWebViewAuthorDetailsProfileImg profileImg,
      @JsonKey(name: "isProfileImgMasked") bool isProfileImgMasked});

  $NovelWebViewAuthorDetailsProfileImgCopyWith<$Res> get profileImg;
}

/// @nodoc
class _$NovelWebViewAuthorDetailsCopyWithImpl<$Res,
        $Val extends NovelWebViewAuthorDetails>
    implements $NovelWebViewAuthorDetailsCopyWith<$Res> {
  _$NovelWebViewAuthorDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? userName = null,
    Object? isFollowed = null,
    Object? isBlocked = null,
    Object? profileImg = null,
    Object? isProfileImgMasked = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      isFollowed: null == isFollowed
          ? _value.isFollowed
          : isFollowed // ignore: cast_nullable_to_non_nullable
              as bool,
      isBlocked: null == isBlocked
          ? _value.isBlocked
          : isBlocked // ignore: cast_nullable_to_non_nullable
              as bool,
      profileImg: null == profileImg
          ? _value.profileImg
          : profileImg // ignore: cast_nullable_to_non_nullable
              as NovelWebViewAuthorDetailsProfileImg,
      isProfileImgMasked: null == isProfileImgMasked
          ? _value.isProfileImgMasked
          : isProfileImgMasked // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NovelWebViewAuthorDetailsProfileImgCopyWith<$Res> get profileImg {
    return $NovelWebViewAuthorDetailsProfileImgCopyWith<$Res>(_value.profileImg,
        (value) {
      return _then(_value.copyWith(profileImg: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NovelWebViewAuthorDetailsImplCopyWith<$Res>
    implements $NovelWebViewAuthorDetailsCopyWith<$Res> {
  factory _$$NovelWebViewAuthorDetailsImplCopyWith(
          _$NovelWebViewAuthorDetailsImpl value,
          $Res Function(_$NovelWebViewAuthorDetailsImpl) then) =
      __$$NovelWebViewAuthorDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "userId") int userId,
      @JsonKey(name: "userName") String userName,
      @JsonKey(name: "isFollowed") bool isFollowed,
      @JsonKey(name: "isBlocked") bool isBlocked,
      @JsonKey(name: "profileImg")
      NovelWebViewAuthorDetailsProfileImg profileImg,
      @JsonKey(name: "isProfileImgMasked") bool isProfileImgMasked});

  @override
  $NovelWebViewAuthorDetailsProfileImgCopyWith<$Res> get profileImg;
}

/// @nodoc
class __$$NovelWebViewAuthorDetailsImplCopyWithImpl<$Res>
    extends _$NovelWebViewAuthorDetailsCopyWithImpl<$Res,
        _$NovelWebViewAuthorDetailsImpl>
    implements _$$NovelWebViewAuthorDetailsImplCopyWith<$Res> {
  __$$NovelWebViewAuthorDetailsImplCopyWithImpl(
      _$NovelWebViewAuthorDetailsImpl _value,
      $Res Function(_$NovelWebViewAuthorDetailsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? userName = null,
    Object? isFollowed = null,
    Object? isBlocked = null,
    Object? profileImg = null,
    Object? isProfileImgMasked = null,
  }) {
    return _then(_$NovelWebViewAuthorDetailsImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      isFollowed: null == isFollowed
          ? _value.isFollowed
          : isFollowed // ignore: cast_nullable_to_non_nullable
              as bool,
      isBlocked: null == isBlocked
          ? _value.isBlocked
          : isBlocked // ignore: cast_nullable_to_non_nullable
              as bool,
      profileImg: null == profileImg
          ? _value.profileImg
          : profileImg // ignore: cast_nullable_to_non_nullable
              as NovelWebViewAuthorDetailsProfileImg,
      isProfileImgMasked: null == isProfileImgMasked
          ? _value.isProfileImgMasked
          : isProfileImgMasked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NovelWebViewAuthorDetailsImpl implements _NovelWebViewAuthorDetails {
  const _$NovelWebViewAuthorDetailsImpl(
      {@JsonKey(name: "userId") required this.userId,
      @JsonKey(name: "userName") required this.userName,
      @JsonKey(name: "isFollowed") required this.isFollowed,
      @JsonKey(name: "isBlocked") required this.isBlocked,
      @JsonKey(name: "profileImg") required this.profileImg,
      @JsonKey(name: "isProfileImgMasked") required this.isProfileImgMasked});

  factory _$NovelWebViewAuthorDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$NovelWebViewAuthorDetailsImplFromJson(json);

  @override
  @JsonKey(name: "userId")
  final int userId;
  @override
  @JsonKey(name: "userName")
  final String userName;
  @override
  @JsonKey(name: "isFollowed")
  final bool isFollowed;
  @override
  @JsonKey(name: "isBlocked")
  final bool isBlocked;
  @override
  @JsonKey(name: "profileImg")
  final NovelWebViewAuthorDetailsProfileImg profileImg;
  @override
  @JsonKey(name: "isProfileImgMasked")
  final bool isProfileImgMasked;

  @override
  String toString() {
    return 'NovelWebViewAuthorDetails(userId: $userId, userName: $userName, isFollowed: $isFollowed, isBlocked: $isBlocked, profileImg: $profileImg, isProfileImgMasked: $isProfileImgMasked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NovelWebViewAuthorDetailsImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.isFollowed, isFollowed) ||
                other.isFollowed == isFollowed) &&
            (identical(other.isBlocked, isBlocked) ||
                other.isBlocked == isBlocked) &&
            (identical(other.profileImg, profileImg) ||
                other.profileImg == profileImg) &&
            (identical(other.isProfileImgMasked, isProfileImgMasked) ||
                other.isProfileImgMasked == isProfileImgMasked));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, userName, isFollowed,
      isBlocked, profileImg, isProfileImgMasked);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NovelWebViewAuthorDetailsImplCopyWith<_$NovelWebViewAuthorDetailsImpl>
      get copyWith => __$$NovelWebViewAuthorDetailsImplCopyWithImpl<
          _$NovelWebViewAuthorDetailsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NovelWebViewAuthorDetailsImplToJson(
      this,
    );
  }
}

abstract class _NovelWebViewAuthorDetails implements NovelWebViewAuthorDetails {
  const factory _NovelWebViewAuthorDetails(
          {@JsonKey(name: "userId") required final int userId,
          @JsonKey(name: "userName") required final String userName,
          @JsonKey(name: "isFollowed") required final bool isFollowed,
          @JsonKey(name: "isBlocked") required final bool isBlocked,
          @JsonKey(name: "profileImg")
          required final NovelWebViewAuthorDetailsProfileImg profileImg,
          @JsonKey(name: "isProfileImgMasked")
          required final bool isProfileImgMasked}) =
      _$NovelWebViewAuthorDetailsImpl;

  factory _NovelWebViewAuthorDetails.fromJson(Map<String, dynamic> json) =
      _$NovelWebViewAuthorDetailsImpl.fromJson;

  @override
  @JsonKey(name: "userId")
  int get userId;
  @override
  @JsonKey(name: "userName")
  String get userName;
  @override
  @JsonKey(name: "isFollowed")
  bool get isFollowed;
  @override
  @JsonKey(name: "isBlocked")
  bool get isBlocked;
  @override
  @JsonKey(name: "profileImg")
  NovelWebViewAuthorDetailsProfileImg get profileImg;
  @override
  @JsonKey(name: "isProfileImgMasked")
  bool get isProfileImgMasked;
  @override
  @JsonKey(ignore: true)
  _$$NovelWebViewAuthorDetailsImplCopyWith<_$NovelWebViewAuthorDetailsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

NovelWebViewAuthorDetailsProfileImg
    _$NovelWebViewAuthorDetailsProfileImgFromJson(Map<String, dynamic> json) {
  return _NovelWebViewAuthorDetailsProfileImg.fromJson(json);
}

/// @nodoc
mixin _$NovelWebViewAuthorDetailsProfileImg {
  @JsonKey(name: "url")
  String get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NovelWebViewAuthorDetailsProfileImgCopyWith<
          NovelWebViewAuthorDetailsProfileImg>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NovelWebViewAuthorDetailsProfileImgCopyWith<$Res> {
  factory $NovelWebViewAuthorDetailsProfileImgCopyWith(
          NovelWebViewAuthorDetailsProfileImg value,
          $Res Function(NovelWebViewAuthorDetailsProfileImg) then) =
      _$NovelWebViewAuthorDetailsProfileImgCopyWithImpl<$Res,
          NovelWebViewAuthorDetailsProfileImg>;
  @useResult
  $Res call({@JsonKey(name: "url") String url});
}

/// @nodoc
class _$NovelWebViewAuthorDetailsProfileImgCopyWithImpl<$Res,
        $Val extends NovelWebViewAuthorDetailsProfileImg>
    implements $NovelWebViewAuthorDetailsProfileImgCopyWith<$Res> {
  _$NovelWebViewAuthorDetailsProfileImgCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NovelWebViewAuthorDetailsProfileImgImplCopyWith<$Res>
    implements $NovelWebViewAuthorDetailsProfileImgCopyWith<$Res> {
  factory _$$NovelWebViewAuthorDetailsProfileImgImplCopyWith(
          _$NovelWebViewAuthorDetailsProfileImgImpl value,
          $Res Function(_$NovelWebViewAuthorDetailsProfileImgImpl) then) =
      __$$NovelWebViewAuthorDetailsProfileImgImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: "url") String url});
}

/// @nodoc
class __$$NovelWebViewAuthorDetailsProfileImgImplCopyWithImpl<$Res>
    extends _$NovelWebViewAuthorDetailsProfileImgCopyWithImpl<$Res,
        _$NovelWebViewAuthorDetailsProfileImgImpl>
    implements _$$NovelWebViewAuthorDetailsProfileImgImplCopyWith<$Res> {
  __$$NovelWebViewAuthorDetailsProfileImgImplCopyWithImpl(
      _$NovelWebViewAuthorDetailsProfileImgImpl _value,
      $Res Function(_$NovelWebViewAuthorDetailsProfileImgImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
  }) {
    return _then(_$NovelWebViewAuthorDetailsProfileImgImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NovelWebViewAuthorDetailsProfileImgImpl
    implements _NovelWebViewAuthorDetailsProfileImg {
  const _$NovelWebViewAuthorDetailsProfileImgImpl(
      {@JsonKey(name: "url") required this.url});

  factory _$NovelWebViewAuthorDetailsProfileImgImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$NovelWebViewAuthorDetailsProfileImgImplFromJson(json);

  @override
  @JsonKey(name: "url")
  final String url;

  @override
  String toString() {
    return 'NovelWebViewAuthorDetailsProfileImg(url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NovelWebViewAuthorDetailsProfileImgImpl &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NovelWebViewAuthorDetailsProfileImgImplCopyWith<
          _$NovelWebViewAuthorDetailsProfileImgImpl>
      get copyWith => __$$NovelWebViewAuthorDetailsProfileImgImplCopyWithImpl<
          _$NovelWebViewAuthorDetailsProfileImgImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NovelWebViewAuthorDetailsProfileImgImplToJson(
      this,
    );
  }
}

abstract class _NovelWebViewAuthorDetailsProfileImg
    implements NovelWebViewAuthorDetailsProfileImg {
  const factory _NovelWebViewAuthorDetailsProfileImg(
          {@JsonKey(name: "url") required final String url}) =
      _$NovelWebViewAuthorDetailsProfileImgImpl;

  factory _NovelWebViewAuthorDetailsProfileImg.fromJson(
          Map<String, dynamic> json) =
      _$NovelWebViewAuthorDetailsProfileImgImpl.fromJson;

  @override
  @JsonKey(name: "url")
  String get url;
  @override
  @JsonKey(ignore: true)
  _$$NovelWebViewAuthorDetailsProfileImgImplCopyWith<
          _$NovelWebViewAuthorDetailsProfileImgImpl>
      get copyWith => throw _privateConstructorUsedError;
}

IllustValue _$IllustValueFromJson(Map<String, dynamic> json) {
  return _IllustValue.fromJson(json);
}

/// @nodoc
mixin _$IllustValue {
  @JsonKey(name: "visible")
  bool get visible => throw _privateConstructorUsedError;
  @JsonKey(name: "availableMessage")
  dynamic get availableMessage => throw _privateConstructorUsedError;
  @JsonKey(name: "illust")
  IllustIllust get illust => throw _privateConstructorUsedError;
  @JsonKey(name: "user")
  User get user => throw _privateConstructorUsedError;
  @JsonKey(name: "id")
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: "page")
  int get page => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IllustValueCopyWith<IllustValue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IllustValueCopyWith<$Res> {
  factory $IllustValueCopyWith(
          IllustValue value, $Res Function(IllustValue) then) =
      _$IllustValueCopyWithImpl<$Res, IllustValue>;
  @useResult
  $Res call(
      {@JsonKey(name: "visible") bool visible,
      @JsonKey(name: "availableMessage") dynamic availableMessage,
      @JsonKey(name: "illust") IllustIllust illust,
      @JsonKey(name: "user") User user,
      @JsonKey(name: "id") String id,
      @JsonKey(name: "page") int page});

  $IllustIllustCopyWith<$Res> get illust;
  $UserCopyWith<$Res> get user;
}

/// @nodoc
class _$IllustValueCopyWithImpl<$Res, $Val extends IllustValue>
    implements $IllustValueCopyWith<$Res> {
  _$IllustValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? visible = null,
    Object? availableMessage = freezed,
    Object? illust = null,
    Object? user = null,
    Object? id = null,
    Object? page = null,
  }) {
    return _then(_value.copyWith(
      visible: null == visible
          ? _value.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool,
      availableMessage: freezed == availableMessage
          ? _value.availableMessage
          : availableMessage // ignore: cast_nullable_to_non_nullable
              as dynamic,
      illust: null == illust
          ? _value.illust
          : illust // ignore: cast_nullable_to_non_nullable
              as IllustIllust,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $IllustIllustCopyWith<$Res> get illust {
    return $IllustIllustCopyWith<$Res>(_value.illust, (value) {
      return _then(_value.copyWith(illust: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$IllustValueImplCopyWith<$Res>
    implements $IllustValueCopyWith<$Res> {
  factory _$$IllustValueImplCopyWith(
          _$IllustValueImpl value, $Res Function(_$IllustValueImpl) then) =
      __$$IllustValueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "visible") bool visible,
      @JsonKey(name: "availableMessage") dynamic availableMessage,
      @JsonKey(name: "illust") IllustIllust illust,
      @JsonKey(name: "user") User user,
      @JsonKey(name: "id") String id,
      @JsonKey(name: "page") int page});

  @override
  $IllustIllustCopyWith<$Res> get illust;
  @override
  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$IllustValueImplCopyWithImpl<$Res>
    extends _$IllustValueCopyWithImpl<$Res, _$IllustValueImpl>
    implements _$$IllustValueImplCopyWith<$Res> {
  __$$IllustValueImplCopyWithImpl(
      _$IllustValueImpl _value, $Res Function(_$IllustValueImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? visible = null,
    Object? availableMessage = freezed,
    Object? illust = null,
    Object? user = null,
    Object? id = null,
    Object? page = null,
  }) {
    return _then(_$IllustValueImpl(
      visible: null == visible
          ? _value.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool,
      availableMessage: freezed == availableMessage
          ? _value.availableMessage
          : availableMessage // ignore: cast_nullable_to_non_nullable
              as dynamic,
      illust: null == illust
          ? _value.illust
          : illust // ignore: cast_nullable_to_non_nullable
              as IllustIllust,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IllustValueImpl implements _IllustValue {
  const _$IllustValueImpl(
      {@JsonKey(name: "visible") required this.visible,
      @JsonKey(name: "availableMessage") required this.availableMessage,
      @JsonKey(name: "illust") required this.illust,
      @JsonKey(name: "user") required this.user,
      @JsonKey(name: "id") required this.id,
      @JsonKey(name: "page") required this.page});

  factory _$IllustValueImpl.fromJson(Map<String, dynamic> json) =>
      _$$IllustValueImplFromJson(json);

  @override
  @JsonKey(name: "visible")
  final bool visible;
  @override
  @JsonKey(name: "availableMessage")
  final dynamic availableMessage;
  @override
  @JsonKey(name: "illust")
  final IllustIllust illust;
  @override
  @JsonKey(name: "user")
  final User user;
  @override
  @JsonKey(name: "id")
  final String id;
  @override
  @JsonKey(name: "page")
  final int page;

  @override
  String toString() {
    return 'IllustValue(visible: $visible, availableMessage: $availableMessage, illust: $illust, user: $user, id: $id, page: $page)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IllustValueImpl &&
            (identical(other.visible, visible) || other.visible == visible) &&
            const DeepCollectionEquality()
                .equals(other.availableMessage, availableMessage) &&
            (identical(other.illust, illust) || other.illust == illust) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.page, page) || other.page == page));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      visible,
      const DeepCollectionEquality().hash(availableMessage),
      illust,
      user,
      id,
      page);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IllustValueImplCopyWith<_$IllustValueImpl> get copyWith =>
      __$$IllustValueImplCopyWithImpl<_$IllustValueImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IllustValueImplToJson(
      this,
    );
  }
}

abstract class _IllustValue implements IllustValue {
  const factory _IllustValue(
      {@JsonKey(name: "visible") required final bool visible,
      @JsonKey(name: "availableMessage")
      required final dynamic availableMessage,
      @JsonKey(name: "illust") required final IllustIllust illust,
      @JsonKey(name: "user") required final User user,
      @JsonKey(name: "id") required final String id,
      @JsonKey(name: "page") required final int page}) = _$IllustValueImpl;

  factory _IllustValue.fromJson(Map<String, dynamic> json) =
      _$IllustValueImpl.fromJson;

  @override
  @JsonKey(name: "visible")
  bool get visible;
  @override
  @JsonKey(name: "availableMessage")
  dynamic get availableMessage;
  @override
  @JsonKey(name: "illust")
  IllustIllust get illust;
  @override
  @JsonKey(name: "user")
  User get user;
  @override
  @JsonKey(name: "id")
  String get id;
  @override
  @JsonKey(name: "page")
  int get page;
  @override
  @JsonKey(ignore: true)
  _$$IllustValueImplCopyWith<_$IllustValueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IllustIllust _$IllustIllustFromJson(Map<String, dynamic> json) {
  return _IllustIllust.fromJson(json);
}

/// @nodoc
mixin _$IllustIllust {
  @JsonKey(name: "title")
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: "description")
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: "restrict")
  int get restrict => throw _privateConstructorUsedError;
  @JsonKey(name: "xRestrict")
  int get xRestrict => throw _privateConstructorUsedError;
  @JsonKey(name: "sl")
  int get sl => throw _privateConstructorUsedError;
  @JsonKey(name: "tags")
  List<Tag> get tags => throw _privateConstructorUsedError;
  @JsonKey(name: "images")
  Images get images => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IllustIllustCopyWith<IllustIllust> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IllustIllustCopyWith<$Res> {
  factory $IllustIllustCopyWith(
          IllustIllust value, $Res Function(IllustIllust) then) =
      _$IllustIllustCopyWithImpl<$Res, IllustIllust>;
  @useResult
  $Res call(
      {@JsonKey(name: "title") String title,
      @JsonKey(name: "description") String description,
      @JsonKey(name: "restrict") int restrict,
      @JsonKey(name: "xRestrict") int xRestrict,
      @JsonKey(name: "sl") int sl,
      @JsonKey(name: "tags") List<Tag> tags,
      @JsonKey(name: "images") Images images});

  $ImagesCopyWith<$Res> get images;
}

/// @nodoc
class _$IllustIllustCopyWithImpl<$Res, $Val extends IllustIllust>
    implements $IllustIllustCopyWith<$Res> {
  _$IllustIllustCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? restrict = null,
    Object? xRestrict = null,
    Object? sl = null,
    Object? tags = null,
    Object? images = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      restrict: null == restrict
          ? _value.restrict
          : restrict // ignore: cast_nullable_to_non_nullable
              as int,
      xRestrict: null == xRestrict
          ? _value.xRestrict
          : xRestrict // ignore: cast_nullable_to_non_nullable
              as int,
      sl: null == sl
          ? _value.sl
          : sl // ignore: cast_nullable_to_non_nullable
              as int,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<Tag>,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as Images,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ImagesCopyWith<$Res> get images {
    return $ImagesCopyWith<$Res>(_value.images, (value) {
      return _then(_value.copyWith(images: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$IllustIllustImplCopyWith<$Res>
    implements $IllustIllustCopyWith<$Res> {
  factory _$$IllustIllustImplCopyWith(
          _$IllustIllustImpl value, $Res Function(_$IllustIllustImpl) then) =
      __$$IllustIllustImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "title") String title,
      @JsonKey(name: "description") String description,
      @JsonKey(name: "restrict") int restrict,
      @JsonKey(name: "xRestrict") int xRestrict,
      @JsonKey(name: "sl") int sl,
      @JsonKey(name: "tags") List<Tag> tags,
      @JsonKey(name: "images") Images images});

  @override
  $ImagesCopyWith<$Res> get images;
}

/// @nodoc
class __$$IllustIllustImplCopyWithImpl<$Res>
    extends _$IllustIllustCopyWithImpl<$Res, _$IllustIllustImpl>
    implements _$$IllustIllustImplCopyWith<$Res> {
  __$$IllustIllustImplCopyWithImpl(
      _$IllustIllustImpl _value, $Res Function(_$IllustIllustImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? restrict = null,
    Object? xRestrict = null,
    Object? sl = null,
    Object? tags = null,
    Object? images = null,
  }) {
    return _then(_$IllustIllustImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      restrict: null == restrict
          ? _value.restrict
          : restrict // ignore: cast_nullable_to_non_nullable
              as int,
      xRestrict: null == xRestrict
          ? _value.xRestrict
          : xRestrict // ignore: cast_nullable_to_non_nullable
              as int,
      sl: null == sl
          ? _value.sl
          : sl // ignore: cast_nullable_to_non_nullable
              as int,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<Tag>,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as Images,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IllustIllustImpl implements _IllustIllust {
  const _$IllustIllustImpl(
      {@JsonKey(name: "title") required this.title,
      @JsonKey(name: "description") required this.description,
      @JsonKey(name: "restrict") required this.restrict,
      @JsonKey(name: "xRestrict") required this.xRestrict,
      @JsonKey(name: "sl") required this.sl,
      @JsonKey(name: "tags") required final List<Tag> tags,
      @JsonKey(name: "images") required this.images})
      : _tags = tags;

  factory _$IllustIllustImpl.fromJson(Map<String, dynamic> json) =>
      _$$IllustIllustImplFromJson(json);

  @override
  @JsonKey(name: "title")
  final String title;
  @override
  @JsonKey(name: "description")
  final String description;
  @override
  @JsonKey(name: "restrict")
  final int restrict;
  @override
  @JsonKey(name: "xRestrict")
  final int xRestrict;
  @override
  @JsonKey(name: "sl")
  final int sl;
  final List<Tag> _tags;
  @override
  @JsonKey(name: "tags")
  List<Tag> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey(name: "images")
  final Images images;

  @override
  String toString() {
    return 'IllustIllust(title: $title, description: $description, restrict: $restrict, xRestrict: $xRestrict, sl: $sl, tags: $tags, images: $images)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IllustIllustImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.restrict, restrict) ||
                other.restrict == restrict) &&
            (identical(other.xRestrict, xRestrict) ||
                other.xRestrict == xRestrict) &&
            (identical(other.sl, sl) || other.sl == sl) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.images, images) || other.images == images));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, description, restrict,
      xRestrict, sl, const DeepCollectionEquality().hash(_tags), images);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IllustIllustImplCopyWith<_$IllustIllustImpl> get copyWith =>
      __$$IllustIllustImplCopyWithImpl<_$IllustIllustImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IllustIllustImplToJson(
      this,
    );
  }
}

abstract class _IllustIllust implements IllustIllust {
  const factory _IllustIllust(
          {@JsonKey(name: "title") required final String title,
          @JsonKey(name: "description") required final String description,
          @JsonKey(name: "restrict") required final int restrict,
          @JsonKey(name: "xRestrict") required final int xRestrict,
          @JsonKey(name: "sl") required final int sl,
          @JsonKey(name: "tags") required final List<Tag> tags,
          @JsonKey(name: "images") required final Images images}) =
      _$IllustIllustImpl;

  factory _IllustIllust.fromJson(Map<String, dynamic> json) =
      _$IllustIllustImpl.fromJson;

  @override
  @JsonKey(name: "title")
  String get title;
  @override
  @JsonKey(name: "description")
  String get description;
  @override
  @JsonKey(name: "restrict")
  int get restrict;
  @override
  @JsonKey(name: "xRestrict")
  int get xRestrict;
  @override
  @JsonKey(name: "sl")
  int get sl;
  @override
  @JsonKey(name: "tags")
  List<Tag> get tags;
  @override
  @JsonKey(name: "images")
  Images get images;
  @override
  @JsonKey(ignore: true)
  _$$IllustIllustImplCopyWith<_$IllustIllustImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Images _$ImagesFromJson(Map<String, dynamic> json) {
  return _Images.fromJson(json);
}

/// @nodoc
mixin _$Images {
  @JsonKey(name: "small")
  dynamic get small => throw _privateConstructorUsedError;
  @JsonKey(name: "medium")
  String get medium => throw _privateConstructorUsedError;
  @JsonKey(name: "original")
  dynamic get original => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ImagesCopyWith<Images> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImagesCopyWith<$Res> {
  factory $ImagesCopyWith(Images value, $Res Function(Images) then) =
      _$ImagesCopyWithImpl<$Res, Images>;
  @useResult
  $Res call(
      {@JsonKey(name: "small") dynamic small,
      @JsonKey(name: "medium") String medium,
      @JsonKey(name: "original") dynamic original});
}

/// @nodoc
class _$ImagesCopyWithImpl<$Res, $Val extends Images>
    implements $ImagesCopyWith<$Res> {
  _$ImagesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? small = freezed,
    Object? medium = null,
    Object? original = freezed,
  }) {
    return _then(_value.copyWith(
      small: freezed == small
          ? _value.small
          : small // ignore: cast_nullable_to_non_nullable
              as dynamic,
      medium: null == medium
          ? _value.medium
          : medium // ignore: cast_nullable_to_non_nullable
              as String,
      original: freezed == original
          ? _value.original
          : original // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ImagesImplCopyWith<$Res> implements $ImagesCopyWith<$Res> {
  factory _$$ImagesImplCopyWith(
          _$ImagesImpl value, $Res Function(_$ImagesImpl) then) =
      __$$ImagesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "small") dynamic small,
      @JsonKey(name: "medium") String medium,
      @JsonKey(name: "original") dynamic original});
}

/// @nodoc
class __$$ImagesImplCopyWithImpl<$Res>
    extends _$ImagesCopyWithImpl<$Res, _$ImagesImpl>
    implements _$$ImagesImplCopyWith<$Res> {
  __$$ImagesImplCopyWithImpl(
      _$ImagesImpl _value, $Res Function(_$ImagesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? small = freezed,
    Object? medium = null,
    Object? original = freezed,
  }) {
    return _then(_$ImagesImpl(
      small: freezed == small
          ? _value.small
          : small // ignore: cast_nullable_to_non_nullable
              as dynamic,
      medium: null == medium
          ? _value.medium
          : medium // ignore: cast_nullable_to_non_nullable
              as String,
      original: freezed == original
          ? _value.original
          : original // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImagesImpl implements _Images {
  const _$ImagesImpl(
      {@JsonKey(name: "small") required this.small,
      @JsonKey(name: "medium") required this.medium,
      @JsonKey(name: "original") required this.original});

  factory _$ImagesImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImagesImplFromJson(json);

  @override
  @JsonKey(name: "small")
  final dynamic small;
  @override
  @JsonKey(name: "medium")
  final String medium;
  @override
  @JsonKey(name: "original")
  final dynamic original;

  @override
  String toString() {
    return 'Images(small: $small, medium: $medium, original: $original)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImagesImpl &&
            const DeepCollectionEquality().equals(other.small, small) &&
            (identical(other.medium, medium) || other.medium == medium) &&
            const DeepCollectionEquality().equals(other.original, original));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(small),
      medium,
      const DeepCollectionEquality().hash(original));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImagesImplCopyWith<_$ImagesImpl> get copyWith =>
      __$$ImagesImplCopyWithImpl<_$ImagesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImagesImplToJson(
      this,
    );
  }
}

abstract class _Images implements Images {
  const factory _Images(
          {@JsonKey(name: "small") required final dynamic small,
          @JsonKey(name: "medium") required final String medium,
          @JsonKey(name: "original") required final dynamic original}) =
      _$ImagesImpl;

  factory _Images.fromJson(Map<String, dynamic> json) = _$ImagesImpl.fromJson;

  @override
  @JsonKey(name: "small")
  dynamic get small;
  @override
  @JsonKey(name: "medium")
  String get medium;
  @override
  @JsonKey(name: "original")
  dynamic get original;
  @override
  @JsonKey(ignore: true)
  _$$ImagesImplCopyWith<_$ImagesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Tag _$TagFromJson(Map<String, dynamic> json) {
  return _Tag.fromJson(json);
}

/// @nodoc
mixin _$Tag {
  @JsonKey(name: "tag")
  String get tag => throw _privateConstructorUsedError;
  @JsonKey(name: "userId")
  String get userId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TagCopyWith<Tag> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TagCopyWith<$Res> {
  factory $TagCopyWith(Tag value, $Res Function(Tag) then) =
      _$TagCopyWithImpl<$Res, Tag>;
  @useResult
  $Res call(
      {@JsonKey(name: "tag") String tag,
      @JsonKey(name: "userId") String userId});
}

/// @nodoc
class _$TagCopyWithImpl<$Res, $Val extends Tag> implements $TagCopyWith<$Res> {
  _$TagCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tag = null,
    Object? userId = null,
  }) {
    return _then(_value.copyWith(
      tag: null == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TagImplCopyWith<$Res> implements $TagCopyWith<$Res> {
  factory _$$TagImplCopyWith(_$TagImpl value, $Res Function(_$TagImpl) then) =
      __$$TagImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "tag") String tag,
      @JsonKey(name: "userId") String userId});
}

/// @nodoc
class __$$TagImplCopyWithImpl<$Res> extends _$TagCopyWithImpl<$Res, _$TagImpl>
    implements _$$TagImplCopyWith<$Res> {
  __$$TagImplCopyWithImpl(_$TagImpl _value, $Res Function(_$TagImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tag = null,
    Object? userId = null,
  }) {
    return _then(_$TagImpl(
      tag: null == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TagImpl implements _Tag {
  const _$TagImpl(
      {@JsonKey(name: "tag") required this.tag,
      @JsonKey(name: "userId") required this.userId});

  factory _$TagImpl.fromJson(Map<String, dynamic> json) =>
      _$$TagImplFromJson(json);

  @override
  @JsonKey(name: "tag")
  final String tag;
  @override
  @JsonKey(name: "userId")
  final String userId;

  @override
  String toString() {
    return 'Tag(tag: $tag, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TagImpl &&
            (identical(other.tag, tag) || other.tag == tag) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, tag, userId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TagImplCopyWith<_$TagImpl> get copyWith =>
      __$$TagImplCopyWithImpl<_$TagImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TagImplToJson(
      this,
    );
  }
}

abstract class _Tag implements Tag {
  const factory _Tag(
      {@JsonKey(name: "tag") required final String tag,
      @JsonKey(name: "userId") required final String userId}) = _$TagImpl;

  factory _Tag.fromJson(Map<String, dynamic> json) = _$TagImpl.fromJson;

  @override
  @JsonKey(name: "tag")
  String get tag;
  @override
  @JsonKey(name: "userId")
  String get userId;
  @override
  @JsonKey(ignore: true)
  _$$TagImplCopyWith<_$TagImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  @JsonKey(name: "id")
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: "name")
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: "image")
  String get image => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") String id,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "image") String image});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? image = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") String id,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "image") String image});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? image = null,
  }) {
    return _then(_$UserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "name") required this.name,
      @JsonKey(name: "image") required this.image});

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final String id;
  @override
  @JsonKey(name: "name")
  final String name;
  @override
  @JsonKey(name: "image")
  final String image;

  @override
  String toString() {
    return 'User(id: $id, name: $name, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {@JsonKey(name: "id") required final String id,
      @JsonKey(name: "name") required final String name,
      @JsonKey(name: "image") required final String image}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  @JsonKey(name: "id")
  String get id;
  @override
  @JsonKey(name: "name")
  String get name;
  @override
  @JsonKey(name: "image")
  String get image;
  @override
  @JsonKey(ignore: true)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Image _$ImageFromJson(Map<String, dynamic> json) {
  return _Image.fromJson(json);
}

/// @nodoc
mixin _$Image {
  @JsonKey(name: "novelImageId")
  String get novelImageId => throw _privateConstructorUsedError;
  @JsonKey(name: "sl")
  String get sl => throw _privateConstructorUsedError;
  @JsonKey(name: "urls")
  Urls get urls => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ImageCopyWith<Image> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageCopyWith<$Res> {
  factory $ImageCopyWith(Image value, $Res Function(Image) then) =
      _$ImageCopyWithImpl<$Res, Image>;
  @useResult
  $Res call(
      {@JsonKey(name: "novelImageId") String novelImageId,
      @JsonKey(name: "sl") String sl,
      @JsonKey(name: "urls") Urls urls});

  $UrlsCopyWith<$Res> get urls;
}

/// @nodoc
class _$ImageCopyWithImpl<$Res, $Val extends Image>
    implements $ImageCopyWith<$Res> {
  _$ImageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? novelImageId = null,
    Object? sl = null,
    Object? urls = null,
  }) {
    return _then(_value.copyWith(
      novelImageId: null == novelImageId
          ? _value.novelImageId
          : novelImageId // ignore: cast_nullable_to_non_nullable
              as String,
      sl: null == sl
          ? _value.sl
          : sl // ignore: cast_nullable_to_non_nullable
              as String,
      urls: null == urls
          ? _value.urls
          : urls // ignore: cast_nullable_to_non_nullable
              as Urls,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UrlsCopyWith<$Res> get urls {
    return $UrlsCopyWith<$Res>(_value.urls, (value) {
      return _then(_value.copyWith(urls: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ImageImplCopyWith<$Res> implements $ImageCopyWith<$Res> {
  factory _$$ImageImplCopyWith(
          _$ImageImpl value, $Res Function(_$ImageImpl) then) =
      __$$ImageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "novelImageId") String novelImageId,
      @JsonKey(name: "sl") String sl,
      @JsonKey(name: "urls") Urls urls});

  @override
  $UrlsCopyWith<$Res> get urls;
}

/// @nodoc
class __$$ImageImplCopyWithImpl<$Res>
    extends _$ImageCopyWithImpl<$Res, _$ImageImpl>
    implements _$$ImageImplCopyWith<$Res> {
  __$$ImageImplCopyWithImpl(
      _$ImageImpl _value, $Res Function(_$ImageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? novelImageId = null,
    Object? sl = null,
    Object? urls = null,
  }) {
    return _then(_$ImageImpl(
      novelImageId: null == novelImageId
          ? _value.novelImageId
          : novelImageId // ignore: cast_nullable_to_non_nullable
              as String,
      sl: null == sl
          ? _value.sl
          : sl // ignore: cast_nullable_to_non_nullable
              as String,
      urls: null == urls
          ? _value.urls
          : urls // ignore: cast_nullable_to_non_nullable
              as Urls,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImageImpl implements _Image {
  const _$ImageImpl(
      {@JsonKey(name: "novelImageId") required this.novelImageId,
      @JsonKey(name: "sl") required this.sl,
      @JsonKey(name: "urls") required this.urls});

  factory _$ImageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageImplFromJson(json);

  @override
  @JsonKey(name: "novelImageId")
  final String novelImageId;
  @override
  @JsonKey(name: "sl")
  final String sl;
  @override
  @JsonKey(name: "urls")
  final Urls urls;

  @override
  String toString() {
    return 'Image(novelImageId: $novelImageId, sl: $sl, urls: $urls)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageImpl &&
            (identical(other.novelImageId, novelImageId) ||
                other.novelImageId == novelImageId) &&
            (identical(other.sl, sl) || other.sl == sl) &&
            (identical(other.urls, urls) || other.urls == urls));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, novelImageId, sl, urls);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageImplCopyWith<_$ImageImpl> get copyWith =>
      __$$ImageImplCopyWithImpl<_$ImageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageImplToJson(
      this,
    );
  }
}

abstract class _Image implements Image {
  const factory _Image(
      {@JsonKey(name: "novelImageId") required final String novelImageId,
      @JsonKey(name: "sl") required final String sl,
      @JsonKey(name: "urls") required final Urls urls}) = _$ImageImpl;

  factory _Image.fromJson(Map<String, dynamic> json) = _$ImageImpl.fromJson;

  @override
  @JsonKey(name: "novelImageId")
  String get novelImageId;
  @override
  @JsonKey(name: "sl")
  String get sl;
  @override
  @JsonKey(name: "urls")
  Urls get urls;
  @override
  @JsonKey(ignore: true)
  _$$ImageImplCopyWith<_$ImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Urls _$UrlsFromJson(Map<String, dynamic> json) {
  return _Urls.fromJson(json);
}

/// @nodoc
mixin _$Urls {
  @JsonKey(name: "240mw")
  String get the240Mw => throw _privateConstructorUsedError;
  @JsonKey(name: "480mw")
  String get the480Mw => throw _privateConstructorUsedError;
  @JsonKey(name: "1200x1200")
  String get the1200X1200 => throw _privateConstructorUsedError;
  @JsonKey(name: "128x128")
  String get the128X128 => throw _privateConstructorUsedError;
  @JsonKey(name: "original")
  String get original => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UrlsCopyWith<Urls> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UrlsCopyWith<$Res> {
  factory $UrlsCopyWith(Urls value, $Res Function(Urls) then) =
      _$UrlsCopyWithImpl<$Res, Urls>;
  @useResult
  $Res call(
      {@JsonKey(name: "240mw") String the240Mw,
      @JsonKey(name: "480mw") String the480Mw,
      @JsonKey(name: "1200x1200") String the1200X1200,
      @JsonKey(name: "128x128") String the128X128,
      @JsonKey(name: "original") String original});
}

/// @nodoc
class _$UrlsCopyWithImpl<$Res, $Val extends Urls>
    implements $UrlsCopyWith<$Res> {
  _$UrlsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? the240Mw = null,
    Object? the480Mw = null,
    Object? the1200X1200 = null,
    Object? the128X128 = null,
    Object? original = null,
  }) {
    return _then(_value.copyWith(
      the240Mw: null == the240Mw
          ? _value.the240Mw
          : the240Mw // ignore: cast_nullable_to_non_nullable
              as String,
      the480Mw: null == the480Mw
          ? _value.the480Mw
          : the480Mw // ignore: cast_nullable_to_non_nullable
              as String,
      the1200X1200: null == the1200X1200
          ? _value.the1200X1200
          : the1200X1200 // ignore: cast_nullable_to_non_nullable
              as String,
      the128X128: null == the128X128
          ? _value.the128X128
          : the128X128 // ignore: cast_nullable_to_non_nullable
              as String,
      original: null == original
          ? _value.original
          : original // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UrlsImplCopyWith<$Res> implements $UrlsCopyWith<$Res> {
  factory _$$UrlsImplCopyWith(
          _$UrlsImpl value, $Res Function(_$UrlsImpl) then) =
      __$$UrlsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "240mw") String the240Mw,
      @JsonKey(name: "480mw") String the480Mw,
      @JsonKey(name: "1200x1200") String the1200X1200,
      @JsonKey(name: "128x128") String the128X128,
      @JsonKey(name: "original") String original});
}

/// @nodoc
class __$$UrlsImplCopyWithImpl<$Res>
    extends _$UrlsCopyWithImpl<$Res, _$UrlsImpl>
    implements _$$UrlsImplCopyWith<$Res> {
  __$$UrlsImplCopyWithImpl(_$UrlsImpl _value, $Res Function(_$UrlsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? the240Mw = null,
    Object? the480Mw = null,
    Object? the1200X1200 = null,
    Object? the128X128 = null,
    Object? original = null,
  }) {
    return _then(_$UrlsImpl(
      the240Mw: null == the240Mw
          ? _value.the240Mw
          : the240Mw // ignore: cast_nullable_to_non_nullable
              as String,
      the480Mw: null == the480Mw
          ? _value.the480Mw
          : the480Mw // ignore: cast_nullable_to_non_nullable
              as String,
      the1200X1200: null == the1200X1200
          ? _value.the1200X1200
          : the1200X1200 // ignore: cast_nullable_to_non_nullable
              as String,
      the128X128: null == the128X128
          ? _value.the128X128
          : the128X128 // ignore: cast_nullable_to_non_nullable
              as String,
      original: null == original
          ? _value.original
          : original // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UrlsImpl implements _Urls {
  const _$UrlsImpl(
      {@JsonKey(name: "240mw") required this.the240Mw,
      @JsonKey(name: "480mw") required this.the480Mw,
      @JsonKey(name: "1200x1200") required this.the1200X1200,
      @JsonKey(name: "128x128") required this.the128X128,
      @JsonKey(name: "original") required this.original});

  factory _$UrlsImpl.fromJson(Map<String, dynamic> json) =>
      _$$UrlsImplFromJson(json);

  @override
  @JsonKey(name: "240mw")
  final String the240Mw;
  @override
  @JsonKey(name: "480mw")
  final String the480Mw;
  @override
  @JsonKey(name: "1200x1200")
  final String the1200X1200;
  @override
  @JsonKey(name: "128x128")
  final String the128X128;
  @override
  @JsonKey(name: "original")
  final String original;

  @override
  String toString() {
    return 'Urls(the240Mw: $the240Mw, the480Mw: $the480Mw, the1200X1200: $the1200X1200, the128X128: $the128X128, original: $original)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UrlsImpl &&
            (identical(other.the240Mw, the240Mw) ||
                other.the240Mw == the240Mw) &&
            (identical(other.the480Mw, the480Mw) ||
                other.the480Mw == the480Mw) &&
            (identical(other.the1200X1200, the1200X1200) ||
                other.the1200X1200 == the1200X1200) &&
            (identical(other.the128X128, the128X128) ||
                other.the128X128 == the128X128) &&
            (identical(other.original, original) ||
                other.original == original));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, the240Mw, the480Mw, the1200X1200, the128X128, original);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UrlsImplCopyWith<_$UrlsImpl> get copyWith =>
      __$$UrlsImplCopyWithImpl<_$UrlsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UrlsImplToJson(
      this,
    );
  }
}

abstract class _Urls implements Urls {
  const factory _Urls(
      {@JsonKey(name: "240mw") required final String the240Mw,
      @JsonKey(name: "480mw") required final String the480Mw,
      @JsonKey(name: "1200x1200") required final String the1200X1200,
      @JsonKey(name: "128x128") required final String the128X128,
      @JsonKey(name: "original") required final String original}) = _$UrlsImpl;

  factory _Urls.fromJson(Map<String, dynamic> json) = _$UrlsImpl.fromJson;

  @override
  @JsonKey(name: "240mw")
  String get the240Mw;
  @override
  @JsonKey(name: "480mw")
  String get the480Mw;
  @override
  @JsonKey(name: "1200x1200")
  String get the1200X1200;
  @override
  @JsonKey(name: "128x128")
  String get the128X128;
  @override
  @JsonKey(name: "original")
  String get original;
  @override
  @JsonKey(ignore: true)
  _$$UrlsImplCopyWith<_$UrlsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Rating _$RatingFromJson(Map<String, dynamic> json) {
  return _Rating.fromJson(json);
}

/// @nodoc
mixin _$Rating {
  @JsonKey(name: "like")
  int get like => throw _privateConstructorUsedError;
  @JsonKey(name: "bookmark")
  int get bookmark => throw _privateConstructorUsedError;
  @JsonKey(name: "view")
  int get view => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RatingCopyWith<Rating> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RatingCopyWith<$Res> {
  factory $RatingCopyWith(Rating value, $Res Function(Rating) then) =
      _$RatingCopyWithImpl<$Res, Rating>;
  @useResult
  $Res call(
      {@JsonKey(name: "like") int like,
      @JsonKey(name: "bookmark") int bookmark,
      @JsonKey(name: "view") int view});
}

/// @nodoc
class _$RatingCopyWithImpl<$Res, $Val extends Rating>
    implements $RatingCopyWith<$Res> {
  _$RatingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? like = null,
    Object? bookmark = null,
    Object? view = null,
  }) {
    return _then(_value.copyWith(
      like: null == like
          ? _value.like
          : like // ignore: cast_nullable_to_non_nullable
              as int,
      bookmark: null == bookmark
          ? _value.bookmark
          : bookmark // ignore: cast_nullable_to_non_nullable
              as int,
      view: null == view
          ? _value.view
          : view // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RatingImplCopyWith<$Res> implements $RatingCopyWith<$Res> {
  factory _$$RatingImplCopyWith(
          _$RatingImpl value, $Res Function(_$RatingImpl) then) =
      __$$RatingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "like") int like,
      @JsonKey(name: "bookmark") int bookmark,
      @JsonKey(name: "view") int view});
}

/// @nodoc
class __$$RatingImplCopyWithImpl<$Res>
    extends _$RatingCopyWithImpl<$Res, _$RatingImpl>
    implements _$$RatingImplCopyWith<$Res> {
  __$$RatingImplCopyWithImpl(
      _$RatingImpl _value, $Res Function(_$RatingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? like = null,
    Object? bookmark = null,
    Object? view = null,
  }) {
    return _then(_$RatingImpl(
      like: null == like
          ? _value.like
          : like // ignore: cast_nullable_to_non_nullable
              as int,
      bookmark: null == bookmark
          ? _value.bookmark
          : bookmark // ignore: cast_nullable_to_non_nullable
              as int,
      view: null == view
          ? _value.view
          : view // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RatingImpl implements _Rating {
  const _$RatingImpl(
      {@JsonKey(name: "like") required this.like,
      @JsonKey(name: "bookmark") required this.bookmark,
      @JsonKey(name: "view") required this.view});

  factory _$RatingImpl.fromJson(Map<String, dynamic> json) =>
      _$$RatingImplFromJson(json);

  @override
  @JsonKey(name: "like")
  final int like;
  @override
  @JsonKey(name: "bookmark")
  final int bookmark;
  @override
  @JsonKey(name: "view")
  final int view;

  @override
  String toString() {
    return 'Rating(like: $like, bookmark: $bookmark, view: $view)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RatingImpl &&
            (identical(other.like, like) || other.like == like) &&
            (identical(other.bookmark, bookmark) ||
                other.bookmark == bookmark) &&
            (identical(other.view, view) || other.view == view));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, like, bookmark, view);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RatingImplCopyWith<_$RatingImpl> get copyWith =>
      __$$RatingImplCopyWithImpl<_$RatingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RatingImplToJson(
      this,
    );
  }
}

abstract class _Rating implements Rating {
  const factory _Rating(
      {@JsonKey(name: "like") required final int like,
      @JsonKey(name: "bookmark") required final int bookmark,
      @JsonKey(name: "view") required final int view}) = _$RatingImpl;

  factory _Rating.fromJson(Map<String, dynamic> json) = _$RatingImpl.fromJson;

  @override
  @JsonKey(name: "like")
  int get like;
  @override
  @JsonKey(name: "bookmark")
  int get bookmark;
  @override
  @JsonKey(name: "view")
  int get view;
  @override
  @JsonKey(ignore: true)
  _$$RatingImplCopyWith<_$RatingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SeriesNavigation _$SeriesNavigationFromJson(Map<String, dynamic> json) {
  return _SeriesNavigation.fromJson(json);
}

/// @nodoc
mixin _$SeriesNavigation {
  @JsonKey(name: "nextNovel")
  PrevNovel? get nextNovel => throw _privateConstructorUsedError;
  @JsonKey(name: "prevNovel")
  PrevNovel? get prevNovel => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SeriesNavigationCopyWith<SeriesNavigation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeriesNavigationCopyWith<$Res> {
  factory $SeriesNavigationCopyWith(
          SeriesNavigation value, $Res Function(SeriesNavigation) then) =
      _$SeriesNavigationCopyWithImpl<$Res, SeriesNavigation>;
  @useResult
  $Res call(
      {@JsonKey(name: "nextNovel") PrevNovel? nextNovel,
      @JsonKey(name: "prevNovel") PrevNovel? prevNovel});

  $PrevNovelCopyWith<$Res>? get nextNovel;
  $PrevNovelCopyWith<$Res>? get prevNovel;
}

/// @nodoc
class _$SeriesNavigationCopyWithImpl<$Res, $Val extends SeriesNavigation>
    implements $SeriesNavigationCopyWith<$Res> {
  _$SeriesNavigationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nextNovel = freezed,
    Object? prevNovel = freezed,
  }) {
    return _then(_value.copyWith(
      nextNovel: freezed == nextNovel
          ? _value.nextNovel
          : nextNovel // ignore: cast_nullable_to_non_nullable
              as PrevNovel?,
      prevNovel: freezed == prevNovel
          ? _value.prevNovel
          : prevNovel // ignore: cast_nullable_to_non_nullable
              as PrevNovel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PrevNovelCopyWith<$Res>? get nextNovel {
    if (_value.nextNovel == null) {
      return null;
    }

    return $PrevNovelCopyWith<$Res>(_value.nextNovel!, (value) {
      return _then(_value.copyWith(nextNovel: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PrevNovelCopyWith<$Res>? get prevNovel {
    if (_value.prevNovel == null) {
      return null;
    }

    return $PrevNovelCopyWith<$Res>(_value.prevNovel!, (value) {
      return _then(_value.copyWith(prevNovel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SeriesNavigationImplCopyWith<$Res>
    implements $SeriesNavigationCopyWith<$Res> {
  factory _$$SeriesNavigationImplCopyWith(_$SeriesNavigationImpl value,
          $Res Function(_$SeriesNavigationImpl) then) =
      __$$SeriesNavigationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "nextNovel") PrevNovel? nextNovel,
      @JsonKey(name: "prevNovel") PrevNovel? prevNovel});

  @override
  $PrevNovelCopyWith<$Res>? get nextNovel;
  @override
  $PrevNovelCopyWith<$Res>? get prevNovel;
}

/// @nodoc
class __$$SeriesNavigationImplCopyWithImpl<$Res>
    extends _$SeriesNavigationCopyWithImpl<$Res, _$SeriesNavigationImpl>
    implements _$$SeriesNavigationImplCopyWith<$Res> {
  __$$SeriesNavigationImplCopyWithImpl(_$SeriesNavigationImpl _value,
      $Res Function(_$SeriesNavigationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nextNovel = freezed,
    Object? prevNovel = freezed,
  }) {
    return _then(_$SeriesNavigationImpl(
      nextNovel: freezed == nextNovel
          ? _value.nextNovel
          : nextNovel // ignore: cast_nullable_to_non_nullable
              as PrevNovel?,
      prevNovel: freezed == prevNovel
          ? _value.prevNovel
          : prevNovel // ignore: cast_nullable_to_non_nullable
              as PrevNovel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SeriesNavigationImpl implements _SeriesNavigation {
  const _$SeriesNavigationImpl(
      {@JsonKey(name: "nextNovel") this.nextNovel,
      @JsonKey(name: "prevNovel") this.prevNovel});

  factory _$SeriesNavigationImpl.fromJson(Map<String, dynamic> json) =>
      _$$SeriesNavigationImplFromJson(json);

  @override
  @JsonKey(name: "nextNovel")
  final PrevNovel? nextNovel;
  @override
  @JsonKey(name: "prevNovel")
  final PrevNovel? prevNovel;

  @override
  String toString() {
    return 'SeriesNavigation(nextNovel: $nextNovel, prevNovel: $prevNovel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeriesNavigationImpl &&
            (identical(other.nextNovel, nextNovel) ||
                other.nextNovel == nextNovel) &&
            (identical(other.prevNovel, prevNovel) ||
                other.prevNovel == prevNovel));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, nextNovel, prevNovel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SeriesNavigationImplCopyWith<_$SeriesNavigationImpl> get copyWith =>
      __$$SeriesNavigationImplCopyWithImpl<_$SeriesNavigationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SeriesNavigationImplToJson(
      this,
    );
  }
}

abstract class _SeriesNavigation implements SeriesNavigation {
  const factory _SeriesNavigation(
          {@JsonKey(name: "nextNovel") final PrevNovel? nextNovel,
          @JsonKey(name: "prevNovel") final PrevNovel? prevNovel}) =
      _$SeriesNavigationImpl;

  factory _SeriesNavigation.fromJson(Map<String, dynamic> json) =
      _$SeriesNavigationImpl.fromJson;

  @override
  @JsonKey(name: "nextNovel")
  PrevNovel? get nextNovel;
  @override
  @JsonKey(name: "prevNovel")
  PrevNovel? get prevNovel;
  @override
  @JsonKey(ignore: true)
  _$$SeriesNavigationImplCopyWith<_$SeriesNavigationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PrevNovel _$PrevNovelFromJson(Map<String, dynamic> json) {
  return _PrevNovel.fromJson(json);
}

/// @nodoc
mixin _$PrevNovel {
  @JsonKey(name: "id")
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: "viewable")
  bool get viewable => throw _privateConstructorUsedError;
  @JsonKey(name: "contentOrder")
  String get contentOrder => throw _privateConstructorUsedError;
  @JsonKey(name: "title")
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: "coverUrl")
  String get coverUrl => throw _privateConstructorUsedError;
  @JsonKey(name: "viewableMessage")
  dynamic get viewableMessage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PrevNovelCopyWith<PrevNovel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrevNovelCopyWith<$Res> {
  factory $PrevNovelCopyWith(PrevNovel value, $Res Function(PrevNovel) then) =
      _$PrevNovelCopyWithImpl<$Res, PrevNovel>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int id,
      @JsonKey(name: "viewable") bool viewable,
      @JsonKey(name: "contentOrder") String contentOrder,
      @JsonKey(name: "title") String title,
      @JsonKey(name: "coverUrl") String coverUrl,
      @JsonKey(name: "viewableMessage") dynamic viewableMessage});
}

/// @nodoc
class _$PrevNovelCopyWithImpl<$Res, $Val extends PrevNovel>
    implements $PrevNovelCopyWith<$Res> {
  _$PrevNovelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? viewable = null,
    Object? contentOrder = null,
    Object? title = null,
    Object? coverUrl = null,
    Object? viewableMessage = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      viewable: null == viewable
          ? _value.viewable
          : viewable // ignore: cast_nullable_to_non_nullable
              as bool,
      contentOrder: null == contentOrder
          ? _value.contentOrder
          : contentOrder // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      coverUrl: null == coverUrl
          ? _value.coverUrl
          : coverUrl // ignore: cast_nullable_to_non_nullable
              as String,
      viewableMessage: freezed == viewableMessage
          ? _value.viewableMessage
          : viewableMessage // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PrevNovelImplCopyWith<$Res>
    implements $PrevNovelCopyWith<$Res> {
  factory _$$PrevNovelImplCopyWith(
          _$PrevNovelImpl value, $Res Function(_$PrevNovelImpl) then) =
      __$$PrevNovelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int id,
      @JsonKey(name: "viewable") bool viewable,
      @JsonKey(name: "contentOrder") String contentOrder,
      @JsonKey(name: "title") String title,
      @JsonKey(name: "coverUrl") String coverUrl,
      @JsonKey(name: "viewableMessage") dynamic viewableMessage});
}

/// @nodoc
class __$$PrevNovelImplCopyWithImpl<$Res>
    extends _$PrevNovelCopyWithImpl<$Res, _$PrevNovelImpl>
    implements _$$PrevNovelImplCopyWith<$Res> {
  __$$PrevNovelImplCopyWithImpl(
      _$PrevNovelImpl _value, $Res Function(_$PrevNovelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? viewable = null,
    Object? contentOrder = null,
    Object? title = null,
    Object? coverUrl = null,
    Object? viewableMessage = freezed,
  }) {
    return _then(_$PrevNovelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      viewable: null == viewable
          ? _value.viewable
          : viewable // ignore: cast_nullable_to_non_nullable
              as bool,
      contentOrder: null == contentOrder
          ? _value.contentOrder
          : contentOrder // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      coverUrl: null == coverUrl
          ? _value.coverUrl
          : coverUrl // ignore: cast_nullable_to_non_nullable
              as String,
      viewableMessage: freezed == viewableMessage
          ? _value.viewableMessage
          : viewableMessage // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PrevNovelImpl implements _PrevNovel {
  const _$PrevNovelImpl(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "viewable") required this.viewable,
      @JsonKey(name: "contentOrder") required this.contentOrder,
      @JsonKey(name: "title") required this.title,
      @JsonKey(name: "coverUrl") required this.coverUrl,
      @JsonKey(name: "viewableMessage") required this.viewableMessage});

  factory _$PrevNovelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PrevNovelImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final int id;
  @override
  @JsonKey(name: "viewable")
  final bool viewable;
  @override
  @JsonKey(name: "contentOrder")
  final String contentOrder;
  @override
  @JsonKey(name: "title")
  final String title;
  @override
  @JsonKey(name: "coverUrl")
  final String coverUrl;
  @override
  @JsonKey(name: "viewableMessage")
  final dynamic viewableMessage;

  @override
  String toString() {
    return 'PrevNovel(id: $id, viewable: $viewable, contentOrder: $contentOrder, title: $title, coverUrl: $coverUrl, viewableMessage: $viewableMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrevNovelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.viewable, viewable) ||
                other.viewable == viewable) &&
            (identical(other.contentOrder, contentOrder) ||
                other.contentOrder == contentOrder) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.coverUrl, coverUrl) ||
                other.coverUrl == coverUrl) &&
            const DeepCollectionEquality()
                .equals(other.viewableMessage, viewableMessage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, viewable, contentOrder,
      title, coverUrl, const DeepCollectionEquality().hash(viewableMessage));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PrevNovelImplCopyWith<_$PrevNovelImpl> get copyWith =>
      __$$PrevNovelImplCopyWithImpl<_$PrevNovelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PrevNovelImplToJson(
      this,
    );
  }
}

abstract class _PrevNovel implements PrevNovel {
  const factory _PrevNovel(
      {@JsonKey(name: "id") required final int id,
      @JsonKey(name: "viewable") required final bool viewable,
      @JsonKey(name: "contentOrder") required final String contentOrder,
      @JsonKey(name: "title") required final String title,
      @JsonKey(name: "coverUrl") required final String coverUrl,
      @JsonKey(name: "viewableMessage")
      required final dynamic viewableMessage}) = _$PrevNovelImpl;

  factory _PrevNovel.fromJson(Map<String, dynamic> json) =
      _$PrevNovelImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int get id;
  @override
  @JsonKey(name: "viewable")
  bool get viewable;
  @override
  @JsonKey(name: "contentOrder")
  String get contentOrder;
  @override
  @JsonKey(name: "title")
  String get title;
  @override
  @JsonKey(name: "coverUrl")
  String get coverUrl;
  @override
  @JsonKey(name: "viewableMessage")
  dynamic get viewableMessage;
  @override
  @JsonKey(ignore: true)
  _$$PrevNovelImplCopyWith<_$PrevNovelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
