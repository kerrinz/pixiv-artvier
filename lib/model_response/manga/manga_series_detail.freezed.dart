// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manga_series_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MangaSeriesDetailResponse _$MangaSeriesDetailResponseFromJson(
    Map<String, dynamic> json) {
  return _MangaSeriesDetailResponse.fromJson(json);
}

/// @nodoc
mixin _$MangaSeriesDetailResponse {
  @JsonKey(name: "illust_series_detail")
  IllustSeriesDetail get illustSeriesDetail =>
      throw _privateConstructorUsedError;
  @JsonKey(name: "illust_series_first_illust")
  CommonIllust get illustSeriesFirstIllust =>
      throw _privateConstructorUsedError;
  @JsonKey(name: "illusts")
  List<CommonIllust> get illusts => throw _privateConstructorUsedError;
  @JsonKey(name: "next_url")
  String? get nextUrl => throw _privateConstructorUsedError;

  /// Serializes this MangaSeriesDetailResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MangaSeriesDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MangaSeriesDetailResponseCopyWith<MangaSeriesDetailResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MangaSeriesDetailResponseCopyWith<$Res> {
  factory $MangaSeriesDetailResponseCopyWith(MangaSeriesDetailResponse value,
          $Res Function(MangaSeriesDetailResponse) then) =
      _$MangaSeriesDetailResponseCopyWithImpl<$Res, MangaSeriesDetailResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: "illust_series_detail")
      IllustSeriesDetail illustSeriesDetail,
      @JsonKey(name: "illust_series_first_illust")
      CommonIllust illustSeriesFirstIllust,
      @JsonKey(name: "illusts") List<CommonIllust> illusts,
      @JsonKey(name: "next_url") String? nextUrl});

  $IllustSeriesDetailCopyWith<$Res> get illustSeriesDetail;
}

/// @nodoc
class _$MangaSeriesDetailResponseCopyWithImpl<$Res,
        $Val extends MangaSeriesDetailResponse>
    implements $MangaSeriesDetailResponseCopyWith<$Res> {
  _$MangaSeriesDetailResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MangaSeriesDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? illustSeriesDetail = null,
    Object? illustSeriesFirstIllust = null,
    Object? illusts = null,
    Object? nextUrl = freezed,
  }) {
    return _then(_value.copyWith(
      illustSeriesDetail: null == illustSeriesDetail
          ? _value.illustSeriesDetail
          : illustSeriesDetail // ignore: cast_nullable_to_non_nullable
              as IllustSeriesDetail,
      illustSeriesFirstIllust: null == illustSeriesFirstIllust
          ? _value.illustSeriesFirstIllust
          : illustSeriesFirstIllust // ignore: cast_nullable_to_non_nullable
              as CommonIllust,
      illusts: null == illusts
          ? _value.illusts
          : illusts // ignore: cast_nullable_to_non_nullable
              as List<CommonIllust>,
      nextUrl: freezed == nextUrl
          ? _value.nextUrl
          : nextUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of MangaSeriesDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IllustSeriesDetailCopyWith<$Res> get illustSeriesDetail {
    return $IllustSeriesDetailCopyWith<$Res>(_value.illustSeriesDetail,
        (value) {
      return _then(_value.copyWith(illustSeriesDetail: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MangaSeriesDetailResponseImplCopyWith<$Res>
    implements $MangaSeriesDetailResponseCopyWith<$Res> {
  factory _$$MangaSeriesDetailResponseImplCopyWith(
          _$MangaSeriesDetailResponseImpl value,
          $Res Function(_$MangaSeriesDetailResponseImpl) then) =
      __$$MangaSeriesDetailResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "illust_series_detail")
      IllustSeriesDetail illustSeriesDetail,
      @JsonKey(name: "illust_series_first_illust")
      CommonIllust illustSeriesFirstIllust,
      @JsonKey(name: "illusts") List<CommonIllust> illusts,
      @JsonKey(name: "next_url") String? nextUrl});

  @override
  $IllustSeriesDetailCopyWith<$Res> get illustSeriesDetail;
}

/// @nodoc
class __$$MangaSeriesDetailResponseImplCopyWithImpl<$Res>
    extends _$MangaSeriesDetailResponseCopyWithImpl<$Res,
        _$MangaSeriesDetailResponseImpl>
    implements _$$MangaSeriesDetailResponseImplCopyWith<$Res> {
  __$$MangaSeriesDetailResponseImplCopyWithImpl(
      _$MangaSeriesDetailResponseImpl _value,
      $Res Function(_$MangaSeriesDetailResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of MangaSeriesDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? illustSeriesDetail = null,
    Object? illustSeriesFirstIllust = null,
    Object? illusts = null,
    Object? nextUrl = freezed,
  }) {
    return _then(_$MangaSeriesDetailResponseImpl(
      illustSeriesDetail: null == illustSeriesDetail
          ? _value.illustSeriesDetail
          : illustSeriesDetail // ignore: cast_nullable_to_non_nullable
              as IllustSeriesDetail,
      illustSeriesFirstIllust: null == illustSeriesFirstIllust
          ? _value.illustSeriesFirstIllust
          : illustSeriesFirstIllust // ignore: cast_nullable_to_non_nullable
              as CommonIllust,
      illusts: null == illusts
          ? _value._illusts
          : illusts // ignore: cast_nullable_to_non_nullable
              as List<CommonIllust>,
      nextUrl: freezed == nextUrl
          ? _value.nextUrl
          : nextUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MangaSeriesDetailResponseImpl implements _MangaSeriesDetailResponse {
  const _$MangaSeriesDetailResponseImpl(
      {@JsonKey(name: "illust_series_detail") required this.illustSeriesDetail,
      @JsonKey(name: "illust_series_first_illust")
      required this.illustSeriesFirstIllust,
      @JsonKey(name: "illusts") required final List<CommonIllust> illusts,
      @JsonKey(name: "next_url") this.nextUrl})
      : _illusts = illusts;

  factory _$MangaSeriesDetailResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MangaSeriesDetailResponseImplFromJson(json);

  @override
  @JsonKey(name: "illust_series_detail")
  final IllustSeriesDetail illustSeriesDetail;
  @override
  @JsonKey(name: "illust_series_first_illust")
  final CommonIllust illustSeriesFirstIllust;
  final List<CommonIllust> _illusts;
  @override
  @JsonKey(name: "illusts")
  List<CommonIllust> get illusts {
    if (_illusts is EqualUnmodifiableListView) return _illusts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_illusts);
  }

  @override
  @JsonKey(name: "next_url")
  final String? nextUrl;

  @override
  String toString() {
    return 'MangaSeriesDetailResponse(illustSeriesDetail: $illustSeriesDetail, illustSeriesFirstIllust: $illustSeriesFirstIllust, illusts: $illusts, nextUrl: $nextUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MangaSeriesDetailResponseImpl &&
            (identical(other.illustSeriesDetail, illustSeriesDetail) ||
                other.illustSeriesDetail == illustSeriesDetail) &&
            (identical(
                    other.illustSeriesFirstIllust, illustSeriesFirstIllust) ||
                other.illustSeriesFirstIllust == illustSeriesFirstIllust) &&
            const DeepCollectionEquality().equals(other._illusts, _illusts) &&
            (identical(other.nextUrl, nextUrl) || other.nextUrl == nextUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      illustSeriesDetail,
      illustSeriesFirstIllust,
      const DeepCollectionEquality().hash(_illusts),
      nextUrl);

  /// Create a copy of MangaSeriesDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MangaSeriesDetailResponseImplCopyWith<_$MangaSeriesDetailResponseImpl>
      get copyWith => __$$MangaSeriesDetailResponseImplCopyWithImpl<
          _$MangaSeriesDetailResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MangaSeriesDetailResponseImplToJson(
      this,
    );
  }
}

abstract class _MangaSeriesDetailResponse implements MangaSeriesDetailResponse {
  const factory _MangaSeriesDetailResponse(
          {@JsonKey(name: "illust_series_detail")
          required final IllustSeriesDetail illustSeriesDetail,
          @JsonKey(name: "illust_series_first_illust")
          required final CommonIllust illustSeriesFirstIllust,
          @JsonKey(name: "illusts") required final List<CommonIllust> illusts,
          @JsonKey(name: "next_url") final String? nextUrl}) =
      _$MangaSeriesDetailResponseImpl;

  factory _MangaSeriesDetailResponse.fromJson(Map<String, dynamic> json) =
      _$MangaSeriesDetailResponseImpl.fromJson;

  @override
  @JsonKey(name: "illust_series_detail")
  IllustSeriesDetail get illustSeriesDetail;
  @override
  @JsonKey(name: "illust_series_first_illust")
  CommonIllust get illustSeriesFirstIllust;
  @override
  @JsonKey(name: "illusts")
  List<CommonIllust> get illusts;
  @override
  @JsonKey(name: "next_url")
  String? get nextUrl;

  /// Create a copy of MangaSeriesDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MangaSeriesDetailResponseImplCopyWith<_$MangaSeriesDetailResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

IllustSeriesDetail _$IllustSeriesDetailFromJson(Map<String, dynamic> json) {
  return _IllustSeriesDetail.fromJson(json);
}

/// @nodoc
mixin _$IllustSeriesDetail {
  @JsonKey(name: "id")
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: "title")
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: "caption")
  String get caption => throw _privateConstructorUsedError;
  @JsonKey(name: "cover_image_urls")
  ImageUrls get coverImageUrls => throw _privateConstructorUsedError;
  @JsonKey(name: "series_work_count")
  int get seriesWorkCount => throw _privateConstructorUsedError;
  @JsonKey(name: "create_date")
  DateTime get createDate => throw _privateConstructorUsedError;
  @JsonKey(name: "width")
  int get width => throw _privateConstructorUsedError;
  @JsonKey(name: "height")
  int get height => throw _privateConstructorUsedError;
  @JsonKey(name: "user")
  CommonUser get user => throw _privateConstructorUsedError;
  @JsonKey(name: "watchlist_added")
  bool get watchlistAdded => throw _privateConstructorUsedError;

  /// Serializes this IllustSeriesDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IllustSeriesDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IllustSeriesDetailCopyWith<IllustSeriesDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IllustSeriesDetailCopyWith<$Res> {
  factory $IllustSeriesDetailCopyWith(
          IllustSeriesDetail value, $Res Function(IllustSeriesDetail) then) =
      _$IllustSeriesDetailCopyWithImpl<$Res, IllustSeriesDetail>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int id,
      @JsonKey(name: "title") String title,
      @JsonKey(name: "caption") String caption,
      @JsonKey(name: "cover_image_urls") ImageUrls coverImageUrls,
      @JsonKey(name: "series_work_count") int seriesWorkCount,
      @JsonKey(name: "create_date") DateTime createDate,
      @JsonKey(name: "width") int width,
      @JsonKey(name: "height") int height,
      @JsonKey(name: "user") CommonUser user,
      @JsonKey(name: "watchlist_added") bool watchlistAdded});

  $ImageUrlsCopyWith<$Res> get coverImageUrls;
  $CommonUserCopyWith<$Res> get user;
}

/// @nodoc
class _$IllustSeriesDetailCopyWithImpl<$Res, $Val extends IllustSeriesDetail>
    implements $IllustSeriesDetailCopyWith<$Res> {
  _$IllustSeriesDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IllustSeriesDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? caption = null,
    Object? coverImageUrls = null,
    Object? seriesWorkCount = null,
    Object? createDate = null,
    Object? width = null,
    Object? height = null,
    Object? user = null,
    Object? watchlistAdded = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      caption: null == caption
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String,
      coverImageUrls: null == coverImageUrls
          ? _value.coverImageUrls
          : coverImageUrls // ignore: cast_nullable_to_non_nullable
              as ImageUrls,
      seriesWorkCount: null == seriesWorkCount
          ? _value.seriesWorkCount
          : seriesWorkCount // ignore: cast_nullable_to_non_nullable
              as int,
      createDate: null == createDate
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as CommonUser,
      watchlistAdded: null == watchlistAdded
          ? _value.watchlistAdded
          : watchlistAdded // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of IllustSeriesDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ImageUrlsCopyWith<$Res> get coverImageUrls {
    return $ImageUrlsCopyWith<$Res>(_value.coverImageUrls, (value) {
      return _then(_value.copyWith(coverImageUrls: value) as $Val);
    });
  }

  /// Create a copy of IllustSeriesDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CommonUserCopyWith<$Res> get user {
    return $CommonUserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$IllustSeriesDetailImplCopyWith<$Res>
    implements $IllustSeriesDetailCopyWith<$Res> {
  factory _$$IllustSeriesDetailImplCopyWith(_$IllustSeriesDetailImpl value,
          $Res Function(_$IllustSeriesDetailImpl) then) =
      __$$IllustSeriesDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int id,
      @JsonKey(name: "title") String title,
      @JsonKey(name: "caption") String caption,
      @JsonKey(name: "cover_image_urls") ImageUrls coverImageUrls,
      @JsonKey(name: "series_work_count") int seriesWorkCount,
      @JsonKey(name: "create_date") DateTime createDate,
      @JsonKey(name: "width") int width,
      @JsonKey(name: "height") int height,
      @JsonKey(name: "user") CommonUser user,
      @JsonKey(name: "watchlist_added") bool watchlistAdded});

  @override
  $ImageUrlsCopyWith<$Res> get coverImageUrls;
  @override
  $CommonUserCopyWith<$Res> get user;
}

/// @nodoc
class __$$IllustSeriesDetailImplCopyWithImpl<$Res>
    extends _$IllustSeriesDetailCopyWithImpl<$Res, _$IllustSeriesDetailImpl>
    implements _$$IllustSeriesDetailImplCopyWith<$Res> {
  __$$IllustSeriesDetailImplCopyWithImpl(_$IllustSeriesDetailImpl _value,
      $Res Function(_$IllustSeriesDetailImpl) _then)
      : super(_value, _then);

  /// Create a copy of IllustSeriesDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? caption = null,
    Object? coverImageUrls = null,
    Object? seriesWorkCount = null,
    Object? createDate = null,
    Object? width = null,
    Object? height = null,
    Object? user = null,
    Object? watchlistAdded = null,
  }) {
    return _then(_$IllustSeriesDetailImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      caption: null == caption
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String,
      coverImageUrls: null == coverImageUrls
          ? _value.coverImageUrls
          : coverImageUrls // ignore: cast_nullable_to_non_nullable
              as ImageUrls,
      seriesWorkCount: null == seriesWorkCount
          ? _value.seriesWorkCount
          : seriesWorkCount // ignore: cast_nullable_to_non_nullable
              as int,
      createDate: null == createDate
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as CommonUser,
      watchlistAdded: null == watchlistAdded
          ? _value.watchlistAdded
          : watchlistAdded // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IllustSeriesDetailImpl implements _IllustSeriesDetail {
  const _$IllustSeriesDetailImpl(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "title") required this.title,
      @JsonKey(name: "caption") required this.caption,
      @JsonKey(name: "cover_image_urls") required this.coverImageUrls,
      @JsonKey(name: "series_work_count") required this.seriesWorkCount,
      @JsonKey(name: "create_date") required this.createDate,
      @JsonKey(name: "width") required this.width,
      @JsonKey(name: "height") required this.height,
      @JsonKey(name: "user") required this.user,
      @JsonKey(name: "watchlist_added") required this.watchlistAdded});

  factory _$IllustSeriesDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$IllustSeriesDetailImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final int id;
  @override
  @JsonKey(name: "title")
  final String title;
  @override
  @JsonKey(name: "caption")
  final String caption;
  @override
  @JsonKey(name: "cover_image_urls")
  final ImageUrls coverImageUrls;
  @override
  @JsonKey(name: "series_work_count")
  final int seriesWorkCount;
  @override
  @JsonKey(name: "create_date")
  final DateTime createDate;
  @override
  @JsonKey(name: "width")
  final int width;
  @override
  @JsonKey(name: "height")
  final int height;
  @override
  @JsonKey(name: "user")
  final CommonUser user;
  @override
  @JsonKey(name: "watchlist_added")
  final bool watchlistAdded;

  @override
  String toString() {
    return 'IllustSeriesDetail(id: $id, title: $title, caption: $caption, coverImageUrls: $coverImageUrls, seriesWorkCount: $seriesWorkCount, createDate: $createDate, width: $width, height: $height, user: $user, watchlistAdded: $watchlistAdded)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IllustSeriesDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.coverImageUrls, coverImageUrls) ||
                other.coverImageUrls == coverImageUrls) &&
            (identical(other.seriesWorkCount, seriesWorkCount) ||
                other.seriesWorkCount == seriesWorkCount) &&
            (identical(other.createDate, createDate) ||
                other.createDate == createDate) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.watchlistAdded, watchlistAdded) ||
                other.watchlistAdded == watchlistAdded));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      caption,
      coverImageUrls,
      seriesWorkCount,
      createDate,
      width,
      height,
      user,
      watchlistAdded);

  /// Create a copy of IllustSeriesDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IllustSeriesDetailImplCopyWith<_$IllustSeriesDetailImpl> get copyWith =>
      __$$IllustSeriesDetailImplCopyWithImpl<_$IllustSeriesDetailImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IllustSeriesDetailImplToJson(
      this,
    );
  }
}

abstract class _IllustSeriesDetail implements IllustSeriesDetail {
  const factory _IllustSeriesDetail(
      {@JsonKey(name: "id") required final int id,
      @JsonKey(name: "title") required final String title,
      @JsonKey(name: "caption") required final String caption,
      @JsonKey(name: "cover_image_urls")
      required final ImageUrls coverImageUrls,
      @JsonKey(name: "series_work_count") required final int seriesWorkCount,
      @JsonKey(name: "create_date") required final DateTime createDate,
      @JsonKey(name: "width") required final int width,
      @JsonKey(name: "height") required final int height,
      @JsonKey(name: "user") required final CommonUser user,
      @JsonKey(name: "watchlist_added")
      required final bool watchlistAdded}) = _$IllustSeriesDetailImpl;

  factory _IllustSeriesDetail.fromJson(Map<String, dynamic> json) =
      _$IllustSeriesDetailImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int get id;
  @override
  @JsonKey(name: "title")
  String get title;
  @override
  @JsonKey(name: "caption")
  String get caption;
  @override
  @JsonKey(name: "cover_image_urls")
  ImageUrls get coverImageUrls;
  @override
  @JsonKey(name: "series_work_count")
  int get seriesWorkCount;
  @override
  @JsonKey(name: "create_date")
  DateTime get createDate;
  @override
  @JsonKey(name: "width")
  int get width;
  @override
  @JsonKey(name: "height")
  int get height;
  @override
  @JsonKey(name: "user")
  CommonUser get user;
  @override
  @JsonKey(name: "watchlist_added")
  bool get watchlistAdded;

  /// Create a copy of IllustSeriesDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IllustSeriesDetailImplCopyWith<_$IllustSeriesDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ImageUrls _$ImageUrlsFromJson(Map<String, dynamic> json) {
  return _ImageUrls.fromJson(json);
}

/// @nodoc
mixin _$ImageUrls {
  @JsonKey(name: "medium")
  String get medium => throw _privateConstructorUsedError;

  /// Serializes this ImageUrls to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ImageUrls
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ImageUrlsCopyWith<ImageUrls> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageUrlsCopyWith<$Res> {
  factory $ImageUrlsCopyWith(ImageUrls value, $Res Function(ImageUrls) then) =
      _$ImageUrlsCopyWithImpl<$Res, ImageUrls>;
  @useResult
  $Res call({@JsonKey(name: "medium") String medium});
}

/// @nodoc
class _$ImageUrlsCopyWithImpl<$Res, $Val extends ImageUrls>
    implements $ImageUrlsCopyWith<$Res> {
  _$ImageUrlsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ImageUrls
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? medium = null,
  }) {
    return _then(_value.copyWith(
      medium: null == medium
          ? _value.medium
          : medium // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ImageUrlsImplCopyWith<$Res>
    implements $ImageUrlsCopyWith<$Res> {
  factory _$$ImageUrlsImplCopyWith(
          _$ImageUrlsImpl value, $Res Function(_$ImageUrlsImpl) then) =
      __$$ImageUrlsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: "medium") String medium});
}

/// @nodoc
class __$$ImageUrlsImplCopyWithImpl<$Res>
    extends _$ImageUrlsCopyWithImpl<$Res, _$ImageUrlsImpl>
    implements _$$ImageUrlsImplCopyWith<$Res> {
  __$$ImageUrlsImplCopyWithImpl(
      _$ImageUrlsImpl _value, $Res Function(_$ImageUrlsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ImageUrls
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? medium = null,
  }) {
    return _then(_$ImageUrlsImpl(
      medium: null == medium
          ? _value.medium
          : medium // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImageUrlsImpl implements _ImageUrls {
  const _$ImageUrlsImpl({@JsonKey(name: "medium") required this.medium});

  factory _$ImageUrlsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageUrlsImplFromJson(json);

  @override
  @JsonKey(name: "medium")
  final String medium;

  @override
  String toString() {
    return 'ImageUrls(medium: $medium)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageUrlsImpl &&
            (identical(other.medium, medium) || other.medium == medium));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, medium);

  /// Create a copy of ImageUrls
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageUrlsImplCopyWith<_$ImageUrlsImpl> get copyWith =>
      __$$ImageUrlsImplCopyWithImpl<_$ImageUrlsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageUrlsImplToJson(
      this,
    );
  }
}

abstract class _ImageUrls implements ImageUrls {
  const factory _ImageUrls(
          {@JsonKey(name: "medium") required final String medium}) =
      _$ImageUrlsImpl;

  factory _ImageUrls.fromJson(Map<String, dynamic> json) =
      _$ImageUrlsImpl.fromJson;

  @override
  @JsonKey(name: "medium")
  String get medium;

  /// Create a copy of ImageUrls
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImageUrlsImplCopyWith<_$ImageUrlsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
