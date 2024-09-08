// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UgoiraImageState {
  String get illustId => throw _privateConstructorUsedError;
  List<GifImageMeta>? get images => throw _privateConstructorUsedError;
  /** 0 - 1 */
  double get progress => throw _privateConstructorUsedError;
  UgoiraImageLoadingState get loadingState =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UgoiraImageStateCopyWith<UgoiraImageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UgoiraImageStateCopyWith<$Res> {
  factory $UgoiraImageStateCopyWith(
          UgoiraImageState value, $Res Function(UgoiraImageState) then) =
      _$UgoiraImageStateCopyWithImpl<$Res, UgoiraImageState>;
  @useResult
  $Res call(
      {String illustId,
      List<GifImageMeta>? images,
      double progress,
      UgoiraImageLoadingState loadingState});
}

/// @nodoc
class _$UgoiraImageStateCopyWithImpl<$Res, $Val extends UgoiraImageState>
    implements $UgoiraImageStateCopyWith<$Res> {
  _$UgoiraImageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? illustId = null,
    Object? images = freezed,
    Object? progress = null,
    Object? loadingState = null,
  }) {
    return _then(_value.copyWith(
      illustId: null == illustId
          ? _value.illustId
          : illustId // ignore: cast_nullable_to_non_nullable
              as String,
      images: freezed == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<GifImageMeta>?,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
      loadingState: null == loadingState
          ? _value.loadingState
          : loadingState // ignore: cast_nullable_to_non_nullable
              as UgoiraImageLoadingState,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UgoiraImageStateImplCopyWith<$Res>
    implements $UgoiraImageStateCopyWith<$Res> {
  factory _$$UgoiraImageStateImplCopyWith(_$UgoiraImageStateImpl value,
          $Res Function(_$UgoiraImageStateImpl) then) =
      __$$UgoiraImageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String illustId,
      List<GifImageMeta>? images,
      double progress,
      UgoiraImageLoadingState loadingState});
}

/// @nodoc
class __$$UgoiraImageStateImplCopyWithImpl<$Res>
    extends _$UgoiraImageStateCopyWithImpl<$Res, _$UgoiraImageStateImpl>
    implements _$$UgoiraImageStateImplCopyWith<$Res> {
  __$$UgoiraImageStateImplCopyWithImpl(_$UgoiraImageStateImpl _value,
      $Res Function(_$UgoiraImageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? illustId = null,
    Object? images = freezed,
    Object? progress = null,
    Object? loadingState = null,
  }) {
    return _then(_$UgoiraImageStateImpl(
      illustId: null == illustId
          ? _value.illustId
          : illustId // ignore: cast_nullable_to_non_nullable
              as String,
      images: freezed == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<GifImageMeta>?,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
      loadingState: null == loadingState
          ? _value.loadingState
          : loadingState // ignore: cast_nullable_to_non_nullable
              as UgoiraImageLoadingState,
    ));
  }
}

/// @nodoc

class _$UgoiraImageStateImpl implements _UgoiraImageState {
  const _$UgoiraImageStateImpl(
      {required this.illustId,
      required final List<GifImageMeta>? images,
      required this.progress,
      required this.loadingState})
      : _images = images;

  @override
  final String illustId;
  final List<GifImageMeta>? _images;
  @override
  List<GifImageMeta>? get images {
    final value = _images;
    if (value == null) return null;
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

/** 0 - 1 */
  @override
  final double progress;
  @override
  final UgoiraImageLoadingState loadingState;

  @override
  String toString() {
    return 'UgoiraImageState(illustId: $illustId, images: $images, progress: $progress, loadingState: $loadingState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UgoiraImageStateImpl &&
            (identical(other.illustId, illustId) ||
                other.illustId == illustId) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.loadingState, loadingState) ||
                other.loadingState == loadingState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, illustId,
      const DeepCollectionEquality().hash(_images), progress, loadingState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UgoiraImageStateImplCopyWith<_$UgoiraImageStateImpl> get copyWith =>
      __$$UgoiraImageStateImplCopyWithImpl<_$UgoiraImageStateImpl>(
          this, _$identity);
}

abstract class _UgoiraImageState implements UgoiraImageState {
  const factory _UgoiraImageState(
          {required final String illustId,
          required final List<GifImageMeta>? images,
          required final double progress,
          required final UgoiraImageLoadingState loadingState}) =
      _$UgoiraImageStateImpl;

  @override
  String get illustId;
  @override
  List<GifImageMeta>? get images;
  @override
  /** 0 - 1 */
  double get progress;
  @override
  UgoiraImageLoadingState get loadingState;
  @override
  @JsonKey(ignore: true)
  _$$UgoiraImageStateImplCopyWith<_$UgoiraImageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
