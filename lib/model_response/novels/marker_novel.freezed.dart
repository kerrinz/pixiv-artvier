// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'marker_novel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MarkedNovelsResponse _$MarkedNovelsResponseFromJson(Map<String, dynamic> json) {
  return _MarkedNovelsResponse.fromJson(json);
}

/// @nodoc
mixin _$MarkedNovelsResponse {
  @JsonKey(name: "marked_novels")
  List<MarkedNovel> get markedNovels => throw _privateConstructorUsedError;
  @JsonKey(name: "next_url")
  dynamic get nextUrl => throw _privateConstructorUsedError;

  /// Serializes this MarkedNovelsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MarkedNovelsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MarkedNovelsResponseCopyWith<MarkedNovelsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarkedNovelsResponseCopyWith<$Res> {
  factory $MarkedNovelsResponseCopyWith(MarkedNovelsResponse value,
          $Res Function(MarkedNovelsResponse) then) =
      _$MarkedNovelsResponseCopyWithImpl<$Res, MarkedNovelsResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: "marked_novels") List<MarkedNovel> markedNovels,
      @JsonKey(name: "next_url") dynamic nextUrl});
}

/// @nodoc
class _$MarkedNovelsResponseCopyWithImpl<$Res,
        $Val extends MarkedNovelsResponse>
    implements $MarkedNovelsResponseCopyWith<$Res> {
  _$MarkedNovelsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MarkedNovelsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? markedNovels = null,
    Object? nextUrl = freezed,
  }) {
    return _then(_value.copyWith(
      markedNovels: null == markedNovels
          ? _value.markedNovels
          : markedNovels // ignore: cast_nullable_to_non_nullable
              as List<MarkedNovel>,
      nextUrl: freezed == nextUrl
          ? _value.nextUrl
          : nextUrl // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MarkedNovelsResponseImplCopyWith<$Res>
    implements $MarkedNovelsResponseCopyWith<$Res> {
  factory _$$MarkedNovelsResponseImplCopyWith(_$MarkedNovelsResponseImpl value,
          $Res Function(_$MarkedNovelsResponseImpl) then) =
      __$$MarkedNovelsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "marked_novels") List<MarkedNovel> markedNovels,
      @JsonKey(name: "next_url") dynamic nextUrl});
}

/// @nodoc
class __$$MarkedNovelsResponseImplCopyWithImpl<$Res>
    extends _$MarkedNovelsResponseCopyWithImpl<$Res, _$MarkedNovelsResponseImpl>
    implements _$$MarkedNovelsResponseImplCopyWith<$Res> {
  __$$MarkedNovelsResponseImplCopyWithImpl(_$MarkedNovelsResponseImpl _value,
      $Res Function(_$MarkedNovelsResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of MarkedNovelsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? markedNovels = null,
    Object? nextUrl = freezed,
  }) {
    return _then(_$MarkedNovelsResponseImpl(
      markedNovels: null == markedNovels
          ? _value._markedNovels
          : markedNovels // ignore: cast_nullable_to_non_nullable
              as List<MarkedNovel>,
      nextUrl: freezed == nextUrl
          ? _value.nextUrl
          : nextUrl // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MarkedNovelsResponseImpl implements _MarkedNovelsResponse {
  const _$MarkedNovelsResponseImpl(
      {@JsonKey(name: "marked_novels")
      required final List<MarkedNovel> markedNovels,
      @JsonKey(name: "next_url") required this.nextUrl})
      : _markedNovels = markedNovels;

  factory _$MarkedNovelsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MarkedNovelsResponseImplFromJson(json);

  final List<MarkedNovel> _markedNovels;
  @override
  @JsonKey(name: "marked_novels")
  List<MarkedNovel> get markedNovels {
    if (_markedNovels is EqualUnmodifiableListView) return _markedNovels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_markedNovels);
  }

  @override
  @JsonKey(name: "next_url")
  final dynamic nextUrl;

  @override
  String toString() {
    return 'MarkedNovelsResponse(markedNovels: $markedNovels, nextUrl: $nextUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarkedNovelsResponseImpl &&
            const DeepCollectionEquality()
                .equals(other._markedNovels, _markedNovels) &&
            const DeepCollectionEquality().equals(other.nextUrl, nextUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_markedNovels),
      const DeepCollectionEquality().hash(nextUrl));

  /// Create a copy of MarkedNovelsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarkedNovelsResponseImplCopyWith<_$MarkedNovelsResponseImpl>
      get copyWith =>
          __$$MarkedNovelsResponseImplCopyWithImpl<_$MarkedNovelsResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MarkedNovelsResponseImplToJson(
      this,
    );
  }
}

abstract class _MarkedNovelsResponse implements MarkedNovelsResponse {
  const factory _MarkedNovelsResponse(
          {@JsonKey(name: "marked_novels")
          required final List<MarkedNovel> markedNovels,
          @JsonKey(name: "next_url") required final dynamic nextUrl}) =
      _$MarkedNovelsResponseImpl;

  factory _MarkedNovelsResponse.fromJson(Map<String, dynamic> json) =
      _$MarkedNovelsResponseImpl.fromJson;

  @override
  @JsonKey(name: "marked_novels")
  List<MarkedNovel> get markedNovels;
  @override
  @JsonKey(name: "next_url")
  dynamic get nextUrl;

  /// Create a copy of MarkedNovelsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarkedNovelsResponseImplCopyWith<_$MarkedNovelsResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MarkedNovel _$MarkedNovelFromJson(Map<String, dynamic> json) {
  return _MarkedNovel.fromJson(json);
}

/// @nodoc
mixin _$MarkedNovel {
  @JsonKey(name: "novel")
  CommonNovel get novel => throw _privateConstructorUsedError;
  @JsonKey(name: "novel_marker")
  NovelMarker? get novelMarker => throw _privateConstructorUsedError;
  MarkerState? get markerState => throw _privateConstructorUsedError;

  /// Serializes this MarkedNovel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MarkedNovel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MarkedNovelCopyWith<MarkedNovel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarkedNovelCopyWith<$Res> {
  factory $MarkedNovelCopyWith(
          MarkedNovel value, $Res Function(MarkedNovel) then) =
      _$MarkedNovelCopyWithImpl<$Res, MarkedNovel>;
  @useResult
  $Res call(
      {@JsonKey(name: "novel") CommonNovel novel,
      @JsonKey(name: "novel_marker") NovelMarker? novelMarker,
      MarkerState? markerState});

  $NovelMarkerCopyWith<$Res>? get novelMarker;
}

/// @nodoc
class _$MarkedNovelCopyWithImpl<$Res, $Val extends MarkedNovel>
    implements $MarkedNovelCopyWith<$Res> {
  _$MarkedNovelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MarkedNovel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? novel = null,
    Object? novelMarker = freezed,
    Object? markerState = freezed,
  }) {
    return _then(_value.copyWith(
      novel: null == novel
          ? _value.novel
          : novel // ignore: cast_nullable_to_non_nullable
              as CommonNovel,
      novelMarker: freezed == novelMarker
          ? _value.novelMarker
          : novelMarker // ignore: cast_nullable_to_non_nullable
              as NovelMarker?,
      markerState: freezed == markerState
          ? _value.markerState
          : markerState // ignore: cast_nullable_to_non_nullable
              as MarkerState?,
    ) as $Val);
  }

  /// Create a copy of MarkedNovel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NovelMarkerCopyWith<$Res>? get novelMarker {
    if (_value.novelMarker == null) {
      return null;
    }

    return $NovelMarkerCopyWith<$Res>(_value.novelMarker!, (value) {
      return _then(_value.copyWith(novelMarker: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MarkedNovelImplCopyWith<$Res>
    implements $MarkedNovelCopyWith<$Res> {
  factory _$$MarkedNovelImplCopyWith(
          _$MarkedNovelImpl value, $Res Function(_$MarkedNovelImpl) then) =
      __$$MarkedNovelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "novel") CommonNovel novel,
      @JsonKey(name: "novel_marker") NovelMarker? novelMarker,
      MarkerState? markerState});

  @override
  $NovelMarkerCopyWith<$Res>? get novelMarker;
}

/// @nodoc
class __$$MarkedNovelImplCopyWithImpl<$Res>
    extends _$MarkedNovelCopyWithImpl<$Res, _$MarkedNovelImpl>
    implements _$$MarkedNovelImplCopyWith<$Res> {
  __$$MarkedNovelImplCopyWithImpl(
      _$MarkedNovelImpl _value, $Res Function(_$MarkedNovelImpl) _then)
      : super(_value, _then);

  /// Create a copy of MarkedNovel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? novel = null,
    Object? novelMarker = freezed,
    Object? markerState = freezed,
  }) {
    return _then(_$MarkedNovelImpl(
      novel: null == novel
          ? _value.novel
          : novel // ignore: cast_nullable_to_non_nullable
              as CommonNovel,
      novelMarker: freezed == novelMarker
          ? _value.novelMarker
          : novelMarker // ignore: cast_nullable_to_non_nullable
              as NovelMarker?,
      markerState: freezed == markerState
          ? _value.markerState
          : markerState // ignore: cast_nullable_to_non_nullable
              as MarkerState?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MarkedNovelImpl implements _MarkedNovel {
  const _$MarkedNovelImpl(
      {@JsonKey(name: "novel") required this.novel,
      @JsonKey(name: "novel_marker") this.novelMarker,
      this.markerState});

  factory _$MarkedNovelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MarkedNovelImplFromJson(json);

  @override
  @JsonKey(name: "novel")
  final CommonNovel novel;
  @override
  @JsonKey(name: "novel_marker")
  final NovelMarker? novelMarker;
  @override
  final MarkerState? markerState;

  @override
  String toString() {
    return 'MarkedNovel(novel: $novel, novelMarker: $novelMarker, markerState: $markerState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarkedNovelImpl &&
            (identical(other.novel, novel) || other.novel == novel) &&
            (identical(other.novelMarker, novelMarker) ||
                other.novelMarker == novelMarker) &&
            (identical(other.markerState, markerState) ||
                other.markerState == markerState));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, novel, novelMarker, markerState);

  /// Create a copy of MarkedNovel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarkedNovelImplCopyWith<_$MarkedNovelImpl> get copyWith =>
      __$$MarkedNovelImplCopyWithImpl<_$MarkedNovelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MarkedNovelImplToJson(
      this,
    );
  }
}

abstract class _MarkedNovel implements MarkedNovel {
  const factory _MarkedNovel(
      {@JsonKey(name: "novel") required final CommonNovel novel,
      @JsonKey(name: "novel_marker") final NovelMarker? novelMarker,
      final MarkerState? markerState}) = _$MarkedNovelImpl;

  factory _MarkedNovel.fromJson(Map<String, dynamic> json) =
      _$MarkedNovelImpl.fromJson;

  @override
  @JsonKey(name: "novel")
  CommonNovel get novel;
  @override
  @JsonKey(name: "novel_marker")
  NovelMarker? get novelMarker;
  @override
  MarkerState? get markerState;

  /// Create a copy of MarkedNovel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarkedNovelImplCopyWith<_$MarkedNovelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NovelMarker _$NovelMarkerFromJson(Map<String, dynamic> json) {
  return _NovelMarker.fromJson(json);
}

/// @nodoc
mixin _$NovelMarker {
  @JsonKey(name: "page")
  int get page => throw _privateConstructorUsedError;

  /// Serializes this NovelMarker to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NovelMarker
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NovelMarkerCopyWith<NovelMarker> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NovelMarkerCopyWith<$Res> {
  factory $NovelMarkerCopyWith(
          NovelMarker value, $Res Function(NovelMarker) then) =
      _$NovelMarkerCopyWithImpl<$Res, NovelMarker>;
  @useResult
  $Res call({@JsonKey(name: "page") int page});
}

/// @nodoc
class _$NovelMarkerCopyWithImpl<$Res, $Val extends NovelMarker>
    implements $NovelMarkerCopyWith<$Res> {
  _$NovelMarkerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NovelMarker
  /// with the given fields replaced by the non-null parameter values.
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
abstract class _$$NovelMarkerImplCopyWith<$Res>
    implements $NovelMarkerCopyWith<$Res> {
  factory _$$NovelMarkerImplCopyWith(
          _$NovelMarkerImpl value, $Res Function(_$NovelMarkerImpl) then) =
      __$$NovelMarkerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: "page") int page});
}

/// @nodoc
class __$$NovelMarkerImplCopyWithImpl<$Res>
    extends _$NovelMarkerCopyWithImpl<$Res, _$NovelMarkerImpl>
    implements _$$NovelMarkerImplCopyWith<$Res> {
  __$$NovelMarkerImplCopyWithImpl(
      _$NovelMarkerImpl _value, $Res Function(_$NovelMarkerImpl) _then)
      : super(_value, _then);

  /// Create a copy of NovelMarker
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
  }) {
    return _then(_$NovelMarkerImpl(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NovelMarkerImpl implements _NovelMarker {
  const _$NovelMarkerImpl({@JsonKey(name: "page") required this.page});

  factory _$NovelMarkerImpl.fromJson(Map<String, dynamic> json) =>
      _$$NovelMarkerImplFromJson(json);

  @override
  @JsonKey(name: "page")
  final int page;

  @override
  String toString() {
    return 'NovelMarker(page: $page)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NovelMarkerImpl &&
            (identical(other.page, page) || other.page == page));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, page);

  /// Create a copy of NovelMarker
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NovelMarkerImplCopyWith<_$NovelMarkerImpl> get copyWith =>
      __$$NovelMarkerImplCopyWithImpl<_$NovelMarkerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NovelMarkerImplToJson(
      this,
    );
  }
}

abstract class _NovelMarker implements NovelMarker {
  const factory _NovelMarker({@JsonKey(name: "page") required final int page}) =
      _$NovelMarkerImpl;

  factory _NovelMarker.fromJson(Map<String, dynamic> json) =
      _$NovelMarkerImpl.fromJson;

  @override
  @JsonKey(name: "page")
  int get page;

  /// Create a copy of NovelMarker
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NovelMarkerImplCopyWith<_$NovelMarkerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
