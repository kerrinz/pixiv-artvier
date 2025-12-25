// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'novel_series_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NovelSeriesDetailResponse _$NovelSeriesDetailResponseFromJson(
    Map<String, dynamic> json) {
  return _NovelSeriesDetailResponse.fromJson(json);
}

/// @nodoc
mixin _$NovelSeriesDetailResponse {
  @JsonKey(name: "novel_series_detail")
  NovelSeriesDetail get novelSeriesDetail => throw _privateConstructorUsedError;
  @JsonKey(name: "novel_series_first_novel")
  CommonNovel get novelSeriesFirstNovel => throw _privateConstructorUsedError;
  @JsonKey(name: "novel_series_latest_novel")
  CommonNovel get novelSeriesLatestNovel => throw _privateConstructorUsedError;
  @JsonKey(name: "novels")
  List<CommonNovel> get novels => throw _privateConstructorUsedError;
  @JsonKey(name: "next_url")
  String? get nextUrl => throw _privateConstructorUsedError;

  /// Serializes this NovelSeriesDetailResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NovelSeriesDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NovelSeriesDetailResponseCopyWith<NovelSeriesDetailResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NovelSeriesDetailResponseCopyWith<$Res> {
  factory $NovelSeriesDetailResponseCopyWith(NovelSeriesDetailResponse value,
          $Res Function(NovelSeriesDetailResponse) then) =
      _$NovelSeriesDetailResponseCopyWithImpl<$Res, NovelSeriesDetailResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: "novel_series_detail")
      NovelSeriesDetail novelSeriesDetail,
      @JsonKey(name: "novel_series_first_novel")
      CommonNovel novelSeriesFirstNovel,
      @JsonKey(name: "novel_series_latest_novel")
      CommonNovel novelSeriesLatestNovel,
      @JsonKey(name: "novels") List<CommonNovel> novels,
      @JsonKey(name: "next_url") String? nextUrl});

  $NovelSeriesDetailCopyWith<$Res> get novelSeriesDetail;
}

/// @nodoc
class _$NovelSeriesDetailResponseCopyWithImpl<$Res,
        $Val extends NovelSeriesDetailResponse>
    implements $NovelSeriesDetailResponseCopyWith<$Res> {
  _$NovelSeriesDetailResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NovelSeriesDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? novelSeriesDetail = null,
    Object? novelSeriesFirstNovel = null,
    Object? novelSeriesLatestNovel = null,
    Object? novels = null,
    Object? nextUrl = freezed,
  }) {
    return _then(_value.copyWith(
      novelSeriesDetail: null == novelSeriesDetail
          ? _value.novelSeriesDetail
          : novelSeriesDetail // ignore: cast_nullable_to_non_nullable
              as NovelSeriesDetail,
      novelSeriesFirstNovel: null == novelSeriesFirstNovel
          ? _value.novelSeriesFirstNovel
          : novelSeriesFirstNovel // ignore: cast_nullable_to_non_nullable
              as CommonNovel,
      novelSeriesLatestNovel: null == novelSeriesLatestNovel
          ? _value.novelSeriesLatestNovel
          : novelSeriesLatestNovel // ignore: cast_nullable_to_non_nullable
              as CommonNovel,
      novels: null == novels
          ? _value.novels
          : novels // ignore: cast_nullable_to_non_nullable
              as List<CommonNovel>,
      nextUrl: freezed == nextUrl
          ? _value.nextUrl
          : nextUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of NovelSeriesDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NovelSeriesDetailCopyWith<$Res> get novelSeriesDetail {
    return $NovelSeriesDetailCopyWith<$Res>(_value.novelSeriesDetail, (value) {
      return _then(_value.copyWith(novelSeriesDetail: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NovelSeriesDetailResponseImplCopyWith<$Res>
    implements $NovelSeriesDetailResponseCopyWith<$Res> {
  factory _$$NovelSeriesDetailResponseImplCopyWith(
          _$NovelSeriesDetailResponseImpl value,
          $Res Function(_$NovelSeriesDetailResponseImpl) then) =
      __$$NovelSeriesDetailResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "novel_series_detail")
      NovelSeriesDetail novelSeriesDetail,
      @JsonKey(name: "novel_series_first_novel")
      CommonNovel novelSeriesFirstNovel,
      @JsonKey(name: "novel_series_latest_novel")
      CommonNovel novelSeriesLatestNovel,
      @JsonKey(name: "novels") List<CommonNovel> novels,
      @JsonKey(name: "next_url") String? nextUrl});

  @override
  $NovelSeriesDetailCopyWith<$Res> get novelSeriesDetail;
}

/// @nodoc
class __$$NovelSeriesDetailResponseImplCopyWithImpl<$Res>
    extends _$NovelSeriesDetailResponseCopyWithImpl<$Res,
        _$NovelSeriesDetailResponseImpl>
    implements _$$NovelSeriesDetailResponseImplCopyWith<$Res> {
  __$$NovelSeriesDetailResponseImplCopyWithImpl(
      _$NovelSeriesDetailResponseImpl _value,
      $Res Function(_$NovelSeriesDetailResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of NovelSeriesDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? novelSeriesDetail = null,
    Object? novelSeriesFirstNovel = null,
    Object? novelSeriesLatestNovel = null,
    Object? novels = null,
    Object? nextUrl = freezed,
  }) {
    return _then(_$NovelSeriesDetailResponseImpl(
      novelSeriesDetail: null == novelSeriesDetail
          ? _value.novelSeriesDetail
          : novelSeriesDetail // ignore: cast_nullable_to_non_nullable
              as NovelSeriesDetail,
      novelSeriesFirstNovel: null == novelSeriesFirstNovel
          ? _value.novelSeriesFirstNovel
          : novelSeriesFirstNovel // ignore: cast_nullable_to_non_nullable
              as CommonNovel,
      novelSeriesLatestNovel: null == novelSeriesLatestNovel
          ? _value.novelSeriesLatestNovel
          : novelSeriesLatestNovel // ignore: cast_nullable_to_non_nullable
              as CommonNovel,
      novels: null == novels
          ? _value._novels
          : novels // ignore: cast_nullable_to_non_nullable
              as List<CommonNovel>,
      nextUrl: freezed == nextUrl
          ? _value.nextUrl
          : nextUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NovelSeriesDetailResponseImpl implements _NovelSeriesDetailResponse {
  const _$NovelSeriesDetailResponseImpl(
      {@JsonKey(name: "novel_series_detail") required this.novelSeriesDetail,
      @JsonKey(name: "novel_series_first_novel")
      required this.novelSeriesFirstNovel,
      @JsonKey(name: "novel_series_latest_novel")
      required this.novelSeriesLatestNovel,
      @JsonKey(name: "novels") required final List<CommonNovel> novels,
      @JsonKey(name: "next_url") this.nextUrl})
      : _novels = novels;

  factory _$NovelSeriesDetailResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$NovelSeriesDetailResponseImplFromJson(json);

  @override
  @JsonKey(name: "novel_series_detail")
  final NovelSeriesDetail novelSeriesDetail;
  @override
  @JsonKey(name: "novel_series_first_novel")
  final CommonNovel novelSeriesFirstNovel;
  @override
  @JsonKey(name: "novel_series_latest_novel")
  final CommonNovel novelSeriesLatestNovel;
  final List<CommonNovel> _novels;
  @override
  @JsonKey(name: "novels")
  List<CommonNovel> get novels {
    if (_novels is EqualUnmodifiableListView) return _novels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_novels);
  }

  @override
  @JsonKey(name: "next_url")
  final String? nextUrl;

  @override
  String toString() {
    return 'NovelSeriesDetailResponse(novelSeriesDetail: $novelSeriesDetail, novelSeriesFirstNovel: $novelSeriesFirstNovel, novelSeriesLatestNovel: $novelSeriesLatestNovel, novels: $novels, nextUrl: $nextUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NovelSeriesDetailResponseImpl &&
            (identical(other.novelSeriesDetail, novelSeriesDetail) ||
                other.novelSeriesDetail == novelSeriesDetail) &&
            (identical(other.novelSeriesFirstNovel, novelSeriesFirstNovel) ||
                other.novelSeriesFirstNovel == novelSeriesFirstNovel) &&
            (identical(other.novelSeriesLatestNovel, novelSeriesLatestNovel) ||
                other.novelSeriesLatestNovel == novelSeriesLatestNovel) &&
            const DeepCollectionEquality().equals(other._novels, _novels) &&
            (identical(other.nextUrl, nextUrl) || other.nextUrl == nextUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      novelSeriesDetail,
      novelSeriesFirstNovel,
      novelSeriesLatestNovel,
      const DeepCollectionEquality().hash(_novels),
      nextUrl);

  /// Create a copy of NovelSeriesDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NovelSeriesDetailResponseImplCopyWith<_$NovelSeriesDetailResponseImpl>
      get copyWith => __$$NovelSeriesDetailResponseImplCopyWithImpl<
          _$NovelSeriesDetailResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NovelSeriesDetailResponseImplToJson(
      this,
    );
  }
}

abstract class _NovelSeriesDetailResponse implements NovelSeriesDetailResponse {
  const factory _NovelSeriesDetailResponse(
          {@JsonKey(name: "novel_series_detail")
          required final NovelSeriesDetail novelSeriesDetail,
          @JsonKey(name: "novel_series_first_novel")
          required final CommonNovel novelSeriesFirstNovel,
          @JsonKey(name: "novel_series_latest_novel")
          required final CommonNovel novelSeriesLatestNovel,
          @JsonKey(name: "novels") required final List<CommonNovel> novels,
          @JsonKey(name: "next_url") final String? nextUrl}) =
      _$NovelSeriesDetailResponseImpl;

  factory _NovelSeriesDetailResponse.fromJson(Map<String, dynamic> json) =
      _$NovelSeriesDetailResponseImpl.fromJson;

  @override
  @JsonKey(name: "novel_series_detail")
  NovelSeriesDetail get novelSeriesDetail;
  @override
  @JsonKey(name: "novel_series_first_novel")
  CommonNovel get novelSeriesFirstNovel;
  @override
  @JsonKey(name: "novel_series_latest_novel")
  CommonNovel get novelSeriesLatestNovel;
  @override
  @JsonKey(name: "novels")
  List<CommonNovel> get novels;
  @override
  @JsonKey(name: "next_url")
  String? get nextUrl;

  /// Create a copy of NovelSeriesDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NovelSeriesDetailResponseImplCopyWith<_$NovelSeriesDetailResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

NovelSeriesDetail _$NovelSeriesDetailFromJson(Map<String, dynamic> json) {
  return _NovelSeriesDetail.fromJson(json);
}

/// @nodoc
mixin _$NovelSeriesDetail {
  @JsonKey(name: "id")
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: "title")
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: "caption")
  String get caption => throw _privateConstructorUsedError;
  @JsonKey(name: "is_original")
  bool get isOriginal => throw _privateConstructorUsedError;
  @JsonKey(name: "is_concluded")
  bool get isConcluded => throw _privateConstructorUsedError;
  @JsonKey(name: "content_count")
  int get contentCount => throw _privateConstructorUsedError;
  @JsonKey(name: "total_character_count")
  int get totalCharacterCount => throw _privateConstructorUsedError;
  @JsonKey(name: "user")
  CommonUser get user => throw _privateConstructorUsedError;
  @JsonKey(name: "display_text")
  String get displayText => throw _privateConstructorUsedError;
  @JsonKey(name: "novel_ai_type")
  int get novelAiType => throw _privateConstructorUsedError;
  @JsonKey(name: "watchlist_added")
  bool get watchlistAdded => throw _privateConstructorUsedError;
  SeriesState? get seriesWatchState => throw _privateConstructorUsedError;

  /// Serializes this NovelSeriesDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NovelSeriesDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NovelSeriesDetailCopyWith<NovelSeriesDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NovelSeriesDetailCopyWith<$Res> {
  factory $NovelSeriesDetailCopyWith(
          NovelSeriesDetail value, $Res Function(NovelSeriesDetail) then) =
      _$NovelSeriesDetailCopyWithImpl<$Res, NovelSeriesDetail>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int id,
      @JsonKey(name: "title") String title,
      @JsonKey(name: "caption") String caption,
      @JsonKey(name: "is_original") bool isOriginal,
      @JsonKey(name: "is_concluded") bool isConcluded,
      @JsonKey(name: "content_count") int contentCount,
      @JsonKey(name: "total_character_count") int totalCharacterCount,
      @JsonKey(name: "user") CommonUser user,
      @JsonKey(name: "display_text") String displayText,
      @JsonKey(name: "novel_ai_type") int novelAiType,
      @JsonKey(name: "watchlist_added") bool watchlistAdded,
      SeriesState? seriesWatchState});

  $CommonUserCopyWith<$Res> get user;
}

/// @nodoc
class _$NovelSeriesDetailCopyWithImpl<$Res, $Val extends NovelSeriesDetail>
    implements $NovelSeriesDetailCopyWith<$Res> {
  _$NovelSeriesDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NovelSeriesDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? caption = null,
    Object? isOriginal = null,
    Object? isConcluded = null,
    Object? contentCount = null,
    Object? totalCharacterCount = null,
    Object? user = null,
    Object? displayText = null,
    Object? novelAiType = null,
    Object? watchlistAdded = null,
    Object? seriesWatchState = freezed,
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
      isOriginal: null == isOriginal
          ? _value.isOriginal
          : isOriginal // ignore: cast_nullable_to_non_nullable
              as bool,
      isConcluded: null == isConcluded
          ? _value.isConcluded
          : isConcluded // ignore: cast_nullable_to_non_nullable
              as bool,
      contentCount: null == contentCount
          ? _value.contentCount
          : contentCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalCharacterCount: null == totalCharacterCount
          ? _value.totalCharacterCount
          : totalCharacterCount // ignore: cast_nullable_to_non_nullable
              as int,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as CommonUser,
      displayText: null == displayText
          ? _value.displayText
          : displayText // ignore: cast_nullable_to_non_nullable
              as String,
      novelAiType: null == novelAiType
          ? _value.novelAiType
          : novelAiType // ignore: cast_nullable_to_non_nullable
              as int,
      watchlistAdded: null == watchlistAdded
          ? _value.watchlistAdded
          : watchlistAdded // ignore: cast_nullable_to_non_nullable
              as bool,
      seriesWatchState: freezed == seriesWatchState
          ? _value.seriesWatchState
          : seriesWatchState // ignore: cast_nullable_to_non_nullable
              as SeriesState?,
    ) as $Val);
  }

  /// Create a copy of NovelSeriesDetail
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
abstract class _$$NovelSeriesDetailImplCopyWith<$Res>
    implements $NovelSeriesDetailCopyWith<$Res> {
  factory _$$NovelSeriesDetailImplCopyWith(_$NovelSeriesDetailImpl value,
          $Res Function(_$NovelSeriesDetailImpl) then) =
      __$$NovelSeriesDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int id,
      @JsonKey(name: "title") String title,
      @JsonKey(name: "caption") String caption,
      @JsonKey(name: "is_original") bool isOriginal,
      @JsonKey(name: "is_concluded") bool isConcluded,
      @JsonKey(name: "content_count") int contentCount,
      @JsonKey(name: "total_character_count") int totalCharacterCount,
      @JsonKey(name: "user") CommonUser user,
      @JsonKey(name: "display_text") String displayText,
      @JsonKey(name: "novel_ai_type") int novelAiType,
      @JsonKey(name: "watchlist_added") bool watchlistAdded,
      SeriesState? seriesWatchState});

  @override
  $CommonUserCopyWith<$Res> get user;
}

/// @nodoc
class __$$NovelSeriesDetailImplCopyWithImpl<$Res>
    extends _$NovelSeriesDetailCopyWithImpl<$Res, _$NovelSeriesDetailImpl>
    implements _$$NovelSeriesDetailImplCopyWith<$Res> {
  __$$NovelSeriesDetailImplCopyWithImpl(_$NovelSeriesDetailImpl _value,
      $Res Function(_$NovelSeriesDetailImpl) _then)
      : super(_value, _then);

  /// Create a copy of NovelSeriesDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? caption = null,
    Object? isOriginal = null,
    Object? isConcluded = null,
    Object? contentCount = null,
    Object? totalCharacterCount = null,
    Object? user = null,
    Object? displayText = null,
    Object? novelAiType = null,
    Object? watchlistAdded = null,
    Object? seriesWatchState = freezed,
  }) {
    return _then(_$NovelSeriesDetailImpl(
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
      isOriginal: null == isOriginal
          ? _value.isOriginal
          : isOriginal // ignore: cast_nullable_to_non_nullable
              as bool,
      isConcluded: null == isConcluded
          ? _value.isConcluded
          : isConcluded // ignore: cast_nullable_to_non_nullable
              as bool,
      contentCount: null == contentCount
          ? _value.contentCount
          : contentCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalCharacterCount: null == totalCharacterCount
          ? _value.totalCharacterCount
          : totalCharacterCount // ignore: cast_nullable_to_non_nullable
              as int,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as CommonUser,
      displayText: null == displayText
          ? _value.displayText
          : displayText // ignore: cast_nullable_to_non_nullable
              as String,
      novelAiType: null == novelAiType
          ? _value.novelAiType
          : novelAiType // ignore: cast_nullable_to_non_nullable
              as int,
      watchlistAdded: null == watchlistAdded
          ? _value.watchlistAdded
          : watchlistAdded // ignore: cast_nullable_to_non_nullable
              as bool,
      seriesWatchState: freezed == seriesWatchState
          ? _value.seriesWatchState
          : seriesWatchState // ignore: cast_nullable_to_non_nullable
              as SeriesState?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NovelSeriesDetailImpl implements _NovelSeriesDetail {
  const _$NovelSeriesDetailImpl(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "title") required this.title,
      @JsonKey(name: "caption") required this.caption,
      @JsonKey(name: "is_original") required this.isOriginal,
      @JsonKey(name: "is_concluded") required this.isConcluded,
      @JsonKey(name: "content_count") required this.contentCount,
      @JsonKey(name: "total_character_count") required this.totalCharacterCount,
      @JsonKey(name: "user") required this.user,
      @JsonKey(name: "display_text") required this.displayText,
      @JsonKey(name: "novel_ai_type") required this.novelAiType,
      @JsonKey(name: "watchlist_added") required this.watchlistAdded,
      this.seriesWatchState});

  factory _$NovelSeriesDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$NovelSeriesDetailImplFromJson(json);

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
  @JsonKey(name: "is_original")
  final bool isOriginal;
  @override
  @JsonKey(name: "is_concluded")
  final bool isConcluded;
  @override
  @JsonKey(name: "content_count")
  final int contentCount;
  @override
  @JsonKey(name: "total_character_count")
  final int totalCharacterCount;
  @override
  @JsonKey(name: "user")
  final CommonUser user;
  @override
  @JsonKey(name: "display_text")
  final String displayText;
  @override
  @JsonKey(name: "novel_ai_type")
  final int novelAiType;
  @override
  @JsonKey(name: "watchlist_added")
  final bool watchlistAdded;
  @override
  final SeriesState? seriesWatchState;

  @override
  String toString() {
    return 'NovelSeriesDetail(id: $id, title: $title, caption: $caption, isOriginal: $isOriginal, isConcluded: $isConcluded, contentCount: $contentCount, totalCharacterCount: $totalCharacterCount, user: $user, displayText: $displayText, novelAiType: $novelAiType, watchlistAdded: $watchlistAdded, seriesWatchState: $seriesWatchState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NovelSeriesDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.isOriginal, isOriginal) ||
                other.isOriginal == isOriginal) &&
            (identical(other.isConcluded, isConcluded) ||
                other.isConcluded == isConcluded) &&
            (identical(other.contentCount, contentCount) ||
                other.contentCount == contentCount) &&
            (identical(other.totalCharacterCount, totalCharacterCount) ||
                other.totalCharacterCount == totalCharacterCount) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.displayText, displayText) ||
                other.displayText == displayText) &&
            (identical(other.novelAiType, novelAiType) ||
                other.novelAiType == novelAiType) &&
            (identical(other.watchlistAdded, watchlistAdded) ||
                other.watchlistAdded == watchlistAdded) &&
            (identical(other.seriesWatchState, seriesWatchState) ||
                other.seriesWatchState == seriesWatchState));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      caption,
      isOriginal,
      isConcluded,
      contentCount,
      totalCharacterCount,
      user,
      displayText,
      novelAiType,
      watchlistAdded,
      seriesWatchState);

  /// Create a copy of NovelSeriesDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NovelSeriesDetailImplCopyWith<_$NovelSeriesDetailImpl> get copyWith =>
      __$$NovelSeriesDetailImplCopyWithImpl<_$NovelSeriesDetailImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NovelSeriesDetailImplToJson(
      this,
    );
  }
}

abstract class _NovelSeriesDetail implements NovelSeriesDetail {
  const factory _NovelSeriesDetail(
      {@JsonKey(name: "id") required final int id,
      @JsonKey(name: "title") required final String title,
      @JsonKey(name: "caption") required final String caption,
      @JsonKey(name: "is_original") required final bool isOriginal,
      @JsonKey(name: "is_concluded") required final bool isConcluded,
      @JsonKey(name: "content_count") required final int contentCount,
      @JsonKey(name: "total_character_count")
      required final int totalCharacterCount,
      @JsonKey(name: "user") required final CommonUser user,
      @JsonKey(name: "display_text") required final String displayText,
      @JsonKey(name: "novel_ai_type") required final int novelAiType,
      @JsonKey(name: "watchlist_added") required final bool watchlistAdded,
      final SeriesState? seriesWatchState}) = _$NovelSeriesDetailImpl;

  factory _NovelSeriesDetail.fromJson(Map<String, dynamic> json) =
      _$NovelSeriesDetailImpl.fromJson;

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
  @JsonKey(name: "is_original")
  bool get isOriginal;
  @override
  @JsonKey(name: "is_concluded")
  bool get isConcluded;
  @override
  @JsonKey(name: "content_count")
  int get contentCount;
  @override
  @JsonKey(name: "total_character_count")
  int get totalCharacterCount;
  @override
  @JsonKey(name: "user")
  CommonUser get user;
  @override
  @JsonKey(name: "display_text")
  String get displayText;
  @override
  @JsonKey(name: "novel_ai_type")
  int get novelAiType;
  @override
  @JsonKey(name: "watchlist_added")
  bool get watchlistAdded;
  @override
  SeriesState? get seriesWatchState;

  /// Create a copy of NovelSeriesDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NovelSeriesDetailImplCopyWith<_$NovelSeriesDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ImageUrls _$ImageUrlsFromJson(Map<String, dynamic> json) {
  return _ImageUrls.fromJson(json);
}

/// @nodoc
mixin _$ImageUrls {
  @JsonKey(name: "square_medium")
  String get squareMedium => throw _privateConstructorUsedError;
  @JsonKey(name: "medium")
  String get medium => throw _privateConstructorUsedError;
  @JsonKey(name: "large")
  String get large => throw _privateConstructorUsedError;

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
  $Res call(
      {@JsonKey(name: "square_medium") String squareMedium,
      @JsonKey(name: "medium") String medium,
      @JsonKey(name: "large") String large});
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
    Object? squareMedium = null,
    Object? medium = null,
    Object? large = null,
  }) {
    return _then(_value.copyWith(
      squareMedium: null == squareMedium
          ? _value.squareMedium
          : squareMedium // ignore: cast_nullable_to_non_nullable
              as String,
      medium: null == medium
          ? _value.medium
          : medium // ignore: cast_nullable_to_non_nullable
              as String,
      large: null == large
          ? _value.large
          : large // ignore: cast_nullable_to_non_nullable
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
  $Res call(
      {@JsonKey(name: "square_medium") String squareMedium,
      @JsonKey(name: "medium") String medium,
      @JsonKey(name: "large") String large});
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
    Object? squareMedium = null,
    Object? medium = null,
    Object? large = null,
  }) {
    return _then(_$ImageUrlsImpl(
      squareMedium: null == squareMedium
          ? _value.squareMedium
          : squareMedium // ignore: cast_nullable_to_non_nullable
              as String,
      medium: null == medium
          ? _value.medium
          : medium // ignore: cast_nullable_to_non_nullable
              as String,
      large: null == large
          ? _value.large
          : large // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImageUrlsImpl implements _ImageUrls {
  const _$ImageUrlsImpl(
      {@JsonKey(name: "square_medium") required this.squareMedium,
      @JsonKey(name: "medium") required this.medium,
      @JsonKey(name: "large") required this.large});

  factory _$ImageUrlsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageUrlsImplFromJson(json);

  @override
  @JsonKey(name: "square_medium")
  final String squareMedium;
  @override
  @JsonKey(name: "medium")
  final String medium;
  @override
  @JsonKey(name: "large")
  final String large;

  @override
  String toString() {
    return 'ImageUrls(squareMedium: $squareMedium, medium: $medium, large: $large)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageUrlsImpl &&
            (identical(other.squareMedium, squareMedium) ||
                other.squareMedium == squareMedium) &&
            (identical(other.medium, medium) || other.medium == medium) &&
            (identical(other.large, large) || other.large == large));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, squareMedium, medium, large);

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
      {@JsonKey(name: "square_medium") required final String squareMedium,
      @JsonKey(name: "medium") required final String medium,
      @JsonKey(name: "large") required final String large}) = _$ImageUrlsImpl;

  factory _ImageUrls.fromJson(Map<String, dynamic> json) =
      _$ImageUrlsImpl.fromJson;

  @override
  @JsonKey(name: "square_medium")
  String get squareMedium;
  @override
  @JsonKey(name: "medium")
  String get medium;
  @override
  @JsonKey(name: "large")
  String get large;

  /// Create a copy of ImageUrls
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImageUrlsImplCopyWith<_$ImageUrlsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
